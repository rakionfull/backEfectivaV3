<?php
use App\Models\MconfigPass;
use App\Models\Muser;
use Config\Encryption;
use Config\Services;


if(!function_exists('veriPass')){
 
  function veriPass($passPost,$idPost){
    $config         = new Encryption();
    $config->key    = KEY;
    $config->driver = 'OpenSSL';
    $config->cipher = CIPER;
    $config ->digest = DIGEST;
    $encrypter = Services::encrypter($config);

    $modelUser = new Muser();
    $model = new MconfigPass();
    $configuracion =  $model->getConfigPass();
    $array_claves = $modelUser -> getPass($idPost);
    $valor=false;
    foreach ($array_claves as $key => $value) {
     
      if(!$valor){
          
        if($passPost == $encrypter->decrypt(hex2bin($value["pass_cl"]))){
          $valor = true;
        }
        
      }
    }
   
    return $valor;
  }
}
if(!function_exists('validacionPassword')){
  function validacionPassword($data){
      if (empty($data["passw"]) && empty($data["repassw"]))
      {
        
        return "Los campos son obligatorios";
      }
      $model = new MconfigPass();
      $configuracion =  $model->getConfigPass();
      if (strlen($data["passw"]) < $configuracion[0]['tama_min'] && strlen($data["repassw"]) < $configuracion[0]['tama_min'])
      {
    
        return 'La contraseña debe contener como minimo '.$configuracion[0]['tama_min'].' caracteres';
      }
      if (strlen($data["passw"]) > $configuracion[0]['tama_max'] && strlen($data["repassw"]) > $configuracion[0]['tama_max'])
      {
    
        return 'La contraseña debe contener como máximo '.$configuracion[0]['tama_max'].' caracteres';
      }
      if(!($data["passw"] == $data["repassw"])){
        return "Las contraseñas no coinciden";
      }
      $password = trim($data['passw']);

      $regex_lowercase = '/[a-z]/';
      $regex_uppercase = '/[A-Z]/';
      $regex_number = '/[0-9]/';
      $regex_special = '/[!@#$%^&*()\-_=+{};:,<.>ยง~]/';

      $cadena = 'La contraseña debe contener ';
      //armando el mensaje
      if($configuracion[0]['letras'] == 1){
        $cadena = $cadena . ' 1 May | 1 Min |';
      }
      if($configuracion[0]['numeros'] == 1){
        $cadena = $cadena . ' 1 Num |';
      }
      if($configuracion[0]['caracteres'] == 1){
        $cadena = $cadena . ' 1 Carac |';
      }
      //validacion con return

      if($configuracion[0]['letras'] == 1){
        if (preg_match_all($regex_lowercase, $password) < 1)
        {
          
          return $cadena;
        }
      }
      if($configuracion[0]['letras'] == 1){
        if (preg_match_all($regex_uppercase, $password) < 1)
        {
          
          return $cadena;
        }
      }
	
		
		if($configuracion[0]['numeros'] == 1){
      if (preg_match_all($regex_number, $password) < 1)
			{
				
				return $cadena;
			}
    }
		  
		if($configuracion[0]['caracteres'] == 1){
      if (preg_match_all($regex_special, $password) < 1)
			{
			
				return $cadena;
			}
    }
		
			
    
    return 1;
  }
}