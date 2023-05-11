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
        $sql = "call sp_add_inventario_clasificacion_activo(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        $result = $this->db->query($sql,[
            $data['idempresa'],
            $data['idarea'],
            $data['idunidad'],
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
            $data['valores'],
            $data['idvaloracion_activo'],
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
                $usersbyarea = $mUser->getUserByArea($data['idarea']);
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
        $sql = "call sp_add_inventario_clasificacion_activo_historial(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        $result = $this->db->query($sql,[
            $id_ica,
            $data['idempresa'],
            $data['idarea'],
            $data['idunidad'],
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
            $data['valores']
        ]);
        if($result){
            return true;
        }
        return false;
    }

    public function edit($id,$data){
        $sql = "call sp_edit_inventario_clasificacion_activo(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        $result = $this->db->query($sql,[
            $id,
            $data['idempresa'],
            $data['idarea'],
            $data['idunidad'],
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
            $data['valores'],
            $data['idvaloracion_activo']
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
                    $usersbyarea = $mUser->getUserByArea($data['idarea']);
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
                //log_message('info','Aquie sta');
                $email = \Config\Services::email();
                $email->setTo($mail);
                if(count($bcc)>0){
                    $email->setBCC($bcc);
                }
                $email->setFrom('jbazant@valtx.pe', 'Inventario Clasificacion Activo registrado');
                $email->setSubject('Inventario Clasificacion Activo registrado');
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
 
}