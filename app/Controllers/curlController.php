<?php

namespace App\Controllers;
use App\Controllers\BaseController;
use CodeIgniter\API\ResponseTrait;
use App\Libraries\Curl;
use Exception;
use ReflectionException;

class curlController extends BaseController
{
    use ResponseTrait;
    
    public function http_request(){
       // try {
            $captcha = new Curl();
            $REST_API = "http://10.167.19.56/WsCifrado/api/Cifrado/ArmarConnectionStrings";
          
            $request_data = [
                "AplicativoKey" => 'dwBlAGIAXwBzAGcAaQByAA==',
                @"Usuario" => "kGKt8csoGKqw9tNXX5cOBENruiSg0JrdNW61yHsavZw=",
                @"Password" => "A5zFh9C9JCD0kSfc2Xv9ghDrYPrIhPQnB4fdhftQNCs="
            ];
            $response = $captcha->perform_http_request('POST', $REST_API , $request_data);
    
            var_dump ($request_data);
        // } catch (\Throwable $th) {
        //     var_dump('error');
        //     var_dump($th);
        // }
      
    }
}