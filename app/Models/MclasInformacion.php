<?php

namespace App\Models;

use CodeIgniter\Model;

class MclasInformacion extends Model
{
    protected $table = 'clasificacion_informacion';
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
    public function validarClasInfo($data){
            
       
           $sql = "CALL validaClasInfo(?)";

           $query = $this->db->query($sql, [
             $data
           ]);

            if( $query->getRow()) return true;
            else return false;
    }
    public function validateClasInformacionModify($data){
          
        
        $sql = "CALL sp_validate_clasi_info_modify(?,?)";

        $query = $this->db->query($sql, [
        
            $data[0]['id'],
            $data[0]['clasificacion'],
          
        ]);
        return $query->getResultArray();

    }
    public function getClasInformacion(){

      
        // $query = $this->db->query("EXEC listarclasinfo");
        $sql = "CALL listarclasinfo()";

        $query = $this->db->query($sql, [
        
        ]);
        return $query->getResultArray();
    }
    public function saveClasInformacion($data){       

     

        $sql = "CALL agregar_clasinfo(?,?,?,?)";

         $query = $this->db->query($sql, [
            $data[0]['clasificacion'],
            $data[0]['descripcion'],
            $data[0]['estado'],
            $data['user']
         ]);
        return $query;

    }
    public function updateClasInformacion($data){  
        
      
         $sql = "CALL editar_clasinfo(?,?,?,?,?)";

         $query = $this->db->query($sql, [
            $data[0]['id'],
            $data[0]['clasificacion'],
            $data[0]['descripcion'],
            $data[0]['estado'],
            $data['user']
         ]);
        return $query;
    }

    public function getClasInfoByActivo(){

      
        // $query = $this->db->query("EXEC listarclasinfo");
        $sql = "CALL listarclasinfoByActivo()";

        $query = $this->db->query($sql, [
        
        ]);
        return $query->getResultArray();
    }
 
}