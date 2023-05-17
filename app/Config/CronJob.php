<?php

namespace Config;

use CodeIgniter\Config\BaseConfig;
use App\Controllers\BaseController;
use Daycry\CronJob\Scheduler;
use App\Models\MriesgoPlanAccion;
use App\Models\Muser;

class CronJob extends \Daycry\CronJob\Config\CronJob
{
    /**
     * Set true if you want save logs
     */
    public bool $logPerformance = true;

    /*
    |--------------------------------------------------------------------------
    | Log Saving Method
    |--------------------------------------------------------------------------
    |
    | Set to specify the REST API requires to be logged in
    |
    | 'file'   Save in files
    | 'database'  Save in database
    |
    */
    public string $logSavingMethod = 'file';

    /**
     * Directory
     */
    public string $filePath = WRITEPATH . 'cronJob/';

    /**
     * File Name in folder jobs structure
     */
    public string $fileName = 'jobs';

    /**
     * --------------------------------------------------------------------------
     * Maximum performance logs
     * --------------------------------------------------------------------------
     *
     * The maximum number of logs that should be saved per Job.
     * Lower numbers reduced the amount of database required to
     * store the logs.
     *
     * If you write 0 it is unlimited
     */
    public int $maxLogsPerJob = 3;

    /*
    |--------------------------------------------------------------------------
    | Database Group
    |--------------------------------------------------------------------------
    |
    | Connect to a database group for logging, etc.
    |
    */
    public string $databaseGroup = 'default';

    /*
    |--------------------------------------------------------------------------
    | Cronjob Table Name
    |--------------------------------------------------------------------------
    |
    | The table name in your database that stores cronjobs
    |
    */
    public string $tableName = 'cronjob';

    /*
    |--------------------------------------------------------------------------
    | Cronjob Notification
    |--------------------------------------------------------------------------
    |
    | Notification of each task
    |
    */
    public bool $notification = false;
    public string $from = 'email@example.com';
    public string $fromName = 'CronJob';
    public string $to = 'email@example.com';
    public string $toName = 'User';

    /*
    |--------------------------------------------------------------------------
    | Views
    |--------------------------------------------------------------------------
    |
    | Notification of each task
    |
    */
    public array $views = [
        'login'                       => '\Daycry\CronJob\Views\login',
        'dashboard'                   => '\Daycry\CronJob\Views\dashboard',
        'layout'                      => '\Daycry\CronJob\Views\layout',
        'logs'                        => '\Daycry\CronJob\Views\logs'
    ];

    /*
    |--------------------------------------------------------------------------
    | Dashboard login
    |--------------------------------------------------------------------------
    */
    public bool $enableDashboard = false;
    public string $username = 'admin';
    public string $password = 'admin';

    /*
    |--------------------------------------------------------------------------
    | Cronjobs
    |--------------------------------------------------------------------------
    |
    | Register any tasks within this method for the application.
    | Called by the TaskRunner.
    |
    | @param Scheduler $schedule
    */
    public function init(Scheduler $schedule)
    {
        // $schedule->command('foo:bar')->everyMinute();
        //
        // $schedule->command('foo:bar')->everyMinute();
       
        //$schedule->shell('cp foo bar')->daily( '02:00 pm' );
        $schedule->call(function() { 
           //log_message('debug','Hola mundo');
         //ejecutar todo el codigo
    //crear funcion de alerta de seguimiento
    //alerta por plan de accion

            $model = new MriesgoPlanAccion();
            $result = $model->getCorreoPlan() ;
            
            foreach ($result as $key => $value) {
                // var_dump($result);
                $idplan = $value['id'];
                $idusuario = $value['usuario'];
               
                $correo_plan = $model->getCorreoPlanEnviados($idplan);
                if(!$correo_plan){
                  
                    
                
                }else{
                    //var_dump($correo_plan);
                     //Si encuentro registros en la tabla envio sumo los dias del ultimo envio segun el valor de la alerta
                     $fecha_alerta = (date("Y-m-d",strtotime($correo_plan->fecha_envio."+ ".$value['valor']." days"))); 
                     $fecha_fin = $value['fecha_fin'];
                     $fecha_actual = date("Y-m-d");
                     // echo $fecha_actual;
                     if($fecha_alerta <= $fecha_fin){
                    
                         if($fecha_actual == $fecha_alerta ){
     
                            //echo ("Es hora de la alerta con envios anteriores del plan de accion");
                                
                                 
                                     //echo ("Correo registrado y enviado");
                                     // enviar al correo  $row['email_us']
                                          // nombre sy apellidos $row['nombre_us']  $row['apepat_us']  $row['apemat_us']
                                     // el nombvre del plan $row['plan_accion]
                                      // el estado: ah inciado
                                      //aleta $row['alerta] tipo de alerta

                                      $modelUser = new Muser;
                                      $datos_correo = $modelUser -> getDatosCorreo();
                                      $config['SMTPHost'] =  $datos_correo->smtp_server;
                                      $config['SMTPUser'] = $datos_correo->email_server;
                                      $config['SMTPPass']  = $datos_correo->pass_server;
                                      $config['SMTPPort'] = $datos_correo->puerto_server;
                                      
                                    
                      
                                      $email = \Config\Services::email();
                                      $email->initialize($config);

                                        $email->setTo($value['email_us']);
                                        $email->setFrom($datos_correo->send_email, $datos_correo->descripcion);
                                        $email->setSubject('Alerta de plan de acción');
                                        $email->setMessage(
                                        view('mail/plan_accion',[
                                            
                                                'fullname' => $value['nombres_us'].' '.$value['apepat_us'].' '.$value['apemat_us'],
                                                'plan' => $value['plan_accion'],
                                                'estado' => $value['estado_plan'],
                                                'alerta' => $value['alerta']
                                            
                                        ])
                                    );
                                    $valor = $email->send();
                                    if($valor){
                                        $insert = $model -> insertCorreoPlan($idplan,$fecha_actual,$idusuario);
                                    }
                                 
                         }
                     
                   }
                }
              
            }
    


            $result2= $model->getCorreoActividad() ;
            
            foreach ($result2 as $key => $value2) {
                // var_dump($result2);
                $idactividad = $value2['id_act'];
                $idusuario = $value2['id_us'];
                $correo_actividad = $model->getCorreoActividadesEnviados($idactividad);
              
                if($value2['progreso'] < 100){
                    if(!$correo_actividad){
                      
                        
                    
                    }else{
                        
                         //Si encuentro registros en la tabla envio sumo los dias del ultimo envio segun el valor de la alerta
                         $fecha_alerta = (date("Y-m-d",strtotime($correo_actividad->fecha_envio."+ ".$value2['valor']." days"))); 
                         $fecha_fin = $value2['fecha_fin'];
                         $fecha_actual = date("Y-m-d");
                         // echo $fecha_actual;
                         if($fecha_alerta <= $fecha_fin){
                        
                             if($fecha_actual == $fecha_alerta ){
         
                              //   echo ("Es hora de la alerta con datos de la actividad");
                                                                             //echo ("Correo registrado y enviado");
                                         // enviar al correo  $row['email_us']
                                              // nombre sy apellidos $row['nombre_us']  $row['apepat_us']  $row['apemat_us']
                                         // el nombvre del plan $row['plan_accion]
                                          // el estado: ah inciado
                                          //aleta $row['alerta] tipo de alerta
                                       $modelUser = new Muser;
                                        $datos_correo = $modelUser -> getDatosCorreo();
                                        $config['SMTPHost'] =  $datos_correo->smtp_server;
                                        $config['SMTPUser'] = $datos_correo->email_server;
                                        $config['SMTPPass']  = $datos_correo->pass_server;
                                        $config['SMTPPort'] = $datos_correo->puerto_server;
                                        
                                    
                        
                                        $email = \Config\Services::email();
                                        $email->initialize($config);

                                          $email->setTo($value2['email_us']);
                                          $email->setFrom($datos_correo->send_email, $datos_correo->descripcion);
                                          $email->setSubject('Alerta de actividad');
                                          $email->setMessage(
                                              view('mail/actividad',[
                                                  
                                                      'fullname' => $value2['nombres_us'].' '.$value2['apepat_us'].' '.$value2['apemat_us'],
                                                      'plan' => $value2['plan_accion'],
                                                      'actividad' => $value2['descripcion'],
                                                      'estado' => 'Mensaje de alerta',
                                                      'alerta' => $value2['alerta']
                                                  
                                              ])
                                          );
                                         $valor = $email->send();
                                         if($valor){
                                            $insert = $model -> insertCorreoActividad($idplan,$fecha_actual,$idusuario);
                                         }
                                     
                             }
                         
                       }
                    }
                }
              
              
            }
   
     
       
        })->daily('7:00 am');
        //->everyMinute();

       
    }
}
