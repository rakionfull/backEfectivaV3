<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\MAplicacionProbabilidad;
use CodeIgniter\API\ResponseTrait;
use CodeIgniter\HTTP\ResponseInterface;
use Exception;

class AplicacionProbabilidadController extends BaseController
{
    use ResponseTrait;
    public function getAplicacionProbabilidad(){
        $input = $this->getRequestInput($this->request);
        try {
            $model = new MAplicacionProbabilidad();
                $response = [
                    'data' =>  $model->getAplicacionProbabilidad($input['escenario'])
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
    
    public function addAplicacionProbabilidad()
    {
   
        try {
            $input = $this->getRequestInput($this->request);

      
            $model = new MAplicacionProbabilidad();
        
            $valida = $model -> validaAplicacionProbabilidad($input[0]);
            if(!$valida){
                $valida2 = $model -> validaAplicacionProbabilidad2($input[0]);
                if(!$valida2){
                    $result = $model->saveAplicacionProbabilidad($input);
                    $msg = 'Registrado correctamente';
                    $error = 1;
                }else{
                    $msg = 'La posición ya está registrada';
                    $error = 0;
                }
              
            }else{
                $msg = 'Aplicación de la probabilidad ya registrada';
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
    public function updateAplicacionProbabilidad()
    {
   
        try {
            $input = $this->getRequestInput($this->request);
            $model = new MAplicacionProbabilidad();
            $found = $model->validateApliProbaModify($input);

            if(count($found) > 0){
                return $this->getResponse(
                    [
                        'error' =>true,
                        'msg' =>'Aplicación de Probabilidad ya registrada'
                    ],
                    ResponseInterface::HTTP_OK
                );
            }else{
                $found2 = $model->validateApliProbaModify2($input);
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
           
            $result = $model->updateAplicacionProbabilidad($input);
        
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
    public function deleteAplicacionProbabilidad()
    {
        $input = $this->getRequestInput($this->request);
        $model = new MAplicacionProbabilidad();
        $found = $model->find($input[0]['id']);
        $this->db->transBegin();
        try{
            if($found){
                if($model->delete($input[0]['id'])){
                    $this->db->transRollback();
                    $data['is_deleted'] = 1;
                    $model->update($input[0]['id'],$data);
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
            $model = new MAplicacionProbabilidad();
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