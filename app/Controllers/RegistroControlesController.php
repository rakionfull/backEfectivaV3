<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\MRegistroControles;
use App\Models\Muser;
use App\Models\EvaluacionRiesgosControles;
use CodeIgniter\API\ResponseTrait;
use CodeIgniter\HTTP\ResponseInterface;
use Exception;

class RegistroControlesController extends BaseController
{
    use ResponseTrait;
    public function LastIdControles(){
        
        try {
            $model = new MRegistroControles();
                $response = [
                    'data' =>  $model->LastIdControles()
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
    public function getCCMenu(){
        
        try {
            $model = new MRegistroControles();
                $response = [
                    'data' =>  $model->getCCMenu()
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
    public function getCCSubMenu(){
        
        try {
            $model = new MRegistroControles();
                $response = [
                    'data' =>  $model->getCCSubMenu()
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
    public function getCCOpciones(){
        
        try {
            $model = new MRegistroControles();
                $response = [
                    'data' =>  $model->getCCOpciones()
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
    public function getCoberturaByActivo(){
        
        try {
            $model = new MRegistroControles();
                $response = [
                    'data' =>  $model->getCoberturaByActivo()
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
    public function getData($id){
        
        try {
            $model = new MRegistroControles();
            $tabla = $model->getTabla($id);
                $response = [
                    'data' =>  $model->getData2($tabla),
                    'dato' =>  $tabla,
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
    public function getRegistroControles(){
        
        try {
            $model = new MRegistroControles();
         
                $response = [
                    'data' =>  $model->getRegistroControles(),
                   
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
    public function getRegistroControl($id){
        
        try {
            $model = new MRegistroControles();
         
                $response = [
                    'data' =>  $model->getRegistroControl($id),
                   
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
    public function getControlRiesgo(){
        
        try {
            $model = new MRegistroControles();
         
                $response = [
                    'data' =>  $model->getControlesRiesgos(),
                   
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
    public function getPlanControl(){
        
        try {
            $model = new MRegistroControles();
         
                $response = [
                    'data' =>  $model->getPlanControl(),
                   
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
    public function getRegistroDetalleControl($id){
        
        try {
            $model = new MRegistroControles();
         
                $response = [
                    'data' =>  $model->getRegistroDetalleControl($id),
                   
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
    
    public function calificarControl($id){
        
        try {
            $input = $this->getRequestInput($this->request);
            $resultado = calificar($input,$id);
                $response = [
                   $resultado
                    // 'data' =>  'el total es'.$resultado,
                    // 'data' =>   $input
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
    public function ejecutarEvaluacion(){
        
        try {
            $input = $this->getRequestInput($this->request);
            $resultado = evaluar($input);
                $response = [
                   $resultado
                   
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
    // public function getAplicacionProbabilidad(){
    //     $input = $this->getRequestInput($this->request);
    //     try {
    //         $model = new MRegistroControles();
    //             $response = [
    //                 'data' =>  $model->getAplicacionProbabilidad($input['escenario'])
    //             ];
    //             return $this->respond($response, ResponseInterface::HTTP_OK);
        
    //     } catch (Exception $ex) {
    //         return $this->getResponse(
    //                 [
    //                     'error' => $ex->getMessage(),
    //                 ],
    //                 ResponseInterface::HTTP_OK
    //             );
    //     }

           
    // }
    
    // public function addControles()
    // {
   
    //     try {
    //         $input = $this->getRequestInput($this->request);

      
    //         $model = new MRegistroControles();
        
    //         $valida = $model -> validaRegistroControl($input[0]);

            
    //         if(!$valida){
    //             $result = $model->saveControles($input);
    //             if($result){
    //                 foreach ($input[0]['valores'] as $key => $value) {
    //                     $data = [
    //                         'idControl' => $result,
    //                         'idCC' => $value['idCC'],
    //                         'valor' => $value['valor'],
    //                         'nom_tabla' => $value['nom_tabla'],
    //                     ];
    //                     $model->saveDetalle_Control($data);
    //                 }
    //                 $msg = 'Registrado correctamente';
    //                 $error = 1;
    //             }
              
    //         }else{
    //             $msg = 'Control ya registrado';
    //             $error = 0;
    //         }
           
    //         return $this->getResponse(
    //             [
                    
    //                 'msg' =>  $msg,
    //                 'error' =>  $error
    //             ]
    //         );
    //     } catch (Exception $ex) {
    //         return $this->getResponse(
    //             [
    //                 'error' => $ex->getMessage(),
    //             ],
    //             ResponseInterface::HTTP_OK
    //         );
    //     }
    
    // }
    
    // public function updateControles()
    // {
   
    //     try {
    //         $input = $this->getRequestInput($this->request);

      
    //         $model = new MRegistroControles();
    //         $found = $model->validateRegitroControlModify($input);
    //         if(count($found) > 0){
    //                     $msg = 'Control ya registrado';
    //                     $error = 0;     
    //          }else{
    //             $result = $model->updateControles($input);
         
    //             if($result){
    //                 foreach ($input[0]['valores'] as $key => $value) {
    //                     $data = [
    //                         'idControl' => $input[0]['id'],
    //                         'idCC' => $value['idCC'],
    //                         'valor' => $value['valor'],
                           
    //                     ];
    //                     $model->updateDtealle_Control($data);
    //                 }
    //                 $msg = 'Modificado correctamente';
    //                 $error = 1;
    //             }
    //          }

           
    //         return $this->getResponse(
    //             [
    //                 'msg' =>  $msg,
    //                 'error' =>  $error
    //             ]
    //         );
    //     } catch (Exception $ex) {
    //         return $this->getResponse(
    //             [
    //                 'error' => $ex->getMessage(),
    //             ],
    //             ResponseInterface::HTTP_OK
    //         );
    //     }
    
    // }
    public function deleteControles()
    {
   
      
        $input = $this->getRequestInput($this->request);
        
        $model = new MRegistroControles();
        $modelERC = new EvaluacionRiesgosControles();
        //$this->db->transBegin();
        $found = $model->find($input['id']);
        
        try {
            if($found){
                $result = $modelERC->deleteRiesgoControl('registro_controles',$input['id']);
                //$model->delete($input['id'])
                if($result){
                    //$this->db->transRollback();
                    $data['is_deleted'] = 1;
                    $data['date_deleted'] = date("Y-m-d H:i:s");
                    $data['id_user_deleted'] = $input['user'];

                    $model->update($input['id'],$data);
                    //actualizar aqui el detalle decontrol + riesgo

                    //$model->deleteRiesgoControles($input['id']);

                    $modelERC->where('id_control',$input['id'])->update(null,[
                        'is_deleted' => '1'
                    ]);
                    $modelERC->where('id_control',$input['id'])->delete();

                      //aqui va el log del sistema
                      $modelUser = new Muser();
                      $user = $modelUser->getUserbyId($input['user']);
                      
                      $accion = 'El usuario '.$user->usuario_us. ' eliminó el control: '.$found['nom_control'];

                      log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);


                    // return $this->getResponse(
                    //     [
                    //         'error' => false,
                    //         'msg' =>  'Control eliminado correctamente'
                    //     ]
                    // );
                }else{
                    $input['is_deleted'] = 0;
                    $input['date_deleted'] = null;
                    $input['id_user_deleted'] = null;
                    $model->update($input['id'],$input);
                    return $this->getResponse(
                        [
                            
                            'error' => true,
                            'msg' =>  'No se puede eliminar el registro porque esta siendo usado en algún proceso.'
                            //'msg' => $result
                        ]
                    );
                }
            }else{
                return $this->getResponse(
                    [
                        'error' => true,
                        'msg' =>  'No existe'
                    ]
                );
            }
            //$this->db->transCommit();
           
        } catch (\Throwable $th) {
            $input['is_deleted'] = 0;
            $input['date_deleted'] = null;
            $input['id_user_deleted'] = null;
            $model->update($input['id'],$input);
            return $this->getResponse(
                [
                    'error' => $th->getMessage(),
                    'error2' => true,
                    'msg' =>  'No se puede eliminar el registro porque esta siendo usado en algún proceso.'
                ]
            );
        }
    
    }
    //registro de controles
    // public function getRegistroControles2(){
        
    //     try {
    //         $model = new MRegistroControles();
         
    //         $result =  $model->getRegistroControles2();
    //         // $result3 =  $model->getRegistroControles3();
    //         $array_datos = [];
            
    //         foreach ($result as $key => $value) {
    //             $array_aux=[];
    //            if($value['caracteristica'] == 'Responsable'){
    //                 if($value['nom_tabla'] != ""){
    //                     $tabla = $model -> getTabla($value['nom_tabla'] );
    //                     $campo_tabla =  $model->getData2($tabla);
    //                     if($value['RCValor'] != ""){
    //                         foreach ($campo_tabla as $key => $value2) {
    //                             if($value2['id']  == $value['RCValor'] ){
    //                                 $array_aux=[
                                        
    //                                             'IDC' => $value['IDRC'] ,
    //                                             'nom_control' => $value['nom_control'] ,
    //                                             'responsable' => $value2[$tabla] ,
    //                                             'estado' => $value['RCEstado'] ,
    //                                             'prioridad' => '',
    //                                 ];
    //                                 array_push($array_datos,$array_aux);
    //                             }
                                
    //                         }
    //                     }else{
    //                         $array_aux=[
                                
    //                             'IDC' => $value['IDRC'] ,
    //                             'nom_control' => $value['nom_control'] ,
    //                             'responsable' => '' ,
    //                             'estado' => $value['RCEstado'] ,
    //                             'prioridad' => '',
    //                         ];
    //                         array_push($array_datos,$array_aux);
    //                     }
                   
    //                 }
                    
                   
    //             }else{
    //                 // $array_aux=[
                                
    //                 //     'IDC' => $value['IDRC'] ,
    //                 //     'nom_control' => $value['nom_control'] ,
    //                 //     'responsable' => '' ,
    //                 //     'estado' => $value['RCEstado'] ,
    //                 //     'prioridad' => '',
    //                 // ];
    //                 // array_push($array_datos,$array_aux);
    //             }
    //             // if($value['caracteristica'] == 'Prioridad'){
    //             //    array_push($array_aux,($value['RCValor']));
    //             // }
               
          
    //         }

    //             $response = [
    //                 'data' =>  $array_datos,
                   
    //             ];
    //             return $this->respond($response, ResponseInterface::HTTP_OK);
        
    //     } catch (Exception $ex) {
    //         return $this->getResponse(
    //                 [
    //                     'error' => $ex->getMessage(),
    //                 ],
    //                 ResponseInterface::HTTP_OK
    //             );
    //     }

           
    // }
    public function getRegistroControles2(){
        
        try {
            $model = new MRegistroControles();
         
            $result =  $model->getRegistroControles2();
            // $result3 =  $model->getRegistroControles3();
            $array_datos = [];
            
            foreach ($result as $key => $value) {
                $array_aux=[];
               if($value['caracteristica'] == 'Responsable'){
                    if($value['nom_tabla'] != ""){
                        $tabla = $model -> getTabla($value['nom_tabla'] );
                        $campo_tabla =  $model->getData2($tabla);
                        if($value['RCValor'] != ""){
                            foreach ($campo_tabla as $key => $value2) {
                                if($value2['id']  == $value['RCValor'] ){
                                    $array_aux=[
                                        
                                                'IDC' => $value['IDRC'] ,
                                                'nom_control' => $value['nom_control'] ,
                                                'responsable' => $value2[$tabla] ,
                                                'estado' => $value['RCEstado'] ,
                                                'prioridad' => '',
                                    ];
                                    array_push($array_datos,$array_aux);
                                }
                                
                            }
                        }else{
                            $array_aux=[
                                
                                'IDC' => $value['IDRC'] ,
                                'nom_control' => $value['nom_control'] ,
                                'responsable' => '' ,
                                'estado' => $value['RCEstado'] ,
                                'prioridad' => '',
                            ];
                            array_push($array_datos,$array_aux);
                        }
                   
                    }else{
                        // $array_aux=[
                                    
                        //     'IDC' => $value['IDRC'] ,
                        //     'nom_control' => $value['nom_control'] ,
                        //     'responsable' => '',
                        //     'estado' => $value['RCEstado'] ,
                        //     'prioridad' => '',
                        // ];
                        // array_push($array_datos,$array_aux);
                        // $array_aux['prioidad'] = $value['RCValor'];
                        // $array_aux['prioridad'] = $value['RCValor'];
                    //   $array_aux['prioridad'] = $value['RCValor'];
                    //   array_push($array_aux,($value['RCValor']));
                        
                    }
                    
                   
                }else{
                    // $array_aux=[
                                
                    //     'IDC' => $value['IDRC'] ,
                    //     'nom_control' => $value['nom_control'] ,
                    //     'responsable' => '' ,
                    //     'estado' => $value['RCEstado'] ,
                    //     'prioridad' => '',
                    // ];
                    // array_push($array_datos,$array_aux);
                }
                // if($value['caracteristica'] == 'Prioridad'){
                //    array_push($array_aux,($value['RCValor']));
                // }
               
          
            }

                $response = [
                    'data' =>  $array_datos,
                   
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
}