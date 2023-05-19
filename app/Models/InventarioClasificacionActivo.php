<?php

namespace App\Models;

use CodeIgniter\Model;

class InventarioClasificacionActivo extends Model
{
    protected $table            = 'inventario_clasificacion_activo';

    protected $primaryKey       = 'id';
    protected $useSoftDeletes   = false;
    // Dates
    protected $useTimestamps = true;
    protected $dateFormat    = 'datetime';
    protected $createdField  = 'date_add';
    protected $updatedField  = 'date_modify';
    protected $deletedField  = 'date_deleted';
    protected $allowedFields    = [
        'id',
        'date_add',
        'date_modify',
        'date_deleted',
        'id_user_added',
        'id_user_modify',
        'id_user_deleted',
        'is_deleted'
    ];


    public $estados = [
        '1' => 'Borrador',
        '2' => 'Registrado',
        '3' => 'Observado',
        '4' => 'Aprobado',
        '5' => 'Por actualizar',
        '6' => 'Activo',
        '7' => 'Inactivo'
    ];

    public function getAllHistoricos($id){
        $sql = "call sp_list_inventario_clasificacion_activo_historial(?)";
        $result = $this->db->query($sql,[$id])->getResultArray();
        return $result;
    }
    public function getAllHistoricosByUser($user_id,$id){
        $sql = "call sp_list_inventario_clasificacion_activo_historial_by_user(?,?)";
        $result = $this->db->query($sql,[$user_id,$id])->getResultArray();
        return $result;
    }

    public function getAll($id){
        $sql = "call sp_list_inventario_clasificacion_activo(?)";
        $result = $this->db->query($sql,[$id])->getResultArray();
        return $result;
    }

    public function getById($id){
        $sql = "call sp_get_inventario_clasificacion_activo(?)";
        $result = $this->db->query($sql,[$id])->getResultArray();
        return $result;
    }

    public function getByUser($user_id,$empresa){
        $sql = "call sp_list_inventario_clasificacion_activo_by_user(?,?)";
        $result = $this->db->query($sql,[$user_id,$empresa])->getResultArray();
        return $result;
    }

    public function store($data){
        $sql = "call sp_add_inventario_clasificacion_activo(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        $result = $this->db->query($sql,[
            $data['idempresa'],
            $data['idarea'],
            $data['idunidades'],
            $data['idmacroproceso'],
            $data['idproceso'],
            $data['activo'],
            $data['desc_activo'],
            $data['idtipo_activo'],
            $data['idcategoria_activo'],
            $data['idubicacion'],
            $data['idpropietario'],
            $data['idcustodio'],
            $data['idvalor'],
            $data['estado'],
            $data['comentario'],
            $data['id_user_added'],
            $data['date_add'],
            $data['estado_2'],
            $data['vals'],
            $data['idvaloracion_activo'],
            $data['idclasificacion_informacion'],
        ]);
        if($result){
            $sql = "call sp_get_last_id";
            $result = $this->db->query($sql)->getResult();
            // $this->store_historial($result[0]->id,$data);
            if($data['estado'] == '2'){
                // return $data;
                //recuperar el correo del usuario?
                $mUser = new Muser();
                $user = $mUser->getUserbyId($data['id_user_added']);
                $usersbyarea = $mUser->getUserByAreaBCC($data['idarea']);
                $bcc = array(
                  
                );
                foreach ($usersbyarea as $item) {
                    array_push($bcc,$item['email_us']);
                }

                $response = $this->sendMail($result[0]->id,$user->email_us,$bcc);
                return $response;
            }
            return true;
        }
        return false;
    }
    public function store_historial($id_ica,$data){
        $sql = "call sp_add_inventario_clasificacion_activo_historial(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        $result = $this->db->query($sql,[
            $id_ica,
            $data['idempresa'],
            $data['idarea'],
            $data['idunidades'],
            $data['idmacroproceso'],
            $data['idproceso'],
            $data['activo'],
            $data['desc_activo'],
            $data['idtipo_activo'],
            $data['idcategoria_activo'],
            $data['idubicacion'],
            $data['idpropietario'],
            $data['idcustodio'],
            $data['idvalor'],
            $data['estado'],
            $data['comentario'],
            $data['id_user_added'],
            $data['date_add'],
            $data['estado_2'],
            $data['vals'],
            $data['idclasificacion_informacion'],
        ]);
        if($result){
            return true;
        }
        return false;
    }

    public function edit($id,$data){
        $sql = "call sp_edit_inventario_clasificacion_activo(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        $result = $this->db->query($sql,[
            $id,
            $data['idempresa'],
            $data['idarea'],
            $data['idunidades'],
            $data['idmacroproceso'],
            $data['idproceso'],
            $data['activo'],
            $data['desc_activo'],
            $data['idtipo_activo'],
            $data['idcategoria_activo'],
            $data['idubicacion'],
            $data['idpropietario'],
            $data['idcustodio'],
            $data['idvalor'],
            $data['estado'],
            $data['comentario'],
            $data['id_user_updated'],
            $data['date_modify'],
            $data['observacion'],
            $data['estado_2'],
            $data['vals'],
            $data['idvaloracion_activo'],
            $data['idclasificacion_informacion'],
        ]);
        if($result){
            $mUser = new Muser();
            $ica = $this->getById($id);
            if($ica[0]['id_user_added'] != $data['id_user_updated']){
                if($data['estado'] == '3' || $data['estado'] == '4' ){ //estado observar - aprobar
                    $mUser = new Muser();
                    $user = $mUser->getUserbyId($ica[0]['id_user_added']);
                    $this->sendMail($id,$user->email_us);
                }
            }else{
                if($data['estado'] == '2' || $data['estado'] == '3'){
                    // return $data;
                    // send email area seguridad informacion
                    $user = $mUser->getUserbyId($data['id_user_added']);
                    $usersbyarea = $mUser->getUserByAreaBCC($data['idarea']);
                    $bcc = array();
                    foreach ($usersbyarea as $item) {
                        array_push($bcc,$item['email_us']);
                    }
                    $response = $this->sendMail($id,$user->email_us,$bcc);
                    return $response;
                }
            }
            return true;
        }
        return false;
    }

    public function sendMail($id,$mail,$bcc = array()){
        try {
            $sql = "call sp_get_info_to_email(?)";
            $result = $this->db->query($sql,[
                $id
            ])->getResult();
            if(count($result)>0){
                $modelUser = new Muser;
                $datos_correo = $modelUser -> getDatosCorreo();
                $config['SMTPHost'] =  $datos_correo->smtp_server;
                $config['SMTPUser'] = $datos_correo->email_server;
                $config['SMTPPass']  = $datos_correo->pass_server;
                $config['SMTPPort'] = $datos_correo->puerto_server;
                
              

                $email = \Config\Services::email();
                $email->initialize($config);
                $email->setTo($mail);
                if(count($bcc)>0){
                    $email->setBCC($bcc);
                }
                $email->setFrom($datos_correo->send_email, $datos_correo->descripcion);
                $email->setSubject('Inventario y clasificación de activo');
                $email->setMessage(
                   view('mail/register_inventario_clasificacion_activo',[
                    'data'=>$result[0]
                    ])
                );
                $valor = $email->send();
                return $email;
            }
            return false;
        } catch (\Throwable $th) {
            log_message('error',$th->getMessage()." linea ".$th->getLine()." file ".$th->getFile());
            return false;
        }
        
    }

    public function getValorByValoraciones($data){
        try {
            $sql = "call sp_get_valor_combinacion_valoracion(?,?,?)";
            $result = $this->db->query($sql,[
                $data['val_c'],
                $data['val_i'],
                $data['val_d'],
            ])->getResultArray();
            
            return $result;
        } catch (\Throwable $th) {
            log_message('error',$th->getMessage()." linea ".$th->getLine()." file ".$th->getFile());
            return false;
        }
    }
    public function listByValoraciones($data){
        try {
            $sql = "call sp_list_ica_by_valoracion(?,?,?)";
            $result = $this->db->query($sql,[
                $data['nom_val1'],
                $data['nom_val2'],
                $data['nom_val3'],
            ])->getResultArray();
            return $result;
        } catch (\Throwable $th) {
            log_message('error',$th->getMessage()." linea ".$th->getLine()." file ".$th->getFile());
            return false;
        }
    }

    public function update_valor_ica($id,$data){
        try {
            $sql = "call update_valor_ica(?,?)";
            $result = $this->db->query($sql,[
                $id,
                $data['id_valor_val']
            ]);
            if($result){
               
                return true;
            }
            return false;
        } catch (\Throwable $th) {
            log_message('error',$th->getMessage()." linea ".$th->getLine()." file ".$th->getFile());
            return false;
        }
    }
    public function update_estado_ica($id,$data){
        try {
            $sql = "call update_status_ica(?,?,?,?)";
            $result = $this->db->query($sql,[
                $id,
                $data['estado'],
                $data['date_modify'],
                $data['id_user_updated'],
            ]);
            if($result){
                $ica = $this->getById($id);
                if($ica[0]['estado'] == '3' || $ica[0]['estado'] == '4'){
                    $mUser = new Muser();
                    $user = $mUser->getUserbyId($ica[0]['id_user_added']);
                    $this->sendMail($id,$user->email_us);
                }
                //aqui agegare logica
                if($ica[0]['estado'] == '2'){
                    // return $data;
                    //recuperar el correo del usuario?
                    $mUser = new Muser();
                    $user = $mUser->getUserbyId($ica[0]['id_user_added']);
                    $usersbyarea = $mUser->getUserByAreaBCC($ica[0]['idarea']);
                    $bcc = array(
                      
                    );
                    foreach ($usersbyarea as $item) {
                        array_push($bcc,$item['email_us']);
                    }
    
                    $response = $this->sendMail($id,$user->email_us,$bcc);
                    return $response;
                }
                return true;
            }
            return false;
        } catch (\Throwable $th) {
            log_message('error',$th->getMessage()." linea ".$th->getLine()." file ".$th->getFile());
            return false;
        }
    }

    public function validateModify($id,$data){
        $sql = "call sp_validate_inventario_modify(?,?,?)";
        $query = $this->db->query($sql,[
            $id,
            $data['activo'],
            $data['idempresa']
        ]);
        return $query->getResultArray();
    }

    public function getAllInventario(){
        $sql = "call sp_list_inventario_clasificacion_activo_all()";
        $result = $this->db->query($sql,[])->getResultArray();
        return $result;
    }

    public function updateVals($data,$id){
        $sql = "call sp_update_vals(?,?)";
        $result = $this->db->query($sql,[$data,$id]);
        return true;
    }
 
    public function deleteInventarioClasificacionActivo($valor,$id){ 
        $sql = "CALL eliminar_general(?)";
        // $valor = 'macroproceso';
        $query = $this->db->query($sql, [$valor]);
        // aqui obtenermos los nombres de las tablas ralacionadas
        $tablas = $query->getResultArray();
        $resultado=false;
        $cont_tablas=0;
        // $id=20;
        foreach ($tablas as $key => $value) {
          
            $sql2 = "CALL consulta_eliminar_general(?,?,?)";
          

            $query2 = $this->db->query($sql2,[
                $valor,
                $value['TABLE_NAME'],
                $id
            ]);
            $resultado = $query2->getResultArray();
            if($resultado){
               
                $cont = 0;
                foreach ($resultado as $key => $value) {
                    if($value['is_deleted'] == 1){
                       
                        $cont++;
                    }

                 }
                if($cont == count($resultado)){
               
                    $cont_tablas ++ ;
                }
            }else{
                $cont_tablas ++ ;
            }
         
           
        }
        if($cont_tablas == count($tablas)){
            return true;
       
        }else{
            return false;
       
        }

    }
}