<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\EvaluacionRiesgo;
use App\Models\MriesgoPlanAccion;
use App\Models\EvaluacionRiesgosControles;
use App\Models\ImpactoRiesgo;
use App\Models\MAplicacionImpacto;
use App\Models\MAplicacionProbabilidad;
use App\Models\MEvaluacionControl;
use App\Models\MRegistroControles;
use App\Models\Muser;
use App\Models\MValoracionRiesgo;
use App\Models\NivelRiesgo;
use App\Models\ProbabilidadRiesgo;
use CodeIgniter\API\ResponseTrait;
use CodeIgniter\HTTP\ResponseInterface;
use Exception;

class EvaluacionRiesgoController extends BaseController
{
    use ResponseTrait;

    public function index($id){
        $input = $this->getRequestInput($this->request);

        try {
            $model = new EvaluacionRiesgo();
            $response = [
                'data' =>  $model->getAll($id),
            ];
            if($input['accion'] == "exportar"){
                $modelUser = new Muser();
                $user = $modelUser->getUserbyId($input['user']);
                $accion = 'El usuario '.$user->usuario_us. ' exportó la informacion de evaluación de riesgos';
                log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);
            }
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
    public function getListHistorial($id){
        $input = $this->getRequestInput($this->request);
        try {
            $model = new EvaluacionRiesgo();
            $response = [
                'data' =>  $model->getAllHistoricos($id),
            ];
            if($input['accion'] == "exportar"){
                $modelUser = new Muser();
                $user = $modelUser->getUserbyId($input['user']);
                $accion = 'El usuario '.$user->usuario_us. ' exportó la informacion historica de evaluación de riesgos';
                log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);
            }
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
    public function countvalores(){
        try {
            $model = new EvaluacionRiesgo();
            $response = [
                'data' =>  $model->countvalores(),
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

    public function show($id){
        try {
            $model = new EvaluacionRiesgo();
            $response = [
                'data' =>  $model->getById($id),
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
        try {
            $rules = [
                'id_empresa' => 'required',
                'id_area' => 'required',
                'id_unidad' => 'required',
                'id_macroproceso' => 'required',
                'id_proceso' => 'required',
                'id_activo' => 'required',
                'id_tipo_amenaza' => 'required',
                'id_descripcion_amenaza' => 'required',
                'id_tipo_vulnerabilidad' => 'required',
                'id_descripcion_vulnerabilidad' => 'required',
                'riesgo' => 'required',
                'valor_probabilidad' => 'required',
                'valor_impacto' => 'required',
                'valor' => 'required',
                'estado' => 'required'
            ];
            $errors = [
                'id_empresa' => ['required' => 'El campo empresa es requerido'],
                'id_area' =>  ['required' => 'El campo area es requerido'],
                'id_unidad' =>  ['required' => 'El campo unidad es requerido'],
                'id_macroproceso' =>  ['required' => 'El campo macroproceso es requerido'],
                'id_proceso' =>  ['required' => 'El campo proceso es requerido'],
                'id_activo' =>  ['required' => 'El campo activo es requerido'],
                'id_tipo_amenaza' =>  ['required' => 'El campo tipo de amenaza es requerido'],
                'id_descripcion_amenaza' =>  ['required' => 'El campo descripcion de amenaza es requerido'],
                'id_tipo_vulnerabilidad' =>  ['required' => 'El campo tipo de vulnerabilidad es requerido'],
                'id_descripcion_vulnerabilidad' =>  ['required' => 'El campo descripcion de vulnerabilidad es requerido'],
                'riesgo' =>  ['required' => 'El campo riesgo es requerido'],
                'valor_probabilidad' =>  ['required' => 'El campo valo de la probabilidad es requerido'],
                'valor_impacto' =>  ['required' => 'El campo valor impacto es requerido'],
                'valor' =>  ['required' => 'El campo valor es requerido'],
                'estado' =>  ['required' => 'El campo estado es requerido']
            ];
            $input = $this->getRequestInput($this->request);
            if (!$this->validateRequest($input, $rules, $errors)) {
                $error = [
                    'error' => true,
                    'datos' => $this->validator->getErrors()
                ];
                return ($this->getResponse($error,ResponseInterface::HTTP_OK));
            }

            $model = new EvaluacionRiesgo();
            $found = $model->where('riesgo',$input['riesgo'])->where('idempresa',$input['id_empresa'])->where('is_deleted',0)->findAll();
            if(count($found) > 0){
                return $this->getResponse(
                    [
                        'error' => true,
                        'msg' =>  'Evaluación de riesgo ya registrado'
                    ]
                );
            }
            $modelERC = new EvaluacionRiesgosControles();
            $result = $model->store($input);
            if($result){
                $id = $model->get_last_id()[0];
                if(isset($input['controles'])){
                    foreach ($input['controles'] as $control) {
                        # code...
                        $data = [
                            'id_evaluacion_riesgo' => $id,
                            'id_control' => $control,
                            'id_user_added' => $input['id_user_added'],
                            'date_add' => $input['date_add'],
                            'id_evaluacion_riesgo' => $id,
                            'id_control' => $control,
                        ];
                        $modelERC->store($data);
                    }
                }

                $modelUser = new Muser();
                $user = $modelUser->getUserbyId($input['id_user_added']);
                $accion = 'El usuario '.$user->usuario_us. ' creó la evaluacion de riesgo: '.$input['riesgo'];
                log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);
    
                return $this->getResponse(
                    [
                        'error' => false,
                        'msg' =>  $result
                    ]
                );
               
            }else{
                return $this->getResponse(
                    [
                        'error' => true,
                        'msg' =>  'Ocurrio un error'
                    ]
                );
            }
        } catch (\Throwable $th) {
            return $this->getResponse(
                [
                    'error' => true,
                    'msg' =>  $th->getMessage()
                ]
            );
        }
    }

    public function update($id){
        try {
            //code...
            $input = $this->getRequestInput($this->request);
    
            $model = new EvaluacionRiesgo();
            $found = $model->validateModify($id,$input);
            if(count($found) > 0){
                return $this->getResponse(
                    [
                        'error' => true,
                        'msg' =>  'Evaluación de riesgo ya registrado'
                    ]
                );
            }
            $result = $model->edit($id,$input);
            if($result){
                if(!isset($input['accion'])){
                    $modelERC = new EvaluacionRiesgosControles();
                    $model->delete_evaluacion_riesgo_controles($id);
                    // $modelERC->where('id_evaluacion_riesgo',$id)->update(null,[
                    //     'is_deleted' => '1'
                    // ]);
                    // $modelERC->where('id_evaluacion_riesgo',$id)->delete();
                    if(isset($input['controles'])){
                        if(count($input['controles']) > 0){
                            foreach ($input['controles'] as $control) {
                                $data = [
                                    'id_evaluacion_riesgo' => $id,
                                    'id_control' => $control,
                                    'id_user_added' => $input['id_user_updated'],
                                    'date_add' => $input['date_modify'],
                                    'id_evaluacion_riesgo' => $id,
                                    'id_control' => $control,
                                ];
                                $modelERC->store($data);
                            }
                        }
                    }
                }

                $modelUser = new Muser();
                $user = $modelUser->getUserbyId($input['id_user_updated']);
                $accion = 'El usuario '.$user->usuario_us. ' modificó la evaluacion de riesgo: '.$input['riesgo'];
                log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);
    
                return $this->getResponse(
                    [
                        'error' => false,
                        'msg' =>  $result
                    ]
                );
            }else{
                return $this->getResponse(
                    [
                        'error' => true,
                        'msg' =>  'Ocurrio un error'
                    ]
                );
            }
        } catch (\Throwable $th) {
            return $this->getResponse(
                [
                    'error' => true,
                    'msg' =>  $th->getMessage()." line ".$th->getLine()." file ".$th->getFile()
                ]
            );
        }
    }

    public function destroy($id){
        $input = $this->getRequestInput($this->request);
        $model = new EvaluacionRiesgo();
        $modelERC = new EvaluacionRiesgosControles();
        $found = $model->find($id);
        //$this->db->transBegin();
        try {
            if($found){
                $result = $modelERC->deleteRiesgoControl('evaluacion_riesgo',$id);
                //$model->delete($id)
                if($result){
                    //$this->db->transRollback();
                    $input['is_deleted'] = 1;
                    $model->update($id,$input);
                   
                    $modelERC->where('id_evaluacion_riesgo',$id)->update(null,[
                        'is_deleted' => '1'
                    ]);
                    $modelERC->where('id_evaluacion_riesgo',$id)->delete();

                    $modelUser = new Muser();
                    $user = $modelUser->getUserbyId($input['id_user_deleted']);
                    $accion = 'El usuario '.$user->usuario_us. ' eliminó la evaluación de riesgo: '.$found['riesgo'];
                    log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);
    

                    // return $this->getResponse(
                    //     [
                    //         'error' => false,
                    //         'msg' =>  'Evaluacion de riesgo eliminado'
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
                        'msg' =>  'No existen datos'
                    ]
                ); 
            }
            //$this->db->transCommit();
           
        } catch (\Throwable $th) {
            $input['estado'] = 1;
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

    public function store_historial(){
        try {
            $rules = [
                'id_empresa' => 'required',
                'id_area' => 'required',
                'id_unidad' => 'required',
                'id_macroproceso' => 'required',
                'id_proceso' => 'required',
                'id_activo' => 'required',
                'id_tipo_amenaza' => 'required',
                'id_descripcion_amenaza' => 'required',
                'id_tipo_vulnerabilidad' => 'required',
                'id_descripcion_vulnerabilidad' => 'required',
                'riesgo' => 'required',
                'valor_probabilidad' => 'required',
                // 'probabilidad' => 'required',
                'valor_impacto' => 'required',
                // 'impacto' => 'required',
                'valor' => 'required',
                'id_control' => 'required',
                // 'riesgo_controlado_probabilidad' => 'required',
                // 'riesgo_controlado_impacto' => 'required',
                'riesgo_controlado_valor' => 'required',
                'estado' => 'required'
            ];
            $errors = [
                'id_empresa' => ['required' => 'El campo empresa es requerido'],
                'id_area' =>  ['required' => 'El campo area es requerido'],
                'id_unidad' =>  ['required' => 'El campo unidad es requerido'],
                'id_macroproceso' =>  ['required' => 'El campo macroproceso es requerido'],
                'id_proceso' =>  ['required' => 'El campo proceso es requerido'],
                'id_activo' =>  ['required' => 'El campo activo es requerido'],
                'id_tipo_amenaza' =>  ['required' => 'El campo tipo de amenaza es requerido'],
                'id_descripcion_amenaza' =>  ['required' => 'El campo descripcion de amenaza es requerido'],
                'id_tipo_vulnerabilidad' =>  ['required' => 'El campo tipo de vulnerabilidad es requerido'],
                'id_descripcion_vulnerabilidad' =>  ['required' => 'El campo descripcion de vulnerabilidad es requerido'],
                'riesgo' =>  ['required' => 'El campo riesgo es requerido'],
                'valor_probabilidad' =>  ['required' => 'El campo valo de la probabilidad es requerido'],
                // 'probabilidad' =>  ['required' => 'El campo probabilidad es requerido'],
                'valor_impacto' =>  ['required' => 'El campo valor impacto es requerido'],
                // 'impacto' =>  ['required' => 'El campo impacto es requerido'],
                'valor' =>  ['required' => 'El campo valor es requerido'],
                'id_control' =>  ['required' => 'El campo control es requerido'],
                // 'riesgo_controlado_probabilidad' =>  ['required' => 'El campo riesgo controlado probabilidad es requerido'],
                // 'riesgo_controlado_impacto' =>  ['required' => 'El campo riesgo controlado impacto es requerido'],
                'riesgo_controlado_valor' =>  ['required' => 'El campo riesgo controlado valor es requerido'],
                'estado' =>  ['required' => 'El campo estado es requerido']
            ];

            $input = $this->getRequestInput($this->request);
            if (!$this->validateRequest($input, $rules, $errors)) {
                $error = [
                    'error' => true,
                    'datos' => $this->validator->getErrors()
                ];
                return ($this->getResponse($error,ResponseInterface::HTTP_OK));
            }

            $model = new EvaluacionRiesgo();
            $result = $model->save_historial($input);
            $modelUser = new Muser();
            $user = $modelUser->getUserbyId($input['id_user_added']);
            $accion = 'El usuario '.$user->usuario_us. ' creó historial de evaluacion de riesgo: '.$input['riesgo'];
            log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);
    
            if($result){
                return $this->getResponse(
                    [
                        'error' => false,
                        'msg' =>  $result
                    ]
                );
               
            }else{
                return $this->getResponse(
                    [
                        'error' => true,
                        'msg' =>  'Ocurrio un error'
                    ]
                );
            }
        } catch (\Throwable $th) {
            return $this->getResponse(
                [
                    'error' => true,
                    'msg' =>  $th->getMessage()
                ]
            );
        }
    }

    public function getEvaluacionRiesgoControlesByEvaluacion($id){
        try {
            $model = new EvaluacionRiesgosControles();
            $response = [
                'data' =>  $model->getByEvaluacionRiesgoId($id)
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
    //agregar control
    public function addControles()
    {
   
        try {
            $input = $this->getRequestInput($this->request);

      
            $model = new MRegistroControles();
            $modelERC = new EvaluacionRiesgosControles();
            $valida = $model -> validaRegistroControl($input[0]);

            
            if(!$valida){
                //aqui Ok. guardamos el control
                $result = $model->saveControles($input);
                if($result){
                   //guardamos todoas los detalles
                   
                    foreach ($input[0]['valores'] as $key => $value) {
                        $data = [
                            'idControl' => $result,
                            'idCC' => $value['idCC'],
                            'valor' => $value['valor'],
                            'nom_tabla' => $value['nom_tabla'],
                           
                        ];
                        $model->saveDetalle_Control($data);
                    
                    }

                    //aqui ejecutaria el tema de la aplicacion del control
                    
                    $riesgos = explode("-", $input[0]['IDR']);
                    //recorremos y agregamos , Recordar que no se puede aplicar el control y el riesgo hasta que se ejecute
                    //todas las actividades
                    if($riesgos[0] != ""){
                        foreach ($riesgos as $key => $value) {
                       
                            $data = [
                                'id_evaluacion_riesgo' => $value,
                                'id_control' => $result,
                                'id_user_added' => $input['user'],
                                // 'id_evaluacion_riesgo' => $value,
                                // 'id_control' => $result,
                            
                            ];

                            $modelERC->store($data);
                        
                        
                        $this->updateRiesgosControlados($value);
                    }
                    }
                    
                     //log del sistema
                     $modelUser = new Muser();
                     $user = $modelUser->getUserbyId($input['user']);
             
             
                     $accion = 'El usuario '.$user->usuario_us. ' creó el control: '.$input[0]['control'];
             
                     log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);

                    $msg = 'Registrado correctamente';
                    $error = 1;
                    $idcontrol=$result;
                }
              
            }else{
                $msg = 'Control ya registrado';
                $error = 0;
                $idcontrol=0;
            }
           
            return $this->getResponse(
                [
                    
                    'msg' =>  $msg,
                    'error' =>  $error,
                    'idcontrol' => $idcontrol,
                    // 'riesgo' => $riesgo
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
    //modificar controles
    public function updateControles()
    {
   
        try {
            $input = $this->getRequestInput($this->request);

      
            $model = new MRegistroControles();
            $modelER = new EvaluacionRiesgo();
            $modelERC = new EvaluacionRiesgosControles();
            $found = $model->validateRegitroControlModify($input);
            if(count($found) > 0){
                        $msg = 'Control ya registrado';
                        $error = 0;     
             }else{

                $result = $model->updateControles($input);
                //cambiamos el estado de todoel detalle que ya no se usara y creamos nuevos
                $model->deleteDetalleControles($input);
                if($result){
                   //guardamos todoas los detalles
                    foreach ($input[0]['valores'] as $key => $value) {
                        $data = [
                            'idControl' => $input[0]['id'],
                            'idCC' => $value['idCC'],
                            'valor' => $value['valor'],
                            'nom_tabla' => $value['nom_tabla'],
                           
                        ];
                        $model->saveDetalle_Control($data);
                    
                    }

                    //aqui ejecutaria el tema de la aplicacion del control
                    
                    $riesgos = explode("-", $input[0]['IDR']);
                    //recorremos y agregamos , Recordar que no se puede aplicar el control y el riesgo hasta que se ejecute
                    //todas las actividades
                    //tengo que actualizar los riesgos para que ejecuten los nuevos
                  //cambiamos estado a os controles con su riesgo de sp_delete_evaluacion_riesgo_controles2

                  foreach ($riesgos as $key => $value2) {
                            $modelER->delete_evaluacion_riesgo_controles2($value2,$input[0]['id'],$input['user']);
                    }

                    //los volvemos a registrar

                    foreach ($riesgos as $key => $value) {
                       
                            $data = [
                                'id_evaluacion_riesgo' => $value,
                                'id_control' => $input[0]['id'],
                                'id_user_added' => $input['user'],
                                'id_evaluacion_riesgo' => $value,
                                'id_control' => $input[0]['id'],
                            
                            ];
                            $modelERC->store($data);
                        
                        
                        $this->updateRiesgosControlados($value);
                    }

                     //log del sistema
                        $modelUser = new Muser();
                        $user = $modelUser->getUserbyId($input['user']);
                
                
                        $accion = 'El usuario '.$user->usuario_us. ' modificó el control: '.$input[0]['control'];
                
                        log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);

                    $msg = 'Modificado correctamente';
                    $error = 1;
                    //$idcontrol=$result;
                }
             }

           
            return $this->getResponse(
                [
                    'msg' =>  $msg,
                    'error' =>  $error,
                   
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


     //agregar los planes de accion
     public function addPlanAccion(){

        try {
            $input = $this->getRequestInput($this->request);
    
            $model = new MriesgoPlanAccion();
            $riesgo = new EvaluacionRiesgosControles();
            //$valida =  $model->validaPlanAccion($input[0]);
            $valida = false;
            if(!$valida){
                //registramos el plan de accion
                $result = $model->savePlanAccion($input);
                //falta registrar el correo de alerta de primer registro

                //registramos riesgo con cada control para detectarlo
                //sacamos todos los riesgos y controles asociados con split
                $riesgos = explode("-", $input[0]['id_riesgo']);
                $controles = explode("-", $input[0]['id_control']);
                //recorremos y agregamos , Recordar que no se puede aplicar el control y el riesgo hasta que se ejecute
                //todas las actividades
                foreach ($riesgos as $key => $value) {
                    foreach ($controles as $key => $value2) {
                        $data = [
                            'id_evaluacion_riesgo' => $value,
                            'id_control' => $value2,
                            'id_user_added' => $input['user'],
                            'id_evaluacion_riesgo' => $value,
                            'id_control' => $value2,
                           
                        ];
                        $riesgo->store($data);
                      
                    }
                    //$this->updateRiesgosControlados($value);
                }
                 //log del sistema
                 $modelUser = new Muser();
                 $user = $modelUser->getUserbyId($input['user']);
         
         
                 $accion = 'El usuario '.$user->usuario_us. ' creó el plan de acción: '.$input[0]['plan_accion'];
         
                 log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);

                $msg = 'Plan Registrado Correctamente';
                $error = 1;
            }else{
                $result = 0;
                $msg = 'Plan ya registrado';
                $error = 0;
                //$error2 = $controlado;
            }
           //probando


           
           //$resultado = $this->updateRiesgosControlados(58);
            //$resultado = $this->controlFuerte($input[0]['id_control']);
            return $this->getResponse(
                [
                    'idplan' => $result,   
                    'msg' =>  $msg,
                     'error' =>  $error,
                   // 'error2' =>  $resultado,
                ]
            );
        } catch (Exception $ex) {
            return $this->getResponse(
                // [
                //     'error' => $ex->getMessage()." line ".$ex->getLine()." ".$ex->getFile()
                // ],
                [
                    'error' => $ex->getMessage(),
                    //'error' =>'No se pudo agregar, intente de nuevo. Si el problema persiste, contacte con el administrador del sistema',
                ],
                ResponseInterface::HTTP_OK
            );
        }
    }

    //actualizar las actividades para evaluar
    public function updateActividadPlan(){
    
        try {
            
            $input = $this->getRequestInput($this->request);
        
            $model = new MriesgoPlanAccion();
            $model2 = new MRegistroControles();

            
            $result = $model->updateActividadPlan($input);
        
            //despues de actualizar debo llamar a todas las actividades
            //recorrerlo y verificar que todas esten en 100, para ejecutar el riesgo vs control
    
            $actividades = $model->getActividadesByPlan($input[0]['idplanaccion']);
            $completos=0;
            foreach ($actividades as $key => $value) {
                if($value['progreso'] == 100){
                    $completos =1;
                }else{
                    $completos =0;
                }
            }
            if($completos == 1){
                $plan_final = $model->getPlanByRiesgos($input[0]['idplanaccion']);

                $riesgos = explode("-", $plan_final[0]['id_riesgo']);
                $control = explode("-", $plan_final[0]['id_control']);
                //recorremos y agregamos , Recordar que no se puede aplicar el control y el riesgo hasta que se ejecute
                //todas las actividades
                $array_riesgos="";

                $array_controles=[];
                if($riesgos[0] != ""){
                    foreach ($riesgos as $key => $value) {
                        $array = $value."-";
                        // array_push($array_riesgos,$array);
                        $array_riesgos = $array_riesgos.$array;
                                         
                    
                        $this->updateRiesgosControlados($value);
                    }
                      // //actualizar el control con los riesgos respectivos
                    foreach ($control as $key => $value2) {
                        $model2 -> updateControlRiesgo($array_riesgos,$value2);
                    }

                  
                   
                }

                  //log del sistema
                    $modelUser = new Muser();
                    $user = $modelUser->getUserbyId($input['user']);
            
            
                    $accion = 'El usuario '.$user->usuario_us. ' la actividad se ejecutó correctamente el riesgo: '.$input[0]['descripcion'];
            
                    log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);
                    
                //$resultado  = $this->updateRiesgosControlados(75);
                return $this->getResponse([
                    'msg' => 'El plan de accion esta culminado, se ha aplicado el control',
                    //'data' => $resultado,
                    'error' => 1,
                    // 'riesgos' => $array_riesgos
                ]);
            }else{

                  //log del sistema
             $modelUser = new Muser();
             $user = $modelUser->getUserbyId($input['user']);
     
     
             $accion = 'El usuario '.$user->usuario_us. ' creó la actividad: '.$input[0]['descripcion'];
     
             log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);

                return $this->getResponse([
                    'msg' => 'Actividad actualizada correctamente',
                    'data' => $actividades,
                    'error' => 1
                ]);
            }
           
    
        
        } catch (Exception $ex) {
            
            return $this->getResponse( [
                
                'error' => $ex->getMessage(),
                'error2' =>'No se pudo editar, intente de nuevo. Si el problema persiste, contacte con el administrador del sistema',
            ], ResponseInterface::HTTP_OK);
        }
        
    }
    // //editar los planes deaccion
    // public function updatePlanAccion(){
    
    //     try {
            
    //         $input = $this->getRequestInput($this->request);
        
    //         $model = new MriesgoPlanAccion();
    //         $model = new MRegistroControles();
    //         $modelERC = new EvaluacionRiesgosControles();
    //         $model->updatePlanAccion($input);
        
    //         return $this->getResponse([
    //             'msg' => 'Actualizado correctamente',
    //             'error' => 1
    //         ]);
        
    //     } catch (Exception $ex) {
            
    //         return $this->getResponse(
    //             [
    //                  //'error' => $ex->getMessage(),
    //                 'error' =>'No se pudo editar, intente de nuevo. Si el problema persiste, contacte con el administrador del sistema',
    //             ]
    //         , ResponseInterface::HTTP_OK);
    //     }
        
    // }
    public function controlFuerte($controles){
        //$controles = explode("-", $controles);
        //primero debo ordenar y traer aplicacion de la probabilidad
        //$input = $this->getRequestInput($this->request);
        //$controles = explode("-", $controles);
        //primero debo ordenar y traer aplicacion de la probabilidad
        //fuerte modeado debil
        //$controles =  $input['controles'];
        $controles =  $controles;
        //fuerte modeado debil
        $Mescenario = new Muser();
        $model = new MEvaluacionControl();
        $modelControles = new MRegistroControles();
        $caracteristicas_controles = [];
        $posiciones_control = [];
        $controles_obtenidos =[];
        $encontrado = true;
        $id_control = [];
        $escenario = $Mescenario ->getEscenario();
        $respuesta = $model->getCaracteristicaOpcion($escenario);
        $controles_fuertes = [];
        $cobertura1 = 0;
        $cobertura2 = 0;
        $cobertura3 = 0;
        $cobertura_final =0;
        $controles_pruebas = [];
       
        //var_dump($respuesta);
        if($respuesta){

            foreach ($respuesta as $key => $value) {
                //var_dump($value);
                $posicion =  explode("%", $value['posicion'])[0];
                //$posicion = ($value['posicion'].split("%")[0]);
                 array_push($posiciones_control,$posicion);
                //aqui se edito por miguel cambie caracteristica por calificacion
                array_push($caracteristicas_controles,strtoupper($value['calificacion']));
               
            }
           
                for ($i = 1; $i < count($posiciones_control) ; $i++) {
                    for ($j = 0; $j <  (count($posiciones_control) - $i); $j++) {
                        if($posiciones_control[$j] <= $posiciones_control[$j+1]){
                            $aux = $posiciones_control[$j];
                            $posiciones_control[$j] = $posiciones_control[$j+1];
                            $posiciones_control[$j+1] = $aux;

                            $aux_caracteristica = $caracteristicas_controles[$j];
                            $caracteristicas_controles[$j] = $caracteristicas_controles[$j+1];
                            $caracteristicas_controles[$j+1] = $aux_caracteristica;

                        }
                    }  
                }  
                //ahora traemos todos los controles y colocamos su id y descripcion para agregarlo
                //aun array_push

                foreach ($controles as $key => $value) {
                   $result = $modelControles -> getRegistroControl($value);
                    
                    $array_aux =[
                           // $value
                        'id' => $result->id,
                        'evaluacion' => $result->evaluacion,
                        'cobertura' => $result->idCobertura
                         
                    ];
                     array_push($controles_obtenidos,$array_aux);
                }

                //obtenidos los controles sus datos empezamos hacer la comparacion
                //recorremos primero el ordenado y luego los controles
               $max_level = "";
                foreach ($caracteristicas_controles as $key => $value) { // FUERTE MODERADO DEBIL
                   foreach ($controles_obtenidos as $key => $value2) {  // DEBIL FUERTE MODERADO  FUERTE
                    //primero asignar el valor mas alto y guardarlo en una variable
                    //luego que se guarden todos los del valor encontrado
                    if($encontrado){
                        if($value == $value2['evaluacion']){
                            $max_level = $value;
                            //aqui probare
                           
                            //encuentra el mayor ahi se queda
                            $encontrado = false;
                            // $id_control = [
                            //     ''
                            // ]
                            // $value2['id'];
                            //agregaros 


                            
                        }
                    }
                        //aqui debe agregar del max_level
                        if($max_level == $value2['evaluacion']){
                            $array = [
                          
                                'id' => $value2['id'],
                                'evaluacion' => $value2['evaluacion'],
                                'cobertura' => $value2['cobertura']
                            
                    
                
               
                            ];
                        
                            array_push($controles_fuertes,$array);
                        }

                       
                    }
                   
                }
                //si ya tengo los controles mas fuertes entonces solo recorro e igualo
                foreach ($caracteristicas_controles as $key => $value) {
                        foreach ($controles_fuertes as $key => $value2) {
                                // $array_aux = [
                                //     $value2['cobertura']
                                // ];
                                // array_push($controles_pruebas,$array_aux);
                                if($value2['cobertura'] == 1){
                                    $cobertura1 = $value2['cobertura'];
                                    $id_control = $value2['id'];
                                }
                                if($value2['cobertura'] == 2){
                                    $cobertura2 = $value2['cobertura'];
                                    $id_control = $value2['id'];
                                }
                                if($value2['cobertura'] == 3){
                                    $cobertura3 = $value2['cobertura'];
                                    $id_control = $value2['id'];
                                }
                            // if($value == $value2[$value]['evaluacion']){
                            //     $array_aux = [
                            //         $value,
                            //         $value2
                            //     ];
                            //     array_push($controles_pruebas,$array_aux);
                            // }
                        }
                }
                //asignamos la cobertura que enviaremos
                if($cobertura1 != 0){
                    $cobertura_final = $cobertura1;
                }
                if($cobertura2 != 0){
                    $cobertura_final = $cobertura2;
                }
                if($cobertura3 != 0){
                    $cobertura_final = $cobertura3;
                }
                if($cobertura1 != 0 && $cobertura2!=0){
                    $cobertura_final = 3;
                }
                //evaluamos la cobertura que queda y le mandamos su id_control
        }else{
            $id_control = false;
        }
      

        //     $response = [
        //         'id_control' => $controles_fuertes
        //     ];
        //     return $this->respond($response, ResponseInterface::HTTP_OK);
        $response = [
            'id_control' => $id_control,
            'cobertura' => $cobertura_final
        ];
        return $response;

    
        //return $this->respond($response, ResponseInterface::HTTP_OK);

    }
    //preguntar tengo que elegir el control mas fuerte?
    public function updateRiesgosControlados($id_riesgo){
        try {
            //code...
            $evaluacionRiesgoModel = new EvaluacionRiesgo();
            $riesgo = $evaluacionRiesgoModel->find($id_riesgo);
            if($riesgo['is_deleted'] == "1"){
                return $this->getResponse(
                    [
                        'error' => true,
                        'message' => 'Esta evaluacion de riesgo está eliminado'
                    ],
                    ResponseInterface::HTTP_OK
                );
            }
            $posiciones_probabilidad = [];
            $posiciones_impacto = [];
            $probabilidadModel = new ProbabilidadRiesgo();
            $impactoModel = new ImpactoRiesgo();
            $user = new Muser();
            $escenario = $user->getEscenario();
            $evaluacionControl = new MEvaluacionControl();
            $caracteristicas = $evaluacionControl->getCaracteristicaOpcion($escenario);
            $posiciones_control = array();
            $caracteristicas_controles = array();
            $controles = [];
            $controles_post = [];
            $pp = $probabilidadModel->getAll($escenario);
            $pi = $impactoModel->getAll($escenario);
            $riesgo_controlado_impacto = $riesgo['riesgo_controlado_impacto'];
            $riesgo_controlado_probabilidad = $riesgo['riesgo_controlado_probabilidad'];
            $riesgo_controlado_valor = $riesgo['riesgo_controlado_valor'];
            foreach ($pp as $item) {
                array_push($posiciones_probabilidad,$item['descripcion']);
            }

            foreach ($pi as $item) {
                array_push($posiciones_impacto,$item['descripcion']);
            }

            if(count($caracteristicas) > 0){
                foreach ($caracteristicas as $item) {

                    $posicion = intval(explode("%",$item['posicion'])[0]);
                    array_push($posiciones_control,$posicion);
                   // array_push($caracteristicas_controles,strtoupper($item['caracteristica']));
                //    var_dump($item);
                    array_push($caracteristicas_controles,strtoupper($item['calificacion']));
                }

                // for ($i = 1; $i < count($posiciones_control); $i++) {
                //     for ($j = 0; $j < (count($posiciones_control) - $i); $j++) {
                //         if($posiciones_control[$j] <= $posiciones_control[$j+1]){
                //             $aux = $posiciones_control[$j];
                //             $posiciones_control[$j] = $posiciones_control[$j+1];
                //             $posiciones_control[$j+1] = $aux;
        
                //             $aux_caracteristica = $caracteristicas_controles[$j];
                //             $caracteristicas_controles[$j] =$caracteristicas_controles[$j+1];
                //             $caracteristicas_controles[$j+1] = $aux_caracteristica;
        
                //         }
                //     }
                // }
                // $control_selected = 0;
                //foreach ($caracteristicas_controles as $caracteristica_control) {
                    $evaluacionRiesgosControles = new EvaluacionRiesgosControles();
                    $controles = $evaluacionRiesgosControles->getByEvaluacionRiesgoId($id_riesgo);
                    
                    foreach ($controles as $key => $value) {
                      
                        array_push($controles_post,$value['id_control']);
                    }
                 
                    $controles = $this->controlFuerte($controles_post);
                    //return $controles;
                    //if(count($controles) > 0){
                        $control_selected = 0;
                        //foreach ($controles as $control) {
                            $control_id = intval($controles['id_control']);
                            // el control seleccionado = $control_id
                            $found = false;
                           // return $control_id;
                            //if(!$found){
                                $registroControlModel = new MRegistroControles();
                                $registroControl = $registroControlModel->getRegistroControl($control_id);
                              
                               // $cobertura = $registroControl->idCobertura;
                               $cobertura =  intval($controles['cobertura']);
                                $evaluacion = strtolower($registroControl->evaluacion);
                               
                                $firstLetter = strtoupper(substr($evaluacion,0,1));
                                 $caracteristica = $firstLetter.substr($evaluacion,1,strlen($evaluacion));
                                 
                                $caracteristica_upper = strtoupper($caracteristica);
                                // $caracteristica_control_1 = strtoupper($caracteristica_control);

                               
                                // if($caracteristica_upper == $caracteristica_control_1){
                                   
                                //     $found = true;
                                    $cobertura = intval($cobertura);
                                    $control_selected = $control_id;
                                    
                                    // var_dump($control_selected);

                                    
                                    switch ($cobertura) {
                                        case 1:
                                            if($escenario == 1){
                                                $riesgo_controlado_impacto = $riesgo['valor_impacto'];
                                                
                                            }else{
                                                $riesgo_controlado_impacto = $riesgo['impacto'];
                                               
                                            }
                                            $riesgo_controlado_probabilidad = $this->getAplicacionProbabilidad($caracteristica,$escenario,$posiciones_probabilidad,$riesgo);
                                            //$riesgo_controlado_valor = $this->getRiesgoControladoValor($riesgo['valor_probabilidad'],$riesgo['valor_impacto'],$riesgo_controlado_probabilidad,$riesgo['riesgo_controlado_impacto'],$escenario);
                                            $riesgo_controlado_valor = $this->getRiesgoControladoValor($riesgo['valor_probabilidad'],$riesgo['valor_impacto'],$riesgo_controlado_probabilidad,$riesgo_controlado_impacto,$escenario);
                                              
                                          break;
                                        case 2:
                                            if($escenario == 1){
                                                $riesgo_controlado_probabilidad = $riesgo['valor_probabilidad'];
                                            }else{ 
                                                $riesgo_controlado_probabilidad =  $riesgo['probabilidad'];;
                                            }
                                           
                                            $riesgo_controlado_impacto = $this->getAplicacionImpacto($caracteristica,$escenario,$posiciones_impacto,$riesgo);
                                            $riesgo_controlado_valor = $this->getRiesgoControladoValor($riesgo['valor_probabilidad'],$riesgo['valor_impacto'], $riesgo_controlado_probabilidad,$riesgo_controlado_impacto,$escenario);
                                            
                                            break;
                                        case 3:
                                         
                                            $riesgo_controlado_probabilidad = $this->getAplicacionProbabilidad($caracteristica,$escenario,$posiciones_probabilidad,$riesgo);
                                            //return $riesgo_controlado_probabilidad;
                                             $riesgo_controlado_impacto = $this->getAplicacionImpacto($caracteristica,$escenario,$posiciones_impacto,$riesgo);
                                            
                                            $riesgo_controlado_valor = $this->getRiesgoControladoValor($riesgo['valor_probabilidad'],$riesgo['valor_impacto'],$riesgo_controlado_probabilidad,$riesgo_controlado_impacto,$escenario);
                                           
                                            
                                            break;
                                        default:
                                            break;
                                    }
                                  
                                    $riesgo['id_control'] = $control_selected;
                                    $riesgo['riesgo_controlado_probabilidad'] = $riesgo_controlado_probabilidad;
                                    $riesgo['riesgo_controlado_impacto'] = $riesgo_controlado_impacto;
                                    $riesgo['riesgo_controlado_valor'] = $riesgo_controlado_valor;
                                    $evaluacionRiesgoModel->update($id_riesgo,$riesgo);
                                 
            //hasta aqui
                                    
                                //}
                            //}
                       // }
                       
                      



                        
                        
                        // var_dump($riesgo);
                                            //return $riesgo;
                        

                        // return $this->getResponse(
                        //     [
                        //         'error' => false,
                        //         'msg' =>'estoy aqui',
                        //         'message' => 'Valores de riesgos controlados actualizados en evaluación de riesgo',
                        //         'data' => $riesgo
                        //     ],
                        //     ResponseInterface::HTTP_OK
                        // );
                    //}
                //}
            }
           
            // return $this->getResponse(
            //     [
            //         'error' => $id_riesgo,
            //         // 'message' => $th->getMessage(),
            //         // 'line' => $th->getLine(),
            //         // 'file' => $th->getFile()
            //     ],
            //     ResponseInterface::HTTP_OK
            // );
            
        } catch (\Throwable $th) {
            return $this->getResponse(
                [
                    'error' => true,
                    'message' => $th->getMessage(),
                    'line' => $th->getLine(),
                    'file' => $th->getFile()
                ],
                ResponseInterface::HTTP_OK
            );
        }
    }

    public function getAplicacionProbabilidad($caracteristica,$escenario,$posiciones_probabilidad,$riesgo){
        $MAplicacionProbabilidad = new MAplicacionProbabilidad();
        $respuestaCaracteristica = $MAplicacionProbabilidad->getByCaracteristica(['caracteristica' => $caracteristica,'escenario' => $escenario])[0];
        // var_dump($respuestaCaracteristica);die();
        
        if(intval($escenario) == 2){
            $probabilidad_actual = $riesgo['probabilidad'];
            foreach ($posiciones_probabilidad as $key => $value) {
                if($value == $probabilidad_actual){
                    $index = $key;
                }
            }
           
            $posicion = intval($index) - intval($respuestaCaracteristica['posicion']);
            if($posicion <= 0){
                $posicion = 0;
            }else{
                $posicion = $posicion;
            }
            $new_posicion = $posiciones_probabilidad[$posicion];
            $riesgo_controlado_probabilidad = $new_posicion;
        }else if(intval($escenario) == 1){
          //  $value = intval(explode("%",$respuestaCaracteristica[0]['posicion'])[0])/100;
          $value = intval(explode("%",$respuestaCaracteristica['posicion'])[0])/100;
            $probabilidad_actual = $riesgo['valor_probabilidad'];
            $new_probabilidad = $probabilidad_actual - ($probabilidad_actual * $value);
            $riesgo_controlado_probabilidad = $new_probabilidad;
        }
        return $riesgo_controlado_probabilidad;
    }

    public function getAplicacionImpacto($caracteristica,$escenario,$posiciones_impacto,$riesgo){
        $MAplicacionImpacto = new MAplicacionImpacto();
        $respuestaCaracteristica = $MAplicacionImpacto->getByCaracteristica(['caracteristica' => $caracteristica,'escenario' => $escenario]);
        
        if(intval($escenario) == 2){
            $impacto_actual = $riesgo['impacto'];
            foreach ($posiciones_impacto as $key => $value) {
                if($value == $impacto_actual){
                    $index = $key;
                }
            }
            // var_dump($respuestaCaracteristica[0]);die();
            $posicion = intval($index) - intval($respuestaCaracteristica[0]['posicion']);
            if($posicion <= 0){
                $posicion = 0;
            }else{
                $posicion = $posicion;
            }
            $new_posicion = $posiciones_impacto[$posicion];
            $riesgo_controlado_impacto = $new_posicion;
        }else if(intval($escenario) == 1){
            //var_dump($respuestaCaracteristica);
            $value = intval(explode("%",$respuestaCaracteristica[0]['posicion'])[0])/100;
            $impacto_actual = $riesgo['valor_impacto'];
            $new_impacto = $impacto_actual - ($impacto_actual * $value);
            $riesgo_controlado_impacto = $new_impacto;
        }
        return $riesgo_controlado_impacto;
    }

    public function getRiesgoControladoValor($valorProb = 0,$valorImp = 0,$descripcionProb = "",$descripcionImp = "",$escenario = 0){
        if(intval($escenario) == 2){
            $probabilidadModel = new ProbabilidadRiesgo();
            $p1 = $probabilidadModel->getByDescription(['descripcion'=>$descripcionProb])[0];
            $idProbabilidad = $p1['id'];
            $impactoModel = new ImpactoRiesgo();
            $p2 = $impactoModel->getByDescription(['descripcion'=>$descripcionImp])[0];
            $idImpacto = $p2['id'];
            $MValoracionRiesgo = new MValoracionRiesgo();
            $respuesta = $MValoracionRiesgo->getByProbabilidadImpacto(['id_probabilidad' => $idProbabilidad,'id_impacto' => $idImpacto])[0];
            return $respuesta['valor'];
        }else if(intval($escenario) == 1){
            // $value = $valorProb * $valorImp;
            $value = $descripcionProb * $descripcionImp;
            $model = new NivelRiesgo();
            $niveles = $model->getAll();
            $found_nivel = false;
            
            foreach ($niveles as $nivel) {
                // $nivel = json_decode($nivel);
                // var_dump($nivel);
                if(!$found_nivel){
                    if($nivel['operador1'] == ">"){
                        if($nivel['operador2'] == "<"){
                            if($value>$nivel['valor1'] && $value<$nivel['valor2']){
                                $found_nivel = true;
                                $descripcion = $nivel['descripcion'];
                            }
                        }
                        if($nivel['operador2'] == "<="){
                            if($value>$nivel['valor1'] && $value<=$nivel['valor2']){
                                $found_nivel = true;
                                $descripcion = $nivel['descripcion'];
                            }
                        }
                    }
                    if($nivel['operador1'] == ">="){
                        if($nivel['operador2'] == "<"){
                            if($value>=$nivel['valor1'] && $value<$nivel['valor2']){
                                $found_nivel = true;
                                $descripcion = $nivel['descripcion'];
                            }
                        }
                        if($nivel['operador2'] == "<="){
                            if($value>=$nivel['valor1'] && $value<=$nivel['valor2']){
                                $found_nivel = true;
                                $descripcion =$nivel['descripcion'];
                            }
                        }
                    }
                    if($nivel['operador1'] == "<"){
                        if($nivel['operador2'] == ">"){
                            if($value<$nivel['valor1'] && $value>$nivel['valor2']){
                                $found_nivel = true;
                                $descripcion = $nivel['descripcion'];
                            }
                        }
                        if($nivel['operador2'] == ">="){
                            if($value<$nivel['valor1'] && $value>=$nivel['valor2']){
                                $found_nivel = true;
                                $descripcion = $nivel['descripcion'];
                            }
                        }
                    }
                    if($nivel['operador1'] == "<="){
                        if($nivel['operador2'] == ">"){
                            if($value<=$nivel['valor1'] && $value>$nivel['valor2']){
                                $found_nivel = true;
                                $descripcion = $nivel['descripcion'];
                            }
                        }
                        if($nivel['operador2'] == ">="){
                            if($value<=$nivel['valor1'] && $value>=$nivel['valor2']){
                                $found_nivel = true;
                                $descripcion = $nivel['descripcion'];
                            }
                        }
                    }
                    // OPERADOR 2
                    if($nivel['operador2'] == ">"){
                        if($nivel['operador1'] == "<"){
                            if($value > $nivel['valor2'] && $value<$nivel['valor1']){
                                $found_nivel = true;
                                $descripcion =$nivel['descripcion'];
                            }
                        }
                        if($nivel['operador1'] == "<="){
                            if($value>$nivel['valor2'] && $value<=$nivel['valor1']){
                                $found_nivel = true;
                                $descripcion = $nivel['descripcion'];
                            }
                        }
                    }
                    if($nivel['operador2'] == ">="){
                        if($nivel['operador1'] == "<"){
                            if($value >= $nivel['valor2'] && $value<$nivel['valor1']){
                                $found_nivel = true;
                                $descripcion = $nivel['descripcion'];
                            }
                        }
                        if($nivel['operador1'] == "<="){
                            if($value>=$nivel['valor2'] && $value<=$nivel['valor1']){
                                $found_nivel = true;
                                $descripcion = $nivel['descripcion'];
                            }
                        }
                    }
                    if($nivel['operador2'] == "<"){
                        if($nivel['operador1'] == "<"){
                            if($value < $nivel['valor2'] && $value<$nivel['valor1']){
                                $found_nivel = true;
                                $descripcion = $nivel['descripcion'];
                            }
                        }
                        if($nivel['operador1'] == "<="){
                            if($value<$nivel['valor2'] && $value<=$nivel['valor1']){
                                $found_nivel = true;
                                $descripcion = $nivel['descripcion'];
                            }
                        }
                    }
                    if($nivel['operador2'] == "<="){
                        if($nivel['operador1'] == "<"){
                            if($value <= $nivel['valor2'] && $value<$nivel['valor1']){
                                $found_nivel = true;
                                $descripcion = $nivel['descripcion'];
                            }
                        }
                        if($nivel['operador1'] == "<="){
                            if($value <= $nivel['valor2'] && $value<=$nivel['valor1']){
                                $found_nivel = true;
                                $descripcion = $nivel['descripcion'];
                            }
                        }
                    }
                }
            }
            return $descripcion;
        }
    }

   
    //adicional para la front
    public function controlMasFuerte(){

        $input = $this->getRequestInput($this->request);
        //$controles = explode("-", $controles);
        //primero debo ordenar y traer aplicacion de la probabilidad
        //fuerte modeado debil
        $controles =  $input['controles'];
        
        $Mescenario = new Muser();
        $model = new MEvaluacionControl();
        $modelControles = new MRegistroControles();
        $caracteristicas_controles = [];
        $posiciones_control = [];
        $controles_obtenidos =[];
        $encontrado = true;
        $id_control = [];
        $controles_fuertes = [];
        $cobertura1 = 0;
        $cobertura2 = 0;
        $cobertura3 = 0;
        $cobertura_final =0;
        $controles_pruebas = [];
        $escenario = $Mescenario ->getEscenario();
        $respuesta = $model->getCaracteristicaOpcion($escenario);
        //var_dump($respuesta);
        // if($respuesta){

        //     foreach ($respuesta as $key => $value) {
        //         //var_dump($value);
        //         $posicion =  explode("%", $value['posicion'])[0];
        //         //$posicion = ($value['posicion'].split("%")[0]);
        //          array_push($posiciones_control,$posicion);
        //         //aqui se edito por miguel cambie caracteristica por calificacion
        //         array_push($caracteristicas_controles,strtoupper($value['calificacion']));
               
        //     }
           
        //         for ($i = 1; $i < count($posiciones_control) ; $i++) {
        //             for ($j = 0; $j <  (count($posiciones_control) - $i); $j++) {
        //                 if($posiciones_control[$j] <= $posiciones_control[$j+1]){
        //                     $aux = $posiciones_control[$j];
        //                     $posiciones_control[$j] = $posiciones_control[$j+1];
        //                     $posiciones_control[$j+1] = $aux;

        //                     $aux_caracteristica = $caracteristicas_controles[$j];
        //                     $caracteristicas_controles[$j] = $caracteristicas_controles[$j+1];
        //                     $caracteristicas_controles[$j+1] = $aux_caracteristica;

        //                 }
        //             }  
        //         }  
        //         //ahora traemos todos los controles y colocamos su id y descripcion para agregarlo
        //         //aun array_push

        //         foreach ($controles as $key => $value) {
        //            $result = $modelControles -> getRegistroControl($value);
                    
        //             $array_aux =[
        //                    // $value
        //                 'id' => $result->id,
        //                 'evaluacion' => $result->evaluacion,
                         
        //             ];
        //              array_push($controles_obtenidos,$array_aux);
        //         }

        //         //obtenidos los controles sus datos empezamos hacer la comparacion
        //         //recorremos primero el ordenado y luego los controles
               
        //         foreach ($caracteristicas_controles as $key => $value) {
        //            foreach ($controles_obtenidos as $key => $value2) {
        //             if($encontrado){
        //                 if($value == $value2['evaluacion']){
        //                     //encuentra el mayor ahi se queda
        //                     $encontrado = false;
        //                     $id_control = $value2['id'];
        //                 }
        //             }
        //            }
        //         }
        // }else{
        //     $id_control = false;
        // }
        if($respuesta){

            foreach ($respuesta as $key => $value) {
                //var_dump($value);
                $posicion =  explode("%", $value['posicion'])[0];
                //$posicion = ($value['posicion'].split("%")[0]);
                 array_push($posiciones_control,$posicion);
                //aqui se edito por miguel cambie caracteristica por calificacion
                array_push($caracteristicas_controles,strtoupper($value['calificacion']));
               
            }
           
                for ($i = 1; $i < count($posiciones_control) ; $i++) {
                    for ($j = 0; $j <  (count($posiciones_control) - $i); $j++) {
                        if($posiciones_control[$j] <= $posiciones_control[$j+1]){
                            $aux = $posiciones_control[$j];
                            $posiciones_control[$j] = $posiciones_control[$j+1];
                            $posiciones_control[$j+1] = $aux;

                            $aux_caracteristica = $caracteristicas_controles[$j];
                            $caracteristicas_controles[$j] = $caracteristicas_controles[$j+1];
                            $caracteristicas_controles[$j+1] = $aux_caracteristica;

                        }
                    }  
                }  
                //ahora traemos todos los controles y colocamos su id y descripcion para agregarlo
                //aun array_push

                foreach ($controles as $key => $value) {
                   $result = $modelControles -> getRegistroControl($value);
                    
                    $array_aux =[
                           // $value
                        'id' => $result->id,
                        'evaluacion' => $result->evaluacion,
                        'cobertura' => $result->idCobertura
                         
                    ];
                     array_push($controles_obtenidos,$array_aux);
                }

                //obtenidos los controles sus datos empezamos hacer la comparacion
                //recorremos primero el ordenado y luego los controles
               $max_level = "";
                foreach ($caracteristicas_controles as $key => $value) { // FUERTE MODERADO DEBIL
                   foreach ($controles_obtenidos as $key => $value2) {  // DEBIL FUERTE MODERADO  FUERTE
                    //primero asignar el valor mas alto y guardarlo en una variable
                    //luego que se guarden todos los del valor encontrado
                    if($encontrado){
                        if($value == $value2['evaluacion']){
                            $max_level = $value;
                            //aqui probare
                           
                            //encuentra el mayor ahi se queda
                            $encontrado = false;
                            // $id_control = [
                            //     ''
                            // ]
                            // $value2['id'];
                            //agregaros 


                            
                        }
                    }
                        //aqui debe agregar del max_level
                        if($max_level == $value2['evaluacion']){
                            $array = [
                          
                                'id' => $value2['id'],
                                'evaluacion' => $value2['evaluacion'],
                                'cobertura' => $value2['cobertura']
                            
                    
                
               
                            ];
                        
                            array_push($controles_fuertes,$array);
                        }

                       
                    }
                   
                }
                //si ya tengo los controles mas fuertes entonces solo recorro e igualo
                foreach ($caracteristicas_controles as $key => $value) {
                        foreach ($controles_fuertes as $key => $value2) {
                                // $array_aux = [
                                //     $value2['cobertura']
                                // ];
                                // array_push($controles_pruebas,$array_aux);
                                if($value2['cobertura'] == 1){
                                    $cobertura1 = $value2['cobertura'];
                                    $id_control = $value2['id'];
                                }
                                if($value2['cobertura'] == 2){
                                    $cobertura2 = $value2['cobertura'];
                                    $id_control = $value2['id'];
                                }
                                if($value2['cobertura'] == 3){
                                    $cobertura3 = $value2['cobertura'];
                                    $id_control = $value2['id'];
                                }
                            // if($value == $value2[$value]['evaluacion']){
                            //     $array_aux = [
                            //         $value,
                            //         $value2
                            //     ];
                            //     array_push($controles_pruebas,$array_aux);
                            // }
                        }
                }
                //asignamos la cobertura que enviaremos
                if($cobertura1 != 0){
                    $cobertura_final = $cobertura1;
                }
                if($cobertura2 != 0){
                    $cobertura_final = $cobertura2;
                }
                if($cobertura3 != 0){
                    $cobertura_final = $cobertura3;
                }
                if($cobertura1 != 0 && $cobertura2!=0){
                    $cobertura_final = 3;
                }
                //evaluamos la cobertura que queda y le mandamos su id_control
        }else{
            $id_control = false;
        }
        $response = [
            'id_control' => $id_control,
            'cobertura' => $cobertura_final
        ];
        return $this->respond($response, ResponseInterface::HTTP_OK);
    
        //return $id_control;

    }
     
}

