<?php

namespace App\Controllers;

use App\Models\Muser;
use App\Models\TipoRiesgo;
use CodeIgniter\API\ResponseTrait;
use CodeIgniter\HTTP\ResponseInterface;
use Exception;

class TipoRiesgosController extends BaseController
{
    use ResponseTrait;

    public function index(){
        try {
            $model = new TipoRiesgo();
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
    public function getTipoRiesgosByActivo(){
        try {
            $model = new TipoRiesgo();
            $response = [
                'data' =>  $model->getTipoRiesgosByActivo(),
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
        $this->db->transBegin();

        try {
            $rules = [
                'tipo_riesgo' => 'required',
                'descripcion' => 'required',
                'estado' => 'required'
            ];
            $errors = [
                'tipo_riesgo' => [
                    'required' => 'Debe ingresar el tipo de riesgo',
                    'is_unique' => 'El campo tipo de riesgo debe ser único'
                ],
                'descripcion' => [
                    'required' => 'Debe ingresar la descripcion'
                ],
                'estado' => [
                    'required' => 'Debe ingresar el estado'
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
    
            
            $model = new TipoRiesgo();
            $found = $model->where('tipo_riesgo',$input['tipo_riesgo'])->where('is_deleted','0')->findAll();
            if(count($found) > 0){
                return $this->getResponse(
                    [
                        'error' => true,
                        'msg' =>  'Ya existe este tipo de riesgo'
                    ]
                );
            }
            $model->store($input);

            $modelUser = new Muser();
            $user = $modelUser->getUserbyId($input['id_user_added']);
            $accion = 'El usuario '.$user->usuario_us. ' creó el tipo de riesgo: '.$input['tipo_riesgo'];
            log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);
            $this->db->transCommit();
           
            return $this->getResponse(
                [
                    'error' => false,
                    'msg' =>  'Tipo de riesgo creado correctamente'
                ]
            );
        } catch (\Throwable $th) {
            $this->db->rollback();
            return $this->getResponse(
                [
                    'error' => true,
                    'msg' =>  'No se pudo guardar, intente de nuevo. Si el problema persiste, contacte con el administrador del sistema.'
                ]
            );
        }
        
    }

    public function update(){
        $this->db->transBegin();

        try {
            $input = $this->getRequestInput($this->request);
            $model = new TipoRiesgo();
            $found = $model->validateModify($input);
            if(count($found) > 0){
                return $this->getResponse(
                    [
                        'error' => true,
                        'msg' =>  'Tipo de riesgo ya registrado'
                    ]
                );
            }
            $model->edit($input);
            
            $modelUser = new Muser();
            $user = $modelUser->getUserbyId($input['id_user_updated']);
            $accion = 'El usuario '.$user->usuario_us. ' modificó el tipo de riesgo: '.$input['tipo_riesgo'];
            log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);
            $this->db->transCommit();
            return $this->getResponse(
                [
                    'error' => false,
                    'msg' =>  'Tipo de riesgo actualizado correctament'
                ]
            );
        } catch (\Throwable $th) {
            $this->db->rollback();

            return $this->getResponse(
                [
                    'error' => true,
                    'msg' =>  'No se pudo guardar, intente de nuevo. Si el problema persiste, contacte con el administrador del sistema.'
                ]
            );
        }
        
    }

    public function destroy($id){
        $input = $this->getRequestInput($this->request);
        $this->db->transBegin();
        $model = new TipoRiesgo();
        $found = $model->find($id);
        try {
            if($found){
                // Si se puede eliminar por llave foranea
                if($model->delete($id)){
                    $this->db->transRollback();
                    $input['is_deleted'] = 1;
                    $model->update($id,$input);

                    $modelUser = new Muser();
                    $user = $modelUser->getUserbyId($input['id_user_deleted']);
                    $accion = 'El usuario '.$user->usuario_us. ' eliminó el tipo de riesgo: '.$found['tipo_riesgo'];
                    log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);

                    return $this->getResponse(
                        [
                            'error' => false,
                            'msg' =>  'Tipo riesgo eliminado'
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
                        'msg' =>  'No existe el tipo de riesgo'
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