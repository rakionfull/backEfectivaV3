<?php
use App\Models\MconfigPass;
use App\Models\Mlog;
use App\Models\Muser;


if(!function_exists('log_acciones')){
  function log_acciones($accion,$terminal,$ip,$id,$id2,$username){
    $fecha = date('Y-m-d H:i:s');
    $modelLog = new Mlog();
    $texto = $accion;
    $id_afectado=0;
    $modelUser = new Muser();
    $user = $modelUser->getUserbyId($id2);
    
    if($accion == 'change_pass'){
      $texto = "El usuario: ".$username." realizó cambio de clave";
    }
    if($accion == 'change_pass2'){
      $texto = "El usuario: ".$username." realizó cambio de clave al usuario: ".$user->usuario_us;
    }
    $array = [
        'terminal' => $terminal,
        'ip_addres' => $ip,
        'u_ejecutor' => $id,
        'u_afectado' => $id2,
        'accion' => $texto,
        'fecha' => $fecha,
    ];
    $modelLog -> saveLog($array);
          
   
  }
}

if(!function_exists('log_sistema')){
  function log_sistema($accion,$terminal,$ip,$id,$username){
    $fecha = date('Y-m-d H:i:s');
    $modelLog = new Mlog();
    $texto = $accion;
    $id_afectado=0;
    if($accion == 'login'){
        $texto = "El usuario: ".$username." inició sesión exitosamente";
    }
    if($accion == 'logout'){
        $texto = "El usuario: ".$username." cerró sesión correctamente desde el sistema";
    }
    if($accion == 'logout2'){
      $texto = "El usuario: ".$username." deslogeó por inactividad";
  }
    $array = [
        'terminal' => $terminal,
        'ip_addres' => $ip,
        'u_ejecutor' => $id,
        'accion' => $texto,
        'fecha' => $fecha,
    ];
    $modelLog -> saveLog_sistema($array);
          
   
  }
}

