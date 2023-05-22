<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\MAplicacionImpacto;
use App\Models\Muser;
use CodeIgniter\API\ResponseTrait;
use CodeIgniter\HTTP\ResponseInterface;
use Exception;

class AplicacionImpactoController extends BaseController
{
    use ResponseTrait;
    public function getAplicacionImpacto(){
        $input = $this->getRequestInput($this->request);
        try {
            $model = new MAplicacionImpacto();
                $response = [
                    'data' =>  $model->getAplicacionImpacto($input['escenario'])
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
    
    public function addAplicacionImpacto()
    {
   
        try {
            $input = $this->getRequestInput($this->request);

      
            $model = new MAplicacionImpacto();
        
            $valida = $model -> validaAplicacionImpacto($input[0]);
            if(!$valida){
                $valida2 = $model -> validaAplicacionImpacto2($input[0]);
                if(!$valida2){
                    $result = $model->saveAplicacionImpacto($input);
                    $modelUser = new Muser();
                    $user = $modelUser->getUserbyId($input['user']);
                    
                    $accion = 'El usuario '.$user->usuario_us. ' agregó la aplicación de impacto: '.$input[0]['descripcion'];

                    log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);

                    $msg = 'Registrado correctamente';
                    $error = 1;
                }else{
                    $msg = 'La posición ya está registrada';
                    $error = 0;
                }
              
            }else{
                $msg = 'Aplicación de impacto ya registrada';
                $error = 0;
            }
            return $this->getResponse(
                [
                    'msg' =>  $msg,
                    'error' =>  $error
                ]
            );
        } catch (Exception $ex) {
            return $this->getResponse(
                [
                    'error' => $ex->getMessage(),
                ],
                ResponseInterface::HTTP_OK
            );
        }
    
    }
    public function updateAplicacionImpacto()
    {
   
        try {
            $input = $this->getRequestInput($this->request);
            $model = new MAplicacionImpacto();
            $found = $model->validateApliImpacModify($input);

            if(count($found) > 0){
                return $this->getResponse(
                    [
                        'error' =>true,
                        'msg' =>'Aplicación de Impacto ya registrada'
                    ],
                    ResponseInterface::HTTP_OK
                );
            }else{
                $found2 = $model->validateApliImpacModify2($input);
                if(count($found2) > 0){
                    return $this->getResponse(
                        [
                            'error' =>true,
                             'msg'=> 'La posición ya está registrada'
                        ],
                        ResponseInterface::HTTP_OK
                    );
                }
            }
            $modelUser = new Muser();
            $user = $modelUser->getUserbyId($input['user']);
            
            $accion = 'El usuario '.$user->usuario_us. ' modificó la aplicación de impacto: '.$input[0]['descripcion'];

            log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);


            $result = $model->updateAplicacionImpacto($input);
        
            return $this->getResponse(
                [
                    'msg' =>  'Modificado correctamente'
                ]
            );
            
        } catch (Exception $ex) {
            return $this->getResponse(
                [
                    'error' => $ex->getMessage(),
                ],
                ResponseInterface::HTTP_OK
            );
        }
       
      
        
    }
    public function deleteAplicacionImpacto()
    {
        $input = $this->getRequestInput($this->request);
        $model = new MAplicacionImpacto();
        $found = $model->find($input[0]['id']);
        $this->db->transBegin();
        try{
            if($found){
                if($model->delete($input[0]['id'])){
                    $this->db->transRollback();
                    $data['is_deleted'] = 1;
                    $model->update($input[0]['id'],$data);
                    $modelUser = new Muser();
                    $user = $modelUser->getUserbyId($input['user']);
                    
                    $accion = 'El usuario '.$user->usuario_us. ' elimnió la aplicación de impacto: '.$found['descripcion'];
        
                    log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);
                    return $this->getResponse(
                        [
                            'error' => false,
                            'msg' =>  'Eliminado correctamente'
                        ]
                    );
                }else{
                    $data['is_deleted'] = 0;
                    $data['date_deleted'] = null;
                    $data['id_user_deleted'] = null;
                    $model->update($input[0]['id'],$data);
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

        } catch (Exception $ex) {
            $data['is_deleted'] = 0;
            $data['date_deleted'] = null;
            $data['id_user_deleted'] = null;
            $model->update($input['id'],$data);
            return $this->getResponse(
                [  
                    'error' => true,
                    'msg' => 'No se puede eliminar el registro porque esta siendo usado en algún proceso.',
                ]
            );
        }
        
    }
    public function getByCaracteristica(){
        try{
            $input = $this->getRequestInput($this->request);
            $model = new MAplicacionImpacto();
            $response = [
                'data' =>  $model->getByCaracteristica($input)
            ];
            return $this->respond($response, ResponseInterface::HTTP_OK);
        } catch (Exception $ex) {
            return $this->getResponse(
                [
                    'error' => $ex->getMessage(),
                ]
            );
        }
      
    }
}