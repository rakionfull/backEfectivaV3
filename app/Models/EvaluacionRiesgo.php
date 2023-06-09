<?php

namespace App\Models;

use CodeIgniter\Model;

class EvaluacionRiesgo extends Model
{
    protected $table  = 'evaluacion_riesgo';
    protected $primaryKey       = 'id';
    protected $useSoftDeletes   = false;

    // Dates
    protected $useTimestamps = true;
    protected $dateFormat    = 'datetime';
    protected $createdField  = 'date_add';
    protected $updatedField  = 'date_modify';
    protected $deletedField  = 'date_deleted';

    protected $allowedFields = [
        'id',
        'id_tipo_riesgo',
        'idempresa',
        'idarea',
        'idunidades',
        'idmacroproceso',
        'idproceso',
        'id_activo',
        'id_tipo_amenaza',
        'id_descripcion_amenaza',
        'id_tipo_vulnerabilidad',
        'id_descripcion_vulnerabilidad',
        'riesgo',
        'valor_probabilidad',
        'probabilidad',
        'valor_impacto',
        'impacto',
        'valor',
        'id_control',
        'riesgo_controlado_probabilidad',
        'riesgo_controlado_impacto',
        'riesgo_controlado_valor',
        'date_add',
        'date_modify',
        'date_deleted',
        'id_user_added',
        'id_user_modify',
        'id_user_deleted',
        'is_deleted'
    ];

    public function getAll($id){
        $sql = "call sp_list_evaluacion_riesgo(?)" ;
        $result = $this->db->query($sql,[$id])->getResultArray();
        return $result;
    }

    public function getAllHistoricos($id){
        $sql = "call sp_list_evaluacion_riesgo_historial (?)";
        $result = $this->db->query($sql,[$id])->getResultArray();
        return $result;
    }

    public function getById($id){
        $sql = "call sp_get_evaluacion_riesgo_by_id(?)";
        $result = $this->db->query($sql,[$id])->getResultArray();
        return $result;
    }
    
    public function store($data){
        if($data['id_valoracion_riesgo'] == ""){
            $sql = "call sp_add_evaluacion_riesgo_nivel(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            $result = $this->db->query($sql,[
                $data['id_tipo_riesgo'],
                $data['id_empresa'],
                $data['id_area'],
                $data['id_unidad'],
                $data['id_macroproceso'],
                $data['id_proceso'],
                $data['id_activo'],
                $data['id_tipo_amenaza'],
                $data['id_descripcion_amenaza'],
                $data['id_tipo_vulnerabilidad'],
                $data['id_descripcion_vulnerabilidad'],
                $data['riesgo'],
                $data['valor_probabilidad'],
                $data['probabilidad'],
                $data['valor_impacto'],
                $data['impacto'],
                $data['valor'],
                $data['id_control'],
                $data['riesgo_controlado_probabilidad'],
                $data['riesgo_controlado_impacto'],
                $data['riesgo_controlado_valor'],
                $data['estado'],
                $data['id_user_added'],
                $data['date_add'],
                $data['id_probabilidad'],
                $data['id_impacto'],
                $data['id_nivel_riesgo']
            ]);
        }else{
            $sql = "call sp_add_evaluacion_riesgo_valoracion(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            $result = $this->db->query($sql,[
                $data['id_tipo_riesgo'],
                $data['id_empresa'],
                $data['id_area'],
                $data['id_unidad'],
                $data['id_macroproceso'],
                $data['id_proceso'],
                $data['id_activo'],
                $data['id_tipo_amenaza'],
                $data['id_descripcion_amenaza'],
                $data['id_tipo_vulnerabilidad'],
                $data['id_descripcion_vulnerabilidad'],
                $data['riesgo'],
                $data['valor_probabilidad'],
                $data['probabilidad'],
                $data['valor_impacto'],
                $data['impacto'],
                $data['valor'],
                $data['id_control'],
                $data['riesgo_controlado_probabilidad'],
                $data['riesgo_controlado_impacto'],
                $data['riesgo_controlado_valor'],
                $data['estado'],
                $data['id_user_added'],
                $data['date_add'],
                $data['id_probabilidad'],
                $data['id_impacto'],
                $data['id_valoracion_riesgo']
            ]);
        }
        if($result){
            return true;
        }
        return false;
    }

    public function edit($id,$data){
        if($data['id_valoracion_riesgo'] == ""){
            $sql = "call sp_update_evaluacion_riesgo_nivel(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            $result = $this->db->query($sql,[
                $id,
                $data['id_tipo_riesgo'],
                $data['id_empresa'],
                $data['id_area'],
                $data['id_unidad'],
                $data['id_macroproceso'],
                $data['id_proceso'],
                $data['id_activo'],
                $data['id_tipo_amenaza'],
                $data['id_descripcion_amenaza'],
                $data['id_tipo_vulnerabilidad'],
                $data['id_descripcion_vulnerabilidad'],
                $data['riesgo'],
                $data['valor_probabilidad'],
                $data['probabilidad'],
                $data['valor_impacto'],
                $data['impacto'],
                $data['valor'],
                $data['id_control'],
                $data['riesgo_controlado_probabilidad'],
                $data['riesgo_controlado_impacto'],
                $data['riesgo_controlado_valor'],
                $data['estado'],
                $data['id_user_updated'],
                $data['date_modify'],
                $data['id_probabilidad'],
                $data['id_impacto'],
                $data['id_nivel_riesgo']
            ]);
        }else{
            $sql = "call sp_update_evaluacion_riesgo_valoracion(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            $result = $this->db->query($sql,[
                $id,
                $data['id_tipo_riesgo'],
                $data['id_empresa'],
                $data['id_area'],
                $data['id_unidad'],
                $data['id_macroproceso'],
                $data['id_proceso'],
                $data['id_activo'],
                $data['id_tipo_amenaza'],
                $data['id_descripcion_amenaza'],
                $data['id_tipo_vulnerabilidad'],
                $data['id_descripcion_vulnerabilidad'],
                $data['riesgo'],
                $data['valor_probabilidad'],
                $data['probabilidad'],
                $data['valor_impacto'],
                $data['impacto'],
                $data['valor'],
                $data['id_control'],
                $data['riesgo_controlado_probabilidad'],
                $data['riesgo_controlado_impacto'],
                $data['riesgo_controlado_valor'],
                $data['estado'],
                $data['id_user_updated'],
                $data['date_modify'],
                $data['id_probabilidad'],
                $data['id_impacto'],
                $data['id_valoracion_riesgo']
            ]);
        }
        if($result){
            return true;
        }
        return false;
    }
    public function countvalores(){
        $sql = "call sp_count_evaluacion_by_valor";
        $result = $this->db->query($sql)->getResultArray();
        return $result;
    }

    public function save_historial($data){
        $sql = "call sp_add_evaluacion_riesgo_historial(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        $result = $this->db->query($sql,[
            $data['id_tipo_riesgo'],
            $data['id_empresa'],
            $data['id_area'],
            $data['id_unidad'],
            $data['id_macroproceso'],
            $data['id_proceso'],
            $data['id_activo'],
            $data['id_tipo_amenaza'],
            $data['id_descripcion_amenaza'],
            $data['id_tipo_vulnerabilidad'],
            $data['id_descripcion_vulnerabilidad'],
            $data['riesgo'],
            $data['valor_probabilidad'],
            $data['probabilidad'],
            $data['valor_impacto'],
            $data['impacto'],
            $data['valor'],
            $data['id_control'],
            $data['riesgo_controlado_probabilidad'],
            $data['riesgo_controlado_impacto'],
            $data['riesgo_controlado_valor'],
            $data['estado'],
            $data['id_user_added'],
            $data['date_add']
        ]);
        if($result){
            return true;
        }
        return false;
    }
    public function get_last_id(){
        $sql = "call sp_get_last_evaluacion_riesgo";
        $result = $this->db->query($sql)->getResultArray();
        return $result;
    }
    public function update_status_riesgo($data){
        $sql = "call sp_change_status_riesgo_by_activo(?,?)";
        $result = $this->db->query($sql,[
            $data['id_activo'],
            $data['estado']
        ])->getResultArray();
        if($result){
            return true;
        }
        return false;
    }
    public function validateModify($id,$data){
        $sql = "call sp_validate_evaluacion_riesgo_modify(?,?,?)";
        $query = $this->db->query($sql,[
            $id,
            $data['riesgo'],
           // $data['id_empresa'] -> aqui eh modificado miguel
            $data['id_empresa']
        ]);
        return $query->getResultArray();
    }

    public function delete_evaluacion_riesgo_controles($id_evaluacion){
        $sql = "call sp_delete_evaluacion_riesgo_controles(?)";
        $result = $this->db->query($sql,[
            $id_evaluacion
        ]);
        if($result){
            return true;
        }
        return false;
    }
    public function delete_evaluacion_riesgo_controles2($id_riesgo,$id_control,$user){
        $sql = "call sp_delete_evaluacion_riesgo_controles2(?,?,?)";
        $result = $this->db->query($sql,[
            $id_riesgo,
            $id_control,
            $user
        ]);
        if($result){
            return true;
        }
        return false;
    }
}
