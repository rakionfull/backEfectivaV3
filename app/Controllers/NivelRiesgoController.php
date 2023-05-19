<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\Muser;
use App\Models\NivelRiesgo;
use CodeIgniter\API\ResponseTrait;
use CodeIgniter\HTTP\ResponseInterface;

class NivelRiesgoController extends BaseController
{
    use ResponseTrait;

    public function index()
    {
        try {
            $model = new NivelRiesgo();
            $response = [
                'data' => $model->getAll()
            ];
            return $this->respond($response, ResponseInterface::HTTP_OK);
        } catch (\Throwable $th) {
            return $this->getResponse(
                [
                    'error' => $th->getMessage(),
                ],
                ResponseInterface::HTTP_OK
            );
        }
    }

    public function store(){
        $rules = [
            "operador1" => 'required',
            "valor1" => 'required',
            "operador2" => 'required',
            "valor2" => 'required',
            'descripcion' => 'required',
            'color' => 'required',
            'estado' => 'required',
            'comentario' => 'required'
        ];
        $errors = [
            "operador1" => [
                'required' => 'Debe ingrear el operador 1'
            ],
            "operador2" => [
                'required' => 'Debe ingrear el operador 2'
            ],
            "valor1" => [
                'required' => 'Debe ingrear el valor 1'
            ],
            "valor2" => [
                'required' => 'Debe ingrear el valor 2'
            ],
            "color" => [
                'required' => 'Debe ingrear el color'
            ],
            'descripcion' => [
                'required' => 'Debe ingresar la descripcion'
            ],
            'estado' => [
                'required' => 'Debe ingresar el estado'
            ],
            'comentario' => [
                'required' => 'Debe ingresar el comentario'
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
        $model = new NivelRiesgo();
        $found = $model->where('descripcion',$input['descripcion'])->where('is_deleted','0')->findAll();
        if(count($found) > 0){
            return $this->getResponse(
                [
                    'error' => true,
                    'msg' =>  'Nivel de riesgo ya registrado'
                ]
            );
        }
        $existeCombinatoria = $model->where('operador1',$input['operador1'])->where('operador2',$input['operador2'])
        ->where('valor1',$input['valor1'])->where('valor2',$input['valor2'])
        ->where('estado',1)->where('is_deleted',0)->findAll();
        if(count($existeCombinatoria) > 0){
            return $this->getResponse(
                [
                    'error' => true,
                    'msg' =>  'Esta combinatoria ya existe'
                ]
            );
        }
        $result = $model->store($input);
        $modelUser = new Muser();
        $user = $modelUser->getUserbyId($input['id_user_added']);
        $accion = 'El usuario '.$user->usuario_us. ' creó el nivel de riesgo: '.$input['descripcion'];
        log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);
    
        return $this->getResponse(
            [
                'msg' =>  $result
            ]
        );
    }
    public function update($id){
        try {
            $rules = [
                "operador1" => 'required',
                "valor1" => 'required',
                "operador2" => 'required',
                "valor2" => 'required',
                'descripcion' => 'required',
                'color' => 'required',
                'estado' => 'required',
                'comentario' => 'required'
            ];
            $errors = [
                "operador1" => [
                    'required' => 'Debe ingrear el operador 1'
                ],
                "operador2" => [
                    'required' => 'Debe ingrear el operador 2'
                ],
                "valor1" => [
                    'required' => 'Debe ingrear el valor 1'
                ],
                "valor2" => [
                    'required' => 'Debe ingrear el valor 2'
                ],
                "color" => [
                    'required' => 'Debe ingrear el color'
                ],
                'descripcion' => [
                    'required' => 'Debe ingresar la descripcion'
                ],
                'estado' => [
                    'required' => 'Debe ingresar el estado'
                ],
                'comentario' => [
                    'required' => 'Debe ingresar el comentario'
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
            $model = new NivelRiesgo();
            $input['id'] = $id;
            $found = $model->validateModify($input);
            if(count($found) > 0){
                return $this->getResponse(
                    [
                        'error' => true,
                        'msg' =>  'Nivel de riesgo ya registrado'
                    ]
                );
            }
            $model->edit($id,$input);
            $modelUser = new Muser();
            $user = $modelUser->getUserbyId($input['id_user_updated']);
            $accion = 'El usuario '.$user->usuario_us. ' modificó el nivel de riesgo: '.$input['descripcion'];
            log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);
        
            return $this->getResponse(
                [
                    'error' => false,
                    'msg' =>  'Nivel de riesgo actualizado correctamente'
                ]
            );
        } catch (\Throwable $th) {
            return $this->getResponse(
                [
                    'error' => true,
                    'e' => $th->getMessage(),
                    'msg' =>  'No se pudo editar, intente de nuevo. Si el problema persiste, contacte con el administrador del sistema.'
                ]
            );
        }
        
    }

    public function destroy($id){
        $input = $this->getRequestInput($this->request);
        $model = new NivelRiesgo();

        $found = $model->find($id);
        
        //$this->db->transBegin();
        try {
            if($found){
                $result = $model->deleteNivelRiesgo('nivel_riesgo',$id);
                if($result){
                    // $this->db->transRollback();
                    $input['is_deleted'] = 1;
                    $model->update($id,$input);

                    //$result = $model->store($input);
                    $modelUser = new Muser();
                    $user = $modelUser->getUserbyId($input['id_user_deleted']);
                    $accion = 'El usuario '.$user->usuario_us. ' eliminó el nivel de riesgo: '.$found['descripcion'];
                    log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);
    

                    // return $this->getResponse(
                    //     [
                    //         'error' => false,
                    //         'msg' =>  'Nivel de riesgo eliminado'
                    //     ]
                    // );
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
                        'msg' =>  'No existe el nivel de riesgo'
                    ]
                );
            }
            //$this->db->transCommit();
            // return $this->getResponse(
            //     [
            //         'error' => false,
            //         'msg' =>  'Nivel de riesgo eliminado'
            //     ]
            // );
        } catch (\Throwable $th) {
            $input['is_deleted'] = 0;
            $input['date_deleted'] = null;
            $input['id_user_deleted'] = null;
            $model->update($id,$input);
            return $this->getResponse(
                [
                    'error' => true,
                    // 'error2' => $th->getMessage(),
                    'msg' =>  'No se puede eliminar el registro porque esta siendo usado en algún proceso.'
                ]
            );
        }
           
    }
}