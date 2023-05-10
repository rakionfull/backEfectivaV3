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
    
    public function http_request($API_REST,$strAplicativoWs_param,$strUsr_param,$strPsw_param){
       // try {
            $curl = new Curl();
            $REST_API = $API_REST;
         
            $request_data = [];
                     
            $strUsr = urlencode($strUsr_param);
            $strPsw = urlencode($strPsw_param);
            $strAplicativoWs = $strAplicativoWs_param;
            $strConexion = "@Usuario|@Password";

            //  $response = $REST_API."?strConexion=".$strConexion."&strAplicativoWs=".$strAplicativoWs."&strUsr=".$strUsr."&strPsw=".$strPsw;
            $response = $curl->perform_http_request('POST', $REST_API.
            "?strConexion=".$strConexion.
            "&strAplicativoWs=".$strAplicativoWs.
            "&strUsr=".$strUsr.
            "&strPsw=".$strPsw,
            $request_data);
    
            return  $response;
       
      
    }
}