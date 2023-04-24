<?php

namespace App\Validation;
use App\Models\Muser;
use Exception;
use Config\Encryption;
use Config\Services;
class UserRules
{
 
    public function validateUser(string $str, string $fields, array $data): bool
    {
        try {
			$config         = new Encryption();
			$config->key    = KEY;
			$config->driver = 'OpenSSL';
			$config->cipher = CIPER;
			$config ->digest = DIGEST;
		
			$encrypter = Services::encrypter($config);
            $model = new Muser();
			$valor=false;
            $user = $model->getUser($data['username']);
           //sreturn password_verify($data['password'], $user->pass_cl);
			if($data['password'] == $encrypter->decrypt(hex2bin($user->pass_cl))){
				$valor = true;
			}else{
				$valor = false;
			}
			return $valor;
        } catch (Exception $ex) {
            return $ex->getMessage();
        }
    }
    public function validatePass(string $str, string $fields, array $data): bool
    {
        
        $password = trim($data['passw']);

		$regex_lowercase = '/[a-z]/';
		$regex_uppercase = '/[A-Z]/';
		$regex_number = '/[0-9]/';
		$regex_special = '/[!@#$%^&*()\-_=+{};:,<.>ยง~]/';
	
			if (preg_match_all($regex_lowercase, $password) < 1)
			{
				
				return FALSE;
			}
	
			if (preg_match_all($regex_uppercase, $password) < 1)
			{
				
				return FALSE;
			}
	
		
		
		    if (preg_match_all($regex_number, $password) < 1)
			{
				
				return FALSE;
			}
		
		
			if (preg_match_all($regex_special, $password) < 1)
			{
			
				return FALSE;
			}
		
		return TRUE;
      
    }
   
}