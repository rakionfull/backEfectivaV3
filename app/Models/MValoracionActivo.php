<?php

namespace App\Models;

use CodeIgniter\Model;

class MValoracionActivo extends Model
{
    protected $table = 'valoracion_activo';
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
        'estado',
        'idvalor',
        'date_add',
        'date_modify',
        'date_deleted',
        'id_user_added',
        'id_user_modify',
        'id_user_deleted',
        'is_deleted'
    ];
   
    public function getValActivo(){

   
    
        $query = $this->db->query("call listarValoracionActivo()",[
          
        ]);
        return $query->getResultArray();
    }

    
    public function saveValActivo($data){       

        

        $query = $this->db->query("call agregar_valoracionactivo(?,?)",[
            $data[0]['id_valor_val'],
            $data['user']
        ]);
        return $query;
    }
    public function saveDetalleValActivo($data){       

        

        $query = $this->db->query("call agregar_detallevaloracionactivo(?,?,?)",[
            $data['idaspecto'],
            $data['idvaloracionactivo'],
            $data['valoracion']
        ]);
        return $query;
    }

    public function lastIdValoracionActivo(){       

        

        $query = $this->db->query("call lastIdValoracionActivo()");
        return $query->getRow()->lastid;
    }
    public function updateValActivo($data){  
        
        
       

        $query = $this->db->query("call editar_valoracionactivo(?,?,?)",[
            $data[0]['id_valor_val'],
            $data[0]['id'],
            $data['user']
        ]);

        return $query;
    }
    public function getValoracionActivo(){
        
  
        // //primero consigo las columnas de los aspectos de seguridad
       

        $query = $this->db->query("call aspectosByEstado()");
        //$cabeceras="SELECT id,aspecto from aspectos_seguridad where estado=1 and is_deleted=0;";
        //$query= $this->db->query($cabeceras); 
        $calificacion = $query -> getResultArray();
        //     //construimos la consulta
         $parte1="SELECT DVA.id as id_dva,SA.id as id_as,VA.id  as id_val,VA.idvalor as valor_activo, ";
        

        $parte2= "";
        for ($i=0; $i < count($calificacion) ; $i++) { 
            if($i == count($calificacion) - 1){ 
                $parte2= $parte2." MAX(CASE when (select aspecto from aspectos_seguridad where estado=1 and is_deleted=0 and id=SA.id) = '{$calificacion[$i]['aspecto'] }' THEN SA.aspecto  ELSE 0 END) 
                as Aspecto_".($i+1).",
                MAX(CASE when (select aspecto from aspectos_seguridad where estado=1 and is_deleted=0 and id=SA.id) = '{$calificacion[$i]['aspecto'] }' THEN DVA.valoracion ELSE 0 END) 
                 as Valoración_".($i+1)." ";
                
            }else{
                $parte2= $parte2." MAX(CASE when (select aspecto from aspectos_seguridad where estado=1 and is_deleted=0 and id=SA.id) = '{$calificacion[$i]['aspecto'] }'
                 THEN SA.aspecto ELSE 0 END) as  Aspecto_".($i+1)." , 
                 MAX(CASE when (select aspecto from aspectos_seguridad where estado=1 and is_deleted=0 and id=SA.id) = '{$calificacion[$i]['aspecto'] }' THEN DVA.valoracion ELSE 0 END) 
                 as Valoración_".($i+1)." , ";
            }
           
          
        }
        
        $parte3=",VAC.id as valor_activo,VAC.valor as valor FROM detalle_valoracion_activo as DVA inner join aspectos_seguridad as
        SA
        on DVA.idaspectos_seguridad=SA.id inner join valoracion_activo as VA on DVA.idvaloracion_activo=VA.id inner join valor_activo as VAC
        on  VAC.id=VA.idvalor where VA.is_deleted=0 and 
        DVA.is_deleted=0  GROUP BY VA.id;";
     

       // luego 
       $query2 = $this->db->query($parte1.$parte2.$parte3);
        
        //return ($parte1.$parte2.$parte3);
         return  $query2 -> getResultArray();
      
    }
    public function getAspectoSeguridad(){
        $query = $this->db->query("call listarAspectoSeguridadByActivo()",[
          
        ]);
        return $query->getResultArray();
    }
    public function updateDetalleAspecto($data){
        $query = $this->db->query("call updateDetalleAspecto(?)",[
          $data,
        ]);
        return $query->getResultArray();
    }
    public function getDetalleEvaluacionActivo($id){
        $sql = "CALL getDetalleEvaluacionActivo(?)";

        $query = $this->db->query($sql, [
           $id
        ]);
        return $query->getResultArray();
    }

    public function get_all_detalle_valoracion_activo(){
        $sql = "call sp_get_all_detalle_valoracion_activo()";
        $query = $this->db->query($sql);
        return $query->getResultArray();
    }

    public function getDetalleValoracionActivo($aspecto){
        $sql = "call sp_get_detalle_valoracion_activo(?)";
        $query = $this->db->query($sql,[$aspecto]);
        return $query->getResultArray();
    }
    public function getValoracionActivoById($id){
        $sql = "call sp_get_valoracion_activo_by_id(?)";
        $query = $this->db->query($sql,[$id]);
        return $query->getResultArray();
        $query = $this->db->query($sql, [
           $id
        ]);
        return $query->getResultArray();
       
    }

    public function getValorActivoByValoraciones($array){
        $model = new MValoracionActivo();
        //traigo los datos de la valoracion de activo
        $detalle_EC = $model->getValActivo();
        foreach ($detalle_EC as $key => $value) {
            $cont=0;
            //traigo el dato de la calificacion segun el array enviado
        
            // $id_calificacion = $model->getById($value2['idCC']);
            
            //traigo el dato respectivo segun clasificaicon e Id de la evlauacion de control
            $valores = $model->getDetalleEvaluacionActivo($value['id']);
            // return $valores;
            //hago la compaativa si el valor del array es = al valor de la evaluacion de control 
            if($cont < count($valores)){
            
                for ($i=0; $i < count($valores); $i++) { 
                    //$resultado_final = $array[$i];
                    if(($array[$i]['idaspecto'] == $valores[$i]['idaspectos_seguridad']) && 
                        ($array[$i]['valoracion'] == $valores[$i]['valoracion'])){
                        $resultado = $valores[$i]['idvaloracion_activo'];
                        $cont++;
                    }else{
                        $resultado = "";
                    }
                }
                if($cont == count($array)){
                    return $resultado;
                }
            }
        }
        return false;
    }
    public function deleteValoracionActivo($valor,$id){ 
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