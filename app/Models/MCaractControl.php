<?php

namespace App\Models;

use CodeIgniter\Model;

class MCaractControl extends Model
{
    protected $table = 'caracteristica_control';
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
    public function validaCaractControl($data){
        


        $sql = "CALL valida_caractControl(?,?)";

        $query = $this->db->query($sql, [
            $data[0]['caracteristica'],
            $data[0]['id']
        ]);

        if( $query->getRow()) return true;
        else return false;
    }
    public function validaCaractControl2($data){
        


        $sql = "CALL valida_caractControl2(?,?,?)";

        $query = $this->db->query($sql, [
            $data[0]['valor'],
            $data[0]['id'],
            $data[0]['condicion'],
        ]);

        if( $query->getRow()) return true;
        else return false;
    }
    public function validateCaractControlModify($data){
          
       
        $sql = "CALL sp_validate_caract_control_modify(?,?,?)";

        $query = $this->db->query($sql, [
        
            $data[0]['id_op'],
            $data[0]['caracteristica'],
            $data[0]['id'],
        
        ]);
        return $query->getResultArray();

    }
    public function validateCaractControlModify2($data){
          
       
        $sql = "CALL sp_validate_caract_control_modify2(?,?,?,?)";

        $query = $this->db->query($sql, [
        
            $data[0]['id_op'],
            $data[0]['valor'],
            $data[0]['condicion'],
            $data[0]['id'],
           
        ]);
        return $query->getResultArray();

    }
    public function getCaractControl($id,$tipo,$calificacion){
        
     
        if($id == 0){
            $sql = "CALL getCaractControl()";

            $query = $this->db->query($sql, [
              
            ]);
        }else{
                
                     $sql = "CALL getCaractControlById(?)";

                     $query = $this->db->query($sql, [
                        $id
                     ]);
            
        }
        
        return $query->getResultArray();
    }

  
    public function getOpcionesCaracteristica($tipo){
        
      
        $sql = "CALL getOpcionesCaracteristica(?)";

                     $query = $this->db->query($sql, [
                        $tipo
                     ]);
            
        return $query->getResultArray();
    }
    public function saveCaractControl($data){       

    
        $sql = "CALL agregar_caractControl(?,?,?,?,?,?,?,?,?,?,?,?,?)";

	    $query = $this->db->query($sql, [
            $data[0]['caracteristica'],
            $data[0]['descripcion'],
            $data[0]['estado'],
            $data[0]['peso'],
            $data[0]['valor'],
            $data[0]['condicion'],
            $data[0]['tipo'],
            $data[0]['id'],
            $data[0]['calificacion'],
            $data[0]['check_tabla'],
            $data[0]['nom_tabla'],
            $data[0]['seleccionable'],
            $data['user']
        
        ]);

        return $query;
    }
    public function updateCaractControl($data){  
        

        $sql = "CALL modificar_caractControl(?,?,?,?,?,?,?,?,?,?,?,?)";

	    $query = $this->db->query($sql, [
            $data[0]['caracteristica'],
            $data[0]['descripcion'],
            $data[0]['estado'],
            $data[0]['peso'],
            $data[0]['valor'],
            $data[0]['condicion'],
            $data[0]['check_tabla'],
            $data[0]['nom_tabla'],
            $data[0]['calificacion'],
            $data[0]['seleccionable'],
            $data['user'],
            $data[0]['id_op'],
        
        ]);

        return $query;
    }
    public function updateGeneral($input,$data){
        $sql = "CALL update_caractControl_general(?,?)";

	    $query = $this->db->query($sql, [
            $input[0]['id_op'],
            $data['id_user_deleted'],
            
        
        ]);

        return $query;
    }
    
}