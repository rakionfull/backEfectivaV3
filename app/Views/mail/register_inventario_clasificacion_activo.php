<h1> Información Registrada - <?php
    if($data->ica_estado == '2'){
        echo 'Proceder a Revisar';
    }else if($data->ica_estado == '3'){
        echo 'Corregir las observaciones';
    }else if($data->ica_estado == '4'){
        echo 'Aprobado';
    }
    ?>
</h1>
<p> Activo: <?php echo $data->activo;?></p>
<p> Descripción Activo: <?php echo $data->desc_activo; ?></p>
<p> Propietario: <?php echo $data->des_propietario; ?></p>
<p> Custodio: <?php echo $data->des_custodio; ?></p>
<?php
    foreach (json_decode($data->vals) as $val) {
        echo '<p>'.$val->aspecto.': '.$val->valoracion.'</p>';
    }
?>
<p> Empresa: <?php echo $data->empresa; ?></p>
<p> Área: <?php echo $data->area; ?></p>
<p> Unidad: <?php echo $data->unidad; ?></p>
<p> Macroproceso: <?php echo $data->macroproceso; ?></p>
<p> Proceso: <?php echo $data->proceso; ?></p>
<p> Tipo de activo: <?php echo $data->tipo_activo; ?></p>
<p> Categoría de activo: <?php echo $data->categoria_activo; ?></p>
<p> Ubicación de activo: <?php echo $data->ubicacion_direccion; ?></p>
<p> Valor de activo: <?php echo $data->valor; ?></p>
<p> Clasificación de la información: <?php echo $data->clasificacion; ?></p>
<p> Comentario: <?php echo $data->ica_comentario; ?></p>
<?php
    if($data->ica_estado == '3'){
        echo '<p>Observaciones: '.$data->observacion.'</p>';
    }
?>