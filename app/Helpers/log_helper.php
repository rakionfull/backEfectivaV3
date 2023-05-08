<?php
use App\Models\MconfigPass;
use App\Models\Mlog;


if(!function_exists('log_acciones')){
  function log_acciones($accion,$terminal,$ip,$id,$id2,$username){
    $fecha = date('Y-m-d H:i:s');
    $modelLog = new Mlog();
    $texto = $accion;
    $id_afectado=0;
    // if($accion == 'login'){
    //     $texto = "El usuario: ".$username." a iniciado sesión";
    // }
    // if($accion == 'logout'){
    //     $texto = "El usuario: ".$username." a cerrado sesión correstamente desde el sistema";
    // }
    if($accion == 'change_pass'){
      $texto = "El usuario: ".$username." ah realizado cambio de clave";
    }
    if($accion == 'change_pass2'){
      $texto = "El usuario: ".$username." ah realizado cambio de clave al usuario: ".$id2;
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
        $texto = "El usuario: ".$username." a iniciado sesión exitosamente";
    }
    if($accion == 'logout'){
        $texto = "El usuario: ".$username." a cerrado sesión correctamente desde el sistema";
    }
    if($accion == 'logout2'){
      $texto = "El usuario: ".$username." deslogeo por inactividad";
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

