<?php

namespace App\Models;

use CodeIgniter\Model;

class MriesgoPlanAccion extends Model
{
    protected $table            = 'plan_accion';
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
    //funciones para el envio de correo
    public function getCorreoPlan(){
    
        $sql = "call getCorreoPlan()";

        $query = $this->db->query($sql, [
        ]);
        return $query->getResultArray();
    }
    public function getCorreoActividad(){
        
    
        $sql = "call getCorreoActividad()";

        $query = $this->db->query($sql, [
        ]);
        return $query->getResultArray();
    }
    public function getCorreoPlanEnviados($id){
        
     
        $sql = "call getCorreoPlanEnviados(?)";

        $query = $this->db->query($sql, [
            $id
        ]);
        return $query->getRow();
    }
    public function getCorreoActividadesEnviados($id){
        
     
        $sql = "call getCorreoActividadesEnviados(?)";

        $query = $this->db->query($sql, [
            $id
        ]);
        return $query->getRow();
    }
    public function insertCorreoPlan($id,$fecha,$usuario){
   

        $sql = "call insertCorreoPlan(?,?,?)";
        $query = $this->db->query($sql, [
            $id,
            $fecha,
            $usuario
        ]);
        return $query;
    }
    public function updateEstadoPLan($id){
        
      
        $sql = "call updateEstadoPLan(?)";
        $query = $this->db->query($sql, [
            $id,
            
        ]);

        return $query;
    }
    public function insertCorreoActividad($id,$fecha,$usuario){
        
   
        $sql = "call insertCorreoActividad(?,?,?)";
        $query = $this->db->query($sql, [
            $id,
            $fecha,
            $usuario
        ]);
        return $query;
    }

    ////
    public function validaPlanAccion($data){
        
      

        $sql = "CALL validaPlanAccion(?)";

        $query = $this->db->query($sql, [ 
            $data['plan_accion']  
        ]);

        
        if( $query->getRow()) return true;
        else return false;
    }

    public function validaPlanAccionModify($data){
        
      

        $sql = "CALL sp_validate_plan_accion_modify(?,?)";

        $query = $this->db->query($sql, [ 
            $data[0]['id']  ,
            $data[0]['plan_accion']  
        ]);

        
        return $query->getResultArray();
    }
    public function getPlanAccion(){

     
        $sql = "CALL listar_plan_accion()";

        $query = $this->db->query($sql, [ ]);
        return $query->getResultArray();
    }
    public function sendMail($iduser,$idplan,$mail,$idregistrador,$bcc = array()){
        try {
            //traer los datos para el correo plan de accion  +usuario responsable
            $sql = "call sp_get_info_to_email_plan(?,?)";
            $result = $this->db->query($sql,[
                $iduser,$idplan
            ])->getResult();
            if(count($result)>0){
                log_message('info','Aquie sta en pplan de accion');
                //primero debo actualizarel envio de correo en la tabla plan_correo

                // $fecha_alerta = date("Y-m-d", strtotime($result['fecha_inicio'])); 
                // $fecha_actual = date("Y-m-d");
                // // echo $fecha_actual;
                // // echo $fecha_alerta;
                // $fecha_fin = date("Y-m-d", strtotime($result['fecha_fin']));
                $fecha_actual = date("Y-m-d");



                $email = \Config\Services::email();
                $email->setTo($mail);
                if(count($bcc)>0){
                    $email->setBCC($bcc);
                }
                $email->setFrom('jbazant@valtx.pe', 'Plan de acción');
                $email->setSubject('Alerta de registro de plan de acción');
                $email->setMessage(
                    view('mail/plan_accion_registrado',[
                                                
                        'fullname' => $result[0]->nombres_us.' '.$result[0]->apepat_us.' '.$result[0]->apemat_us,
                        'plan' => $result[0]->plan_accion,
                        'estado' => 'Plan regitrado correctamente',
                        'inicio' => $result[0]->fecha_inicio,
                        'fin' => $result[0]->fecha_fin,
                        'alerta' => $result[0]->alerta
                    
                    ])
                );
                $valor = $email->send();
                if($valor){
                    // se ejecuta el registro de la alerta por primeravez
                    $insert = $this -> insertCorreoPlan($idplan,$fecha_actual,$idregistrador);
                    //cambiamos a en proceso
                    $update = $this -> updateEstadoPLan($idplan);
                }
                return $email;
            }
            return false;
            //return $iduser.$idplan.$email;
        } catch (\Throwable $th) {

            log_message('error',$th->getMessage()." linea ".$th->getLine()." file ".$th->getFile());
            return $th->getMessage();
        }
        
    }
    public function sendMailActividad($iduser,$idactividad,$mail,$idregistrador,$bcc = array()){
        try {
            //traer los datos para el correo plan de accion  +usuario responsable
            $sql = "call sp_get_info_to_email_actividad(?,?)";
            $result = $this->db->query($sql,[
                $iduser,$idactividad
            ])->getResult();
            if(count($result)>0){
                log_message('info','Aquie sta en actividad del plan');
                //primero debo actualizarel envio de correo en la tabla plan_correo

                // $fecha_alerta = date("Y-m-d", strtotime($result['fecha_inicio'])); 
                // $fecha_actual = date("Y-m-d");
                // // echo $fecha_actual;
                // // echo $fecha_alerta;
                // $fecha_fin = date("Y-m-d", strtotime($result['fecha_fin']));
                $fecha_actual = date("Y-m-d");



                $email = \Config\Services::email();
                $email->setTo($mail);
                if(count($bcc)>0){
                    $email->setBCC($bcc);
                }
                $email->setFrom('jbazant@valtx.pe', 'Actividad');
                $email->setSubject('Alerta de registro de actividad');
                $email->setMessage(
                    view('mail/actividad_registrado',[
                                                
                        'fullname' => $result[0]->nombres_us.' '.$result[0]->apepat_us.' '.$result[0]->apemat_us,
                        'plan' => $result[0]->plan_accion,
                        'actividad' => $result[0]->descripcion,
                        
                        'estado' => 'Actividad regitrado correctamente',
                        'inicio' => $result[0]->fecha_inicio,
                        'fin' => $result[0]->fecha_fin,
                        'alerta' => $result[0]->alerta
                    
                    ])
                );
                $valor = $email->send();
                if($valor){
                    // se ejecuta el registro de la alerta por primeravez
                    $insert = $this -> insertCorreoActividad($idactividad,$fecha_actual,$idregistrador);
                    //cambiamos a en proceso
                   // $update = $this -> updateEstadoPLan($idplan);
                }
                return $email;
            }
            return false;
            //return $iduser.$idplan.$email;
        } catch (\Throwable $th) {

            log_message('error',$th->getMessage()." linea ".$th->getLine()." file ".$th->getFile());
            return $th->getMessage();
        }
        
    }
    public function savePlanAccion($data){

        $sql = "CALL agregar_plan_accion(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

        $query = $this->db->query($sql, [
            $data[0]['id_riesgo'],
            $data[0]['id_control'],
            $data[0]['plan_accion'],
            $data[0]['descripcion'],
            $data[0]['fecha_inicio'],
            $data[0]['fecha_fin'],
            $data['user'],
            $data[0]['idempresa'],
            $data[0]['idarea'],
            $data[0]['idunidad'],
            $data[0]['idposicion'],
            $data[0]['idusuario'],
            $data[0]['idprioridad'],
            $data[0]['idestado'],
            $data[0]['idalerta'],
        
        ]);

        //aqui deberiamos enviar la alerta al registrarlo.
        // $mUser = new Muser();
        // $user = $mUser->getUserbyId($data['user']);

        // $this->sendMail($id,$user->email_us);

        

               
        $last_id = $this->db->query("SELECT  id as maxid FROM 
        plan_accion order by id DESC LIMIT 1");
        $last_id_plan= $last_id->getRow()->maxid;
        $mUser = new Muser();
        $user = $mUser->getUserbyId($data[0]['idusuario']);
        $bcc = array();
        $valor = $this->sendMail($data[0]['idusuario'],$last_id_plan,$user->email_us, $data['user'],$bcc);
        

        return $last_id_plan;
        //return $valor;
    }

   
    public function updatePlanAccion($data){

    
        $sql = "CALL modificar_plan_accion(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

        $query = $this->db->query($sql, [
            $data[0]['id'],
            $data[0]['plan_accion'],
            $data[0]['descripcion'],
            $data[0]['fecha_inicio'],
            $data[0]['fecha_fin'],
            $data[0]['idempresa'],
            $data[0]['idarea'],
            $data[0]['idunidad'],
            $data[0]['idposicion'],
            $data[0]['idusuario'],
            $data[0]['idprioridad'],
            $data[0]['idestado'],
            $data[0]['idalerta'],
            $data['user'],
            $data[0]['id_riesgo'],
            $data[0]['id_control'],
           
        ]);

        return $query;
    }


    public function deletePlanAccion($data){

   
        $sql = "CALL eliminar_plan_accion(?,?)";

        $query = $this->db->query($sql, [
            $data[0]['id'],
           
            $data['user'],
           
           
        ]);
        return $query;
    }



    
    public function getActividadesByPlan($idplan){
        $sql = "CALL getActividadesByPlan(?)";

	    $query = $this->db->query($sql, [
            $idplan
        ]);
        return $query->getResultArray();
    }
    public function getPlanByRiesgos($idplan){
        $sql = "CALL getPlanByRiesgos(?)";

	    $query = $this->db->query($sql, [
            $idplan
        ]);
        return $query->getResultArray();
    }


    //        Actividades del Plan

    public function getActividadPlan($id){


        $sql = "CALL listar_actividades_plan(?)";

        $query = $this->db->query($sql, [
            $id,         
           
        ]);
        
        return $query->getResultArray();
    }
    public function getDetallePlan($id){

      
        $sql = "CALL listar_detalle_plan(?)";

        $query = $this->db->query($sql, [
            $id,         
           
        ]);
        return $query->getRow();
    }
    public function getPlan($id){
       
        $sql = "CALL get_Plan_Control(?)";

        $query = $this->db->query($sql, [
            $id,         
           
        ]);
        return $query->getRow();
    }
 



    public function saveActividadPlan($data){
    
    

            $sql = "CALL agregar_actividades_plan(?,?,?,?,?,?,?,?,?,?,?,?)";

            $query = $this->db->query($sql, [
                $data['idempresa'],
                $data['idarea'],
                $data['idunidad'],
                $data['idposicion'],
                $data['idusuario'],
                $data['descripcion'],
                $data['fecha_inicio'],
                $data['fecha_fin'],
                $data['idalerta'],
                $data['progreso'],
                $data['user'],
                $data['idplanaccion'],
               
            ]);
            $last_id = $this->db->query("SELECT id as maxid FROM actividades_plan where id_planes={$data['idplanaccion']} order by id DESC LIMIT 1;");
            $last_id_plan= $last_id->getRow()->maxid;
            $mUser = new Muser();
            $user = $mUser->getUserbyId($data['idusuario']);
            $bcc = array();
            $valor = $this->sendMailActividad($data['idusuario'],$last_id_plan,$user->email_us, $data['user'],$bcc);

        return $valor;
    }
    
    public function updateActividadPlan($data){
       

            $sql = "CALL modificar_actividades_plan(?,?,?,?,?,?,?,?,?,?,?,?)";

            $query = $this->db->query($sql, [
                $data[0]['id'],
                $data[0]['idempresa'],
                $data[0]['idarea'],
                $data[0]['idunidad'],
                $data[0]['idposicion'],
                $data[0]['idusuario'],
                $data[0]['descripcion'],
                $data[0]['fecha_inicio'],
                $data[0]['fecha_fin'],
                $data[0]['idalerta'],
                $data[0]['progreso'],
               
                $data['user'],
             
            ]);

        return $query;
    }

    public function deleteActividadesPlan($data) {
       
    

        $sql = "CALL eliminar_actividades_plan(?,?)";

            $query = $this->db->query($sql, [
                $data[0]['id'],               
                $data['user'],
             
            ]);

        return $query;
    }
    



    

    

}