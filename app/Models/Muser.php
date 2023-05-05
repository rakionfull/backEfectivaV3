<?php

namespace App\Models;

use CodeIgniter\Model;

class Muser extends Model
{
    protected $table            = 'tb_users';
    protected $primaryKey       = 'id_us';
    protected $useSoftDeletes   = false;
    // Dates
    protected $useTimestamps = true;
    protected $dateFormat    = 'datetime';
    protected $createdField  = 'date_add';
    protected $updatedField  = 'date_modify';
    protected $deletedField  = 'date_deleted';
    protected $allowedFields    = [
        'id_us',
        'date_add',
        'date_modify',
        'date_deleted',
        'id_user_added',
        'id_user_updated',
        'id_user_deleted',
        'is_deleted'
    ];
/*
    public function saveUser($data){
      
        
        $creacion_us = date('Y-m-d H:i:s');
        $estado_us = '1';
        $change_pass = '0';
      
        $query=$this->db->query("INSERT INTO tb_users 
        (docident_us,nombres_us,apepat_us,apemat_us,email_us,
        usuario_us,creacion_us,estado_us,bloqueo_us,change_pass,perfil_us,idempresa,idposicion,idarea,idunidad) VALUES
        ('{$data['docident_us']}','{$data['nombres_us']}',
        '{$data['apepat_us']}','{$data['apemat_us']}',
        '{$data['email_us']}','{$data['usuario_us']}',
        '{$creacion_us}','{$estado_us}',0,'{$change_pass}','{$data['perfil_us']}',
        '{$data['id_empresa']}','{$data['id_puesto']}','{$data['id_area']}','{$data['id_unidad']}'); ") ;
         
        return true;

    }
*/

public function saveUser($data){
    // $query = $this->db->query("CALL sp_save_users(
    //     '{$data['docident_us']}',
    //     '{$data['nombres_us']}',
    //     '{$data['apepat_us']}',
    //     '{$data['apemat_us']}',
    //     '{$data['email_us']}',
    //     '{$data['usuario_us']}',
    //     {$data['perfil_us']},
    //     {$data['id_empresa']},
    //     {$data['id_puesto']},
    //     {$data['id_area']},
    //     {$data['id_unidad']},
    //     0,
    //     1,
    //     @result
    // )");
    $query = $this->db->query("CALL sp_save_users(?,?,?,?,?,?,?,?,?,?,?)", [
        $data['docident_us'],
        $data['nombres_us'],
        $data['apepat_us'],
        $data['apemat_us'],
        $data['email_us'],
        $data['usuario_us'],
        $data['perfil_us'],
        $data['id_empresa'],
        $data['id_puesto'],
        $data['id_area'],
        $data['id_unidad'],
    ]);

    // $result = $this->db->query('SELECT @result AS result')->getRowArray()['result'];
    return true;
}




    public function lastid(){
     
        $maxID = $this->db->query('SELECT @@identity as maxid FROM tb_users');

        return $maxID->getRow()->maxid;
    }
 /*   
    public function savePass($data){
       
        $creacion_cl = date('Y-m-d H:i:s');
        $expiracion_cl = time() + (24*3600*45);
        $query=$this->db->query("INSERT INTO tb_historial_claves 
        (pass_cl,id_us,creacion_cl,expiracion_cl) VALUES
        ('{$data['pass_cl']}','{$data['id_us']}',
        '{$creacion_cl}','{$expiracion_cl}'); ") ;
    
    
        return $query;
    }
*/


    public function savePass($data){
       
        $creacion_cl = date('Y-m-d H:i:s');
        $expiracion_cl = time() + (24*3600*45);
        $query=$this->db->query("INSERT INTO tb_historial_claves 
        (pass_cl,id_us,creacion_cl,expiracion_cl) VALUES
        ('{$data['pass_cl']}','{$data['id_us']}',
        '{$creacion_cl}','{$expiracion_cl}'); ") ;
    
    
        return $query;
    }



/*
    public function getUser($username){

        $Usuario = $this->db->query("SELECT * FROM  tb_users as TU INNER JOIN tb_historial_claves AS TH
        on TU.id_us=TH.id_us WHERE TU.usuario_us= '{$username}'  ORDER BY TH.id_cl DESC LIMIT 1");
       
        return $Usuario->getRow();
    }
*/
public function getUser($username) {
    $query = $this->db->query("CALL sp_get_user_with_last_password(?)", [$username]);
    return $query->getRow();
}
   /*
    public function getPass($idPost){

        $query = $this->db->query("SELECT * FROM  tb_users as TU INNER JOIN tb_historial_claves AS TH
        on TU.id_us=TH.id_us WHERE TU.id_us= {$idPost} ORDER BY TH.id_cl DESC LIMIT 10");
       
        return $query->getResultArray();
    }
*/
    public function getPass($idPost) {
        $query = $this->db->query("CALL sp_get_user_history(?)", [$idPost]);
        return $query->getResultArray();
    }
/*
    public function getUserbyId($id){

        $Usuario = $this->db->query("SELECT * FROM  tb_users as TU INNER JOIN tb_historial_claves AS TH
        on TU.id_us=TH.id_us WHERE TU.id_us= '{$id}' ORDER BY TH.id_cl DESC LIMIT 1");
       
        return $Usuario->getRow();
    }
*/
    public function getUserbyId($id){
        $query = $this->db->query("CALL sp_get_user_last_password_byid(?)", [$id]);
        return $query->getRow();
    }
/*    
    public function getUserUpdate($id){

        $Usuario = $this->db->query("SELECT * FROM  tb_users as TU WHERE TU.id_us= '{$id}'");
       
        return $Usuario->getRow();
    }
*/
    public function getUserUpdate($id){
        $query = $this->db->query("CALL sp_get_user_by_id(?)", [$id]);
      
        return $query->getRow();
    }


    public function getUserByDatos($username){

        $sql = "CALL getUserByDatos(?)";

		$result = $this->db->query($sql, [$username]);

        //$Usuario = $this->db->query("CALL getUserByDatos user = {$username}");
       
        return $result->getRow();
    }

   /*
    public function changePass($data){
        // return $data;
        $query=$this->db->query("UPDATE tb_users SET change_pass = 1 
        where id_us = $data") ;
            
        return $query;
    }
*/
    public function changePass($data){
        // return $data;
        $query = $this->db->query("CALL sp_change_pass(?)", [$data]);
       
        return $query;
    }


    //retorna todos los usuarios
    public function getUsers($data){
        $consulta = "";
   
        if($data['estado'] == 'all') {
            $consulta = "SELECT  *,TU.id_us as id,(select loged from tb_sesiones where id_us=TU.id_us  ORDER BY loged DESC LIMIT 1) as loged
             FROM tb_users as TU where TU.is_deleted=0 ORDER BY TU.id_us;";
        }
        else { $consulta = "SELECT  *,TU.id_us as id,(select loged from tb_sesiones where id_us=TU.id_us  ORDER BY loged DESC LIMIT 1) as loged FROM tb_users as TU  
            where TU.estado_us={$data['estado'] } and TU.is_deleted=0 ORDER BY TU.id_us;"; }

        $Usuario = $this->db->query($consulta);
        return $Usuario->getResultArray();
    }

   /*
    //actualiza el usuario
    public function updateUser($data,$id){
      
        $actualizacion_us = date('Y-m-d H:i:s');
        $query=$this->db->query("UPDATE tb_users SET nombres_us = '{$data['nombres_us']}', docident_us = '{$data['docident_us']}',
        apepat_us = '{$data['apepat_us']}',apemat_us= '{$data['apemat_us']}',perfil_us= '{$data['perfil_us']}',
        estado_us= '{$data['estado_us']}',
        email_us= '{$data['email_us']}' ,actualizacion_us='{$actualizacion_us}',idempresa='{$data['id_empresa']}'
        ,idarea='{$data['id_area']}',idposicion='{$data['id_puesto']}',idunidad='{$data['id_unidad']}'
       
        where id_us = {$id} ") ;
           
        return $query;
        // idarea='{$data['id_area']}',idposicion='{$data['id_puesto']}',idunidad='{$data['id_unidad']}'
    }
*/
    public function updateUser($data,$id){
      
        $query = $this->db->query("CALL sp_update_user('{$data['nombres_us']}', '{$data['docident_us']}', '{$data['apepat_us']}', 
                            '{$data['apemat_us']}', '{$data['perfil_us']}', '{$data['estado_us']}', '{$data['email_us']}', 
                            '{$data['id_empresa']}', '{$data['id_area']}', '{$data['id_puesto']}', '{$data['id_unidad']}', '{$id}')");

        return $query;
    }
/*
        //actualiza solo el estado 
    public function updateEstadoUser($data){
        // $query=$this->db->query("UPDATE tb_users SET 
        // estado_us= '{$data['estado_us']}'
        // where id_us = {$data['id_us']} ") ;
           $query=$this->db->query("UPDATE tb_users SET 
           bloqueo_us= '{$data['estado_us']}',
           intentos_us = 1
           where id_us = {$data['id_us']} ") ;
        return $query;
    }
*/
    public function updateEstadoUser($data){
        $query=$this->db->query("CALL sp_update_user_estado({$data['id_us']}, {$data['estado_us']})");
        return $query;
    }

    // public function deleteUser($id){
    //     $this->db->query("DELETE FROM tb_historial_claves
    //     where id_us = {$id} ") ;
    //     $query=$this->db->query("DELETE FROM tb_users
    //     where id_us = {$id} ") ;
    //     return $query;
    // }
/*    public function findUser($username){

        $Usuario = $this->db->query("SELECT  * FROM  tb_users where usuario_us= '{$username}' ");
       
        return $Usuario->getRow();
    }
    */

    public function findUser($username){

        $query = $this->db->query("CALL sp_find_user('$username')");

        return $query->getRow();
    }

    public function getIntento($username){
        $Usuario = $this->db->query("SELECT  intentos_us,bloqueo_time,bloqueo_us FROM  tb_users where usuario_us= '{$username}' ");
   
    return $Usuario->getRow();
    }
/*
    public function setIntento($username,$intento){
        $newIntento = $intento + 1 ;
        $Usuario = $this->db->query("UPDATE  tb_users SET intentos_us= $newIntento where usuario_us= '{$username}' ");
       
        return $Usuario;
    }
*/
    public function setIntento($username,$intento){
        $newIntento = $intento + 1;
        $this->db->query("CALL sp_update_intentos('$username','$newIntento')");
    }
/*
    public function setTimeIntento($username){
        // $time =  time() + 60*2;
       // $Usuario = $this->db->query("UPDATE  tb_users SET bloqueo_time= $time  where usuario_us= '{$username}' ");
        $Usuario = $this->db->query("UPDATE  tb_users SET bloqueo_us=1  where usuario_us= '{$username}' ");
       
        return $Usuario;
    }
*/
    public function setTimeIntento($username){
        $query = $this->db->query("CALL sp_set_time_intento('{$username}')");
        return $query;
    }

    //reportes
    public function getCamposUser(){
        $consulta = "SELECT COLUMN_NAME
        FROM Information_Schema.Columns
        WHERE TABLE_NAME = 'tb_users'
        ORDER BY COLUMN_NAME";
        $Usuario = $this->db->query($consulta);
        return $Usuario->getResultArray();
    }
    public function getDatosUser(){
        $consulta = "SELECT TU.usuario_us,TU.docident_us,TU.nombres_us, TU.apepat_us,TU.apemat_us,TP.perfil,TU.creacion_us,
        IF(TU.estado_us=1, 'Activo', 'Inactivo') as estado, IF(bloqueo_us=0, 'Desbloqueado', 'Bloqueado') as bloqueo,
        (SELECT last_activity FROM tb_sesiones WHERE id_us = TU.id_us ORDER by last_activity DESC LIMIT 1 ) AS ultimo_acceso
         FROM tb_users as TU inner join tb_perfiles as TP on TU.perfil_us=TP.id_perfil; ";
        $Usuario = $this->db->query($consulta);
        return $Usuario->getResultArray();
    }
    /*
    public function getUserByActivo(){

        $query = $this->db->query("SELECT * FROM tb_users where estado_us='1'");
        return $query->getResultArray();
    }
*/
public function getUserByActivo(){

    $query = $this->db->query("CALL get_users_activos()");
    return $query->getResultArray();
}
 /*
    public function getUserByEmpresa($data,$data1){

        $query = $this->db->query("SELECT * FROM tb_users where estado_us='1' and idempresa={$data} and idarea={$data1}");
        return $query->getResultArray();
    }
*/
    public function getUserByEmpresa($data,$data1,$data2,$data3){

        $query = $this->db->query("CALL get_user_by_empresa($data, $data1,$data2,$data3)");
    return $query->getResultArray();
    }
/*
    public function getUserByArea($id_area){

        $query = $this->db->query("SELECT * FROM tb_users where estado_us='1' and idarea={$id_area}");
        return $query->getResultArray();
    }*/

    public function getUserByArea($id_area){

        $query = $this->db->query("CALL getUserByArea($id_area)");
    return $query->getResultArray();
    }
/*
    public function getUserNombreByActivo(){

        $query = $this->db->query("SELECT * FROM tb_users where estado_us='1'");
        return $query->getResultArray();
    }
*/
    public function getUserNombreByActivo(){

        $query = $this->db->query("CALL getUserNombreByActivo()");
    return $query->getResultArray();
    }

    
/*
    public function getEscenario(){
        $query = $this->db->query("SELECT escenario FROM escenario_active");
        return $query->getRow()->escenario;
        // return $queryc->escenario;
    }
*/
    
    public function getEscenario(){
        $query = $this->db->query("CALL getEscenario()");
        return $query->getRow()->escenario;
    }

    //reporte Seguridad
    public function dataReporteSeguridad($data){
        // $consulta = "SELECT TU.usuario_us,TU.docident_us,TU.nombres_us, TU.apepat_us,TU.apemat_us,TP.perfil,TU.creacion_us,
        // IF(TU.estado_us=1, 'Activo', 'Inactivo') as estado, IF(bloqueo_us=0, 'Desbloqueado', 'Bloqueado') as bloqueo,
        // (SELECT last_activity FROM tb_sesiones WHERE id_us = TU.id_us ORDER by last_activity DESC LIMIT 1 ) AS ultimo_acceso
        //  FROM tb_users as TU inner join tb_perfiles as TP on TU.perfil_us=TP.id_perfil; ";
        // $Usuario = $this->db->query($consulta);
        $fecha_fin= (date("Y-m-d",strtotime($data['fecha_fin']."+ 1 days"))); 
        $query = $this->db->query("CALL dataReporteSeguridad('{$data['fecha_ini']}','{$fecha_fin}')");
        return $query->getResultArray();
    }

   

}

