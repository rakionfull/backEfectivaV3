<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\DescripcionVulnerabilidad;
use App\Models\Muser;
use CodeIgniter\API\ResponseTrait;
use CodeIgniter\HTTP\ResponseInterface;
use Exception;

class DescripcionVulnerabilidadController extends BaseController
{
    use ResponseTrait;

    public function index(){
        try {
            $model = new DescripcionVulnerabilidad();
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
            'idcategoria' => 'required',
            'vulnerabilidad' => 'required',
        ];
        $errors = [
            'idcategoria' => [
                'required' => 'Debe ingresar el id de la categoria de vulnerabilidad',
            ],
            'vulnerabilidad' => [
                'required' => 'Debe ingresar la vulnerabilidad'
            ]
        ];
        

        $input = $this->getRequestInput($this->request);
        if (!$this->validateRequest($input, $rules, $errors)) {
            $error = [
                'error' => 'validar',
                'datos' => $this->validator->getErrors()
            ];
            return ($this->getResponse($error,ResponseInterface::HTTP_OK));
        }

        $model = new DescripcionVulnerabilidad();
        $found = $model->where('idcategoria_vulnerabilidad',$input['idcategoria'])
        ->where('vulnerabilidad',$input['vulnerabilidad'])
        ->where('is_deleted','0')->findAll();
        if(count($found) > 0){
            return $this->getResponse(
                [
                    'error' => true,
                    'msg' =>  'Descripcion de vulnerabilidad ya registrado'
                ]
            );
        }
        $result = $model->store($input);

        $modelUser = new Muser();
        $user = $modelUser->getUserbyId($input['id_user_added']);
        $accion = 'El usuario '.$user->usuario_us. ' creó la descripción de vulnerabilidad: '.$input['vulnerabilidad'];
        log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);
    

        return $this->getResponse(
            [
                'msg' =>  $result
            ]
        );
    }

    public function update($id){
        try {
            $input = $this->getRequestInput($this->request);
    
            $model = new DescripcionVulnerabilidad();
            $input['id'] = $id;
            $found = $model->validateModify($input);
            if(count($found) > 0){
                return $this->getResponse(
                    [
                        'error' => true,
                        'msg' =>  'Descripcion de vulnerabilidad ya registrado'
                    ]
                );
            }
            $model->edit($id,$input);
            $modelUser = new Muser();
            $user = $modelUser->getUserbyId($input['id_user_updated']);
            $accion = 'El usuario '.$user->usuario_us. ' modificó la descripción de vulnerabilidad: '.$input['vulnerabilidad'];
            log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);
        
            return $this->getResponse(
                [
                    'error' => false,
                    'msg' =>  'Descripcion de vulnerabilidad actualizada correctamente'
                ]
            );
        } catch (\Throwable $th) {
            return $this->getResponse(
                [
                    'error' => true,
                    'ex' => $th->getMessage(),
                    'msg' =>  'No se pudo editar, intente de nuevo. Si el problema persiste, contacte con el administrador del sistema.'

                ]
            );
        }
    }

    public function destroy($id){
        $input = $this->getRequestInput($this->request);
        $model = new DescripcionVulnerabilidad();
        $found = $model->find($id);

        $this->db->transBegin();

        try {
            if($found){
                // Si se puede eliminar por llave foranea
                if($model->delete($id)){
                    $this->db->transRollback();
                    $input['is_deleted'] = 1;
                    $model->update($id,$input);

                    $modelUser = new Muser();
                    $user = $modelUser->getUserbyId($input['id_user_deleted']);
                    $accion = 'El usuario '.$user->usuario_us. ' eliminó la descripción de vulnerabilidad: '.$found['vulnerabilidad'];
                    log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);
    
                    return $this->getResponse(
                        [
                            'error' => false,
                            'msg' =>  'Descripcion de Vulnerabilidad eliminado'
                        ]
                    );
                }else{
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
                    // 'msg' =>  'Ocurrio un error '.$th->getMessage()
                    'msg' =>'No se puede eliminar el registro porque esta siendo usado en algún proceso.'
                ]
            );
        
        }
    }
}