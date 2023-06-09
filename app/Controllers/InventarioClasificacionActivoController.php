<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use App\Models\EvaluacionRiesgo;
use App\Models\InventarioClasificacionActivo;
use App\Models\Muser;
use App\Models\MValoracionActivo;
use CodeIgniter\API\ResponseTrait;
use CodeIgniter\HTTP\ResponseInterface;
use Exception;

class InventarioClasificacionActivoController extends BaseController
{
    use ResponseTrait;

    public function getValoracionActivoById(){
        $input = $this->getRequestInput($this->request);

        try {
            $model = new MValoracionActivo();
            $response = [
                'data' =>  $model->getValoracionActivoById($input['id_valoracion_activo'])
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

    public function getAllDetalleValoracionActivo(){
        try {
            $model = new MValoracionActivo();
            $response = [
                'data' =>  $model->get_all_detalle_valoracion_activo()
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
    public function getValorActivoByValoraciones(){
        try {
            $input = $this->getRequestInput($this->request);
            $model = new MValoracionActivo();
            $response = [
                'data' =>  $model->getValorActivoByValoraciones($input['valores'])
            ];
            return $this->respond($response, ResponseInterface::HTTP_OK);
        } catch (Exception $ex) {
            return $this->getResponse(
                    [
                        'error' => $ex->getMessage(),
                        'file' => $ex->getFile(),
                        'line' => $ex->getLine()
                    ],
                    ResponseInterface::HTTP_OK
                );
        } 
    }
    public function getDetalleValoracionActivo(){
        $input = $this->getRequestInput($this->request);

        try {
            $model = new MValoracionActivo();
            $response = [
                'data' =>  $model->getDetalleValoracionActivo($input['aspecto'])
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
    public function getAllHistoricos($id){
        $input = $this->getRequestInput($this->request);

        try {
            $model = new InventarioClasificacionActivo();
            $response = [
                'data' =>  $model->getAllHistoricos($id),
            ];
            if($input['accion'] == "exportar"){
                $modelUser = new Muser();
                $user = $modelUser->getUserbyId($input['user']);
                $accion = 'El usuario '.$user->usuario_us. ' exportó la información historia de inventario de clasificación y activos';
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
    public function getAllHistoricosByUser($user_id,$id){
        $input = $this->getRequestInput($this->request);
        try {
            $model = new InventarioClasificacionActivo();
            $response = [
                'data' =>  $model->getAllHistoricosByUser($user_id,$id),
            ];
            if($input['accion'] == "exportar"){
                $modelUser = new Muser();
                $user = $modelUser->getUserbyId($user_id);
                $accion = 'El usuario '.$user->usuario_us. ' exportó la información historia de inventario de clasificación y activos por usuario';
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
    public function getValorByValoraciones(){
        try {
            $input = $this->getRequestInput($this->request);
            $model = new InventarioClasificacionActivo();
            $response = [
                'data' =>  $model->getValorByValoraciones($input),
            ];
            return $this->respond($response, ResponseInterface::HTTP_OK);
        } catch (Exception $ex) {
            log_message('error',$ex->getMessage()." linea ".$ex->getLine()." file ".$ex->getFile());

            return $this->getResponse(
                    [
                        'error' => $ex->getMessage(),
                    ],
                    ResponseInterface::HTTP_OK
                );
        }
    }
    public function listByValoraciones(){
        try {
            $input = $this->getRequestInput($this->request);
            $model = new InventarioClasificacionActivo();
            $response = [
                'data' =>  $model->listByValoraciones($input),
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
    public function index($id){
        $input = $this->getRequestInput($this->request);

        try {
            $model = new InventarioClasificacionActivo();
            $response = [
                'data' =>  $model->getAll($id),
            ];
            if($input['accion'] == "exportar"){
                $modelUser = new Muser();
                $user = $modelUser->getUserbyId($input['user']);
                $accion = 'El usuario '.$user->usuario_us. ' exportó la informacion de inventario de clasificación y activo';
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
    public function show($id){
        try {
            $model = new InventarioClasificacionActivo();
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

    public function getByUser($user_id,$empresa){
        $input = $this->getRequestInput($this->request);

        try {
            $model = new InventarioClasificacionActivo();
            $response = [
                'data' =>  $model->getByUser($user_id,$empresa),
            ];
            if($input['accion'] == "exportar"){
                $modelUser = new Muser();
                $user = $modelUser->getUserbyId($user_id);
                $accion = 'El usuario '.$user->usuario_us. ' exporto la informacion de inventario de clasificación y activo por usuario';
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
    public function store(){
        try {
            $rules = [
                'idempresa' => 'required',
                'idarea' => 'required',
                'idunidades' => 'required',
                'idmacroproceso' => 'required',
                'idproceso' => 'required',
                'activo' => 'required',
                'desc_activo' => 'required',
                'idtipo_activo' => 'required',
                'idcategoria_activo' => 'required',
                'idubicacion' => 'required',
                'idpropietario' => 'required',
                'idcustodio' => 'required',
                'idvalor' => 'required',
                'estado' => 'required',
                'comentario' => 'required',
            ];
            $errors = [
                'idempresa' => [
                    'required' => 'Debe ingresar la empresa',
                ],
                'idarea' => [
                    'required' => 'Debe ingresar el area',
                ],
                'idunidades' => [
                    'required' => 'Debe ingresar la unidad',
                ],
                'idmacroproceso' => [
                    'required' => 'Debe ingresar el macroproceso',
                ],
                'idproceso' => [
                    'required' => 'Debe ingresar el proceso',
                ],
                'activo' => [
                    'required' => 'Debe ingresar el activo',
                ],
                'desc_activo' => [
                    'required' => 'Debe ingresar la descripcion del activo',
                ],
                'idtipo_activo' => [
                    'required' => 'Debe ingresar el tipo de activo',
                ],
                'idcategoria_activo' => [
                    'required' => 'Debe ingresar la categoria del activo',
                ],
                'idubicacion' => [
                    'required' => 'Debe ingresar la ubicacion',
                ],
                'idpropietario' => [
                    'required' => 'Debe ingresar el propietario',
                ],
                'idvalor' => [
                    'required' => 'Debe ingresar el valor',
                ],
                'estado' => [
                    'required' => 'Debe ingresar el estado',
                ],
                'comentario' => [
                    'required' => 'Debe ingresar el comentario',
                ],
            ];

            $input = $this->getRequestInput($this->request);
            if (!$this->validateRequest($input, $rules, $errors)) {
                $error = [
                    'error' => true,
                    'datos' => $this->validator->getErrors()
                ];
                return ($this->getResponse($error,ResponseInterface::HTTP_OK));
            }

            $model = new InventarioClasificacionActivo();
            $found = $model->where('activo',$input['activo'])->where('idempresa',$input['idempresa'])->where('is_deleted',0)->findAll();
            if(count($found) > 0){
                return $this->getResponse(
                    [
                        'error' => true,
                        'msg' =>  'Inventario de clasificación y activo ya registrado'
                    ]
                );
            }

            $result = $model->store($input);

            $modelUser = new Muser();
            $user = $modelUser->getUserbyId($input['id_user_added']);
            $accion = 'El usuario '.$user->usuario_us. ' creó el inventario de clasificación y activos: '.$input['activo'];
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
                        'msg' =>  'Ocurrio un error',
                        'msg2' => $result
                       
                    ]
                );
            }
        } catch (\Throwable $th) {
            return $this->getResponse(
                [
                    'error' => true,
                    'msg' =>  $th->getMessage(),
                    'line' => $th->getLine(),
                    'file' => $th->getFile()
                ]
            );
        }
    }

    public function update($id){
        try {
            //code...
            $input = $this->getRequestInput($this->request);
    
            $model = new InventarioClasificacionActivo();
            $modelEvaluarionRiesgo = new EvaluacionRiesgo();
            $found = $model->validateModify($id,$input);
            if(count($found) > 0){
                return $this->getResponse(
                    [
                        'error' => true,
                        'msg' =>  'Inventario y clasificación de activo ya registrado'
                    ]
                );
            }
            $ica = $model->find($id);
            if($ica['estado'] != $input['estado']){
                $input['id_user_added'] = $input['id_user_updated'];
                $input['date_add'] = $input['date_modify'];
                $model->store_historial($id,$input);
            }
            
            $data['id_activo'] = $id;
            $data['estado'] = $input['estado_2'];
            $modelEvaluarionRiesgo->update_status_riesgo($data);

            $result = $model->edit($id,$input);
            
            $modelUser = new Muser();
            $user = $modelUser->getUserbyId($input['id_user_updated']);
            $accion = 'El usuario '.$user->usuario_us. ' modificó el inventario de clasificación y activos: '.$input['activo'];
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
                    'msg' =>  $th->getMessage()." line ".$th->getLine()." file ".$th->getFile()
                ]
            );
        }
    }

    public function destroy($id){
        $input = $this->getRequestInput($this->request);
        $model = new InventarioClasificacionActivo();
        $found = $model->find($id);
        // $this->db->transBegin();
        try {

            if($found){
                // $model->delete($id)
                $result = $model -> deleteInventarioClasificacionActivo('inventario_clasificacion_activo',$id);
                if($result){
                    // $this->db->transRollback();
                    $input['is_deleted'] = 1;
                    $model->update($id,$input);

                    $modelUser = new Muser();
                    $user = $modelUser->getUserbyId($input['id_user_deleted']);
                    $accion = 'El usuario '.$user->usuario_us. ' eliminó el inventario de clasificación y activos: '.$found['activo'];
                    log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);
            
                    // return $this->getResponse(
                    //     [
                    //         'error' => false,
                    //         'msg' =>  'Inventario de clasificacion de activo eliminado'
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
                        'msg' =>  'No existe el inventario de clasificacion de activo'
                    ]
                );
            }
            // $this->db->transCommit();
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
    public function updateStatus($id){
        try {
            $input = $this->getRequestInput($this->request);
            $model = new InventarioClasificacionActivo();
            $ica = $model->find($id);
            if($input['estado'] != $ica['estado']){
                $model->store_historial($id,$ica);
            }
            $result = $model->update_estado_ica($id,$input);
            $modelUser = new Muser();
            $user = $modelUser->getUserbyId($input['id_user_updated']);
            $accion = 'El usuario '.$user->usuario_us. ' modificó el inventario de clasificación y activos: '.$ica['activo'];
            log_sistema($accion,$input['terminal'],$input['ip'],$user->id_us,$user->usuario_us);
    
            return $this->getResponse(
                [
                    'error' => false,
                    'msg' =>  $result
                ]
            );
        } catch (\Throwable $th) {
            return $this->getResponse(
                [
                    'error' => true,
                    'msg' =>  $th->getMessage()." line ".$th->getLine()." file ".$th->getFile()
                ]
            );
        
        }
    }

    public function reloadValoracion(){
        try {
            $input = $this->getRequestInput($this->request);
            $model = new InventarioClasificacionActivo();
            $modelValoracion = new MValoracionActivo();
          
            //aqui aplicamos la lógica
            //primero traemos todas las valoraciones los id respectivos

            
            
            $inventario = $model -> getAllInventario();  //traigo todos los inventario de activos
           $array = "";

            foreach ($inventario as $key => $value) {
                $valores = $modelValoracion -> getValoracionDetalle($value['id_val']); // traigo todos los datos valoracion con detalle
                // foreach ($valores as $key => $value) {
                //     $array = '[{
                //         "idaspecto" : "'.$value['id_aspecto'].'"
                //         "idaspecto" : "'.$value['aspecto'].'"
                //         "idaspecto" : "'.$value['valoracion'].'"
                //     }]';
                // }
                for ($i=0; $i < count($valores); $i++) { 
                    if($i == 0){
                        $array = $array.
                            '[{ "idaspecto" : "'.$valores[$i]['id_aspecto'].'","aspecto" : "'.$valores[$i]['aspecto'].'","valoracion" : "'.$valores[$i]['valoracion'].'"},';
                    }else{
                        if($i == (count($valores) - 1)){
                            $array = $array.
                            '{"idaspecto" : "'.$valores[$i]['id_aspecto'].'","aspecto" : "'.$valores[$i]['aspecto'].'","valoracion" : "'.$valores[$i]['valoracion'].'"}]';
                        }else{
                            $array = $array.
                            '{"idaspecto" : "'.$valores[$i]['id_aspecto'].'","aspecto" : "'.$valores[$i]['aspecto'].'","valoracion" : "'.$valores[$i]['valoracion'].'"},';
                        }
                       
                    }
                   
                    

                }
                
                //hacemos update al inventario
                $result = $model -> updateVals($array,$value['id_ica']);
                $data = [
                    'idempresa'=> $value['idempresa'],
                    'idarea' => $value['idarea'],
                    'idunidades' => $value['idunidades'],
                    'idmacroproceso' => $value['idmacroproceso'],
                    'idproceso' => $value['idproceso'] ,
                    'activo' => $value['activo'] ,
                    'desc_activo' => $value['desc_activo'],
                    'idtipo_activo' => $value['idtipo_activo'],
                    'idcategoria_activo' => $value['idcategoria_activo'],
                    'idubicacion' => $value['idubicacion'],
                    'idpropietario' => $value['idpropietario'],
                    'idcustodio' => $value['idcustodio'],
                    'idvalor' => $value['idvalor'],
                    'estado' => $value['estado'],
                    'comentario' =>  $value['comentario'],
                    'id_user_added' => $input['user'] ,
                    'date_add' => date("Y-m-d H:i:s"),
                    'estado_2' => $value['id_val'],
                    'valores' => $array,
                ];
               
             
               
            
                //insertamos en la tabla historial
                $model ->store_historial($value['id_ica'],$data);
                $array = "";
            }
            $response = [
                
                
                'data' => $result
            ];
            //recorremos los 2 arreglos y asignamos el array que se enviara
            // [{"idaspecto":"2","aspecto":"Confidencialidad","valoracion":"1"},
            // {"idaspecto":"3","aspecto":"Integridad","valoracion":"1"},
            // {"idaspecto":"4","aspecto":"Disponibilidad","valoracion":"1"}]
            
           // [{ "idaspecto" : "2","aspecto" : "Confidencialidad","valoracion" : "1"},
           //{"idaspecto" : "3","aspecto" : "Integridad","valoracion" : "1"},
           //{"idaspecto" : "4","aspecto" : "Disponibilidad","valoracion" : "2"}]

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