<?php

namespace App\Models;

use CodeIgniter\Model;

class MaspectoSeg extends Model
{
    protected $table            = 'aspectos_seguridad';
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
    public function validaAspectoSeg($data){
      
        // $query = $this->db->query("SELECT * FROM aspectos_seguridad 
        // where aspecto='{$data}' where is_deleted=0");

        $sql = "CALL validaAspecto(?)";
        $query = $this->db->query($sql, [
            $data
        ]);
        if( $query->getRow()) return true;
        else return false;
    } 
    public function validateAspectoSegModify($data){
          
        // $query = $this->db->query("SELECT * from empresa  
        // where empresa ='{$data['empresa']}' and is_deleted=0;");
        $sql = "CALL sp_validate_aspecto_modify(?,?)";

        $query = $this->db->query($sql, [
        
            $data[0]['id'],
            $data[0]['aspecto'],
              
        ]);
        return $query->getResultArray();

    }
    public function getAspectoSeg(){

       
        // $query = $this->db->query("EXEC listarAspecto");
        $sql = "CALL listarAspecto()";
        $query = $this->db->query($sql, [
         
        ]);
        return $query->getResultArray();
    }
    
    public function saveAspectoSeg($data){
       
        // $query = $this->db->query("EXEC agregar_aspecto
        // @aspecto = '{$data[0]['aspecto']}',
        // @estado= {$data[0]['estado']},
        // @idUserAdd= {$data['user']}");

        $sql = "CALL agregar_aspecto(?,?,?)";
        $query = $this->db->query($sql, [
            $data[0]['aspecto'],
            $data[0]['estado'],
            $data['user'],
           
        ]);
        return $query;
    }
    public function updateAspectoSeg($data){
              
      
        // $query = $this->db->query("EXEC editar_aspecto
        // @aspecto = '{$data[0]['aspecto']}',
        // @idaspecto = '{$data[0]['id']}',
        // @estado= {$data[0]['estado']},
        // @idUserAdd= {$data['user']}");

        $sql = "CALL editar_aspecto(?,?,?,?)";
        $query = $this->db->query($sql, [
            $data[0]['aspecto'],
            $data[0]['id'],
            $data[0]['estado'],
            $data['user'],
           
        ]);
        return $query;
    }
 

    public function getAspectoByActivo(){

       
        // $query = $this->db->query("EXEC getAspectoByActivo");
        $sql = "CALL getAspectoByActivo()";
        $query = $this->db->query($sql, [
         
        ]);
        return $query->getResultArray();
    }
}