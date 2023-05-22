<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\MCobertura;
use App\Models\Muser;
use CodeIgniter\API\ResponseTrait;
use CodeIgniter\HTTP\ResponseInterface;
use Exception;

class CoberturaController extends BaseController
{
    use ResponseTrait;
    public function getCobertura(){

        try {
            $model = new MCobertura();
                $response = [
                    'data' =>  $model->getCobertura()
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
    public function addCobertura()
    {
   
        try {
            $input = $this->getRequestInput($this->request);

      
            $model = new MCobertura();
        
            $valida = $model -> validaCobertura($input[0]['cobertura']);
            if(!$valida){
                $result = $model->saveCobertura($input);
                $modelUser = new Muser();
                $user = $modelUser->getUserbyId($input['user']);
                
                $accion = 'El usuario '.$user->usuario_us. ' agregó la cobertura: '.$input[0]['cobertura'];

                log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);
                $msg = 'Registrado correctamente';
                $error = 1;
            }else{
                $msg = 'Cobertura ya registrada';
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
    public function updateCobertura()
    {
   
        try {
            $input = $this->getRequestInput($this->request);
            $model = new MCobertura();
            $found = $model->validateCoberturaModify($input);

            if(count($found) > 0){
                return $this->getResponse(
                    [
                        'error' =>true,
                        'msg' =>'Cobertura ya registrada'
                    ],
                    ResponseInterface::HTTP_OK
                );
            }
            $result = $model->updateCobertura($input);
            $modelUser = new Muser();
            $user = $modelUser->getUserbyId($input['user']);
            
            $accion = 'El usuario '.$user->usuario_us. ' modificó la cobertura: '.$input[0]['cobertura'];

            log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);
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
    public function deleteCobertura()
    {
        $input = $this->getRequestInput($this->request);
        $model = new MCobertura();
        $found = $model->find($input[0]['id']);
        $this->db->transBegin();
        try{
            if($found){
                if($model->delete($input[0]['id'])){
                    $this->db->transRollback();
                    $data['date_deleted'] = date("Y-m-d H:i:s");
                    $data['id_user_deleted'] = $input['user'];
                    $data['is_deleted'] = 1;
                    $model->update($input[0]['id'],$data);
                    $modelUser = new Muser();
                    $user = $modelUser->getUserbyId($input['user']);
                    
                    $accion = 'El usuario '.$user->usuario_us. ' eliminó la cobertura: '.$found['cobertura'];
        
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
            $model->update($input[0]['id'],$data);
            return $this->getResponse(
                [  
                    'error' => true,
                    'msg' => 'No se puede eliminar el registro porque esta siendo usado en algún proceso.',
                ]
            );
        }
      
      
        
    }
}