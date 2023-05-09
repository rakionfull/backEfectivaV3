<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\CategoriasVulnerabilidad;
use App\Models\Muser;
use CodeIgniter\API\ResponseTrait;
use CodeIgniter\HTTP\ResponseInterface;
use Exception;

class CategoriasVulnerabilidadController extends BaseController
{
    use ResponseTrait;

    public function index(){
        try {
            $model = new CategoriasVulnerabilidad();
            $response = [
                'data' =>  $model->getAll(),
            ];
            return $this->respond($response, ResponseInterface::HTTP_OK);
        } catch (Exception $ex) {
            return $this->getResponse(
                    [
                        'error' => $ex->getMessage(),
                    ],
                    ResponseInterface::HTTP_OK
                );
        }
    }
    public function store(){
        $rules = [
            'categoria' => 'required|is_unique[categoria_vulnerabilidad.categoria]',
            'estado' => 'required',
        ];
        $errors = [
            'categoria' => [
                'required' => 'Debe ingresar la categoria de la vulnerabilidad',
                'is_unique' => 'Esta categoria de vulnerabilidad ya existe en nuestros registros',
            ],
            'estado' => [
                'required' => 'Debe ingresar el estado'
            ]
        ];

        $input = $this->getRequestInput($this->request);
        if (!$this->validateRequest($input, $rules, $errors)) {
            $error = [
                'error' => true,
                'msg' => $this->validator->getErrors()
            ];
            return ($this->getResponse($error,ResponseInterface::HTTP_OK));
        }

        $model = new CategoriasVulnerabilidad();
        $result = $model->store($input);

        $modelUser = new Muser();
        $user = $modelUser->getUserbyId($input['id_user_added']);
        $accion = 'El usuario '.$user->usuario_us. ' creó la categoría de vulnerabilidad: '.$input['categoria'];
        log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);
    

        return $this->getResponse(
            [
                'error' => false,
                'msg' =>  $result
            ]
        );
    }

    public function update($id){
        try {
            $rules = [
                // 'categoria' => 'required|is_unique[categoria_vulnerabilidad.categoria]',
                'categoria' => 'required',
                'estado' => 'required',
            ];
            $errors = [
                'categoria' => [
                    'required' => 'Debe ingresar la categoria de la vulnerabilidad',
                    // 'is_unique' => 'Esta categoria de vulnerabilidad ya existe en nuestros registros',
                ],
                'estado' => [
                    'required' => 'Debe ingresar el estado'
                ]
            ];
    
            $input = $this->getRequestInput($this->request);
            if (!$this->validateRequest($input, $rules, $errors)) {
                $error = [
                    'error' => true,
                    'msg' => $this->validator->getErrors()
                ];
                return ($this->getResponse($error,ResponseInterface::HTTP_OK));
            }
    
            $model = new CategoriasVulnerabilidad();
            $input['id'] = $id;
            $found = $model->validateModify($input);
            if(count($found) > 0){
                return $this->getResponse(
                    [
                        'error' => true,
                        'msg' =>  'Categoria de Vulnerabilidad ya registrado'
                    ]
                );
            }
            $model->edit($id,$input);
            $modelUser = new Muser();
            $user = $modelUser->getUserbyId($input['id_user_updated']);
            $accion = 'El usuario '.$user->usuario_us. ' modificó la categoría de vulnerabilidad: '.$input['categoria'];
            log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);
        
            return $this->getResponse(
                [
                    'error' => false,
                    'msg' =>  'Categoría de la vulnerabilidad editada correctamente'
                ]
            );
        } catch (\Throwable $th) {
            return $this->getResponse(
                [
                    'error' => true,
                    'msg' =>  'No se pudo editar, intente de nuevo. Si el problema persiste, contacte con el administrador del sistema.'

                ]
            );
        }
        
    }

    public function destroy($id){
        $input = $this->getRequestInput($this->request);
        $model = new CategoriasVulnerabilidad();
        $found = $model->find($id);
        $this->db->transBegin();
        try {
            if($found){
                $result = $model->deleteCategoriaVulnerabilidad('categoria_vulnerabilidad',$id);
                if($result){
                    // $this->db->transRollback();
                    $input['is_deleted'] = 1;
                    $model->update($id,$input);
                    $modelUser = new Muser();
                    $user = $modelUser->getUserbyId($input['id_user_deleted']);
                    $accion = 'El usuario '.$user->usuario_us. ' eliminó la categoría de vulnerabilidad: '.$found['categoria'];
                    log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);
    
                    // return $this->getResponse(
                    //     [
                    //         'error' => false,
                    //         'msg' =>  'Categoria de vulnerabilidad eliminado'
                    //     ]
                    // );
                }else{
                    $input['is_deleted'] = 0;
                    $input['date_deleted'] = null;
                    $input['id_user_deleted'] = null;
                    $model->update($id,$input);
                    
                    return $this->getResponse(
                        [   'error2' =>  $ex->getMessage(),
                            'error' => true,
                            'msg' =>  'No se puede eliminar el registro porque esta siendo usado en algún proceso.'
                        ]
                    );
                }
            }else{
                return $this->getResponse(
                    [
                        'error' => true,
                        'msg' =>  'No existen registros'
                    ]
                );
            }
            $this->db->transCommit();

        } catch (\Throwable $th) {
            $input['is_deleted'] = 0;
            $input['date_deleted'] = null;
            $input['id_user_deleted'] = null;
            $model->update($id,$input);
            return $this->getResponse(
                [
                    'error' => true,
                    'msg' =>  'No se puede eliminar el registro porque esta siendo usado en algún proceso.'
                ]
            );
        
        }
    }
}