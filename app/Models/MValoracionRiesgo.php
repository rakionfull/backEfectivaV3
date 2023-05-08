<?php

namespace App\Models;

use CodeIgniter\Model;

class MValoracionRiesgo extends Model
{

    protected $table            = 'valoracion_riesgo';
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

    
    public function validaValoracionRiesgo($data){
        
      
    

        $sql = "call valida_ValoracionRiesgo(?,?)";

        $query=$this->db->query($sql,[
            $data['probabilidad'],
            $data['impacto'],
           
        ]);

        if( $query->getRow()) return true;
        else return false;
    }
    public function validateValoracionRiesgo($data){
        
        $sql = "call sp_validate_valoracion_riesgo_modify(?,?,?)";

        $query=$this->db->query($sql,[
            $data[0]['probabilidad'],
            $data[0]['impacto'],
            $data[0]['id'],
        ]);

        return $query->getResultArray();
    }
    public function getValoracionRiesgo(){
        
        $query = $this->db->query("call listar_ValoracionRiesgo");
        return $query->getResultArray();
    }


    public function saveValoracionRiesgo($data){       

        $sql = "call agregar_ValoracionRiesgo(?,?,?,?)";

        $query=$this->db->query($sql,[
            $data[0]['valor'],
            $data[0]['probabilidad'],
            $data[0]['impacto'],
            $data['user']
        ]);

        return $query;
    }
    public function updateValoracionRiesgo($data){  
        $sql = "call modificar_ValoracionRiesgo(?,?,?,?,?)";
        $query= $this->db->query($sql,[
            $data[0]['valor'],
            $data[0]['probabilidad'],
            $data[0]['impacto'],
            $data['user'],
            $data[0]['id']
        ]);
        return $query;
    }

    public function getImpactoRiesgoByActivo(){
        
        $query = $this->db->query("call listar_ImpactoRiesgoByActivo");
        return $query->getResultArray();
    }
    public function getProbabilidadRiesgoByActivo(){
        
        $query = $this->db->query("call listar_ProbabilidadRiesgoByActivo");
        return $query->getResultArray();
    }
   
    public function getDataMatriz(){
        
  
        //   $query = $this->db->query("SELECT  concat(PR.valor1,' - ',PR.valor2) as valorProbabilidad 
        //   ,concat(IR.valor1,' - ',IR.valor2) as  valorImpacto,VR.id,VR.idProbabilidad,VR.idImpacto,VR.valor, 
        //    PR.descripcion as probabilidad, IR.descripcion as impacto
        //    from valoracion_riesgo as VR inner join probabilidad_riesgo as PR 
        //    on VR.idProbabilidad = PR.id inner join impacto_riesgo as IR on VR.idImpacto=IR.id
        //   where VR.is_deleted=0 and PR.estado=1  and  IR.estado=1  and PR.tipo_regla='2 Valores' 
        //   and IR.tipo_regla='2 Valores' order by valorProbabilidad DESC ");
          
          $query = $this->db->query("call getDataMatriz()",[]);
        return $query->getResultArray();
    }

    public function getByProbabilidadImpacto($data){
        $query = $this->db->query("call sp_get_valoracion_riesgo(?,?)",[
            $data['id_probabilidad'],
            $data['id_impacto']
        ]);
        return $query->getResultArray();;
    }

    public function deleteValoracionRiesgo($valor,$id){ 
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