<?php

namespace App\Models;

use CodeIgniter\Model;

class Mperfil extends Model
{
    protected $table = 'tb_perfiles';
    protected $primaryKey       = 'id_perfil';
    protected $useSoftDeletes   = false;
    // Dates
    protected $useTimestamps = true;
    protected $dateFormat    = 'datetime';
    protected $createdField  = 'date_add';
    protected $updatedField  = 'date_modify';
    protected $deletedField  = 'date_deleted';
    protected $allowedFields    = [
        'id_perfil',
        'date_add',
        'date_modify',
        'date_deleted',
        'id_user_added',
        'id_user_modify',
        'id_user_deleted',
        'is_deleted'
    ];
    public function lastIdPerfil(){
        $maxID = $this->db->query('SELECT MAX(id_perfil) as maxid FROM tb_perfiles');
    
        return $maxID->getRow()->maxid;
    }
    //buscar pefil por id
    /*public function getPerfilById($data){
       
        $consulta ="SELECT * FROM  tb_perfiles where id_perfil={$data}"; 
        $query = $this->db->query($consulta);
        return $query->getRow();
    }
*/
    public function getPerfilById($perfil_id){
        $sql = "CALL getPerfilById(?)";
        $result = $this->db->query($sql, [$perfil_id]);
        return $result->getRow();
    }

    /*
    public function getUserbyIdPerfil($data){
       
        $consulta ="SELECT * FROM  tb_perfiles as TP inner join tb_users as TU on TU.perfil_us = TP.id_perfil where TU.id_us={$data}"; 
        $query = $this->db->query($consulta);
        return $query->getRow();
    }*/

    public function getUserbyIdPerfil($usuario_id) {
        $sql = "CALL obtenerUsuarioPorIdPerfil(?)";
        $result = $this->db->query($sql, [$usuario_id]);
        return $result->getRow();
    }

    //retorna todos los perfiles
    public function getPerfiles($data){
        $consulta = "";
        if($data['estado'] =='all'){ $consulta="SELECT * FROM  tb_perfiles where is_deleted=0";
        }else{ $consulta ="SELECT * FROM  tb_perfiles where est_perfil='{$data['estado']}'  and is_deleted=0"; }
        $query = $this->db->query($consulta);
        return $query->getResultArray();
    }
    /*
    public function validaPerfil($data){
      
        $query = $this->db->query("SELECT * FROM tb_perfiles where perfil='{$data}' AND is_deleted=0");
        $query->getRow();
        if( $query->getRow()) return true;
        else return false;
    }
    */
    public function validaPerfil($data) {
        $sql = "CALL obtenerPerfilPorNombre(?)";
        $query = $this->db->query($sql, [$data]);
        $result = $query->getRow();
    
        if ($result) {
            return true;
        } else {
            return false;
        }
    }
    
    public function validatePerfilModify($data){
          
        // $query = $this->db->query("SELECT * from empresa  
        // where empresa ='{$data['empresa']}' and is_deleted=0;");
        $sql = "CALL sp_validate_perfil_modify(?,?)";

        $query = $this->db->query($sql, [
            $data['id_perfil'],
            $data['perfil'],
          
        ]);
        return $query->getResultArray();

    }
    //agregar el perfil
    public function savePerfil($data){
        // return $data;
        
        $creacion_perfil = date('Y-m-d H:i:s');
    
        $query=$this->db->query("INSERT INTO tb_perfiles
        (perfil,desc_perfil,est_perfil,creacion_perfil,is_user_negocio) VALUES
        ('{$data['perfil']}','{$data['desc_perfil']}',
        '{$data['est_perfil']}','{$creacion_perfil}','{$data['evaluador']}'); ") ;
    
    
        return $query;
    }
    public function updatePerfil($data){
      
        $actualizacion_perfil = date('Y-m-d H:i:s');
        $query=$this->db->query("UPDATE tb_perfiles SET 
        perfil = '{$data['perfil']}',
        desc_perfil = '{$data['desc_perfil']}',
        est_perfil= '{$data['est_perfil']}',
        actualizacion_perfil='{$actualizacion_perfil}',
        is_user_negocio = '{$data['evaluador']}'
        where id_perfil = {$data['id_perfil']} ") ;
           
        return $query;
    }
   
    //detalle perfiles}
    /*public function getDetPerfil($data){

        $query = $this->db->query("SELECT * from tb_perfiles
         where id_perfil={$data['id_perfil']}" );
        return $query->getRow();
    }*/

    public function getDetPerfil($data){
        $query = $this->db->query("CALL getDetPerfil(?)", [$data['id_perfil']]);
        return $query->getRow();
    }
    

    //datos para detalle perfil par ael log
    public function getDetPerById($data) {
        $query = $this->db->query("CALL obtenerDetPerById(?)", [$data]);
        return $query->getRow();
    }
/*    
    public function getDetPerById($data){

        $query = $this->db->query("SELECT * from tb_detalle_perfil  as DP inner join tb_perfiles as TP
        on DP.id_perfil=TP.id_perfil
         where id_det_per={$data}" );

        return $query->getRow();
    }
   */
    //permisos de usuario segun rol
    /*public function getPermisos($id){

        $query = $this->db->query("SELECT * from tb_detalle_perfil as TDP inner join tb_perfiles as TP on TDP.id_perfil=TP.id_perfil
         where TDP.id_perfil={$id}  and TP.est_perfil=1 order by id_det_per ASC" );
        return $query->getResultArray();
    }
*/
    public function getPermisos($id) {
        $sql = "CALL obtenerPermisos(?)";
        $result = $this->db->query($sql, [$id]);
        return $result->getResultArray();
    }

    /*
    public function getPermisosByPerfil($data){

        $query = $this->db->query("SELECT * from tb_detalle_perfil as TDP inner join tb_perfiles as TP
        on TDP.id_perfil=TP.id_perfil inner join tb_item as TI on TI.id_item = TDP.id where TP.perfil='{$data['perfil'] }' and
		TDP.tabla='tb_item' and TI.desc_item='{$data['opcion'] }' and TP.est_perfil=1 order by TDP.id_det_per ASC" );
        return $query->getRow();
    }
*/
    public function getPermisosByPerfil($data){
        $perfil = $data['perfil'];
        $opcion = $data['opcion'];
       // $query = $this->db->query("CALL obtenerPermisosPorPerfil('$perfil', '$opcion')");
        $sql = "CALL obtenerPermisosPorPerfil(?,?)";
        $result = $this->db->query($sql, [
            $perfil,
            $opcion
        ]);
        return $result->getRow();
    }
    /*
    //agregar el detalle de perfil
    public function saveDetPerfil($data){
      

        $query=$this->db->query("INSERT INTO tb_detalle_perfil
        (id_perfil,tabla,id,view_det,create_det,update_det,delete_det) VALUES
        ('{$data['id_perfil']}','{$data['tabla']}',
        '{$data['id']}',0,0,0,0); ") ;
    
    
        return $query;
    }
*/
    public function saveDetPerfil($data) {
        $sql = "CALL insertarDetallePerfil(?, ?, ?)";
        $params = array($data['id_perfil'], $data['tabla'], $data['id']);
        $query = $this->db->query($sql, $params);
        return $query;
      }
    /*  
    public function updateDetPer($data,$column){
      
        $query=$this->db->query("UPDATE tb_detalle_perfil SET 
        {$column} = {$data['estado']}
        where id_det_per = {$data['id_op']} ") ;
           
        return $query;
    }
*/
    public function updateDetPer($data, $column) {
        $query = $this->db->query("CALL actualizarDetPer({$data['id_op']}, {$data['estado']}, '{$column}')");
        return $query;
    }
    
    //obtener opcion segun id
    public function getPerfilOpcion($tabla,$data){
        $id = 'id_mod'; $op='mod';
        if($tabla == 'tb_opcion') {$id='id_op'; $op='op';}  
        if($tabla == 'tb_item') {$id='id_item'; $op='item';} 

        $query=$this->db->query("SELECT desc_{$op} as opcion FROM  {$tabla} where {$id} = {$data} ") ;
           
        return $query->getRow();
    }
    /*
    public function getModulo($data){
        
        $query = $this->db->query("SELECT * FROM tb_detalle_perfil as DP inner join tb_modulo as TM on DP.id=TM.id_mod 
        where DP.tabla='tb_modulo' and DP.id_perfil={$data['id_perfil']}" );
        return $query->getResultArray();

    }
*/
    public function getModulo($data){
        $query = $this->db->query("CALL obtenerModulosPerfil({$data['id_perfil']})");
        return $query->getResultArray();
    }
    
/*
    public function getAllModulos(){
        
        $query = $this->db->query("SELECT * FROM tb_modulo" );
        return $query->getResultArray();

    }
*/
    public function getAllModulos(){
        
        $query = $this->db->query("CALL getAllModulos()");
        return $query->getResultArray();

    }

   /*

    public function getOpcion($data){
        
        $query = $this->db->query("SELECT * from tb_detalle_perfil as DP inner join tb_opcion as T on DP.id=T.id_op 
        where DP.tabla='tb_opcion' and DP.id_perfil={$data['id_perfil']}" );
        return $query->getResultArray();

    }
*/
    public function getOpcion($data){
        $sql = "CALL get_opcion(?)";
        $query = $this->db->query($sql, [
            $data['id_perfil'],
        ]);
      
        // $result = $query->getResultArray();
        return $query->getResultArray();

    }
/*
    public function getAllOpciones(){
        
        $query = $this->db->query("SELECT * FROM tb_opcion" );
        return $query->getResultArray();

    }
*/
    public function getAllOpciones(){
        $query = $this->db->query("CALL get_all_opciones()");
        return $query->getResultArray();
    }
    /*
    public function getItem($data){
        
        $query = $this->db->query("SELECT * FROM tb_detalle_perfil as DP 
        inner join tb_item as TI on DP.id=TI.id_item where DP.tabla='tb_item' and DP.id_perfil={$data['id_perfil']} order by TI.id_op,TI.id_item ASC;" );
        return $query->getResultArray();

    }*/
    public function getItem($data){
        $query = $this->db->query("CALL get_item({$data['id_perfil']})");
        return $query->getResultArray();
    }

    /*
    public function getAllItems(){
        
        $query = $this->db->query("SELECT * FROM tb_item order by id_op ASC" );
        return $query->getResultArray();

    }*/

    public function getAllItems(){
        $query = $this->db->query("CALL getAllItems()");
        return $query->getResultArray();
    }
    

    public function getDetallePerfil(){
        $sql = "call sp_get_detalle_perfil_to_reporte()";
        $query = $this->db->query($sql);
        return $query->getResultArray();
    }
}

