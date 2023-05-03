<?php

use App\Models\MRegistroControles;
use App\Models\MEvaluacionControl;
use App\Models\MValoracionActivo;

function calificar($array,$idCC)
{
    $model = new MRegistroControles();
    //traer los pesos segun el IDCC
    $peso_total = 0;
    $array_resultado =[];
    foreach ($array as $key => $value) {
      
        if($value['valor'] != 0){
            $peso = $model->obtenerPeso($value['idCC']);
             if($peso != ""){
                $peso_total =  $peso_total + floatval($peso); 
            
            }
       
        }
      
    }
    $model = new MRegistroControles();
    $valores = $model->getValoresControles($idCC);
    $resultado  = "";
    foreach ($valores as $key => $value2) {
        if($value2['condicion'] == "<"){
            if($peso_total < floatval($value2['valor'])){
                $resultado = $value2['caracteristica'] ;
                $array_resultado = [
                    'id' => $value2['id'],
                    'caracteristica' => $value2['caracteristica']
                ];
            }
        }
        if($value2['condicion'] == ">"){
            if($peso_total >floatval($value2['valor'])){
                $resultado = $value2['caracteristica'];
                $array_resultado = [
                    'id' => $value2['id'],
                    'caracteristica' => $value2['caracteristica']
                ];
            }
        }
        if($value2['condicion'] >= ">="){
            if($peso_total < floatval($value2['valor'])){
                $resultado = $value2['caracteristica'];
                $array_resultado = [
                    'id' => $value2['id'],
                    'caracteristica' => $value2['caracteristica']
                ];
            }
        }
        if($value2['condicion'] == "<="){
            if($peso_total <= floatval($value2['valor'])){
                $resultado = $value2['caracteristica'];
                $array_resultado = [
                    'id' => $value2['id'],
                    'caracteristica' => $value2['caracteristica']
                ];
            }
        }
        if($value2['condicion'] == "="){
            if($peso_total == floatval($value2['valor'])){
                $resultado = $value2['caracteristica'];
                $array_resultado = [
                    'id' => $value2['id'],
                    'caracteristica' => $value2['caracteristica']
                ];
            }
        }
      
    }
    //peso total
    // traemos la data de la calificacion
    // return $peso_total;
    return $array_resultado;
}
function evaluar($array){
    $model = new MRegistroControles();
    //traigo los datos de la evluacion de control
    $detalle_EC = $model->getEvaluacionControl();
    $resultado_final = [];
    $cont=0;
    foreach ($detalle_EC as $key => $value) {
       
            
                //traigo el dato de la caligicacion segun el array enviado
            
                // $id_calificacion = $model->getById($value2['idCC']);
                
                    //traigo el dato respectivo segun clasificaicon e Id de la evlauacion de control
                    $valores = $model->getDetalleEvaluacionControl($value['id']);
                    // //hago la compaativa si el valor del array es = al valor de la evaluacion de control 
               if($cont < count($valores)){
              
                    for ($i=0; $i < count($valores) ; $i++) { 
                        if(strtoupper($array[$i]['valor']) == strtoupper($valores[$i]['caracteristica'])){
                          //$resultado_final = $valores[$i]['calificacion'];
                          $resultado_final = [
                            'id_evaluacion' =>$valores[$i]['id'],
                            'calificacion' => $valores[$i]['calificacion']
                          ];
                        //    $resultado_final = [
                        //     $array[$i]['valor'] ,
                        //     $valores[$i]['caracteristica'],
                        //     $valores[$i]['calificacion'],
                        //    ];
                            // $array_extra=[
                            //     $array[$i]['valor'] ,
                            //     $array[$i]['idCC'],
                            
                               
                            //     $valores[$i]['caracteristica'],
                            //     $valores[$i]['id'],
                            //     $valores[$i]['calificacion'],
                            // ];
                            // $array_extra = [
                            //     'hola'
                            // ];
                            // array_push($resultado_final,$array_extra);
                            $cont++;
                        

                        }else{
                            $resultado_final = "";
                            $resultado = [];
                            $cont=0;
                        }
                    }
               }
                    
                                            
                        
                        
                          
                    
                

    }
    
    if($resultado_final == ""){
        $resultado_final = [
            'id_evaluacion' =>0,
            'calificacion' =>"No hay Evaluacion Registrada para esta combinacion"
        ];
        //$resultado_final = "No hay Evaluacion Registrada para esta combinacion";
    }
    return $resultado_final;
}
function validar_evaluacion_control($array){
    $model = new MRegistroControles();
    //traigo los datos de la evluacion de control
    $detalle_EC = $model->getEvaluacionControl();
    $resultado_final = false;
    $cont=0;
    foreach ($detalle_EC as $key => $value) {
       
            
                //traigo el dato de la caligicacion segun el array enviado
            
                // $id_calificacion = $model->getById($value2['idCC']);
                
                    //traigo el dato respectivo segun clasificaicon e Id de la evlauacion de control
                $valores = $model->getDetalleEvaluacionControl($value['id']);
                    // //hago la compaativa si el valor del array es = al valor de la evaluacion de control 
               if($cont < count($valores)){
              
                    for ($i=0; $i < count($valores) ; $i++) { 
                        //$resultado_final = $array[$i];
                        if(($array[$i]) == ($valores[$i]['ID_CC'])){
                        $resultado_final = true;
                      
                         $cont++;
                        

                        }else{
                            $resultado_final = "";
                            $resultado = [];
                            $cont=0;
                        }
                    }
               }
                    
                                            
                        
                        
                          
                    
                

    }
    
    return $resultado_final;
}
function validar_evaluacion_control2($array,$id){
    $model = new MRegistroControles();
    //traigo los datos de la evluacion de control
    $detalle_EC = $model->getEvaluacionControl();
    $resultado_final = false;
    $cont=0;
    foreach ($detalle_EC as $key => $value) {
       
            
                //traigo el dato de la caligicacion segun el array enviado
            
                // $id_calificacion = $model->getById($value2['idCC']);
                
                    //traigo el dato respectivo segun clasificaicon e Id de la evlauacion de control
                    if($value['id'] != $id){
                        $valores = $model->getDetalleEvaluacionControl($value['id']);
                        // //hago la compaativa si el valor del array es = al valor de la evaluacion de control 
                        if($cont < count($valores)){
                        
                                for ($i=0; $i < count($valores) ; $i++) { 
                                    //$resultado_final = $array[$i];
                                    if(($array[$i]) == ($valores[$i]['ID_CC'])){
                                        $resultado_final = true;
                                    
                                        $cont++;
                                    
            
                                    }else{
                                        $resultado_final = "";
                                        $resultado = [];
                                        $cont=0;
                                    }
                                }
                        }
                    }
              
                    
    }
    
    return $resultado_final;
}

//validaciones de valoracion de activo
function validar_valoracion_activo($array,$idvalor){
    $model = new MValoracionActivo();
    //traigo los datos de la valoracion de activo
    $detalle_EC = $model->getValActivo();
    $resultado_final = false;
    $cont=0;
    foreach ($detalle_EC as $key => $value) {
       
            
                //traigo el dato de la caligicacion segun el array enviado
            
                // $id_calificacion = $model->getById($value2['idCC']);
                
                    //traigo el dato respectivo segun clasificaicon e Id de la evlauacion de control
                $valores = $model->getDetalleEvaluacionActivo($value['id']);
                    // //hago la compaativa si el valor del array es = al valor de la evaluacion de control 
               if($cont < count($valores)){
              
                    // for ($i=0; $i < count($valores) ; $i++) { 
                    //     //$resultado_final = $array[$i];
                    //     if(($array[$i]['idaspecto']) == ($valores[$i]['idaspectos_seguridad']) && 
                    //         ($array[$i]['valoracion']) == ($valores[$i]['valoracion']) &&
                    //         $idvalor == $valores[$i]['idvalor']){
                    //         $resultado_final = true;
                      
                    //      $cont++;
                        

                    //     }else{
                    //         $resultado_final = "";
                    //         $resultado = [];
                    //         $cont=0;
                    //     }
                    // }
                    //aqui se corrigio
                    for ($i=0; $i < count($valores) ; $i++) { 
                        //$resultado_final = $array[$i];
                        if(($array[$i]['idaspecto']) == ($valores[$i]['idaspectos_seguridad']) && 
                            ($array[$i]['valoracion']) == ($valores[$i]['valoracion'])){
                            $resultado_final = true;
                      
                         $cont++;
                        

                        }else{
                            $resultado_final = "";
                            $resultado = [];
                            $cont=0;
                        }
                    }
               }

    }
    
    return $resultado_final;
}
function validar_valoracion_activo2($array,$idvalor,$id){
    $model = new MValoracionActivo();
    //traigo los datos de la valoracion de activo
    $detalle_EC = $model->getValActivo();
    $resultado_final = false;
    $cont=0;
    foreach ($detalle_EC as $key => $value) {
       
            
                //traigo el dato de la caligicacion segun el array enviado
            
                // $id_calificacion = $model->getById($value2['idCC']);
                if($value['id'] != $id){     
                    //traigo el dato respectivo segun clasificaicon e Id de la evlauacion de control
                    $valores = $model->getDetalleEvaluacionActivo($value['id']);
                        // //hago la compaativa si el valor del array es = al valor de la evaluacion de control 
                    if($cont < count($valores)){
                    
                            // for ($i=0; $i < count($valores) ; $i++) { 
                            //     //$resultado_final = $array[$i];
                            //     if(($array[$i]['idaspecto']) == ($valores[$i]['idaspectos_seguridad']) && 
                            //         ($array[$i]['valoracion']) == ($valores[$i]['valoracion']) &&
                            //         $idvalor == $valores[$i]['idvalor']){
                            //         $resultado_final = true;
                            
                            //     $cont++;
                                

                            //     }else{
                            //         $resultado_final = "";
                            //         $resultado = [];
                            //         $cont=0;
                            //     }
                            // }
                            //aqui tambien
                            for ($i=0; $i < count($valores) ; $i++) { 
                                //$resultado_final = $array[$i];
                                if(($array[$i]['idaspecto']) == ($valores[$i]['idaspectos_seguridad']) && 
                                    ($array[$i]['valoracion']) == ($valores[$i]['valoracion']) ){
                                    $resultado_final = true;
                            
                                $cont++;
                                

                                }else{
                                    $resultado_final = "";
                                    $resultado = [];
                                    $cont=0;
                                }
                            }
                    }
                }
                    
                                            
                        
                        
                          
                    
                

    }
    
    return $resultado_final;
}

