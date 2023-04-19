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
        'idaspecto1',
        'idaspecto2',
        'idaspecto3',
        'date_add',
        'date_modify',
        'date_deleted',
        'id_user_added',
        'id_user_modify',
        'id_user_deleted',
        'is_deleted'
    ];
    public function validarValActivo($data){
        
            // $query = $this->db->query("SELECT * FROM valoracion_activo 
            // where idaspecto1='{$data['id_aspecto1']}'
            // and idaspecto2={$data['id_aspecto2']} 
            // and idaspecto3={$data['id_aspecto3']} 
            // and idvalor={$data['id_valor_val']}
            // and valoracion1='{$data['nom_val1']}' 
            // and valoracion2='{$data['nom_val2']}' 
            // and valoracion3='{$data['nom_val3']}'");
           
           $query = $this->db->query("call validaValoracionActivo(?,?,?,?,?,?)",[
            $data['id_aspecto1'],
            $data['id_aspecto2'],
            $data['id_aspecto3'],
           
            $data['nom_val1'],
            $data['nom_val2'],
            $data['nom_val3'],
            // $data['id_valor_val'],
           ]);

            if( $query->getRow()) return true;
            else return false;
    }
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
        
        
       

        $query = $this->db->query("call editar_valoracionactivo(?,?,?,?,?,?,?,?,?)",[
            $data[0]['id_aspecto1'],
            $data[0]['id_aspecto2'],
            $data[0]['id_aspecto3'],
            $data[0]['nom_val1'],
            $data[0]['nom_val2'],
            $data[0]['nom_val3'],
            $data[0]['id_valor_val'],
            $data[0]['id'],
            $data['user']
        ]);

        return $query;
    }
    public function getValoracionActivo(){
        
  
        // //primero consigo las columnas de los aspectos de seguridad
       


        $cabeceras="SELECT aspecto from aspectos_seguridad where estado=1 and is_deleted=0;";
        $query= $this->db->query($cabeceras); 
        $calificacion = $query -> getResultArray();
        //     //construimos la consulta
         $parte1="SELECT DVA.id,SA.id,VA.id,DVA.valoracion as valor ,";
        

        $parte2= "";
        for ($i=0; $i < count($calificacion) ; $i++) { 
            if($i == count($calificacion) - 1){ 
                $parte2= $parte2." MAX(CASE when (select aspecto from aspectos_seguridad where estado=1 and is_deleted=0 and id=SA.id) = '{$calificacion[$i]['aspecto'] }' THEN SA.aspecto  ELSE 0 END) 
                as '{$calificacion[$i]['aspecto'] }' ";
                
            }else{
                $parte2= $parte2." MAX(CASE when (select aspecto from aspectos_seguridad where estado=1 and is_deleted=0 and id=SA.id) = '{$calificacion[$i]['aspecto'] }'
                 THEN SA.aspecto ELSE 0 END) as  '{$calificacion[$i]['aspecto'] }' , ";
            }
           
          
        }
        
        $parte3=", DVA.valoracion as Valoracion,VAC.id as valor_activo FROM detalle_valoracion_activo as DVA inner join aspectos_seguridad as
        SA
        on DVA.idaspectos_seguridad=SA.id inner join valoracion_activo as VA on DVA.idvaloracion_activo=VA.id inner join valor_activo as VAC
        on  VAC.id=VA.idvalor where VA.is_deleted=0 and 
        DVA.is_deleted=0  GROUP BY VA.id; ";
     

       // luego 
        $query2 = $this->db->query($parte1.$parte2.$parte3);
        
      
         return  $query2 -> getResultArray();
      
    }
    public function getAspectoSeguridad(){
        $query = $this->db->query("call listarAspectoSeguridadByActivo()",[
          
        ]);
        return $query->getResultArray();
    }


}