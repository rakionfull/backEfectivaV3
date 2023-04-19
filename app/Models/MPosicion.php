<?php

namespace App\Models;

use CodeIgniter\Model;

class MPosicion extends Model
{
    protected $table            = 'posicion_puesto';
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
        'idarea',
        'idunidad',
        'idempresa',
        'estado',
        'date_add',
        'date_modify',
        'date_deleted',
        'id_user_added',
        'id_user_modify',
        'id_user_deleted',
        'is_deleted'
    ];
    public function validaPosicion($data){
        
            // $query = $this->db->query("SELECT * FROM posicion_puesto 
            // where posicion_puesto='{$data['posicion']}'
            // and idempresa={$data['idempresa']} and
            //  idarea={$data['idarea']} and 
            //  idunidad={$data['idunidad']}");

           $sql = "CALL validaPosicion(?,?,?,?)";

           $query = $this->db->query($sql, [
            $data['idarea'],
            $data['idempresa'],
            $data['idunidad'],
            $data['posicion']
           
           
           
           ]);

            if( $query->getRow()) return true;
            else return false;
    }
    public function validatePosicionModify($data){
          
        // $query = $this->db->query("SELECT * from empresa  
        // where empresa ='{$data['empresa']}' and is_deleted=0;");
        $sql = "CALL sp_validate_puesto_modify(?,?,?,?,?)";

        $query = $this->db->query($sql, [
        
            $data[0]['id'],
            $data[0]['posicion'],
            $data[0]['idempresa'],
            $data[0]['idarea'],
            $data[0]['idunidad'],
           
            
        ]);
        return $query->getResultArray();

    }
    public function getPosicion($dato){

        if($dato == 0){
           
           
            $sql = "CALL listarPosicion()";

            $query = $this->db->query($sql, [
       
            ]);
        }else{
    
            //   $query = $this->db->query("EXEC listarPosicionEmpresa @dato={$dato}");
              $sql = "CALL listarPosicionEmpresa(?)";

              $query = $this->db->query($sql, [
               $dato
              ]);
        }
       
        return $query->getResultArray();
    }

    
    public function savePosicion($data){       

      

        $sql = "CALL agregar_posicion(?,?,?,?,?,?)";

        $query = $this->db->query($sql, [
         $data[0]['idarea'],
         $data[0]['idempresa'],
         $data[0]['idunidad'],
         $data[0]['posicion'],
         $data[0]['estado'],
         $data['user'],
        ]);
        return $query;
    }
    public function updatePosicion($data){  
        
   
        $sql = "CALL editar_posicion(?,?,?,?,?,?,?)";

        $query = $this->db->query($sql, [
         $data[0]['idarea'],
         $data[0]['idempresa'],
         $data[0]['idunidad'],
         $data[0]['posicion'],
         $data[0]['id'],
         $data[0]['estado'],
         $data['user'],
        ]);
        return $query;
    }
  
   
    public function getPosicionByArea($area_id){
        
        // $query = $this->db->query("EXEC getPosicionByArea @idarea={$area_id}");
        $sql = "CALL getPosicionByArea(?)";

        $query = $this->db->query($sql, [
          $area_id
        ]);
        return $query->getResultArray();
    }
    public function getPosicionByUnidad($data){
     
        // $query = $this->db->query("EXEC getPosicionByUnidad @empresa={$data['idempresa']},
        // @area={$data['idarea']}, @unidad={$data['idunidad']}");

        $sql = "CALL getPosicionByUnidad(?,?,?)";

        $query = $this->db->query($sql, [
          $data['idempresa'],
          $data['idarea'],
          $data['idunidad']
        ]);
        return $query->getResultArray();
    }
    public function getComboPosicion(){

    
        //$query = $this->db->query("EXEC getComboPosicion");
        $sql = "CALL getComboPosicion()";

        $query = $this->db->query($sql, [
        
        ]);
        return $query->getResultArray();
    }
    public function getPosicionByActivo($data){

     
    //    $query = $this->db->query("EXEC getPosicionByActivo
    //     @empresa={$data['idempresa']}");
        
      $sql = "CALL getPosicionByActivo(?)";

      $query = $this->db->query($sql, [
        $data['idempresa']
      ]);
       return $query->getResultArray();
    }
    public function deletePosicion($valor,$id){ 
        $sql = "CALL eliminar_general(?)";
        
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