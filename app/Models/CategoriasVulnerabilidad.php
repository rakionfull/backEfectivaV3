<?php

namespace App\Models;

use CodeIgniter\Model;

class CategoriasVulnerabilidad extends Model
{
    protected $table            = 'categoria_vulnerabilidad';
    protected $useSoftDeletes   = false;
    protected $primaryKey       = 'id';
    protected $allowedFields    = [
        'id',
        'categoria',
        'estado',
        'date_add',
        'date_modify',
        'date_deleted',
        'id_user_added',
        'id_user_modify',
        'id_user_deleted',
        'is_deleted'
    ];

    public function getAll(){
        $sql = "call sp_list_categoria_vulnerabilidad";
        $result = $this->db->query($sql)->getResultArray();
        return $result;
    }

    public function store($data){
        $sql = "call sp_add_categoria_vulnerabilidad(?,?,?,?)";
        $result = $this->db->query($sql,[
            $data['categoria'],
            $data['estado'],
            $data['id_user_added'],
            $data['date_add']
        ]);
        if($result){
            return true;
        }
        return false;
    }

    public function edit($id,$data){
        $sql = "call sp_edit_categoria_vulnerabilidad(?,?,?,?,?)";
        $result = $this->db->query($sql,[
            $id,
            $data['categoria'],
            $data['estado'],
            $data['id_user_updated'],
            $data['date_modify']
        ]);
        if($result){
            return true;
        }
        return false;
    }

    public function validateModify($data){
        $sql = "call sp_validate_categoria_vulnerabilidad_modify(?,?)";
        $query = $this->db->query($sql,[
            $data['id'],
            $data['categoria']
        ]);
        return $query->getResultArray();
    }
    public function deleteCategoriaVulnerabilidad($valor,$id){ 
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