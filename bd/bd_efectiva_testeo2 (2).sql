-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-05-2023 a las 23:14:59
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_efectiva_testeo2`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarDetPer` (IN `id_op` INT, IN `estado` INT, IN `columna` VARCHAR(30))   BEGIN
    SET @sql = CONCAT("UPDATE tb_detalle_perfil SET ", columna, " = ", estado, " WHERE id_det_per = ", id_op);
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_evaluacion_riesgos_controles` (IN `id_evaluacion_riesgo` INT, IN `id_control` INT, IN `id_user_added` INT, IN `id_riesgo_param` INT, IN `id_control_param` INT)   BEGIN
	INSERT INTO evaluacion_riesgos_controles(id_evaluacion_riesgo,id_control,id_user_added,
                                             DATE_ADD,idregistro_controles,idevaluacion_riesgo)
 VALUES (id_evaluacion_riesgo,id_control,id_user_added,now(),id_control_param,id_riesgo_param);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_actividades_plan` (IN `idempresa` INT, IN `idarea` INT, IN `idunidad` INT, IN `idposicion` INT, IN `idusuario` INT, IN `descripcion` VARCHAR(150), IN `fecha_inicio` DATETIME, IN `fecha_fin` DATETIME, IN `idalerta` INT, IN `progreso` INT, IN `idUserAdd` INT, IN `idplan` INT)   BEGIN
	INSERT INTO actividades_plan (
        idempresa, idarea, idunidades, idposicion_puesto, idusuario, descripcion, 
		fecha_inicio,
        fecha_fin, 
		idalerta, progreso, id_user_added, DATE_ADD,id_planes)
    VALUES (
        idempresa, idarea, idunidad, idposicion, idusuario, descripcion,
        CONVERT(fecha_inicio,DATETIME),
		CONVERT(fecha_fin,DATETIME),
		idalerta, progreso, idUserAdd, CURRENT_DATE(),idplan);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_AlertSeguimiento` (IN `alerta` VARCHAR(100), IN `valor` INT, IN `descripcion` VARCHAR(100), IN `idUserAdd` INT)   BEGIN
  INSERT INTO alert_seguimiento(alerta, valor, descripcion, id_user_added, DATE_ADD)
  VALUES (alerta, valor, descripcion, idUserAdd, NOW());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_AplicacionImpacto` (IN `disenio` INT, IN `posicion` VARCHAR(50), IN `escenario` INT, IN `descripcion` VARCHAR(100), IN `idUserAdd` INT)   BEGIN
	INSERT INTO aplicacion_impacto(
	   idclasificacion,
	   posicion,descripcion,escenario,id_user_added,DATE_ADD)
    VALUES (
	   disenio,
	   posicion,descripcion,escenario,idUserAdd,CURRENT_DATE());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_AplicacionProbabilidad` (IN `disenio` INT, IN `posicion` VARCHAR(50), IN `escenario` INT, IN `descripcion` VARCHAR(100), IN `idUserAdd` INT)   BEGIN
	INSERT INTO aplicacion_probailidad(
	   idclasificacion,
	   posicion,descripcion,escenario,id_user_added,DATE_ADD)
    VALUES (
	   disenio,
	   posicion,descripcion,escenario,idUserAdd,CURRENT_DATE());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_area` (IN `area` VARCHAR(150), IN `empresa` INT, IN `estado` INT, IN `idUserAdd` INT)   BEGIN
	INSERT INTO area (area,idempresa,estado,id_user_added,DATE_ADD) VALUES(area,empresa,estado,idUserAdd,NOW());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_aspecto` (IN `aspecto` VARCHAR(150), IN `estado` INT, IN `idUserAdd` INT)   BEGIN
	INSERT INTO aspectos_seguridad(aspecto,estado,
id_user_added,DATE_ADD) VALUES(aspecto,estado,idUserAdd,NOW());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_caractControl` (IN `caracteristica` VARCHAR(100), IN `descripcion` VARCHAR(100), IN `estado` INT, IN `peso` VARCHAR(50), IN `valor` VARCHAR(50), IN `condicion` VARCHAR(50), IN `tipo` VARCHAR(50), IN `idOpcion` INT, IN `calificacion` INT, IN `check_tabla` INT, IN `nom_tabla` VARCHAR(100), IN `seleccionable` INT, IN `idUserAdd` INT)   BEGIN
	INSERT INTO caracteristica_control(
	   caracteristica,
	   descripcion,estado,peso,valor,condicion,tipo,idOpcion,clasificacion,check_tabla,nom_tabla,seleccionable,
	   id_user_added,DATE_ADD)
    VALUES (caracteristica,descripcion,estado,peso,valor,condicion,tipo,idOpcion,calificacion,check_tabla,
	   nom_tabla,seleccionable,idUserAdd,CURRENT_DATE());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_catactivo` (IN `categoria` VARCHAR(150), IN `tipo` INT, IN `estado` INT, IN `idUserAdd` INT)   BEGIN
	INSERT INTO categoria_activo
(categoria,estado,idtipo_activo,id_user_added,DATE_ADD)
VALUES
(categoria,estado,tipo,idUserAdd,NOW());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_clasinfo` (IN `clasificacion` VARCHAR(150), IN `descripcion` VARCHAR(150), IN `estado` INT, IN `idUserAdd` INT)   BEGIN
	INSERT INTO clasificacion_informacion
(clasificacion,descripcion,estado,id_user_added,DATE_ADD)
VALUES
(clasificacion,descripcion,estado,idUserAdd,NOW());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_cobertura` (IN `cobertura` VARCHAR(100), IN `descripcion` VARCHAR(100), IN `idUserAdd` INT)   BEGIN
	INSERT INTO cobertura  (cobertura,descripcion,id_user_added,DATE_ADD)
    VALUES (cobertura,descripcion,idUserAdd,CURRENT_DATE());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_detallevaloracionactivo` (IN `idaspectos_seguridad_param` INT, IN `idvaloracion_activo_param` INT, IN `valoracion_param` VARCHAR(50))   BEGIN
	INSERT INTO detalle_valoracion_activo
        (idaspectos_seguridad,idvaloracion_activo,valoracion) 
		VALUES(idaspectos_seguridad_param,idvaloracion_activo_param,valoracion_param);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_detalle_control` (IN `idControl` INT, IN `idCC` INT, IN `nom_tabla` INT, IN `valor` VARCHAR(50))   BEGIN
	INSERT INTO detalle_controles(idControles, idCC, nom_tabla,valor,idcaracteristica_control)
	VALUES (idControl,idCC,nom_tabla,valor,idCC);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_detalle_Evaluacion_Control` (IN `IEC` INT, IN `IDCC` INT)   BEGIN
	INSERT INTO detalle_evaluacion_control(IEC,ID_CC)
    VALUES (IEC,IDCC);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_empresa` (IN `empresa` VARCHAR(150), IN `estado` INT, IN `idUserAdd` INT)   BEGIN
	INSERT INTO empresa	(empresa,estado,id_user_added,DATE_ADD) VALUES(empresa,estado,idUserAdd,NOW());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_estado` (IN `estado` VARCHAR(150), IN `descripcion` VARCHAR(150), IN `idUserAdd` INT)   BEGIN
	INSERT INTO estado  (estado,descripcion,id_user_added,DATE_ADD)
    VALUES (estado, descripcion,idUserAdd,CURRENT_DATE());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_Evaluacion_Control` (IN `calificacion` VARCHAR(50), IN `idUserAdd` INT)   BEGIN
	INSERT INTO evaluacion_control2(calificacion,id_user_added,DATE_ADD)
    VALUES (calificacion,idUserAdd,CURRENT_DATE());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_macroproceso` (IN `area` INT, IN `empresa` INT, IN `unidad` INT, IN `macroproceso` VARCHAR(150), IN `estado` INT, IN `idUserAdd` INT)   BEGIN
	INSERT INTO macroproceso(macroproceso,
idunidades,idempresa,idarea,estado,
id_user_added,DATE_ADD) VALUES(macroproceso,unidad,empresa,area,estado,idUserAdd,NOW());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_plan_accion` (IN `id_riesgo` VARCHAR(150), IN `id_control` VARCHAR(150), IN `plan_accion` VARCHAR(150), IN `descripcion` VARCHAR(150), IN `fecha_inicio` DATE, IN `fecha_fin` DATE, IN `id_user_added` INT, IN `idempresa` INT, IN `idarea` INT, IN `idunidad` INT, IN `idposicion` INT, IN `idusuario` INT, IN `idprioridad` INT, IN `idestado` INT, IN `idalerta` INT)   BEGIN
	 INSERT INTO plan_accion (
        id_riesgo, id_control, plan_accion, descripcion, fecha_inicio, fecha_fin, id_user_added, DATE_ADD,
        idempresa, idarea, idunidades, idposicion_puesto, idusuario, idprioridad, idestado, idalerta)
    VALUES (
        id_riesgo, id_control, plan_accion, descripcion, fecha_inicio, fecha_fin, id_user_added, CURRENT_DATE(),
        idempresa, idarea, idunidad, idposicion, idusuario, idprioridad, idestado, idalerta);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_posicion` (IN `area` INT, IN `empresa` INT, IN `unidad` INT, IN `posicion` VARCHAR(150), IN `estado` INT, IN `idUserAdd` INT)   BEGIN
	INSERT INTO posicion_puesto(posicion_puesto,
idempresa,idarea,idunidades,estado,
id_user_added,DATE_ADD) VALUES(posicion,empresa,area,unidad,estado,idUserAdd,NOW());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_prioridad` (IN `prioridad` VARCHAR(100), IN `descripcion` VARCHAR(100), IN `idUserAdd` INT)   BEGIN
	INSERT INTO prioridad(prioridad, decripcion,id_user_added,DATE_ADD)
	VALUES (prioridad,descripcion,idUserAdd,CURRENT_DATE());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_proceso` (IN `area` INT, IN `empresa` INT, IN `unidad` INT, IN `macroproceso` INT, IN `proceso` VARCHAR(150), IN `estado` INT, IN `idUserAdd` INT)   BEGIN
	INSERT INTO proceso(proceso,idmacroproceso,
idunidades,idempresa,idarea,estado,
id_user_added,DATE_ADD) VALUES(proceso,macroproceso,unidad,
                               empresa,area,estado,idUserAdd,NOW());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_Registro_Controles` (IN `IDR` VARCHAR(100), IN `riesgo` VARCHAR(100), IN `IDC` VARCHAR(100), IN `control` VARCHAR(100), IN `cobertura` INT, IN `evaluacion` VARCHAR(100), IN `estado` INT, IN `idUserAdd` INT, IN `idcc` INT)   BEGIN
	INSERT INTO registro_controles(IDR,riesgo,IDC,nom_control,idCobertura,evaluacion,estado
                                   ,id_user_added,DATE_ADD,idevaluacion_control2 )
    VALUES (IDR,riesgo,IDC,control,cobertura,evaluacion,estado,idUserAdd,now(),idcc);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_tipoactivo` (IN `tipo` VARCHAR(150), IN `estado` INT, IN `idUserAdd` INT)   BEGIN
	INSERT INTO tipo_activo (tipo,estado,id_user_added,DATE_ADD)
VALUES (tipo,estado,idUserAdd,NOW());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_ubiactivo` (IN `continente` VARCHAR(50), IN `pais` VARCHAR(50), IN `ciudad` VARCHAR(50), IN `direccion` VARCHAR(300), IN `descripcion` VARCHAR(300), IN `estado` INT, IN `idUserAdd` INT)   BEGIN
	INSERT INTO ubicacion_activo
(continente,pais,ciudad,direccion,descripcion,estado,id_user_added,DATE_ADD)
VALUES
(continente,pais,ciudad,direccion,descripcion,estado,idUserAdd,NOW());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_unidad` (IN `area` INT, IN `empresa` INT, IN `unidad` VARCHAR(150), IN `estado` INT, IN `idUserAdd` INT)   BEGIN
	INSERT INTO unidades(unidad,idempresa,idarea,estado,
id_user_added,DATE_ADD) VALUES(unidad,empresa,area,estado,idUserAdd,NOW());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_valoracionactivo` (IN `idvalor` INT, IN `idUserAdd` INT)   BEGIN
	INSERT INTO valoracion_activo
        (idvalor,estado,id_user_added,DATE_ADD) 
		VALUES(idvalor,1,idUserAdd,NOW());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_ValoracionRiesgo` (IN `valor` VARCHAR(100), IN `probabilidad` INT, IN `impacto` INT, IN `idUserAdd` INT)   BEGIN
	INSERT INTO valoracion_riesgo(valor,idprobabilidad_riesgo ,idimpacto_riesgo,id_user_added,DATE_ADD)
    VALUES (valor,probabilidad,impacto,idUserAdd,CURRENT_DATE());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_valoractivo` (IN `valor` VARCHAR(150), IN `estado` INT, IN `idUserAdd` INT)   BEGIN
	INSERT INTO valor_activo(valor,estado,
id_user_added,DATE_ADD) VALUES(valor,estado,idUserAdd,NOW());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `aspectosByEstado` ()   begin   
   	SELECT id,aspecto from aspectos_seguridad where estado=1 and is_deleted=0;
  end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `consulta_eliminar_general` (IN `tabla_padre` VARCHAR(50), IN `tabla_hija` VARCHAR(50), IN `id_padre` INT)   BEGIN
 
 
set @smt = concat("SELECT ",tabla_hija,".is_deleted FROM ",tabla_padre," INNER JOIN ",tabla_hija," on ",tabla_padre,".id=",tabla_hija,".id",tabla_padre," where ",tabla_padre,".id=",id_padre,";");
 
prepare smt2 from @smt;
execute smt2;
 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dataReporteMovimientos` (IN `inicio` VARCHAR(50), IN `fin` VARCHAR(50))   BEGIN
  select id as id_reporte,terminal,ip_addres,(SELECT usuario_us from tb_users where id_us=u_ejecutor ) as usuario_ejecutor,accion,fecha
from log_sistema where fecha BETWEEN inicio AND fin;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dataReporteSeguridad` (IN `inicio` VARCHAR(50), IN `fin` VARCHAR(50))   BEGIN
  select id as id_reporte,terminal,ip_addres,(SELECT usuario_us from tb_users where id_us=u_ejecutor ) as usuario_ejecutor,
(SELECT usuario_us from tb_users where id_us=u_afectado ) as usuario_afectado,accion,fecha
from log_acciones where fecha BETWEEN inicio AND fin;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_detalle_control` (IN `idid` INT)   BEGIN
	update detalle_controles set is_deleted=1 where idControles=idid; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_riesgo_control` (IN `idid` INT)   begin
update 
        evaluacion_riesgos_controles set is_deleted=1 where id_control=idid and is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editar_area` (IN `area` VARCHAR(150), IN `empresa` INT, IN `estado` INT, IN `idarea` INT, IN `idUserAdd` INT)   BEGIN
	UPDATE area  
	SET area=area,idempresa=empresa,estado=estado,
    id_user_updated=idUserAdd,
    date_modify = NOW()
	WHERE id=idarea;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editar_aspecto` (IN `aspecto` VARCHAR(150), IN `idaspecto` INT, IN `estado` INT, IN `idUserAdd` INT)   BEGIN
	UPDATE aspectos_seguridad SET
aspecto=aspecto,
estado=estado,
id_user_updated=iduserAdd,
date_modify=NOW()
WHERE id=idaspecto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editar_catactivo` (IN `categoria` VARCHAR(150), IN `idcategoria` INT, IN `tipo` INT, IN `estado` INT, IN `idUserAdd` INT)   BEGIN
UPDATE categoria_activo SET
categoria=categoria,
idtipo_activo = tipo,
estado = estado ,
id_user_updated=iduserAdd,
date_modify=NOW()
WHERE id=idcategoria;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editar_clasinfo` (IN `idclasi` INT, IN `clasificacion` VARCHAR(150), IN `descripcion` VARCHAR(150), IN `estado` INT, IN `idUserAdd` INT)   BEGIN
UPDATE clasificacion_informacion SET
clasificacion=clasificacion,
descripcion=descripcion,
estado = estado ,
id_user_updated=iduserAdd,
date_modify=NOW()
WHERE id=idclasi;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editar_empresa` (IN `empresa` VARCHAR(150), IN `estado` INT, IN `idempresa` INT, IN `idUserAdd` INT)   BEGIN
	UPDATE empresa 
	SET empresa=empresa,estado=estado,
    id_user_updated=idUserAdd,
    date_modify = NOW()
	WHERE id=idempresa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editar_macroproceso` (IN `area` INT, IN `empresa` INT, IN `unidad` INT, IN `macroproceso` VARCHAR(150), IN `estado` INT, IN `idmacroproceso` INT, IN `idUserAdd` INT)   BEGIN
	UPDATE macroproceso   
	SET 
    idarea=area,
    idempresa=empresa,
    idunidades=unidad,
    macroproceso=macroproceso,
    estado=estado,
    id_user_updated=idUserAdd,
    date_modify = NOW()
	WHERE id=idmacroproceso;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editar_posicion` (IN `area` INT, IN `empresa` INT, IN `unidad` INT, IN `posicion` VARCHAR(150), IN `idposicion` INT, IN `estado` INT, IN `idUserAdd` INT)   BEGIN
	UPDATE posicion_puesto SET
idarea=area,
idempresa=empresa,
idunidades=unidad,
posicion_puesto=posicion,
estado=estado,
id_user_updated=iduserAdd,
date_modify=NOW()
WHERE id=idposicion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editar_proceso` (IN `area` INT, IN `empresa` INT, IN `unidad` INT, IN `macroproceso` INT, IN `proceso` VARCHAR(150), IN `idproceso` INT, IN `estado` INT, IN `idUserAdd` INT)   BEGIN
	UPDATE proceso   
	SET 
    idarea=AREA,
idempresa=empresa,
idunidades=unidad,
idmacroproceso=macroproceso,
proceso=proceso,
estado=estado,
id_user_updated=iduserAdd,
date_modify=NOW()
WHERE id=idproceso;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editar_tipoactivo` (IN `tipo` VARCHAR(150), IN `idtipo` INT, IN `estado` INT, IN `idUserAdd` INT)   BEGIN
UPDATE tipo_activo SET
tipo = tipo,
estado = estado ,
id_user_updated=iduserAdd,
date_modify=NOW()
WHERE id=idtipo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editar_ubiactivo` (IN `idubiactivo` INT, IN `continente` VARCHAR(50), IN `pais` VARCHAR(50), IN `ciudad` VARCHAR(50), IN `direccion` VARCHAR(300), IN `descripcion` VARCHAR(300), IN `estado` INT, IN `idUserAdd` INT)   BEGIN
UPDATE ubicacion_activo SET
continente=continente,
pais=pais,
ciudad=ciudad,
direccion=direccion,
descripcion=descripcion,
estado = estado ,
id_user_updated=iduserAdd,
date_modify=NOW()
WHERE id=idubiactivo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editar_unidad` (IN `area` INT, IN `empresa` INT, IN `unidad` VARCHAR(150), IN `estado` INT, IN `idunidad` INT, IN `idUserAdd` INT)   BEGIN
	UPDATE unidades  
	SET idarea=AREA,
    idempresa=empresa,
    unidad=unidad,
    estado=estado,
    id_user_updated=idUserAdd,
    date_modify = NOW()
	WHERE id=idunidad;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editar_valoracionactivo` (IN `idvalor` INT, IN `idvaloracion` INT, IN `idUserAdd` INT)   BEGIN
	UPDATE valoracion_activo SET
		idvalor=idvalor,	
id_user_updated=iduserAdd,
date_modify=NOW()
WHERE id=idvaloracion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editar_valoractivo` (IN `valor` VARCHAR(150), IN `idvalor` INT, IN `estado` INT, IN `idUserAdd` INT)   BEGIN
	UPDATE valor_activo  SET
valor=valor,
estado=estado,
id_user_updated=iduserAdd,
date_modify=NOW()
WHERE id=idvalor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_actividades_plan` (IN `idid` INT, IN `idUserDel` INT)   BEGIN
	UPDATE actividades_plan SET 
	id_user_deleted = idUserDel,
	date_deleted = CURRENT_DATE(),
	is_deleted = 1
    WHERE id = idid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_alertSeguimiento` (IN `idUserAdd` INT, IN `idAlerta` INT)   BEGIN
	UPDATE alert_seguimiento  SET
	id_user_deleted=idUserAdd,
	date_deleted=CURRENT_DATE(),
	is_deleted=1
	WHERE id=idAlerta;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_AplicacionImpacto` (IN `idUserAdd` INT, IN `idAplicacionImpacto` INT)   BEGIN
	UPDATE aplicacion_probailidad  SET
	id_user_deleted=idUserAdd,
	date_deleted=CURRENT_DATE(),
	is_deleted=1
	WHERE id= idAplicacionImpacto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_AplicacionProbabilidad` (IN `idUserAdd` INT, IN `idAplicacionProbabilidad` INT)   BEGIN
	UPDATE aplicacion_probailidad  SET
	id_user_deleted=idUserAdd,
	date_deleted=CURRENT_DATE(),
	is_deleted=1
	WHERE id= idAplicacionProbabilidad;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_caractControl` (IN `idUserAdd` INT, IN `idCaractControl` INT)   BEGIN
	UPDATE caracteristica_control  SET
	id_user_deleted=idUserAdd,
	date_deleted=CURRENT_DATE(),
	is_deleted=1
	WHERE id=idCaractControl;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_cobertura` (IN `idUserAdd` INT, IN `idCobertura` INT)   BEGIN
	UPDATE cobertura  SET
	id_user_deleted=idUserAdd,
	date_deleted=CURRENT_DATE(),
	is_deleted=1
	WHERE id=idCobertura;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_estado` (IN `idUserAdd` INT, IN `idEstado` INT)   BEGIN
	UPDATE estado  SET
	id_user_deleted=idUserAdd,
	date_deleted=CURRENT_DATE(),
	is_deleted=1
	WHERE id=idEstado;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_Evaluacion_Control` (IN `idUserAdd` INT, IN `idEvaluacionControl` INT)   BEGIN
	UPDATE evaluacion_control2  SET
	id_user_deleted=idUserAdd,
	date_deleted=CURRENT_DATE(),
	is_deleted=1
	WHERE id= idEvaluacionControl;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_general` (IN `dato` VARCHAR(150))   begin   
   
SELECT TABLE_NAME FROM information_schema.KEY_COLUMN_USAGE WHERE REFERENCED_TABLE_NAME = dato AND
CONSTRAINT_SCHEMA='bd_efectiva_testeo2';
  end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_plan_accion` (IN `id` INT, IN `id_user_deleted` INT)   BEGIN
	UPDATE plan_accion
    SET id_user_deleted = id_user_deleted,
	is_deleted = 1,
	date_deleted = CURRENT_DATE()
    WHERE id = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_prioridad` (IN `idUserAdd` INT, IN `idPrioridad` INT)   BEGIN
	UPDATE prioridad  SET
	id_user_deleted=idUserAdd,
	date_deleted=CURRENT_DATE(),
	is_deleted=1
	WHERE id=idPrioridad;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_Registro_Controles` (IN `idUserAdd` INT, IN `idControl` INT)   BEGIN
	UPDATE  registro_controles SET
	id_user_deleted=idUserAdd,
	date_deleted=CURRENT_DATE(),
	is_deleted=1
	WHERE id=idControl;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_ValoracionRiesgo` (IN `idUserAdd` INT, IN `idValoracionRiesgo` INT)   BEGIN
	UPDATE valoracion_riesgo  SET
	id_user_deleted=idUserAdd,
	date_deleted=CURRENT_DATE(),
	is_deleted=1
	WHERE id= idValoracionRiesgo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getActividadesByPlan` (IN `idplan` INT)   begin
select * from actividades_plan as AP inner join plan_accion as PA on PA.id=AP.id_planes  where AP.id_planes=idplan and AP.is_deleted=0 and PA.is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllItems` ()   BEGIN
    SELECT * FROM tb_item order by id_op ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllModulos` ()   BEGIN
    SELECT * FROM tb_modulo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAspectoByActivo` ()   BEGIN
	SELECT * FROM aspectos_seguridad WHERE estado='1' AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getById` (IN `idid` INT)   begin
SELECT id from caracteristica_control 
        where is_deleted=0 and clasificacion =1 and idOpcion=idid;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getByIdSesion` (IN `id` INT, IN `iat` VARCHAR(100))   begin
	SELECT  * from tb_sesiones
         where id_us=id and expi > iat and loged='1' ORDER BY id_se LIMIT 1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCaractControl` ()   begin
	SELECT * FROM caracteristica_control where tipo='menu' and is_deleted=0 ;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCaractControlById` (IN `id` INT)   begin
	SELECT * FROM caracteristica_control 
                    where is_deleted=0  and idOpcion=id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCCMenu` ()   begin
select * from caracteristica_control where tipo = 'menu' and is_deleted=0 and estado= 1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCCOpciones` ()   begin
  select * from caracteristica_control where tipo =
         'opcion' and is_deleted=0 and estado= 1 and clasificacion=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCCSubMenu` ()   begin
select *
         from caracteristica_control where 
         tipo = 'submenu' and is_deleted=0 and estado= 1 and clasificacion=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCiudad` (IN `dato` VARCHAR(30))   begin
SELECT * FROM ciudad where ubicacionpaisid=dato;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCoberturaByActivo` ()   begin
  select * from cobertura where is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getComboPosicion` ()   BEGIN
	SELECT * FROM posicion_puesto WHERE estado='1' AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getConfigPass` ()   begin
SELECT * FROM  config_pass;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getContinente` ()   begin
SELECT * FROM continente where ContinenteCodigo='América';
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCorreoActividad` ()   begin
	SELECT AP.progreso as progreso,AP.id as id_act,PA.plan_accion,AP.descripcion as descripcion,TU.id_us,TU.email_us,A.valor,AP.fecha_inicio as 
        fecha_ini,
        AP.fecha_fin as fecha_fin,TU.nombres_us,TU.apepat_us,TU.apemat_us ,A.alerta as alerta
        from actividades_plan as AP  inner join alert_seguimiento as A on AP.idalerta=A.id
        inner join tb_users as TU on AP.idusuario = TU.id_us  inner join plan_accion as PA on PA.id=AP.id_planes
        where AP.is_deleted = 0 and PA.is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCorreoActividadesEnviados` (IN `id` INT)   begin
	SELECT * FROM correo_actividad where idactividad= id ORDER BY id DESC LIMIT 1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCorreoPlan` ()   begin
	SELECT PA.id,TU.id_us as usuario, E.id as estado ,
         PA.plan_accion,TU.email_us,E.estado as estado_plan,A.valor,PA.fecha_inicio as fecha_ini,
         PA.fecha_fin as fecha_fin,TU.nombres_us,TU.apepat_us,TU.apemat_us ,A.alerta as alerta
        FROM plan_accion as PA inner join tb_users as TU on PA.idusuario = TU.id_us 
        inner join alert_seguimiento as A on A.id=PA.idalerta inner join estado as E on PA.idestado = E.id
        where PA.is_deleted = 0 ;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCorreoPlanEnviados` (IN `id` INT)   begin
	SELECT * FROM correo_plan where idplan= id ORDER BY id DESC LIMIT 1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getData2` (IN `tabla` VARCHAR(150))   begin
 SELECT * FROM tabla where is_deleted=0 and estado=1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getDataMatriz` ()   begin
SELECT  concat(PR.valor1,' - ',PR.valor2) as valorProbabilidad 
          ,concat(IR.valor1,' - ',IR.valor2) as  valorImpacto,VR.id,VR.idprobabilidad_riesgo,VR.idimpacto_riesgo,VR.valor, 
           PR.descripcion as probabilidad, IR.descripcion as impacto
           from valoracion_riesgo as VR inner join probabilidad_riesgo as PR 
           on VR.idprobabilidad_riesgo = PR.id inner join impacto_riesgo as IR on VR.idimpacto_riesgo=IR.id
          where VR.is_deleted=0 and PR.estado=1  and  IR.estado=1  and PR.tipo_regla='2 Valores' 
          and IR.tipo_regla='2 Valores' order by valorProbabilidad DESC;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getDatosCorreo` ()   BEGIN
	SELECT * from datos_correo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getDetalleEvaluacionActivo` (IN `idid` INT)   begin
select * from detalle_valoracion_activo as DVA
inner join aspectos_seguridad as ass on ass.id=DVA.idaspectos_seguridad
inner join valoracion_activo as VA on DVA.idvaloracion_activo=VA.id
WHERE VA.id=idid and DVA.is_deleted=0 and ass.is_deleted=0 and ass.estado=1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getDetalleEvaluacionControl` (IN `idid` INT)   begin
select DET.id as IDET,DET.ID_CC,
        CC.idOpcion,CC.caracteristica as caracteristica,EC.id as id, 
        EC.calificacion as calificacion from evaluacion_control2 as 
        EC inner join detalle_evaluacion_control as DET on 
        EC.id=DET.IEC
        inner join caracteristica_control as CC on CC.id=DET.ID_CC 
        where EC.id=idid order by CC.idOpcion;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getDetPerfil` (IN `idid` INT)   begin
SELECT * from tb_perfiles
         where id_perfil=idid and is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getEscenario` ()   BEGIN
    SELECT escenario FROM escenario_active INTO @escenario;
    SELECT @escenario AS escenario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getEvaluacionControl` ()   begin
select * from 
        evaluacion_control2 where is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getOpcionesCaracteristica` (IN `idtipo` VARCHAR(150))   begin
SELECT * from caracteristica_control where is_deleted=0 and estado=1 and tipo=idtipo order by date_add;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getPaises` (IN `dato` VARCHAR(30))   begin
SELECT * FROM pais where continente=dato;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getPerfilById` (IN `id_post` INT)   BEGIN
 SELECT * FROM  tb_perfiles where id_perfil=id_post;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getPlanByRiesgos` (IN `idid` INT)   begin

       select * from plan_accion where id=idid and is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getPlanControl` ()   begin
select * from 
        registro_controles where is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getPosicionByArea` (IN `idarea` INT)   BEGIN
	SELECT PP.id AS id_pos,PP.posicion_puesto,PP.idempresa,PP.idunidad,PP.idarea,
        E.empresa,A.area,U.unidad,PP.estado FROM posicion_puesto AS PP INNER JOIN empresa AS E
        ON PP.idempresa=E.id INNER JOIN area AS A ON PP.idarea=A.id 
        INNER JOIN unidades AS U ON PP.idunidades=U.id
        WHERE pp.idarea=idarea;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getPosicionByUnidad` (IN `empresa` INT, IN `area` INT, IN `unidad` INT)   BEGIN
	SELECT PP.id AS id_pos,PP.posicion_puesto,PP.idempresa,PP.idunidades,PP.idarea,
        E.empresa,A.area,U.unidad,PP.estado FROM posicion_puesto AS PP INNER JOIN empresa AS E
        ON PP.idempresa=E.id INNER JOIN area AS A ON PP.idarea=A.id 
        INNER JOIN unidades AS U ON PP.idunidades=U.id
        WHERE PP.idarea=area AND PP.idempresa=empresa AND PP.idunidades=unidad;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getRegistroControl` (IN `idid` INT)   begin
select * from registro_controles 
        where id=idid;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getRegistroControles` ()   begin
select * from 
        registro_controles where is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getRegistroControles2` ()   begin
SELECT *,RC.id as IDRC ,RC.estado as RCEstado,DC.valor as RCValor from registro_controles  as RC 
        inner join detalle_controles as DC on RC.id=DC.idControles inner join caracteristica_control as CC 
        on DC.idCC=CC.id where RC.is_deleted=0 and DC.is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getRegistroDetalleControl` (IN `idid` INT)   begin
select * from 
        detalle_controles where idControles=idid and is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getTabla` (IN `idid` INT)   begin
 SELECT nom_tabla FROM catalogo_tabla where id=idid;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getTipoActivoByActivo` ()   BEGIN
	SELECT * FROM tipo_activo 
         WHERE estado='1' AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getTipoRiesgosByActivo` ()   BEGIN
	SELECT * FROM tipo_riesgo WHERE is_deleted=0 AND estado=1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserByArea` (IN `area_id` INT)   BEGIN
    SELECT * FROM tb_users WHERE estado_us='1' AND idarea=area_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserByAreaBCC` (IN `area_id` INT)   BEGIN
    SELECT * FROM tb_users
    inner join tb_perfiles on tb_perfiles.id_perfil=tb_users.perfil_us
    WHERE tb_users.estado_us='1' AND tb_users.idarea=area_id and tb_users.is_deleted=0 and tb_perfiles.is_user_negocio=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserByDatos` (IN `user_pass` VARCHAR(50))   BEGIN
	SELECT *,TP.is_user_negocio AS negocio FROM  tb_users AS TU INNER JOIN tb_historial_claves AS TH
        ON TU.id_us=TH.id_us INNER JOIN tb_perfiles AS TP ON TP.id_perfil=TU.perfil_us
		WHERE TU.usuario_us=user_pass AND estado_us='1'  ORDER BY TH.id_cl DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserNombreByActivo` ()   BEGIN
    SELECT nombres_us, apepat_us, apemat_us FROM tb_users WHERE estado_us='1';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getValorActivoByActivo` ()   BEGIN
	SELECT * FROM valor_activo WHERE estado='1' AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_items` ()   BEGIN
    SELECT * FROM tb_item ORDER BY id_op ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_opciones` ()   BEGIN
    SELECT * FROM tb_opcion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_item` (IN `id_perfil` INT)   BEGIN
    SELECT *
    FROM tb_detalle_perfil AS DP
    INNER JOIN tb_item AS TI ON DP.id = TI.id_item
    WHERE DP.tabla = 'tb_item' AND DP.id_perfil = id_perfil
    ORDER BY TI.id_op, TI.id_item ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_opcion` (IN `idid_perfil` INT)   BEGIN
    SELECT * FROM tb_detalle_perfil AS DP
    INNER JOIN tb_opcion AS T ON DP.id = T.id_op
    WHERE DP.tabla = 'tb_opcion' AND DP.id_perfil = idid_perfil;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_Plan_Control` (IN `id` INT)   BEGIN
	SELECT PA.id,(SELECT COUNT(*) FROM actividades_plan WHERE id_planes = PA.id) AS actividades,PA.*
	FROM plan_accion AS PA   WHERE PA.is_deleted=0 AND PA.id = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_users_activos` ()   BEGIN
    SELECT * FROM tb_users WHERE estado_us = '1';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_by_empresa` (IN `empresa_id` INT, IN `area_id` INT, IN `unidad_id` INT, IN `posicion_id` INT)   BEGIN
    SELECT * FROM tb_users WHERE estado_us = '1' AND idempresa = empresa_id AND idarea = area_id
    and idunidad=unidad_id and idposicion=posicion_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarDetallePerfil` (IN `perfil_id` INT, IN `tabla` VARCHAR(50), IN `registro_id` INT)   BEGIN
  INSERT INTO tb_detalle_perfil
    (id_perfil, tabla, id, view_det, create_det, update_det, delete_det)
  VALUES
    (perfil_id, tabla, registro_id, 0, 0, 0, 0);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertCorreoActividad` (IN `id_param` INT, IN `fecha_param` DATETIME, IN `user_param` INT)   BEGIN
   insert into correo_actividad(idactividad,fecha_envio,idusuario)
   VALUES( id_param,fecha_param,user_param);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertCorreoPlan` (IN `id` INT, IN `fecha` DATETIME, IN `usuario` INT)   begin
	INSERT INTO correo_plan (idplan,fecha_envio,idusuario) 
        VALUES (id,fecha,usuario);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LastIdControles` ()   begin
SELECT MAX(id) as last_id from registro_controles;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lastIdValoracionActivo` ()   BEGIN
	SELECT MAX(id) as lastid FROM valoracion_activo ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `last_id_Evaluacion_Control` ()   BEGIN
	SELECT  id AS maxid FROM evaluacion_control2 ORDER BY id DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `last_id_Registro_Proceso` ()   BEGIN
	SELECT  id AS maxid FROM registro_controles ORDER BY id DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listaCategoriaByActivo` (IN `idactivo` INT)   BEGIN
	SELECT * FROM categoria_activo WHERE idtipo_activo=idactivo AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listaProcesoByEstado` ()   BEGIN
	SELECT * FROM proceso 
            WHERE estado='1' ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listaProcesoByMacro` (IN `empresa` INT, IN `area` INT, IN `unidad` INT, IN `macroproceso` INT)   BEGIN
	SELECT * FROM proceso WHERE idempresa=empresa AND idarea=area AND
    idunidades=unidad AND idmacroproceso=macroproceso AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarArea` ()   BEGIN
	SELECT A.id,A.idempresa,E.empresa,A.area,A.estado
                FROM empresa AS E INNER JOIN area AS A ON A.idempresa = E.id WHERE A.is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarAreaByActivo` (IN `empresa` INT)   BEGIN
	SELECT * FROM area
            WHERE estado=1 and idempresa=empresa AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarAreaEmpresa` (IN `dato` INT)   BEGIN
	SELECT A.id,A.idempresa,E.empresa,A.area,A.estado
            FROM empresa AS E INNER JOIN area AS A 
			ON A.idempresa = E.id WHERE A.idempresa=dato and A.is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarAspecto` ()   BEGIN
	SELECT * FROM 
        aspectos_seguridad WHERE is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarAspectoSeguridadByActivo` ()   BEGIN 

SELECT * FROM aspectos_seguridad where estado=1 and is_deleted=0;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarcatactivo` ()   BEGIN
	SELECT CA.id,CA.categoria,CA.estado,CA.idtipo_activo,
TA.tipo FROM categoria_activo AS CA INNER JOIN 
tipo_activo AS TA ON CA.idtipo_activo=TA.id 
WHERE CA.is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarclasinfo` ()   BEGIN
	SELECT * FROM clasificacion_informacion WHERE is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarclasinfoByActivo` ()   BEGIN
    SELECT * FROM clasificacion_informacion where is_deleted=0 and estado=1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarEmpresa` ()   BEGIN
	SELECT * FROM empresa WHERE is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarEmpresaByAcivo` ()   BEGIN
	SELECT * FROM empresa WHERE estado='1' AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarMacroEmpresa` (IN `dato` INT)   BEGIN
	SELECT M.id, M.macroproceso,E.empresa,A.area,U.unidad,M.estado,M.idempresa,
            M.idarea,M.idunidades
            FROM macroproceso AS M INNER JOIN empresa AS E ON M.idempresa=E.id
                                    INNER JOIN area AS A ON M.idarea=A.id
                                    INNER JOIN unidades AS U ON M.idunidades=U.id WHERE E.id = dato AND M.is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarMacroproceso` ()   BEGIN
	SELECT M.id, M.macroproceso,E.empresa,A.area,U.unidad,M.estado,M.idempresa,
            M.idarea,M.idunidades
            FROM macroproceso AS M INNER JOIN empresa AS E ON M.idempresa=E.id INNER JOIN area AS A ON M.idarea=A.id INNER JOIN unidades AS U ON M.idunidades=U.id AND M.is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarMacroprocesoByActivo` (IN `empresa` INT, IN `area` INT, IN `unidad` INT)   BEGIN
	SELECT * FROM macroproceso  
            WHERE estado='1' 
			AND idempresa=empresa
			AND idarea=area
            AND idunidades=unidad and is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarPosicion` ()   BEGIN
	SELECT PP.id AS id_pos,PP.posicion_puesto,PP.idempresa,PP.idunidades,PP.idarea,
            E.empresa,A.area,U.unidad,PP.estado FROM posicion_puesto AS PP INNER JOIN empresa AS E
            ON PP.idempresa=E.id INNER JOIN area AS A ON PP.idarea=A.id 
            INNER JOIN unidades AS U ON PP.idunidades=U.id WHERE PP.is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarPosicionEmpresa` (IN `dato` INT)   BEGIN
	SELECT PP.id AS id_pos,PP.posicion_puesto,PP.idempresa,PP.idunidades,PP.idarea,
            E.empresa,A.area,U.unidad,PP.estado FROM posicion_puesto AS PP INNER JOIN empresa AS E
            ON PP.idempresa=E.id INNER JOIN area AS A ON PP.idarea=A.id 
            INNER JOIN unidades AS U 
			ON PP.idunidades=U.id WHERE E.id=dato 
            AND PP.is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarProceso` ()   BEGIN
	SELECT P.id,P.proceso,E.empresa,A.area,U.unidad,M.macroproceso,P.estado,
            P.idempresa,P.idarea,P.idunidades,P.idmacroproceso
            FROM proceso AS P INNER JOIN empresa AS E ON P.idempresa=E.id
                                    INNER JOIN area AS A ON P.idarea=A.id
                                    INNER JOIN unidades AS U ON P.idunidades=U.id												   
                                    INNER JOIN macroproceso AS M ON P.idmacroproceso = M.id AND P.is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarProcesoEmpresa` (IN `dato` INT)   BEGIN
	SELECT P.id,P.proceso,E.empresa,A.area,U.unidad,M.macroproceso,P.estado,
            P.idempresa,P.idarea,P.idunidades,P.idmacroproceso
            FROM proceso AS P INNER JOIN empresa AS E ON P.idempresa=E.id
                                    INNER JOIN area AS A ON P.idarea=A.id
                                    INNER JOIN unidades AS U ON P.idunidades=U.id												   
                                    INNER JOIN macroproceso AS M ON P.idmacroproceso = M.id 
									WHERE E.id = dato AND P.is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listartipoactivo` ()   BEGIN
	SELECT * FROM tipo_activo WHERE is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarubiactivo` ()   BEGIN
	SELECT UA.id,UA.continente,UA.pais,UA.ciudad,UA.estado,UA.direccion,
        UA.descripcion,C.PaisContinente,P.paisnombre ,CI.estadonombre FROM ubicacion_activo AS UA 
        INNER JOIN continente AS C ON UA.continente=C.ContinenteCodigo INNER JOIN
        pais AS P ON UA.pais=P.id INNER JOIN ciudad AS CI 
        ON UA.ciudad=CI.id WHERE UA.is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarUnidadByActivo` (IN `empresa` INT(12), IN `area` INT(12))   BEGIN
	SELECT * FROM unidades 
            WHERE estado=1 and
			 idempresa=empresa
			AND idarea=area
			AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarUnidadByEstado` ()   BEGIN
SELECT * FROM unidades WHERE estado='1';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarUnidadEmpresa` (IN `dato` INT)   BEGIN
	SELECT U.id,U.unidad,E.empresa,A.area,U.estado,U.idempresa,U.idarea
            FROM unidades AS U INNER JOIN empresa AS E ON U.idempresa = E.id
                               INNER JOIN area AS A ON U.idarea = A.id 
							   WHERE E.id  = dato AND U.is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarUnidades` ()   BEGIN
	SELECT U.id,U.unidad,E.empresa,A.area,U.estado,U.idempresa,U.idarea
            FROM unidades AS U INNER JOIN empresa AS E ON U.idempresa = E.id
                               INNER JOIN area AS A ON U.idarea = A.id AND U.is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarValoracionActivo` ()   BEGIN
	SELECT * from valoracion_activo where is_deleted=0 and estado=1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listarValorActivo` ()   BEGIN
	SELECT * FROM 
        valor_activo WHERE is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_actividadesByPlan` (IN `id_planes` INT)   BEGIN
	SELECT PA.id, 
		(SELECT empresa FROM empresa WHERE idempresa=id) AS empresa,
		(SELECT area FROM area WHERE idarea=id) AS area,
		(SELECT unidad FROM unidades WHERE idunidades=id) AS unidad,
		(SELECT posicion_puesto FROM posicion_puesto WHERE idposicion=id) AS posicion,
		(SELECT nombres_us FROM tb_users WHERE id_us=idusuario) AS nombre,
		descripcion,
		fecha_inicio,
		fecha_fin	
	FROM actividades_plan AS PA
	WHERE is_deleted=0 AND id_planes = id_planes;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_actividades_plan` (IN `idid` INT)   BEGIN
	SELECT AP.id,AP.idempresa,AP.idarea,AP.idunidades,AP.idposicion_puesto,AP.idusuario,AP.idalerta,
	(SELECT empresa FROM empresa WHERE id=AP.idempresa) AS empresa,
	(SELECT area FROM area WHERE id=AP.idarea) AS area,
	(SELECT unidad FROM unidades WHERE id=AP.idunidades) AS unidad,
	(SELECT posicion_puesto FROM posicion_puesto WHERE id=AP.idposicion_puesto) AS posicion,
	(SELECT nombres_us FROM tb_users WHERE id_us=AP.idusuario) AS nombre,
	AP.descripcion,
	AP.fecha_inicio,
	AP.fecha_fin,AP.progreso
	FROM plan_accion AS PA INNER JOIN actividades_plan AS AP ON PA.id=AP.id_planes
	WHERE AP.is_deleted=0 AND PA.id = idid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_alert_seguimiento` ()   BEGIN
	SELECT * FROM alert_seguimiento WHERE is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_AplicacionImpacto` (IN `idescenario` INT)   BEGIN
	SELECT id,idclasificacion,(SELECT calificacion FROM evaluacion_control2 WHERE id=idclasificacion) AS disenio,
	posicion,descripcion,escenario
	FROM aplicacion_impacto  WHERE is_deleted=0 AND escenario=idescenario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_AplicacionProbabilidad` (IN `idescenario` INT)   BEGIN
	SELECT id,idclasificacion,(SELECT calificacion FROM evaluacion_control2 WHERE id=idclasificacion) AS disenio,
	posicion,descripcion,escenario
	FROM aplicacion_probailidad 
	WHERE is_deleted=0 AND escenario=idescenario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_caractControl` ()   BEGIN
	SELECT * FROM caracteristica_control WHERE is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_cobertura` ()   BEGIN
	SELECT * FROM cobertura where is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_detalle_plan` (IN `id` INT)   BEGIN
	SELECT COUNT(*) AS actividades FROM actividades_plan WHERE id_planes= id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_estado` ()   BEGIN
	SELECT * FROM estado WHERE is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_Evaluacion_Control` ()   BEGIN
	SELECT id,idDisenio,(SELECT caracteristica FROM caracteristica_control WHERE id=idDisenio) AS disenio,
	idOperatividad,(SELECT caracteristica FROM caracteristica_control WHERE id=idOperatividad) AS operatividad,calificacion
	FROM evaluacion_control AS EC 
	WHERE is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_ImpactoRiesgoByActivo` ()   BEGIN
	SELECT *
	FROM impacto_riesgo
    WHERE is_deleted=0 AND estado=1 AND tipo_regla='2 Valores'  ORDER BY valor1 ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_plan_accion` (IN `empresa_param` INT)   BEGIN
	SELECT id,plan_accion, 
	(SELECT COUNT(*) FROM actividades_plan WHERE id_planes = PA.id and is_deleted=0) AS actividades,	
	descripcion,idarea,(SELECT area FROM area WHERE id = idarea) AS responsable, idestado,
	(SELECT estado FROM estado WHERE id=idestado) AS estado,
	idprioridad,(SELECT prioridad FROM prioridad WHERE id=idprioridad) AS prioridad, fecha_inicio, fecha_fin 
	FROM plan_accion AS PA
	WHERE is_deleted=0 and PA.idempresa=empresa_param;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_prioridad` ()   BEGIN
	SELECT *
	FROM prioridad WHERE is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_ProbabilidadRiesgoByActivo` ()   BEGIN
	SELECT *
	FROM probabilidad_riesgo WHERE is_deleted=0 AND estado=1 AND tipo_regla='2 Valores'  ORDER BY valor1 DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_riesgos` ()   BEGIN
	SELECT * FROM evaluacion_riesgo WHERE is_deleted=0 AND estado = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_ValoracionRiesgo` ()   BEGIN
	SELECT VR.id,VR.idprobabilidad_riesgo,VR.idimpacto_riesgo,VR.valor, 
	PR.descripcion AS probabilidad, IR.descripcion AS impacto
	FROM valoracion_riesgo AS VR INNER JOIN probabilidad_riesgo AS PR 
	ON VR.idprobabilidad_riesgo = PR.id INNER JOIN impacto_riesgo AS IR ON VR.idimpacto_riesgo=IR.id
	WHERE VR.is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modificar_actividades_plan` (IN `idid` INT, IN `idempresa` INT, IN `idarea` INT, IN `idunidad` INT, IN `idposicion` INT, IN `idusuario` INT, IN `descripcion` VARCHAR(150), IN `fecha_inicio` DATETIME, IN `fecha_fin` DATETIME, IN `idalerta` INT, IN `progreso` INT, IN `idUserModify` INT)   BEGIN
	UPDATE actividades_plan SET 
        idempresa = idempresa,
        idarea = idarea,
        idunidades = idunidad,
        idposicion_puesto = idposicion,
        idusuario = idusuario,
        descripcion = descripcion,
        fecha_inicio = fecha_inicio,
        fecha_fin = fecha_fin,
        idalerta = idalerta,
        progreso = progreso,        
        id_user_updated = idUserModify,
        date_modify = CURRENT_DATE()
		WHERE id = idid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modificar_AlertSeguimiento` (IN `alerta` VARCHAR(150), IN `valor` INT, IN `descripcion` VARCHAR(150), IN `idUserAdd` INT, IN `idAlerta` INT)   BEGIN
	UPDATE alert_seguimiento  SET
	alerta=alerta,
	valor=valor,
	descripcion= descripcion,
	id_user_updated=idUserAdd,
	date_modify=CURRENT_DATE() WHERE id=idAlerta;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modificar_AplicacionImpacto` (IN `disenio` INT, IN `posicion` VARCHAR(50), IN `escenario` INT, IN `descripcion` VARCHAR(100), IN `idUserAdd` INT, IN `idAplicacionImpacto` INT)   BEGIN
	UPDATE aplicacion_impacto  SET
	idclasificacion=disenio,
	posicion= posicion,
	descripcion= descripcion,
	escenario= escenario,
	id_user_updated=idUserAdd,
	date_modify=now() WHERE id=idAplicacionImpacto;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modificar_AplicacionProbabilidad` (IN `disenio` INT, IN `posicion` VARCHAR(50), IN `escenario` INT, IN `descripcion` VARCHAR(100), IN `idUserAdd` INT, IN `idAplicacionProbabilidad` INT)   BEGIN
	UPDATE aplicacion_probailidad  SET
	idclasificacion=disenio,
	posicion= posicion,
	descripcion= descripcion,
	escenario= escenario,
	id_user_updated=idUserAdd,
	date_modify=now() WHERE id=idAplicacionProbabilidad;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modificar_caractControl` (IN `idcaracteristica` VARCHAR(100), IN `iddescripcion` VARCHAR(100), IN `idestado` INT, IN `idpeso` VARCHAR(50), IN `idvalor` VARCHAR(50), IN `idcondicion` VARCHAR(50), IN `idcheck_tabla` INT, IN `idnom_tabla` VARCHAR(100), IN `idcalificacion` INT, IN `idseleccionable` INT, IN `idUserAdd` INT, IN `idCaractControl` INT)   BEGIN
	UPDATE caracteristica_control  SET
	   caracteristica=idcaracteristica,
	   descripcion= iddescripcion,
	   estado= idestado,
	   peso = idpeso,
	   valor = idvalor,
	   condicion = idcondicion,
	   check_tabla=idcheck_tabla,
	   nom_tabla=idnom_tabla,
	   clasificacion=idcalificacion,
	   seleccionable=idseleccionable,
	   id_user_updated=idUserAdd,
	   date_modify=CURRENT_DATE() WHERE id=idCaractControl;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modificar_cobertura` (IN `cobertura` VARCHAR(100), IN `descripcion` VARCHAR(100), IN `idUserAdd` INT, IN `idCobertura` INT)   BEGIN
	UPDATE cobertura  SET
	cobertura=cobertura,
	descripcion= descripcion,
	id_user_updated=idUserAdd,
	date_modify=CURRENT_DATE() WHERE id=idCobertura;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modificar_detalle_control` (IN `idvalor` VARCHAR(50), IN `idControl` INT, IN `ididCC` INT)   BEGIN
	UPDATE  detalle_controles SET
	valor=idvalor WHERE idControles=idControl AND idCC=ididCC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modificar_estado` (IN `estado` VARCHAR(150), IN `descripcion` VARCHAR(150), IN `idUserAdd` INT, IN `idEstado` INT)   BEGIN
	UPDATE estado  SET
	   estado=estado,
	   descripcion= descripcion,
	   id_user_updated=idUserAdd,
	   date_modify=CURRENT_DATE() WHERE id=idEstado;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modificar_Evaluacion_Control` (IN `idcalificacion` VARCHAR(50), IN `idUserAdd` INT, IN `idEvaluacionControl` INT)   BEGIN
	UPDATE evaluacion_control2  SET
	calificacion= idcalificacion,
	id_user_updated=idUserAdd,
	date_modify=now() WHERE id=idEvaluacionControl;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modificar_plan_accion` (IN `idid` INT, IN `plan` VARCHAR(150), IN `descripcion` VARCHAR(150), IN `fecha_ini` DATETIME, IN `fecha_fin` DATETIME, IN `empresa` INT, IN `area` INT, IN `unidad` INT, IN `posicion` INT, IN `usuario` INT, IN `prioridad` INT, IN `estado` INT, IN `alerta` INT, IN `idUserAdd` INT, IN `idriesgo` VARCHAR(150), IN `idcontrol` VARCHAR(150))   BEGIN
	UPDATE plan_accion SET
	plan_accion = plan,
	descripcion = descripcion,
	fecha_inicio = fecha_ini,
	fecha_fin = fecha_fin,
	idempresa = empresa,
	idarea = AREA,
	idunidades = unidad,
	idposicion_puesto = posicion,
	idusuario = usuario,
	idprioridad = prioridad,
	idestado = estado,
	idalerta=alerta,
	id_riesgo = idriesgo,
	id_control = idcontrol,
	id_user_updated = idUserAdd,
	date_modify = CURRENT_DATE()
	WHERE id=idid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modificar_prioridad` (IN `prioridad` VARCHAR(150), IN `descripcion` VARCHAR(150), IN `idUserAdd` INT, IN `idPrioridad` INT)   BEGIN
	UPDATE prioridad  SET
	prioridad=prioridad,
	decripcion= descripcion,
	id_user_updated=idUserAdd,
	date_modify=CURRENT_DATE() WHERE id=idPrioridad;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modificar_Registro_Controles` (IN `idIDR` VARCHAR(100), IN `idriesgo` VARCHAR(100), IN `idIDC` VARCHAR(100), IN `control` VARCHAR(100), IN `cobertura` INT, IN `idevaluacion` VARCHAR(100), IN `idestado` INT, IN `idUserAdd` INT, IN `idControl` INT)   BEGIN
	UPDATE  registro_controles SET
	IDR= idIDR,
	riesgo=idriesgo,
	IDC=idIDC,
	nom_control=control,
	idCobertura=cobertura,
	evaluacion=idevaluacion,
	estado=idestado,
	id_user_added=idUserAdd,
	DATE_ADD=CURRENT_DATE() WHERE id=idControl;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modificar_ValoracionRiesgo` (IN `valor` VARCHAR(100), IN `probabilidad` INT, IN `impacto` INT, IN `idUserAdd` INT, IN `idValoracionRiesgo` INT)   BEGIN
	UPDATE valoracion_riesgo
    SET valor=valor,
	idprobabilidad_riesgo = probabilidad,
	idimpacto_riesgo = impacto,
	id_user_updated=idUserAdd,
	date_modify=CURRENT_DATE() WHERE id=idValoracionRiesgo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerDetPerById` (IN `idid_perfil` INT)   BEGIN
    SELECT * from tb_detalle_perfil  as DP inner join tb_perfiles as TP
        on DP.id_perfil=TP.id_perfil
         where id_det_per= idid_perfil;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerModulosPerfil` (IN `perfil_id` INT)   BEGIN
    SELECT * FROM tb_detalle_perfil AS DP
    INNER JOIN tb_modulo AS TM ON DP.id = TM.id_mod
    WHERE DP.tabla = 'tb_modulo' AND DP.id_perfil = perfil_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerPerfilPorNombre` (IN `id_post` VARCHAR(100))   BEGIN
   SELECT * FROM tb_perfiles where perfil=id_post AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerPermisos` (IN `id_post` INT)   BEGIN
 SELECT * from tb_detalle_perfil as TDP inner join tb_perfiles as TP on TDP.id_perfil=TP.id_perfil
         where TDP.id_perfil=id_post  and TP.est_perfil=1 order by id_det_per ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerPermisosPorPerfil` (IN `perfil_post` VARCHAR(50), IN `opcion_post` VARCHAR(50))   BEGIN
  SELECT * from tb_detalle_perfil as TDP inner join tb_perfiles as TP
        on TDP.id_perfil=TP.id_perfil inner join tb_item as TI on TI.id_item = TDP.id where TP.perfil=perfil_post and
		TDP.tabla='tb_item' and TI.desc_item=opcion_post and TP.est_perfil=1 order by TDP.id_det_per ASC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerPeso` (IN `idid` INT)   begin
select peso from caracteristica_control where id=idid;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerUsuarioPorIdPerfil` (IN `id_post` INT)   BEGIN
 SELECT * FROM  tb_perfiles as TP inner join tb_users as TU on TU.perfil_us = TP.id_perfil where TU.id_us=id_post;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `saveLog` (IN `idterminal` VARCHAR(150), IN `idip_addres` VARCHAR(150), IN `idu_ejecutor` VARCHAR(150), IN `idu_afectado` VARCHAR(150), IN `idaccion` VARCHAR(150), IN `idfecha` DATETIME)   begin
INSERT INTO log_acciones(terminal,ip_addres,u_ejecutor,u_afectado,accion,fecha) 
VALUES (idterminal,idip_addres,idu_ejecutor,idu_afectado,idaccion,idfecha);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `saveLog_sistema` (IN `idterminal` VARCHAR(150), IN `idip_addres` VARCHAR(150), IN `idu_ejecutor` VARCHAR(150), IN `idaccion` VARCHAR(1000), IN `idfecha` DATETIME)   begin
INSERT INTO log_sistema(terminal,ip_addres,u_ejecutor,accion,fecha) 
VALUES (idterminal,idip_addres,idu_ejecutor,idaccion,idfecha);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `saveSesion` (IN `id` INT, IN `iat` VARCHAR(150), IN `exp` VARCHAR(150), IN `activity` VARCHAR(150))   begin
	INSERT INTO tb_sesiones 
        (id_us,iat,expi,last_activity,loged) VALUES
        (id,iat,
        exp,activity,'1');
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_add_categoria_vulnerabilidad` (IN `categoria` VARCHAR(150), IN `estado` INT, IN `id_user_added` INT, IN `date_add` DATETIME)   BEGIN
	INSERT INTO categoria_vulnerabilidad(categoria,estado,id_user_added,DATE_ADD)
	VALUES (categoria,estado,id_user_added,DATE_ADD);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_add_desc_amenaza` (IN `idtipo_amenaza` INT, IN `amenaza` VARCHAR(150), IN `id_user_added` INT, IN `date_add` DATETIME)   BEGIN
	INSERT INTO desc_amenaza(idtipo_amenaza,amenaza,id_user_added,DATE_ADD)
	VALUES (idtipo_amenaza,amenaza,id_user_added,DATE_ADD);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_add_desc_vulnerabilidad` (IN `idcategoria` INT, IN `vulnerabilidad` VARCHAR(150), IN `id_user_added` INT, IN `date_add` DATETIME)   BEGIN
	INSERT INTO desc_vulnerabilidad(idcategoria_vulnerabilidad,vulnerabilidad,id_user_added,DATE_ADD)
	VALUES (idcategoria,vulnerabilidad,id_user_added,DATE_ADD);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_add_evaluacion_riesgo` (IN `id_tipo_riesgo` INT, IN `id_empresa` INT, IN `id_area` INT, IN `id_unidad` INT, IN `id_macroproceso` INT, IN `id_proceso` INT, IN `id_activo` INT, IN `id_tipo_amenaza` INT, IN `id_descripcion_amenaza` INT, IN `id_tipo_vulnerabilidad` INT, IN `id_descripcion_vulnerabilidad` INT, IN `riesgo` VARCHAR(150), IN `valor_probabilidad` INT, IN `probabilidad` VARCHAR(150), IN `valor_impacto` VARCHAR(150), IN `impacto` VARCHAR(150), IN `valor` VARCHAR(150), IN `id_control` INT, IN `riesgo_controlado_probabilidad` VARCHAR(150), IN `riesgo_controlado_impacto` VARCHAR(150), IN `riesgo_controlado_valor` VARCHAR(150), IN `estado` INT, IN `id_user_added` INT, IN `date_add` DATETIME)   BEGIN
	INSERT INTO evaluacion_riesgo(
	id_tipo_riesgo,
	idempresa,
	idarea,
	idunidades,
	idmacroproceso,
	idproceso,
	id_activo,
	id_tipo_amenaza,
	id_descripcion_amenaza,
	id_tipo_vulnerabilidad,
	id_descripcion_vulnerabilidad,
	riesgo,
	valor_probabilidad,
	probabilidad,
	valor_impacto,
	impacto,
	valor,
	id_control,
	riesgo_controlado_probabilidad,
	riesgo_controlado_impacto,
	riesgo_controlado_valor,
	estado,
	id_user_added,
	DATE_ADD
	) VALUES (
		id_tipo_riesgo,
		id_empresa,
		id_area,
		id_unidad,
		id_macroproceso,
		id_proceso,
		id_activo,
		id_tipo_amenaza,
		id_descripcion_amenaza,
		id_tipo_vulnerabilidad,
		id_descripcion_vulnerabilidad,
		riesgo,
		valor_probabilidad,
		probabilidad,
		valor_impacto,
		impacto,
		valor,
		id_control,
		riesgo_controlado_probabilidad,
		riesgo_controlado_impacto,
		riesgo_controlado_valor,
		estado,
		id_user_added,
		DATE_ADD
	);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_add_evaluacion_riesgo_historial` (IN `id_tipo_riesgo` INT, IN `id_empresa` INT, IN `id_area` INT, IN `id_unidad` INT, IN `id_macroproceso` INT, IN `id_proceso` INT, IN `id_activo` INT, IN `id_tipo_amenaza` INT, IN `id_descripcion_amenaza` INT, IN `id_tipo_vulnerabilidad` INT, IN `id_descripcion_vulnerabilidad` INT, IN `riesgo` VARCHAR(150), IN `valor_probabilidad` INT, IN `probabilidad` VARCHAR(150), IN `valor_impacto` VARCHAR(150), IN `impacto` VARCHAR(150), IN `valor` VARCHAR(150), IN `id_control` INT, IN `riesgo_controlado_probabilidad` VARCHAR(150), IN `riesgo_controlado_impacto` VARCHAR(150), IN `riesgo_controlado_valor` VARCHAR(150), IN `estado` INT, IN `id_user_added` INT, IN `date_add` DATETIME)   BEGIN
	INSERT INTO evaluacion_riesgo_historial(
	id_tipo_riesgo,
	idempresa,
	idarea,
	idunidades,
	idmacroproceso,
	idproceso,
	id_activo,
	id_tipo_amenaza,
	id_descripcion_amenaza,
	id_tipo_vulnerabilidad,
	id_descripcion_vulnerabilidad,
	riesgo,
	valor_probabilidad,
	probabilidad,
	valor_impacto,
	impacto,
	valor,
	id_control,
	riesgo_controlado_probabilidad,
	riesgo_controlado_impacto,
	riesgo_controlado_valor,
	estado,
	id_user_added,
	DATE_ADD
	) VALUES (
		id_tipo_riesgo,
		id_empresa,
		id_area,
		id_unidad,
		id_macroproceso,
		id_proceso,
		id_activo,
		id_tipo_amenaza,
		id_descripcion_amenaza,
		id_tipo_vulnerabilidad,
		id_descripcion_vulnerabilidad,
		riesgo,
		valor_probabilidad,
		probabilidad,
		valor_impacto,
		impacto,
		valor,
		id_control,
		riesgo_controlado_probabilidad,
		riesgo_controlado_impacto,
		riesgo_controlado_valor,
		estado,
		id_user_added,
		DATE_ADD
	);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_add_evaluacion_riesgo_nivel` (IN `id_tipo_riesgo` INT, IN `id_empresa` INT, IN `id_area` INT, IN `id_unidad` INT, IN `id_macroproceso` INT, IN `id_proceso` INT, IN `id_activo` INT, IN `id_tipo_amenaza` INT, IN `id_descripcion_amenaza` INT, IN `id_tipo_vulnerabilidad` INT, IN `id_descripcion_vulnerabilidad` INT, IN `riesgo` VARCHAR(150), IN `valor_probabilidad` INT, IN `probabilidad` VARCHAR(150), IN `valor_impacto` VARCHAR(150), IN `impacto` VARCHAR(150), IN `valor` VARCHAR(150), IN `id_control` INT, IN `riesgo_controlado_probabilidad` VARCHAR(150), IN `riesgo_controlado_impacto` VARCHAR(150), IN `riesgo_controlado_valor` VARCHAR(150), IN `estado` INT, IN `id_user_added` INT, IN `date_add` DATETIME, IN `id_probabilidad_param` INT, IN `id_impacto_param` INT, IN `id_nivel_riesgo_param` INT)   BEGIN
	INSERT INTO evaluacion_riesgo(
	id_tipo_riesgo,
	idempresa,
	idarea,
	idunidades,
	idmacroproceso,
	idproceso,
	id_activo,
	id_tipo_amenaza,
	id_descripcion_amenaza,
	id_tipo_vulnerabilidad,
	id_descripcion_vulnerabilidad,
	riesgo,
	valor_probabilidad,
	probabilidad,
	valor_impacto,
	impacto,
	valor,
	id_control,
	riesgo_controlado_probabilidad,
	riesgo_controlado_impacto,
	riesgo_controlado_valor,
	estado,
	id_user_added,
	DATE_ADD,
    idprobabilidad_riesgo,
    idimpacto_riesgo,
    idnivel_riesgo,
        idinventario_clasificacion_activo
	) VALUES (
		id_tipo_riesgo,
		id_empresa,
		id_area,
		id_unidad,
		id_macroproceso,
		id_proceso,
		id_activo,
		id_tipo_amenaza,
		id_descripcion_amenaza,
		id_tipo_vulnerabilidad,
		id_descripcion_vulnerabilidad,
		riesgo,
		valor_probabilidad,
		probabilidad,
		valor_impacto,
		impacto,
		valor,
		id_control,
		riesgo_controlado_probabilidad,
		riesgo_controlado_impacto,
		riesgo_controlado_valor,
		estado,
		id_user_added,
		DATE_ADD,
        id_probabilidad_param,
        id_impacto_param,
        id_nivel_riesgo_param,
        id_activo
	);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_add_evaluacion_riesgo_valoracion` (IN `id_tipo_riesgo` INT, IN `id_empresa` INT, IN `id_area` INT, IN `id_unidad` INT, IN `id_macroproceso` INT, IN `id_proceso` INT, IN `id_activo` INT, IN `id_tipo_amenaza` INT, IN `id_descripcion_amenaza` INT, IN `id_tipo_vulnerabilidad` INT, IN `id_descripcion_vulnerabilidad` INT, IN `riesgo` VARCHAR(150), IN `valor_probabilidad` INT, IN `probabilidad` VARCHAR(150), IN `valor_impacto` VARCHAR(150), IN `impacto` VARCHAR(150), IN `valor` VARCHAR(150), IN `id_control` INT, IN `riesgo_controlado_probabilidad` VARCHAR(150), IN `riesgo_controlado_impacto` VARCHAR(150), IN `riesgo_controlado_valor` VARCHAR(150), IN `estado` INT, IN `id_user_added` INT, IN `date_add` DATETIME, IN `id_probabilidad_param` INT, IN `id_impacto_param` INT, IN `id_valoracion_riesgo_param` INT)   BEGIN
	INSERT INTO evaluacion_riesgo(
	id_tipo_riesgo,
	idempresa,
	idarea,
	idunidades,
	idmacroproceso,
	idproceso,
	id_activo,
	id_tipo_amenaza,
	id_descripcion_amenaza,
	id_tipo_vulnerabilidad,
	id_descripcion_vulnerabilidad,
	riesgo,
	valor_probabilidad,
	probabilidad,
	valor_impacto,
	impacto,
	valor,
	id_control,
	riesgo_controlado_probabilidad,
	riesgo_controlado_impacto,
	riesgo_controlado_valor,
	estado,
	id_user_added,
	DATE_ADD,
    idprobabilidad_riesgo,
    idimpacto_riesgo,
    idvaloracion_riesgo,
        idinventario_clasificacion_activo
	) VALUES (
		id_tipo_riesgo,
		id_empresa,
		id_area,
		id_unidad,
		id_macroproceso,
		id_proceso,
		id_activo,
		id_tipo_amenaza,
		id_descripcion_amenaza,
		id_tipo_vulnerabilidad,
		id_descripcion_vulnerabilidad,
		riesgo,
		valor_probabilidad,
		probabilidad,
		valor_impacto,
		impacto,
		valor,
		id_control,
		riesgo_controlado_probabilidad,
		riesgo_controlado_impacto,
		riesgo_controlado_valor,
		estado,
		id_user_added,
		DATE_ADD,
        id_probabilidad_param,
        id_impacto_param,
        id_valoracion_riesgo_param,
        id_activo
	);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_add_impacto_1` (IN `descripcion` VARCHAR(150), IN `tipo_regla` VARCHAR(150), IN `tipo_valor` VARCHAR(150), IN `comentario` VARCHAR(150), IN `estado` INT, IN `escenario` INT, IN `formula` VARCHAR(150), IN `id_user_added` INT, IN `date_add` DATETIME)   BEGIN
	INSERT INTO impacto_riesgo(descripcion,tipo_regla,tipo_valor,formula,comentario,estado,escenario,id_user_added,DATE_ADD)
	VALUES (descripcion,tipo_regla,tipo_valor,formula,comentario,estado,escenario,id_user_added,DATE_ADD);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_add_impacto_2` (IN `descripcion` VARCHAR(150), IN `tipo_regla` VARCHAR(150), IN `tipo_valor` VARCHAR(150), IN `operador1` VARCHAR(150), IN `valor1` INT, IN `operador2` VARCHAR(150), IN `valor2` INT, IN `comentario` VARCHAR(150), IN `estado` INT, IN `escenario` INT, IN `id_user_added` INT, IN `date_add` DATETIME)   BEGIN
	INSERT INTO impacto_riesgo(descripcion,tipo_regla,tipo_valor,operador1,valor1,operador2,valor2,comentario,estado,escenario,id_user_added,DATE_ADD)
	VALUES (descripcion,tipo_regla,tipo_valor,operador1,valor1,operador2,valor2,comentario,estado,escenario,id_user_added,DATE_ADD);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_add_inventario_clasificacion_activo` (IN `idempresa` INT, IN `idarea` INT, IN `idunidad` INT, IN `idmacroproceso` INT, IN `idproceso` INT, IN `activo` VARCHAR(150), IN `desc_activo` VARCHAR(500), IN `idtipo_activo` INT, IN `idcategoria_activo` INT, IN `idubicacion` INT, IN `idpropietario` INT, IN `idcustodio` INT, IN `idvalor` INT, IN `estado` INT, IN `comentario` VARCHAR(500), IN `id_user_added` INT, IN `date_add` DATETIME, IN `estado_2_param` INT, IN `vals_param` TEXT, IN `idvaloracion_activo_param` INT, IN `idclasi_info` INT)   BEGIN
	insert into inventario_clasificacion_activo(
	idempresa,
	idarea,
	idunidades,
	idmacroproceso,
	idproceso,
	activo,
	desc_activo,
	idtipo_activo,
	idcategoria_activo,
	idubicacion,
	idpropietario,
	idcustodio,
	idvalor,
	estado,
	comentario,
	id_user_added,
	date_add,
    estado_2,
    vals,
    idvaloracion_activo,
        idclasificacion_informacion
	) values(
		idempresa,
		idarea,
		idunidad,
		idmacroproceso,
		idproceso,
		activo,
		desc_activo,
		idtipo_activo,
		idcategoria_activo,
		idubicacion,
		idpropietario,
		idcustodio,
		idvalor,
		estado,
		comentario,
		id_user_added,
		date_add,
        estado_2_param,
        vals_param,
        idvaloracion_activo_param,
        idclasi_info
	);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_add_inventario_clasificacion_activo_historial` (IN `id_ica` INT, IN `idempresa` INT, IN `idarea` INT, IN `idunidad` INT, IN `idmacroproceso` INT, IN `idproceso` INT, IN `activo` VARCHAR(150), IN `desc_activo` VARCHAR(500), IN `idtipo_activo` INT, IN `idcategoria_activo` INT, IN `idubicacion` INT, IN `idpropietario` INT, IN `idcustodio` INT, IN `idvalor` INT, IN `estado` INT, IN `comentario` VARCHAR(500), IN `id_user_added` INT, IN `date_add` DATETIME, IN `estado_2_param` INT, IN `vals_param` TEXT, IN `idclasi_info` INT)   BEGIN
	INSERT INTO inventario_clasificacion_activo_historial(
	id_ica,
	idempresa,
	idarea,
	idunidades,
	idmacroproceso,
	idproceso,
	activo,
	desc_activo,
	idtipo_activo,
	idcategoria_activo,
	idubicacion,
	idpropietario,
	idcustodio,
	idvalor,
	estado,
	comentario,
	id_user_added,
	DATE_ADD,
	estado_2,
    vals,
        idclasificacion_informacion
	) VALUES(
		id_ica,
		idempresa,
		idarea,
		idunidad,
		idmacroproceso,
		idproceso,
		activo,
		desc_activo,
		idtipo_activo,
		idcategoria_activo,
		idubicacion,
		idpropietario,
		idcustodio,
		idvalor,
		estado,
		comentario,
		id_user_added,
		DATE_ADD,
		estado_2_param,
        vals_param,
        idclasi_info
	);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_add_nivel_riesgo` (IN `descripcion` VARCHAR(150), IN `operador1` VARCHAR(150), IN `valor1` INT, IN `operador2` VARCHAR(150), IN `valor2` INT, IN `color` VARCHAR(150), IN `comentario` VARCHAR(150), IN `estado` INT, IN `id_user_added` INT, IN `date_add` DATETIME)   BEGIN
	INSERT INTO nivel_riesgo(descripcion,operador1,valor1,operador2,valor2,color,comentario,estado,id_user_added,DATE_ADD)
	VALUES (descripcion,operador1,valor1,operador2,valor2,color,comentario,estado,id_user_added,DATE_ADD);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_add_probabilidad_1` (IN `descripcion` VARCHAR(150), IN `tipo_regla` VARCHAR(150), IN `tipo_valor` VARCHAR(150), IN `comentario` VARCHAR(150), IN `estado` INT, IN `escenario` INT, IN `formula` INT, IN `id_user_added` INT, IN `date_add` DATETIME)   BEGIN
	INSERT INTO probabilidad_riesgo(formula,descripcion,tipo_regla,tipo_valor,comentario,estado,escenario,id_user_added,DATE_ADD)
	VALUES (formula,descripcion,tipo_regla,tipo_valor,comentario,estado,escenario,id_user_added,DATE_ADD);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_add_probabilidad_2` (IN `descripcion` VARCHAR(150), IN `tipo_regla` VARCHAR(150), IN `tipo_valor` VARCHAR(150), IN `operador1` VARCHAR(150), IN `valor1` INT, IN `operador2` VARCHAR(150), IN `valor2` INT, IN `comentario` VARCHAR(150), IN `estado` INT, IN `escenario` INT, IN `id_user_added` INT, IN `date_add` DATETIME)   BEGIN
	INSERT INTO probabilidad_riesgo(descripcion,tipo_regla,tipo_valor,operador1,valor1,operador2,valor2,comentario,estado,escenario,id_user_added,DATE_ADD)
	VALUES (descripcion,tipo_regla,tipo_valor,operador1,valor1,operador2,valor2,comentario,estado,escenario,id_user_added,DATE_ADD);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_add_tipo_amenaza` (IN `tipo` VARCHAR(150), IN `estado` INT, IN `id_user_added` INT, IN `date_add` DATETIME)   BEGIN
	INSERT INTO tipo_amenaza(tipo,estado,id_user_added,DATE_ADD)
	VALUES (tipo,estado,id_user_added,DATE_ADD);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_agregar_plan_accion` (IN `plan_accion` VARCHAR(150), IN `actividades` VARCHAR(150), IN `descripcion` VARCHAR(150), IN `fecha_inicio` DATETIME, IN `fecha_fin` DATETIME, IN `idempresa` INT, IN `idarea` INT, IN `idunidad` INT, IN `idposicion` INT, IN `id_user` INT)   BEGIN
	SET @fecha_actual = CURRENT_DATE();
    
    INSERT INTO plan_accion
    (
        plan_accion,
        actividades,
        descripcion,
        fecha_inicio,
        fecha_fin,
        idempresa,
        idarea,
        idunidad,
        idposicion,
        id_user_added,
        DATE_ADD
    )
    VALUES
    (
        plan_accion,
        actividades,
        descripcion,
        fecha_inicio,
        fecha_fin,
        idempresa,
        idarea,
        idunidad,
        idposicion,
        id_user,
        @fecha_actual
    );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cat_activo_modify` (IN `idcat_activoparam` INT, IN `cat_activo_param` VARCHAR(150), IN `tipo` INT)   begin
	select * from categoria_activo where idtipo_activo=tipo and categoria=cat_activo_param and id!=idcat_activoparam and is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_change_pass` (IN `id` INT)   BEGIN
    UPDATE tb_users SET change_pass = 1 WHERE id_us = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_change_status_riesgo_by_activo` (IN `id_activo_param` INT, IN `status` INT)   begin
update evaluacion_riesgo set estado=status where id_activo=id_activo_param;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_count_evaluacion_by_valor` ()   BEGIN
	SELECT COUNT(*) AS cantidad,er.valor
	FROM evaluacion_riesgo er
	INNER JOIN inventario_clasificacion_activo ica ON ica.id=er.id_activo
	WHERE er.estado=1 AND er.is_deleted=0 AND ica.is_deleted=0
	GROUP BY er.valor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_count_planes_by_valor` ()   BEGIN
	SELECT COUNT(*) AS cantidad,e.estado
	FROM plan_accion as pa INNER JOIN estado as e on  pa.idestado=e.id
	WHERE pa.is_deleted=0 AND e.is_deleted=0
	GROUP BY e.estado;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_categoria_vulnerabilidad` (IN `id` INT, IN `id_user_deleted` INT, IN `date_deleted` DATETIME)   BEGIN
	UPDATE categoria_vulnerabilidad
	SET is_deleted=1,
	estado=2,
	id_user_deleted=id_user_deleted,
	date_deleted=date_deleted
	WHERE id=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_desc_amenaza` (IN `id` INT, IN `id_user_deleted` INT, IN `date_deleted` DATETIME)   BEGIN
	UPDATE desc_amenaza
	SET is_deleted=1,
	id_user_deleted=id_user_deleted,
	date_deleted=date_deleted
	WHERE id=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_desc_vulnerabilidad` (IN `id` INT, IN `id_user_deleted` INT, IN `date_deleted` DATETIME)   BEGIN
	UPDATE desc_vulnerabilidad
	SET is_deleted=1,
	id_user_deleted=id_user_deleted,
	date_deleted=date_deleted
	WHERE id=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_evaluacion_riesgo` (IN `idid` INT, IN `id_user_deleted` INT, IN `date_deleted` DATETIME)   BEGIN
	UPDATE evaluacion_riesgo
	SET is_deleted=1,
	id_user_deleted=id_user_deleted,
	date_deleted=date_deleted
	WHERE id=idid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_evaluacion_riesgo_controles` (IN `id_evaluacion_riesgo_param` INT)   begin
	update evaluacion_riesgos_controles set is_deleted='1' where id_evaluacion_riesgo = id_evaluacion_riesgo_param;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_evaluacion_riesgo_controles2` (IN `id_evaluacion_riesgo_param` INT, IN `id_control_param` INT, IN `user_param` INT)   begin
	update evaluacion_riesgos_controles set is_deleted='1',	id_user_deleted=user_param,date_deteled=now() where id_evaluacion_riesgo = id_evaluacion_riesgo_param
    and id_control = id_control_param;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_impacto` (IN `id` INT, IN `id_user_deleted` INT, IN `date_deleted` DATETIME)   BEGIN
	UPDATE impacto_riesgo
	SET is_deleted=1,estado=2,id_user_deleted=id_user_deleted,date_deleted=date_deleted
	WHERE id=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_inventario_clasificacion_activo` (IN `id` INT, IN `id_user_deleted` INT, IN `date_deleted` DATETIME)   BEGIN
	UPDATE inventario_clasificacion_activo
	SET is_deleted=1,id_user_deleted=id_user_deleted,date_deleted=date_deleted
	WHERE id=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_nivel_riesgo` (IN `id` INT, IN `id_user_deleted` INT, IN `date_deleted` DATETIME)   BEGIN
	UPDATE nivel_riesgo
	SET is_deleted=1,
	estado=2,
	id_user_deleted=id_user_deleted,
	date_deleted=date_deleted
	WHERE id=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_probabilidad` (IN `id` INT, IN `id_user_deleted` INT, IN `date_deleted` DATETIME)   BEGIN
	UPDATE probabilidad_riesgo
	SET is_deleted=1,estado=2,id_user_deleted=id_user_deleted,date_deleted=date_deleted
	WHERE id=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_tipo_amenaza` (IN `id` INT, IN `id_user_deleted` INT, IN `date_deleted` DATETIME)   BEGIN
	UPDATE tipo_amenaza
	SET is_deleted=1,
	estado=2,
	id_user_deleted=id_user_deleted,
	date_deleted=date_deleted
	WHERE id=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_tipo_riesgo` (IN `id` INT, IN `id_user_deleted` INT, IN `date_deleted` DATETIME)   BEGIN
	UPDATE tipo_riesgo
	SET estado=2,is_deleted=1,id_user_deleted=id_user_deleted,date_deleted=date_deleted
	WHERE id=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editar_plan_accion` (IN `id` INT, IN `plan_accion` VARCHAR(150), IN `actividades` INT, IN `descripcion` VARCHAR(150), IN `fecha_inicio` DATETIME, IN `fecha_fin` DATETIME, IN `idempresa` INT, IN `idarea` INT, IN `idunidad` INT, IN `idposicion` INT, IN `id_user` INT)   BEGIN
	SET @fecha_actual = CURRENT_DATE();
    
    UPDATE plan_accion SET
        plan_accion = plan_accion,
        actividades = actividades,
        descripcion = descripcion,
        fecha_inicio = fecha_inicio,
        fecha_fin = fecha_fin,
        idempresa = idempresa,
        idarea = idarea,
        idunidad = idunidad,
        idposicion = idposicion,
        id_user_updated = id_user,
        date_modify = @fecha_actual
    WHERE id = id AND is_deleted = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_edit_categoria_vulnerabilidad` (IN `idid` INT, IN `categoria` VARCHAR(150), IN `estado` INT, IN `id_user_updated` INT, IN `date_modify` DATETIME)   BEGIN
	UPDATE categoria_vulnerabilidad
	SET categoria=categoria,
	estado=estado,
	id_user_updated=id_user_updated,
	date_modify=date_modify
	WHERE id=idid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_edit_desc_amenaza` (IN `idid` INT, IN `idtipo_amenaza` INT, IN `amenaza` VARCHAR(150), IN `id_user_updated` INT, IN `date_modify` DATETIME)   BEGIN
	UPDATE desc_amenaza
	SET idtipo_amenaza=idtipo_amenaza,
	amenaza=amenaza,
	id_user_updated=id_user_updated,
	date_modify=date_modify
	WHERE id=idid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_edit_desc_vulnerabilidad` (IN `idid` INT, IN `idcategoria` INT, IN `vulnerabilidad` VARCHAR(150), IN `id_user_updated` INT, IN `date_modify` DATETIME)   BEGIN
	UPDATE desc_vulnerabilidad
	SET idcategoria_vulnerabilidad=idcategoria,
	vulnerabilidad=vulnerabilidad,
	id_user_updated=id_user_updated,
	date_modify=date_modify
	WHERE id=idid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_edit_impacto_1` (IN `idir` INT, IN `iddescripcion` VARCHAR(150), IN `idtipo_regla` VARCHAR(150), IN `idtipo_valor` VARCHAR(150), IN `idcomentario` VARCHAR(150), IN `idestado` INT, IN `idformula` VARCHAR(150), IN `idid_user_updated` INT, IN `iddate_modify` DATETIME)   BEGIN
	UPDATE impacto_riesgo
	SET formula=idformula,
    descripcion=iddescripcion,
    tipo_regla=idtipo_regla,
    tipo_valor=idtipo_valor,
    comentario=idcomentario,
    estado=idestado,
    id_user_updated=
    idid_user_updated,
    date_modify=iddate_modify
	WHERE id=idir;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_edit_impacto_2` (IN `idir` INT, IN `descripcion` VARCHAR(150), IN `tipo_regla` VARCHAR(150), IN `tipo_valor` VARCHAR(150), IN `operador1` VARCHAR(150), IN `valor1` INT, IN `operador2` VARCHAR(150), IN `valor2` INT, IN `comentario` VARCHAR(150), IN `estado` INT, IN `id_user_updated` INT, IN `date_modify` DATETIME)   BEGIN
	UPDATE impacto_riesgo
	SET descripcion=descripcion,
	tipo_regla=tipo_regla,
	tipo_valor=tipo_valor,
	operador1=operador1,
	operador2=operador2,
	valor1=valor1,
	valor2=valor2,
	comentario=comentario,
	estado=estado,
	id_user_updated=id_user_updated,
	date_modify=date_modify
	WHERE id=idir;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_edit_inventario_clasificacion_activo` (IN `idid` INT, IN `idempresa` INT, IN `idarea` INT, IN `idunidad` INT, IN `idmacroproceso` INT, IN `idproceso` INT, IN `activo` VARCHAR(150), IN `desc_activo` VARCHAR(500), IN `idtipo_activo` INT, IN `idcategoria_activo` INT, IN `idubicacion` INT, IN `idpropietario` INT, IN `idcustodio` INT, IN `idvalor` INT, IN `estado` INT, IN `comentario` VARCHAR(500), IN `id_user_updated` INT, IN `date_modify` DATETIME, IN `observacion` VARCHAR(200), IN `estado_2_param` INT, IN `vals_param` TEXT, IN `idvaloracion_activo_param` INT, IN `idclasi_info` INT)   BEGIN
	UPDATE inventario_clasificacion_activo
	SET idempresa=idempresa,
	idarea=idarea,
	idunidades=idunidad,
	idmacroproceso=idmacroproceso,
	idproceso=idproceso,
	activo=activo,
	desc_activo=desc_activo,
	idtipo_activo=idtipo_activo,
	idcategoria_activo=idcategoria_activo,
	idubicacion=idubicacion,
	idpropietario=idpropietario,
	idcustodio=idcustodio,
	idvalor=idvalor,
	estado=estado,
	comentario=comentario,
	id_user_updated=id_user_updated,
	date_modify=date_modify,
	observacion=observacion,
    estado_2=estado_2_param,
    vals=vals_param,
    idvaloracion_activo=idvaloracion_activo_param,
    idclasificacion_informacion=idclasi_info
    where id=idid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_edit_nivel_riesgo` (IN `idid` INT, IN `descripcion` VARCHAR(150), IN `operador1` VARCHAR(150), IN `valor1` INT, IN `operador2` VARCHAR(150), IN `valor2` INT, IN `color` VARCHAR(150), IN `comentario` VARCHAR(150), IN `estado` INT, IN `id_user_updated` INT, IN `date_modify` DATETIME)   BEGIN
	UPDATE nivel_riesgo
	SET descripcion=descripcion,
	operador1=operador1,
	operador2=operador2,
	valor1=valor1,
	valor2=valor2,
	color=color,
	comentario=comentario,
	estado=estado,
	id_user_updated=id_user_updated,
	date_modify=date_modify
	WHERE id=idid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_edit_probabilidad_1` (IN `idpr` INT, IN `iddescripcion` VARCHAR(150), IN `idtipo_regla` VARCHAR(150), IN `idtipo_valor` VARCHAR(150), IN `idcomentario` VARCHAR(150), IN `idestado` INT, IN `idformula` VARCHAR(150), IN `idid_user_updated` INT, IN `iddate_modify` DATETIME)   BEGIN
	UPDATE probabilidad_riesgo
	SET formula=idformula,
    descripcion=iddescripcion,
    tipo_regla=idtipo_regla,
    tipo_valor=idtipo_valor,
    comentario=idcomentario,
    estado=idestado,
    id_user_updated=idid_user_updated,
    date_modify=iddate_modify
	WHERE id=idpr;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_edit_probabilidad_2` (IN `idpr` INT, IN `iddescripcion` VARCHAR(150), IN `idtipo_regla` VARCHAR(150), IN `idtipo_valor` VARCHAR(150), IN `idoperador1` VARCHAR(150), IN `idvalor1` INT, IN `idoperador2` VARCHAR(150), IN `idvalor2` INT, IN `idcomentario` VARCHAR(150), IN `idestado` INT, IN `idid_user_updated` INT, IN `iddate_modify` DATETIME)   BEGIN
	UPDATE probabilidad_riesgo
	SET descripcion=iddescripcion,
	tipo_regla=idtipo_regla,
	tipo_valor=idtipo_valor,
	operador1=idoperador1,
	operador2=idoperador2,
	valor1=idvalor1,
	valor2=idvalor2,
	comentario=idcomentario,
	estado=idestado,
	id_user_updated=idid_user_updated,
	date_modify=iddate_modify
	WHERE id=idpr;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_edit_tipo_amenaza` (IN `idid` INT, IN `tipo` VARCHAR(150), IN `estado` INT, IN `id_user_updated` INT, IN `date_modify` DATETIME)   BEGIN
	UPDATE tipo_amenaza
	SET tipo=tipo,
	estado=estado,
	id_user_updated=id_user_updated,
	date_modify=date_modify
	WHERE id=idid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_find_user` (IN `username` VARCHAR(255))   BEGIN
    SELECT *
    FROM tb_users
    WHERE usuario_us = username;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_active_escenario_1` ()   BEGIN
	SELECT * FROM probabilidad_riesgo WHERE estado=1 AND is_deleted=0 AND escenario=1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_active_escenario_1_modify` (IN `id_param` INT)   begin
	SELECT * FROM probabilidad_riesgo WHERE estado=1 AND is_deleted=0 and id!=id_param and escenario=1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_active_impacto_escenario_1` ()   BEGIN
	SELECT * FROM impacto_riesgo WHERE estado=1 AND is_deleted=0 AND escenario=1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_active_impacto_escenario_1_modify` (IN `id_param` INT)   begin
	SELECT * FROM impacto_riesgo WHERE estado=1 AND is_deleted=0 and id!=id_param and escenario=1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_aplicacion_impacto_by_caracteristica` (IN `idcaracteristica` VARCHAR(50), IN `escene` INT)   BEGIN
SELECT ai.*,cc.calificacion
	FROM aplicacion_impacto ai
		INNER JOIN evaluacion_control2 cc ON cc.id = ai.idclasificacion
	WHERE cc.calificacion=idcaracteristica AND ai.is_deleted=0 AND ai.escenario=escene;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_aplicacion_probabilidad_by_caracteristica` (IN `idcaracteristica` VARCHAR(50), IN `escene` INT)   BEGIN
	SELECT ap.*,cc.calificacion
	FROM aplicacion_probailidad ap
	INNER JOIN evaluacion_control2 cc ON cc.id = ap.idclasificacion
	WHERE cc.calificacion=idcaracteristica AND ap.is_deleted=0 AND escenario=escene;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_caracteristica_control_opcion` (IN `scene` INT)   begin
	select 
    ap.id,cc.calificacion,ap.posicion,ap.escenario
    from aplicacion_probailidad as ap inner join evaluacion_control2 as cc on cc.id = ap.idclasificacion where ap.escenario=scene and ap.is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_detalle_perfil_to_reporte` ()   begin
	(SELECT tp.perfil,tp.desc_perfil,tp.creacion_perfil,tp.est_perfil,TI.desc_item,DP.view_det,DP.create_det,DP.update_det,DP.delete_det
	FROM tb_detalle_perfil as DP 
	inner join tb_perfiles tp on tp.id_perfil=DP.id_perfil
	inner join tb_item as TI on DP.id=TI.id_item where DP.tabla='tb_item' 
     and DP.is_deleted=0 order by TI.id_op,TI.id_item ASC 
    )
    union all 
    (
		SELECT tp.perfil,tp.desc_perfil,tp.creacion_perfil,tp.est_perfil,TM.desc_mod as desc_item,DP.view_det,DP.create_det,DP.update_det,DP.delete_det
        FROM tb_detalle_perfil as DP
        inner join tb_perfiles tp on tp.id_perfil=DP.id_perfil
        inner join tb_modulo as TM on DP.id=TM.id_mod 
		where DP.tabla='tb_modulo' and DP.is_deleted=0 and tp.is_deleted=0
    )
    union all
    (
		SELECT tp.perfil,tp.desc_perfil,tp.creacion_perfil,tp.est_perfil,T.desc_op as desc_item,DP.view_det,DP.create_det,DP.update_det,DP.delete_det
        from tb_detalle_perfil as DP
		inner join tb_perfiles tp on tp.id_perfil=DP.id_perfil
        inner join tb_opcion as T on DP.id=T.id_op 
        where DP.tabla='tb_opcion' and DP.is_deleted=0
    );
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_detalle_valoracion_activo` (IN `idaspecto_param` VARCHAR(50))   begin
	select distinct ass.id as id_aspecto,ass.aspecto as aspecto,dva.valoracion as valoracion
	from detalle_valoracion_activo dva
	inner join aspectos_seguridad ass on ass.id=dva.idaspectos_seguridad
	where dva.is_deleted = 0 and ass.id=idaspecto_param;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_evaluacion_riesgo_by_id` (IN `id_param` INT)   BEGIN
	SELECT * FROM evaluacion_riesgo WHERE id=id_param;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_evaluacion_riesgo_controles_by_evaluacion_riesgo_id` (IN `id_evaluacion_riesgo_pass` INT)   BEGIN
	select * from evaluacion_riesgos_controles where id_evaluacion_riesgo = id_evaluacion_riesgo_pass and is_deleted=0;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_impacto_by_description` (IN `iddescription` VARCHAR(50))   BEGIN
	SELECT * FROM impacto_riesgo
	WHERE descripcion=iddescription AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_info_to_email` (IN `idid` INT)   BEGIN
	SELECT
	ica.id AS ica_id,
	ica.activo,
	ica.desc_activo,
	ica.idpropietario AS propietario,
	pp.posicion_puesto AS des_propietario,
	ica.idcustodio AS custodio,
	ica.observacion AS observacion,
	pp1.posicion_puesto AS des_custodio,
	ica.vals AS vals,
	ica.estado AS ica_estado,
	ica.comentario AS ica_comentario,
	e.id AS id_empresa,
	e.empresa AS empresa,
	a.id AS id_area,
	a.area AS area,
	u.id AS id_unidad,
	u.unidad AS unidad,
	m.id AS id_macroproceso,
	m.macroproceso AS macroproceso,
	p.id AS id_proceso,
	p.proceso AS proceso,
	ta.id AS id_tipo_activo,
	ta.tipo AS tipo_activo,
	ca.id AS id_categoria_activo,
	ca.categoria AS categoria_activo,
	ua.id AS ubicacion_id,
	ua.continente AS ubicacion_continente,
	ua.pais AS ubicacion_pais,
	ua.ciudad AS ubicacion_ciudad,
	ua.direccion AS ubicacion_direccion,
	ua.descripcion AS ubicacion_descripcion,
	va.id AS id_valor,
	va.valor AS valor,
    ci.clasificacion as clasificacion
	FROM inventario_clasificacion_activo AS ica
	INNER JOIN empresa AS e ON e.id=ica.idempresa
	INNER JOIN area AS a ON a.id=ica.idarea
	INNER JOIN unidades AS u ON u.id=ica.idunidades
	INNER JOIN macroproceso AS m ON m.id=ica.idmacroproceso
	INNER JOIN proceso AS p ON p.id=ica.idproceso
	INNER JOIN tipo_activo AS ta ON ta.id=ica.idtipo_activo
	INNER JOIN categoria_activo AS ca ON ca.id=ica.idcategoria_activo
	INNER JOIN ubicacion_activo AS ua ON ua.id=ica.idubicacion
	INNER JOIN valor_activo AS va ON va.id=ica.idvalor
	INNER JOIN posicion_puesto AS pp ON pp.id=ica.idpropietario
	INNER JOIN posicion_puesto AS pp1 ON pp1.id=ica.idcustodio
    INNER JOIN clasificacion_informacion as ci on ci.id=ica.idclasificacion_informacion
	WHERE ica.id=idid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_info_to_email_actividad` (IN `id_usuario` INT, IN `idid` INT)   begin
SELECT * FROM actividades_plan as PA inner join tb_users as TU on PA.idusuario=TU.id_us 
inner join alert_seguimiento as ALE on PA.idalerta=ALE.id inner join plan_accion as PLAN ON 
PLAN.id=PA.id_planes where TU.id_us = id_usuario AND PA.id=idid;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_info_to_email_plan` (IN `id_usuario` INT, IN `idid` INT)   begin
SELECT * FROM plan_accion as PA inner join tb_users as TU on PA.idusuario=TU.id_us 
inner join alert_seguimiento as ALE on PA.idalerta=ALE.id where TU.id_us = id_usuario AND PA.id=idid;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_intentos` (IN `username` VARCHAR(255))   BEGIN
    SELECT intentos_us, bloqueo_time, bloqueo_us
    FROM tb_users
    WHERE usuario_us = username;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_intentos_usuario` (IN `username` VARCHAR(255))   BEGIN
    SELECT intentos_us, bloqueo_time, bloqueo_us
    FROM tb_users
    WHERE usuario_us = username;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_inventario_clasificacion_activo` (IN `idid` INT)   BEGIN
	SELECT * FROM inventario_clasificacion_activo WHERE id=idid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_last_evaluacion_riesgo` ()   BEGIN
	SELECT id FROM evaluacion_riesgo ORDER BY id DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_last_id` ()   BEGIN
	SELECT * FROM inventario_clasificacion_activo ORDER BY id DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_probabilidad_by_description` (IN `iddescription` VARCHAR(50))   BEGIN
	SELECT * FROM probabilidad_riesgo
	WHERE descripcion=iddescription AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_unidades_by_empresa_by_area` (IN `idempresa_param` INT, IN `idarea_param` INT)   begin
	SELECT U.id,U.unidad,E.empresa,A.area,U.estado,U.idempresa,U.idarea
	FROM unidades AS U 
    INNER JOIN empresa AS E ON U.idempresa = E.id
	INNER JOIN area AS A ON U.idarea = A.id AND U.is_deleted=0
    where U.idempresa=idempresa_param and U.idarea=idarea_param;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_user_by_id` (IN `user_id` INT)   BEGIN
    SELECT *
    FROM tb_users
    WHERE id_us = user_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_user_history` (IN `id_post` INT)   BEGIN
    SELECT * FROM tb_users AS TU 
    INNER JOIN tb_historial_claves AS TH ON TU.id_us = TH.id_us 
    WHERE TU.id_us = id_post 
    ORDER BY TH.id_cl DESC 
    LIMIT 10;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_user_last_password_byid` (IN `user_id` INT)   BEGIN
    SELECT *
    FROM tb_users AS TU
    INNER JOIN tb_historial_claves AS TH ON TU.id_us = TH.id_us
    WHERE TU.id_us = user_id
    ORDER BY TH.id_cl DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_user_with_last_password` (IN `username` VARCHAR(255))   BEGIN
    SELECT *
    FROM tb_users AS TU
    INNER JOIN tb_historial_claves AS TH ON TU.id_us = TH.id_us
    WHERE TU.usuario_us = username
    ORDER BY TH.id_cl DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_valoracion_activo_by_id` (IN `id_param` INT)   begin
	select valoracion_activo.id,valoracion_activo.idvalor,valor_activo.valor from valoracion_activo inner join valor_activo on valor_activo.id=valoracion_activo.idvalor where valoracion_activo.id=id_param and valoracion_activo.is_deleted =0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_valoracion_by_probabilidad_impacto` (IN `probabilidad_param` VARCHAR(100), IN `impacto_param` VARCHAR(100))   begin
	select vr.id,vr.idprobabilidad_riesgo as idprobabilidad_riesgo,pr.descripcion as probabilidad, vr.idimpacto_riesgo as idimpacto_riesgo,ir.descripcion as impacto
	from valoracion_riesgo as vr
	inner join probabilidad_riesgo pr on pr.id=vr.idprobabilidad_riesgo
	inner join impacto_riesgo ir on ir.id=vr.idimpacto_riesgo
	where vr.is_deleted = 0 and pr.descripcion=probabilidad_param and ir.descripcion=impacto_param;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_valoracion_riesgo` (IN `idid_probabilidad` INT, IN `idid_impacto` INT)   BEGIN
	SELECT * FROM valoracion_riesgo WHERE idprobabilidad_riesgo =idid_probabilidad AND idimpacto_riesgo=idid_impacto AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_valor_combinacion_valoracion` (IN `val_c` INT, IN `val_i` INT, IN `val_d` INT)   BEGIN
	SELECT vac.id,vac.valor FROM valoracion_activo va
	INNER JOIN valor_activo vac ON va.idvalor=vac.id
	WHERE va.valoracion1=val_c AND va.valoracion2=val_i AND valoracion3=val_d;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_tipo_riesgo` (IN `tipo_riesgo` VARCHAR(150), IN `descripcion` VARCHAR(150), IN `estado` INT, IN `id_user_added` INT, IN `date_add` DATETIME)   BEGIN
	INSERT INTO tipo_riesgo(tipo_riesgo,descripcion,estado,id_user_added,DATE_ADD) VALUES(tipo_riesgo,descripcion,estado,id_user_added,DATE_ADD);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_list_categoria_vulnerabilidad` ()   BEGIN
	SELECT * FROM categoria_vulnerabilidad WHERE is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_list_desc_amenaza` ()   BEGIN
	select da.id as id,ta.id as id_tipo_amenaza,ta.tipo as tipo_amenaza,da.amenaza as amenaza from desc_amenaza as da inner join tipo_amenaza as ta on da.idtipo_amenaza = ta.id WHERE da.is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_list_desc_vulnerabilidad` ()   BEGIN
	SELECT da.id as id,ca.categoria as categoria,da.vulnerabilidad as vulnerabilidad
    FROM desc_vulnerabilidad da
	inner join categoria_vulnerabilidad ca on ca.id = da.idcategoria_vulnerabilidad
    WHERE da.is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_list_evaluacion_riesgo` (IN `empresa` INT)   BEGIN
	SELECT * FROM evaluacion_riesgo WHERE idempresa=empresa and is_deleted=0 ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_list_evaluacion_riesgo_historial` (IN `idid` INT)   BEGIN
	SELECT
		erh.id AS id,
		tipo_riesgo.tipo_riesgo AS tipo_riesgo,
		empresa.empresa AS empresa,
		area.area AS area,
		unidades.unidad AS unidad,
		macroproceso.macroproceso AS macroproceso,
		proceso.proceso AS proceso,
		erh.id_activo AS activo,
		ta.tipo AS tipo_amenaza,
		da.amenaza AS descripcion_amenaza,
		ca.categoria AS tipo_vulnerabilidad,
		dv.vulnerabilidad AS descripcion_vulnerabilidad,
		erh.riesgo AS riesgo,
		erh.valor_probabilidad AS valor_probabilidad,
		erh.probabilidad AS probabilidad,
		erh.valor_impacto AS valor_impacto,
		erh.impacto AS impacto,
		erh.valor AS valor,
		erh.id_control AS control,
		erh.riesgo_controlado_probabilidad AS riesgo_controlado_probabilidad,
		erh.riesgo_controlado_impacto AS riesgo_controlado_impacto,
		erh.riesgo_controlado_valor AS riesgo_controlado_valor,
		erh.date_add AS DATE_ADD
	FROM evaluacion_riesgo_historial erh
	INNER JOIN empresa ON empresa.id=erh.idempresa
	INNER JOIN tipo_riesgo ON tipo_riesgo.id=erh.id_tipo_riesgo
	INNER JOIN area ON area.id=erh.idarea
	INNER JOIN unidades ON unidades.id=erh.idunidades
	INNER JOIN macroproceso ON macroproceso.id=erh.idmacroproceso
	INNER JOIN proceso ON proceso.id = erh.idproceso
	INNER JOIN inventario_clasificacion_activo AS iva ON iva.id=erh.id_activo
	INNER JOIN tipo_amenaza ta ON ta.id=erh.id_tipo_amenaza
	INNER JOIN desc_amenaza da ON da.id=erh.id_descripcion_amenaza
	INNER JOIN categoria_vulnerabilidad ca ON ca.id=erh.id_tipo_vulnerabilidad
	INNER JOIN desc_vulnerabilidad dv ON dv.id=erh.id_descripcion_vulnerabilidad
	WHERE erh.is_deleted=0 AND empresa.id=idid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_list_ica_by_valoracion` (IN `val_c` INT, IN `val_i` INT, IN `val_d` INT)   BEGIN
	SELECT ica.* FROM inventario_clasificacion_activo ica
	WHERE ica.val_c=val_c AND ica.val_i=val_i AND ica.val_d=val_d;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_list_impacto` (IN `idescenario` INT)   BEGIN
	SELECT * FROM impacto_riesgo WHERE escenario=idescenario AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_list_inventario_clasificacion_activo` (IN `empresa` INT)   BEGIN
	SELECT
	ica.id AS ica_id,
    ica.estado_2 as ica_estado_2,
	ica.activo,
	ica.desc_activo,
	ica.idpropietario AS propietario,
	pp.posicion_puesto AS des_propietario,
	ica.idcustodio AS custodio,
	ica.observacion AS observacion,
	pp1.posicion_puesto AS des_custodio,
	ica.vals AS vals,
	ica.estado AS ica_estado,
	ica.comentario AS ica_comentario,
	e.id AS id_empresa,
	e.empresa AS empresa,
	a.id AS id_area,
	a.area AS area,
	u.id AS id_unidad,
	u.unidad AS unidad,
	m.id AS id_macroproceso,
	m.macroproceso AS macroproceso,
	p.id AS id_proceso,
	p.proceso AS proceso,
	ta.id AS id_tipo_activo,
	ta.tipo AS tipo_activo,
	ca.id AS id_categoria_activo,
	ca.categoria AS categoria_activo,
	ua.id AS ubicacion_id,
	ua.continente AS ubicacion_continente,
	ua.pais AS ubicacion_pais,
	ua.ciudad AS ubicacion_ciudad,
	ua.direccion AS ubicacion_direccion,
	ua.descripcion AS ubicacion_descripcion,
	va.id AS id_valor,
	va.valor AS valor,
    ci.id as id_clasificacion,
     ci.clasificacion as clasificacion
	FROM inventario_clasificacion_activo AS ica
	INNER JOIN empresa AS e ON e.id=ica.idempresa
	INNER JOIN area AS a ON a.id=ica.idarea
	INNER JOIN unidades AS u ON u.id=ica.idunidades
	INNER JOIN macroproceso AS m ON m.id=ica.idmacroproceso
	INNER JOIN proceso AS p ON p.id=ica.idproceso
	INNER JOIN tipo_activo AS ta ON ta.id=ica.idtipo_activo
	INNER JOIN categoria_activo AS ca ON ca.id=ica.idcategoria_activo
	INNER JOIN ubicacion_activo AS ua ON ua.id=ica.idubicacion
	INNER JOIN valor_activo AS va ON va.id=ica.idvalor
	INNER JOIN posicion_puesto AS pp ON pp.id=ica.idpropietario
	INNER JOIN posicion_puesto AS pp1 ON pp1.id=ica.idcustodio
    INNER JOIN clasificacion_informacion as ci ON ci.id=ica.idclasificacion_informacion
	WHERE ica.is_deleted=0 AND e.id=empresa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_list_inventario_clasificacion_activo_all` ()   BEGIN
	SELECT ICA.id as id_ica,ICA.idvaloracion_activo as id_val,ICA.* FROM inventario_clasificacion_activo AS ICA inner join valoracion_activo as VA ON
    ICA.idvaloracion_activo=VA.id where ICA.is_deleted=0 and VA.is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_list_inventario_clasificacion_activo_by_user` (IN `id_user` INT, IN `empresa` INT)   BEGIN
	SELECT
	ica.id AS ica_id,
	ica.activo,
	ica.desc_activo,
	ica.idpropietario AS propietario,
	pp.posicion_puesto AS des_propietario,
	ica.idcustodio AS custodio,
	ica.observacion AS observacion,
	pp1.posicion_puesto AS des_custodio,
	ica.vals AS vals,
	ica.estado AS ica_estado,
	ica.comentario AS ica_comentario,
	e.id AS id_empresa,
	e.empresa AS empresa,
	a.id AS id_area,
	a.area AS area,
	u.id AS id_unidad,
	u.unidad AS unidad,
	m.id AS id_macroproceso,
	m.macroproceso AS macroproceso,
	p.id AS id_proceso,
	p.proceso AS proceso,
	ta.id AS id_tipo_activo,
	ta.tipo AS tipo_activo,
	ca.id AS id_categoria_activo,
	ca.categoria AS categoria_activo,
	ua.id AS ubicacion_id,
	ua.continente AS ubicacion_continente,
	ua.pais AS ubicacion_pais,
	ua.ciudad AS ubicacion_ciudad,
	ua.direccion AS ubicacion_direccion,
	ua.descripcion AS ubicacion_descripcion,
	va.id AS id_valor,
    ica.estado_2 as ica_estado_2,
	va.valor AS valor,
   ci.id as id_clasificacion,
     ci.clasificacion as clasificacion
	FROM inventario_clasificacion_activo AS ica
	INNER JOIN empresa AS e ON e.id=ica.idempresa
	INNER JOIN area AS a ON a.id=ica.idarea
	INNER JOIN unidades AS u ON u.id=ica.idunidades
	INNER JOIN macroproceso AS m ON m.id=ica.idmacroproceso
	INNER JOIN proceso AS p ON p.id=ica.idproceso
	INNER JOIN tipo_activo AS ta ON ta.id=ica.idtipo_activo
	INNER JOIN categoria_activo AS ca ON ca.id=ica.idcategoria_activo
	INNER JOIN ubicacion_activo AS ua ON ua.id=ica.idubicacion
	INNER JOIN valor_activo AS va ON va.id=ica.idvalor
	INNER JOIN posicion_puesto AS pp ON pp.id=ica.idpropietario
	INNER JOIN posicion_puesto AS pp1 ON pp1.id=ica.idcustodio
    INNER JOIN clasificacion_informacion as ci ON ci.id=ica.idclasificacion_informacion
	WHERE ica.is_deleted=0 AND ica.id_user_added=id_user AND e.id=empresa
;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_list_inventario_clasificacion_activo_historial` (IN `idid` INT)   BEGIN
	SELECT
	ica.id_ica AS ica_id,
	ica.activo,
	ica.desc_activo,
	ica.idpropietario AS propietario,
	pp.posicion_puesto AS des_propietario,
	ica.idcustodio AS custodio,
	ica.observacion AS observacion,
	ica.date_add AS date_created,
	pp1.posicion_puesto AS des_custodio,
	ica.vals AS vals,
	ica.estado AS ica_estado,
	ica.comentario AS ica_comentario,
	e.id AS id_empresa,
	e.empresa AS empresa,
	a.id AS id_area,
	a.area AS area,
	u.id AS id_unidad,
	u.unidad AS unidad,
     ica.estado_2 as ica_estado_2,
	m.id AS id_macroproceso,
	m.macroproceso AS macroproceso,
	p.id AS id_proceso,
	p.proceso AS proceso,
	ta.id AS id_tipo_activo,
	ta.tipo AS tipo_activo,
	ca.id AS id_categoria_activo,
	ca.categoria AS categoria_activo,
	ua.id AS ubicacion_id,
	ua.continente AS ubicacion_continente,
	ua.pais AS ubicacion_pais,
	ua.ciudad AS ubicacion_ciudad,
	ua.direccion AS ubicacion_direccion,
	ua.descripcion AS ubicacion_descripcion,
	va.id AS id_valor,
	va.valor AS valor,
      ci.id as id_clasificacion,
     ci.clasificacion as clasificacion
	FROM inventario_clasificacion_activo_historial AS ica
	INNER JOIN empresa AS e ON e.id=ica.idempresa
	INNER JOIN area AS a ON a.id=ica.idarea
	INNER JOIN unidades AS u ON u.id=ica.idunidades
	INNER JOIN macroproceso AS m ON m.id=ica.idmacroproceso
	INNER JOIN proceso AS p ON p.id=ica.idproceso
	INNER JOIN tipo_activo AS ta ON ta.id=ica.idtipo_activo
	INNER JOIN categoria_activo AS ca ON ca.id=ica.idcategoria_activo
	INNER JOIN ubicacion_activo AS ua ON ua.id=ica.idubicacion
	INNER JOIN valor_activo AS va ON va.id=ica.idvalor
	INNER JOIN posicion_puesto AS pp ON pp.id=ica.idpropietario
	INNER JOIN posicion_puesto AS pp1 ON pp1.id=ica.idcustodio
    INNER JOIN clasificacion_informacion as ci ON ci.id=ica.idclasificacion_informacion
	WHERE ica.is_deleted=0 AND e.id=idid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_list_inventario_clasificacion_activo_historial_by_user` (IN `id_user` INT, IN `idid` INT)   BEGIN
	SELECT
	ica.id_ica AS ica_id,
	ica.activo,
	ica.desc_activo,
	ica.idpropietario AS propietario,
	ica.date_add AS date_created,
	pp.posicion_puesto AS des_propietario,
	ica.idcustodio AS custodio,
	ica.observacion AS observacion,
	pp1.posicion_puesto AS des_custodio,
	ica.vals AS vals,
	ica.estado AS ica_estado,
	ica.comentario AS ica_comentario,
	e.id AS id_empresa,
	e.empresa AS empresa,
	a.id AS id_area,
	a.area AS area,
	u.id AS id_unidad,
     ica.estado_2 as ica_estado_2,
	u.unidad AS unidad,
	m.id AS id_macroproceso,
	m.macroproceso AS macroproceso,
	p.id AS id_proceso,
	p.proceso AS proceso,
	ta.id AS id_tipo_activo,
	ta.tipo AS tipo_activo,
	ca.id AS id_categoria_activo,
	ca.categoria AS categoria_activo,
	ua.id AS ubicacion_id,
	ua.continente AS ubicacion_continente,
	ua.pais AS ubicacion_pais,
	ua.ciudad AS ubicacion_ciudad,
	ua.direccion AS ubicacion_direccion,
	ua.descripcion AS ubicacion_descripcion,
	va.id AS id_valor,
	va.valor AS valor,
    ci.id as id_clasificacion,
     ci.clasificacion as clasificacion
	FROM inventario_clasificacion_activo_historial AS ica
	INNER JOIN empresa AS e ON e.id=ica.idempresa
	INNER JOIN area AS a ON a.id=ica.idarea
	INNER JOIN unidades AS u ON u.id=ica.idunidades
	INNER JOIN macroproceso AS m ON m.id=ica.idmacroproceso
	INNER JOIN proceso AS p ON p.id=ica.idproceso
	INNER JOIN tipo_activo AS ta ON ta.id=ica.idtipo_activo
	INNER JOIN categoria_activo AS ca ON ca.id=ica.idcategoria_activo
	INNER JOIN ubicacion_activo AS ua ON ua.id=ica.idubicacion
	INNER JOIN valor_activo AS va ON va.id=ica.idvalor
	INNER JOIN posicion_puesto AS pp ON pp.id=ica.idpropietario
	INNER JOIN posicion_puesto AS pp1 ON pp1.id=ica.idcustodio
	INNER JOIN inventario_clasificacion_activo AS ic ON ic.id=ica.id_ica
    INNER JOIN clasificacion_informacion as ci ON ci.id=ica.idclasificacion_informacion
	WHERE ica.is_deleted=0 AND ic.id_user_added=id_user 
    AND e.id=idid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_list_nivel_riesgo` ()   BEGIN
	SELECT * FROM nivel_riesgo WHERE is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_list_probabilidad` (IN `idescenario` INT)   BEGIN
	SELECT * FROM probabilidad_riesgo WHERE escenario=idescenario AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_list_tipo_amenaza` ()   BEGIN
	SELECT * FROM tipo_amenaza WHERE is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_list_tipo_riesgo` ()   BEGIN
	SELECT * FROM tipo_riesgo WHERE is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_save_users` (IN `docident_us` VARCHAR(50), IN `nombres_us` VARCHAR(100), IN `apepat_us` VARCHAR(100), IN `apemat_us` VARCHAR(100), IN `email_us` VARCHAR(255), IN `usuario_us` VARCHAR(50), IN `perfil_us` INT, IN `id_empresa` INT, IN `id_puesto` INT, IN `id_area` INT, IN `id_unidad` INT)   BEGIN
    DECLARE creacion_us DATETIME DEFAULT NOW();
    DECLARE estado_us INT DEFAULT 1;
    DECLARE change_pass INT DEFAULT 0;
    
    INSERT INTO tb_users (
        docident_us,
        nombres_us,
        apepat_us,
        apemat_us,
        email_us,
        usuario_us,
        creacion_us,
        estado_us,
        bloqueo_us,
        change_pass,
        perfil_us,
        idempresa,
        idposicion,
        idarea,
        idunidad,
        intentos_us
    ) VALUES (
        docident_us,
        nombres_us,
        apepat_us,
        apemat_us,
        email_us,
        usuario_us,
        creacion_us,
        estado_us,
        0,
        change_pass,
        perfil_us,
        id_empresa,
        id_puesto,
        id_area,
        id_unidad,
        1
    );
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_set_time_intento` (IN `username` VARCHAR(50))   BEGIN
   UPDATE  tb_users SET bloqueo_us=1  where usuario_us= username;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_evaluacion_riesgo` (IN `idid` INT, IN `idid_tipo_riesgo` INT, IN `idid_empresa` INT, IN `idid_area` INT, IN `idid_unidad` INT, IN `idid_macroproceso` INT, IN `idid_proceso` INT, IN `idid_activo` INT, IN `idid_tipo_amenaza` INT, IN `idid_descripcion_amenaza` INT, IN `idid_tipo_vulnerabilidad` INT, IN `idid_descripcion_vulnerabilidad` INT, IN `idriesgo` VARCHAR(150), IN `idvalor_probabilidad` INT, IN `idprobabilidad` VARCHAR(150), IN `idvalor_impacto` VARCHAR(150), IN `idimpacto` VARCHAR(150), IN `idvalor` VARCHAR(150), IN `idid_control` INT, IN `idriesgo_controlado_probabilidad` VARCHAR(150), IN `idriesgo_controlado_impacto` VARCHAR(150), IN `idriesgo_controlado_valor` VARCHAR(150), IN `idestado` INT, IN `idid_user_updated` INT, IN `iddate_modify` DATETIME)   BEGIN
	UPDATE evaluacion_riesgo
	SET 
	id_tipo_riesgo=idid_tipo_riesgo,
	idempresa=idid_empresa,
	idarea=idid_area,
	idunidades=idid_unidad,
	idmacroproceso=idid_macroproceso,
	idproceso=idid_proceso,
	id_activo=idid_activo,
	id_tipo_amenaza=idid_tipo_amenaza,
	id_descripcion_amenaza=idid_descripcion_amenaza,
	id_tipo_vulnerabilidad=idid_tipo_vulnerabilidad,
	id_descripcion_vulnerabilidad=idid_descripcion_vulnerabilidad,
	riesgo=idriesgo,
	valor_probabilidad=idvalor_probabilidad,
	probabilidad=idprobabilidad,
	valor_impacto=idvalor_impacto,
	impacto=idimpacto,
	valor=idvalor,
	id_control=idid_control,
	riesgo_controlado_probabilidad=idriesgo_controlado_probabilidad,
	riesgo_controlado_impacto=idriesgo_controlado_impacto,
	riesgo_controlado_valor=idriesgo_controlado_valor,
	estado=idestado,
	id_user_updated=idid_user_updated,
	date_modify=iddate_modify
	WHERE id=idid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_evaluacion_riesgo_nivel` (IN `idid` INT, IN `idid_tipo_riesgo` INT, IN `idid_empresa` INT, IN `idid_area` INT, IN `idid_unidad` INT, IN `idid_macroproceso` INT, IN `idid_proceso` INT, IN `idid_activo` INT, IN `idid_tipo_amenaza` INT, IN `idid_descripcion_amenaza` INT, IN `idid_tipo_vulnerabilidad` INT, IN `idid_descripcion_vulnerabilidad` INT, IN `idriesgo` VARCHAR(150), IN `idvalor_probabilidad` INT, IN `idprobabilidad` VARCHAR(150), IN `idvalor_impacto` VARCHAR(150), IN `idimpacto` VARCHAR(150), IN `idvalor` VARCHAR(150), IN `idid_control` INT, IN `idriesgo_controlado_probabilidad` VARCHAR(150), IN `idriesgo_controlado_impacto` VARCHAR(150), IN `idriesgo_controlado_valor` VARCHAR(150), IN `idestado` INT, IN `idid_user_updated` INT, IN `iddate_modify` DATETIME, IN `id_probabilidad_param` INT, IN `id_impacto_param` INT, IN `id_nivel_riesgo_param` INT)   BEGIN
	UPDATE evaluacion_riesgo
	SET 
	id_tipo_riesgo=idid_tipo_riesgo,
	idempresa=idid_empresa,
	idarea=idid_area,
	idunidades=idid_unidad,
	idmacroproceso=idid_macroproceso,
	idproceso=idid_proceso,
    idinventario_clasificacion_activo=idid_activo,
	id_activo=idid_activo,
	id_tipo_amenaza=idid_tipo_amenaza,
	id_descripcion_amenaza=idid_descripcion_amenaza,
	id_tipo_vulnerabilidad=idid_tipo_vulnerabilidad,
	id_descripcion_vulnerabilidad=idid_descripcion_vulnerabilidad,
	riesgo=idriesgo,
	valor_probabilidad=idvalor_probabilidad,
	probabilidad=idprobabilidad,
	valor_impacto=idvalor_impacto,
	impacto=idimpacto,
	valor=idvalor,
	id_control=idid_control,
	riesgo_controlado_probabilidad=idriesgo_controlado_probabilidad,
	riesgo_controlado_impacto=idriesgo_controlado_impacto,
	riesgo_controlado_valor=idriesgo_controlado_valor,
	estado=idestado,
	id_user_updated=idid_user_updated,
	date_modify=iddate_modify,
    idprobabilidad_riesgo=id_probabilidad_param,
    idimpacto_riesgo=id_impacto_param,
    idnivel_riesgo=id_nivel_riesgo_param
	WHERE id=idid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_evaluacion_riesgo_valoracion` (IN `idid` INT, IN `idid_tipo_riesgo` INT, IN `idid_empresa` INT, IN `idid_area` INT, IN `idid_unidad` INT, IN `idid_macroproceso` INT, IN `idid_proceso` INT, IN `idid_activo` INT, IN `idid_tipo_amenaza` INT, IN `idid_descripcion_amenaza` INT, IN `idid_tipo_vulnerabilidad` INT, IN `idid_descripcion_vulnerabilidad` INT, IN `idriesgo` VARCHAR(150), IN `idvalor_probabilidad` INT, IN `idprobabilidad` VARCHAR(150), IN `idvalor_impacto` VARCHAR(150), IN `idimpacto` VARCHAR(150), IN `idvalor` VARCHAR(150), IN `idid_control` INT, IN `idriesgo_controlado_probabilidad` VARCHAR(150), IN `idriesgo_controlado_impacto` VARCHAR(150), IN `idriesgo_controlado_valor` VARCHAR(150), IN `idestado` INT, IN `idid_user_updated` INT, IN `iddate_modify` DATETIME, IN `id_probabilidad_param` INT, IN `id_impacto_param` INT, IN `id_valoracion_riesgo_param` INT)   BEGIN
	UPDATE evaluacion_riesgo
	SET 
	id_tipo_riesgo=idid_tipo_riesgo,
	idempresa=idid_empresa,
	idarea=idid_area,
	idunidades=idid_unidad,
	idmacroproceso=idid_macroproceso,
	idproceso=idid_proceso,
    idinventario_clasificacion_activo=idid_activo,
	id_activo=idid_activo,
	id_tipo_amenaza=idid_tipo_amenaza,
	id_descripcion_amenaza=idid_descripcion_amenaza,
	id_tipo_vulnerabilidad=idid_tipo_vulnerabilidad,
	id_descripcion_vulnerabilidad=idid_descripcion_vulnerabilidad,
	riesgo=idriesgo,
	valor_probabilidad=idvalor_probabilidad,
	probabilidad=idprobabilidad,
	valor_impacto=idvalor_impacto,
	impacto=idimpacto,
	valor=idvalor,
	id_control=idid_control,
	riesgo_controlado_probabilidad=idriesgo_controlado_probabilidad,
	riesgo_controlado_impacto=idriesgo_controlado_impacto,
	riesgo_controlado_valor=idriesgo_controlado_valor,
	estado=idestado,
	id_user_updated=idid_user_updated,
	date_modify=iddate_modify,
    idprobabilidad_riesgo=id_probabilidad_param,
    idimpacto_riesgo=id_impacto_param,
    idvaloracion_riesgo=id_valoracion_riesgo_param
	WHERE id=idid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_intentos` (IN `p_username` VARCHAR(255), IN `newintento` INT)   BEGIN
    UPDATE tb_users SET intentos_us = newintento WHERE usuario_us = p_username;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_scene_probabilidad_user` (IN `user_id` INT, IN `idscene` INT)   BEGIN
	UPDATE escenario_active SET escenario=idscene;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_tipo_riesgo` (IN `idid` INT, IN `tipo_riesgo` VARCHAR(150), IN `descripcion` VARCHAR(150), IN `estado` INT, IN `id_user_updated` INT, IN `date_modify` DATETIME)   BEGIN
	UPDATE tipo_riesgo
	SET tipo_riesgo=tipo_riesgo,descripcion=descripcion,estado=estado,id_user_updated=id_user_updated,date_modify=date_modify
	WHERE id=idid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_user` (IN `nombres_us` VARCHAR(255), IN `docident_us` VARCHAR(255), IN `apepat_us` VARCHAR(255), IN `apemat_us` VARCHAR(255), IN `perfil_us` VARCHAR(255), IN `estado_us` INT, IN `email_us` VARCHAR(255), IN `id_empresa` INT, IN `id_area` INT, IN `id_puesto` INT, IN `id_unidad` INT, IN `idid_us` INT)   BEGIN
    UPDATE tb_users 
    SET nombres_us = nombres_us, docident_us = docident_us, apepat_us = apepat_us, apemat_us = apemat_us, 
        perfil_us = perfil_us, estado_us = estado_us, email_us = email_us, actualizacion_us = NOW(), 
        idempresa = id_empresa, idarea = id_area, idposicion = id_puesto, idunidad = id_unidad
    WHERE id_us = idid_us;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_user_estado` (IN `idid_us` INT, IN `estado_us` INT)   BEGIN
    UPDATE tb_users
    SET bloqueo_us = estado_us, intentos_us = 1
    WHERE id_us = idid_us;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_vals` (IN `vals_param` VARCHAR(500), IN `id_param` INT)   BEGIN
	UPDATE inventario_clasificacion_activo SET vals=vals_param where id=id_param;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_alerta_modify` (IN `idalertaparam` INT, IN `alerta_param` VARCHAR(150))   begin
	select * from alert_seguimiento where alerta=alerta_param and id!=idalertaparam and is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_apli_impac_modify` (IN `idapli_impacparam` INT, IN `disenio_param` VARCHAR(150), IN `posicion_param` VARCHAR(150), IN `escenario_param` VARCHAR(150))   begin
	select * from aplicacion_impacto WHERE idclasificacion=disenio_param AND 
	posicion=posicion_param AND escenario=escenario_param and id!=idapli_impacparam and is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_apli_impac_modify2` (IN `idapli_impacparam` INT, IN `posicion_param` VARCHAR(150), IN `escenario_param` VARCHAR(150))   begin
	select * from aplicacion_impacto WHERE 
	posicion=posicion_param AND escenario=escenario_param and id!=idapli_impacparam and is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_apli_proba_modify` (IN `idapli_probaparam` INT, IN `disenio_param` VARCHAR(150), IN `posicion_param` VARCHAR(150), IN `escenario_param` VARCHAR(150))   begin
	select * from aplicacion_probailidad WHERE idclasificacion=disenio_param AND 
	posicion=posicion_param AND escenario=escenario_param and id!=idapli_probaparam and is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_apli_proba_modify2` (IN `idapli_probaparam` INT, IN `posicion_param` VARCHAR(150), IN `escenario_param` VARCHAR(150))   begin
	select * from aplicacion_probailidad WHERE 
	posicion=posicion_param AND escenario=escenario_param and id!=idapli_probaparam and is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_area_modify` (IN `idareaparam` INT, IN `area_param` VARCHAR(150), IN `empresa` INT)   begin
	select * from area where idempresa=empresa and area=area_param and id!=idareaparam and is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_aspecto_modify` (IN `idaspectoparam` INT, IN `aspecto_param` VARCHAR(150))   begin
	select * from aspectos_seguridad where aspecto=aspecto_param and id!=idaspectoparam and is_deleted=0;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_caract_control_modify` (IN `idcarac_controlparam` INT, IN `caract_param` VARCHAR(150), IN `idOpcionparam` INT)   begin
	select * FROM caracteristica_control WHERE caracteristica=caract_param AND idOpcion=idOpcionparam and id!=idcarac_controlparam and is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_caract_control_modify2` (IN `idcarac_controlparam` INT, IN `valor_param` VARCHAR(150), IN `condicion_param` VARCHAR(150), IN `idOpcionparam` INT)   begin
	select * FROM caracteristica_control WHERE valor=valor_param  and condicion=condicion_param AND idOpcion=idOpcionparam and id!=idcarac_controlparam and is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_categoria_vulnerabilidad_modify` (IN `id_param` INT, IN `categoria_param` VARCHAR(150))   begin
	select * from categoria_vulnerabilidad where categoria=categoria_param and id!=id_param and is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_clasi_info_modify` (IN `idclasi_infoparam` INT, IN `clasi_info_param` VARCHAR(150))   begin
	select * from clasificacion_informacion where clasificacion=clasi_info_param and id!=idclasi_infoparam and is_deleted=0;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_cobertura_modify` (IN `idcoberturaparam` INT, IN `cobertura_param` VARCHAR(150))   begin
	select * from cobertura where cobertura=cobertura_param and id!=idcoberturaparam and is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_combinatoria_impacto` (IN `idoperador1` VARCHAR(150), IN `idvalor1` INT, IN `idoperador2` VARCHAR(150), IN `idvalor2` INT)   BEGIN
	SELECT * FROM impacto_riesgo
	WHERE operador1=idoperador1 AND valor1=idvalor1
	AND operador2=idoperador2 AND valor2=idvalor2 AND estado=1 AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_combinatoria_probabilidad` (IN `idoperador1` VARCHAR(150), IN `idvalor1` INT, IN `idoperador2` VARCHAR(150), IN `idvalor2` INT)   BEGIN
	SELECT * FROM probabilidad_riesgo
	WHERE operador1=idoperador1 AND valor1=idvalor1
	AND operador2=idoperador2 AND valor2=idvalor2 AND estado=1
    AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_descripcion_amenaza_modify` (IN `id_param` INT, IN `amenaza_param` VARCHAR(150), IN `idtipo_param` INT)   begin
	select * from desc_amenaza where amenaza=amenaza_param and id!=id_param and is_deleted=0 and idtipo_amenaza=idtipo_param;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_descripcion_vulnerabilidad_modify` (IN `id_param` INT, IN `descripcion_param` VARCHAR(150), IN `idcategoria_param` INT)   begin
	select * from desc_vulnerabilidad 
    where vulnerabilidad=descripcion_param 
    and id!=id_param and is_deleted=0 and 
    idcategoria_vulnerabilidad=idcategoria_param;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_empresa_modify` (IN `idempresaparam` INT, IN `empresa_param` VARCHAR(150))   begin
	select * from empresa where empresa=empresa_param and id!=idempresaparam and is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_estado_modify` (IN `idestadoparam` INT, IN `estado_param` VARCHAR(150))   begin
	select * from estado where estado=estado_param and id!=idestadoparam and is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_evaluacion_riesgo_modify` (IN `id_param` INT, IN `riesgo_param` VARCHAR(150), IN `idempresa_param` INT)   begin
	select * from evaluacion_riesgo where riesgo=riesgo_param and id!=id_param and is_deleted=0 and idempresa=idempresa_param;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_impacto_riesgo_modify` (IN `idimpacto_riesgoparam` INT, IN `impacto_riesgo_param` VARCHAR(150), IN `escenario_param` INT)   begin
	select * from impacto_riesgo where descripcion=impacto_riesgo_param and id!=idimpacto_riesgoparam and is_deleted=0 and escenario=escenario_param;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_inventario_modify` (IN `id_param` INT, IN `activo_param` VARCHAR(150), IN `idempresa_param` INT)   begin
	select * from inventario_clasificacion_activo where activo=activo_param and id!=id_param and is_deleted=0 and idempresa=idempresa_param;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_macroproceso_modify` (IN `idmacroprocesoparam` INT, IN `macroproceso_param` VARCHAR(150), IN `empresa` INT, IN `area` INT, IN `unidad` INT)   begin
	select * from macroproceso where idempresa=empresa and 
    idarea=area and idunidades = unidad and macroproceso=macroproceso_param and id!=idmacroprocesoparam and is_deleted=0;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_nivel_riesgo_modify` (IN `idnivel_riesgoparam` INT, IN `descripcion_param` VARCHAR(150))   begin
	select * from nivel_riesgo where descripcion=descripcion_param and id!=idnivel_riesgoparam and is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_perfil_modify` (IN `idperfilparam` INT, IN `perfil_param` VARCHAR(150))   begin
	select * from tb_perfiles where perfil=perfil_param and id_perfil!=idperfilparam and is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_plan_accion_modify` (IN `idplanaccionparam` INT, IN `planaccion_param` VARCHAR(150))   begin
	select * from plan_accion where plan_accion=planaccion_param and id!=idplanaccionparam and is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_prioridad_modify` (IN `idprioridadparam` INT, IN `prioridad_param` VARCHAR(150))   begin
	select * from prioridad where prioridad=prioridad_param and id!=idprioridadparam and is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_probabilidad_riesgo_modify` (IN `idprobabilidad_riesgoparam` INT, IN `probabilidad_riesgo_param` VARCHAR(150), IN `escenario_param` INT)   begin
	select * from probabilidad_riesgo where descripcion=probabilidad_riesgo_param and id!=idprobabilidad_riesgoparam and is_deleted=0 and escenario=escenario_param;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_proceso_modify` (IN `idprocesoparam` INT, IN `proceso_param` VARCHAR(150), IN `empresa` INT, IN `area` INT, IN `unidad` INT, IN `macroproceso` INT)   begin
	select * from proceso where 
    idempresa=empresa and idarea=area and idunidades = unidad AND
    idmacroproceso=macroproceso and proceso=proceso_param and id!=idprocesoparam
    and is_deleted=0;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_puesto_modify` (IN `idpuestoparam` INT, IN `puesto_param` VARCHAR(150), IN `empresa` INT, IN `area` INT, IN `unidad` INT)   begin
	select * from posicion_puesto where idempresa=empresa AND
    idarea=area and idunidades=unidad and posicion_puesto=puesto_param and id!=idpuestoparam
    and is_deleted=0;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_registro_control_modify` (IN `idregistrocontrolparam` INT, IN `registrocontrol_param` VARCHAR(150))   begin
	select * from registro_controles where nom_control=registrocontrol_param and id!=idregistrocontrolparam and is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_tipo_activo_modify` (IN `idtipo_activoparam` INT, IN `tipo_activo_param` VARCHAR(150))   begin
	select * from tipo_activo where tipo=tipo_activo_param and id!=idtipo_activoparam and is_deleted=0;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_tipo_amenaza_modify` (IN `id_param` INT, IN `tipo_param` VARCHAR(150))   begin
	select * from tipo_amenaza where tipo=tipo_param and id!=id_param and is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_tipo_riesgo_modify` (IN `idtipo_riesgoparam` INT, IN `tipo_riesgo_param` VARCHAR(150))   begin
	select * from tipo_riesgo where tipo_riesgo=tipo_riesgo_param and id!=idtipo_riesgoparam and is_deleted=0 ;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_ubi_activo_modify` (IN `idcontinente` VARCHAR(50), IN `idpais` VARCHAR(50), IN `idciudad` VARCHAR(50), IN `iddireccion` VARCHAR(300), IN `iddescripcion` VARCHAR(300), IN `idubi_activo` INT)   BEGIN
	SELECT * FROM ubicacion_activo 
            WHERE continente=idcontinente AND 
			pais=idpais AND
			ciudad= idciudad AND
			direccion=iddireccion AND
			descripcion = iddescripcion AND
            is_deleted=0 and id!=idubi_activo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_unidad_modify` (IN `idunidadparam` INT, IN `unidad_param` VARCHAR(150), IN `empresa` INT, IN `area` INT)   begin
	select * from unidades where idempresa=empresa AND 
    idarea= area and unidad=unidad_param and id!=idunidadparam and is_deleted=0;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_valoracion_activo_modify` (IN `ididaspecto1` INT, IN `ididaspecto2` INT, IN `ididaspecto3` INT, IN `ididvaloracion1` INT, IN `ididvaloracion2` INT, IN `ididvaloracion3` INT, IN `idvaloracion_param` INT)   BEGIN
	SELECT * FROM valoracion_activo 
            WHERE idaspecto1=ididaspecto1
            AND idaspecto2= ididaspecto2
            AND idaspecto3=ididaspecto3
           
            AND valoracion1=ididvaloracion1
            AND valoracion2=ididvaloracion2
            AND valoracion3=ididvaloracion3 AND is_deleted=0 and id!=idvaloracion_param;
            END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_valoracion_riesgo_modify` (IN `probabilidad` INT, IN `impacto` INT, IN `idvaloracion_param` VARCHAR(150))   begin
	 SELECT *
	  FROM valoracion_riesgo WHERE 
	  idprobabilidad_riesgo =probabilidad AND idimpacto_riesgo=impacto and 
      id!=idvaloracion_param and is_deleted=0;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validate_valor_activo_modify` (IN `idvalor_activoparam` INT, IN `valor_activo_param` VARCHAR(150))   begin
	select * from valor_activo where valor=valor_activo_param and id!=idvalor_activoparam and is_deleted=0;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_valoracion_detalle_all` (IN `id_valoracion_param` INT)   BEGIN
SELECT ASP.id as id_aspecto,ASP.aspecto as aspecto,DVA.valoracion as valoracion FROM valoracion_activo as VA inner join detalle_valoracion_activo as DVA
on VA.id = DVA.idvaloracion_activo inner join aspectos_seguridad as ASP 
on ASP.id=DVA.idaspectos_seguridad  where VA.id=id_valoracion_param and VA.is_deleted=0 and DVA.is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateConfigPass` (IN `idduracion` INT, IN `idinactividad` INT, IN `idsesion` INT, IN `idtama_min` INT, IN `idtama_max` INT, IN `idletras` INT, IN `idnumeros` INT, IN `idcaracteres` INT, IN `last_activity` INT, IN `idintentos` INT)   begin
UPDATE config_pass SET
        duracion=idduracion,
        inactividad=idinactividad,
        sesion=idsesion,
        tama_min=idtama_min,
        tama_max=idtama_max,
        letras=idletras,
        numeros=idnumeros,
        caracteres=idcaracteres,
        fecha_actualizacion=last_activity,
        intentos=idintentos;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateControlRiesgo` (IN `riesgos` VARCHAR(100), IN `idid` INT)   begin
update 
        registro_controles set IDR=riesgos where id=idid;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateDetalleAspecto` (IN `idvaloracion` INT)   begin   
   UPDATE detalle_valoracion_activo SET is_deleted=1 where idvaloracion_activo=idvaloracion;
  end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEstadoPLan` (IN `idid` INT)   begin
	UPDATE plan_accion SET idestado=2 where id = idid;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateLoged` (IN `dato` INT)   begin
	UPDATE tb_sesiones set loged=0
        where id_us = dato;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_caractControl_general` (IN `idcarac_controlparam` INT, IN `user_deleted` INT)   begin
	UPDATE caracteristica_control SET is_deleted=1, date_deleted=now(),id_user_deleted=user_deleted whERE idOpcion=idcarac_controlparam ;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_status_ica` (IN `idid` INT, IN `estado` INT, IN `date_modify` DATETIME, IN `id_user_updated` INT)   BEGIN
	UPDATE inventario_clasificacion_activo
	SET estado=estado,id_user_updated=id_user_updated,date_modify=date_modify
	WHERE id=idid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_valor_ica` (IN `id` INT, IN `id_valor` INT)   BEGIN
	UPDATE inventario_clasificacion_activo
	SET idvalor=id_valor
	WHERE id=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `validaAlerta_seguimiento` (IN `idalert` VARCHAR(50))   BEGIN
	  SELECT * FROM alert_seguimiento WHERE alerta=idalert and is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `validaArea` (IN `idarea` VARCHAR(150), IN `empresa` INT)   BEGIN
	SELECT * FROM area   WHERE idempresa =empresa
    AND area=idarea and is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `validaAspecto` (IN `idaspecto` VARCHAR(150))   BEGIN
	 SELECT * FROM aspectos_seguridad WHERE 
         aspecto=idaspecto AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `validaCatActivo` (IN `idcategoria` VARCHAR(150), IN `ididtipo` INT)   BEGIN
	SELECT * FROM categoria_activo 
            WHERE idtipo_activo=ididtipo AND 
			categoria=idcategoria AND
            is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `validaClasInfo` (IN `idclasificacion` VARCHAR(150))   BEGIN
SELECT * FROM clasificacion_informacion 
            WHERE clasificacion=idclasificacion AND
            is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `validaEmpresa` (IN `ïdempresa` VARCHAR(150))   BEGIN
	SELECT * FROM empresa  WHERE empresa =idempresa AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `validaEstado` (IN `idestado` VARCHAR(50))   BEGIN
	  SELECT * FROM estado WHERE estado=idestado and is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `validaMacroproceso` (IN `area` INT, IN `empresa` INT, IN `unidad` INT, IN `idmacroproceso` VARCHAR(150))   BEGIN
	SELECT * FROM macroproceso WHERE 
          idempresa=empresa AND
		idarea = area AND idunidades=unidad
		AND macroproceso=idmacroproceso and is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `validaPlanAccion` (IN `idplan_accion` VARCHAR(150))   BEGIN
	  SELECT * FROM plan_accion WHERE plan_accion=idplan_accion AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `validaPosicion` (IN `area` INT, IN `empresa` INT, IN `unidad` INT, IN `posicion` VARCHAR(150))   BEGIN
	SELECT * FROM posicion_puesto WHERE 
          idempresa=empresa AND
		idarea = area AND idunidades=unidad
		AND posicion_puesto=posicion AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `validaPrioridad` (IN `idprioridad` VARCHAR(150))   BEGIN
	SELECT * FROM prioridad WHERE prioridad=idprioridad AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `validaProceso` (IN `area` INT, IN `empresa` INT, IN `unidad` INT, IN `macroproceso` INT, IN `idproceso` VARCHAR(150))   BEGIN
	SELECT * FROM proceso WHERE 
		idmacroproceso=macroproceso AND
          idempresa=empresa AND
		idarea = area AND idunidades=unidad
		AND proceso=idproceso AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `validaRegistroControl` (IN `dato` VARCHAR(500))   begin
select * from registro_controles 
        where is_deleted=0 and nom_control=dato;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `validaTipoActivo` (IN `idtipo` VARCHAR(150))   BEGIN
	SELECT * FROM tipo_activo 
            WHERE tipo=idtipo AND
            is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `validaUbiActivo` (IN `idcontinente` VARCHAR(50), IN `idpais` VARCHAR(50), IN `idciudad` VARCHAR(50), IN `iddireccion` VARCHAR(300), IN `iddescripcion` VARCHAR(300))   BEGIN
	SELECT * FROM ubicacion_activo 
            WHERE continente=idcontinente AND 
			pais=idpais AND
			ciudad= idciudad AND
			direccion=iddireccion AND
			descripcion = iddescripcion AND
            is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `validaUnidad` (IN `ididarea` INT, IN `ididempresa` INT, IN `idunidad` VARCHAR(150))   BEGIN
	SELECT * FROM unidades WHERE 
          idempresa=ididempresa AND
		idarea = ididarea AND unidad=idunidad and is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `validaValoracionActivo` (IN `ididaspecto1` INT, IN `ididaspecto2` INT, IN `ididaspecto3` INT, IN `ididvaloracion1` INT, IN `ididvaloracion2` INT, IN `ididvaloracion3` INT)   BEGIN
	SELECT * FROM valoracion_activo 
            WHERE idaspecto1=ididaspecto1
            AND idaspecto2= ididaspecto2
            AND idaspecto3=ididaspecto3
           
            AND valoracion1=ididvaloracion1
            AND valoracion2=ididvaloracion2
            AND valoracion3=ididvaloracion3 AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `validaValorActivo` (IN `idvalor` VARCHAR(150))   BEGIN
	 SELECT * FROM valor_activo WHERE 
         valor=idvalor AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `valida_AplicacionImpacto` (IN `disenio` INT, IN `idposicion` VARCHAR(50), IN `idescenario` INT)   BEGIN
	 SELECT *
	FROM aplicacion_impacto WHERE idclasificacion=disenio AND 
	posicion=idposicion AND escenario=idescenario AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `valida_AplicacionImpacto2` (IN `idposicion` VARCHAR(50), IN `idescenario` INT)   BEGIN
	 SELECT *
	FROM aplicacion_impacto WHERE 
	posicion=idposicion AND escenario=idescenario AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `valida_AplicacionProbabilidad` (IN `disenio` INT, IN `idposicion` VARCHAR(50), IN `idescenario` INT)   BEGIN
	SELECT *
	FROM aplicacion_probailidad WHERE idclasificacion=disenio AND 
	posicion=idposicion AND escenario=idescenario AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `valida_AplicacionProbabilidad2` (IN `idposicion` VARCHAR(50), IN `idescenario` INT)   BEGIN
	SELECT *
	FROM aplicacion_probailidad WHERE 
	posicion=idposicion AND escenario=idescenario AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `valida_caractControl` (IN `idcaracteristica` VARCHAR(50), IN `ididOpcion` INT)   BEGIN
	SELECT *
	FROM caracteristica_control WHERE caracteristica=idcaracteristica AND idOpcion=ididOpcion AND is_deleted=0 ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `valida_caractControl2` (IN `idvalor` VARCHAR(50), IN `ididOpcion` INT, IN `idcondicion` VARCHAR(50))   BEGIN
	SELECT *
	FROM caracteristica_control WHERE valor=idvalor 
    and condicion=idcondicion AND idOpcion=ididOpcion AND is_deleted=0 ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `valida_cobertura` (IN `idcobertura` VARCHAR(150))   BEGIN
	SELECT * FROM cobertura WHERE cobertura=idcobertura AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `valida_Evaluacion_Control` (IN `disenio` INT, IN `operatividad` INT, IN `idcalificacion` VARCHAR(50))   BEGIN
	SELECT *
	FROM evaluacion_control
    WHERE idDisenio=disenio AND 
	idOperatividad=operatividad AND calificacion=idcalificacion AND is_deleted=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `valida_ValoracionRiesgo` (IN `probabilidad` INT, IN `impacto` INT)   BEGIN
	  SELECT *
	  FROM valoracion_riesgo WHERE 
	  idprobabilidad_riesgo =probabilidad AND idimpacto_riesgo=impacto and is_deleted=0;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividades_plan`
--

CREATE TABLE `actividades_plan` (
  `id` int(11) NOT NULL,
  `idempresa` int(11) DEFAULT NULL,
  `idarea` int(11) DEFAULT NULL,
  `idunidades` int(11) DEFAULT NULL,
  `idposicion_puesto` int(11) DEFAULT NULL,
  `idusuario` int(11) DEFAULT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  `fecha_inicio` datetime(6) DEFAULT NULL,
  `fecha_fin` datetime(6) DEFAULT NULL,
  `idalerta` int(11) DEFAULT NULL,
  `progreso` int(11) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0,
  `id_planes` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `actividades_plan`
--

INSERT INTO `actividades_plan` (`id`, `idempresa`, `idarea`, `idunidades`, `idposicion_puesto`, `idusuario`, `descripcion`, `fecha_inicio`, `fecha_fin`, `idalerta`, `progreso`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`, `id_planes`) VALUES
(12, 3, 2, 1, 1, 1, 'Actividad 1', '2023-05-11 00:00:00.000000', '2023-06-20 00:00:00.000000', 1, 0, 1, '2023-05-11 00:00:00.000000', NULL, NULL, NULL, NULL, 0, 13),
(13, 3, 2, 1, 1, 1, 'Actividad 1', '2023-05-11 00:00:00.000000', '2023-06-20 00:00:00.000000', 1, 0, 1, '2023-05-11 00:00:00.000000', NULL, NULL, NULL, NULL, 0, 15),
(14, 3, 2, 1, 1, 1, 'ActividadA', '2023-05-11 00:00:00.000000', '2023-06-20 00:00:00.000000', 1, 0, 1, '2023-05-11 00:00:00.000000', NULL, NULL, NULL, NULL, 0, 15),
(15, 3, 2, 1, 1, 1, 'Actividad 1', '2023-05-11 00:00:00.000000', '2023-06-20 00:00:00.000000', 1, 100, 1, '2023-05-11 00:00:00.000000', 1, '2023-05-16 00:00:00.000000', NULL, NULL, 0, 16),
(16, 3, 2, 1, 1, 5, 'ActividadA', '2023-05-16 00:00:00.000000', '2023-06-20 00:00:00.000000', 1, 100, 1, '2023-05-16 00:00:00.000000', 1, '2023-05-16 00:00:00.000000', NULL, NULL, 0, 17);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alert_seguimiento`
--

CREATE TABLE `alert_seguimiento` (
  `id` int(11) NOT NULL,
  `alerta` varchar(150) DEFAULT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  `valor` int(11) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `alert_seguimiento`
--

INSERT INTO `alert_seguimiento` (`id`, `alerta`, `descripcion`, `valor`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`) VALUES
(1, 'Alerta Diaria', 'Alerta Diaria', 1, 1, '2023-05-03 11:39:23.000000', NULL, NULL, NULL, NULL, 0),
(2, 'Alerta Semanal', 'Alerta Semanal', 7, 1, '2023-05-03 11:39:34.000000', NULL, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aplicacion_impacto`
--

CREATE TABLE `aplicacion_impacto` (
  `id` int(11) NOT NULL,
  `idclasificacion` int(11) DEFAULT NULL,
  `posicion` varchar(100) DEFAULT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0,
  `escenario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `aplicacion_impacto`
--

INSERT INTO `aplicacion_impacto` (`id`, `idclasificacion`, `posicion`, `descripcion`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`, `escenario`) VALUES
(1, 2, '0', '0 izquierda', 1, '2023-05-07 00:00:00.000000', NULL, NULL, NULL, NULL, 0, 2),
(2, 1, '2', '2 izquierda', 1, '2023-05-07 00:00:00.000000', NULL, NULL, NULL, NULL, 0, 2),
(3, 11, '25%', '25%', 1, '2023-05-07 00:00:00.000000', 1, '2023-05-19 13:41:33.000000', NULL, NULL, 0, 1),
(4, 12, '50%', '50%', 1, '2023-05-07 00:00:00.000000', 1, '2023-05-19 13:41:37.000000', NULL, NULL, 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aplicacion_probailidad`
--

CREATE TABLE `aplicacion_probailidad` (
  `id` int(11) NOT NULL,
  `idclasificacion` int(11) DEFAULT NULL,
  `posicion` varchar(100) DEFAULT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0,
  `escenario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `aplicacion_probailidad`
--

INSERT INTO `aplicacion_probailidad` (`id`, `idclasificacion`, `posicion`, `descripcion`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`, `escenario`) VALUES
(1, 2, '0', '0 HACIA ABAJO', 1, '2023-05-07 00:00:00.000000', NULL, NULL, NULL, NULL, 0, 2),
(2, 1, '2', '2 HACIA ABAJO', 1, '2023-05-07 00:00:00.000000', NULL, NULL, NULL, NULL, 0, 2),
(3, 12, '50%', '50%', 1, '2023-05-07 00:00:00.000000', 1, '2023-05-19 13:41:21.000000', NULL, NULL, 0, 1),
(4, 11, '25%', '25%', 1, '2023-05-07 00:00:00.000000', 1, '2023-05-19 13:41:25.000000', NULL, NULL, 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `area`
--

CREATE TABLE `area` (
  `id` int(11) NOT NULL,
  `area` varchar(250) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `idempresa` int(11) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `area`
--

INSERT INTO `area` (`id`, `area`, `estado`, `idempresa`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`) VALUES
(1, 'AreaA', 1, 3, 1, '2023-05-02 13:43:32.000000', NULL, '2023-05-18 11:56:20.000000', 1, '2023-05-02 13:43:37.000000', 1),
(2, 'RECURSOS HUMANOS', 1, 3, 1, '2023-05-03 11:08:42.000000', 1, '2023-05-18 12:12:40.000000', NULL, NULL, 0),
(3, 'AreaB', 1, 3, 1, '2023-05-03 11:08:49.000000', NULL, '2023-05-18 11:56:20.000000', NULL, NULL, 0),
(4, 'AreaCC', 1, 3, 1, '2023-05-07 18:13:08.000000', 1, '2023-05-18 11:56:20.000000', NULL, NULL, 0),
(5, 'AreaD', 1, 3, 1, '2023-05-07 18:13:33.000000', NULL, '2023-05-18 11:56:20.000000', 1, '2023-05-07 18:13:37.000000', 1),
(6, 'AREATESTEOA', 1, 6, 1, '2023-05-11 19:28:35.000000', NULL, '2023-05-18 03:25:48.000000', NULL, NULL, 0),
(7, 'AREAC', 1, 3, 1, '2023-05-18 12:12:27.000000', NULL, '2023-05-18 12:15:28.000000', 1, '2023-05-18 12:15:28.000000', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aspectos_seguridad`
--

CREATE TABLE `aspectos_seguridad` (
  `id` int(11) NOT NULL,
  `aspecto` varchar(150) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `aspectos_seguridad`
--

INSERT INTO `aspectos_seguridad` (`id`, `aspecto`, `estado`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`) VALUES
(1, 'Confidencialidad', 2, 1, '2023-05-02 10:45:58.000000', 1, '2023-05-02 10:46:28.000000', 1, '2023-05-02 10:46:28.000000', 1),
(2, 'Confidencialidad', 1, 1, '2023-05-03 11:54:15.000000', 1, '2023-05-18 13:17:36.000000', NULL, NULL, 0),
(3, 'Integridad', 1, 1, '2023-05-03 11:54:30.000000', NULL, NULL, NULL, NULL, 0),
(4, 'Disponibilidad', 1, 1, '2023-05-03 11:54:37.000000', NULL, NULL, NULL, NULL, 0),
(5, 'ConfidencialidadA', 1, 1, '2023-05-18 13:11:17.000000', NULL, '2023-05-18 13:11:21.000000', 1, '2023-05-18 13:11:21.000000', 1),
(6, 'NUEVO', 1, 1, '2023-05-18 13:18:45.000000', NULL, '2023-05-18 13:18:50.000000', 1, '2023-05-18 13:18:50.000000', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `caracteristica_control`
--

CREATE TABLE `caracteristica_control` (
  `id` int(11) NOT NULL,
  `caracteristica` varchar(150) NOT NULL,
  `descripcion` varchar(150) NOT NULL,
  `estado` int(11) NOT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0,
  `valor` varchar(30) DEFAULT NULL,
  `condicion` varchar(2) DEFAULT NULL,
  `peso` varchar(30) DEFAULT NULL,
  `tipo` varchar(30) DEFAULT NULL,
  `idOpcion` int(11) DEFAULT NULL,
  `clasificacion` int(11) DEFAULT NULL,
  `check_tabla` int(11) DEFAULT NULL,
  `nom_tabla` varchar(100) DEFAULT NULL,
  `seleccionable` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `caracteristica_control`
--

INSERT INTO `caracteristica_control` (`id`, `caracteristica`, `descripcion`, `estado`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`, `valor`, `condicion`, `peso`, `tipo`, `idOpcion`, `clasificacion`, `check_tabla`, `nom_tabla`, `seleccionable`) VALUES
(1, 'Diseño', 'Diseño', 1, 1, '2023-05-02 00:00:00.000000', NULL, '2023-05-02 11:18:09.000000', 1, '2023-05-02 11:18:09.000000', 1, '', '', '', 'menu', 0, 0, 0, '', 0),
(3, 'Calificación de diseño', 'Calificación de diseño', 1, 1, '2023-05-02 00:00:00.000000', NULL, NULL, 1, '2023-05-02 11:18:09.000000', 1, '', '', '', 'submenu', 1, 1, 0, '', 0),
(4, 'Bajo', 'Bajo', 1, 1, '2023-05-02 00:00:00.000000', 1, '2023-05-02 11:18:00.000000', 1, '2023-05-02 11:18:00.000000', 1, '1', '<=', '', 'opcion', 3, 1, 0, '', 0),
(5, 'Objetivo', 'Objetivo', 1, 1, '2023-05-02 00:00:00.000000', 1, '2023-05-02 00:00:00.000000', 1, '2023-05-02 11:18:09.000000', 1, '', '', '', 'submenu', 1, 0, 0, '', 1),
(6, 'No cumple', 'No cumple', 1, 1, '2023-05-02 00:00:00.000000', 1, '2023-05-02 11:17:52.000000', 1, '2023-05-02 11:17:52.000000', 1, '', '', '0', 'opcion', 5, 0, 0, '', 0),
(7, 'Diseño', 'Diseño', 1, 1, '2023-05-02 00:00:00.000000', NULL, NULL, NULL, NULL, 0, '', '', '', 'menu', 0, 0, 0, '', 0),
(8, 'Objetivo', 'Objetivo', 1, 1, '2023-05-02 00:00:00.000000', NULL, NULL, NULL, NULL, 0, '', '', '', 'submenu', 7, 0, 0, '', 1),
(9, 'No cumplee', 'No cumple', 1, 1, '2023-05-02 00:00:00.000000', 1, '2023-05-02 00:00:00.000000', NULL, NULL, 0, '', '', '0', 'opcion', 8, 0, 0, '', 0),
(10, 'Cumple parcialmente', 'No cumple', 1, 1, '2023-05-02 00:00:00.000000', NULL, '2023-05-02 11:32:23.000000', 1, '2023-05-02 11:32:23.000000', 1, '', '', '0', 'opcion', 8, 0, 0, '', 0),
(11, 'Semi-cumple', 'Semi-cumple', 1, 1, '2023-05-02 00:00:00.000000', NULL, NULL, NULL, NULL, 0, '', '', '1', 'opcion', 8, 0, 0, '', 0),
(12, 'Calificación de diseño', 'Calificación de diseño', 1, 1, '2023-05-02 00:00:00.000000', NULL, NULL, NULL, NULL, 0, '', '', '', 'submenu', 7, 1, 0, '', 0),
(13, 'Operatividad', 'Operatividad', 1, 1, '2023-05-02 00:00:00.000000', 1, '2023-05-02 00:00:00.000000', NULL, NULL, 0, '', '', '', 'menu', 0, 0, 0, '', 0),
(14, 'Calificación de operatividad', 'Calificación de operatividad', 1, 1, '2023-05-02 00:00:00.000000', NULL, NULL, NULL, NULL, 0, '', '', '', 'submenu', 13, 1, 0, '', 0),
(15, 'Débil', 'Débil', 1, 1, '2023-05-02 00:00:00.000000', 1, '2023-05-19 00:00:00.000000', NULL, NULL, 0, '1', '<=', '', 'opcion', 12, 1, 0, '', 0),
(16, 'Débil', 'Débil', 1, 1, '2023-05-02 00:00:00.000000', 1, '2023-05-19 00:00:00.000000', NULL, NULL, 0, '1', '<=', '', 'opcion', 14, 1, 0, '', 0),
(17, 'Moderado', 'Moderado', 1, 1, '2023-05-02 00:00:00.000000', NULL, NULL, NULL, NULL, 0, '2', '=', '', 'opcion', 14, 1, 0, '', 0),
(18, 'Moderado', 'Moderado', 1, 1, '2023-05-02 00:00:00.000000', NULL, NULL, NULL, NULL, 0, '2', '=', '', 'opcion', 12, 1, 0, '', 0),
(19, 'Definición', 'Definiciónnn', 1, 1, '2023-05-02 00:00:00.000000', 1, '2023-05-02 13:22:27.000000', 1, '2023-05-02 13:22:27.000000', 1, '', '', '', 'submenu', 7, 0, 0, '', 0),
(20, 'Nuevo', 'Nuevo', 1, 1, '2023-05-02 00:00:00.000000', NULL, '2023-05-02 13:27:12.000000', 1, '2023-05-02 13:27:12.000000', 1, '', '', '', 'menu', 0, 0, 0, '', 0),
(21, 'Nuevo2', 'Nuevo', 1, 1, '2023-05-02 00:00:00.000000', 1, '2023-05-02 13:27:38.000000', 1, '2023-05-02 13:27:38.000000', 1, '', '', '', 'menu', 0, 0, 0, '', 0),
(22, 'Si cumple', 'Si cumple', 1, 1, '2023-05-02 00:00:00.000000', NULL, '2023-05-02 17:44:25.000000', 1, '2023-05-02 17:44:25.000000', 1, '', '', '0', 'opcion', 8, 0, 0, '', 0),
(23, 'Si cumple', 'Si cumple', 1, 1, '2023-05-02 00:00:00.000000', NULL, '2023-05-02 17:47:10.000000', 1, '2023-05-02 17:47:10.000000', 1, '', '', '0', 'opcion', 8, 0, 0, '', 0),
(24, 'Si cumple', 'Si cumple', 1, 1, '2023-05-02 00:00:00.000000', NULL, NULL, NULL, NULL, 0, '', '', '0', 'opcion', 8, 0, 0, '', 0),
(25, 'Automatizacion', 'Automatizacion', 1, 1, '2023-05-05 00:00:00.000000', NULL, NULL, NULL, NULL, 0, '', '', '', 'submenu', 13, 0, 0, '', 1),
(26, 'Manual', 'Manual', 1, 1, '2023-05-05 00:00:00.000000', NULL, NULL, NULL, NULL, 0, '', '', '0', 'opcion', 25, 0, 0, '', 0),
(27, 'Automatico', 'Automatico', 1, 1, '2023-05-05 00:00:00.000000', NULL, NULL, NULL, NULL, 0, '', '', '1', 'opcion', 25, 0, 0, '', 0),
(28, 'Definición', 'Definición', 1, 1, '2023-05-05 00:00:00.000000', 1, '2023-05-05 00:00:00.000000', NULL, NULL, 0, '', '', '', 'submenu', 7, 0, 0, '', 0),
(29, 'Responsable', 'Responsable', 1, 1, '2023-05-05 00:00:00.000000', 1, '2023-05-07 00:00:00.000000', NULL, NULL, 0, '', '', '2', 'opcion', 28, 0, 1, '1', 0),
(30, 'Fuerte', 'Fuerte', 1, 1, '2023-05-18 00:00:00.000000', 1, '2023-05-19 00:00:00.000000', NULL, NULL, 0, '2', '>', '', 'opcion', 14, 1, 0, '', 0),
(31, 'Alto', 'Alto', 1, 1, '2023-05-18 00:00:00.000000', NULL, '2023-05-18 21:31:44.000000', 1, '2023-05-18 21:31:44.000000', 1, '2', '>', '', 'opcion', 12, 1, 0, '', 0),
(32, 'Prueba o revisión', 'Prueba o revisión', 1, 1, '2023-05-18 00:00:00.000000', 1, '2023-05-18 00:00:00.000000', NULL, NULL, 0, '', '', '', 'submenu', 13, 0, 0, '', 1),
(33, 'Revisado', 'Revisado', 1, 1, '2023-05-18 00:00:00.000000', NULL, NULL, NULL, NULL, 0, '', '', '0', 'opcion', 32, 0, 0, '', 0),
(34, 'Probado', 'Revisado', 1, 1, '2023-05-18 00:00:00.000000', 1, '2023-05-18 00:00:00.000000', NULL, NULL, 0, '', '', '0', 'opcion', 32, 0, 0, '', 0),
(35, 'Característica de Operatividad', 'Característica de Operatividad', 1, 1, '2023-05-18 00:00:00.000000', 1, '2023-05-18 00:00:00.000000', NULL, NULL, 0, '', '', '', 'submenu', 13, 0, 0, '', 1),
(36, 'Cumple muy fuerte', 'Cumple muy fuerte', 1, 1, '2023-05-18 00:00:00.000000', 1, '2023-05-18 00:00:00.000000', NULL, NULL, 0, '', '', '0', 'opcion', 8, 0, 0, '', 0),
(37, 'Fuerte', 'Fuerte', 1, 1, '2023-05-18 00:00:00.000000', NULL, '2023-05-18 22:05:34.000000', 1, '2023-05-18 22:05:34.000000', 1, '2', '>', '', 'opcion', 12, 1, 0, '', 0),
(38, 'Nuevo', 'Nuevo', 1, 1, '2023-05-18 00:00:00.000000', NULL, '2023-05-19 13:14:19.000000', 1, '2023-05-19 13:14:19.000000', 1, '', '', '0', 'submenu', 7, 0, 0, '', 1),
(39, 'Muy Alto', 'Muy Alto', 1, 1, '2023-05-18 00:00:00.000000', NULL, '2023-05-18 22:04:54.000000', 1, '2023-05-18 22:04:54.000000', 1, '', '', '', 'opcion', 8, 0, 0, '', 0),
(40, 'Muy alto', 'Muy alto', 1, 1, '2023-05-18 00:00:00.000000', 1, '2023-05-18 00:00:00.000000', NULL, NULL, 0, '', '', '', 'opcion', 8, 0, 0, '', 0),
(41, 'Fuerte', 'Fuerte', 1, 1, '2023-05-18 00:00:00.000000', NULL, NULL, NULL, NULL, 0, '2', '>', '', 'opcion', 12, 1, 0, '', 0),
(42, 'Demasiado', 'Demasiado', 1, 1, '2023-05-18 00:00:00.000000', 1, '2023-05-18 00:00:00.000000', NULL, NULL, 0, '', '', '', 'opcion', 8, 0, 0, '', 0),
(43, 'Detectivo', 'Detectivo', 1, 1, '2023-05-18 00:00:00.000000', NULL, NULL, NULL, NULL, 0, '', '', '0', 'opcion', 35, 0, 0, '', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `catalogo_tabla`
--

CREATE TABLE `catalogo_tabla` (
  `id` int(11) NOT NULL,
  `nom_tabla` varchar(100) DEFAULT NULL,
  `desc_tabla` varchar(150) DEFAULT NULL,
  `dato` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `catalogo_tabla`
--

INSERT INTO `catalogo_tabla` (`id`, `nom_tabla`, `desc_tabla`, `dato`) VALUES
(1, 'posicion_puesto', 'Posicion y Puesto', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria_activo`
--

CREATE TABLE `categoria_activo` (
  `id` int(11) NOT NULL,
  `categoria` varchar(150) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `idtipo_activo` int(11) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categoria_activo`
--

INSERT INTO `categoria_activo` (`id`, `categoria`, `estado`, `idtipo_activo`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`) VALUES
(1, 'ACTCATA', 1, 1, 1, '2023-05-07 18:28:01.000000', NULL, NULL, NULL, NULL, 0),
(2, 'ACTCATB', 1, 2, 1, '2023-05-07 18:28:09.000000', NULL, NULL, NULL, NULL, 0),
(3, 'SOFTWARE', 1, 2, 1, '2023-05-18 14:18:09.000000', 1, '2023-05-18 14:21:37.000000', 1, '2023-05-18 14:21:37.000000', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria_vulnerabilidad`
--

CREATE TABLE `categoria_vulnerabilidad` (
  `id` int(11) NOT NULL,
  `categoria` varchar(150) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categoria_vulnerabilidad`
--

INSERT INTO `categoria_vulnerabilidad` (`id`, `categoria`, `estado`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`) VALUES
(1, 'CATA', 1, 1, '2023-05-07 18:26:26.000000', NULL, NULL, NULL, NULL, 0),
(2, 'CATB', 1, 1, '2023-05-07 18:26:32.000000', NULL, NULL, NULL, NULL, 0),
(3, 'CATC', 1, 1, '2023-05-09 18:07:35.000000', NULL, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudad`
--

CREATE TABLE `ciudad` (
  `id` int(11) NOT NULL,
  `ubicacionpaisid` int(11) DEFAULT NULL,
  `estadonombre` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ciudad`
--

INSERT INTO `ciudad` (`id`, `ubicacionpaisid`, `estadonombre`) VALUES
(1, 3, 'Azerbaijan'),
(2, 3, 'Nargorni Karabakh'),
(3, 3, 'Nakhichevanskaya Region'),
(4, 4, 'Anguilla'),
(5, 7, 'Brestskaya obl.'),
(6, 7, 'Vitebskaya obl.'),
(7, 7, 'Gomelskaya obl.'),
(8, 7, 'Grodnenskaya obl.'),
(9, 7, 'Minskaya obl.'),
(10, 7, 'Mogilevskaya obl.'),
(11, 8, 'Belize'),
(12, 10, 'Hamilton'),
(13, 15, 'Dong Bang Song Cuu Long'),
(14, 15, 'Dong Bang Song Hong'),
(15, 15, 'Dong Nam Bo'),
(16, 15, 'Duyen Hai Mien Trung'),
(17, 15, 'Khu Bon Cu'),
(18, 15, 'Mien Nui Va Trung Du'),
(19, 15, 'Thai Nguyen'),
(20, 16, 'Artibonite'),
(21, 16, 'Grand&#039;Anse'),
(22, 16, 'North West'),
(23, 16, 'West'),
(24, 16, 'South'),
(25, 16, 'South East'),
(26, 17, 'Grande-Terre'),
(27, 17, 'Basse-Terre'),
(28, 21, 'Abkhazia'),
(29, 21, 'Ajaria'),
(30, 21, 'Georgia'),
(31, 21, 'South Ossetia'),
(32, 23, 'Al QÄhira'),
(33, 23, 'Aswan'),
(34, 23, 'Asyut'),
(35, 23, 'Beni Suef'),
(36, 23, 'Gharbia'),
(37, 23, 'Damietta'),
(38, 24, 'Southern District'),
(39, 24, 'Central District'),
(40, 24, 'Northern District'),
(41, 24, 'Haifa'),
(42, 24, 'Tel Aviv'),
(43, 24, 'Jerusalem'),
(44, 25, 'Bangala'),
(45, 25, 'Chhattisgarh'),
(46, 25, 'Karnataka'),
(47, 25, 'Uttaranchal'),
(48, 25, 'Andhara Pradesh'),
(49, 25, 'Assam'),
(50, 25, 'Bihar'),
(51, 25, 'Gujarat'),
(52, 25, 'Jammu and Kashmir'),
(53, 25, 'Kerala'),
(54, 25, 'Madhya Pradesh'),
(55, 25, 'Manipur'),
(56, 25, 'Maharashtra'),
(57, 25, 'Megahalaya'),
(58, 25, 'Orissa'),
(59, 25, 'Punjab'),
(60, 25, 'Pondisheri'),
(61, 25, 'Rajasthan'),
(62, 25, 'Tamil Nadu'),
(63, 25, 'Tripura'),
(64, 25, 'Uttar Pradesh'),
(65, 25, 'Haryana'),
(66, 25, 'Chandigarh'),
(67, 26, 'Azarbayjan-e Khavari'),
(68, 26, 'Esfahan'),
(69, 26, 'Hamadan'),
(70, 26, 'Kordestan'),
(71, 26, 'Markazi'),
(72, 26, 'Sistan-e Baluches'),
(73, 26, 'Yazd'),
(74, 26, 'Kerman'),
(75, 26, 'Kermanshakhan'),
(76, 26, 'Mazenderan'),
(77, 26, 'Tehran'),
(78, 26, 'Fars'),
(79, 26, 'Horasan'),
(80, 26, 'Husistan'),
(81, 30, 'Aktyubinskaya obl.'),
(82, 30, 'Alma-Atinskaya obl.'),
(83, 30, 'Vostochno-Kazahstanskaya obl.'),
(84, 30, 'Gurevskaya obl.'),
(85, 30, 'Zhambylskaya obl. (Dzhambulskaya obl.)'),
(86, 30, 'Dzhezkazganskaya obl.'),
(87, 30, 'Karagandinskaya obl.'),
(88, 30, 'Kzyl-Ordinskaya obl.'),
(89, 30, 'Kokchetavskaya obl.'),
(90, 30, 'Kustanaiskaya obl.'),
(91, 30, 'Mangystauskaya (Mangyshlakskaya obl.)'),
(92, 30, 'Pavlodarskaya obl.'),
(93, 30, 'Severo-Kazahstanskaya obl.'),
(94, 30, 'Taldy-Kurganskaya obl.'),
(95, 30, 'Turgaiskaya obl.'),
(96, 30, 'Akmolinskaya obl. (Tselinogradskaya obl.)'),
(97, 30, 'Chimkentskaya obl.'),
(98, 31, 'Littoral'),
(99, 31, 'Southwest Region'),
(100, 31, 'North'),
(101, 31, 'Central'),
(102, 33, 'Government controlled area'),
(103, 33, 'Turkish controlled area'),
(104, 34, 'Issik Kulskaya Region'),
(105, 34, 'Kyrgyzstan'),
(106, 34, 'Narinskaya Region'),
(107, 34, 'Oshskaya Region'),
(108, 34, 'Tallaskaya Region'),
(109, 37, 'al-Jahra'),
(110, 37, 'al-Kuwait'),
(111, 38, 'Latviya'),
(112, 39, 'Tarabulus'),
(113, 39, 'Bengasi'),
(114, 40, 'Litva'),
(115, 43, 'Moldova'),
(116, 45, 'Auckland'),
(117, 45, 'Bay of Plenty'),
(118, 45, 'Canterbury'),
(119, 45, 'Gisborne'),
(120, 45, 'Hawke&#039;s Bay'),
(121, 45, 'Manawatu-Wanganui'),
(122, 45, 'Marlborough'),
(123, 45, 'Nelson'),
(124, 45, 'Northland'),
(125, 45, 'Otago'),
(126, 45, 'Southland'),
(127, 45, 'Taranaki'),
(128, 45, 'Tasman'),
(129, 45, 'Waikato'),
(130, 45, 'Wellington'),
(131, 45, 'West Coast'),
(132, 49, 'Saint-Denis'),
(133, 50, 'Altaiskii krai'),
(134, 50, 'Amurskaya obl.'),
(135, 50, 'Arhangelskaya obl.'),
(136, 50, 'Astrahanskaya obl.'),
(137, 50, 'Bashkiriya obl.'),
(138, 50, 'Belgorodskaya obl.'),
(139, 50, 'Bryanskaya obl.'),
(140, 50, 'Buryatiya'),
(141, 50, 'Vladimirskaya obl.'),
(142, 50, 'Volgogradskaya obl.'),
(143, 50, 'Vologodskaya obl.'),
(144, 50, 'Voronezhskaya obl.'),
(145, 50, 'Nizhegorodskaya obl.'),
(146, 50, 'Dagestan'),
(147, 50, 'Evreiskaya obl.'),
(148, 50, 'Ivanovskaya obl.'),
(149, 50, 'Irkutskaya obl.'),
(150, 50, 'Kabardino-Balkariya'),
(151, 50, 'Kaliningradskaya obl.'),
(152, 50, 'Tverskaya obl.'),
(153, 50, 'Kalmykiya'),
(154, 50, 'Kaluzhskaya obl.'),
(155, 50, 'Kamchatskaya obl.'),
(156, 50, 'Kareliya'),
(157, 50, 'Kemerovskaya obl.'),
(158, 50, 'Kirovskaya obl.'),
(159, 50, 'Komi'),
(160, 50, 'Kostromskaya obl.'),
(161, 50, 'Krasnodarskii krai'),
(162, 50, 'Krasnoyarskii krai'),
(163, 50, 'Kurganskaya obl.'),
(164, 50, 'Kurskaya obl.'),
(165, 50, 'Lipetskaya obl.'),
(166, 50, 'Magadanskaya obl.'),
(167, 50, 'Marii El'),
(168, 50, 'Mordoviya'),
(169, 50, 'Moscow &amp; Moscow Region'),
(170, 50, 'Murmanskaya obl.'),
(171, 50, 'Novgorodskaya obl.'),
(172, 50, 'Novosibirskaya obl.'),
(173, 50, 'Omskaya obl.'),
(174, 50, 'Orenburgskaya obl.'),
(175, 50, 'Orlovskaya obl.'),
(176, 50, 'Penzenskaya obl.'),
(177, 50, 'Permskiy krai'),
(178, 50, 'Primorskii krai'),
(179, 50, 'Pskovskaya obl.'),
(180, 50, 'Rostovskaya obl.'),
(181, 50, 'Ryazanskaya obl.'),
(182, 50, 'Samarskaya obl.'),
(183, 50, 'Saint-Petersburg and Region'),
(184, 50, 'Saratovskaya obl.'),
(185, 50, 'Saha (Yakutiya)'),
(186, 50, 'Sahalin'),
(187, 50, 'Sverdlovskaya obl.'),
(188, 50, 'Severnaya Osetiya'),
(189, 50, 'Smolenskaya obl.'),
(190, 50, 'Stavropolskii krai'),
(191, 50, 'Tambovskaya obl.'),
(192, 50, 'Tatarstan'),
(193, 50, 'Tomskaya obl.'),
(195, 50, 'Tulskaya obl.'),
(196, 50, 'Tyumenskaya obl. i Hanty-Mansiiskii AO'),
(197, 50, 'Udmurtiya'),
(198, 50, 'Ulyanovskaya obl.'),
(199, 50, 'Uralskaya obl.'),
(200, 50, 'Habarovskii krai'),
(201, 50, 'Chelyabinskaya obl.'),
(202, 50, 'Checheno-Ingushetiya'),
(203, 50, 'Chitinskaya obl.'),
(204, 50, 'Chuvashiya'),
(205, 50, 'Yaroslavskaya obl.'),
(206, 51, 'Ahuachapán'),
(207, 51, 'Cuscatlán'),
(208, 51, 'La Libertad'),
(209, 51, 'La Paz'),
(210, 51, 'La Unión'),
(211, 51, 'San Miguel'),
(212, 51, 'San Salvador'),
(213, 51, 'Santa Ana'),
(214, 51, 'Sonsonate'),
(215, 54, 'Paramaribo'),
(216, 56, 'Gorno-Badakhshan Region'),
(217, 56, 'Kuljabsk Region'),
(218, 56, 'Kurgan-Tjube Region'),
(219, 56, 'Sughd Region'),
(220, 56, 'Tajikistan'),
(221, 57, 'Ashgabat Region'),
(222, 57, 'Krasnovodsk Region'),
(223, 57, 'Mary Region'),
(224, 57, 'Tashauz Region'),
(225, 57, 'Chardzhou Region'),
(226, 58, 'Grand Turk'),
(227, 59, 'Bartin'),
(228, 59, 'Bayburt'),
(229, 59, 'Karabuk'),
(230, 59, 'Adana'),
(231, 59, 'Aydin'),
(232, 59, 'Amasya'),
(233, 59, 'Ankara'),
(234, 59, 'Antalya'),
(235, 59, 'Artvin'),
(236, 59, 'Afion'),
(237, 59, 'Balikesir'),
(238, 59, 'Bilecik'),
(239, 59, 'Bursa'),
(240, 59, 'Gaziantep'),
(241, 59, 'Denizli'),
(242, 59, 'Izmir'),
(243, 59, 'Isparta'),
(244, 59, 'Icel'),
(245, 59, 'Kayseri'),
(246, 59, 'Kars'),
(247, 59, 'Kodjaeli'),
(248, 59, 'Konya'),
(249, 59, 'Kirklareli'),
(250, 59, 'Kutahya'),
(251, 59, 'Malatya'),
(252, 59, 'Manisa'),
(253, 59, 'Sakarya'),
(254, 59, 'Samsun'),
(255, 59, 'Sivas'),
(256, 59, 'Istanbul'),
(257, 59, 'Trabzon'),
(258, 59, 'Corum'),
(259, 59, 'Edirne'),
(260, 59, 'Elazig'),
(261, 59, 'Erzincan'),
(262, 59, 'Erzurum'),
(263, 59, 'Eskisehir'),
(264, 60, 'Jinja'),
(265, 60, 'Kampala'),
(266, 61, 'Andijon Region'),
(267, 61, 'Buxoro Region'),
(268, 61, 'Jizzac Region'),
(269, 61, 'Qaraqalpaqstan'),
(270, 61, 'Qashqadaryo Region'),
(271, 61, 'Navoiy Region'),
(272, 61, 'Namangan Region'),
(273, 61, 'Samarqand Region'),
(274, 61, 'Surxondaryo Region'),
(275, 61, 'Sirdaryo Region'),
(276, 61, 'Tashkent Region'),
(277, 61, 'Fergana Region'),
(278, 61, 'Xorazm Region'),
(279, 62, 'Vinnitskaya obl.'),
(280, 62, 'Volynskaya obl.'),
(281, 62, 'Dnepropetrovskaya obl.'),
(282, 62, 'Donetskaya obl.'),
(283, 62, 'Zhitomirskaya obl.'),
(284, 62, 'Zakarpatskaya obl.'),
(285, 62, 'Zaporozhskaya obl.'),
(286, 62, 'Ivano-Frankovskaya obl.'),
(287, 62, 'Kievskaya obl.'),
(288, 62, 'Kirovogradskaya obl.'),
(289, 62, 'Krymskaya obl.'),
(290, 62, 'Luganskaya obl.'),
(291, 62, 'Lvovskaya obl.'),
(292, 62, 'Nikolaevskaya obl.'),
(293, 62, 'Odesskaya obl.'),
(294, 62, 'Poltavskaya obl.'),
(295, 62, 'Rovenskaya obl.'),
(296, 62, 'Sumskaya obl.'),
(297, 62, 'Ternopolskaya obl.'),
(298, 62, 'Harkovskaya obl.'),
(299, 62, 'Hersonskaya obl.'),
(300, 62, 'Hmelnitskaya obl.'),
(301, 62, 'Cherkasskaya obl.'),
(302, 62, 'Chernigovskaya obl.'),
(303, 62, 'Chernovitskaya obl.'),
(304, 68, 'Estoniya'),
(305, 69, 'Cheju'),
(306, 69, 'Chollabuk'),
(307, 69, 'Chollanam'),
(308, 69, 'Chungcheongbuk'),
(309, 69, 'Chungcheongnam'),
(310, 69, 'Incheon'),
(311, 69, 'Kangweon'),
(312, 69, 'Kwangju'),
(313, 69, 'Kyeonggi'),
(314, 69, 'Kyeongsangbuk'),
(315, 69, 'Kyeongsangnam'),
(316, 69, 'Pusan'),
(317, 69, 'Seoul'),
(318, 69, 'Taegu'),
(319, 69, 'Taejeon'),
(320, 69, 'Ulsan'),
(321, 70, 'Aichi'),
(322, 70, 'Akita'),
(323, 70, 'Aomori'),
(324, 70, 'Wakayama'),
(325, 70, 'Gifu'),
(326, 70, 'Gunma'),
(327, 70, 'Ibaraki'),
(328, 70, 'Iwate'),
(329, 70, 'Ishikawa'),
(330, 70, 'Kagawa'),
(331, 70, 'Kagoshima'),
(332, 70, 'Kanagawa'),
(333, 70, 'Kyoto'),
(334, 70, 'Kochi'),
(335, 70, 'Kumamoto'),
(336, 70, 'Mie'),
(337, 70, 'Miyagi'),
(338, 70, 'Miyazaki'),
(339, 70, 'Nagano'),
(340, 70, 'Nagasaki'),
(341, 70, 'Nara'),
(342, 70, 'Niigata'),
(343, 70, 'Okayama'),
(344, 70, 'Okinawa'),
(345, 70, 'Osaka'),
(346, 70, 'Saga'),
(347, 70, 'Saitama'),
(348, 70, 'Shiga'),
(349, 70, 'Shizuoka'),
(350, 70, 'Shimane'),
(351, 70, 'Tiba'),
(352, 70, 'Tokyo'),
(353, 70, 'Tokushima'),
(354, 70, 'Tochigi'),
(355, 70, 'Tottori'),
(356, 70, 'Toyama'),
(357, 70, 'Fukui'),
(358, 70, 'Fukuoka'),
(359, 70, 'Fukushima'),
(360, 70, 'Hiroshima'),
(361, 70, 'Hokkaido'),
(362, 70, 'Hyogo'),
(363, 70, 'Yoshimi'),
(364, 70, 'Yamagata'),
(365, 70, 'Yamaguchi'),
(366, 70, 'Yamanashi'),
(368, 73, 'Hong Kong'),
(369, 74, 'Indonesia'),
(370, 75, 'Jordan'),
(371, 76, 'Malaysia'),
(372, 77, 'Singapore'),
(373, 78, 'Taiwan'),
(374, 30, 'Kazahstan'),
(375, 62, 'Ukraina'),
(376, 25, 'India'),
(377, 23, 'Egypt'),
(378, 106, 'Damascus'),
(379, 131, 'Isle of Man'),
(380, 30, 'Zapadno-Kazahstanskaya obl.'),
(381, 50, 'Adygeya'),
(382, 50, 'Hakasiya'),
(383, 93, 'Dubai'),
(384, 50, 'Chukotskii AO'),
(385, 99, 'Beirut'),
(386, 137, 'Tegucigalpa'),
(387, 138, 'Santo Domingo'),
(388, 139, 'Ulan Bator'),
(389, 23, 'Sinai'),
(390, 140, 'Baghdad'),
(391, 140, 'Basra'),
(392, 140, 'Mosul'),
(393, 141, 'Johannesburg'),
(394, 104, 'Morocco'),
(395, 104, 'Tangier'),
(396, 50, 'Yamalo-Nenetskii AO'),
(397, 122, 'Tunisia'),
(398, 92, 'Thailand'),
(399, 117, 'Mozambique'),
(400, 84, 'Korea'),
(401, 87, 'Pakistan'),
(402, 142, 'Aruba'),
(403, 80, 'Bahamas'),
(404, 69, 'South Korea'),
(405, 132, 'Jamaica'),
(406, 93, 'Sharjah'),
(407, 93, 'Abu Dhabi'),
(409, 24, 'Ramat Hagolan'),
(410, 115, 'Nigeria'),
(411, 64, 'Ain'),
(412, 64, 'Haute-Savoie'),
(413, 64, 'Aisne'),
(414, 64, 'Allier'),
(415, 64, 'Alpes-de-Haute-Provence'),
(416, 64, 'Hautes-Alpes'),
(417, 64, 'Alpes-Maritimes'),
(418, 64, 'Ard&egrave;che'),
(419, 64, 'Ardennes'),
(420, 64, 'Ari&egrave;ge'),
(421, 64, 'Aube'),
(422, 64, 'Aude'),
(423, 64, 'Aveyron'),
(424, 64, 'Bouches-du-Rh&ocirc;ne'),
(425, 64, 'Calvados'),
(426, 64, 'Cantal'),
(427, 64, 'Charente'),
(428, 64, 'Charente Maritime'),
(429, 64, 'Cher'),
(430, 64, 'Corr&egrave;ze'),
(431, 64, 'Dordogne'),
(432, 64, 'Corse'),
(433, 64, 'C&ocirc;te d&#039;Or'),
(434, 64, 'Sa&ocirc;ne et Loire'),
(435, 64, 'C&ocirc;tes d&#039;Armor'),
(436, 64, 'Creuse'),
(437, 64, 'Doubs'),
(438, 64, 'Dr&ocirc;me'),
(439, 64, 'Eure'),
(440, 64, 'Eure-et-Loire'),
(441, 64, 'Finist&egrave;re'),
(442, 64, 'Gard'),
(443, 64, 'Haute-Garonne'),
(444, 64, 'Gers'),
(445, 64, 'Gironde'),
(446, 64, 'Hérault'),
(447, 64, 'Ille et Vilaine'),
(448, 64, 'Indre'),
(449, 64, 'Indre-et-Loire'),
(450, 64, 'Isère'),
(451, 64, 'Jura'),
(452, 64, 'Landes'),
(453, 64, 'Loir-et-Cher'),
(454, 64, 'Loire'),
(455, 64, 'Rh&ocirc;ne'),
(456, 64, 'Haute-Loire'),
(457, 64, 'Loire Atlantique'),
(458, 64, 'Loiret'),
(459, 64, 'Lot'),
(460, 64, 'Lot-et-Garonne'),
(461, 64, 'Loz&egrave;re'),
(462, 64, 'Maine et Loire'),
(463, 64, 'Manche'),
(464, 64, 'Marne'),
(465, 64, 'Haute-Marne'),
(466, 64, 'Mayenne'),
(467, 64, 'Meurthe-et-Moselle'),
(468, 64, 'Meuse'),
(469, 64, 'Morbihan'),
(470, 64, 'Moselle'),
(471, 64, 'Ni&egrave;vre'),
(472, 64, 'Nord'),
(473, 64, 'Oise'),
(474, 64, 'Orne'),
(475, 64, 'Pas-de-Calais'),
(476, 64, 'Puy-de-D&ocirc;me'),
(477, 64, 'Pyrénées-Atlantiques'),
(478, 64, 'Hautes-Pyrénées'),
(479, 64, 'Pyrénées-Orientales'),
(480, 64, 'Bas Rhin'),
(481, 64, 'Haut Rhin'),
(482, 64, 'Haute-Sa&ocirc;ne'),
(483, 64, 'Sarthe'),
(484, 64, 'Savoie'),
(485, 64, 'Paris'),
(486, 64, 'Seine-Maritime'),
(487, 64, 'Seine-et-Marne'),
(488, 64, 'Yvelines'),
(489, 64, 'Deux-S&egrave;vres'),
(490, 64, 'Somme'),
(491, 64, 'Tarn'),
(492, 64, 'Tarn-et-Garonne'),
(493, 64, 'Var'),
(494, 64, 'Vaucluse'),
(495, 64, 'Vendée'),
(496, 64, 'Vienne'),
(497, 64, 'Haute-Vienne'),
(498, 64, 'Vosges'),
(499, 64, 'Yonne'),
(500, 64, 'Territoire de Belfort'),
(501, 64, 'Essonne'),
(502, 64, 'Hauts-de-Seine'),
(503, 64, 'Seine-Saint-Denis'),
(504, 64, 'Val-de-Marne'),
(505, 64, 'Val-d&#039;Oise'),
(506, 29, 'Piemonte - Torino'),
(507, 29, 'Piemonte - Alessandria'),
(508, 29, 'Piemonte - Asti'),
(509, 29, 'Piemonte - Biella'),
(510, 29, 'Piemonte - Cuneo'),
(511, 29, 'Piemonte - Novara'),
(512, 29, 'Piemonte - Verbania'),
(513, 29, 'Piemonte - Vercelli'),
(514, 29, 'Valle d&#039;Aosta - Aosta'),
(515, 29, 'Lombardia - Milano'),
(516, 29, 'Lombardia - Bergamo'),
(517, 29, 'Lombardia - Brescia'),
(518, 29, 'Lombardia - Como'),
(519, 29, 'Lombardia - Cremona'),
(520, 29, 'Lombardia - Lecco'),
(521, 29, 'Lombardia - Lodi'),
(522, 29, 'Lombardia - Mantova'),
(523, 29, 'Lombardia - Pavia'),
(524, 29, 'Lombardia - Sondrio'),
(525, 29, 'Lombardia - Varese'),
(526, 29, 'Trentino Alto Adige - Trento'),
(527, 29, 'Trentino Alto Adige - Bolzano'),
(528, 29, 'Veneto - Venezia'),
(529, 29, 'Veneto - Belluno'),
(530, 29, 'Veneto - Padova'),
(531, 29, 'Veneto - Rovigo'),
(532, 29, 'Veneto - Treviso'),
(533, 29, 'Veneto - Verona'),
(534, 29, 'Veneto - Vicenza'),
(535, 29, 'Friuli Venezia Giulia - Trieste'),
(536, 29, 'Friuli Venezia Giulia - Gorizia'),
(537, 29, 'Friuli Venezia Giulia - Pordenone'),
(538, 29, 'Friuli Venezia Giulia - Udine'),
(539, 29, 'Liguria - Genova'),
(540, 29, 'Liguria - Imperia'),
(541, 29, 'Liguria - La Spezia'),
(542, 29, 'Liguria - Savona'),
(543, 29, 'Emilia Romagna - Bologna'),
(544, 29, 'Emilia Romagna - Ferrara'),
(545, 29, 'Emilia Romagna - Forlì-Cesena'),
(546, 29, 'Emilia Romagna - Modena'),
(547, 29, 'Emilia Romagna - Parma'),
(548, 29, 'Emilia Romagna - Piacenza'),
(549, 29, 'Emilia Romagna - Ravenna'),
(550, 29, 'Emilia Romagna - Reggio Emilia'),
(551, 29, 'Emilia Romagna - Rimini'),
(552, 29, 'Toscana - Firenze'),
(553, 29, 'Toscana - Arezzo'),
(554, 29, 'Toscana - Grosseto'),
(555, 29, 'Toscana - Livorno'),
(556, 29, 'Toscana - Lucca'),
(557, 29, 'Toscana - Massa Carrara'),
(558, 29, 'Toscana - Pisa'),
(559, 29, 'Toscana - Pistoia'),
(560, 29, 'Toscana - Prato'),
(561, 29, 'Toscana - Siena'),
(562, 29, 'Umbria - Perugia'),
(563, 29, 'Umbria - Terni'),
(564, 29, 'Marche - Ancona'),
(565, 29, 'Marche - Ascoli Piceno'),
(566, 29, 'Marche - Macerata'),
(567, 29, 'Marche - Pesaro - Urbino'),
(568, 29, 'Lazio - Roma'),
(569, 29, 'Lazio - Frosinone'),
(570, 29, 'Lazio - Latina'),
(571, 29, 'Lazio - Rieti'),
(572, 29, 'Lazio - Viterbo'),
(573, 29, 'Abruzzo - L´Aquila'),
(574, 29, 'Abruzzo - Chieti'),
(575, 29, 'Abruzzo - Pescara'),
(576, 29, 'Abruzzo - Teramo'),
(577, 29, 'Molise - Campobasso'),
(578, 29, 'Molise - Isernia'),
(579, 29, 'Campania - Napoli'),
(580, 29, 'Campania - Avellino'),
(581, 29, 'Campania - Benevento'),
(582, 29, 'Campania - Caserta'),
(583, 29, 'Campania - Salerno'),
(584, 29, 'Puglia - Bari'),
(585, 29, 'Puglia - Brindisi'),
(586, 29, 'Puglia - Foggia'),
(587, 29, 'Puglia - Lecce'),
(588, 29, 'Puglia - Taranto'),
(589, 29, 'Basilicata - Potenza'),
(590, 29, 'Basilicata - Matera'),
(591, 29, 'Calabria - Catanzaro'),
(592, 29, 'Calabria - Cosenza'),
(593, 29, 'Calabria - Crotone'),
(594, 29, 'Calabria - Reggio Calabria'),
(595, 29, 'Calabria - Vibo Valentia'),
(596, 29, 'Sicilia - Palermo'),
(597, 29, 'Sicilia - Agrigento'),
(598, 29, 'Sicilia - Caltanissetta'),
(599, 29, 'Sicilia - Catania'),
(600, 29, 'Sicilia - Enna'),
(601, 29, 'Sicilia - Messina'),
(602, 29, 'Sicilia - Ragusa'),
(603, 29, 'Sicilia - Siracusa'),
(604, 29, 'Sicilia - Trapani'),
(605, 29, 'Sardegna - Cagliari'),
(606, 29, 'Sardegna - Nuoro'),
(607, 29, 'Sardegna - Oristano'),
(608, 29, 'Sardegna - Sassari'),
(609, 28, 'Las Palmas'),
(610, 28, 'Soria'),
(611, 28, 'Palencia'),
(612, 28, 'Zamora'),
(613, 28, 'Cádiz'),
(614, 28, 'Navarra'),
(615, 28, 'Ourense'),
(616, 28, 'Segovia'),
(617, 28, 'Guip&uacute;zcoa'),
(618, 28, 'Ciudad Real'),
(619, 28, 'Vizcaya'),
(620, 28, 'álava'),
(621, 28, 'A Coruña'),
(622, 28, 'Cantabria'),
(623, 28, 'Almería'),
(624, 28, 'Zaragoza'),
(625, 28, 'Santa Cruz de Tenerife'),
(626, 28, 'Cáceres'),
(627, 28, 'Guadalajara'),
(628, 28, 'ávila'),
(629, 28, 'Toledo'),
(630, 28, 'Castellón'),
(631, 28, 'Tarragona'),
(632, 28, 'Lugo'),
(633, 28, 'La Rioja'),
(634, 28, 'Ceuta'),
(635, 28, 'Murcia'),
(636, 28, 'Salamanca'),
(637, 28, 'Valladolid'),
(638, 28, 'Jaén'),
(639, 28, 'Girona'),
(640, 28, 'Granada'),
(641, 28, 'Alacant'),
(642, 28, 'Córdoba'),
(643, 28, 'Albacete'),
(644, 28, 'Cuenca'),
(645, 28, 'Pontevedra'),
(646, 28, 'Teruel'),
(647, 28, 'Melilla'),
(648, 28, 'Barcelona'),
(649, 28, 'Badajoz'),
(650, 28, 'Madrid'),
(651, 28, 'Sevilla'),
(652, 28, 'Val&egrave;ncia'),
(653, 28, 'Huelva'),
(654, 28, 'Lleida'),
(655, 28, 'León'),
(656, 28, 'Illes Balears'),
(657, 28, 'Burgos'),
(658, 28, 'Huesca'),
(659, 28, 'Asturias'),
(660, 28, 'Málaga'),
(661, 144, 'Afghanistan'),
(662, 210, 'Niger'),
(663, 133, 'Mali'),
(664, 156, 'Burkina Faso'),
(665, 136, 'Togo'),
(666, 151, 'Benin'),
(667, 119, 'Angola'),
(668, 102, 'Namibia'),
(669, 100, 'Botswana'),
(670, 134, 'Madagascar'),
(671, 202, 'Mauritius'),
(672, 196, 'Laos'),
(673, 158, 'Cambodia'),
(674, 90, 'Philippines'),
(675, 88, 'Papua New Guinea'),
(676, 228, 'Solomon Islands'),
(677, 240, 'Vanuatu'),
(678, 176, 'Fiji'),
(679, 223, 'Samoa'),
(680, 206, 'Nauru'),
(681, 168, 'Cote D&#039;Ivoire'),
(682, 198, 'Liberia'),
(683, 187, 'Guinea'),
(684, 189, 'Guyana'),
(685, 98, 'Algeria'),
(686, 147, 'Antigua and Barbuda'),
(687, 127, 'Bahrain'),
(688, 149, 'Bangladesh'),
(689, 128, 'Barbados'),
(690, 152, 'Bhutan'),
(691, 155, 'Brunei'),
(692, 157, 'Burundi'),
(693, 159, 'Cape Verde'),
(694, 130, 'Chad'),
(695, 164, 'Comoros'),
(696, 112, 'Congo (Brazzaville)'),
(697, 169, 'Djibouti'),
(698, 171, 'East Timor'),
(699, 173, 'Eritrea'),
(700, 121, 'Ethiopia'),
(701, 180, 'Gabon'),
(702, 181, 'Gambia'),
(703, 105, 'Ghana'),
(704, 197, 'Lesotho'),
(705, 125, 'Malawi'),
(706, 200, 'Maldives'),
(707, 205, 'Myanmar (Burma)'),
(708, 107, 'Nepal'),
(709, 213, 'Oman'),
(710, 217, 'Rwanda'),
(711, 91, 'Saudi Arabia'),
(712, 120, 'Sri Lanka'),
(713, 232, 'Sudan'),
(714, 234, 'Swaziland'),
(715, 101, 'Tanzania'),
(716, 236, 'Tonga'),
(717, 239, 'Tuvalu'),
(718, 242, 'Western Sahara'),
(719, 243, 'Yemen'),
(720, 116, 'Zambia'),
(721, 96, 'Zimbabwe'),
(722, 66, 'Aargau'),
(723, 66, 'Appenzell Innerrhoden'),
(724, 66, 'Appenzell Ausserrhoden'),
(725, 66, 'Bern'),
(726, 66, 'Basel-Landschaft'),
(727, 66, 'Basel-Stadt'),
(728, 66, 'Fribourg'),
(729, 66, 'Gen&egrave;ve'),
(730, 66, 'Glarus'),
(731, 66, 'Graubünden'),
(732, 66, 'Jura'),
(733, 66, 'Luzern'),
(734, 66, 'Neuch&acirc;tel'),
(735, 66, 'Nidwalden'),
(736, 66, 'Obwalden'),
(737, 66, 'Sankt Gallen'),
(738, 66, 'Schaffhausen'),
(739, 66, 'Solothurn'),
(740, 66, 'Schwyz'),
(741, 66, 'Thurgau'),
(742, 66, 'Ticino'),
(743, 66, 'Uri'),
(744, 66, 'Vaud'),
(745, 66, 'Valais'),
(746, 66, 'Zug'),
(747, 66, 'Zürich'),
(749, 48, 'Aveiro'),
(750, 48, 'Beja'),
(751, 48, 'Braga'),
(752, 48, 'Braganca'),
(753, 48, 'Castelo Branco'),
(754, 48, 'Coimbra'),
(755, 48, 'Evora'),
(756, 48, 'Faro'),
(757, 48, 'Madeira'),
(758, 48, 'Guarda'),
(759, 48, 'Leiria'),
(760, 48, 'Lisboa'),
(761, 48, 'Portalegre'),
(762, 48, 'Porto'),
(763, 48, 'Santarem'),
(764, 48, 'Setubal'),
(765, 48, 'Viana do Castelo'),
(766, 48, 'Vila Real'),
(767, 48, 'Viseu'),
(768, 48, 'Azores'),
(769, 55, 'Armed Forces Americas'),
(770, 55, 'Armed Forces Europe'),
(771, 55, 'Alaska'),
(772, 55, 'Alabama'),
(773, 55, 'Armed Forces Pacific'),
(774, 55, 'Arkansas'),
(775, 55, 'American Samoa'),
(776, 55, 'Arizona'),
(777, 55, 'California'),
(778, 55, 'Colorado'),
(779, 55, 'Connecticut'),
(780, 55, 'District of Columbia'),
(781, 55, 'Delaware'),
(782, 55, 'Florida'),
(783, 55, 'Federated States of Micronesia'),
(784, 55, 'Georgia'),
(786, 55, 'Hawaii'),
(787, 55, 'Iowa'),
(788, 55, 'Idaho'),
(789, 55, 'Illinois'),
(790, 55, 'Indiana'),
(791, 55, 'Kansas'),
(792, 55, 'Kentucky'),
(793, 55, 'Louisiana'),
(794, 55, 'Massachusetts'),
(795, 55, 'Maryland'),
(796, 55, 'Maine'),
(797, 55, 'Marshall Islands'),
(798, 55, 'Michigan'),
(799, 55, 'Minnesota'),
(800, 55, 'Missouri'),
(801, 55, 'Northern Mariana Islands'),
(802, 55, 'Mississippi'),
(803, 55, 'Montana'),
(804, 55, 'North Carolina'),
(805, 55, 'North Dakota'),
(806, 55, 'Nebraska'),
(807, 55, 'New Hampshire'),
(808, 55, 'New Jersey'),
(809, 55, 'New Mexico'),
(810, 55, 'Nevada'),
(811, 55, 'New York'),
(812, 55, 'Ohio'),
(813, 55, 'Oklahoma'),
(814, 55, 'Oregon'),
(815, 55, 'Pennsylvania'),
(816, 246, 'Puerto Rico'),
(817, 55, 'Palau'),
(818, 55, 'Rhode Island'),
(819, 55, 'South Carolina'),
(820, 55, 'South Dakota'),
(821, 55, 'Tennessee'),
(822, 55, 'Texas'),
(823, 55, 'Utah'),
(824, 55, 'Virginia'),
(825, 55, 'Virgin Islands'),
(826, 55, 'Vermont'),
(827, 55, 'Washington'),
(828, 55, 'West Virginia'),
(829, 55, 'Wisconsin'),
(830, 55, 'Wyoming'),
(831, 94, 'Greenland'),
(832, 18, 'Brandenburg'),
(833, 18, 'Baden-Württemberg'),
(834, 18, 'Bayern'),
(835, 18, 'Hessen'),
(836, 18, 'Hamburg'),
(837, 18, 'Mecklenburg-Vorpommern'),
(838, 18, 'Niedersachsen'),
(839, 18, 'Nordrhein-Westfalen'),
(840, 18, 'Rheinland-Pfalz'),
(841, 18, 'Schleswig-Holstein'),
(842, 18, 'Sachsen'),
(843, 18, 'Sachsen-Anhalt'),
(844, 18, 'Thüringen'),
(845, 18, 'Berlin'),
(846, 18, 'Bremen'),
(847, 18, 'Saarland'),
(848, 13, 'Scotland North'),
(849, 13, 'England - East'),
(850, 13, 'England - West Midlands'),
(851, 13, 'England - South West'),
(852, 13, 'England - North West'),
(853, 13, 'England - Yorks &amp; Humber'),
(854, 13, 'England - South East'),
(855, 13, 'England - London'),
(856, 13, 'Northern Ireland'),
(857, 13, 'England - North East'),
(858, 13, 'Wales South'),
(859, 13, 'Wales North'),
(860, 13, 'England - East Midlands'),
(861, 13, 'Scotland Central'),
(862, 13, 'Scotland South'),
(863, 13, 'Channel Islands'),
(864, 13, 'Isle of Man'),
(865, 2, 'Burgenland'),
(866, 2, 'Kärnten'),
(867, 2, 'Niederösterreich'),
(868, 2, 'Oberösterreich'),
(869, 2, 'Salzburg'),
(870, 2, 'Steiermark'),
(871, 2, 'Tirol'),
(872, 2, 'Vorarlberg'),
(873, 2, 'Wien'),
(874, 9, 'Bruxelles'),
(875, 9, 'West-Vlaanderen'),
(876, 9, 'Oost-Vlaanderen'),
(877, 9, 'Limburg'),
(878, 9, 'Vlaams Brabant'),
(879, 9, 'Antwerpen'),
(880, 9, 'LiÄge'),
(881, 9, 'Namur'),
(882, 9, 'Hainaut'),
(883, 9, 'Luxembourg'),
(884, 9, 'Brabant Wallon'),
(887, 67, 'Blekinge Lan'),
(888, 67, 'Gavleborgs Lan'),
(890, 67, 'Gotlands Lan'),
(891, 67, 'Hallands Lan'),
(892, 67, 'Jamtlands Lan'),
(893, 67, 'Jonkopings Lan'),
(894, 67, 'Kalmar Lan'),
(895, 67, 'Dalarnas Lan'),
(897, 67, 'Kronobergs Lan'),
(899, 67, 'Norrbottens Lan'),
(900, 67, 'Orebro Lan'),
(901, 67, 'Ostergotlands Lan'),
(903, 67, 'Sodermanlands Lan'),
(904, 67, 'Uppsala Lan'),
(905, 67, 'Varmlands Lan'),
(906, 67, 'Vasterbottens Lan'),
(907, 67, 'Vasternorrlands Lan'),
(908, 67, 'Vastmanlands Lan'),
(909, 67, 'Stockholms Lan'),
(910, 67, 'Skane Lan'),
(911, 67, 'Vastra Gotaland'),
(913, 46, 'Akershus'),
(914, 46, 'Aust-Agder'),
(915, 46, 'Buskerud'),
(916, 46, 'Finnmark'),
(917, 46, 'Hedmark'),
(918, 46, 'Hordaland'),
(919, 46, 'More og Romsdal'),
(920, 46, 'Nordland'),
(921, 46, 'Nord-Trondelag'),
(922, 46, 'Oppland'),
(923, 46, 'Oslo'),
(924, 46, 'Ostfold'),
(925, 46, 'Rogaland'),
(926, 46, 'Sogn og Fjordane'),
(927, 46, 'Sor-Trondelag'),
(928, 46, 'Telemark'),
(929, 46, 'Troms'),
(930, 46, 'Vest-Agder'),
(931, 46, 'Vestfold'),
(933, 63, '&ETH;&bull;land'),
(934, 63, 'Lapland'),
(935, 63, 'Oulu'),
(936, 63, 'Southern Finland'),
(937, 63, 'Eastern Finland'),
(938, 63, 'Western Finland'),
(940, 22, 'Arhus'),
(941, 22, 'Bornholm'),
(942, 22, 'Frederiksborg'),
(943, 22, 'Fyn'),
(944, 22, 'Kobenhavn'),
(945, 22, 'Staden Kobenhavn'),
(946, 22, 'Nordjylland'),
(947, 22, 'Ribe'),
(948, 22, 'Ringkobing'),
(949, 22, 'Roskilde'),
(950, 22, 'Sonderjylland'),
(951, 22, 'Storstrom'),
(952, 22, 'Vejle'),
(953, 22, 'Vestsjalland'),
(954, 22, 'Viborg'),
(956, 65, 'Hlavni Mesto Praha'),
(957, 65, 'Jihomoravsky Kraj'),
(958, 65, 'Jihocesky Kraj'),
(959, 65, 'Vysocina'),
(960, 65, 'Karlovarsky Kraj'),
(961, 65, 'Kralovehradecky Kraj'),
(962, 65, 'Liberecky Kraj'),
(963, 65, 'Olomoucky Kraj'),
(964, 65, 'Moravskoslezsky Kraj'),
(965, 65, 'Pardubicky Kraj'),
(966, 65, 'Plzensky Kraj'),
(967, 65, 'Stredocesky Kraj'),
(968, 65, 'Ustecky Kraj'),
(969, 65, 'Zlinsky Kraj'),
(971, 114, 'Berat'),
(972, 114, 'Diber'),
(973, 114, 'Durres'),
(974, 114, 'Elbasan'),
(975, 114, 'Fier'),
(976, 114, 'Gjirokaster'),
(977, 114, 'Korce'),
(978, 114, 'Kukes'),
(979, 114, 'Lezhe'),
(980, 114, 'Shkoder'),
(981, 114, 'Tirane'),
(982, 114, 'Vlore'),
(984, 145, 'Canillo'),
(985, 145, 'Encamp'),
(986, 145, 'La Massana'),
(987, 145, 'Ordino'),
(988, 145, 'Sant Julia de Loria'),
(989, 145, 'Andorra la Vella'),
(990, 145, 'Escaldes-Engordany'),
(992, 6, 'Aragatsotn'),
(993, 6, 'Ararat'),
(994, 6, 'Armavir'),
(995, 6, 'Geghark&#039;unik&#039;'),
(996, 6, 'Kotayk&#039;'),
(997, 6, 'Lorri'),
(998, 6, 'Shirak'),
(999, 6, 'Syunik&#039;'),
(1000, 6, 'Tavush'),
(1001, 6, 'Vayots&#039; Dzor'),
(1002, 6, 'Yerevan'),
(1004, 79, 'Federation of Bosnia and Herzegovina'),
(1005, 79, 'Republika Srpska'),
(1007, 11, 'Mikhaylovgrad'),
(1008, 11, 'Blagoevgrad'),
(1009, 11, 'Burgas'),
(1010, 11, 'Dobrich'),
(1011, 11, 'Gabrovo'),
(1012, 11, 'Grad Sofiya'),
(1013, 11, 'Khaskovo'),
(1014, 11, 'Kurdzhali'),
(1015, 11, 'Kyustendil'),
(1016, 11, 'Lovech'),
(1017, 11, 'Montana'),
(1018, 11, 'Pazardzhik'),
(1019, 11, 'Pernik'),
(1020, 11, 'Pleven'),
(1021, 11, 'Plovdiv'),
(1022, 11, 'Razgrad'),
(1023, 11, 'Ruse'),
(1024, 11, 'Shumen'),
(1025, 11, 'Silistra'),
(1026, 11, 'Sliven'),
(1027, 11, 'Smolyan'),
(1028, 11, 'Sofiya'),
(1029, 11, 'Stara Zagora'),
(1030, 11, 'Turgovishte'),
(1031, 11, 'Varna'),
(1032, 11, 'Veliko Turnovo'),
(1033, 11, 'Vidin'),
(1034, 11, 'Vratsa'),
(1035, 11, 'Yambol'),
(1037, 71, 'Bjelovarsko-Bilogorska'),
(1038, 71, 'Brodsko-Posavska'),
(1039, 71, 'Dubrovacko-Neretvanska'),
(1040, 71, 'Istarska'),
(1041, 71, 'Karlovacka'),
(1042, 71, 'Koprivnicko-Krizevacka'),
(1043, 71, 'Krapinsko-Zagorska'),
(1044, 71, 'Licko-Senjska'),
(1045, 71, 'Medimurska'),
(1046, 71, 'Osjecko-Baranjska'),
(1047, 71, 'Pozesko-Slavonska'),
(1048, 71, 'Primorsko-Goranska'),
(1049, 71, 'Sibensko-Kninska'),
(1050, 71, 'Sisacko-Moslavacka'),
(1051, 71, 'Splitsko-Dalmatinska'),
(1052, 71, 'Varazdinska'),
(1053, 71, 'Viroviticko-Podravska'),
(1054, 71, 'Vukovarsko-Srijemska'),
(1055, 71, 'Zadarska'),
(1056, 71, 'Zagrebacka'),
(1057, 71, 'Grad Zagreb'),
(1059, 143, 'Gibraltar'),
(1060, 20, 'Evros'),
(1061, 20, 'Rodhopi'),
(1062, 20, 'Xanthi'),
(1063, 20, 'Drama'),
(1064, 20, 'Serrai'),
(1065, 20, 'Kilkis'),
(1066, 20, 'Pella'),
(1067, 20, 'Florina'),
(1068, 20, 'Kastoria'),
(1069, 20, 'Grevena'),
(1070, 20, 'Kozani'),
(1071, 20, 'Imathia'),
(1072, 20, 'Thessaloniki'),
(1073, 20, 'Kavala'),
(1074, 20, 'Khalkidhiki'),
(1075, 20, 'Pieria'),
(1076, 20, 'Ioannina'),
(1077, 20, 'Thesprotia'),
(1078, 20, 'Preveza'),
(1079, 20, 'Arta'),
(1080, 20, 'Larisa'),
(1081, 20, 'Trikala'),
(1082, 20, 'Kardhitsa'),
(1083, 20, 'Magnisia'),
(1084, 20, 'Kerkira'),
(1085, 20, 'Levkas'),
(1086, 20, 'Kefallinia'),
(1087, 20, 'Zakinthos'),
(1088, 20, 'Fthiotis'),
(1089, 20, 'Evritania'),
(1090, 20, 'Aitolia kai Akarnania'),
(1091, 20, 'Fokis'),
(1092, 20, 'Voiotia'),
(1093, 20, 'Evvoia'),
(1094, 20, 'Attiki'),
(1095, 20, 'Argolis'),
(1096, 20, 'Korinthia'),
(1097, 20, 'Akhaia'),
(1098, 20, 'Ilia'),
(1099, 20, 'Messinia'),
(1100, 20, 'Arkadhia'),
(1101, 20, 'Lakonia'),
(1102, 20, 'Khania'),
(1103, 20, 'Rethimni'),
(1104, 20, 'Iraklion'),
(1105, 20, 'Lasithi'),
(1106, 20, 'Dhodhekanisos'),
(1107, 20, 'Samos'),
(1108, 20, 'Kikladhes'),
(1109, 20, 'Khios'),
(1110, 20, 'Lesvos'),
(1112, 14, 'Bacs-Kiskun'),
(1113, 14, 'Baranya'),
(1114, 14, 'Bekes'),
(1115, 14, 'Borsod-Abauj-Zemplen'),
(1116, 14, 'Budapest'),
(1117, 14, 'Csongrad'),
(1118, 14, 'Debrecen'),
(1119, 14, 'Fejer'),
(1120, 14, 'Gyor-Moson-Sopron'),
(1121, 14, 'Hajdu-Bihar'),
(1122, 14, 'Heves'),
(1123, 14, 'Komarom-Esztergom'),
(1124, 14, 'Miskolc'),
(1125, 14, 'Nograd'),
(1126, 14, 'Pecs'),
(1127, 14, 'Pest'),
(1128, 14, 'Somogy'),
(1129, 14, 'Szabolcs-Szatmar-Bereg'),
(1130, 14, 'Szeged'),
(1131, 14, 'Jasz-Nagykun-Szolnok'),
(1132, 14, 'Tolna'),
(1133, 14, 'Vas'),
(1134, 14, 'Veszprem'),
(1135, 14, 'Zala'),
(1136, 14, 'Gyor'),
(1150, 14, 'Veszprem'),
(1152, 126, 'Balzers'),
(1153, 126, 'Eschen'),
(1154, 126, 'Gamprin'),
(1155, 126, 'Mauren'),
(1156, 126, 'Planken'),
(1157, 126, 'Ruggell'),
(1158, 126, 'Schaan'),
(1159, 126, 'Schellenberg'),
(1160, 126, 'Triesen'),
(1161, 126, 'Triesenberg'),
(1162, 126, 'Vaduz'),
(1163, 41, 'Diekirch'),
(1164, 41, 'Grevenmacher'),
(1165, 41, 'Luxembourg'),
(1167, 85, 'Aracinovo'),
(1168, 85, 'Bac'),
(1169, 85, 'Belcista'),
(1170, 85, 'Berovo'),
(1171, 85, 'Bistrica'),
(1172, 85, 'Bitola'),
(1173, 85, 'Blatec'),
(1174, 85, 'Bogdanci'),
(1175, 85, 'Bogomila'),
(1176, 85, 'Bogovinje'),
(1177, 85, 'Bosilovo'),
(1179, 85, 'Cair'),
(1180, 85, 'Capari'),
(1181, 85, 'Caska'),
(1182, 85, 'Cegrane'),
(1184, 85, 'Centar Zupa'),
(1187, 85, 'Debar'),
(1188, 85, 'Delcevo'),
(1190, 85, 'Demir Hisar'),
(1191, 85, 'Demir Kapija'),
(1195, 85, 'Dorce Petrov'),
(1198, 85, 'Gazi Baba'),
(1199, 85, 'Gevgelija'),
(1200, 85, 'Gostivar'),
(1201, 85, 'Gradsko'),
(1204, 85, 'Jegunovce'),
(1205, 85, 'Kamenjane'),
(1207, 85, 'Karpos'),
(1208, 85, 'Kavadarci'),
(1209, 85, 'Kicevo'),
(1210, 85, 'Kisela Voda'),
(1211, 85, 'Klecevce'),
(1212, 85, 'Kocani'),
(1214, 85, 'Kondovo'),
(1217, 85, 'Kratovo'),
(1219, 85, 'Krivogastani'),
(1220, 85, 'Krusevo'),
(1223, 85, 'Kumanovo'),
(1224, 85, 'Labunista'),
(1225, 85, 'Lipkovo'),
(1228, 85, 'Makedonska Kamenica'),
(1229, 85, 'Makedonski Brod'),
(1234, 85, 'Murtino'),
(1235, 85, 'Negotino'),
(1238, 85, 'Novo Selo'),
(1240, 85, 'Ohrid'),
(1242, 85, 'Orizari'),
(1245, 85, 'Petrovec'),
(1248, 85, 'Prilep'),
(1249, 85, 'Probistip'),
(1250, 85, 'Radovis'),
(1252, 85, 'Resen'),
(1253, 85, 'Rosoman'),
(1256, 85, 'Saraj'),
(1260, 85, 'Srbinovo'),
(1262, 85, 'Star Dojran'),
(1264, 85, 'Stip'),
(1265, 85, 'Struga'),
(1266, 85, 'Strumica'),
(1267, 85, 'Studenicani'),
(1268, 85, 'Suto Orizari'),
(1269, 85, 'Sveti Nikole'),
(1270, 85, 'Tearce'),
(1271, 85, 'Tetovo'),
(1273, 85, 'Valandovo'),
(1275, 85, 'Veles'),
(1277, 85, 'Vevcani'),
(1278, 85, 'Vinica'),
(1281, 85, 'Vrapciste'),
(1286, 85, 'Zelino'),
(1289, 85, 'Zrnovci'),
(1291, 86, 'Malta'),
(1292, 44, 'La Condamine'),
(1293, 44, 'Monaco'),
(1294, 44, 'Monte-Carlo'),
(1295, 47, 'Biala Podlaska'),
(1296, 47, 'Bialystok'),
(1297, 47, 'Bielsko'),
(1298, 47, 'Bydgoszcz'),
(1299, 47, 'Chelm'),
(1300, 47, 'Ciechanow'),
(1301, 47, 'Czestochowa'),
(1302, 47, 'Elblag'),
(1303, 47, 'Gdansk'),
(1304, 47, 'Gorzow'),
(1305, 47, 'Jelenia Gora'),
(1306, 47, 'Kalisz'),
(1307, 47, 'Katowice'),
(1308, 47, 'Kielce'),
(1309, 47, 'Konin'),
(1310, 47, 'Koszalin'),
(1311, 47, 'Krakow'),
(1312, 47, 'Krosno'),
(1313, 47, 'Legnica'),
(1314, 47, 'Leszno'),
(1315, 47, 'Lodz'),
(1316, 47, 'Lomza'),
(1317, 47, 'Lublin'),
(1318, 47, 'Nowy Sacz'),
(1319, 47, 'Olsztyn'),
(1320, 47, 'Opole'),
(1321, 47, 'Ostroleka'),
(1322, 47, 'Pila'),
(1323, 47, 'Piotrkow'),
(1324, 47, 'Plock'),
(1325, 47, 'Poznan'),
(1326, 47, 'Przemysl'),
(1327, 47, 'Radom'),
(1328, 47, 'Rzeszow'),
(1329, 47, 'Siedlce'),
(1330, 47, 'Sieradz'),
(1331, 47, 'Skierniewice'),
(1332, 47, 'Slupsk'),
(1333, 47, 'Suwalki'),
(1335, 47, 'Tarnobrzeg'),
(1336, 47, 'Tarnow'),
(1337, 47, 'Torun'),
(1338, 47, 'Walbrzych'),
(1339, 47, 'Warszawa'),
(1340, 47, 'Wloclawek'),
(1341, 47, 'Wroclaw'),
(1342, 47, 'Zamosc'),
(1343, 47, 'Zielona Gora'),
(1344, 47, 'Dolnoslaskie'),
(1345, 47, 'Kujawsko-Pomorskie'),
(1346, 47, 'Lodzkie'),
(1347, 47, 'Lubelskie'),
(1348, 47, 'Lubuskie'),
(1349, 47, 'Malopolskie'),
(1350, 47, 'Mazowieckie'),
(1351, 47, 'Opolskie'),
(1352, 47, 'Podkarpackie'),
(1353, 47, 'Podlaskie'),
(1354, 47, 'Pomorskie'),
(1355, 47, 'Slaskie'),
(1356, 47, 'Swietokrzyskie'),
(1357, 47, 'Warminsko-Mazurskie'),
(1358, 47, 'Wielkopolskie'),
(1359, 47, 'Zachodniopomorskie'),
(1361, 72, 'Alba'),
(1362, 72, 'Arad'),
(1363, 72, 'Arges'),
(1364, 72, 'Bacau'),
(1365, 72, 'Bihor'),
(1366, 72, 'Bistrita-Nasaud'),
(1367, 72, 'Botosani'),
(1368, 72, 'Braila'),
(1369, 72, 'Brasov'),
(1370, 72, 'Bucuresti'),
(1371, 72, 'Buzau'),
(1372, 72, 'Caras-Severin'),
(1373, 72, 'Cluj'),
(1374, 72, 'Constanta'),
(1375, 72, 'Covasna'),
(1376, 72, 'Dambovita'),
(1377, 72, 'Dolj'),
(1378, 72, 'Galati'),
(1379, 72, 'Gorj'),
(1380, 72, 'Harghita'),
(1381, 72, 'Hunedoara'),
(1382, 72, 'Ialomita'),
(1383, 72, 'Iasi'),
(1384, 72, 'Maramures'),
(1385, 72, 'Mehedinti'),
(1386, 72, 'Mures'),
(1387, 72, 'Neamt'),
(1388, 72, 'Olt'),
(1389, 72, 'Prahova'),
(1390, 72, 'Salaj'),
(1391, 72, 'Satu Mare'),
(1392, 72, 'Sibiu'),
(1393, 72, 'Suceava'),
(1394, 72, 'Teleorman'),
(1395, 72, 'Timis'),
(1396, 72, 'Tulcea'),
(1397, 72, 'Vaslui'),
(1398, 72, 'Valcea'),
(1399, 72, 'Vrancea'),
(1400, 72, 'Calarasi'),
(1401, 72, 'Giurgiu'),
(1404, 224, 'Acquaviva'),
(1405, 224, 'Chiesanuova'),
(1406, 224, 'Domagnano'),
(1407, 224, 'Faetano'),
(1408, 224, 'Fiorentino'),
(1409, 224, 'Borgo Maggiore'),
(1410, 224, 'San Marino'),
(1411, 224, 'Monte Giardino'),
(1412, 224, 'Serravalle'),
(1413, 52, 'Banska Bystrica'),
(1414, 52, 'Bratislava'),
(1415, 52, 'Kosice'),
(1416, 52, 'Nitra'),
(1417, 52, 'Presov'),
(1418, 52, 'Trencin'),
(1419, 52, 'Trnava'),
(1420, 52, 'Zilina'),
(1423, 53, 'Beltinci'),
(1425, 53, 'Bohinj'),
(1426, 53, 'Borovnica'),
(1427, 53, 'Bovec'),
(1428, 53, 'Brda'),
(1429, 53, 'Brezice'),
(1430, 53, 'Brezovica'),
(1432, 53, 'Cerklje na Gorenjskem'),
(1434, 53, 'Cerkno'),
(1436, 53, 'Crna na Koroskem'),
(1437, 53, 'Crnomelj'),
(1438, 53, 'Divaca'),
(1439, 53, 'Dobrepolje'),
(1440, 53, 'Dol pri Ljubljani'),
(1443, 53, 'Duplek'),
(1447, 53, 'Gornji Grad'),
(1450, 53, 'Hrastnik'),
(1451, 53, 'Hrpelje-Kozina'),
(1452, 53, 'Idrija'),
(1453, 53, 'Ig'),
(1454, 53, 'Ilirska Bistrica'),
(1455, 53, 'Ivancna Gorica'),
(1462, 53, 'Komen'),
(1463, 53, 'Koper-Capodistria'),
(1464, 53, 'Kozje'),
(1465, 53, 'Kranj'),
(1466, 53, 'Kranjska Gora'),
(1467, 53, 'Krsko'),
(1469, 53, 'Lasko'),
(1470, 53, 'Ljubljana'),
(1471, 53, 'Ljubno'),
(1472, 53, 'Logatec'),
(1475, 53, 'Medvode'),
(1476, 53, 'Menges'),
(1478, 53, 'Mezica'),
(1480, 53, 'Moravce'),
(1482, 53, 'Mozirje'),
(1483, 53, 'Murska Sobota'),
(1487, 53, 'Nova Gorica'),
(1489, 53, 'Ormoz'),
(1491, 53, 'Pesnica'),
(1494, 53, 'Postojna'),
(1497, 53, 'Radece'),
(1498, 53, 'Radenci'),
(1500, 53, 'Radovljica'),
(1502, 53, 'Rogaska Slatina'),
(1505, 53, 'Sencur'),
(1506, 53, 'Sentilj'),
(1508, 53, 'Sevnica'),
(1509, 53, 'Sezana'),
(1511, 53, 'Skofja Loka'),
(1513, 53, 'Slovenj Gradec'),
(1514, 53, 'Slovenske Konjice'),
(1515, 53, 'Smarje pri Jelsah'),
(1521, 53, 'Tolmin'),
(1522, 53, 'Trbovlje'),
(1524, 53, 'Trzic'),
(1526, 53, 'Velenje'),
(1528, 53, 'Vipava'),
(1531, 53, 'Vrhnika'),
(1532, 53, 'Vuzenica'),
(1533, 53, 'Zagorje ob Savi'),
(1535, 53, 'Zelezniki'),
(1536, 53, 'Ziri'),
(1537, 53, 'Zrece'),
(1539, 53, 'Domzale'),
(1540, 53, 'Jesenice'),
(1541, 53, 'Kamnik'),
(1542, 53, 'Kocevje'),
(1544, 53, 'Lenart'),
(1545, 53, 'Litija'),
(1546, 53, 'Ljutomer'),
(1550, 53, 'Maribor'),
(1552, 53, 'Novo Mesto'),
(1553, 53, 'Piran'),
(1554, 53, 'Preddvor'),
(1555, 53, 'Ptuj'),
(1556, 53, 'Ribnica'),
(1558, 53, 'Sentjur pri Celju'),
(1559, 53, 'Slovenska Bistrica'),
(1560, 53, 'Videm'),
(1562, 53, 'Zalec'),
(1564, 109, 'Seychelles'),
(1565, 108, 'Mauritania'),
(1566, 135, 'Senegal'),
(1567, 154, 'Road Town'),
(1568, 165, 'Congo'),
(1569, 166, 'Avarua'),
(1570, 172, 'Malabo'),
(1571, 175, 'Torshavn'),
(1572, 178, 'Papeete'),
(1573, 184, 'St George&#039;s'),
(1574, 186, 'St Peter Port'),
(1575, 188, 'Bissau'),
(1576, 193, 'Saint Helier'),
(1577, 201, 'Fort-de-France'),
(1578, 207, 'Willemstad'),
(1579, 208, 'Noumea'),
(1580, 212, 'Kingston'),
(1581, 215, 'Adamstown'),
(1582, 216, 'Doha'),
(1583, 218, 'Jamestown'),
(1584, 219, 'Basseterre'),
(1585, 220, 'Castries'),
(1586, 221, 'Saint Pierre'),
(1587, 222, 'Kingstown'),
(1588, 225, 'San Tome'),
(1589, 226, 'Belgrade'),
(1590, 227, 'Freetown'),
(1591, 229, 'Mogadishu'),
(1592, 235, 'Fakaofo'),
(1593, 237, 'Port of Spain'),
(1594, 241, 'Mata-Utu'),
(1596, 89, 'Amazonas'),
(1597, 89, 'Ancash'),
(1598, 89, 'Apurímac'),
(1599, 89, 'Arequipa'),
(1600, 89, 'Ayacucho'),
(1601, 89, 'Cajamarca'),
(1602, 89, 'Callao'),
(1603, 89, 'Cusco'),
(1604, 89, 'Huancavelica'),
(1605, 89, 'Huánuco'),
(1606, 89, 'Ica'),
(1607, 89, 'Junín'),
(1608, 89, 'La Libertad'),
(1609, 89, 'Lambayeque'),
(1610, 89, 'Lima'),
(1611, 89, 'Loreto'),
(1612, 89, 'Madre de Dios'),
(1613, 89, 'Moquegua'),
(1614, 89, 'Pasco'),
(1615, 89, 'Piura'),
(1616, 89, 'Puno'),
(1617, 89, 'San Martín'),
(1618, 89, 'Tacna'),
(1619, 89, 'Tumbes'),
(1620, 89, 'Ucayali'),
(1622, 110, 'Alto Paraná'),
(1623, 110, 'Amambay'),
(1624, 110, 'Boquerón'),
(1625, 110, 'Caaguaz&uacute;'),
(1626, 110, 'Caazapá'),
(1627, 110, 'Central'),
(1628, 110, 'Concepción'),
(1629, 110, 'Cordillera'),
(1630, 110, 'Guairá'),
(1631, 110, 'Itap&uacute;a'),
(1632, 110, 'Misiones'),
(1633, 110, 'Neembuc&uacute;'),
(1634, 110, 'Paraguarí'),
(1635, 110, 'Presidente Hayes'),
(1636, 110, 'San Pedro'),
(1637, 110, 'Alto Paraguay'),
(1638, 110, 'Canindey&uacute;'),
(1639, 110, 'Chaco'),
(1642, 111, 'Artigas'),
(1643, 111, 'Canelones'),
(1644, 111, 'Cerro Largo'),
(1645, 111, 'Colonia'),
(1646, 111, 'Durazno'),
(1647, 111, 'Flores'),
(1648, 111, 'Florida'),
(1649, 111, 'Lavalleja'),
(1650, 111, 'Maldonado'),
(1651, 111, 'Montevideo'),
(1652, 111, 'Paysand&uacute;'),
(1653, 111, 'Río Negro'),
(1654, 111, 'Rivera'),
(1655, 111, 'Rocha'),
(1656, 111, 'Salto'),
(1657, 111, 'San José'),
(1658, 111, 'Soriano'),
(1659, 111, 'Tacuarembó'),
(1660, 111, 'Treinta y Tres'),
(1662, 81, 'Región de Tarapacá'),
(1663, 81, 'Región de Antofagasta'),
(1664, 81, 'Región de Atacama'),
(1665, 81, 'Región de Coquimbo'),
(1666, 81, 'Región de Valparaíso'),
(1667, 81, 'Región del Libertador General Bernardo O&#039;Higgins'),
(1668, 81, 'Región del Maule'),
(1669, 81, 'Región del Bío Bío'),
(1670, 81, 'Región de La Araucanía'),
(1671, 81, 'Región de Los Lagos'),
(1672, 81, 'Región Aisén del General Carlos Ibáñez del Campo'),
(1673, 81, 'Región de Magallanes y de la Antártica Chilena'),
(1674, 81, 'Región Metropolitana de Santiago'),
(1676, 185, 'Alta Verapaz'),
(1677, 185, 'Baja Verapaz'),
(1678, 185, 'Chimaltenango'),
(1679, 185, 'Chiquimula'),
(1680, 185, 'El Progreso'),
(1681, 185, 'Escuintla'),
(1682, 185, 'Guatemala'),
(1683, 185, 'Huehuetenango'),
(1684, 185, 'Izabal'),
(1685, 185, 'Jalapa'),
(1686, 185, 'Jutiapa'),
(1687, 185, 'Petén'),
(1688, 185, 'Quetzaltenango'),
(1689, 185, 'Quiché'),
(1690, 185, 'Retalhuleu'),
(1691, 185, 'Sacatepéquez'),
(1692, 185, 'San Marcos'),
(1693, 185, 'Santa Rosa'),
(1694, 185, 'Sololá'),
(1695, 185, 'Suchitepequez'),
(1696, 185, 'Totonicapán'),
(1697, 185, 'Zacapa'),
(1699, 82, 'Amazonas'),
(1700, 82, 'Antioquia'),
(1701, 82, 'Arauca'),
(1702, 82, 'Atlántico'),
(1703, 82, 'Caquetá'),
(1704, 82, 'Cauca'),
(1705, 82, 'César'),
(1706, 82, 'Chocó'),
(1707, 82, 'Córdoba'),
(1708, 82, 'Guaviare'),
(1709, 82, 'Guainía'),
(1710, 82, 'Huila'),
(1711, 82, 'La Guajira'),
(1712, 82, 'Meta'),
(1713, 82, 'Narino'),
(1714, 82, 'Norte de Santander'),
(1715, 82, 'Putumayo'),
(1716, 82, 'Quindío'),
(1717, 82, 'Risaralda'),
(1718, 82, 'San Andrés y Providencia'),
(1719, 82, 'Santander'),
(1720, 82, 'Sucre'),
(1721, 82, 'Tolima'),
(1722, 82, 'Valle del Cauca'),
(1723, 82, 'Vaupés'),
(1724, 82, 'Vichada'),
(1725, 82, 'Casanare'),
(1726, 82, 'Cundinamarca'),
(1727, 82, 'Distrito Especial'),
(1730, 82, 'Caldas'),
(1731, 82, 'Magdalena'),
(1733, 42, 'Aguascalientes'),
(1734, 42, 'Baja California'),
(1735, 42, 'Baja California Sur'),
(1736, 42, 'Campeche'),
(1737, 42, 'Chiapas'),
(1738, 42, 'Chihuahua'),
(1739, 42, 'Coahuila de Zaragoza'),
(1740, 42, 'Colima'),
(1741, 42, 'Distrito Federal'),
(1742, 42, 'Durango'),
(1743, 42, 'Guanajuato'),
(1744, 42, 'Guerrero'),
(1745, 42, 'Hidalgo'),
(1746, 42, 'Jalisco'),
(1747, 42, 'México'),
(1748, 42, 'Michoacán de Ocampo'),
(1749, 42, 'Morelos'),
(1750, 42, 'Nayarit'),
(1751, 42, 'Nuevo León'),
(1752, 42, 'Oaxaca'),
(1753, 42, 'Puebla'),
(1754, 42, 'Querétaro de Arteaga'),
(1755, 42, 'Quintana Roo'),
(1756, 42, 'San Luis Potosí'),
(1757, 42, 'Sinaloa'),
(1758, 42, 'Sonora'),
(1759, 42, 'Tabasco'),
(1760, 42, 'Tamaulipas'),
(1761, 42, 'Tlaxcala'),
(1762, 42, 'Veracruz-Llave'),
(1763, 42, 'Yucatán'),
(1764, 42, 'Zacatecas'),
(1766, 124, 'Bocas del Toro'),
(1767, 124, 'Chiriquí'),
(1768, 124, 'Coclé'),
(1769, 124, 'Colón'),
(1770, 124, 'Darién'),
(1771, 124, 'Herrera'),
(1772, 124, 'Los Santos'),
(1773, 124, 'Panamá'),
(1774, 124, 'San Blas'),
(1775, 124, 'Veraguas'),
(1777, 123, 'Chuquisaca'),
(1778, 123, 'Cochabamba'),
(1779, 123, 'El Beni'),
(1780, 123, 'La Paz'),
(1781, 123, 'Oruro'),
(1782, 123, 'Pando'),
(1783, 123, 'Potosí'),
(1784, 123, 'Santa Cruz'),
(1785, 123, 'Tarija'),
(1787, 36, 'Alajuela'),
(1788, 36, 'Cartago'),
(1789, 36, 'Guanacaste'),
(1790, 36, 'Heredia'),
(1791, 36, 'Limón'),
(1792, 36, 'Puntarenas'),
(1793, 36, 'San José'),
(1795, 103, 'Galápagos'),
(1796, 103, 'Azuay'),
(1797, 103, 'Bolívar'),
(1798, 103, 'Canar'),
(1799, 103, 'Carchi'),
(1800, 103, 'Chimborazo'),
(1801, 103, 'Cotopaxi'),
(1802, 103, 'El Oro'),
(1803, 103, 'Esmeraldas'),
(1804, 103, 'Guayas'),
(1805, 103, 'Imbabura'),
(1806, 103, 'Loja'),
(1807, 103, 'Los Ríos'),
(1808, 103, 'Manabí'),
(1809, 103, 'Morona-Santiago'),
(1810, 103, 'Pastaza'),
(1811, 103, 'Pichincha'),
(1812, 103, 'Tungurahua'),
(1813, 103, 'Zamora-Chinchipe'),
(1814, 103, 'Sucumbíos'),
(1815, 103, 'Napo'),
(1816, 103, 'Orellana'),
(1818, 5, 'Buenos Aires'),
(1819, 5, 'Catamarca'),
(1820, 5, 'Chaco'),
(1821, 5, 'Chubut'),
(1822, 5, 'Córdoba'),
(1823, 5, 'Corrientes'),
(1824, 5, 'Distrito Federal'),
(1825, 5, 'Entre Ríos'),
(1826, 5, 'Formosa'),
(1827, 5, 'Jujuy'),
(1828, 5, 'La Pampa'),
(1829, 5, 'La Rioja'),
(1830, 5, 'Mendoza'),
(1831, 5, 'Misiones'),
(1832, 5, 'Neuquén'),
(1833, 5, 'Río Negro'),
(1834, 5, 'Salta'),
(1835, 5, 'San Juan'),
(1836, 5, 'San Luis'),
(1837, 5, 'Santa Cruz'),
(1838, 5, 'Santa Fe'),
(1839, 5, 'Santiago del Estero'),
(1840, 5, 'Tierra del Fuego'),
(1841, 5, 'Tucumán'),
(1843, 95, 'Amazonas'),
(1844, 95, 'Anzoategui'),
(1845, 95, 'Apure'),
(1846, 95, 'Aragua'),
(1847, 95, 'Barinas'),
(1848, 95, 'Bolívar'),
(1849, 95, 'Carabobo'),
(1850, 95, 'Cojedes'),
(1851, 95, 'Delta Amacuro'),
(1852, 95, 'Falcón'),
(1853, 95, 'Guárico'),
(1854, 95, 'Lara'),
(1855, 95, 'Mérida'),
(1856, 95, 'Miranda'),
(1857, 95, 'Monagas'),
(1858, 95, 'Nueva Esparta'),
(1859, 95, 'Portuguesa'),
(1860, 95, 'Sucre'),
(1861, 95, 'Táchira'),
(1862, 95, 'Trujillo'),
(1863, 95, 'Yaracuy'),
(1864, 95, 'Zulia'),
(1865, 95, 'Dependencias Federales'),
(1866, 95, 'Distrito Capital'),
(1867, 95, 'Vargas'),
(1869, 209, 'Boaco'),
(1870, 209, 'Carazo'),
(1871, 209, 'Chinandega'),
(1872, 209, 'Chontales'),
(1873, 209, 'Estelí'),
(1874, 209, 'Granada'),
(1875, 209, 'Jinotega'),
(1876, 209, 'León'),
(1877, 209, 'Madriz'),
(1878, 209, 'Managua'),
(1879, 209, 'Masaya'),
(1880, 209, 'Matagalpa'),
(1881, 209, 'Nueva Segovia'),
(1882, 209, 'Rio San Juan'),
(1883, 209, 'Rivas'),
(1884, 209, 'Zelaya'),
(1886, 113, 'Pinar del Rio'),
(1887, 113, 'Ciudad de la Habana'),
(1888, 113, 'Matanzas'),
(1889, 113, 'Isla de la Juventud'),
(1890, 113, 'Camaguey'),
(1891, 113, 'Ciego de Avila'),
(1892, 113, 'Cienfuegos'),
(1893, 113, 'Granma'),
(1894, 113, 'Guantanamo'),
(1895, 113, 'La Habana'),
(1896, 113, 'Holguin'),
(1897, 113, 'Las Tunas'),
(1898, 113, 'Sancti Spiritus'),
(1899, 113, 'Santiago de Cuba'),
(1900, 113, 'Villa Clara'),
(1901, 12, 'Acre'),
(1902, 12, 'Alagoas'),
(1903, 12, 'Amapa'),
(1904, 12, 'Amazonas'),
(1905, 12, 'Bahia'),
(1906, 12, 'Ceara'),
(1907, 12, 'Distrito Federal'),
(1908, 12, 'Espirito Santo'),
(1909, 12, 'Mato Grosso do Sul'),
(1910, 12, 'Maranhao'),
(1911, 12, 'Mato Grosso'),
(1912, 12, 'Minas Gerais'),
(1913, 12, 'Para'),
(1914, 12, 'Paraiba'),
(1915, 12, 'Parana'),
(1916, 12, 'Piaui'),
(1917, 12, 'Rio de Janeiro'),
(1918, 12, 'Rio Grande do Norte'),
(1919, 12, 'Rio Grande do Sul'),
(1920, 12, 'Rondonia'),
(1921, 12, 'Roraima'),
(1922, 12, 'Santa Catarina'),
(1923, 12, 'Sao Paulo'),
(1924, 12, 'Sergipe'),
(1925, 12, 'Goias'),
(1926, 12, 'Pernambuco'),
(1927, 12, 'Tocantins'),
(1930, 83, 'Akureyri'),
(1931, 83, 'Arnessysla'),
(1932, 83, 'Austur-Bardastrandarsysla'),
(1933, 83, 'Austur-Hunavatnssysla'),
(1934, 83, 'Austur-Skaftafellssysla'),
(1935, 83, 'Borgarfjardarsysla'),
(1936, 83, 'Dalasysla'),
(1937, 83, 'Eyjafjardarsysla'),
(1938, 83, 'Gullbringusysla'),
(1939, 83, 'Hafnarfjordur'),
(1943, 83, 'Kjosarsysla'),
(1944, 83, 'Kopavogur'),
(1945, 83, 'Myrasysla'),
(1946, 83, 'Neskaupstadur'),
(1947, 83, 'Nordur-Isafjardarsysla'),
(1948, 83, 'Nordur-Mulasysla'),
(1949, 83, 'Nordur-Tingeyjarsysla'),
(1950, 83, 'Olafsfjordur'),
(1951, 83, 'Rangarvallasysla'),
(1952, 83, 'Reykjavik'),
(1953, 83, 'Saudarkrokur'),
(1954, 83, 'Seydisfjordur'),
(1956, 83, 'Skagafjardarsysla'),
(1957, 83, 'Snafellsnes- og Hnappadalssysla'),
(1958, 83, 'Strandasysla'),
(1959, 83, 'Sudur-Mulasysla'),
(1960, 83, 'Sudur-Tingeyjarsysla'),
(1961, 83, 'Vestmannaeyjar'),
(1962, 83, 'Vestur-Bardastrandarsysla'),
(1964, 83, 'Vestur-Isafjardarsysla'),
(1965, 83, 'Vestur-Skaftafellssysla'),
(1966, 35, 'Anhui'),
(1967, 35, 'Zhejiang'),
(1968, 35, 'Jiangxi'),
(1969, 35, 'Jiangsu'),
(1970, 35, 'Jilin'),
(1971, 35, 'Qinghai'),
(1972, 35, 'Fujian'),
(1973, 35, 'Heilongjiang'),
(1974, 35, 'Henan'),
(1975, 35, 'Hebei'),
(1976, 35, 'Hunan'),
(1977, 35, 'Hubei'),
(1978, 35, 'Xinjiang'),
(1979, 35, 'Xizang'),
(1980, 35, 'Gansu'),
(1981, 35, 'Guangxi'),
(1982, 35, 'Guizhou'),
(1983, 35, 'Liaoning'),
(1984, 35, 'Nei Mongol'),
(1985, 35, 'Ningxia'),
(1986, 35, 'Beijing'),
(1987, 35, 'Shanghai'),
(1988, 35, 'Shanxi'),
(1989, 35, 'Shandong'),
(1990, 35, 'Shaanxi'),
(1991, 35, 'Sichuan'),
(1992, 35, 'Tianjin'),
(1993, 35, 'Yunnan'),
(1994, 35, 'Guangdong'),
(1995, 35, 'Hainan'),
(1996, 35, 'Chongqing'),
(1997, 97, 'Central'),
(1998, 97, 'Coast'),
(1999, 97, 'Eastern'),
(2000, 97, 'Nairobi Area'),
(2001, 97, 'North-Eastern'),
(2002, 97, 'Nyanza'),
(2003, 97, 'Rift Valley'),
(2004, 97, 'Western'),
(2006, 195, 'Gilbert Islands'),
(2007, 195, 'Line Islands'),
(2008, 195, 'Phoenix Islands'),
(2010, 1, 'Australian Capital Territory'),
(2011, 1, 'New South Wales'),
(2012, 1, 'Northern Territory'),
(2013, 1, 'Queensland'),
(2014, 1, 'South Australia'),
(2015, 1, 'Tasmania'),
(2016, 1, 'Victoria'),
(2017, 1, 'Western Australia'),
(2018, 27, 'Dublin'),
(2019, 27, 'Galway'),
(2020, 27, 'Kildare'),
(2021, 27, 'Leitrim'),
(2022, 27, 'Limerick'),
(2023, 27, 'Mayo'),
(2024, 27, 'Meath'),
(2025, 27, 'Carlow'),
(2026, 27, 'Kilkenny'),
(2027, 27, 'Laois'),
(2028, 27, 'Longford'),
(2029, 27, 'Louth'),
(2030, 27, 'Offaly'),
(2031, 27, 'Westmeath'),
(2032, 27, 'Wexford'),
(2033, 27, 'Wicklow'),
(2034, 27, 'Roscommon'),
(2035, 27, 'Sligo'),
(2036, 27, 'Clare'),
(2037, 27, 'Cork'),
(2038, 27, 'Kerry'),
(2039, 27, 'Tipperary'),
(2040, 27, 'Waterford'),
(2041, 27, 'Cavan'),
(2042, 27, 'Donegal'),
(2043, 27, 'Monaghan'),
(2044, 50, 'Karachaeva-Cherkesskaya Respublica'),
(2045, 50, 'Raimirskii (Dolgano-Nenetskii) AO'),
(2046, 50, 'Respublica Tiva'),
(2047, 32, 'Newfoundland'),
(2048, 32, 'Nova Scotia'),
(2049, 32, 'Prince Edward Island'),
(2050, 32, 'New Brunswick'),
(2051, 32, 'Quebec'),
(2052, 32, 'Ontario'),
(2053, 32, 'Manitoba'),
(2054, 32, 'Saskatchewan'),
(2055, 32, 'Alberta'),
(2056, 32, 'British Columbia'),
(2057, 32, 'Nunavut'),
(2058, 32, 'Northwest Territories'),
(2059, 32, 'Yukon Territory'),
(2060, 19, 'Drenthe'),
(2061, 19, 'Friesland'),
(2062, 19, 'Gelderland'),
(2063, 19, 'Groningen'),
(2064, 19, 'Limburg'),
(2065, 19, 'Noord-Brabant'),
(2066, 19, 'Noord-Holland'),
(2067, 19, 'Utrecht'),
(2068, 19, 'Zeeland'),
(2069, 19, 'Zuid-Holland'),
(2071, 19, 'Overijssel'),
(2072, 19, 'Flevoland'),
(2073, 138, 'Duarte'),
(2074, 138, 'Puerto Plata'),
(2075, 138, 'Valverde'),
(2076, 138, 'María Trinidad Sánchez'),
(2077, 138, 'Azua'),
(2078, 138, 'Santiago'),
(2079, 138, 'San Cristóbal'),
(2080, 138, 'Peravia'),
(2081, 138, 'Elías Piña'),
(2082, 138, 'Barahona'),
(2083, 138, 'Monte Plata'),
(2084, 138, 'Salcedo'),
(2085, 138, 'La Altagracia'),
(2086, 138, 'San Juan'),
(2087, 138, 'Monseñor Nouel'),
(2088, 138, 'Monte Cristi'),
(2089, 138, 'Espaillat'),
(2090, 138, 'Sánchez Ramírez'),
(2091, 138, 'La Vega'),
(2092, 138, 'San Pedro de Macorís'),
(2093, 138, 'Independencia'),
(2094, 138, 'Dajabón'),
(2095, 138, 'Baoruco'),
(2096, 138, 'El Seibo'),
(2097, 138, 'Hato Mayor'),
(2098, 138, 'La Romana'),
(2099, 138, 'Pedernales'),
(2100, 138, 'Samaná'),
(2101, 138, 'Santiago Rodríguez'),
(2102, 138, 'San José de Ocoa'),
(2103, 70, 'Chiba'),
(2104, 70, 'Ehime'),
(2105, 70, 'Oita'),
(2106, 85, 'Skopje'),
(2108, 35, 'Schanghai'),
(2109, 35, 'Hongkong'),
(2110, 35, 'Neimenggu'),
(2111, 35, 'Aomen'),
(2112, 92, 'Amnat Charoen'),
(2113, 92, 'Ang Thong'),
(2114, 92, 'Bangkok'),
(2115, 92, 'Buri Ram'),
(2116, 92, 'Chachoengsao'),
(2117, 92, 'Chai Nat'),
(2118, 92, 'Chaiyaphum'),
(2119, 92, 'Chanthaburi'),
(2120, 92, 'Chiang Mai'),
(2121, 92, 'Chiang Rai'),
(2122, 92, 'Chon Buri'),
(2124, 92, 'Kalasin'),
(2126, 92, 'Kanchanaburi'),
(2127, 92, 'Khon Kaen'),
(2128, 92, 'Krabi'),
(2129, 92, 'Lampang'),
(2131, 92, 'Loei'),
(2132, 92, 'Lop Buri'),
(2133, 92, 'Mae Hong Son'),
(2134, 92, 'Maha Sarakham'),
(2137, 92, 'Nakhon Pathom'),
(2139, 92, 'Nakhon Ratchasima'),
(2140, 92, 'Nakhon Sawan'),
(2141, 92, 'Nakhon Si Thammarat'),
(2143, 92, 'Narathiwat'),
(2144, 92, 'Nong Bua Lam Phu'),
(2145, 92, 'Nong Khai'),
(2146, 92, 'Nonthaburi'),
(2147, 92, 'Pathum Thani'),
(2148, 92, 'Pattani'),
(2149, 92, 'Phangnga'),
(2150, 92, 'Phatthalung'),
(2154, 92, 'Phichit'),
(2155, 92, 'Phitsanulok'),
(2156, 92, 'Phra Nakhon Si Ayutthaya'),
(2157, 92, 'Phrae'),
(2158, 92, 'Phuket'),
(2159, 92, 'Prachin Buri'),
(2160, 92, 'Prachuap Khiri Khan'),
(2162, 92, 'Ratchaburi'),
(2163, 92, 'Rayong'),
(2164, 92, 'Roi Et'),
(2165, 92, 'Sa Kaeo'),
(2166, 92, 'Sakon Nakhon'),
(2167, 92, 'Samut Prakan'),
(2168, 92, 'Samut Sakhon'),
(2169, 92, 'Samut Songkhran'),
(2170, 92, 'Saraburi'),
(2172, 92, 'Si Sa Ket'),
(2173, 92, 'Sing Buri'),
(2174, 92, 'Songkhla'),
(2175, 92, 'Sukhothai'),
(2176, 92, 'Suphan Buri'),
(2177, 92, 'Surat Thani'),
(2178, 92, 'Surin'),
(2180, 92, 'Trang'),
(2182, 92, 'Ubon Ratchathani'),
(2183, 92, 'Udon Thani'),
(2184, 92, 'Uthai Thani'),
(2185, 92, 'Uttaradit'),
(2186, 92, 'Yala'),
(2187, 92, 'Yasothon'),
(2188, 69, 'Busan'),
(2189, 69, 'Daegu'),
(2191, 69, 'Gangwon'),
(2192, 69, 'Gwangju'),
(2193, 69, 'Gyeonggi'),
(2194, 69, 'Gyeongsangbuk'),
(2195, 69, 'Gyeongsangnam'),
(2196, 69, 'Jeju'),
(2201, 25, 'Delhi'),
(2202, 81, 'Región de Los Ríos'),
(2203, 81, 'Región de Arica y Parinacota');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clasificacion_informacion`
--

CREATE TABLE `clasificacion_informacion` (
  `id` int(11) NOT NULL,
  `clasificacion` varchar(150) DEFAULT NULL,
  `descripcion` varchar(500) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clasificacion_informacion`
--

INSERT INTO `clasificacion_informacion` (`id`, `clasificacion`, `descripcion`, `estado`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`) VALUES
(1, 'CLASIFICAICONA', 'CLASIFICAICONA', 1, 1, '2023-05-07 18:28:54.000000', 1, '2023-05-18 14:37:54.000000', NULL, NULL, 0),
(2, 'CONFIDENCIAL', 'CONFIDENCIAL', 1, 1, '2023-05-18 14:36:26.000000', NULL, '2023-05-18 14:37:01.000000', 1, '2023-05-18 14:37:01.000000', 1),
(3, 'CLASIFICAICONB', 'CLASIFICAICONB', 1, 1, '2023-05-18 14:38:01.000000', NULL, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cobertura`
--

CREATE TABLE `cobertura` (
  `id` int(11) NOT NULL,
  `cobertura` varchar(150) DEFAULT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cobertura`
--

INSERT INTO `cobertura` (`id`, `cobertura`, `descripcion`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`) VALUES
(1, 'Probabilidad', 'Probabilidad', 1, '2023-05-05 00:00:00.000000', NULL, NULL, NULL, NULL, 0),
(2, 'Impacto', 'Impacto', 1, '2023-05-05 00:00:00.000000', NULL, NULL, NULL, NULL, 0),
(3, 'Ambos', 'Ambos', 1, '2023-05-05 00:00:00.000000', NULL, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `config_pass`
--

CREATE TABLE `config_pass` (
  `id` int(11) NOT NULL,
  `duracion` int(11) DEFAULT NULL,
  `inactividad` int(11) DEFAULT NULL,
  `sesion` int(11) DEFAULT NULL,
  `tama_min` int(11) DEFAULT NULL,
  `tama_max` int(11) DEFAULT NULL,
  `letras` int(11) DEFAULT NULL,
  `numeros` int(11) DEFAULT NULL,
  `caracteres` int(11) DEFAULT NULL,
  `fecha_creacion` datetime(6) DEFAULT NULL,
  `fecha_actualizacion` datetime(6) DEFAULT NULL,
  `intentos` int(11) DEFAULT NULL,
  `recordatorio` int(11) DEFAULT NULL,
  `limitador` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `config_pass`
--

INSERT INTO `config_pass` (`id`, `duracion`, `inactividad`, `sesion`, `tama_min`, `tama_max`, `letras`, `numeros`, `caracteres`, `fecha_creacion`, `fecha_actualizacion`, `intentos`, `recordatorio`, `limitador`) VALUES
(1, 45, 60, 30, 8, 12, 1, 1, 1, '2023-03-22 00:59:24.000000', '0000-00-00 00:00:00.000000', 3, 10, 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `continente`
--

CREATE TABLE `continente` (
  `ContinenteCodigo` char(50) NOT NULL DEFAULT '',
  `PaisContinente` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `continente`
--

INSERT INTO `continente` (`ContinenteCodigo`, `PaisContinente`) VALUES
('Africa', 'Africa'),
('América', 'América'),
('Asia', 'Asia'),
('Europe', 'Europa'),
('Oceania', 'Oceania');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `controles`
--

CREATE TABLE `controles` (
  `id` int(11) NOT NULL,
  `IDR` int(11) DEFAULT NULL,
  `riesgo` int(11) DEFAULT NULL,
  `IDC` int(11) DEFAULT NULL,
  `desc_control` varchar(150) DEFAULT NULL,
  `disenio` varchar(150) DEFAULT NULL,
  `responsable` int(11) DEFAULT NULL,
  `preiodicidad` varchar(150) DEFAULT NULL,
  `evidencia` varchar(150) DEFAULT NULL,
  `documentacion` varchar(150) DEFAULT NULL,
  `idobjetivo` int(11) DEFAULT NULL,
  `operatividad` varchar(150) DEFAULT NULL,
  `idprueba` int(11) DEFAULT NULL,
  `idautomatizacion` int(11) DEFAULT NULL,
  `caract_operatividad` varchar(150) DEFAULT NULL,
  `evaluacion` varchar(150) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` int(11) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` int(11) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `correo_actividad`
--

CREATE TABLE `correo_actividad` (
  `id` int(11) NOT NULL,
  `idactividad` int(11) DEFAULT NULL,
  `fecha_envio` datetime DEFAULT NULL,
  `idusuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `correo_actividad`
--

INSERT INTO `correo_actividad` (`id`, `idactividad`, `fecha_envio`, `idusuario`) VALUES
(18, 13, '2023-05-11 00:00:00', 1),
(19, 14, '2023-05-11 03:46:59', 1),
(20, 15, '2023-05-14 11:55:40', 1),
(21, 16, '2023-05-14 00:00:00', 1),
(23, 16, '2023-05-14 00:00:00', 1),
(24, 16, '2023-05-15 00:00:00', 1),
(25, 16, '2023-05-15 00:00:00', 1),
(26, 16, '2023-05-16 17:55:00', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `correo_plan`
--

CREATE TABLE `correo_plan` (
  `id` int(11) NOT NULL,
  `idplan` int(11) DEFAULT NULL,
  `fecha_envio` datetime DEFAULT NULL,
  `idusuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `correo_plan`
--

INSERT INTO `correo_plan` (`id`, `idplan`, `fecha_envio`, `idusuario`) VALUES
(38, 8, '2023-04-04 00:00:00', 8),
(39, 12, '2023-05-10 00:00:00', 1),
(40, 13, '2023-05-11 00:00:00', 1),
(41, 14, '2023-05-11 00:00:00', 1),
(42, 15, '2023-05-11 00:00:00', 1),
(43, 16, '2023-05-14 11:55:00', 1),
(44, 16, '2023-05-14 00:00:00', 1),
(45, 16, '2023-05-14 00:00:00', 1),
(47, 16, '2023-05-15 00:00:00', 1),
(48, 17, '2023-05-16 17:53:07', 1),
(49, 18, '2023-05-18 03:27:03', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `datos_correo`
--

CREATE TABLE `datos_correo` (
  `id` int(11) NOT NULL,
  `smtp_server` varchar(100) DEFAULT NULL,
  `ip_server` varchar(100) DEFAULT NULL,
  `puerto_server` int(11) DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `email_server` varchar(150) DEFAULT NULL,
  `pass_server` varchar(500) DEFAULT NULL,
  `send_email` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `datos_correo`
--

INSERT INTO `datos_correo` (`id`, `smtp_server`, `ip_server`, `puerto_server`, `descripcion`, `email_server`, `pass_server`, `send_email`) VALUES
(1, 'smtp.gmail.com', '', 587, 'Riesgos SI-C', 'youkai.miguel@gmail.com', 'rrtblhmaeikftqix', 'gestionRiesgoSI_C@efectiva.com.pe');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `desc_amenaza`
--

CREATE TABLE `desc_amenaza` (
  `id` int(11) NOT NULL,
  `idtipo_amenaza` int(11) DEFAULT NULL,
  `amenaza` varchar(150) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `desc_amenaza`
--

INSERT INTO `desc_amenaza` (`id`, `idtipo_amenaza`, `amenaza`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`) VALUES
(1, 1, 'AMEDESCA', 1, '2023-05-07 18:26:06.000000', NULL, NULL, NULL, NULL, 0),
(2, 2, 'AMEDESB', 1, '2023-05-07 18:26:15.000000', NULL, NULL, NULL, NULL, 0),
(4, 3, 'AMEDESC', 1, '2023-05-09 18:07:26.000000', NULL, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `desc_vulnerabilidad`
--

CREATE TABLE `desc_vulnerabilidad` (
  `id` int(11) NOT NULL,
  `idcategoria_vulnerabilidad` int(11) DEFAULT NULL,
  `vulnerabilidad` varchar(150) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `desc_vulnerabilidad`
--

INSERT INTO `desc_vulnerabilidad` (`id`, `idcategoria_vulnerabilidad`, `vulnerabilidad`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`) VALUES
(1, 1, 'CATDESCA', 1, '2023-05-07 18:26:43.000000', NULL, NULL, NULL, NULL, 0),
(2, 2, 'CATDESCB', 1, '2023-05-07 18:26:51.000000', NULL, NULL, NULL, NULL, 0),
(3, 3, 'CATDESC', 1, '2023-05-09 18:07:45.000000', NULL, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_controles`
--

CREATE TABLE `detalle_controles` (
  `id` int(11) NOT NULL,
  `idControles` int(11) DEFAULT NULL,
  `idCC` int(11) DEFAULT NULL,
  `nom_tabla` varchar(40) DEFAULT NULL,
  `valor` varchar(50) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0,
  `idcaracteristica_control` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_controles`
--

INSERT INTO `detalle_controles` (`id`, `idControles`, `idCC`, `nom_tabla`, `valor`, `is_deleted`, `idcaracteristica_control`) VALUES
(95, 8, 7, '0', ' DISEñO  ', 0, 7),
(96, 8, 13, '0', ' OPERATIVIDAD  ', 0, 13),
(97, 8, 15, '0', 'BAJO', 0, 15),
(98, 8, 16, '0', 'BAJO', 0, 16),
(99, 8, 8, '0', '', 0, 8),
(100, 8, 29, '1', '', 0, 29),
(101, 8, 25, '0', '', 0, 25),
(102, 9, 7, '0', ' DISEñO  ', 0, 7),
(103, 9, 13, '0', ' OPERATIVIDAD  ', 0, 13),
(104, 9, 15, '0', 'BAJO', 0, 15),
(105, 9, 16, '0', 'BAJO', 0, 16),
(106, 9, 8, '0', '', 0, 8),
(107, 9, 29, '1', '', 0, 29),
(108, 9, 25, '0', '', 0, 25),
(109, 10, 7, '0', ' DISEñO  ', 0, 7),
(110, 10, 13, '0', ' OPERATIVIDAD  ', 0, 13),
(111, 10, 15, '0', 'BAJO', 0, 15),
(112, 10, 16, '0', 'BAJO', 0, 16),
(113, 10, 8, '0', '', 0, 8),
(114, 10, 29, '1', '', 0, 29),
(115, 10, 25, '0', '', 0, 25),
(116, 11, 7, '0', ' DISEñO  ', 1, 7),
(117, 11, 13, '0', ' OPERATIVIDAD  ', 1, 13),
(118, 11, 15, '0', 'BAJO', 1, 15),
(119, 11, 16, '0', 'BAJO', 1, 16),
(120, 11, 8, '0', '', 1, 8),
(121, 11, 29, '1', '', 1, 29),
(122, 11, 25, '0', '', 1, 25),
(123, 11, 7, '0', ' DISEñO  ', 0, 7),
(124, 11, 13, '0', ' OPERATIVIDAD  ', 0, 13),
(125, 11, 18, '0', 'MODERADO', 0, 18),
(126, 11, 16, '0', 'BAJO', 0, 16),
(127, 11, 8, '0', '', 0, 8),
(128, 11, 29, '1', '1', 0, 29),
(129, 11, 25, '0', '', 0, 25),
(130, 12, 7, '0', ' DISEñO  ', 0, 7),
(131, 12, 13, '0', ' OPERATIVIDAD  ', 0, 13),
(132, 12, 18, '0', 'MODERADO', 0, 18),
(133, 12, 16, '0', 'BAJO', 0, 16),
(134, 12, 8, '0', '', 0, 8),
(135, 12, 29, '1', '2', 0, 29),
(136, 12, 25, '0', '', 0, 25),
(137, 13, 7, '0', ' DISEñO  ', 0, 7),
(138, 13, 13, '0', ' OPERATIVIDAD  ', 0, 13),
(139, 13, 18, '0', 'MODERADO', 0, 18),
(140, 13, 16, '0', 'BAJO', 0, 16),
(141, 13, 8, '0', '', 0, 8),
(142, 13, 29, '1', '1', 0, 29),
(143, 13, 25, '0', '', 0, 25),
(144, 14, 7, '0', ' DISEñO  ', 0, 7),
(145, 14, 13, '0', ' OPERATIVIDAD  ', 0, 13),
(146, 14, 18, '0', 'MODERADO', 0, 18),
(147, 14, 16, '0', 'BAJO', 0, 16),
(148, 14, 8, '0', '', 0, 8),
(149, 14, 29, '1', '1', 0, 29),
(150, 14, 25, '0', '', 0, 25),
(151, 15, 7, '0', ' DISEñO  ', 0, 7),
(152, 15, 13, '0', ' OPERATIVIDAD  ', 0, 13),
(153, 15, 18, '0', 'MODERADO', 0, 18),
(154, 15, 16, '0', 'BAJO', 0, 16),
(155, 15, 8, '0', '', 0, 8),
(156, 15, 29, '1', '1', 0, 29),
(157, 15, 25, '0', '', 0, 25),
(158, 16, 7, '0', ' DISEñO  ', 0, 7),
(159, 16, 13, '0', ' OPERATIVIDAD  ', 0, 13),
(160, 16, 18, '0', 'MODERADO', 0, 18),
(161, 16, 16, '0', 'BAJO', 0, 16),
(162, 16, 8, '0', '', 0, 8),
(163, 16, 29, '1', '1', 0, 29),
(164, 16, 25, '0', '', 0, 25),
(165, 17, 7, '0', ' DISEñO  ', 0, 7),
(166, 17, 13, '0', ' OPERATIVIDAD  ', 0, 13),
(167, 17, 18, '0', 'MODERADO', 0, 18),
(168, 17, 16, '0', 'BAJO', 0, 16),
(169, 17, 8, '0', '', 0, 8),
(170, 17, 29, '1', '2', 0, 29),
(171, 17, 25, '0', '', 0, 25),
(172, 18, 7, '0', ' DISEñO  ', 0, 7),
(173, 18, 13, '0', ' OPERATIVIDAD  ', 0, 13),
(174, 18, 18, '0', 'MODERADO', 0, 18),
(175, 18, 16, '0', 'BAJO', 0, 16),
(176, 18, 8, '0', '24', 0, 8),
(177, 18, 29, '1', '2', 0, 29),
(178, 18, 25, '0', '', 0, 25),
(179, 19, 7, '0', ' DISEñO  ', 0, 7),
(180, 19, 13, '0', ' OPERATIVIDAD  ', 0, 13),
(181, 19, 18, '0', 'MODERADO', 0, 18),
(182, 19, 16, '0', 'BAJO', 0, 16),
(183, 19, 8, '0', '24', 0, 8),
(184, 19, 29, '1', '1', 0, 29),
(185, 19, 25, '0', '27', 0, 25),
(186, 20, 7, '0', ' DISEñO  ', 0, 7),
(187, 20, 13, '0', ' OPERATIVIDAD  ', 0, 13),
(188, 20, 15, '0', 'BAJO', 0, 15),
(189, 20, 16, '0', 'BAJO', 0, 16),
(190, 20, 8, '0', '', 0, 8),
(191, 20, 29, '1', '', 0, 29),
(192, 20, 25, '0', '', 0, 25);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_evaluacion_control`
--

CREATE TABLE `detalle_evaluacion_control` (
  `id` int(11) NOT NULL,
  `IEC` int(11) DEFAULT NULL,
  `ID_CC` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_evaluacion_control`
--

INSERT INTO `detalle_evaluacion_control` (`id`, `IEC`, `ID_CC`) VALUES
(21, 3, 0),
(22, 3, 0),
(25, 5, 18),
(26, 5, 16),
(27, 6, 18),
(28, 6, 30),
(29, 1, 0),
(30, 1, 17),
(31, 7, 18),
(32, 7, 17),
(33, 2, 15),
(34, 2, 16),
(37, 8, 18),
(38, 8, 17),
(45, 4, 15),
(46, 4, 17),
(47, 9, 41),
(48, 9, 16),
(51, 10, 15),
(52, 10, 16),
(57, 11, 15),
(58, 11, 17),
(59, 12, 15),
(60, 12, 30);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_valoracion_activo`
--

CREATE TABLE `detalle_valoracion_activo` (
  `id` int(11) NOT NULL,
  `idaspectos_seguridad` int(11) NOT NULL,
  `idvaloracion_activo` int(11) NOT NULL,
  `valoracion` int(11) NOT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_valoracion_activo`
--

INSERT INTO `detalle_valoracion_activo` (`id`, `idaspectos_seguridad`, `idvaloracion_activo`, `valoracion`, `is_deleted`) VALUES
(1, 2, 1, 1, 1),
(2, 3, 1, 1, 1),
(3, 4, 1, 1, 1),
(4, 2, 2, 1, 1),
(5, 3, 2, 1, 1),
(6, 4, 2, 1, 1),
(7, 2, 2, 0, 1),
(8, 3, 2, 0, 1),
(9, 4, 2, 0, 1),
(10, 2, 4, 3, 1),
(11, 3, 4, 3, 1),
(12, 4, 4, 3, 1),
(13, 2, 1, 1, 0),
(14, 3, 1, 1, 0),
(15, 4, 1, 2, 0),
(16, 2, 2, 2, 1),
(17, 3, 2, 5, 1),
(18, 4, 2, 1, 1),
(19, 2, 2, 2, 0),
(20, 3, 2, 4, 0),
(21, 4, 2, 1, 0),
(22, 2, 4, 3, 0),
(23, 3, 4, 3, 0),
(24, 4, 4, 2, 0),
(25, 2, 5, 5, 0),
(26, 3, 5, 5, 0),
(27, 4, 5, 5, 0),
(28, 2, 6, 4, 1),
(29, 3, 6, 4, 1),
(30, 4, 6, 4, 1),
(31, 2, 7, 3, 1),
(32, 3, 7, 3, 1),
(33, 4, 7, 3, 1),
(34, 2, 7, 3, 1),
(35, 3, 7, 3, 1),
(36, 4, 7, 5, 1),
(37, 2, 8, 1, 1),
(38, 3, 8, 7, 1),
(39, 4, 8, 8, 1),
(40, 2, 8, 1, 1),
(41, 3, 8, 7, 1),
(42, 4, 8, 9, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa`
--

CREATE TABLE `empresa` (
  `id` int(11) NOT NULL,
  `empresa` varchar(250) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empresa`
--

INSERT INTO `empresa` (`id`, `empresa`, `estado`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`) VALUES
(1, 'Efectiva SA', 1, 1, '2023-05-02 13:41:16.000000', NULL, '2023-05-02 13:41:21.000000', 1, '2023-05-02 13:41:21.000000', 1),
(2, 'Efectiva SA', 1, 1, '2023-05-02 13:41:32.000000', NULL, '2023-05-02 13:41:40.000000', 1, '2023-05-02 13:41:40.000000', 1),
(3, 'Efectiva SA', 1, 1, '2023-05-02 13:43:19.000000', 1, '2023-05-18 11:56:20.000000', NULL, NULL, 0),
(4, 'TesteoAA', 1, 1, '2023-05-07 13:02:32.000000', 1, '2023-05-07 13:07:29.000000', 1, '2023-05-07 13:07:29.000000', 1),
(5, 'TesteoAAA', 1, 1, '2023-05-07 18:12:48.000000', 1, '2023-05-07 18:13:23.000000', 1, '2023-05-07 18:13:23.000000', 1),
(6, 'TESTEOA', 1, 1, '2023-05-11 19:28:21.000000', 1, '2023-05-18 03:25:48.000000', NULL, NULL, 0),
(7, 'TESTEOB', 1, 1, '2023-05-17 23:51:50.000000', NULL, '2023-05-17 23:52:05.000000', 1, '2023-05-17 23:52:05.000000', 1),
(8, 'TESTEOB', 1, 1, '2023-05-17 23:54:04.000000', NULL, '2023-05-17 23:54:08.000000', 1, '2023-05-17 23:54:08.000000', 1),
(9, 'TESTEOB', 1, 1, '2023-05-17 23:55:47.000000', NULL, '2023-05-17 23:55:52.000000', 1, '2023-05-17 23:55:52.000000', 1),
(10, 'testeob', 1, 1, '2023-05-17 23:56:31.000000', NULL, '2023-05-17 23:56:37.000000', 1, '2023-05-17 23:56:37.000000', 1),
(11, 'TESTEOB', 1, 1, '2023-05-17 23:57:03.000000', NULL, '2023-05-17 23:57:07.000000', 1, '2023-05-17 23:57:07.000000', 1),
(12, 'TESTEOC', 1, 1, '2023-05-17 23:58:10.000000', NULL, '2023-05-17 23:58:13.000000', 1, '2023-05-17 23:58:13.000000', 1),
(13, 'TESTEOB', 1, 1, '2023-05-17 23:58:53.000000', NULL, '2023-05-17 23:58:57.000000', 1, '2023-05-17 23:58:57.000000', 1),
(14, 'TESTEOB', 1, 1, '2023-05-18 02:16:33.000000', NULL, '2023-05-18 02:16:55.000000', 1, '2023-05-18 02:16:55.000000', 1),
(15, 'TESTEOC', 1, 1, '2023-05-18 02:16:48.000000', NULL, '2023-05-18 02:16:51.000000', 1, '2023-05-18 02:16:51.000000', 1),
(16, 'TESTEOB', 1, 1, '2023-05-18 11:54:22.000000', NULL, '2023-05-18 12:01:08.000000', 1, '2023-05-18 12:01:08.000000', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `escenario_active`
--

CREATE TABLE `escenario_active` (
  `id` int(11) NOT NULL,
  `escenario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `escenario_active`
--

INSERT INTO `escenario_active` (`id`, `escenario`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado`
--

CREATE TABLE `estado` (
  `id` int(11) NOT NULL,
  `estado` varchar(150) DEFAULT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estado`
--

INSERT INTO `estado` (`id`, `estado`, `descripcion`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`) VALUES
(1, 'Por iniciar', 'Por iniciar', 1, '2023-05-03 00:00:00.000000', 1, '2023-05-03 00:00:00.000000', NULL, NULL, 0),
(2, 'En proceso', 'En proceso', 1, '2023-05-03 00:00:00.000000', NULL, NULL, NULL, NULL, 0),
(3, 'Culminadoo', 'Culminadoo', 1, '2023-05-08 00:00:00.000000', 1, '2023-05-08 01:23:14.000000', 1, '2023-05-08 01:23:14.000000', 1),
(4, 'Culminado', 'Culminado', 1, '2023-05-16 00:00:00.000000', NULL, NULL, NULL, NULL, 0),
(5, 'Nueva', 'Nueva', 1, '2023-05-18 00:00:00.000000', NULL, '2023-05-18 22:41:06.000000', 1, '2023-05-18 22:41:06.000000', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluacion_control2`
--

CREATE TABLE `evaluacion_control2` (
  `id` int(11) NOT NULL,
  `calificacion` varchar(100) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `evaluacion_control2`
--

INSERT INTO `evaluacion_control2` (`id`, `calificacion`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`) VALUES
(10, 'Moderado', 1, '2023-05-19 00:00:00.000000', 1, '2023-05-19 13:40:30.000000', NULL, NULL, 0),
(11, 'Débil', 1, '2023-05-19 00:00:00.000000', 1, '2023-05-19 13:40:50.000000', NULL, NULL, 0),
(12, 'Fuerte', 1, '2023-05-19 00:00:00.000000', NULL, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluacion_riesgo`
--

CREATE TABLE `evaluacion_riesgo` (
  `id` int(11) NOT NULL,
  `id_tipo_riesgo` int(11) DEFAULT NULL,
  `idempresa` int(11) DEFAULT NULL,
  `idarea` int(11) DEFAULT NULL,
  `idunidades` int(11) DEFAULT NULL,
  `idmacroproceso` int(11) DEFAULT NULL,
  `idproceso` int(11) DEFAULT NULL,
  `id_activo` int(11) DEFAULT NULL,
  `id_tipo_amenaza` int(11) DEFAULT NULL,
  `id_descripcion_amenaza` int(11) DEFAULT NULL,
  `id_tipo_vulnerabilidad` int(11) DEFAULT NULL,
  `id_descripcion_vulnerabilidad` int(11) DEFAULT NULL,
  `riesgo` longtext DEFAULT NULL,
  `valor_probabilidad` int(11) DEFAULT NULL,
  `probabilidad` varchar(150) DEFAULT NULL,
  `valor_impacto` varchar(150) DEFAULT NULL,
  `impacto` varchar(150) DEFAULT NULL,
  `valor` varchar(150) DEFAULT NULL,
  `id_control` int(11) DEFAULT NULL,
  `riesgo_controlado_probabilidad` varchar(150) DEFAULT NULL,
  `riesgo_controlado_impacto` varchar(150) DEFAULT NULL,
  `riesgo_controlado_valor` varchar(150) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0,
  `idprobabilidad_riesgo` int(11) DEFAULT NULL,
  `idimpacto_riesgo` int(11) DEFAULT NULL,
  `idnivel_riesgo` int(11) DEFAULT NULL,
  `idvaloracion_riesgo` int(11) DEFAULT NULL,
  `idinventario_clasificacion_activo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluacion_riesgos_controles`
--

CREATE TABLE `evaluacion_riesgos_controles` (
  `id` int(11) NOT NULL,
  `id_evaluacion_riesgo` int(11) DEFAULT NULL,
  `id_control` int(11) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deteled` datetime DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0,
  `idregistro_controles` int(11) DEFAULT NULL,
  `idevaluacion_riesgo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluacion_riesgo_historial`
--

CREATE TABLE `evaluacion_riesgo_historial` (
  `id` int(11) NOT NULL,
  `id_tipo_riesgo` int(11) DEFAULT NULL,
  `idempresa` int(11) DEFAULT NULL,
  `idarea` int(11) DEFAULT NULL,
  `idunidades` int(11) DEFAULT NULL,
  `idmacroproceso` int(11) DEFAULT NULL,
  `idproceso` int(11) DEFAULT NULL,
  `id_activo` int(11) DEFAULT NULL,
  `id_tipo_amenaza` int(11) DEFAULT NULL,
  `id_descripcion_amenaza` int(11) DEFAULT NULL,
  `id_tipo_vulnerabilidad` int(11) DEFAULT NULL,
  `id_descripcion_vulnerabilidad` int(11) DEFAULT NULL,
  `riesgo` varchar(150) DEFAULT NULL,
  `valor_probabilidad` int(11) DEFAULT NULL,
  `probabilidad` varchar(150) DEFAULT NULL,
  `valor_impacto` varchar(150) DEFAULT NULL,
  `impacto` varchar(150) DEFAULT NULL,
  `valor` varchar(150) DEFAULT NULL,
  `id_control` int(11) DEFAULT NULL,
  `riesgo_controlado_probabilidad` varchar(150) DEFAULT NULL,
  `riesgo_controlado_impacto` varchar(150) DEFAULT NULL,
  `riesgo_controlado_valor` varchar(150) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `impacto_riesgo`
--

CREATE TABLE `impacto_riesgo` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  `tipo_regla` varchar(150) DEFAULT NULL,
  `tipo_valor` varchar(150) DEFAULT NULL,
  `formula` varchar(150) DEFAULT NULL,
  `operador1` varchar(150) DEFAULT NULL,
  `valor1` int(11) DEFAULT NULL,
  `operador2` varchar(150) DEFAULT NULL,
  `valor2` int(11) DEFAULT NULL,
  `comentario` varchar(150) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `escenario` int(11) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `impacto_riesgo`
--

INSERT INTO `impacto_riesgo` (`id`, `descripcion`, `tipo_regla`, `tipo_valor`, `formula`, `operador1`, `valor1`, `operador2`, `valor2`, `comentario`, `estado`, `escenario`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`) VALUES
(1, 'IMPROBABLE', '2 Valores', 'Numero', NULL, '>=', 1000, '<=', 3000, 'IMPROBABLE', 2, 2, 1, '2023-05-07 18:23:19.000000', 1, '2023-05-08 18:52:48.000000', NULL, NULL, 0),
(2, 'PROBABLE', '2 Valores', 'Numero', NULL, '>', 3000, '<=', 10000, 'PROBABLE', 2, 2, 1, '2023-05-07 18:23:39.000000', 1, '2023-05-08 18:52:53.000000', NULL, NULL, 0),
(3, 'IMPACTO', '1 Valor', 'Numero', '', NULL, NULL, NULL, NULL, 'IMPACTO', 2, 1, 1, '2023-05-07 18:42:20.000000', NULL, '2023-05-07 18:52:49.000000', 1, '2023-05-07 18:52:48.000000', 1),
(4, 'IMPACTO', '1 Valor', 'Numero', '', NULL, NULL, NULL, NULL, 'IMPACTO', 2, 1, 1, '2023-05-07 18:53:48.000000', 1, '2023-05-08 10:52:13.000000', 1, '2023-05-08 10:52:12.000000', 1),
(5, 'IMPACTO', '1 Valor', 'Numero', '', NULL, NULL, NULL, NULL, 'IMPACTO', 2, 1, 1, '2023-05-08 10:54:53.000000', 1, '2023-05-08 11:46:03.000000', 1, '2023-05-08 11:46:03.000000', 1),
(6, 'IMPACTO', '1 Valor', 'Numero', '> 1000 IMPROBABLE > 8000 PROBABLE', NULL, NULL, NULL, NULL, 'IMPACTO', 2, 1, 1, '2023-05-08 11:47:07.000000', 1, '2023-05-08 18:58:20.000000', 1, '2023-05-08 18:58:20.000000', 1),
(7, 'IMPACTO', '1 Valor', 'Numero', '', NULL, NULL, NULL, NULL, 'IMPACTO', 1, 1, 1, '2023-05-09 18:05:21.000000', 1, '2023-05-18 20:59:44.000000', NULL, NULL, 0),
(8, 'muy allto', '2 Valores', 'Numero', NULL, '>', 1000, '<=', 2000, 'muy allto', 2, 2, 1, '2023-05-18 20:58:31.000000', NULL, '2023-05-18 20:59:32.000000', 1, '2023-05-18 20:59:32.000000', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario_clasificacion_activo`
--

CREATE TABLE `inventario_clasificacion_activo` (
  `id` int(11) NOT NULL,
  `idempresa` int(11) DEFAULT NULL,
  `idarea` int(11) DEFAULT NULL,
  `idunidades` int(11) DEFAULT NULL,
  `idmacroproceso` int(11) DEFAULT NULL,
  `idproceso` int(11) DEFAULT NULL,
  `activo` varchar(150) DEFAULT NULL,
  `desc_activo` varchar(500) DEFAULT NULL,
  `idtipo_activo` int(11) DEFAULT NULL,
  `idcategoria_activo` int(11) DEFAULT NULL,
  `idubicacion` int(11) DEFAULT NULL,
  `idpropietario` int(11) DEFAULT NULL,
  `idcustodio` int(11) DEFAULT NULL,
  `val_c` int(11) DEFAULT NULL,
  `val_i` int(11) DEFAULT NULL,
  `val_d` int(11) DEFAULT NULL,
  `idvalor` int(11) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `comentario` varchar(500) DEFAULT NULL,
  `observacion` varchar(200) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0,
  `estado_2` int(11) DEFAULT 1,
  `vals` text DEFAULT NULL,
  `idvaloracion_activo` int(11) DEFAULT NULL,
  `idclasificacion_informacion` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inventario_clasificacion_activo`
--

INSERT INTO `inventario_clasificacion_activo` (`id`, `idempresa`, `idarea`, `idunidades`, `idmacroproceso`, `idproceso`, `activo`, `desc_activo`, `idtipo_activo`, `idcategoria_activo`, `idubicacion`, `idpropietario`, `idcustodio`, `val_c`, `val_i`, `val_d`, `idvalor`, `estado`, `comentario`, `observacion`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`, `estado_2`, `vals`, `idvaloracion_activo`, `idclasificacion_informacion`) VALUES
(30, 3, 2, 1, 1, 1, 'ActivoA', 'ActivoA', 1, 1, 1, 1, 4, NULL, NULL, NULL, 1, 2, 'ActivoA', NULL, 1, '2023-05-19 14:00:53.000000', 1, '2023-05-19 14:05:37.000000', NULL, NULL, 0, 1, '[{\"idaspecto\":\"2\",\"aspecto\":\"Confidencialidad\",\"valoracion\":\"1\"},{\"idaspecto\":\"3\",\"aspecto\":\"Integridad\",\"valoracion\":\"1\"},{\"idaspecto\":\"4\",\"aspecto\":\"Disponibilidad\",\"valoracion\":\"2\"}]', 1, 1),
(31, 3, 2, 1, 1, 1, 'ActivoB', 'ActivoB', 1, 1, 1, 1, 4, NULL, NULL, NULL, 1, 2, 'ActivoB', NULL, 1, '2023-05-19 14:01:30.000000', 1, '2023-05-19 14:05:44.000000', NULL, NULL, 0, 1, '[{\"idaspecto\":\"2\",\"aspecto\":\"Confidencialidad\",\"valoracion\":\"1\"},{\"idaspecto\":\"3\",\"aspecto\":\"Integridad\",\"valoracion\":\"1\"},{\"idaspecto\":\"4\",\"aspecto\":\"Disponibilidad\",\"valoracion\":\"2\"}]', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario_clasificacion_activo_historial`
--

CREATE TABLE `inventario_clasificacion_activo_historial` (
  `id` int(11) NOT NULL,
  `id_ica` int(11) NOT NULL,
  `idempresa` int(11) DEFAULT NULL,
  `idarea` int(11) DEFAULT NULL,
  `idunidades` int(11) DEFAULT NULL,
  `idmacroproceso` int(11) DEFAULT NULL,
  `idproceso` int(11) DEFAULT NULL,
  `activo` varchar(150) DEFAULT NULL,
  `desc_activo` varchar(500) DEFAULT NULL,
  `idtipo_activo` int(11) DEFAULT NULL,
  `idcategoria_activo` int(11) DEFAULT NULL,
  `idubicacion` int(11) DEFAULT NULL,
  `idpropietario` int(11) DEFAULT NULL,
  `idcustodio` int(11) DEFAULT NULL,
  `val_c` int(11) DEFAULT NULL,
  `val_i` int(11) DEFAULT NULL,
  `val_d` int(11) DEFAULT NULL,
  `idvalor` int(11) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `comentario` varchar(500) DEFAULT NULL,
  `observacion` varchar(200) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0,
  `estado_2` int(11) DEFAULT 1,
  `vals` text DEFAULT NULL,
  `idclasificacion_informacion` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inventario_clasificacion_activo_historial`
--

INSERT INTO `inventario_clasificacion_activo_historial` (`id`, `id_ica`, `idempresa`, `idarea`, `idunidades`, `idmacroproceso`, `idproceso`, `activo`, `desc_activo`, `idtipo_activo`, `idcategoria_activo`, `idubicacion`, `idpropietario`, `idcustodio`, `val_c`, `val_i`, `val_d`, `idvalor`, `estado`, `comentario`, `observacion`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`, `estado_2`, `vals`, `idclasificacion_informacion`) VALUES
(1, 13, 3, 2, 1, 1, 1, 'AcitvoA', 'AcitvoA', 1, 1, 1, 1, 2, NULL, NULL, NULL, 1, 3, 'AcitvoA', NULL, 5, '2023-05-13 11:36:23.000000', NULL, NULL, NULL, NULL, 0, 1, '[{\"idaspecto\":\"2\",\"aspecto\":\"Confidencialidad\",\"valoracion\":\"1\"},{\"idaspecto\":\"3\",\"aspecto\":\"Integridad\",\"valoracion\":\"1\"},{\"idaspecto\":\"4\",\"aspecto\":\"Disponibilidad\",\"valoracion\":\"2\"}]', NULL),
(2, 13, 3, 2, 1, 1, 1, 'AcitvoA', 'AcitvoA', 1, 1, 1, 1, 2, NULL, NULL, NULL, 1, 4, 'AcitvoA', NULL, 5, '2023-05-13 11:37:26.000000', NULL, NULL, NULL, NULL, 0, 1, '[{\"idaspecto\":\"2\",\"aspecto\":\"Confidencialidad\",\"valoracion\":\"1\"},{\"idaspecto\":\"3\",\"aspecto\":\"Integridad\",\"valoracion\":\"1\"},{\"idaspecto\":\"4\",\"aspecto\":\"Disponibilidad\",\"valoracion\":\"2\"}]', NULL),
(3, 14, 3, 2, 1, 1, 1, 'ActivoA', 'ActivoA', 1, 1, 1, 1, 2, NULL, NULL, NULL, 1, 3, 'ActivoA', NULL, 5, '2023-05-16 17:46:17.000000', NULL, NULL, NULL, NULL, 0, 1, '[{\"idaspecto\":\"2\",\"aspecto\":\"Confidencialidad\",\"valoracion\":\"1\"},{\"idaspecto\":\"3\",\"aspecto\":\"Integridad\",\"valoracion\":\"1\"},{\"idaspecto\":\"4\",\"aspecto\":\"Disponibilidad\",\"valoracion\":\"2\"}]', NULL),
(4, 14, 3, 2, 1, 1, 1, 'ActivoA', 'ActivoA', 1, 1, 1, 1, 2, NULL, NULL, NULL, 1, 2, 'ActivoA', NULL, 1, '2023-05-16 17:47:27.000000', NULL, NULL, NULL, NULL, 0, 1, '[{\"idaspecto\":\"2\",\"aspecto\":\"Confidencialidad\",\"valoracion\":\"1\"},{\"idaspecto\":\"3\",\"aspecto\":\"Integridad\",\"valoracion\":\"1\"},{\"idaspecto\":\"4\",\"aspecto\":\"Disponibilidad\",\"valoracion\":\"2\"}]', NULL),
(5, 14, 3, 2, 1, 1, 1, 'ActivoA', 'ActivoA', 1, 1, 1, 1, 2, NULL, NULL, NULL, 1, 4, 'ActivoA', NULL, 5, '2023-05-16 17:48:21.000000', NULL, NULL, NULL, NULL, 0, 1, '[{\"idaspecto\":\"2\",\"aspecto\":\"Confidencialidad\",\"valoracion\":\"1\"},{\"idaspecto\":\"3\",\"aspecto\":\"Integridad\",\"valoracion\":\"1\"},{\"idaspecto\":\"4\",\"aspecto\":\"Disponibilidad\",\"valoracion\":\"2\"}]', NULL),
(6, 17, 3, 2, 1, 1, 1, 'ActivoAA', 'ActivoA', 1, 1, 1, 1, 2, NULL, NULL, NULL, 1, 4, 'ActivoA', NULL, 5, '2023-05-17 01:55:41.000000', NULL, NULL, NULL, NULL, 0, 1, '[{\"idaspecto\":\"2\",\"aspecto\":\"Confidencialidad\",\"valoracion\":\"1\"},{\"idaspecto\":\"3\",\"aspecto\":\"Integridad\",\"valoracion\":\"1\"},{\"idaspecto\":\"4\",\"aspecto\":\"Disponibilidad\",\"valoracion\":\"2\"}]', 1),
(7, 17, 3, 2, 1, 1, 1, 'ActivoAA', 'ActivoA', 1, 1, 1, 1, 2, NULL, NULL, NULL, 2, 2, 'ActivoA', NULL, 1, '2023-05-17 02:00:45.000000', NULL, NULL, NULL, NULL, 0, 1, '[{\"idaspecto\":\"2\",\"aspecto\":\"Confidencialidad\",\"valoracion\":\"2\"},{\"idaspecto\":\"3\",\"aspecto\":\"Integridad\",\"valoracion\":\"4\"},{\"idaspecto\":\"4\",\"aspecto\":\"Disponibilidad\",\"valoracion\":\"1\"}]', 1),
(8, 20, 3, 2, 1, 1, 1, 'ActivoC', 'ActivoC', 1, 1, 1, 1, 4, NULL, NULL, NULL, 1, 1, 'ActivoC', NULL, 1, '2023-05-18 22:57:11.000000', NULL, NULL, NULL, NULL, 0, 1, '[{\"idaspecto\":\"2\",\"aspecto\":\"Confidencialidad\",\"valoracion\":\"1\"},{\"idaspecto\":\"3\",\"aspecto\":\"Integridad\",\"valoracion\":\"1\"},{\"idaspecto\":\"4\",\"aspecto\":\"Disponibilidad\",\"valoracion\":\"2\"}]', 1),
(9, 21, 3, 2, 1, 1, 1, 'ActivoD', 'ActivoD', 1, 1, 1, 1, 4, NULL, NULL, NULL, 1, 2, 'ActivoD', NULL, 1, '2023-05-18 23:11:24.000000', NULL, NULL, NULL, NULL, 0, 1, '[{\"idaspecto\":\"2\",\"aspecto\":\"Confidencialidad\",\"valoracion\":\"1\"},{\"idaspecto\":\"3\",\"aspecto\":\"Integridad\",\"valoracion\":\"1\"},{\"idaspecto\":\"4\",\"aspecto\":\"Disponibilidad\",\"valoracion\":\"2\"}]', 1),
(10, 21, 3, 2, 1, 1, 1, 'ActivoD', 'ActivoD', 1, 1, 1, 1, 4, NULL, NULL, NULL, 1, 2, 'ActivoD', NULL, 1, '2023-05-18 23:12:02.000000', NULL, NULL, NULL, NULL, 0, 1, '[{\"idaspecto\":\"2\",\"aspecto\":\"Confidencialidad\",\"valoracion\":\"1\"},{\"idaspecto\":\"3\",\"aspecto\":\"Integridad\",\"valoracion\":\"1\"},{\"idaspecto\":\"4\",\"aspecto\":\"Disponibilidad\",\"valoracion\":\"2\"}]', 1),
(11, 22, 3, 2, 1, 1, 1, 'ACTIVOE', 'ACTIVOE', 1, 1, 1, 1, 4, NULL, NULL, NULL, 1, 0, 'ACTIVOE', NULL, 1, '2023-05-18 23:14:13.000000', NULL, NULL, NULL, NULL, 0, 1, '[{\"idaspecto\":\"2\",\"aspecto\":\"Confidencialidad\",\"valoracion\":\"1\"},{\"idaspecto\":\"3\",\"aspecto\":\"Integridad\",\"valoracion\":\"1\"},{\"idaspecto\":\"4\",\"aspecto\":\"Disponibilidad\",\"valoracion\":\"2\"}]', 1),
(12, 23, 3, 2, 1, 1, 1, 'ACTIVOF', 'ACTIVOF', 1, 1, 1, 1, 4, NULL, NULL, NULL, 1, 1, 'ACTIVOF', NULL, 1, '2023-05-18 23:18:12.000000', NULL, NULL, NULL, NULL, 0, 1, '[{\"idaspecto\":\"2\",\"aspecto\":\"Confidencialidad\",\"valoracion\":\"1\"},{\"idaspecto\":\"3\",\"aspecto\":\"Integridad\",\"valoracion\":\"1\"},{\"idaspecto\":\"4\",\"aspecto\":\"Disponibilidad\",\"valoracion\":\"2\"}]', 1),
(13, 18, 3, 2, 1, 1, 1, 'ActivoB', 'ActivoA', 1, 1, 1, 1, 2, NULL, NULL, NULL, 1, 4, 'ActivoA', NULL, 5, '2023-05-18 23:22:17.000000', NULL, NULL, NULL, NULL, 0, 1, '[{\"idaspecto\":\"2\",\"aspecto\":\"Confidencialidad\",\"valoracion\":\"1\"},{\"idaspecto\":\"3\",\"aspecto\":\"Integridad\",\"valoracion\":\"1\"},{\"idaspecto\":\"4\",\"aspecto\":\"Disponibilidad\",\"valoracion\":\"2\"}]', 1),
(14, 18, 3, 2, 1, 1, 1, 'ActivoB', 'ActivoA', 1, 1, 1, 1, 2, NULL, NULL, NULL, 1, 4, 'ActivoA', NULL, 5, '2023-05-18 23:23:00.000000', NULL, NULL, NULL, NULL, 0, 1, '[{\"idaspecto\":\"2\",\"aspecto\":\"Confidencialidad\",\"valoracion\":\"1\"},{\"idaspecto\":\"3\",\"aspecto\":\"Integridad\",\"valoracion\":\"1\"},{\"idaspecto\":\"4\",\"aspecto\":\"Disponibilidad\",\"valoracion\":\"2\"}]', 1),
(15, 18, 3, 2, 1, 1, 1, 'ActivoB', 'ActivoA', 1, 1, 1, 1, 2, NULL, NULL, NULL, 1, 4, 'ActivoA', NULL, 1, '2023-05-17 02:02:10.000000', NULL, NULL, NULL, NULL, 0, 1, '[{\"idaspecto\":\"2\",\"aspecto\":\"Confidencialidad\",\"valoracion\":\"1\"},{\"idaspecto\":\"3\",\"aspecto\":\"Integridad\",\"valoracion\":\"1\"},{\"idaspecto\":\"4\",\"aspecto\":\"Disponibilidad\",\"valoracion\":\"2\"}]', 1),
(16, 30, 3, 2, 1, 1, 1, 'ActivoA', 'ActivoA', 1, 1, 1, 1, 4, NULL, NULL, NULL, 1, 1, 'ActivoA', NULL, 1, '2023-05-19 14:00:53.000000', NULL, NULL, NULL, NULL, 0, 1, '[{\"idaspecto\":\"2\",\"aspecto\":\"Confidencialidad\",\"valoracion\":\"1\"},{\"idaspecto\":\"3\",\"aspecto\":\"Integridad\",\"valoracion\":\"1\"},{\"idaspecto\":\"4\",\"aspecto\":\"Disponibilidad\",\"valoracion\":\"2\"}]', 1),
(17, 31, 3, 2, 1, 1, 1, 'ActivoB', 'ActivoB', 1, 1, 1, 1, 4, NULL, NULL, NULL, 1, 1, 'ActivoB', NULL, 1, '2023-05-19 14:01:30.000000', NULL, NULL, NULL, NULL, 0, 1, '[{\"idaspecto\":\"2\",\"aspecto\":\"Confidencialidad\",\"valoracion\":\"1\"},{\"idaspecto\":\"3\",\"aspecto\":\"Integridad\",\"valoracion\":\"1\"},{\"idaspecto\":\"4\",\"aspecto\":\"Disponibilidad\",\"valoracion\":\"2\"}]', 1),
(18, 30, 3, 2, 1, 1, 1, 'ActivoA', 'ActivoA', 1, 1, 1, 1, 4, NULL, NULL, NULL, 1, 1, 'ActivoA', NULL, 1, '2023-05-19 14:00:53.000000', NULL, NULL, NULL, NULL, 0, 1, '[{\"idaspecto\":\"2\",\"aspecto\":\"Confidencialidad\",\"valoracion\":\"1\"},{\"idaspecto\":\"3\",\"aspecto\":\"Integridad\",\"valoracion\":\"1\"},{\"idaspecto\":\"4\",\"aspecto\":\"Disponibilidad\",\"valoracion\":\"2\"}]', 1),
(19, 31, 3, 2, 1, 1, 1, 'ActivoB', 'ActivoB', 1, 1, 1, 1, 4, NULL, NULL, NULL, 1, 1, 'ActivoB', NULL, 1, '2023-05-19 14:01:30.000000', NULL, NULL, NULL, NULL, 0, 1, '[{\"idaspecto\":\"2\",\"aspecto\":\"Confidencialidad\",\"valoracion\":\"1\"},{\"idaspecto\":\"3\",\"aspecto\":\"Integridad\",\"valoracion\":\"1\"},{\"idaspecto\":\"4\",\"aspecto\":\"Disponibilidad\",\"valoracion\":\"2\"}]', 1),
(20, 30, 3, 2, 1, 1, 1, 'ActivoA', 'ActivoA', 1, 1, 1, 1, 4, NULL, NULL, NULL, 1, 1, 'ActivoA', NULL, 1, '2023-05-19 14:00:53.000000', NULL, NULL, NULL, NULL, 0, 1, '[{\"idaspecto\":\"2\",\"aspecto\":\"Confidencialidad\",\"valoracion\":\"1\"},{\"idaspecto\":\"3\",\"aspecto\":\"Integridad\",\"valoracion\":\"1\"},{\"idaspecto\":\"4\",\"aspecto\":\"Disponibilidad\",\"valoracion\":\"2\"}]', 1),
(21, 31, 3, 2, 1, 1, 1, 'ActivoB', 'ActivoB', 1, 1, 1, 1, 4, NULL, NULL, NULL, 1, 1, 'ActivoB', NULL, 1, '2023-05-19 14:01:30.000000', NULL, NULL, NULL, NULL, 0, 1, '[{\"idaspecto\":\"2\",\"aspecto\":\"Confidencialidad\",\"valoracion\":\"1\"},{\"idaspecto\":\"3\",\"aspecto\":\"Integridad\",\"valoracion\":\"1\"},{\"idaspecto\":\"4\",\"aspecto\":\"Disponibilidad\",\"valoracion\":\"2\"}]', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log_acciones`
--

CREATE TABLE `log_acciones` (
  `id` int(11) NOT NULL,
  `terminal` varchar(500) DEFAULT NULL,
  `ip_addres` varchar(150) DEFAULT NULL,
  `u_ejecutor` int(11) DEFAULT NULL,
  `u_afectado` int(11) DEFAULT NULL,
  `accion` longtext DEFAULT NULL,
  `fecha` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `log_acciones`
--

INSERT INTO `log_acciones` (`id`, `terminal`, `ip_addres`, `u_ejecutor`, `u_afectado`, `accion`, `fecha`) VALUES
(1, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador ah realizado cambio de clave', '2023-05-01 20:50:12.000000'),
(2, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a iniciado sesión', '2023-05-01 20:50:22.000000'),
(3, 'Opera 97.0.0.0', '::1', 1, 2, 'El usuario administrador ah creado el usuario: testeo1 y se le asignó el perfil : ADMINISTRADOR', '2023-05-01 20:53:08.000000'),
(4, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a cerrado sesión correstamente desde el sistema', '2023-05-01 20:53:13.000000'),
(5, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a iniciado sesión', '2023-05-01 20:59:31.000000'),
(6, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a cerrado sesión correstamente desde el sistema', '2023-05-01 20:59:37.000000'),
(7, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a iniciado sesión', '2023-05-01 21:02:14.000000'),
(8, 'Opera 97.0.0.0', '::1', 1, 3, 'El usuario administrador ah creado el usuario: testeo1 y se le asignó el perfil : ADMINISTRADOR', '2023-05-01 21:02:46.000000'),
(9, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a cerrado sesión correstamente desde el sistema', '2023-05-01 21:02:51.000000'),
(10, '0', '0', 1, 0, 'El usuario: administrador a iniciado sesión', '2023-05-01 22:34:49.000000'),
(11, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a iniciado sesión', '2023-05-01 23:09:32.000000'),
(12, 'Opera 97.0.0.0', '::1', 1, 3, 'El usuario administrador a Desabilitado al usuario: testeo1', '2023-05-01 23:09:46.000000'),
(13, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a cerrado sesión correstamente desde el sistema', '2023-05-01 23:09:51.000000'),
(14, 'Opera 97.0.0.0', '::1', 3, 0, 'El usuario: testeo1 ah realizado cambio de clave', '2023-05-01 23:10:30.000000'),
(15, 'Opera 97.0.0.0', '::1', 3, 0, 'El usuario: testeo1 a iniciado sesión', '2023-05-01 23:10:49.000000'),
(16, 'Opera 97.0.0.0', '::1', 3, 0, 'El usuario: testeo1 a cerrado sesión correstamente desde el sistema', '2023-05-01 23:10:54.000000'),
(17, 'Opera 97.0.0.0', '::1', 3, 0, 'El usuario: testeo1 a iniciado sesión', '2023-05-01 23:11:02.000000'),
(18, 'Opera 97.0.0.0', '::1', 3, 0, 'El usuario: testeo1 a cerrado sesión correstamente desde el sistema', '2023-05-01 23:11:09.000000'),
(19, 'Opera 97.0.0.0', '::1', 3, 0, 'El usuario: testeo1 a iniciado sesión', '2023-05-01 23:11:21.000000'),
(20, 'Opera 97.0.0.0', '::1', 3, 0, 'El usuario: testeo1 a cerrado sesión correstamente desde el sistema', '2023-05-01 23:12:08.000000'),
(21, '0', '0', 3, 0, 'El usuario: testeo1 a iniciado sesión', '2023-05-01 23:12:19.000000'),
(22, '0', '0', 3, 0, 'El usuario: testeo1 a iniciado sesión', '2023-05-01 23:16:54.000000'),
(23, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a iniciado sesión', '2023-05-01 23:23:16.000000'),
(24, 'Opera 97.0.0.0', '::1', 1, 3, 'El usuario administrador a Desabilitado al usuario: testeo1', '2023-05-01 23:23:28.000000'),
(25, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a cerrado sesión correstamente desde el sistema', '2023-05-01 23:23:31.000000'),
(26, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a iniciado sesión', '2023-05-01 23:27:04.000000'),
(27, 'Opera 97.0.0.0', '::1', 1, 3, 'El usuario administrador a Desabilitado al usuario: testeo1', '2023-05-01 23:27:50.000000'),
(28, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a cerrado sesión correstamente desde el sistema', '2023-05-01 23:27:53.000000'),
(29, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a iniciado sesión', '2023-05-01 23:30:08.000000'),
(30, 'Opera 97.0.0.0', '::1', 1, 3, 'El usuario administrador ah modificado los datos del usuario: testeo1', '2023-05-01 23:36:54.000000'),
(31, 'Opera 97.0.0.0', '::1', 1, 3, 'El usuario administrador a Desabilitado al usuario: testeo1', '2023-05-01 23:37:28.000000'),
(32, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a cerrado sesión correstamente desde el sistema', '2023-05-01 23:37:36.000000'),
(33, 'Opera 97.0.0.0', '::1', 3, 0, 'El usuario: testeo1 a iniciado sesión', '2023-05-01 23:37:54.000000'),
(34, 'Opera 97.0.0.0', '::1', 3, 0, 'El usuario testeo1 ah creado el perfil : TESTEOA', '2023-05-02 00:02:34.000000'),
(35, 'Opera 97.0.0.0', '::1', 3, 0, 'El usuario testeo1 ah eliminado el perfil : TESTEOA', '2023-05-02 00:02:38.000000'),
(36, 'Opera 97.0.0.0', '::1', 3, 0, 'El usuario testeo1 ah eliminado el perfil : TESTEOA', '2023-05-02 00:02:43.000000'),
(37, 'Opera 97.0.0.0', '::1', 3, 0, 'El usuario: testeo1 a cerrado sesión correstamente desde el sistema', '2023-05-02 00:03:30.000000'),
(38, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a iniciado sesión', '2023-05-02 00:04:33.000000'),
(39, 'Opera 97.0.0.0', '::1', 1, 4, 'El usuario administrador ah creado el usuario: testeo2 y se le asignó el perfil : ADMINISTRADOR', '2023-05-02 00:19:04.000000'),
(40, 'Opera 97.0.0.0', '::1', 1, 4, 'El usuario administrador ah modificado los datos del usuario: testeo2', '2023-05-02 00:19:23.000000'),
(41, 'Opera 97.0.0.0', '::1', 1, 4, 'El usuario: administrador ah realizado cambio de clave al usuario: 4', '2023-05-02 00:19:42.000000'),
(42, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a cerrado sesión correstamente desde el sistema', '2023-05-02 00:19:46.000000'),
(43, 'Opera 97.0.0.0', '::1', 4, 0, 'El usuario: testeo2 a iniciado sesión', '2023-05-02 00:19:59.000000'),
(44, 'Opera 97.0.0.0', '::1', 4, 0, 'El usuario: testeo2 ah realizado cambio de clave', '2023-05-02 00:20:19.000000'),
(45, 'Opera 97.0.0.0', '::1', 4, 0, 'El usuario: testeo2 a cerrado sesión correstamente desde el sistema', '2023-05-02 00:20:28.000000'),
(46, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a iniciado sesión', '2023-05-02 00:21:06.000000'),
(47, 'Opera 97.0.0.0', '::1', 1, 4, 'El usuario: administrador ah realizado cambio de clave al usuario: 4', '2023-05-02 00:21:41.000000'),
(48, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a cerrado sesión correstamente desde el sistema', '2023-05-02 00:21:46.000000'),
(49, 'Opera 97.0.0.0', '::1', 4, 0, 'El usuario: testeo2 a iniciado sesión', '2023-05-02 00:21:59.000000'),
(50, 'Opera 97.0.0.0', '::1', 4, 0, 'El usuario: testeo2 ah realizado cambio de clave', '2023-05-02 00:22:31.000000'),
(51, 'Opera 97.0.0.0', '::1', 4, 0, 'El usuario: testeo2 a cerrado sesión correstamente desde el sistema', '2023-05-02 00:22:38.000000'),
(52, 'Opera 97.0.0.0', '::1', 4, 0, 'El usuario: testeo2 a iniciado sesión', '2023-05-02 00:23:02.000000'),
(53, 'Opera 97.0.0.0', '::1', 4, 0, 'El usuario: testeo2 a cerrado sesión correstamente desde el sistema', '2023-05-02 00:23:06.000000'),
(54, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a iniciado sesión', '2023-05-02 02:51:22.000000'),
(55, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a cerrado sesión correstamente desde el sistema', '2023-05-02 03:16:03.000000'),
(56, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a iniciado sesión', '2023-05-02 10:39:44.000000'),
(57, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador ah realizado cambio de clave', '2023-05-02 10:40:49.000000'),
(58, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador ah realizado cambio de clave', '2023-05-02 10:44:01.000000'),
(59, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a cerrado sesión correstamente desde el sistema', '2023-05-02 12:05:58.000000'),
(60, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a iniciado sesión', '2023-05-02 13:08:23.000000'),
(61, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a cerrado sesión correstamente desde el sistema', '2023-05-02 14:19:51.000000'),
(62, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a iniciado sesión', '2023-05-02 14:36:52.000000'),
(63, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador ah creado el perfil : PRUEBA', '2023-05-02 14:37:38.000000'),
(64, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador ah eliminado el perfil : PRUEBA', '2023-05-02 14:46:56.000000'),
(65, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a cerrado sesión correstamente desde el sistema', '2023-05-02 15:00:47.000000'),
(66, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a iniciado sesión', '2023-05-02 17:43:16.000000'),
(67, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a cerrado sesión correstamente desde el sistema', '2023-05-02 18:20:58.000000'),
(68, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a iniciado sesión', '2023-05-03 11:08:11.000000'),
(69, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a cerrado sesión correstamente desde el sistema', '2023-05-03 11:11:04.000000'),
(70, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a iniciado sesión', '2023-05-03 11:11:14.000000'),
(71, 'Opera 97.0.0.0', '::1', 1, 5, 'El usuario administrador ah creado el usuario: testeo1 y se le asignó el perfil : ADMINISTRADOR', '2023-05-03 11:12:03.000000'),
(72, 'Opera 97.0.0.0', '::1', 1, 1, 'El usuario administrador ah modificado los datos del usuario: administrador', '2023-05-03 11:12:21.000000'),
(73, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a cerrado sesión correstamente desde el sistema', '2023-05-03 11:12:26.000000'),
(74, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a iniciado sesión', '2023-05-03 11:35:09.000000'),
(75, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a cerrado sesión correstamente desde el sistema', '2023-05-03 12:08:52.000000'),
(76, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a iniciado sesión', '2023-05-03 16:58:48.000000'),
(77, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a cerrado sesión correstamente desde el sistema', '2023-05-03 17:10:19.000000'),
(78, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a iniciado sesión', '2023-05-03 19:05:27.000000'),
(79, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a iniciado sesión', '2023-05-03 19:45:35.000000'),
(80, 'Opera 97.0.0.0', '::1', 1, 5, 'El usuario administrador ah modificado los datos del usuario: testeo1', '2023-05-03 19:46:12.000000'),
(81, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a iniciado sesión', '2023-05-04 13:48:54.000000'),
(82, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a cerrado sesión correstamente desde el sistema', '2023-05-04 13:50:14.000000'),
(83, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a iniciado sesión', '2023-05-04 15:38:33.000000'),
(84, 'Opera 97.0.0.0', '::1', 1, 5, 'El usuario administrador a Habilitado al usuario: testeo1', '2023-05-04 16:10:08.000000'),
(85, 'Opera 97.0.0.0', '::1', 1, 1, 'El usuario administrador a Desabilitado al usuario: administrador', '2023-05-04 16:20:48.000000'),
(86, 'Opera 97.0.0.0', '::1', 1, 1, 'El usuario administrador ah modificado los datos del usuario: administrador', '2023-05-04 16:27:36.000000'),
(87, 'Opera 97.0.0.0', '::1', 1, 5, 'El usuario administrador ah modificado los datos del usuario: testeo1', '2023-05-04 16:29:09.000000'),
(88, 'Opera 97.0.0.0', '::1', 1, 1, 'El usuario administrador ah modificado los datos del usuario: administrador', '2023-05-04 16:33:06.000000'),
(89, 'Opera 97.0.0.0', '::1', 1, 1, 'El usuario administrador ah modificado los datos del usuario: administrador', '2023-05-04 16:35:45.000000'),
(90, 'Opera 97.0.0.0', '::1', 1, 1, 'El usuario administrador ah modificado los datos del usuario: administrador', '2023-05-04 16:36:07.000000'),
(91, 'Opera 97.0.0.0', '::1', 1, 6, 'El usuario administrador ah creado el usuario: testeo2 y se le asignó el perfil : ADMINISTRADOR', '2023-05-04 16:40:04.000000'),
(92, 'Opera 97.0.0.0', '::1', 1, 6, 'El usuario administrador ah modificado los datos del usuario: testeo2', '2023-05-04 16:40:55.000000'),
(93, 'Opera 97.0.0.0', '::1', 1, 1, 'El usuario administrador ah modificado los datos del usuario: administrador', '2023-05-04 17:06:48.000000'),
(94, 'Opera 97.0.0.0', '::1', 1, 7, 'El usuario administrador ah creado el usuario: testeo2 y se le asignó el perfil : ADMINISTRADOR', '2023-05-04 17:28:29.000000'),
(95, 'Opera 97.0.0.0', '::1', 1, 7, 'El usuario administrador ah eliminado al usuario : testeo2', '2023-05-04 17:28:33.000000'),
(96, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a cerrado sesión correstamente desde el sistema', '2023-05-04 17:52:10.000000'),
(97, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a iniciado sesión', '2023-05-05 08:32:29.000000'),
(98, 'Opera 97.0.0.0', '::1', 1, 5, 'El usuario administrador ah modificado los datos del usuario: testeo1', '2023-05-05 08:33:06.000000'),
(99, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a cerrado sesión correstamente desde el sistema', '2023-05-05 10:01:02.000000'),
(100, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a iniciado sesión', '2023-05-05 10:03:45.000000'),
(101, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Desactivo al perfil:ADMINISTRADOR : Eliminar en  opcion Accesos', '2023-05-05 10:29:25.000000'),
(102, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:ADMINISTRADOR : Eliminar en  opcion Accesos', '2023-05-05 10:29:59.000000'),
(103, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a cerrado sesión correstamente desde el sistema', '2023-05-05 10:54:59.000000'),
(104, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a iniciado sesión', '2023-05-05 10:59:40.000000'),
(105, 'Opera 97.0.0.0', '::1', 1, 1, 'El usuario administrador ah modificado los datos del usuario: administrador', '2023-05-05 11:00:18.000000'),
(106, 'Opera 97.0.0.0', '::1', 1, 5, 'El usuario administrador a Desabilitado al usuario: testeo1', '2023-05-05 11:00:33.000000'),
(107, 'Opera 97.0.0.0', '::1', 1, 5, 'El usuario administrador a Habilitado al usuario: testeo1', '2023-05-05 11:02:28.000000'),
(108, 'Opera 97.0.0.0', '::1', 1, 5, 'El usuario administrador a Desabilitado al usuario: testeo1', '2023-05-05 11:02:40.000000'),
(109, 'Opera 97.0.0.0', '::1', 1, 5, 'El usuario administrador a Habilitado al usuario: testeo1', '2023-05-05 11:02:52.000000'),
(110, 'Opera 97.0.0.0', '::1', 1, 5, 'El usuario administrador a Desabilitado al usuario: testeo1', '2023-05-05 11:02:58.000000'),
(111, 'Opera 97.0.0.0', '::1', 1, 5, 'El usuario administrador a Habilitado al usuario: testeo1', '2023-05-05 11:03:01.000000'),
(112, 'Opera 97.0.0.0', '::1', 1, 5, 'El usuario administrador a Desabilitado al usuario: testeo1', '2023-05-05 11:03:06.000000'),
(113, 'Opera 97.0.0.0', '::1', 1, 5, 'El usuario administrador a Habilitado al usuario: testeo1', '2023-05-05 11:06:02.000000'),
(114, 'Opera 97.0.0.0', '::1', 1, 5, 'El usuario administrador a Desabilitado al usuario: testeo1', '2023-05-05 11:06:12.000000'),
(115, 'Opera 97.0.0.0', '::1', 1, 5, 'El usuario administrador a Habilitado al usuario: testeo1', '2023-05-05 11:07:08.000000'),
(116, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a cerrado sesión correstamente desde el sistema', '2023-05-05 13:43:58.000000'),
(117, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a iniciado sesión', '2023-05-05 14:20:53.000000'),
(118, 'Opera 97.0.0.0', '::1', 1, 5, 'El usuario administrador ah modificado los datos del usuario: testeo1', '2023-05-05 14:22:36.000000'),
(119, 'Opera 97.0.0.0', '::1', 1, 1, 'El usuario administrador ah modificado los datos del usuario: administrador', '2023-05-05 14:23:50.000000'),
(120, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a cerrado sesión correstamente desde el sistema', '2023-05-05 14:31:47.000000'),
(121, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador a iniciado sesión', '2023-05-05 14:31:52.000000'),
(122, 'Opera 97.0.0.0', '::1', 1, 5, 'El usuario administrador a Desbloqueado al usuario: testeo1', '2023-05-05 16:19:32.000000'),
(123, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Desactivo al perfil:ADMINISTRADOR : Eliminar en  opcion Usuarios', '2023-05-05 16:20:21.000000'),
(124, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador ah modificado el perfil : ADMINISTRADORB', '2023-05-07 15:06:16.000000'),
(125, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador ah modificado el perfil : ADMINISTRADORB', '2023-05-07 15:07:08.000000'),
(126, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador ah modificado el perfil : ADMINISTRADORB', '2023-05-07 15:07:27.000000'),
(127, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador ah creado el perfil : TESTEOA', '2023-05-07 15:09:28.000000'),
(128, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador ah eliminado el perfil : TESTEOA', '2023-05-07 15:11:11.000000'),
(129, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador ah modificado el perfil : ADMINISTRADOR', '2023-05-07 15:11:18.000000'),
(130, 'Opera 97.0.0.0', '::1', 1, 8, 'El usuario administrador ah creado el usuario: Testeo3 y se le asignó el perfil : ADMINISTRADOR', '2023-05-07 18:04:58.000000'),
(131, 'Opera 97.0.0.0', '::1', 1, 8, 'El usuario administrador ah modificado los datos del usuario: Testeo3', '2023-05-07 18:07:20.000000'),
(132, 'Opera 97.0.0.0', '::1', 1, 8, 'El usuario administrador a Bloqueado al usuario: Testeo3', '2023-05-07 18:07:26.000000'),
(133, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador ah creado el perfil : TESTEO', '2023-05-07 18:09:03.000000'),
(134, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador ah modificado el perfil : TESTEOA', '2023-05-07 18:09:11.000000'),
(135, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:TESTEOA : Ver en opcion Accesos', '2023-05-07 18:09:21.000000'),
(136, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:TESTEOA : Crear en opcion Accesos', '2023-05-07 18:09:23.000000'),
(137, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:TESTEOA : Editar en opcion Accesos', '2023-05-07 18:09:24.000000'),
(138, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:TESTEOA : Eliminar en  opcion Accesos', '2023-05-07 18:09:26.000000'),
(139, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:TESTEOA : Ver en opcion Usuarios', '2023-05-07 18:09:29.000000'),
(140, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:TESTEOA : Crear en opcion Usuarios', '2023-05-07 18:09:30.000000'),
(141, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:TESTEOA : Editar en opcion Usuarios', '2023-05-07 18:09:32.000000'),
(142, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:TESTEOA : Eliminar en  opcion Usuarios', '2023-05-07 18:09:33.000000'),
(143, 'Opera 97.0.0.0', '::1', 1, 8, 'El usuario administrador a Desbloqueado al usuario: Testeo3', '2023-05-07 18:09:43.000000'),
(144, 'Opera 97.0.0.0', '::1', 1, 8, 'El usuario administrador ah modificado los datos del usuario: Testeo3, Se modifico el perfil ADMINISTRADOR por TESTEOA', '2023-05-07 18:09:56.000000'),
(145, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador ah creado el perfil : TESTEOB', '2023-05-07 18:10:16.000000'),
(146, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador ah eliminado el perfil : TESTEOB', '2023-05-07 18:10:25.000000'),
(147, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:ADMINISTRADOR : Eliminar en  opcion Usuarios', '2023-05-08 02:14:20.000000'),
(148, 'Opera 97.0.0.0', '::1', 1, 5, 'El usuario administrador a Desbloqueado al usuario: testeo1', '2023-05-08 02:14:26.000000'),
(149, 'Opera 97.0.0.0', '::1', 1, 1, 'El usuario administrador ah modificado los datos del usuario: administrador', '2023-05-09 17:00:50.000000'),
(150, 'Opera 97.0.0.0', '::1', 1, 5, 'El usuario administrador ah modificado los datos del usuario: testeo1', '2023-05-09 17:01:07.000000'),
(151, 'Opera 97.0.0.0', '::1', 1, 5, 'El usuario administrador ah modificado los datos del usuario: testeo1, Se modifico el perfil ADMINISTRADOR por TESTEOA', '2023-05-09 17:01:26.000000'),
(152, 'Opera 97.0.0.0', '::1', 1, 5, 'El usuario: administrador ah realizado cambio de clave al usuario: 5', '2023-05-09 17:01:47.000000'),
(153, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:TESTEOA : Ver en opcion Evaluación de Riesgos de Seguridad en Procesos de Negocio', '2023-05-09 18:10:15.000000'),
(154, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:TESTEOA : Crear en opcion Evaluación de Riesgos de Seguridad en Procesos de Negocio', '2023-05-09 18:10:16.000000'),
(155, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:TESTEOA : Editar en opcion Evaluación de Riesgos de Seguridad en Procesos de Negocio', '2023-05-09 18:10:18.000000'),
(156, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:TESTEOA : Eliminar en  opcion Evaluación de Riesgos de Seguridad en Procesos de Negocio', '2023-05-09 18:10:19.000000'),
(157, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:TESTEOA : Ver en opcion Inventario y Clasificaci+on de Activos', '2023-05-09 18:10:21.000000'),
(158, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:TESTEOA : Ver en opcion Evaluación de Riesgos SI-C', '2023-05-09 18:10:21.000000'),
(159, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:TESTEOA : Ver en opcion Registro de Controles', '2023-05-09 18:10:24.000000'),
(160, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:TESTEOA : Ver en opcion Registro de Plan de Accion', '2023-05-09 18:10:24.000000'),
(161, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:TESTEOA : Crear en opcion Registro de Plan de Accion', '2023-05-09 18:10:27.000000'),
(162, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:TESTEOA : Crear en opcion Registro de Controles', '2023-05-09 18:10:27.000000'),
(163, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:TESTEOA : Crear en opcion Inventario y Clasificaci+on de Activos', '2023-05-09 18:10:29.000000'),
(164, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:TESTEOA : Crear en opcion Evaluación de Riesgos SI-C', '2023-05-09 18:10:30.000000'),
(165, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:TESTEOA : Editar en opcion Inventario y Clasificaci+on de Activos', '2023-05-09 18:10:31.000000'),
(166, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:TESTEOA : Editar en opcion Evaluación de Riesgos SI-C', '2023-05-09 18:10:33.000000'),
(167, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:TESTEOA : Editar en opcion Registro de Plan de Accion', '2023-05-09 18:10:35.000000'),
(168, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:TESTEOA : Editar en opcion Registro de Controles', '2023-05-09 18:10:36.000000'),
(169, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:TESTEOA : Eliminar en  opcion Inventario y Clasificaci+on de Activos', '2023-05-09 18:10:38.000000'),
(170, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:TESTEOA : Eliminar en  opcion Evaluación de Riesgos SI-C', '2023-05-09 18:10:38.000000'),
(171, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:TESTEOA : Eliminar en  opcion Registro de Controles', '2023-05-09 18:10:39.000000'),
(172, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador Activo al perfil:TESTEOA : Eliminar en  opcion Registro de Plan de Accion', '2023-05-09 18:10:41.000000'),
(173, 'Opera 97.0.0.0', '::1', 1, 9, 'El usuario administrador ah creado el usuario: aisa123 y se le asignó el perfil : TESTEOA', '2023-05-10 18:46:33.000000'),
(174, 'Opera 97.0.0.0', '::1', 1, 1, 'El usuario administrador ah modificado los datos del usuario: administrador', '2023-05-10 18:46:46.000000'),
(175, 'Opera 97.0.0.0', '::1', 1, 5, 'El usuario administrador ah modificado los datos del usuario: testeo1', '2023-05-10 18:47:14.000000'),
(176, 'Opera 97.0.0.0', '::1', 1, 416, 'El usuario: administrador ah realizado cambio de clave al usuario: 416ecffcb8669ce52cf019ae97790160a02e7b24406549fa0b6a1ecd0734407cc0a2abc23c1738d90bf', '2023-05-11 03:18:29.000000'),
(177, 'Opera 97.0.0.0', '::1', 1, 4761, 'El usuario: administrador ah realizado cambio de clave al usuario: 4761db38878050b57e00e743fbc070bbb02f1d8941f7b6f389cb62f2702e4da5b37de3826e8493e10d1', '2023-05-11 03:19:21.000000'),
(178, 'Opera 97.0.0.0', '::1', 1, 1, 'El usuario: administrador ah realizado cambio de clave al usuario: 1', '2023-05-11 03:25:09.000000'),
(179, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario: administrador ah realizado cambio de clave', '2023-05-11 03:26:30.000000'),
(180, 'Opera 97.0.0.0', '::1', 1, 5, 'El usuario: administrador realizó cambio de clave al usuario: testeo1', '2023-05-11 11:25:21.000000'),
(181, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador asignó al perfil:TESTEOA : Ver en opción Perfiles', '2023-05-11 11:34:34.000000'),
(182, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador asignó al perfil:TESTEOA : Crear en opción Perfiles', '2023-05-11 11:34:35.000000'),
(183, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador asignó al perfil:TESTEOA : Editar en opción Perfiles', '2023-05-11 11:34:37.000000'),
(184, 'Opera 97.0.0.0', '::1', 1, 0, 'El usuario administrador asignó al perfil:TESTEOA : Eliminar en opción Perfiles', '2023-05-11 11:34:37.000000'),
(185, 'Opera 97.0.0.0', '::1', 1, 5, 'El usuario administrador modificó los datos del usuario: testeo1, Se cambió el perfil TESTEOA por el siguiente ADMINISTRADOR', '2023-05-11 15:57:48.000000'),
(186, 'Opera 97.0.0.0', '::1', 1, 8, 'El usuario: administrador realizó cambio de clave al usuario: Testeo3', '2023-05-11 15:59:09.000000'),
(187, 'Opera 97.0.0.0', '::1', 1, 5, 'El usuario administrador modificó los datos del usuario: testeo1, Se cambió el perfil ADMINISTRADOR por el siguiente TESTEOA', '2023-05-11 18:18:25.000000'),
(188, 'Opera 97.0.0.0', '::1', 1, 1, 'El usuario administrador modificó los datos del usuario: administrador', '2023-05-11 19:27:48.000000'),
(189, 'Opera 97.0.0.0', '::1', 1, 1, 'El usuario administrador modificó los datos del usuario: administrador', '2023-05-11 19:29:07.000000'),
(190, 'Opera 97.0.0.0', '::1', 1, 1, 'El usuario administrador modificó los datos del usuario: administrador', '2023-05-12 01:55:03.000000'),
(191, 'Opera 97.0.0.0', '::1', 1, 1, 'El usuario administrador modificó los datos del usuario: administrador', '2023-05-12 02:52:20.000000'),
(192, 'Opera 97.0.0.0', '::1', 1, 1, 'El usuario administrador modificó los datos del usuario: administrador', '2023-05-12 02:52:49.000000'),
(193, 'Opera 97.0.0.0', '::1', 1, 10, 'El usuario administrador creó el usuario: testeo5 y asignó el perfil : ADMINISTRADOR', '2023-05-12 10:19:40.000000'),
(194, 'Opera 97.0.0.0', '::1', 10, 0, 'El usuario: testeo5 realizó cambio de clave', '2023-05-12 10:20:56.000000'),
(195, 'Opera 97.0.0.0', '::1', 1, 10, 'El usuario administrador Desbloqueó al usuario: testeo5', '2023-05-12 13:51:21.000000'),
(196, 'Opera 97.0.0.0', '::1', 1, 10, 'El usuario administrador eliminó al usuario : testeo5', '2023-05-12 13:52:35.000000'),
(197, 'Opera 97.0.0.0', '::1', 1, 1, 'El usuario administrador modificó los datos del usuario: administrador', '2023-05-12 16:20:39.000000'),
(198, 'Opera 97.0.0.0', '::1', 1, 1, 'El usuario administrador modificó los datos del usuario: administrador', '2023-05-12 16:21:24.000000'),
(199, 'Opera 97.0.0.0', '::1', 1, 9, 'El usuario administrador modificó los datos del usuario: aisa123', '2023-05-12 23:59:20.000000'),
(200, 'Opera 97.0.0.0', '::1', 1, 5, 'El usuario: administrador realizó cambio de clave al usuario: testeo1', '2023-05-13 11:35:40.000000'),
(201, 'Opera 98.0.0.0', '::1', 1, 5, 'El usuario administrador modificó los datos del usuario: testeo1', '2023-05-16 17:42:42.000000'),
(202, 'Opera 98.0.0.0', '::1', 1, 9, 'El usuario administrador modificó los datos del usuario: aisa123', '2023-05-16 17:43:05.000000'),
(203, 'Opera 98.0.0.0', '::1', 1, 9, 'El usuario administrador modificó los datos del usuario: aisa123', '2023-05-17 01:23:20.000000'),
(204, 'Opera 98.0.0.0', '::1', 1, 5, 'El usuario administrador modificó los datos del usuario: testeo1', '2023-05-17 01:23:30.000000'),
(205, 'Opera 98.0.0.0', '::1', 1, 1, 'El usuario: administrador realizó cambio de clave al usuario: administrador', '2023-05-17 10:08:17.000000'),
(206, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario: administrador realizó cambio de clave', '2023-05-17 21:28:38.000000'),
(207, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario: administrador realizó cambio de clave', '2023-05-17 21:34:59.000000'),
(208, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario: administrador realizó cambio de clave', '2023-05-17 21:35:38.000000'),
(209, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador creó el perfil : TESTEOB', '2023-05-17 22:36:00.000000'),
(210, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador creó el perfil : TESTEOA', '2023-05-17 22:36:13.000000'),
(211, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador creó el perfil : TESTEOA', '2023-05-17 22:37:07.000000'),
(212, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador creó el perfil : TESTEOA', '2023-05-17 22:39:17.000000'),
(213, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador eliminó el perfil : TESTEOA', '2023-05-17 22:41:35.000000'),
(214, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador eliminó el perfil : TESTEOA', '2023-05-17 22:41:40.000000'),
(215, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador eliminó el perfil : TESTEOA', '2023-05-17 22:41:44.000000'),
(216, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador creó el perfil : TESTEOC', '2023-05-17 22:47:36.000000'),
(217, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador modifcó el perfil : TESTEOCC', '2023-05-17 22:48:16.000000'),
(218, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador eliminó el perfil : TESTEOB', '2023-05-17 22:48:25.000000'),
(219, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador asignó al perfil:TESTEOCC : Ver en opción Accesos', '2023-05-17 22:48:36.000000'),
(220, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador asignó al perfil:TESTEOCC : Crear en opción Accesos', '2023-05-17 22:49:32.000000'),
(221, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador asignó al perfil:TESTEOCC : Editar en opción Accesos', '2023-05-17 22:49:34.000000'),
(222, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador asignó al perfil:TESTEOCC : Eliminar en opción Accesos', '2023-05-17 22:49:36.000000'),
(223, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador revocó al perfil:TESTEOCC : Eliminar en opción Accesos', '2023-05-17 22:49:39.000000'),
(224, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador asignó al perfil:TESTEOCC : Eliminar en opción Accesos', '2023-05-17 22:49:43.000000'),
(225, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador asignó al perfil:TESTEOCC : Ver en opción Usuarios', '2023-05-17 22:49:46.000000'),
(226, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador asignó al perfil:TESTEOCC : Crear en opción Usuarios', '2023-05-17 22:49:48.000000'),
(227, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador asignó al perfil:TESTEOCC : Editar en opción Usuarios', '2023-05-17 22:49:49.000000'),
(228, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador asignó al perfil:TESTEOCC : Eliminar en opción Usuarios', '2023-05-17 22:49:51.000000'),
(229, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador asignó al perfil:TESTEOCC : Ver en opción Config. Contraseña', '2023-05-17 22:49:53.000000'),
(230, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador eliminó el perfil : TESTEOCC', '2023-05-17 22:50:07.000000'),
(231, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador creó el perfil : TESTEOB', '2023-05-17 22:53:37.000000'),
(232, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador modifcó el perfil : TESTEOBB', '2023-05-17 22:53:55.000000'),
(233, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador eliminó el perfil : TESTEOBB', '2023-05-17 22:54:01.000000'),
(234, 'Opera 98.0.0.0', '::1', 1, 1, 'El usuario administrador modificó los datos del usuario: administrador', '2023-05-17 22:55:33.000000'),
(235, 'Opera 98.0.0.0', '::1', 1, 1, 'El usuario administrador modificó los datos del usuario: administrador', '2023-05-17 22:55:52.000000'),
(236, 'Opera 98.0.0.0', '::1', 1, 1, 'El usuario administrador modificó los datos del usuario: administrador', '2023-05-17 22:56:22.000000'),
(237, 'Opera 98.0.0.0', '::1', 1, 1, 'El usuario administrador modificó los datos del usuario: administrador', '2023-05-17 23:15:03.000000'),
(238, 'Opera 98.0.0.0', '::1', 1, 1, 'El usuario administrador modificó los datos del usuario: administrador', '2023-05-17 23:15:24.000000'),
(239, 'Opera 98.0.0.0', '::1', 1, 11, 'El usuario administrador creó el usuario: testeo6 y asignó el perfil : ADMINISTRADOR', '2023-05-17 23:17:39.000000'),
(240, 'Opera 98.0.0.0', '::1', 1, 11, 'El usuario administrador modificó los datos del usuario: testeo6', '2023-05-17 23:18:30.000000'),
(241, 'Opera 98.0.0.0', '::1', 1, 11, 'El usuario administrador Bloqueó al usuario: testeo6', '2023-05-17 23:18:39.000000'),
(242, 'Opera 98.0.0.0', '::1', 1, 11, 'El usuario administrador Desbloqueó al usuario: testeo6', '2023-05-17 23:19:09.000000'),
(243, 'Opera 98.0.0.0', '::1', 1, 11, 'El usuario administrador eliminó al usuario : testeo6', '2023-05-17 23:19:19.000000'),
(244, 'Opera 98.0.0.0', '::1', 1, 9, 'El usuario administrador eliminó al usuario : aisa123', '2023-05-17 23:20:41.000000'),
(245, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador creó el perfil : TESTEOAA', '2023-05-17 23:21:55.000000'),
(246, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador modifcó el perfil : TESTEOB', '2023-05-17 23:22:08.000000'),
(247, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador asignó al perfil:TESTEOB : Ver en opción Accesos', '2023-05-17 23:22:18.000000'),
(248, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador asignó al perfil:TESTEOB : Crear en opción Accesos', '2023-05-17 23:22:20.000000'),
(249, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador asignó al perfil:TESTEOB : Editar en opción Accesos', '2023-05-17 23:22:23.000000'),
(250, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador revocó al perfil:TESTEOB : Editar en opción Accesos', '2023-05-17 23:22:25.000000'),
(251, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador asignó al perfil:TESTEOB : Editar en opción Accesos', '2023-05-17 23:22:27.000000'),
(252, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador asignó al perfil:TESTEOB : Eliminar en opción Accesos', '2023-05-17 23:22:29.000000'),
(253, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador asignó al perfil:TESTEOB : Ver en opción Usuarios', '2023-05-17 23:22:31.000000'),
(254, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador revocó al perfil:TESTEOB : Crear en opción Usuarios', '2023-05-17 23:22:34.000000'),
(255, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador asignó al perfil:TESTEOB : Crear en opción Usuarios', '2023-05-17 23:22:36.000000'),
(256, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador asignó al perfil:TESTEOB : Editar en opción Usuarios', '2023-05-17 23:22:38.000000'),
(257, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador asignó al perfil:TESTEOB : Eliminar en opción Usuarios', '2023-05-17 23:22:50.000000'),
(258, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario administrador eliminó el perfil : TESTEOB', '2023-05-17 23:23:00.000000'),
(259, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario: administrador realizó cambio de clave', '2023-05-18 01:31:12.000000'),
(260, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario: administrador realizó cambio de clave', '2023-05-18 02:58:47.000000'),
(261, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario: administrador realizó cambio de clave', '2023-05-18 03:02:44.000000'),
(262, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario: administrador realizó cambio de clave', '2023-05-18 03:03:46.000000'),
(263, 'Opera 98.0.0.0', '::1', 1, 0, 'El usuario: administrador realizó cambio de clave', '2023-05-18 03:24:11.000000'),
(264, 'Opera 98.0.0.0', '::1', 1, 8, 'El usuario administrador Bloqueó al usuario: Testeo3', '2023-05-18 03:24:59.000000'),
(265, 'Opera 98.0.0.0', '::1', 1, 1, 'El usuario administrador modificó los datos del usuario: administrador', '2023-05-18 12:44:43.000000'),
(266, 'Opera 98.0.0.0', '::1', 1, 8, 'El usuario administrador modificó los datos del usuario: Testeo3', '2023-05-18 14:38:35.000000'),
(267, 'Opera 98.0.0.0', '::1', 1, 12, 'El usuario administrador creó el usuario: testeo10 y asignó el perfil : ADMINISTRADOR', '2023-05-18 19:49:10.000000'),
(268, 'Opera 98.0.0.0', '::1', 1, 1, 'El usuario administrador modificó los datos del usuario: administrador', '2023-05-18 22:55:56.000000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log_sistema`
--

CREATE TABLE `log_sistema` (
  `id` int(11) NOT NULL,
  `terminal` varchar(200) NOT NULL,
  `ip_addres` varchar(200) NOT NULL,
  `u_ejecutor` int(11) NOT NULL,
  `accion` text NOT NULL,
  `fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `log_sistema`
--

INSERT INTO `log_sistema` (`id`, `terminal`, `ip_addres`, `u_ejecutor`, `accion`, `fecha`) VALUES
(1, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a cerrado sesión correctamente desde el sistema', '2023-05-07 13:02:01'),
(2, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión', '2023-05-07 13:02:13'),
(3, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador ha creado la empresa: TesteoA', '2023-05-07 13:02:32'),
(4, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador ha modificado la empresa: TesteoAA', '2023-05-07 13:05:46'),
(5, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador ha eliminado la empresa: TesteoAA', '2023-05-07 13:07:29'),
(6, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a cerrado sesión correctamente desde el sistema', '2023-05-07 13:13:54'),
(7, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión', '2023-05-07 14:18:37'),
(8, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a cerrado sesión correctamente desde el sistema', '2023-05-07 14:49:44'),
(9, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión', '2023-05-07 15:06:05'),
(10, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a cerrado sesión correctamente desde el sistema', '2023-05-07 15:35:22'),
(11, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión', '2023-05-07 18:03:50'),
(12, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador ha creado la empresa: TesteoAA', '2023-05-07 18:12:48'),
(13, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador ha modificado la empresa: TesteoAAA', '2023-05-07 18:12:53'),
(14, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador ha creado el área: AreaC', '2023-05-07 18:13:08'),
(15, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador ha modificado el área: AreaCC', '2023-05-07 18:13:14'),
(16, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador ha eliminado la empresa: TesteoAAA', '2023-05-07 18:13:23'),
(17, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador ha creado el área: AreaD', '2023-05-07 18:13:33'),
(18, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador ha eliminado el área: AreaD', '2023-05-07 18:13:37'),
(19, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el tipo de activo: TIPOACTIVOA', '2023-05-07 18:27:32'),
(20, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el tipo de activo: TIPOACTIVOB', '2023-05-07 18:27:39'),
(21, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a cerrado sesión correctamente desde el sistema', '2023-05-07 20:37:35'),
(22, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-08 01:19:06'),
(23, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a cerrado sesión correctamente desde el sistema', '2023-05-08 01:20:23'),
(24, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-08 01:20:45'),
(25, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el estado: Culminado', '2023-05-08 01:21:02'),
(26, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el estado: Culminadoo', '2023-05-08 01:21:23'),
(27, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó el estado: Culminadoo', '2023-05-08 01:23:14'),
(28, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador deslogeo por inactividad', '2023-05-08 01:52:39'),
(29, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-08 02:09:37'),
(30, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a cerrado sesión correctamente desde el sistema', '2023-05-08 02:09:50'),
(31, 'Opera 97.0.0.0', '::1', 5, 'El usuario: testeo1 falló al ingresar al sistema (credenciales incorrectas), intento 2', '2023-05-08 02:13:03'),
(32, 'Opera 97.0.0.0', '::1', 5, 'El usuario: testeo1 falló al ingresar al sistema (credenciales incorrectas), el usuario se bloqueó', '2023-05-08 02:13:26'),
(33, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-08 02:13:49'),
(34, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a cerrado sesión correctamente desde el sistema', '2023-05-08 02:58:29'),
(35, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-08 10:09:31'),
(36, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el control: CONTROL B', '2023-05-08 11:01:33'),
(37, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el control: CONTROL C', '2023-05-08 11:04:54'),
(38, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador deslogeo por inactividad', '2023-05-08 11:34:36'),
(39, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-08 11:34:56'),
(40, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador deslogeo por inactividad', '2023-05-08 12:45:05'),
(41, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-08 12:52:22'),
(42, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador deslogeo por inactividad', '2023-05-08 13:14:13'),
(43, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-08 17:43:10'),
(44, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador deslogeo por inactividad', '2023-05-08 19:17:50'),
(45, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-09 12:53:16'),
(46, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el plan de acción: PlanA', '2023-05-09 12:53:55'),
(47, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el plan de acción: PlanA', '2023-05-09 13:05:26'),
(48, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el plan de acción: PlanA', '2023-05-09 13:07:07'),
(49, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la actividad: ActividadA', '2023-05-09 13:08:51'),
(50, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a cerrado sesión correctamente desde el sistema', '2023-05-09 13:11:53'),
(51, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-09 15:36:11'),
(52, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a cerrado sesión correctamente desde el sistema', '2023-05-09 15:45:46'),
(53, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-09 15:45:52'),
(54, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a cerrado sesión correctamente desde el sistema', '2023-05-09 15:47:35'),
(55, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-09 15:47:39'),
(56, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a cerrado sesión correctamente desde el sistema', '2023-05-09 15:47:50'),
(57, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-09 17:00:04'),
(58, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a cerrado sesión correctamente desde el sistema', '2023-05-09 17:03:13'),
(59, 'Opera 97.0.0.0', '::1', 5, 'El usuario: testeo1 a iniciado sesión exitosamente', '2023-05-09 17:03:29'),
(60, 'Opera 97.0.0.0', '::1', 5, 'El usuario: testeo1 a cerrado sesión correctamente desde el sistema', '2023-05-09 17:06:39'),
(61, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-09 18:02:39'),
(62, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el tipo de riesgo: TipoRiesgoC', '2023-05-09 18:03:15'),
(63, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el tipo de riesgo: TipoRiesgoCC', '2023-05-09 18:04:10'),
(64, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó el tipo de riesgo: TipoRiesgoCC', '2023-05-09 18:04:26'),
(65, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la probabilidad: PROBABILIDAD', '2023-05-09 18:04:56'),
(66, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el impacto: IMPACTO', '2023-05-09 18:05:22'),
(67, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el nivel de riesgo: MUY PROBABLE', '2023-05-09 18:06:04'),
(68, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el tipo de amenaza: AMENAZAC', '2023-05-09 18:06:55'),
(69, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la descripción de amenaza: AMEDESC', '2023-05-09 18:07:06'),
(70, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó la descripción de amenaza: AMEDESCC', '2023-05-09 18:07:11'),
(71, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó la descripción de amenaza: AMEDESCC', '2023-05-09 18:07:19'),
(72, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la descripción de amenaza: AMEDESC', '2023-05-09 18:07:26'),
(73, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la categoría de vulnerabilidad: CATC', '2023-05-09 18:07:35'),
(74, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la descripción de vulnerabilidad: CATDESC', '2023-05-09 18:07:46'),
(75, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el inventario de clasificación y activos: ActivoC', '2023-05-09 18:09:33'),
(76, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a cerrado sesión correctamente desde el sistema', '2023-05-09 18:10:44'),
(77, 'Opera 97.0.0.0', '::1', 5, 'El usuario: testeo1 a iniciado sesión exitosamente', '2023-05-09 18:10:57'),
(78, 'Opera 97.0.0.0', '::1', 5, 'El usuario testeo1 modificó el inventario de clasificación y activos: ACTIVOA', '2023-05-09 18:11:34'),
(79, 'Opera 97.0.0.0', '::1', 5, 'El usuario testeo1 modificó el inventario de clasificación y activos: ActivoB', '2023-05-09 18:11:58'),
(80, 'Opera 97.0.0.0', '::1', 5, 'El usuario: testeo1 a cerrado sesión correctamente desde el sistema', '2023-05-09 18:15:07'),
(81, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-09 18:15:14'),
(82, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la evaluacion de riesgo: RIESGOA', '2023-05-09 18:15:59'),
(83, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó la evaluacion de riesgo: RIESGOA', '2023-05-09 18:16:26'),
(84, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó la evaluacion de riesgo: RIESGOA', '2023-05-09 18:16:39'),
(85, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a cerrado sesión correctamente desde el sistema', '2023-05-09 18:30:14'),
(86, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-09 18:30:19'),
(87, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-10 01:19:34'),
(88, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el plan de acción: PlanA', '2023-05-10 01:40:48'),
(89, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el plan de acción: PlanA', '2023-05-10 01:41:06'),
(90, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la evaluacion de riesgo: RIESGO A', '2023-05-10 02:37:27'),
(91, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el control: ControlA', '2023-05-10 02:38:25'),
(92, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la evaluacion de riesgo: RIESGOB', '2023-05-10 02:39:37'),
(93, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el control: ControlA', '2023-05-10 02:43:32'),
(94, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el control: ControlB', '2023-05-10 02:45:22'),
(95, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la evaluacion de riesgo: RIESGOC', '2023-05-10 02:46:13'),
(96, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el control: ControlC', '2023-05-10 02:46:40'),
(97, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el plan de acción: PlanA', '2023-05-10 02:53:20'),
(98, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la actividad: ActividadA', '2023-05-10 02:53:48'),
(99, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la evaluacion de riesgo: RIESGOD', '2023-05-10 02:54:45'),
(100, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el plan de acción: PlanA', '2023-05-10 02:55:23'),
(101, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el plan de acción: PlanA', '2023-05-10 02:56:37'),
(102, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el plan de acción: PlanA', '2023-05-10 03:18:32'),
(103, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el plan de acción: PlanA', '2023-05-10 03:18:59'),
(104, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a cerrado sesión correctamente desde el sistema', '2023-05-10 03:21:50'),
(105, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-10 03:37:19'),
(106, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el control: ControlB', '2023-05-10 03:37:52'),
(107, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el control: ControlC', '2023-05-10 03:47:15'),
(108, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el control: ControlB', '2023-05-10 03:49:37'),
(109, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-10 09:42:51'),
(110, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el inventario de clasificación y activos: ActivoB', '2023-05-10 09:58:31'),
(111, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador deslogeo por inactividad', '2023-05-10 10:24:21'),
(112, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-10 10:42:52'),
(113, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el inventario de clasificación y activos: ACTIVOA', '2023-05-10 10:43:16'),
(114, 'Chrome 112.0.0.0', '::1', 5, 'El usuario: testeo1 a iniciado sesión exitosamente', '2023-05-10 10:44:40'),
(115, 'Chrome 112.0.0.0', '::1', 5, 'El usuario testeo1 modificó el inventario de clasificación y activos: ACTIVOA', '2023-05-10 10:45:11'),
(116, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a cerrado sesión correctamente desde el sistema', '2023-05-10 10:46:10'),
(117, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-10 10:57:05'),
(118, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el inventario de clasificación y activos: ACTIVOA', '2023-05-10 11:00:00'),
(119, 'Chrome 112.0.0.0', '::1', 5, 'El usuario testeo1 modificó el inventario de clasificación y activos: ACTIVOA', '2023-05-10 11:02:29'),
(120, 'Chrome 112.0.0.0', '::1', 5, 'El usuario testeo1 modificó el inventario de clasificación y activos: ACTIVOA', '2023-05-10 11:02:56'),
(121, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el inventario de clasificación y activos: ACTIVOA', '2023-05-10 11:15:22'),
(122, 'Chrome 112.0.0.0', '::1', 5, 'El usuario testeo1 modificó el inventario de clasificación y activos: ACTIVOA', '2023-05-10 11:18:35'),
(123, 'Chrome 112.0.0.0', '::1', 5, 'El usuario testeo1 modificó el inventario de clasificación y activos: ACTIVOA', '2023-05-10 11:19:13'),
(124, 'Chrome 112.0.0.0', '::1', 5, 'El usuario: testeo1 a cerrado sesión correctamente desde el sistema', '2023-05-10 11:24:00'),
(125, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el inventario de clasificación y activos: ACTIVOA', '2023-05-10 11:27:06'),
(126, 'Chrome 112.0.0.0', '::1', 5, 'El usuario: testeo1 a iniciado sesión exitosamente', '2023-05-10 11:32:30'),
(127, 'Chrome 112.0.0.0', '::1', 5, 'El usuario testeo1 modificó el inventario de clasificación y activos: ACTIVOA', '2023-05-10 11:32:52'),
(128, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador deslogeo por inactividad', '2023-05-10 12:03:07'),
(129, 'Chrome 112.0.0.0', '::1', 5, 'El usuario: testeo1 deslogeo por inactividad', '2023-05-10 12:11:21'),
(130, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-10 16:36:57'),
(131, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la evaluacion de riesgo: RIESGOA', '2023-05-10 16:37:32'),
(132, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el control: ControlA', '2023-05-10 16:46:13'),
(133, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó la evaluacion de riesgo: RIESGOA', '2023-05-10 16:47:42'),
(134, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó la control: ControlA', '2023-05-10 17:03:55'),
(135, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó la control: ControlA', '2023-05-10 17:04:20'),
(136, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó la control: ControlA', '2023-05-10 17:05:12'),
(137, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó la control: ControlA', '2023-05-10 17:05:43'),
(138, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó la control: ControlA', '2023-05-10 17:06:08'),
(139, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó la control: ControlA', '2023-05-10 17:06:23'),
(140, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó la control: ControlA', '2023-05-10 17:06:57'),
(141, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el control: Control10', '2023-05-10 17:07:53'),
(142, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a cerrado sesión correctamente desde el sistema', '2023-05-10 17:54:40'),
(143, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-10 18:18:40'),
(144, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó la evaluacion de riesgo: RIESGOA', '2023-05-10 18:19:49'),
(145, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó la control: Control10', '2023-05-10 18:19:55'),
(146, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el control: Plan11', '2023-05-10 18:22:31'),
(147, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el plan de acción: Plana', '2023-05-10 18:23:03'),
(148, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la actividad: ActividadA', '2023-05-10 18:23:34'),
(149, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el plan de acción: Plana', '2023-05-10 18:24:00'),
(150, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el plan de acción: PlanA', '2023-05-10 18:24:20'),
(151, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la actividad: Actividad 1', '2023-05-10 18:26:32'),
(152, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el inventario de clasificación y activos: ACTIVOH', '2023-05-10 18:48:01'),
(153, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el inventario de clasificación y activos: ActivoJ', '2023-05-10 18:49:12'),
(154, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el inventario de clasificación y activos: Activok', '2023-05-10 18:51:44'),
(155, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el inventario de clasificación y activos: ACTIVOM', '2023-05-10 18:55:30'),
(156, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el inventario de clasificación y activos: Activon', '2023-05-10 18:58:05'),
(157, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador deslogeo por inactividad', '2023-05-10 19:31:50'),
(158, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-10 19:38:18'),
(159, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el plan de acción: PLAN A', '2023-05-10 19:41:43'),
(160, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la actividad: Actividad 1', '2023-05-10 19:43:33'),
(161, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el inventario de clasificación y activos: ActivoZ', '2023-05-10 19:49:00'),
(162, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-11 01:06:02'),
(163, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó la evaluación de riesgo: RIESGOA', '2023-05-11 01:10:24'),
(164, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la evaluacion de riesgo: RIESGOA', '2023-05-11 01:11:49'),
(165, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador deslogeo por inactividad', '2023-05-11 01:42:04'),
(166, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-11 01:43:56'),
(167, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó la evaluación de riesgo: RIESGOA', '2023-05-11 01:48:10'),
(168, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el inventario de clasificación y activos: ACTIVOZZ', '2023-05-11 02:01:22'),
(169, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador exportó la informacion historica de evaluación de riesgos', '2023-05-11 02:03:30'),
(170, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador exportó la informacion de evaluación de riesgos', '2023-05-11 02:03:35'),
(171, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador exporto la informacion de inventario de clasificación y activo por usuario', '2023-05-11 02:03:43'),
(172, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador exportó la información historia de inventario de clasificación y activos por usuario', '2023-05-11 02:03:46'),
(173, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador exporto la informacion de inventario de clasificación y activo por usuario', '2023-05-11 02:04:58'),
(174, 'Chrome 113.0.0.0', '::1', 5, 'El usuario: testeo1 a iniciado sesión exitosamente', '2023-05-11 02:07:08'),
(175, 'Chrome 113.0.0.0', '::1', 5, 'El usuario testeo1 modificó el inventario de clasificación y activos: ACTIVOZZ', '2023-05-11 02:07:35'),
(176, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la evaluacion de riesgo: RIESGOA', '2023-05-11 02:11:49'),
(177, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el control: Plan11', '2023-05-11 02:12:32'),
(178, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador deslogeo por inactividad', '2023-05-11 02:12:37'),
(179, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-11 02:12:57'),
(180, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó la evaluacion de riesgo: RIESGOA', '2023-05-11 02:13:56'),
(181, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó la evaluación de riesgo: RIESGOA', '2023-05-11 02:14:18'),
(182, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó la control: Plan11', '2023-05-11 02:14:24'),
(183, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la evaluacion de riesgo: RIESGOAA', '2023-05-11 02:17:58'),
(184, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el control: Control12', '2023-05-11 02:18:25'),
(185, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la evaluacion de riesgo: RIESGOB', '2023-05-11 02:24:12'),
(186, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el control: Control13', '2023-05-11 02:24:37'),
(187, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el plan de acción: PlanA', '2023-05-11 02:25:26'),
(188, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la actividad: Actividad 1', '2023-05-11 02:25:53'),
(189, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la evaluacion de riesgo: RIESGOC', '2023-05-11 02:27:03'),
(190, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el plan de acción: PlanA', '2023-05-11 02:27:19'),
(191, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el plan de acción: PlanA', '2023-05-11 02:27:45'),
(192, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó la evaluación de riesgo: RIESGOB', '2023-05-11 02:27:52'),
(193, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el control: Control14', '2023-05-11 02:28:33'),
(194, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el plan de acción: PlanA', '2023-05-11 02:28:49'),
(195, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el plan de acción: PlanA', '2023-05-11 02:29:09'),
(196, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó la control: Control13', '2023-05-11 02:29:19'),
(197, 'Chrome 113.0.0.0', '::1', 5, 'El usuario: testeo1 deslogeo por inactividad', '2023-05-11 02:31:21'),
(198, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó el plan de acción: PlanA', '2023-05-11 02:46:57'),
(199, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó la control: Control14', '2023-05-11 02:47:11'),
(200, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó la evaluación de riesgo: RIESGOC', '2023-05-11 02:47:19'),
(201, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la evaluacion de riesgo: RIESGOB', '2023-05-11 02:52:16'),
(202, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el control: Contol15', '2023-05-11 02:52:40'),
(203, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el plan de acción: PlanA', '2023-05-11 02:54:05'),
(204, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el plan de acción: PlanA', '2023-05-11 02:55:21'),
(205, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el plan de acción: PlanA', '2023-05-11 02:55:42'),
(206, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó la control: Contol15', '2023-05-11 02:55:49'),
(207, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó la evaluación de riesgo: RIESGOB', '2023-05-11 02:55:56'),
(208, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó el plan de acción: PlanA', '2023-05-11 02:56:06'),
(209, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó la control: Control12', '2023-05-11 02:56:35'),
(210, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó la evaluación de riesgo: RIESGOAA', '2023-05-11 02:56:41'),
(211, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a cerrado sesión correctamente desde el sistema', '2023-05-11 03:18:38'),
(212, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador falló al ingresar al sistema (credenciales incorrectas), intento 1', '2023-05-11 03:18:45'),
(213, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-11 03:18:53'),
(214, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a cerrado sesión correctamente desde el sistema', '2023-05-11 03:19:28'),
(215, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador falló al ingresar al sistema (credenciales incorrectas), intento 1', '2023-05-11 03:20:21'),
(216, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-11 03:24:44'),
(217, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a cerrado sesión correctamente desde el sistema', '2023-05-11 03:25:26'),
(218, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-11 03:25:37'),
(219, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a cerrado sesión correctamente desde el sistema', '2023-05-11 03:26:37'),
(220, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-11 03:27:00'),
(221, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a cerrado sesión correctamente desde el sistema', '2023-05-11 03:27:07'),
(222, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador falló al ingresar al sistema (credenciales incorrectas), intento 1', '2023-05-11 03:38:55'),
(223, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-11 03:39:04'),
(224, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la evaluacion de riesgo: RIESGOA', '2023-05-11 03:39:46'),
(225, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el control: Control16', '2023-05-11 03:40:16'),
(226, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el plan de acción: PlanA', '2023-05-11 03:40:55'),
(227, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la actividad: Actividad 1', '2023-05-11 03:41:20'),
(228, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la actividad: ActividadA', '2023-05-11 03:47:05'),
(229, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a cerrado sesión correctamente desde el sistema', '2023-05-11 03:48:40'),
(230, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador a iniciado sesión exitosamente', '2023-05-11 10:32:17'),
(231, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-11 11:19:26'),
(232, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-11 11:19:30'),
(233, 'Chrome 113.0.0.0', '::1', 5, 'El usuario: testeo1 inició sesión exitosamente', '2023-05-11 11:42:12'),
(234, 'Chrome 113.0.0.0', '::1', 5, 'El usuario testeo1 modificó el inventario de clasificación y activos: ActivoZ', '2023-05-11 11:45:37'),
(235, 'Chrome 113.0.0.0', '::1', 5, 'El usuario: testeo1 cerró sesión correctamente desde el sistema', '2023-05-11 11:46:07'),
(236, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la evaluacion de riesgo: RIESGOB', '2023-05-11 11:47:29'),
(237, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la evaluacion de riesgo: RIESGOC', '2023-05-11 11:48:03'),
(238, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó la evaluación de riesgo: RIESGOB', '2023-05-11 11:48:13'),
(239, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el control: Control11', '2023-05-11 11:48:43'),
(240, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó la evaluacion de riesgo: RIESGOC', '2023-05-11 11:49:45'),
(241, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó la evaluacion de riesgo: RIESGOC', '2023-05-11 11:51:31'),
(242, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó el control: Control11', '2023-05-11 11:51:51'),
(243, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó la evaluación de riesgo: RIESGOC', '2023-05-11 11:52:01'),
(244, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la evaluacion de riesgo: RIESGOD', '2023-05-11 11:52:41'),
(245, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el control: Control18', '2023-05-11 11:53:08'),
(246, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó la evaluacion de riesgo: RIESGOD', '2023-05-11 11:53:37'),
(247, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la evaluacion de riesgo: RIESGOE', '2023-05-11 11:54:08'),
(248, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el plan de acción: PlanA', '2023-05-11 11:55:06'),
(249, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la actividad: Actividad 1', '2023-05-11 11:55:45'),
(250, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el plan de acción: PlanA', '2023-05-11 11:56:52'),
(251, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó la evaluación de riesgo: RIESGOD', '2023-05-11 11:57:12'),
(252, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador la actividad se ejecutó correctamente el riesgo: Actividad 1', '2023-05-11 11:58:13'),
(253, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó el plan de acción: PlanA', '2023-05-11 11:58:55'),
(254, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó la evaluación de riesgo: RIESGOE', '2023-05-11 11:59:07'),
(255, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó el control: Control18', '2023-05-11 11:59:16'),
(256, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-11 12:06:52'),
(257, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-11 15:57:33'),
(258, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador exportó la información de reporte de seguridad ', '2023-05-11 15:58:02'),
(259, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador exportó la información de reporte de seguridad ', '2023-05-11 15:59:19'),
(260, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador exportó la información de usuarios', '2023-05-11 16:00:49'),
(261, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador exportó la información de detalle de perfiles ', '2023-05-11 16:00:55'),
(262, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador exportó la información de detalle de perfiles ', '2023-05-11 16:01:10'),
(263, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador exportó la información de detalle de perfiles ', '2023-05-11 16:01:34'),
(264, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador exportó la información de reporte de movimientos del sistema ', '2023-05-11 16:01:48'),
(265, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó la valoración de activo: 1', '2023-05-11 18:04:19'),
(266, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el inventario de clasificación y activos: ActivoZ', '2023-05-11 18:11:13'),
(267, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el inventario de clasificación y activos: ACTIVOZZ', '2023-05-11 18:11:51'),
(268, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó la valoración de activo: 2', '2023-05-11 18:13:41'),
(269, 'Chrome 113.0.0.0', '::1', 5, 'El usuario: testeo1 inició sesión exitosamente', '2023-05-11 18:18:01'),
(270, 'Chrome 113.0.0.0', '::1', 5, 'El usuario: testeo1 cerró sesión correctamente desde el sistema', '2023-05-11 18:18:28'),
(271, 'Chrome 113.0.0.0', '::1', 5, 'El usuario: testeo1 inició sesión exitosamente', '2023-05-11 18:18:38'),
(272, 'Chrome 113.0.0.0', '::1', 5, 'El usuario testeo1 modificó el inventario de clasificación y activos: ACTIVOH', '2023-05-11 18:19:40'),
(273, 'Chrome 113.0.0.0', '::1', 5, 'El usuario testeo1 modificó el inventario de clasificación y activos: ACTIVOH', '2023-05-11 18:50:19'),
(274, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el inventario de clasificación y activos: ACTIVO ZZZZ', '2023-05-11 18:51:52'),
(275, 'Chrome 113.0.0.0', '::1', 5, 'El usuario testeo1 modificó el inventario de clasificación y activos: ACTIVO ZZZZ', '2023-05-11 18:52:29'),
(276, 'Chrome 113.0.0.0', '::1', 5, 'El usuario testeo1 modificó el inventario de clasificación y activos: ACTIVO ZZZZ', '2023-05-11 18:53:55'),
(277, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el inventario de clasificación y activos: ACTIVO ZZZZ', '2023-05-11 18:55:12'),
(278, 'Chrome 113.0.0.0', '::1', 5, 'El usuario testeo1 modificó el inventario de clasificación y activos: ACTIVO ZZZZ', '2023-05-11 18:55:57'),
(279, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el inventario de clasificación y activos: ACTIVO ZZZZ', '2023-05-11 18:56:59'),
(280, 'Chrome 113.0.0.0', '::1', 5, 'El usuario testeo1 modificó el inventario de clasificación y activos: ACTIVO ZZZZ', '2023-05-11 18:57:35'),
(281, 'Chrome 113.0.0.0', '::1', 5, 'El usuario testeo1 modificó el inventario de clasificación y activos: ACTIVO ZZZZ', '2023-05-11 18:58:56'),
(282, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el inventario de clasificación y activos: ACTIVOA', '2023-05-11 19:06:18'),
(283, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó la valoración de activo: 2', '2023-05-11 19:09:31'),
(284, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó la valoración de activo: 4', '2023-05-11 19:09:37'),
(285, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador exportó la información historia de inventario de clasificación y activos por usuario', '2023-05-11 19:12:38'),
(286, 'Chrome 113.0.0.0', '::1', 5, 'El usuario testeo1 modificó el inventario de clasificación y activos: ACTIVOZZ', '2023-05-11 19:13:29'),
(287, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador exportó la información historia de inventario de clasificación y activos por usuario', '2023-05-11 19:13:38'),
(288, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el inventario de clasificación y activos: ACTIVOH', '2023-05-11 19:15:00'),
(289, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador exportó la información historia de inventario de clasificación y activos por usuario', '2023-05-11 19:15:07'),
(290, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-11 19:27:51'),
(291, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador falló al ingresar al sistema (credenciales incorrectas), intento 1', '2023-05-11 19:28:01'),
(292, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-11 19:28:06'),
(293, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la empresa: TESTEOA', '2023-05-11 19:28:21'),
(294, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el área: AREATESTEOA', '2023-05-11 19:28:35'),
(295, 'Chrome 113.0.0.0', '::1', 5, 'El usuario: testeo1 deslogeó por inactividad', '2023-05-11 19:28:46'),
(296, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-11 19:29:11'),
(297, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-11 19:29:22'),
(298, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-11 19:31:40'),
(299, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-11 19:32:09'),
(300, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador exportó la información de reporte de movimientos del sistema ', '2023-05-11 19:32:26'),
(301, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-11 19:50:58'),
(302, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-11 19:51:05'),
(303, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-11 19:51:29'),
(304, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-12 01:54:34'),
(305, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-12 01:55:12'),
(306, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-12 01:55:20'),
(307, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador deslogueó por inactividad', '2023-05-12 02:10:49'),
(308, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-12 02:26:14'),
(309, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador exportó la información historia de inventario de clasificación y activos por usuario', '2023-05-12 02:44:44'),
(310, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-12 02:52:24'),
(311, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-12 02:52:28'),
(312, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-12 02:52:54'),
(313, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-12 02:52:57'),
(314, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador deslogueó por inactividad', '2023-05-12 03:08:32'),
(315, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-12 03:12:30'),
(316, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador modificó el inventario de clasificación y activos: ACTIVOZZ', '2023-05-12 03:12:56'),
(317, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-12 10:13:34'),
(318, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-12 10:14:19'),
(319, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-12 10:14:23'),
(320, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-12 10:16:47'),
(321, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-12 10:18:13'),
(322, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-12 10:19:43'),
(323, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-12 10:21:51'),
(324, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-12 10:23:10'),
(325, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-12 10:23:15'),
(326, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-12 10:24:04'),
(327, 'Opera 97.0.0.0', '::1', 10, 'El usuario: testeo5 falló al ingresar al sistema (credenciales incorrectas), intento 1', '2023-05-12 10:24:15'),
(328, 'Opera 97.0.0.0', '::1', 10, 'El usuario: testeo5 falló al ingresar al sistema (credenciales incorrectas), intento 2', '2023-05-12 10:24:22'),
(329, 'Opera 97.0.0.0', '::1', 10, 'El usuario: testeo5 falló al ingresar al sistema (credenciales incorrectas), el usuario se bloqueó', '2023-05-12 10:24:28'),
(330, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-12 10:25:25'),
(331, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-12 10:25:44'),
(332, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-12 10:25:48'),
(333, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-12 10:29:02'),
(334, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-12 10:47:39'),
(335, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador deslogueó por inactividad', '2023-05-12 11:25:10'),
(336, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-12 13:41:37'),
(337, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador exportó la información de reporte de seguridad ', '2023-05-12 14:07:05'),
(338, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador exportó la información de reporte de movimientos del sistema ', '2023-05-12 14:10:46'),
(339, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador deslogueó por inactividad', '2023-05-12 14:53:10'),
(340, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-12 16:16:10'),
(341, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador exportó la información historia de inventario de clasificación y activos por usuario', '2023-05-12 16:17:50'),
(342, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-12 16:20:42'),
(343, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-12 16:20:48'),
(344, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-12 16:21:28'),
(345, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-12 16:21:45'),
(346, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-12 16:24:39'),
(347, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-12 22:33:24'),
(348, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó el inventario de clasificación y activos: ACTIVOA', '2023-05-12 22:38:02'),
(349, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó el inventario de clasificación y activos: ACTIVO ZZZZ', '2023-05-12 22:38:14'),
(350, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó el inventario de clasificación y activos: ACTIVOZZ', '2023-05-12 22:38:42'),
(351, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó el inventario de clasificación y activos: ActivoZ', '2023-05-12 22:38:51'),
(352, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó el plan de acción: PlanA', '2023-05-12 22:40:32'),
(353, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó el control: Control16', '2023-05-12 22:40:42'),
(354, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó la evaluación de riesgo: RIESGOA', '2023-05-12 22:40:53'),
(355, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador deslogueó por inactividad', '2023-05-12 23:04:10'),
(356, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-12 23:18:26'),
(357, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador deslogueó por inactividad', '2023-05-12 23:45:10'),
(358, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-12 23:57:25'),
(359, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el inventario de clasificación y activos: ActivoA', '2023-05-12 23:58:43'),
(360, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó la evaluacion de riesgo: RiesgoA', '2023-05-13 00:00:25'),
(361, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó el inventario de clasificación y activos: ActivoA', '2023-05-13 00:00:39'),
(362, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador deslogueó por inactividad', '2023-05-13 00:25:10'),
(363, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-13 00:36:24'),
(364, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó la evaluación de riesgo: RiesgoA', '2023-05-13 00:37:51'),
(365, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador eliminó el inventario de clasificación y activos: ActivoA', '2023-05-13 00:48:09'),
(366, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-13 11:32:05'),
(367, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador creó el inventario de clasificación y activos: AcitvoA', '2023-05-13 11:33:10'),
(368, 'Opera 97.0.0.0', '::1', 1, 'El usuario administrador exportó la información historia de inventario de clasificación y activos por usuario', '2023-05-13 11:33:22'),
(369, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-13 11:33:50'),
(370, 'Opera 97.0.0.0', '::1', 5, 'El usuario: testeo1 falló al ingresar al sistema (credenciales incorrectas), intento 1', '2023-05-13 11:34:13'),
(371, 'Opera 97.0.0.0', '::1', 5, 'El usuario: testeo1 falló al ingresar al sistema (credenciales incorrectas), intento 2', '2023-05-13 11:34:28'),
(372, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-13 11:34:33'),
(373, 'Opera 97.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-13 11:35:44'),
(374, 'Opera 97.0.0.0', '::1', 5, 'El usuario: testeo1 inició sesión exitosamente', '2023-05-13 11:35:56'),
(375, 'Opera 97.0.0.0', '::1', 5, 'El usuario testeo1 modificó el inventario de clasificación y activos: AcitvoA', '2023-05-13 11:36:30'),
(376, 'Opera 97.0.0.0', '::1', 5, 'El usuario testeo1 exportó la información historia de inventario de clasificación y activos', '2023-05-13 11:36:36'),
(377, 'Opera 97.0.0.0', '::1', 5, 'El usuario testeo1 modificó el inventario de clasificación y activos: AcitvoA', '2023-05-13 11:37:33'),
(378, 'Opera 97.0.0.0', '::1', 5, 'El usuario testeo1 exportó la informacion de inventario de clasificación y activo', '2023-05-13 11:37:43'),
(379, 'Opera 97.0.0.0', '::1', 5, 'El usuario testeo1 exportó la información historia de inventario de clasificación y activos', '2023-05-13 11:37:45'),
(380, 'Opera 97.0.0.0', '::1', 5, 'El usuario testeo1 eliminó el inventario de clasificación y activos: AcitvoA', '2023-05-13 11:38:06'),
(381, 'Opera 97.0.0.0', '::1', 5, 'El usuario testeo1 exportó la información historia de inventario de clasificación y activos', '2023-05-13 11:38:12'),
(382, 'Opera 97.0.0.0', '::1', 5, 'El usuario: testeo1 deslogueó por inactividad', '2023-05-13 13:15:57'),
(383, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-16 12:30:27'),
(384, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-16 12:36:02'),
(385, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-16 17:36:59'),
(386, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el inventario de clasificación y activos: ActivoA', '2023-05-16 17:44:27'),
(387, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-16 17:45:32'),
(388, 'Opera 98.0.0.0', '::1', 5, 'El usuario: testeo1 inició sesión exitosamente', '2023-05-16 17:45:41'),
(389, 'Opera 98.0.0.0', '::1', 5, 'El usuario testeo1 modificó el inventario de clasificación y activos: ActivoA', '2023-05-16 17:46:24'),
(390, 'Opera 98.0.0.0', '::1', 5, 'El usuario: testeo1 cerró sesión correctamente desde el sistema', '2023-05-16 17:46:45'),
(391, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-16 17:46:53'),
(392, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó el inventario de clasificación y activos: ActivoA', '2023-05-16 17:47:33'),
(393, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-16 17:47:49'),
(394, 'Opera 98.0.0.0', '::1', 5, 'El usuario: testeo1 inició sesión exitosamente', '2023-05-16 17:47:57'),
(395, 'Opera 98.0.0.0', '::1', 5, 'El usuario testeo1 modificó el inventario de clasificación y activos: ActivoA', '2023-05-16 17:48:28'),
(396, 'Opera 98.0.0.0', '::1', 5, 'El usuario: testeo1 cerró sesión correctamente desde el sistema', '2023-05-16 17:49:47'),
(397, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-16 17:50:11'),
(398, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó la evaluacion de riesgo: RiesgoA', '2023-05-16 17:51:24'),
(399, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el control: Control19', '2023-05-16 17:52:02'),
(400, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el plan de acción: PlanA', '2023-05-16 17:53:13'),
(401, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó la actividad: ActividadA', '2023-05-16 17:55:06'),
(402, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador la actividad se ejecutó correctamente el riesgo: Actividad 1', '2023-05-16 17:58:18');
INSERT INTO `log_sistema` (`id`, `terminal`, `ip_addres`, `u_ejecutor`, `accion`, `fecha`) VALUES
(403, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador la actividad se ejecutó correctamente el riesgo: ActividadA', '2023-05-16 17:59:59'),
(404, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el estado: Culminado', '2023-05-16 18:00:24'),
(405, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó el plan de acción: PlanA', '2023-05-16 18:01:20'),
(406, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó el plan de acción: PlanA', '2023-05-16 18:02:55'),
(407, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-16 18:21:05'),
(408, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-17 00:52:21'),
(409, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el inventario de clasificación y activos: ActivoB', '2023-05-17 01:23:42'),
(410, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó el plan de acción: PlanA', '2023-05-17 01:41:31'),
(411, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó el control: Control19', '2023-05-17 01:41:35'),
(412, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó el inventario de clasificación y activos: ActivoB', '2023-05-17 01:41:42'),
(413, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el inventario de clasificación y activos: ActivoB', '2023-05-17 01:42:44'),
(414, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó el inventario de clasificación y activos: ActivoB', '2023-05-17 01:47:31'),
(415, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el inventario de clasificación y activos: ActivoAA', '2023-05-17 01:51:51'),
(416, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-17 01:55:10'),
(417, 'Opera 98.0.0.0', '::1', 5, 'El usuario: testeo1 inició sesión exitosamente', '2023-05-17 01:55:15'),
(418, 'Opera 98.0.0.0', '::1', 5, 'El usuario testeo1 modificó el inventario de clasificación y activos: ActivoAA', '2023-05-17 01:55:47'),
(419, 'Opera 98.0.0.0', '::1', 5, 'El usuario: testeo1 cerró sesión correctamente desde el sistema', '2023-05-17 01:56:12'),
(420, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-17 01:56:16'),
(421, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador exporto la informacion de inventario de clasificación y activo por usuario', '2023-05-17 01:57:55'),
(422, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador exportó la información historia de inventario de clasificación y activos por usuario', '2023-05-17 01:58:11'),
(423, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-17 01:58:22'),
(424, 'Opera 98.0.0.0', '::1', 5, 'El usuario: testeo1 inició sesión exitosamente', '2023-05-17 01:58:30'),
(425, 'Opera 98.0.0.0', '::1', 5, 'El usuario testeo1 exportó la informacion de inventario de clasificación y activo', '2023-05-17 01:58:45'),
(426, 'Opera 98.0.0.0', '::1', 5, 'El usuario testeo1 exportó la información historia de inventario de clasificación y activos', '2023-05-17 01:59:01'),
(427, 'Opera 98.0.0.0', '::1', 5, 'El usuario testeo1 modificó el inventario de clasificación y activos: ActivoAA', '2023-05-17 01:59:41'),
(428, 'Opera 98.0.0.0', '::1', 5, 'El usuario: testeo1 cerró sesión correctamente desde el sistema', '2023-05-17 01:59:48'),
(429, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-17 01:59:56'),
(430, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó el inventario de clasificación y activos: ActivoAA', '2023-05-17 02:00:51'),
(431, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el inventario de clasificación y activos: ActivoB', '2023-05-17 02:02:16'),
(432, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó el inventario de clasificación y activos: ActivoAA', '2023-05-17 02:02:58'),
(433, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el inventario de clasificación y activos: ActivoA', '2023-05-17 02:03:50'),
(434, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-17 02:04:01'),
(435, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-17 03:33:59'),
(436, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-17 03:34:25'),
(437, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-17 10:06:36'),
(438, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-17 10:08:21'),
(439, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-17 10:08:31'),
(440, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador falló al ingresar al sistema (credenciales incorrectas), intento 1', '2023-05-17 19:14:38'),
(441, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador falló al ingresar al sistema (credenciales incorrectas), intento 2', '2023-05-17 19:15:24'),
(442, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador falló al ingresar al sistema (credenciales incorrectas), el usuario se bloqueó', '2023-05-17 19:16:07'),
(443, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-17 19:24:44'),
(444, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-17 19:25:44'),
(445, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-17 19:27:02'),
(446, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-17 19:31:03'),
(447, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-17 19:31:49'),
(448, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-17 19:32:54'),
(449, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-17 19:38:17'),
(450, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-17 19:39:24'),
(451, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-17 21:36:39'),
(452, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-17 21:57:59'),
(453, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador exportó la información de detalle de perfiles ', '2023-05-17 22:54:24'),
(454, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador exportó la información de usuarios', '2023-05-17 23:20:50'),
(455, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador exportó la información de reporte de seguridad ', '2023-05-17 23:25:49'),
(456, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador exportó la información de reporte de seguridad ', '2023-05-17 23:30:49'),
(457, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador exportó la información de reporte de seguridad ', '2023-05-17 23:30:53'),
(458, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador exportó la información de reporte de seguridad ', '2023-05-17 23:30:59'),
(459, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador exportó la información de reporte de movimientos del sistema ', '2023-05-17 23:31:24'),
(460, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador exportó la información de reporte de movimientos del sistema ', '2023-05-17 23:31:26'),
(461, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador exportó la información de reporte de movimientos del sistema ', '2023-05-17 23:31:33'),
(462, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador exportó la información de usuarios', '2023-05-17 23:37:13'),
(463, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador exportó la información de usuarios', '2023-05-17 23:37:15'),
(464, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador exportó la información de detalle de perfiles ', '2023-05-17 23:37:21'),
(465, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador exportó la información de detalle de perfiles ', '2023-05-17 23:37:22'),
(466, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó la empresa: TESTEOAA', '2023-05-17 23:50:40'),
(467, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó la empresa: TESTEOB', '2023-05-17 23:51:50'),
(468, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó la empresa: TESTEOB', '2023-05-17 23:52:05'),
(469, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó la empresa: TESTEOB', '2023-05-17 23:54:04'),
(470, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó la empresa: TESTEOB', '2023-05-17 23:54:08'),
(471, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó la empresa: TESTEOB', '2023-05-17 23:55:47'),
(472, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó la empresa: TESTEOB', '2023-05-17 23:55:52'),
(473, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó la empresa: testeob', '2023-05-17 23:56:31'),
(474, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó la empresa: testeob', '2023-05-17 23:56:37'),
(475, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó la empresa: TESTEOB', '2023-05-17 23:57:03'),
(476, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó la empresa: TESTEOB', '2023-05-17 23:57:07'),
(477, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó la empresa: TESTEOC', '2023-05-17 23:58:10'),
(478, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó la empresa: TESTEOC', '2023-05-17 23:58:13'),
(479, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó la empresa: TESTEOB', '2023-05-17 23:58:53'),
(480, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó la empresa: TESTEOB', '2023-05-17 23:58:57'),
(481, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-18 00:12:03'),
(482, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 00:12:09'),
(483, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 00:43:14'),
(484, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-18 01:16:46'),
(485, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 01:16:51'),
(486, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador falló al ingresar al sistema (credenciales incorrectas), intento 1', '2023-05-18 01:18:09'),
(487, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 01:18:13'),
(488, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 01:19:30'),
(489, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 01:22:59'),
(490, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 01:24:36'),
(491, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 01:24:52'),
(492, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 01:27:19'),
(493, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 01:28:18'),
(494, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 01:28:58'),
(495, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 01:30:07'),
(496, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 01:30:49'),
(497, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 01:43:02'),
(498, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-18 01:43:21'),
(499, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 01:43:26'),
(500, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador deslogueó por inactividad', '2023-05-18 01:53:00'),
(501, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 01:54:43'),
(502, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-18 01:56:34'),
(503, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 01:56:39'),
(504, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-18 01:58:07'),
(505, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 01:58:12'),
(506, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-18 01:59:58'),
(507, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 02:00:03'),
(508, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-18 02:02:02'),
(509, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 02:13:35'),
(510, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-18 02:13:41'),
(511, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 02:13:45'),
(512, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-18 02:14:11'),
(513, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 02:14:14'),
(514, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó la empresa: TESTEOAAA', '2023-05-18 02:16:17'),
(515, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó la empresa: TESTEOB', '2023-05-18 02:16:33'),
(516, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó la empresa: TESTEOC', '2023-05-18 02:16:48'),
(517, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó la empresa: TESTEOC', '2023-05-18 02:16:51'),
(518, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó la empresa: TESTEOB', '2023-05-18 02:16:55'),
(519, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador deslogueó por inactividad', '2023-05-18 02:37:26'),
(520, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 02:51:18'),
(521, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador deslogueó por inactividad', '2023-05-18 02:54:21'),
(522, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 02:57:50'),
(523, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-18 02:58:19'),
(524, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 02:58:23'),
(525, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 02:59:06'),
(526, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 03:02:57'),
(527, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador falló al ingresar al sistema (credenciales incorrectas), intento 1', '2023-05-18 03:04:56'),
(528, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador falló al ingresar al sistema (credenciales incorrectas), intento 2', '2023-05-18 03:08:43'),
(529, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador falló al ingresar al sistema (credenciales incorrectas), el usuario se bloqueó', '2023-05-18 03:12:47'),
(530, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador intentó ingresar al sistema, pero su usuario esta bloqueado', '2023-05-18 03:13:40'),
(531, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador intentó ingresar al sistema, pero su usuario esta bloqueado', '2023-05-18 03:15:16'),
(532, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador intentó ingresar al sistema, pero su usuario esta bloqueado', '2023-05-18 03:16:09'),
(533, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador intentó ingresar al sistema, pero su usuario esta bloqueado', '2023-05-18 03:16:36'),
(534, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador intentó ingresar al sistema, pero su usuario esta bloqueado', '2023-05-18 03:17:14'),
(535, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador intentó ingresar al sistema, pero su usuario esta bloqueado', '2023-05-18 03:17:43'),
(536, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador intentó ingresar al sistema, pero su usuario esta bloqueado', '2023-05-18 03:18:14'),
(537, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador intentó ingresar al sistema, pero su usuario esta bloqueado', '2023-05-18 03:18:20'),
(538, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador intentó ingresar al sistema, pero su usuario esta bloqueado', '2023-05-18 03:19:05'),
(539, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador intentó ingresar al sistema, pero su usuario esta bloqueado', '2023-05-18 03:20:08'),
(540, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador intentó ingresar al sistema, pero su usuario esta bloqueado', '2023-05-18 03:20:35'),
(541, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador intentó ingresar al sistema, pero su usuario esta bloqueado', '2023-05-18 03:21:23'),
(542, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador intentó ingresar al sistema, pero su usuario esta bloqueado', '2023-05-18 03:23:32'),
(543, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 03:23:48'),
(544, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador falló al ingresar al sistema (credenciales incorrectas), intento 1', '2023-05-18 03:24:40'),
(545, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 03:24:47'),
(546, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-18 03:25:26'),
(547, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 03:25:35'),
(548, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó la empresa: TESTEOA', '2023-05-18 03:25:48'),
(549, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el control: Control 20', '2023-05-18 03:26:36'),
(550, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el plan de acción: PlanA', '2023-05-18 03:27:09'),
(551, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-18 03:27:24'),
(552, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador falló al ingresar al sistema (credenciales incorrectas), intento 1', '2023-05-18 11:53:59'),
(553, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 11:54:06'),
(554, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó la empresa: TESTEOB', '2023-05-18 11:54:22'),
(555, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-18 11:55:51'),
(556, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador falló al ingresar al sistema (credenciales incorrectas), intento 1', '2023-05-18 11:55:59'),
(557, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 11:56:06'),
(558, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó la empresa: Efectiva SA', '2023-05-18 11:56:20'),
(559, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó la empresa: TESTEOB', '2023-05-18 12:01:08'),
(560, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el área: AREAC', '2023-05-18 12:12:27'),
(561, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó el área: RECURSOS HUMANOS', '2023-05-18 12:12:40'),
(562, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó el área: AREAC', '2023-05-18 12:15:28'),
(563, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó la unidad: PLANEAMIENTO', '2023-05-18 12:35:26'),
(564, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó la unidad: UnidadB', '2023-05-18 12:35:34'),
(565, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó la unidad: UnidadB', '2023-05-18 12:35:51'),
(566, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el macroproceso: MACROPROCESO PLANEAMIENTO', '2023-05-18 12:44:10'),
(567, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-18 12:44:46'),
(568, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 12:44:50'),
(569, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó el macroproceso: MACROPROCESO PLANEAMIENTO', '2023-05-18 12:46:06'),
(570, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el proceso: PROCESO A', '2023-05-18 13:00:11'),
(571, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó el proceso: PROCESO A', '2023-05-18 13:01:10'),
(572, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó la posición: SUBGERENTE RH', '2023-05-18 13:09:47'),
(573, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó la posición: SUBGERENTE RH', '2023-05-18 13:11:03'),
(574, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el aspecto de seguridad: ConfidencialidadA', '2023-05-18 13:11:17'),
(575, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó el aspecto de seguridad: ConfidencialidadA', '2023-05-18 13:11:21'),
(576, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó el aspecto de seguridad: Confidencialidada', '2023-05-18 13:17:30'),
(577, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó el aspecto de seguridad: Confidencialidad', '2023-05-18 13:17:36'),
(578, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el aspecto de seguridad: NUEVO', '2023-05-18 13:18:45'),
(579, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó el aspecto de seguridad: NUEVO', '2023-05-18 13:18:50'),
(580, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó el valor de activo: NO SIGNIFICATIVOO', '2023-05-18 13:25:18'),
(581, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el valor de activo: MUY ALTO', '2023-05-18 13:27:46'),
(582, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó el valor de activo: MUY ALTO', '2023-05-18 13:27:52'),
(583, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el valor de activo: MUY ALTO', '2023-05-18 13:43:10'),
(584, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó el valor de activo: MUY ALTO', '2023-05-18 13:43:15'),
(585, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó la valoración de activo: 1', '2023-05-18 13:50:22'),
(586, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó la valoración de activo: 7', '2023-05-18 13:55:37'),
(587, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó la valoración de activo: 7', '2023-05-18 13:56:39'),
(588, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó la valoración de activo: 6', '2023-05-18 14:02:03'),
(589, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el tipo de activo: TIPOACTIVOC', '2023-05-18 14:08:57'),
(590, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó el tipo de activo: ELECTRÓNICO', '2023-05-18 14:12:18'),
(591, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó el tipo de activo: ELECTRÓNICOS', '2023-05-18 14:12:29'),
(592, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó el tipo de activo: ELECTRÓNICOS', '2023-05-18 14:13:29'),
(593, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó la categoría de activo: SOFTWARE', '2023-05-18 14:18:09'),
(594, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó la categoría de activo: SOFTWAREE', '2023-05-18 14:18:17'),
(595, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó la categoría de activo: SOFTWARE', '2023-05-18 14:18:22'),
(596, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó la categoría  de activo: SOFTWARE', '2023-05-18 14:21:37'),
(597, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó la ubicación de activo: INFRAESTRUCTURAA', '2023-05-18 14:26:27'),
(598, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó la ubicación  de activo: INFRAESTRUCTURAA', '2023-05-18 14:30:47'),
(599, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó la clasificacion de la información: CONFIDENCIAL', '2023-05-18 14:36:26'),
(600, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó la clasificación de la información: CONFIDENCIAL', '2023-05-18 14:37:01'),
(601, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó la clasificacion de la información: CLASIFICAICONA', '2023-05-18 14:37:54'),
(602, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó la clasificacion de la información: CLASIFICAICONB', '2023-05-18 14:38:01'),
(603, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-18 14:45:40'),
(604, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 19:41:06'),
(605, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el proceso: PROCEAA', '2023-05-18 20:10:16'),
(606, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó el proceso: PROCEAAa', '2023-05-18 20:10:32'),
(607, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó la unidad: UNIDADA', '2023-05-18 20:12:20'),
(608, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el macroproceso: MACROTESTEO', '2023-05-18 20:13:57'),
(609, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó la posición: GERENTE DE RHH', '2023-05-18 20:15:28'),
(610, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó la valoración de activo: 2', '2023-05-18 20:23:18'),
(611, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó la valoración de activo: 8', '2023-05-18 20:23:26'),
(612, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó la valoración de activo: 8', '2023-05-18 20:23:31'),
(613, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó la probabilidad: PROBABILIDAD', '2023-05-18 20:33:21'),
(614, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó el impacto: IMPACTO', '2023-05-18 20:33:26'),
(615, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el impacto: muy allto', '2023-05-18 20:58:31'),
(616, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó la probabilidad: muy allto', '2023-05-18 20:59:19'),
(617, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó la probabilidad: muy allto', '2023-05-18 20:59:24'),
(618, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó el impacto: muy allto', '2023-05-18 20:59:32'),
(619, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó el impacto: IMPACTO', '2023-05-18 20:59:44'),
(620, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó la probabilidad: PROBABILIDAD', '2023-05-18 20:59:51'),
(621, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el nivel de riesgo: EXTREMO', '2023-05-18 21:01:54'),
(622, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó el nivel de riesgo: EXTREMO', '2023-05-18 21:21:35'),
(623, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó la prioridad: Muy alta', '2023-05-18 22:37:59'),
(624, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó la prioridad: Extrema', '2023-05-18 22:38:50'),
(625, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó la prioridad: Muy altaaaa', '2023-05-18 22:39:12'),
(626, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el estado: Nueva', '2023-05-18 22:41:02'),
(627, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó el estado: Nueva', '2023-05-18 22:41:06'),
(628, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-18 22:56:01'),
(629, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 22:56:06'),
(630, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el inventario de clasificación y activos: ActivoC', '2023-05-18 22:57:11'),
(631, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó el inventario de clasificación y activos: ActivoC', '2023-05-18 23:06:57'),
(632, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el inventario de clasificación y activos: ActivoD', '2023-05-18 23:10:57'),
(633, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó el inventario de clasificación y activos: ActivoD', '2023-05-18 23:12:09'),
(634, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador exportó la información historia de inventario de clasificación y activos por usuario', '2023-05-18 23:12:21'),
(635, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el inventario de clasificación y activos: ACTIVOE', '2023-05-18 23:14:13'),
(636, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó el inventario de clasificación y activos: ACTIVOE', '2023-05-18 23:14:20'),
(637, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el inventario de clasificación y activos: ACTIVOF', '2023-05-18 23:18:12'),
(638, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó el inventario de clasificación y activos: ACTIVOF', '2023-05-18 23:18:23'),
(639, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el inventario de clasificación y activos: ACTIVOG', '2023-05-18 23:21:18'),
(640, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-18 23:21:30'),
(641, 'Opera 98.0.0.0', '::1', 5, 'El usuario: testeo1 falló al ingresar al sistema (credenciales incorrectas), intento 1', '2023-05-18 23:21:42'),
(642, 'Opera 98.0.0.0', '::1', 5, 'El usuario: testeo1 inició sesión exitosamente', '2023-05-18 23:21:50'),
(643, 'Opera 98.0.0.0', '::1', 5, 'El usuario testeo1 modificó el inventario de clasificación y activos: ActivoB', '2023-05-18 23:23:06'),
(644, 'Opera 98.0.0.0', '::1', 5, 'El usuario testeo1 exportó la información historia de inventario de clasificación y activos', '2023-05-18 23:23:30'),
(645, 'Opera 98.0.0.0', '::1', 5, 'El usuario testeo1 modificó el inventario de clasificación y activos: ActivoB', '2023-05-18 23:25:36'),
(646, 'Opera 98.0.0.0', '::1', 5, 'El usuario: testeo1 cerró sesión correctamente desde el sistema', '2023-05-18 23:31:26'),
(647, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador falló al ingresar al sistema (credenciales incorrectas), intento 1', '2023-05-18 23:31:41'),
(648, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-18 23:31:45'),
(649, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador deslogueó por inactividad', '2023-05-19 01:22:20'),
(650, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-19 02:44:21'),
(651, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó el inventario de clasificación y activos: ActivoB', '2023-05-19 02:47:05'),
(652, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-19 07:51:06'),
(653, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-19 08:02:08'),
(654, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador inició sesión exitosamente', '2023-05-19 11:17:04'),
(655, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el inventario de clasificación y activos: ActivoZ', '2023-05-19 11:18:22'),
(656, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el inventario de clasificación y activos: ActivoZZ', '2023-05-19 11:21:54'),
(657, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el inventario de clasificación y activos: ActivoZZZz', '2023-05-19 11:24:14'),
(658, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el inventario de clasificación y activos: ActivoAaaa', '2023-05-19 11:25:08'),
(659, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el inventario de clasificación y activos: ActivoBBB', '2023-05-19 11:27:56'),
(660, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó la evaluacion de riesgo: RiesgoA', '2023-05-19 13:23:10'),
(661, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó la evaluación de riesgo: RiesgoA', '2023-05-19 13:23:14'),
(662, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador eliminó el control: Control 20', '2023-05-19 13:23:23'),
(663, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el inventario de clasificación y activos: ActivoA', '2023-05-19 14:00:53'),
(664, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador creó el inventario de clasificación y activos: ActivoB', '2023-05-19 14:01:30'),
(665, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó el inventario de clasificación y activos: ActivoA', '2023-05-19 14:01:47'),
(666, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó el inventario de clasificación y activos: ActivoB', '2023-05-19 14:01:56'),
(667, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó el inventario de clasificación y activos: ActivoA', '2023-05-19 14:03:56'),
(668, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó el inventario de clasificación y activos: ActivoB', '2023-05-19 14:04:04'),
(669, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó el inventario de clasificación y activos: ActivoA', '2023-05-19 14:05:44'),
(670, 'Opera 98.0.0.0', '::1', 1, 'El usuario administrador modificó el inventario de clasificación y activos: ActivoB', '2023-05-19 14:05:51'),
(671, 'Opera 98.0.0.0', '::1', 1, 'El usuario: administrador cerró sesión correctamente desde el sistema', '2023-05-19 14:24:10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `macroproceso`
--

CREATE TABLE `macroproceso` (
  `id` int(11) NOT NULL,
  `macroproceso` varchar(150) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `idempresa` int(11) DEFAULT NULL,
  `idarea` int(11) DEFAULT NULL,
  `idunidades` int(11) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `macroproceso`
--

INSERT INTO `macroproceso` (`id`, `macroproceso`, `estado`, `idempresa`, `idarea`, `idunidades`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`) VALUES
(1, 'MacroA', 1, 3, 2, 1, 1, '2023-05-03 11:09:33.000000', NULL, '2023-05-18 12:35:26.000000', NULL, NULL, 0),
(2, 'MacroB', 1, 3, 3, 2, 1, '2023-05-03 11:09:51.000000', NULL, '2023-05-18 11:56:20.000000', NULL, NULL, 0),
(3, 'MACROPROCESO PLANEAMIENTO', 1, 3, 2, 1, 1, '2023-05-18 12:44:10.000000', NULL, '2023-05-18 12:46:06.000000', 1, '2023-05-18 12:46:06.000000', 1),
(4, 'MACROTESTEO', 1, 3, 2, 1, 1, '2023-05-18 20:13:57.000000', NULL, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nivel_riesgo`
--

CREATE TABLE `nivel_riesgo` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(150) NOT NULL,
  `operador1` varchar(150) DEFAULT NULL,
  `valor1` int(11) DEFAULT NULL,
  `operador2` varchar(150) DEFAULT NULL,
  `valor2` int(11) DEFAULT NULL,
  `color` varchar(150) DEFAULT NULL,
  `comentario` varchar(150) NOT NULL,
  `estado` int(11) NOT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `nivel_riesgo`
--

INSERT INTO `nivel_riesgo` (`id`, `descripcion`, `operador1`, `valor1`, `operador2`, `valor2`, `color`, `comentario`, `estado`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`) VALUES
(1, 'RARO', '>', 1000, '<=', 4000, '#000000', 'RARO', 1, 1, '2023-05-07 18:24:03.000000', NULL, '2023-05-08 10:53:58.000000', 1, '2023-05-08 10:53:58.000000', 1),
(2, 'PROBABLE', '>', 4000, '<=', 8000, '#000000', 'PROBABLE', 1, 1, '2023-05-07 18:24:20.000000', NULL, '2023-05-07 18:52:28.000000', 1, '2023-05-07 18:52:27.000000', 1),
(3, 'PROBABLE', '>', 4000, '<=', 30000, '#000000', 'PROBABLE', 1, 1, '2023-05-07 18:54:12.000000', 1, '2023-05-08 10:53:46.000000', 1, '2023-05-08 10:53:46.000000', 1),
(4, 'RARO', '>=', 1000, '<', 4000, '#000000', 'RARO', 1, 1, '2023-05-08 10:58:55.000000', NULL, '2023-05-08 12:55:01.000000', 1, '2023-05-08 12:55:00.000000', 1),
(5, 'PROBABLE', '>=', 4000, '<', 30000, '#000000', 'PROBABLE', 1, 1, '2023-05-08 10:59:15.000000', NULL, '2023-05-08 12:52:48.000000', 1, '2023-05-08 12:52:48.000000', 1),
(6, 'RARO', '>', 1, '<', 5, '#000000', 'RARO', 1, 1, '2023-05-08 17:56:54.000000', NULL, NULL, NULL, NULL, 0),
(7, 'PROBABLE', '>=', 5, '<=', 5000, '#000000', 'PROBABLE', 1, 1, '2023-05-08 17:57:15.000000', 1, '2023-05-08 17:57:35.000000', NULL, NULL, 0),
(8, 'MUY PROBABLE', '>', 5000, '<=', 100000, '#000000', 'MUY PROBABLE', 1, 1, '2023-05-08 18:05:33.000000', 1, '2023-05-08 18:58:07.000000', 1, '2023-05-08 18:58:06.000000', 1),
(9, 'MUY PROBABLE', '>', 5000, '<=', 60000, '#000000', 'MUY PROBABLE', 1, 1, '2023-05-09 18:06:04.000000', NULL, NULL, NULL, NULL, 0),
(10, 'EXTREMO', '>', 100000000, '<', 200000000, '#000000', 'EXTREMO', 1, 1, '2023-05-18 21:01:54.000000', NULL, '2023-05-18 21:21:35.000000', 1, '2023-05-18 21:21:34.000000', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pais`
--

CREATE TABLE `pais` (
  `id` int(11) NOT NULL,
  `paisnombre` varchar(250) NOT NULL,
  `continente` varchar(250) DEFAULT NULL,
  `codigoPais` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pais`
--

INSERT INTO `pais` (`id`, `paisnombre`, `continente`, `codigoPais`) VALUES
(1, 'Australia', 'NULL', NULL),
(2, 'Austria', 'NULL', NULL),
(3, 'Azerbaiyán', 'NULL', NULL),
(4, 'Anguilla', 'NULL', NULL),
(5, 'Argentina', 'América', NULL),
(6, 'Armenia', 'NULL', NULL),
(7, 'Bielorrusia', 'NULL', NULL),
(8, 'Belice', 'América', NULL),
(9, 'Bélgica', 'NULL', NULL),
(10, 'Bermudas', 'NULL', NULL),
(11, 'Bulgaria', 'NULL', NULL),
(12, 'Brasil', 'América', NULL),
(13, 'Reino Unido', 'NULL', NULL),
(14, 'Hungría', 'NULL', NULL),
(15, 'Vietnam', 'NULL', NULL),
(16, 'Haiti', 'América', NULL),
(17, 'Guadalupe', 'NULL', NULL),
(18, 'Alemania', 'NULL', NULL),
(19, 'Países Bajos, Holanda', 'NULL', NULL),
(20, 'Grecia', 'NULL', NULL),
(21, 'Georgia', 'NULL', NULL),
(22, 'Dinamarca', 'NULL', NULL),
(23, 'Egipto', 'NULL', NULL),
(24, 'Israel', 'NULL', NULL),
(25, 'India', 'NULL', NULL),
(26, 'Irán', 'NULL', NULL),
(27, 'Irlanda', 'NULL', NULL),
(28, 'España', 'NULL', NULL),
(29, 'Italia', 'NULL', NULL),
(30, 'Kazajstán', 'NULL', NULL),
(31, 'Camerún', 'NULL', NULL),
(32, 'Canadá', 'América', NULL),
(33, 'Chipre', 'NULL', NULL),
(34, 'Kirguistán', 'NULL', NULL),
(35, 'China', 'NULL', NULL),
(36, 'Costa Rica', 'América', NULL),
(37, 'Kuwait', 'NULL', NULL),
(38, 'Letonia', 'NULL', NULL),
(39, 'Libia', 'NULL', NULL),
(40, 'Lituania', 'NULL', NULL),
(41, 'Luxemburgo', 'NULL', NULL),
(42, 'México', 'América', NULL),
(43, 'Moldavia', 'NULL', NULL),
(44, 'Mónaco', 'NULL', NULL),
(45, 'Nueva Zelanda', 'NULL', NULL),
(46, 'Noruega', 'NULL', NULL),
(47, 'Polonia', 'NULL', NULL),
(48, 'Portugal', 'NULL', NULL),
(49, 'Reunión', 'NULL', NULL),
(50, 'Rusia', 'NULL', NULL),
(51, 'El Salvador', 'América', NULL),
(52, 'Eslovaquia', 'NULL', NULL),
(53, 'Eslovenia', 'NULL', NULL),
(54, 'Surinam', 'América', NULL),
(55, 'Estados Unidos', 'América', NULL),
(56, 'Tadjikistan', 'NULL', NULL),
(57, 'Turkmenistan', 'NULL', NULL),
(58, 'Islas Turcas y Caicos', 'NULL', NULL),
(59, 'Turquía', 'NULL', NULL),
(60, 'Uganda', 'NULL', NULL),
(61, 'Uzbekistán', 'NULL', NULL),
(62, 'Ucrania', 'NULL', NULL),
(63, 'Finlandia', 'NULL', NULL),
(64, 'Francia', 'NULL', NULL),
(65, 'República Checa', 'NULL', NULL),
(66, 'Suiza', 'NULL', NULL),
(67, 'Suecia', 'NULL', NULL),
(68, 'Estonia', 'NULL', NULL),
(69, 'Corea del Sur', 'NULL', NULL),
(70, 'Japón', 'NULL', NULL),
(71, 'Croacia', 'NULL', NULL),
(72, 'Rumanía', 'NULL', NULL),
(73, 'Hong Kong', 'NULL', NULL),
(74, 'Indonesia', 'NULL', NULL),
(75, 'Jordania', 'NULL', NULL),
(76, 'Malasia', 'NULL', NULL),
(77, 'Singapur', 'NULL', NULL),
(78, 'Taiwan', 'NULL', NULL),
(79, 'Bosnia y Herzegovina', 'NULL', NULL),
(80, 'Bahamas', 'América', NULL),
(81, 'Chile', 'América', NULL),
(82, 'Colombia', 'América', NULL),
(83, 'Islandia', 'NULL', NULL),
(84, 'Corea del Norte', 'NULL', NULL),
(85, 'Macedonia', 'NULL', NULL),
(86, 'Malta', 'NULL', NULL),
(87, 'Pakistán', 'NULL', NULL),
(88, 'Papúa-Nueva Guinea', 'NULL', NULL),
(89, 'Perú', 'América', NULL),
(90, 'Filipinas', 'NULL', NULL),
(91, 'Arabia Saudita', 'NULL', NULL),
(92, 'Tailandia', 'NULL', NULL),
(93, 'Emiratos árabes Unidos', 'NULL', NULL),
(94, 'Groenlandia', 'NULL', NULL),
(95, 'Venezuela', 'América', NULL),
(96, 'Zimbabwe', 'NULL', NULL),
(97, 'Kenia', 'NULL', NULL),
(98, 'Algeria', 'NULL', NULL),
(99, 'Líbano', 'NULL', NULL),
(100, 'Botsuana', 'Africa', NULL),
(101, 'Tanzania', 'NULL', NULL),
(102, 'Namibia', 'NULL', NULL),
(103, 'Ecuador', 'América', NULL),
(104, 'Marruecos', 'NULL', NULL),
(105, 'Ghana', 'NULL', NULL),
(106, 'Siria', 'NULL', NULL),
(107, 'Nepal', 'NULL', NULL),
(108, 'Mauritania', 'NULL', NULL),
(109, 'Seychelles', 'NULL', NULL),
(110, 'Paraguay', 'América', NULL),
(111, 'Uruguay', 'América', NULL),
(112, 'Congo (Brazzaville)', 'NULL', NULL),
(113, 'Cuba', 'América', NULL),
(114, 'Albania', 'NULL', NULL),
(115, 'Nigeria', 'NULL', NULL),
(116, 'Zambia', 'NULL', NULL),
(117, 'Mozambique', 'NULL', NULL),
(119, 'Angola', 'Africa', NULL),
(120, 'Sri Lanka', 'NULL', NULL),
(121, 'Etiopía', 'NULL', NULL),
(122, 'Túnez', 'NULL', NULL),
(123, 'Bolivia', 'América', NULL),
(124, 'Panamá', 'América', NULL),
(125, 'Malawi', 'NULL', NULL),
(126, 'Liechtenstein', 'NULL', NULL),
(127, 'Bahrein', 'NULL', NULL),
(128, 'Barbados', 'América', NULL),
(130, 'Chad', 'NULL', NULL),
(131, 'Man, Isla de', 'NULL', NULL),
(132, 'Jamaica', 'América', NULL),
(133, 'Malí', 'NULL', NULL),
(134, 'Madagascar', 'NULL', NULL),
(135, 'Senegal', 'NULL', NULL),
(136, 'Togo', 'NULL', NULL),
(137, 'Honduras', 'América', NULL),
(138, 'República Dominicana', 'América', NULL),
(139, 'Mongolia', 'NULL', NULL),
(140, 'Irak', 'NULL', NULL),
(141, 'Sudáfrica', 'NULL', NULL),
(142, 'Aruba', 'NULL', NULL),
(143, 'Gibraltar', 'NULL', NULL),
(144, 'Afganistán', 'NULL', NULL),
(145, 'Andorra', 'NULL', NULL),
(147, 'Antigua y Barbuda', 'América', NULL),
(149, 'Bangladesh', 'NULL', NULL),
(151, 'Benín', 'Africa', NULL),
(152, 'Bután', 'NULL', NULL),
(154, 'Islas Virgenes Británicas', 'NULL', NULL),
(155, 'Brunéi', 'NULL', NULL),
(156, 'Burkina Faso', 'Africa', NULL),
(157, 'Burundi', 'NULL', NULL),
(158, 'Camboya', 'NULL', NULL),
(159, 'Cabo Verde', 'NULL', NULL),
(164, 'Comores', 'NULL', NULL),
(165, 'Congo (Kinshasa)', 'NULL', NULL),
(166, 'Cook, Islas', 'NULL', NULL),
(168, 'Costa de Marfil', 'NULL', NULL),
(169, 'Djibouti, Yibuti', 'NULL', NULL),
(171, 'Timor Oriental', 'NULL', NULL),
(172, 'Guinea Ecuatorial', 'NULL', NULL),
(173, 'Eritrea', 'NULL', NULL),
(175, 'Feroe, Islas', 'NULL', NULL),
(176, 'Fiyi', 'NULL', NULL),
(178, 'Polinesia Francesa', 'NULL', NULL),
(180, 'Gabón', 'NULL', NULL),
(181, 'Gambia', 'NULL', NULL),
(184, 'Granada', 'América', NULL),
(185, 'Guatemala', 'América', NULL),
(186, 'Guernsey', 'NULL', NULL),
(187, 'Guinea', 'NULL', NULL),
(188, 'Guinea-Bissau', 'NULL', NULL),
(189, 'Guyana', 'América', NULL),
(193, 'Jersey', 'NULL', NULL),
(195, 'Kiribati', 'NULL', NULL),
(196, 'Laos', 'NULL', NULL),
(197, 'Lesotho', 'NULL', NULL),
(198, 'Liberia', 'NULL', NULL),
(200, 'Maldivas', 'NULL', NULL),
(201, 'Martinica', 'NULL', NULL),
(202, 'Mauricio', 'NULL', NULL),
(205, 'Myanmar', 'NULL', NULL),
(206, 'Nauru', 'NULL', NULL),
(207, 'Antillas Holandesas', 'NULL', NULL),
(208, 'Nueva Caledonia', 'NULL', NULL),
(209, 'Nicaragua', 'América', NULL),
(210, 'Níger', 'NULL', NULL),
(212, 'Norfolk Island', 'NULL', NULL),
(213, 'Omán', 'NULL', NULL),
(215, 'Isla Pitcairn', 'NULL', NULL),
(216, 'Qatar', 'NULL', NULL),
(217, 'Ruanda', 'NULL', NULL),
(218, 'Santa Elena', 'NULL', NULL),
(219, 'San Cristobal y Nevis', 'NULL', NULL),
(220, 'Santa Lucía', 'América', NULL),
(221, 'San Pedro y Miquelón', 'NULL', NULL),
(222, 'San Vincente y Granadinas', 'NULL', NULL),
(223, 'Samoa', 'NULL', NULL),
(224, 'San Marino', 'NULL', NULL),
(225, 'San Tomé y Príncipe', 'NULL', NULL),
(226, 'Serbia y Montenegro', 'NULL', NULL),
(227, 'Sierra Leona', 'NULL', NULL),
(228, 'Islas Salomón', 'NULL', NULL),
(229, 'Somalia', 'NULL', NULL),
(232, 'Sudán', 'NULL', NULL),
(234, 'Swazilandia', 'NULL', NULL),
(235, 'Tokelau', 'NULL', NULL),
(236, 'Tonga', 'NULL', NULL),
(237, 'Trinidad y Tobago', 'América', NULL),
(239, 'Tuvalu', 'NULL', NULL),
(240, 'Vanuatu', 'NULL', NULL),
(241, 'Wallis y Futuna', 'NULL', NULL),
(242, 'Sáhara Occidental', 'NULL', NULL),
(243, 'Yemen', 'NULL', NULL),
(246, 'Puerto Rico', 'NULL', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plan_accion`
--

CREATE TABLE `plan_accion` (
  `id` int(11) NOT NULL,
  `plan_accion` varchar(150) DEFAULT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  `fecha_inicio` datetime(6) DEFAULT NULL,
  `fecha_fin` datetime(6) DEFAULT NULL,
  `idempresa` int(11) DEFAULT NULL,
  `idarea` int(11) DEFAULT NULL,
  `idunidades` int(11) DEFAULT NULL,
  `idposicion_puesto` int(11) DEFAULT NULL,
  `idusuario` int(11) DEFAULT NULL,
  `idprioridad` int(11) DEFAULT NULL,
  `idestado` int(11) DEFAULT NULL,
  `idalerta` int(11) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0,
  `actividades` int(11) DEFAULT NULL,
  `id_riesgo` varchar(50) DEFAULT NULL,
  `id_control` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `plan_accion`
--

INSERT INTO `plan_accion` (`id`, `plan_accion`, `descripcion`, `fecha_inicio`, `fecha_fin`, `idempresa`, `idarea`, `idunidades`, `idposicion_puesto`, `idusuario`, `idprioridad`, `idestado`, `idalerta`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`, `actividades`, `id_riesgo`, `id_control`) VALUES
(13, 'PlanA', 'PlanA', '2023-05-11 00:00:00.000000', '2023-06-20 00:00:00.000000', 3, 2, 1, 1, 1, 1, 2, 1, 1, '2023-05-11 00:00:00.000000', 1, '2023-05-11 02:46:57.000000', 1, '2023-05-11 02:46:57.000000', 1, NULL, '23', '14'),
(14, 'PlanA', 'PlanA', '2023-05-11 00:00:00.000000', '2023-06-20 00:00:00.000000', 3, 2, 1, 1, 1, 1, 2, 1, 1, '2023-05-11 00:00:00.000000', 1, '2023-05-11 02:56:06.000000', 1, '2023-05-11 02:56:06.000000', 1, NULL, '21', '12'),
(15, 'PlanA', 'PlanA', '2023-05-11 00:00:00.000000', '2023-06-20 00:00:00.000000', 3, 2, 1, 1, 1, 1, 1, 1, 1, '2023-05-11 00:00:00.000000', NULL, '2023-05-12 22:40:32.000000', 1, '2023-05-12 22:40:32.000000', 1, NULL, '25', '16'),
(16, 'PlanA', 'PlanA', '2023-05-11 00:00:00.000000', '2023-06-20 00:00:00.000000', 3, 2, 1, 1, 1, 1, 2, 1, 1, '2023-05-11 00:00:00.000000', 1, '2023-05-16 18:02:55.000000', 1, '2023-05-16 18:02:55.000000', 1, NULL, '29', '18'),
(17, 'PlanA', 'PlanA', '2023-05-16 00:00:00.000000', '2023-06-20 00:00:00.000000', 3, 2, 1, 1, 5, 1, 4, 1, 1, '2023-05-16 00:00:00.000000', 1, '2023-05-17 01:41:31.000000', 1, '2023-05-17 01:41:31.000000', 1, NULL, '31', '19'),
(18, 'PlanA', 'PlanA', '2023-05-18 00:00:00.000000', '2023-06-20 00:00:00.000000', 3, 2, 1, 1, 1, 1, 1, 1, 1, '2023-05-18 00:00:00.000000', NULL, NULL, NULL, NULL, 0, NULL, '31', '20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `posicion_puesto`
--

CREATE TABLE `posicion_puesto` (
  `id` int(11) NOT NULL,
  `posicion_puesto` varchar(150) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `idempresa` int(11) DEFAULT NULL,
  `idarea` int(11) DEFAULT NULL,
  `idunidades` int(11) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `posicion_puesto`
--

INSERT INTO `posicion_puesto` (`id`, `posicion_puesto`, `estado`, `idempresa`, `idarea`, `idunidades`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`) VALUES
(1, 'PosicionA', 1, 3, 2, 1, 1, '2023-05-03 11:10:29.000000', NULL, '2023-05-18 12:35:26.000000', NULL, NULL, 0),
(2, 'PosicionB', 1, 3, 3, 2, 1, '2023-05-03 11:10:40.000000', NULL, '2023-05-18 11:56:20.000000', NULL, NULL, 0),
(3, 'SUBGERENTE RH', 1, 3, 2, 1, 1, '2023-05-18 13:09:47.000000', NULL, '2023-05-18 13:11:03.000000', 1, '2023-05-18 13:11:03.000000', 1),
(4, 'GERENTE DE RHH', 1, 3, 2, 1, 1, '2023-05-18 20:15:28.000000', NULL, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prioridad`
--

CREATE TABLE `prioridad` (
  `id` int(11) NOT NULL,
  `prioridad` varchar(150) DEFAULT NULL,
  `decripcion` varchar(150) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `prioridad`
--

INSERT INTO `prioridad` (`id`, `prioridad`, `decripcion`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`) VALUES
(1, 'Alta', 'Alta', 1, '2023-05-03 00:00:00.000000', NULL, NULL, NULL, NULL, 0),
(2, 'Media', 'Media', 1, '2023-05-03 00:00:00.000000', NULL, NULL, NULL, NULL, 0),
(3, 'Baja', 'Baja', 1, '2023-05-03 00:00:00.000000', NULL, NULL, NULL, NULL, 0),
(4, 'Muy alta', 'Muy alta', 1, '2023-05-18 00:00:00.000000', NULL, '2023-05-18 22:37:59.000000', 1, '2023-05-18 22:37:59.000000', 1),
(5, 'Muy altaaaa', 'Muy alta', 1, '2023-05-18 00:00:00.000000', 1, '2023-05-18 00:00:00.000000', NULL, NULL, 0),
(6, 'Extrema', 'Extrema', 1, '2023-05-18 00:00:00.000000', NULL, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `probabilidad_riesgo`
--

CREATE TABLE `probabilidad_riesgo` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  `tipo_regla` varchar(150) DEFAULT NULL,
  `tipo_valor` varchar(150) DEFAULT NULL,
  `formula` varchar(150) DEFAULT NULL,
  `operador1` varchar(150) DEFAULT NULL,
  `valor1` int(11) DEFAULT NULL,
  `operador2` varchar(150) DEFAULT NULL,
  `valor2` int(11) DEFAULT NULL,
  `comentario` varchar(150) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `escenario` int(11) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `probabilidad_riesgo`
--

INSERT INTO `probabilidad_riesgo` (`id`, `descripcion`, `tipo_regla`, `tipo_valor`, `formula`, `operador1`, `valor1`, `operador2`, `valor2`, `comentario`, `estado`, `escenario`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`) VALUES
(1, 'RARO', '2 Valores', 'Numero', NULL, '>', 1, '<=', 5, 'RARO', 2, 2, 1, '2023-05-07 18:22:26.000000', 1, '2023-05-08 18:52:36.000000', NULL, NULL, 0),
(2, 'PROBABLE', '2 Valores', 'Numero', NULL, '>', 5, '<=', 10, 'PROBABLE', 2, 2, 1, '2023-05-07 18:22:43.000000', NULL, '2023-05-07 18:34:12.000000', 1, '2023-05-07 18:34:11.000000', 1),
(3, 'PROBABLE', '2 Valores', 'Numero', NULL, '>', 5, '<=', 10, 'PROBABLE', 2, 2, 1, '2023-05-07 18:34:34.000000', 1, '2023-05-08 18:52:41.000000', NULL, NULL, 0),
(4, 'PROBABILIDAD', '1 Valor', 'Numero', '', NULL, NULL, NULL, NULL, 'PROBABILIDAD', 2, 1, 1, '2023-05-07 18:42:33.000000', 1, '2023-05-08 10:51:51.000000', 1, '2023-05-08 10:51:50.000000', 1),
(5, 'PROBABILIDAD', '1 Valor', 'Numero', '', NULL, NULL, NULL, NULL, 'PROBABILIDAD', 2, 1, 1, '2023-05-08 10:54:33.000000', 1, '2023-05-08 11:47:15.000000', 1, '2023-05-08 11:47:15.000000', 1),
(6, 'PROBABILIDAD', '1 Valor', 'Numero', '> 1 RARO > 5 PROBABLE', NULL, NULL, NULL, NULL, 'PROBABILIDAD', 2, 1, 1, '2023-05-08 11:48:02.000000', 1, '2023-05-08 18:58:14.000000', 1, '2023-05-08 18:58:13.000000', 1),
(7, 'PROBABILIDAD', '1 Valor', 'Numero', '', NULL, NULL, NULL, NULL, 'PROBABILIDAD', 1, 1, 1, '2023-05-09 18:04:55.000000', 1, '2023-05-18 20:59:51.000000', NULL, NULL, 0),
(8, 'muy allto', '2 Valores', 'Numero', NULL, '>', 100, '<=', 2000, 'muy allto', 2, 2, 1, '2023-05-18 20:59:19.000000', NULL, '2023-05-18 20:59:24.000000', 1, '2023-05-18 20:59:23.000000', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proceso`
--

CREATE TABLE `proceso` (
  `id` int(11) NOT NULL,
  `proceso` varchar(150) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `idempresa` int(11) DEFAULT NULL,
  `idarea` int(11) DEFAULT NULL,
  `idunidades` int(11) DEFAULT NULL,
  `idmacroproceso` int(11) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proceso`
--

INSERT INTO `proceso` (`id`, `proceso`, `estado`, `idempresa`, `idarea`, `idunidades`, `idmacroproceso`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`) VALUES
(1, 'ProceA', 1, 3, 2, 1, 1, 1, '2023-05-03 11:10:06.000000', NULL, '2023-05-18 12:35:26.000000', NULL, NULL, 0),
(2, 'ProceB', 1, 3, 3, 2, 2, 1, '2023-05-03 11:10:17.000000', NULL, '2023-05-18 11:56:20.000000', NULL, NULL, 0),
(3, 'PROCESO A', 1, 3, 2, 1, 1, 1, '2023-05-18 13:00:11.000000', NULL, '2023-05-18 13:01:10.000000', 1, '2023-05-18 13:01:10.000000', 1),
(4, 'PROCEAAa', 1, 3, 2, 1, 1, 1, '2023-05-18 20:10:16.000000', 1, '2023-05-18 20:10:32.000000', NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_controles`
--

CREATE TABLE `registro_controles` (
  `id` int(11) NOT NULL,
  `IDR` varchar(30) DEFAULT NULL,
  `riesgo` varchar(100) DEFAULT NULL,
  `IDC` varchar(30) DEFAULT NULL,
  `nom_control` varchar(100) DEFAULT NULL,
  `idCobertura` int(11) DEFAULT NULL,
  `evaluacion` varchar(30) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0,
  `idevaluacion_control2` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sysdiagrams`
--

CREATE TABLE `sysdiagrams` (
  `name` varchar(160) NOT NULL,
  `principal_id` int(11) NOT NULL,
  `diagram_id` int(11) NOT NULL,
  `version` int(11) DEFAULT NULL,
  `definition` longblob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_detalle_perfil`
--

CREATE TABLE `tb_detalle_perfil` (
  `id_det_per` int(11) NOT NULL,
  `id_perfil` int(11) NOT NULL,
  `view_det` int(11) DEFAULT NULL,
  `create_det` int(11) DEFAULT NULL,
  `update_det` int(11) DEFAULT NULL,
  `delete_det` int(11) DEFAULT NULL,
  `tabla` varchar(50) DEFAULT NULL,
  `id` int(11) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tb_detalle_perfil`
--

INSERT INTO `tb_detalle_perfil` (`id_det_per`, `id_perfil`, `view_det`, `create_det`, `update_det`, `delete_det`, `tabla`, `id`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`) VALUES
(1, 1, 1, 1, 1, 1, 'tb_modulo', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2, 1, 1, 1, 1, 1, 'tb_modulo', 2, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(3, 1, 1, 1, 1, 1, 'tb_modulo', 3, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(4, 1, 1, 1, 1, 1, 'tb_opcion', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(5, 1, 1, 1, 1, 1, 'tb_opcion', 2, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(6, 1, 1, 1, 1, 1, 'tb_opcion', 3, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(7, 1, 1, 1, 1, 1, 'tb_opcion', 4, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(8, 1, 1, 1, 1, 1, 'tb_opcion', 5, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(9, 1, 1, 1, 1, 1, 'tb_opcion', 6, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(10, 1, 1, 1, 1, 0, 'tb_opcion', 7, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(11, 1, 1, 1, 1, 1, 'tb_opcion', 8, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(12, 1, 1, 1, 1, 1, 'tb_opcion', 9, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(13, 1, 1, 1, 1, 1, 'tb_opcion', 10, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(14, 1, 1, 1, 1, 1, 'tb_opcion', 11, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(15, 1, 1, 1, 1, 1, 'tb_item', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(16, 1, 1, 1, 1, 1, 'tb_item', 13, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(17, 1, 1, 1, 1, 1, 'tb_item', 12, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(18, 1, 1, 1, 1, 1, 'tb_item', 11, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(19, 1, 1, 1, 1, 1, 'tb_item', 10, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(20, 1, 1, 1, 1, 1, 'tb_item', 9, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(21, 1, 1, 1, 1, 1, 'tb_item', 8, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(22, 1, 1, 1, 1, 1, 'tb_item', 7, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(23, 1, 1, 1, 1, 1, 'tb_item', 2, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(24, 1, 1, 1, 1, 1, 'tb_item', 3, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(25, 1, 1, 1, 1, 1, 'tb_item', 4, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(26, 1, 1, 1, 1, 1, 'tb_item', 5, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(27, 1, 1, 1, 1, 1, 'tb_item', 6, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(28, 1, 1, 1, 1, 1, 'tb_item', 23, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(29, 1, 1, 1, 1, 1, 'tb_item', 22, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(30, 1, 1, 1, 1, 1, 'tb_item', 21, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(31, 1, 1, 1, 1, 1, 'tb_item', 20, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(32, 1, 1, 1, 1, 1, 'tb_item', 19, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(33, 1, 1, 1, 1, 1, 'tb_item', 18, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(34, 1, 1, 1, 1, 1, 'tb_item', 17, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(35, 1, 1, 1, 1, 1, 'tb_item', 16, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(36, 1, 1, 1, 1, 1, 'tb_item', 15, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(37, 1, 1, 1, 1, 1, 'tb_item', 14, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(38, 1, 1, 1, 1, 1, 'tb_item', 27, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(39, 1, 1, 1, 1, 1, 'tb_item', 26, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(40, 1, 1, 1, 1, 1, 'tb_item', 25, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(41, 1, 1, 1, 1, 1, 'tb_item', 24, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(42, 1, 1, 1, 1, 1, 'tb_item', 31, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(43, 1, 1, 1, 1, 1, 'tb_item', 28, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(44, 1, 1, 1, 1, 1, 'tb_item', 29, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(45, 1, 1, 1, 1, 1, 'tb_item', 30, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(46, 3, 0, 0, 0, 0, 'tb_modulo', 1, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(47, 3, 0, 0, 0, 0, 'tb_modulo', 2, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(48, 3, 0, 0, 0, 0, 'tb_modulo', 3, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(49, 3, 0, 0, 0, 0, 'tb_opcion', 1, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(50, 3, 0, 0, 0, 0, 'tb_opcion', 2, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(51, 3, 0, 0, 0, 0, 'tb_opcion', 3, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(52, 3, 0, 0, 0, 0, 'tb_opcion', 4, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(53, 3, 0, 0, 0, 0, 'tb_opcion', 5, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(54, 3, 0, 0, 0, 0, 'tb_opcion', 6, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(55, 3, 0, 0, 0, 0, 'tb_opcion', 7, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(56, 3, 0, 0, 0, 0, 'tb_opcion', 8, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(57, 3, 0, 0, 0, 0, 'tb_opcion', 9, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(58, 3, 0, 0, 0, 0, 'tb_opcion', 10, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(59, 3, 0, 0, 0, 0, 'tb_opcion', 11, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(60, 3, 0, 0, 0, 0, 'tb_item', 1, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(61, 3, 0, 0, 0, 0, 'tb_item', 13, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(62, 3, 0, 0, 0, 0, 'tb_item', 12, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(63, 3, 0, 0, 0, 0, 'tb_item', 11, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(64, 3, 0, 0, 0, 0, 'tb_item', 10, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(65, 3, 0, 0, 0, 0, 'tb_item', 9, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(66, 3, 0, 0, 0, 0, 'tb_item', 8, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(67, 3, 0, 0, 0, 0, 'tb_item', 7, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(68, 3, 0, 0, 0, 0, 'tb_item', 2, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(69, 3, 0, 0, 0, 0, 'tb_item', 3, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(70, 3, 0, 0, 0, 0, 'tb_item', 4, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(71, 3, 0, 0, 0, 0, 'tb_item', 5, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(72, 3, 0, 0, 0, 0, 'tb_item', 6, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(73, 3, 0, 0, 0, 0, 'tb_item', 23, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(74, 3, 0, 0, 0, 0, 'tb_item', 22, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(75, 3, 0, 0, 0, 0, 'tb_item', 21, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(76, 3, 0, 0, 0, 0, 'tb_item', 20, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(77, 3, 0, 0, 0, 0, 'tb_item', 19, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(78, 3, 0, 0, 0, 0, 'tb_item', 18, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(79, 3, 0, 0, 0, 0, 'tb_item', 17, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(80, 3, 0, 0, 0, 0, 'tb_item', 16, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(81, 3, 0, 0, 0, 0, 'tb_item', 15, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(82, 3, 0, 0, 0, 0, 'tb_item', 14, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(83, 3, 0, 0, 0, 0, 'tb_item', 27, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(84, 3, 0, 0, 0, 0, 'tb_item', 26, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(85, 3, 0, 0, 0, 0, 'tb_item', 25, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(86, 3, 0, 0, 0, 0, 'tb_item', 24, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(87, 3, 0, 0, 0, 0, 'tb_item', 31, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(88, 3, 0, 0, 0, 0, 'tb_item', 28, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(89, 3, 0, 0, 0, 0, 'tb_item', 29, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(90, 3, 0, 0, 0, 0, 'tb_item', 30, NULL, NULL, NULL, '2023-05-02 00:02:43', 3, '2023-05-02 00:02:43', 1),
(91, 4, 0, 0, 0, 0, 'tb_modulo', 1, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(92, 4, 0, 0, 0, 0, 'tb_modulo', 2, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(93, 4, 0, 0, 0, 0, 'tb_modulo', 3, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(94, 4, 0, 0, 0, 0, 'tb_opcion', 1, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(95, 4, 0, 0, 0, 0, 'tb_opcion', 2, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(96, 4, 0, 0, 0, 0, 'tb_opcion', 3, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(97, 4, 0, 0, 0, 0, 'tb_opcion', 4, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(98, 4, 0, 0, 0, 0, 'tb_opcion', 5, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(99, 4, 0, 0, 0, 0, 'tb_opcion', 6, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(100, 4, 0, 0, 0, 0, 'tb_opcion', 7, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(101, 4, 0, 0, 0, 0, 'tb_opcion', 8, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(102, 4, 0, 0, 0, 0, 'tb_opcion', 9, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(103, 4, 0, 0, 0, 0, 'tb_opcion', 10, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(104, 4, 0, 0, 0, 0, 'tb_opcion', 11, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(105, 4, 0, 0, 0, 0, 'tb_item', 1, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(106, 4, 0, 0, 0, 0, 'tb_item', 13, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(107, 4, 0, 0, 0, 0, 'tb_item', 12, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(108, 4, 0, 0, 0, 0, 'tb_item', 11, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(109, 4, 0, 0, 0, 0, 'tb_item', 10, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(110, 4, 0, 0, 0, 0, 'tb_item', 9, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(111, 4, 0, 0, 0, 0, 'tb_item', 8, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(112, 4, 0, 0, 0, 0, 'tb_item', 7, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(113, 4, 0, 0, 0, 0, 'tb_item', 2, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(114, 4, 0, 0, 0, 0, 'tb_item', 3, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(115, 4, 0, 0, 0, 0, 'tb_item', 4, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(116, 4, 0, 0, 0, 0, 'tb_item', 5, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(117, 4, 0, 0, 0, 0, 'tb_item', 6, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(118, 4, 0, 0, 0, 0, 'tb_item', 23, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(119, 4, 0, 0, 0, 0, 'tb_item', 22, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(120, 4, 0, 0, 0, 0, 'tb_item', 21, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(121, 4, 0, 0, 0, 0, 'tb_item', 20, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(122, 4, 0, 0, 0, 0, 'tb_item', 19, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(123, 4, 0, 0, 0, 0, 'tb_item', 18, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(124, 4, 0, 0, 0, 0, 'tb_item', 17, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(125, 4, 0, 0, 0, 0, 'tb_item', 16, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(126, 4, 0, 0, 0, 0, 'tb_item', 15, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(127, 4, 0, 0, 0, 0, 'tb_item', 14, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(128, 4, 0, 0, 0, 0, 'tb_item', 27, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(129, 4, 0, 0, 0, 0, 'tb_item', 26, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(130, 4, 0, 0, 0, 0, 'tb_item', 25, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(131, 4, 0, 0, 0, 0, 'tb_item', 24, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(132, 4, 0, 0, 0, 0, 'tb_item', 31, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(133, 4, 0, 0, 0, 0, 'tb_item', 28, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(134, 4, 0, 0, 0, 0, 'tb_item', 29, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(135, 4, 0, 0, 0, 0, 'tb_item', 30, NULL, NULL, NULL, '2023-05-02 14:46:56', 1, '2023-05-02 14:46:56', 1),
(136, 5, 0, 0, 0, 0, 'tb_modulo', 1, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(137, 5, 0, 0, 0, 0, 'tb_modulo', 2, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(138, 5, 0, 0, 0, 0, 'tb_modulo', 3, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(139, 5, 0, 0, 0, 0, 'tb_opcion', 1, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(140, 5, 0, 0, 0, 0, 'tb_opcion', 2, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(141, 5, 0, 0, 0, 0, 'tb_opcion', 3, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(142, 5, 0, 0, 0, 0, 'tb_opcion', 4, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(143, 5, 0, 0, 0, 0, 'tb_opcion', 5, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(144, 5, 0, 0, 0, 0, 'tb_opcion', 6, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(145, 5, 0, 0, 0, 0, 'tb_opcion', 7, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(146, 5, 0, 0, 0, 0, 'tb_opcion', 8, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(147, 5, 0, 0, 0, 0, 'tb_opcion', 9, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(148, 5, 0, 0, 0, 0, 'tb_opcion', 10, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(149, 5, 0, 0, 0, 0, 'tb_opcion', 11, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(150, 5, 0, 0, 0, 0, 'tb_item', 1, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(151, 5, 0, 0, 0, 0, 'tb_item', 13, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(152, 5, 0, 0, 0, 0, 'tb_item', 12, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(153, 5, 0, 0, 0, 0, 'tb_item', 11, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(154, 5, 0, 0, 0, 0, 'tb_item', 10, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(155, 5, 0, 0, 0, 0, 'tb_item', 9, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(156, 5, 0, 0, 0, 0, 'tb_item', 8, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(157, 5, 0, 0, 0, 0, 'tb_item', 7, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(158, 5, 0, 0, 0, 0, 'tb_item', 2, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(159, 5, 0, 0, 0, 0, 'tb_item', 3, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(160, 5, 0, 0, 0, 0, 'tb_item', 4, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(161, 5, 0, 0, 0, 0, 'tb_item', 5, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(162, 5, 0, 0, 0, 0, 'tb_item', 6, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(163, 5, 0, 0, 0, 0, 'tb_item', 23, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(164, 5, 0, 0, 0, 0, 'tb_item', 22, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(165, 5, 0, 0, 0, 0, 'tb_item', 21, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(166, 5, 0, 0, 0, 0, 'tb_item', 20, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(167, 5, 0, 0, 0, 0, 'tb_item', 19, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(168, 5, 0, 0, 0, 0, 'tb_item', 18, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(169, 5, 0, 0, 0, 0, 'tb_item', 17, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(170, 5, 0, 0, 0, 0, 'tb_item', 16, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(171, 5, 0, 0, 0, 0, 'tb_item', 15, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(172, 5, 0, 0, 0, 0, 'tb_item', 14, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(173, 5, 0, 0, 0, 0, 'tb_item', 27, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(174, 5, 0, 0, 0, 0, 'tb_item', 26, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(175, 5, 0, 0, 0, 0, 'tb_item', 25, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(176, 5, 0, 0, 0, 0, 'tb_item', 24, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(177, 5, 0, 0, 0, 0, 'tb_item', 31, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(178, 5, 0, 0, 0, 0, 'tb_item', 28, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(179, 5, 0, 0, 0, 0, 'tb_item', 29, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(180, 5, 0, 0, 0, 0, 'tb_item', 30, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1),
(181, 6, 1, 1, 1, 1, 'tb_modulo', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(182, 6, 0, 0, 0, 0, 'tb_modulo', 2, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(183, 6, 1, 1, 1, 1, 'tb_modulo', 3, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(184, 6, 1, 1, 1, 1, 'tb_opcion', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(185, 6, 0, 0, 0, 0, 'tb_opcion', 2, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(186, 6, 1, 1, 1, 1, 'tb_opcion', 3, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(187, 6, 0, 0, 0, 0, 'tb_opcion', 4, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(188, 6, 0, 0, 0, 0, 'tb_opcion', 5, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(189, 6, 0, 0, 0, 0, 'tb_opcion', 6, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(190, 6, 0, 0, 0, 0, 'tb_opcion', 7, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(191, 6, 1, 1, 1, 1, 'tb_opcion', 8, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(192, 6, 1, 1, 1, 1, 'tb_opcion', 9, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(193, 6, 1, 1, 1, 1, 'tb_opcion', 10, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(194, 6, 1, 1, 1, 1, 'tb_opcion', 11, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(195, 6, 0, 0, 0, 0, 'tb_item', 1, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(196, 6, 0, 0, 0, 0, 'tb_item', 13, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(197, 6, 0, 0, 0, 0, 'tb_item', 12, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(198, 6, 0, 0, 0, 0, 'tb_item', 11, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(199, 6, 0, 0, 0, 0, 'tb_item', 10, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(200, 6, 0, 0, 0, 0, 'tb_item', 9, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(201, 6, 0, 0, 0, 0, 'tb_item', 8, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(202, 6, 0, 0, 0, 0, 'tb_item', 7, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(203, 6, 0, 0, 0, 0, 'tb_item', 2, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(204, 6, 0, 0, 0, 0, 'tb_item', 3, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(205, 6, 0, 0, 0, 0, 'tb_item', 4, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(206, 6, 0, 0, 0, 0, 'tb_item', 5, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(207, 6, 0, 0, 0, 0, 'tb_item', 6, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(208, 6, 0, 0, 0, 0, 'tb_item', 23, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(209, 6, 0, 0, 0, 0, 'tb_item', 22, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(210, 6, 0, 0, 0, 0, 'tb_item', 21, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(211, 6, 0, 0, 0, 0, 'tb_item', 20, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(212, 6, 0, 0, 0, 0, 'tb_item', 19, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(213, 6, 0, 0, 0, 0, 'tb_item', 18, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(214, 6, 0, 0, 0, 0, 'tb_item', 17, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(215, 6, 0, 0, 0, 0, 'tb_item', 16, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(216, 6, 0, 0, 0, 0, 'tb_item', 15, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(217, 6, 0, 0, 0, 0, 'tb_item', 14, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(218, 6, 0, 0, 0, 0, 'tb_item', 27, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(219, 6, 0, 0, 0, 0, 'tb_item', 26, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(220, 6, 0, 0, 0, 0, 'tb_item', 25, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(221, 6, 0, 0, 0, 0, 'tb_item', 24, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(222, 6, 0, 0, 0, 0, 'tb_item', 31, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(223, 6, 0, 0, 0, 0, 'tb_item', 28, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(224, 6, 0, 0, 0, 0, 'tb_item', 29, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(225, 6, 0, 0, 0, 0, 'tb_item', 30, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(226, 7, 0, 0, 0, 0, 'tb_modulo', 1, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(227, 7, 0, 0, 0, 0, 'tb_modulo', 2, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(228, 7, 0, 0, 0, 0, 'tb_modulo', 3, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(229, 7, 0, 0, 0, 0, 'tb_opcion', 1, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(230, 7, 0, 0, 0, 0, 'tb_opcion', 2, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(231, 7, 0, 0, 0, 0, 'tb_opcion', 3, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(232, 7, 0, 0, 0, 0, 'tb_opcion', 4, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(233, 7, 0, 0, 0, 0, 'tb_opcion', 5, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(234, 7, 0, 0, 0, 0, 'tb_opcion', 6, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(235, 7, 0, 0, 0, 0, 'tb_opcion', 7, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(236, 7, 0, 0, 0, 0, 'tb_opcion', 8, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(237, 7, 0, 0, 0, 0, 'tb_opcion', 9, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(238, 7, 0, 0, 0, 0, 'tb_opcion', 10, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(239, 7, 0, 0, 0, 0, 'tb_opcion', 11, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(240, 7, 0, 0, 0, 0, 'tb_item', 1, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(241, 7, 0, 0, 0, 0, 'tb_item', 13, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(242, 7, 0, 0, 0, 0, 'tb_item', 12, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(243, 7, 0, 0, 0, 0, 'tb_item', 11, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(244, 7, 0, 0, 0, 0, 'tb_item', 10, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(245, 7, 0, 0, 0, 0, 'tb_item', 9, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(246, 7, 0, 0, 0, 0, 'tb_item', 8, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(247, 7, 0, 0, 0, 0, 'tb_item', 7, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(248, 7, 0, 0, 0, 0, 'tb_item', 2, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(249, 7, 0, 0, 0, 0, 'tb_item', 3, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(250, 7, 0, 0, 0, 0, 'tb_item', 4, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(251, 7, 0, 0, 0, 0, 'tb_item', 5, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(252, 7, 0, 0, 0, 0, 'tb_item', 6, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(253, 7, 0, 0, 0, 0, 'tb_item', 23, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(254, 7, 0, 0, 0, 0, 'tb_item', 22, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(255, 7, 0, 0, 0, 0, 'tb_item', 21, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(256, 7, 0, 0, 0, 0, 'tb_item', 20, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(257, 7, 0, 0, 0, 0, 'tb_item', 19, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(258, 7, 0, 0, 0, 0, 'tb_item', 18, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(259, 7, 0, 0, 0, 0, 'tb_item', 17, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(260, 7, 0, 0, 0, 0, 'tb_item', 16, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(261, 7, 0, 0, 0, 0, 'tb_item', 15, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(262, 7, 0, 0, 0, 0, 'tb_item', 14, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(263, 7, 0, 0, 0, 0, 'tb_item', 27, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(264, 7, 0, 0, 0, 0, 'tb_item', 26, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(265, 7, 0, 0, 0, 0, 'tb_item', 25, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(266, 7, 0, 0, 0, 0, 'tb_item', 24, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(267, 7, 0, 0, 0, 0, 'tb_item', 31, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(268, 7, 0, 0, 0, 0, 'tb_item', 28, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(269, 7, 0, 0, 0, 0, 'tb_item', 29, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(270, 7, 0, 0, 0, 0, 'tb_item', 30, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1),
(271, 8, 0, 0, 0, 0, 'tb_modulo', 1, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(272, 8, 0, 0, 0, 0, 'tb_modulo', 2, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(273, 8, 0, 0, 0, 0, 'tb_modulo', 3, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(274, 8, 0, 0, 0, 0, 'tb_opcion', 1, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(275, 8, 0, 0, 0, 0, 'tb_opcion', 2, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(276, 8, 0, 0, 0, 0, 'tb_opcion', 3, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(277, 8, 0, 0, 0, 0, 'tb_opcion', 4, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(278, 8, 0, 0, 0, 0, 'tb_opcion', 5, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(279, 8, 0, 0, 0, 0, 'tb_opcion', 6, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(280, 8, 0, 0, 0, 0, 'tb_opcion', 7, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(281, 8, 0, 0, 0, 0, 'tb_opcion', 8, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(282, 8, 0, 0, 0, 0, 'tb_opcion', 9, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(283, 8, 0, 0, 0, 0, 'tb_opcion', 10, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(284, 8, 0, 0, 0, 0, 'tb_opcion', 11, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(285, 8, 0, 0, 0, 0, 'tb_item', 1, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(286, 8, 0, 0, 0, 0, 'tb_item', 13, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(287, 8, 0, 0, 0, 0, 'tb_item', 12, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(288, 8, 0, 0, 0, 0, 'tb_item', 11, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(289, 8, 0, 0, 0, 0, 'tb_item', 10, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(290, 8, 0, 0, 0, 0, 'tb_item', 9, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(291, 8, 0, 0, 0, 0, 'tb_item', 8, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(292, 8, 0, 0, 0, 0, 'tb_item', 7, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(293, 8, 0, 0, 0, 0, 'tb_item', 2, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(294, 8, 0, 0, 0, 0, 'tb_item', 3, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(295, 8, 0, 0, 0, 0, 'tb_item', 4, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(296, 8, 0, 0, 0, 0, 'tb_item', 5, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(297, 8, 0, 0, 0, 0, 'tb_item', 6, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(298, 8, 0, 0, 0, 0, 'tb_item', 23, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(299, 8, 0, 0, 0, 0, 'tb_item', 22, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(300, 8, 0, 0, 0, 0, 'tb_item', 21, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(301, 8, 0, 0, 0, 0, 'tb_item', 20, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(302, 8, 0, 0, 0, 0, 'tb_item', 19, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(303, 8, 0, 0, 0, 0, 'tb_item', 18, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(304, 8, 0, 0, 0, 0, 'tb_item', 17, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(305, 8, 0, 0, 0, 0, 'tb_item', 16, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(306, 8, 0, 0, 0, 0, 'tb_item', 15, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(307, 8, 0, 0, 0, 0, 'tb_item', 14, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(308, 8, 0, 0, 0, 0, 'tb_item', 27, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(309, 8, 0, 0, 0, 0, 'tb_item', 26, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(310, 8, 0, 0, 0, 0, 'tb_item', 25, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(311, 8, 0, 0, 0, 0, 'tb_item', 24, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(312, 8, 0, 0, 0, 0, 'tb_item', 31, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(313, 8, 0, 0, 0, 0, 'tb_item', 28, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(314, 8, 0, 0, 0, 0, 'tb_item', 29, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(315, 8, 0, 0, 0, 0, 'tb_item', 30, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1),
(316, 9, 0, 0, 0, 0, 'tb_modulo', 1, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(317, 9, 0, 0, 0, 0, 'tb_modulo', 2, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(318, 9, 0, 0, 0, 0, 'tb_modulo', 3, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(319, 9, 0, 0, 0, 0, 'tb_opcion', 1, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(320, 9, 0, 0, 0, 0, 'tb_opcion', 2, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(321, 9, 0, 0, 0, 0, 'tb_opcion', 3, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(322, 9, 0, 0, 0, 0, 'tb_opcion', 4, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(323, 9, 0, 0, 0, 0, 'tb_opcion', 5, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(324, 9, 0, 0, 0, 0, 'tb_opcion', 6, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(325, 9, 0, 0, 0, 0, 'tb_opcion', 7, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(326, 9, 0, 0, 0, 0, 'tb_opcion', 8, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(327, 9, 0, 0, 0, 0, 'tb_opcion', 9, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(328, 9, 0, 0, 0, 0, 'tb_opcion', 10, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(329, 9, 0, 0, 0, 0, 'tb_opcion', 11, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(330, 9, 0, 0, 0, 0, 'tb_item', 1, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(331, 9, 0, 0, 0, 0, 'tb_item', 13, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(332, 9, 0, 0, 0, 0, 'tb_item', 12, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(333, 9, 0, 0, 0, 0, 'tb_item', 11, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(334, 9, 0, 0, 0, 0, 'tb_item', 10, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(335, 9, 0, 0, 0, 0, 'tb_item', 9, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(336, 9, 0, 0, 0, 0, 'tb_item', 8, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(337, 9, 0, 0, 0, 0, 'tb_item', 7, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(338, 9, 0, 0, 0, 0, 'tb_item', 2, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(339, 9, 0, 0, 0, 0, 'tb_item', 3, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(340, 9, 0, 0, 0, 0, 'tb_item', 4, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(341, 9, 0, 0, 0, 0, 'tb_item', 5, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(342, 9, 0, 0, 0, 0, 'tb_item', 6, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(343, 9, 0, 0, 0, 0, 'tb_item', 23, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(344, 9, 0, 0, 0, 0, 'tb_item', 22, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(345, 9, 0, 0, 0, 0, 'tb_item', 21, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(346, 9, 0, 0, 0, 0, 'tb_item', 20, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(347, 9, 0, 0, 0, 0, 'tb_item', 19, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(348, 9, 0, 0, 0, 0, 'tb_item', 18, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(349, 9, 0, 0, 0, 0, 'tb_item', 17, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(350, 9, 0, 0, 0, 0, 'tb_item', 16, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(351, 9, 0, 0, 0, 0, 'tb_item', 15, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(352, 9, 0, 0, 0, 0, 'tb_item', 14, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(353, 9, 0, 0, 0, 0, 'tb_item', 27, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(354, 9, 0, 0, 0, 0, 'tb_item', 26, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(355, 9, 0, 0, 0, 0, 'tb_item', 25, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(356, 9, 0, 0, 0, 0, 'tb_item', 24, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(357, 9, 0, 0, 0, 0, 'tb_item', 31, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(358, 9, 0, 0, 0, 0, 'tb_item', 28, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(359, 9, 0, 0, 0, 0, 'tb_item', 29, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(360, 9, 0, 0, 0, 0, 'tb_item', 30, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1),
(361, 10, 0, 0, 0, 0, 'tb_modulo', 1, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(362, 10, 0, 0, 0, 0, 'tb_modulo', 2, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(363, 10, 0, 0, 0, 0, 'tb_modulo', 3, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(364, 10, 0, 0, 0, 0, 'tb_opcion', 1, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(365, 10, 0, 0, 0, 0, 'tb_opcion', 2, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(366, 10, 0, 0, 0, 0, 'tb_opcion', 3, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(367, 10, 0, 0, 0, 0, 'tb_opcion', 4, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(368, 10, 0, 0, 0, 0, 'tb_opcion', 5, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(369, 10, 0, 0, 0, 0, 'tb_opcion', 6, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(370, 10, 0, 0, 0, 0, 'tb_opcion', 7, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(371, 10, 0, 0, 0, 0, 'tb_opcion', 8, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(372, 10, 0, 0, 0, 0, 'tb_opcion', 9, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(373, 10, 0, 0, 0, 0, 'tb_opcion', 10, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(374, 10, 0, 0, 0, 0, 'tb_opcion', 11, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(375, 10, 0, 0, 0, 0, 'tb_item', 1, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(376, 10, 0, 0, 0, 0, 'tb_item', 13, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(377, 10, 0, 0, 0, 0, 'tb_item', 12, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(378, 10, 0, 0, 0, 0, 'tb_item', 11, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(379, 10, 0, 0, 0, 0, 'tb_item', 10, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(380, 10, 0, 0, 0, 0, 'tb_item', 9, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(381, 10, 0, 0, 0, 0, 'tb_item', 8, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(382, 10, 0, 0, 0, 0, 'tb_item', 7, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(383, 10, 0, 0, 0, 0, 'tb_item', 2, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(384, 10, 0, 0, 0, 0, 'tb_item', 3, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(385, 10, 0, 0, 0, 0, 'tb_item', 4, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(386, 10, 0, 0, 0, 0, 'tb_item', 5, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(387, 10, 0, 0, 0, 0, 'tb_item', 6, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(388, 10, 0, 0, 0, 0, 'tb_item', 23, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(389, 10, 0, 0, 0, 0, 'tb_item', 22, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(390, 10, 0, 0, 0, 0, 'tb_item', 21, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(391, 10, 0, 0, 0, 0, 'tb_item', 20, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(392, 10, 0, 0, 0, 0, 'tb_item', 19, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(393, 10, 0, 0, 0, 0, 'tb_item', 18, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(394, 10, 0, 0, 0, 0, 'tb_item', 17, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(395, 10, 0, 0, 0, 0, 'tb_item', 16, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(396, 10, 0, 0, 0, 0, 'tb_item', 15, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(397, 10, 0, 0, 0, 0, 'tb_item', 14, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(398, 10, 0, 0, 0, 0, 'tb_item', 27, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(399, 10, 0, 0, 0, 0, 'tb_item', 26, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(400, 10, 0, 0, 0, 0, 'tb_item', 25, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(401, 10, 0, 0, 0, 0, 'tb_item', 24, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(402, 10, 0, 0, 0, 0, 'tb_item', 31, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(403, 10, 0, 0, 0, 0, 'tb_item', 28, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(404, 10, 0, 0, 0, 0, 'tb_item', 29, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(405, 10, 0, 0, 0, 0, 'tb_item', 30, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1),
(406, 11, 0, 0, 0, 0, 'tb_modulo', 1, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(407, 11, 0, 0, 0, 0, 'tb_modulo', 2, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(408, 11, 0, 0, 0, 0, 'tb_modulo', 3, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(409, 11, 0, 0, 0, 0, 'tb_opcion', 1, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(410, 11, 0, 0, 0, 0, 'tb_opcion', 2, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(411, 11, 0, 0, 0, 0, 'tb_opcion', 3, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(412, 11, 0, 0, 0, 0, 'tb_opcion', 4, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(413, 11, 0, 0, 0, 0, 'tb_opcion', 5, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(414, 11, 0, 0, 0, 0, 'tb_opcion', 6, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(415, 11, 0, 0, 0, 0, 'tb_opcion', 7, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(416, 11, 0, 0, 0, 0, 'tb_opcion', 8, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(417, 11, 0, 0, 0, 0, 'tb_opcion', 9, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(418, 11, 0, 0, 0, 0, 'tb_opcion', 10, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(419, 11, 0, 0, 0, 0, 'tb_opcion', 11, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(420, 11, 0, 0, 0, 0, 'tb_item', 1, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(421, 11, 0, 0, 0, 0, 'tb_item', 13, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(422, 11, 0, 0, 0, 0, 'tb_item', 12, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(423, 11, 0, 0, 0, 0, 'tb_item', 11, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(424, 11, 0, 0, 0, 0, 'tb_item', 10, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(425, 11, 0, 0, 0, 0, 'tb_item', 9, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(426, 11, 0, 0, 0, 0, 'tb_item', 8, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(427, 11, 0, 0, 0, 0, 'tb_item', 7, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(428, 11, 0, 0, 0, 0, 'tb_item', 2, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(429, 11, 0, 0, 0, 0, 'tb_item', 3, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(430, 11, 0, 0, 0, 0, 'tb_item', 4, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(431, 11, 0, 0, 0, 0, 'tb_item', 5, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(432, 11, 0, 0, 0, 0, 'tb_item', 6, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(433, 11, 0, 0, 0, 0, 'tb_item', 23, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(434, 11, 0, 0, 0, 0, 'tb_item', 22, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(435, 11, 0, 0, 0, 0, 'tb_item', 21, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(436, 11, 0, 0, 0, 0, 'tb_item', 20, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(437, 11, 0, 0, 0, 0, 'tb_item', 19, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(438, 11, 0, 0, 0, 0, 'tb_item', 18, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(439, 11, 0, 0, 0, 0, 'tb_item', 17, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(440, 11, 0, 0, 0, 0, 'tb_item', 16, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(441, 11, 0, 0, 0, 0, 'tb_item', 15, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(442, 11, 0, 0, 0, 0, 'tb_item', 14, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(443, 11, 0, 0, 0, 0, 'tb_item', 27, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(444, 11, 0, 0, 0, 0, 'tb_item', 26, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(445, 11, 0, 0, 0, 0, 'tb_item', 25, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(446, 11, 0, 0, 0, 0, 'tb_item', 24, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(447, 11, 0, 0, 0, 0, 'tb_item', 31, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(448, 11, 0, 0, 0, 0, 'tb_item', 28, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(449, 11, 0, 0, 0, 0, 'tb_item', 29, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(450, 11, 0, 0, 0, 0, 'tb_item', 30, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1),
(451, 12, 1, 1, 1, 1, 'tb_modulo', 1, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(452, 12, 0, 0, 0, 0, 'tb_modulo', 2, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(453, 12, 0, 0, 0, 0, 'tb_modulo', 3, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(454, 12, 1, 1, 1, 1, 'tb_opcion', 1, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(455, 12, 1, 0, 0, 0, 'tb_opcion', 2, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(456, 12, 0, 0, 0, 0, 'tb_opcion', 3, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(457, 12, 0, 0, 0, 0, 'tb_opcion', 4, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(458, 12, 0, 0, 0, 0, 'tb_opcion', 5, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(459, 12, 0, 0, 0, 0, 'tb_opcion', 6, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(460, 12, 0, 0, 0, 0, 'tb_opcion', 7, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(461, 12, 0, 0, 0, 0, 'tb_opcion', 8, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(462, 12, 0, 0, 0, 0, 'tb_opcion', 9, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(463, 12, 0, 0, 0, 0, 'tb_opcion', 10, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(464, 12, 0, 0, 0, 0, 'tb_opcion', 11, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(465, 12, 0, 0, 0, 0, 'tb_item', 1, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(466, 12, 0, 0, 0, 0, 'tb_item', 13, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(467, 12, 0, 0, 0, 0, 'tb_item', 12, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(468, 12, 0, 0, 0, 0, 'tb_item', 11, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(469, 12, 0, 0, 0, 0, 'tb_item', 10, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(470, 12, 0, 0, 0, 0, 'tb_item', 9, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(471, 12, 0, 0, 0, 0, 'tb_item', 8, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(472, 12, 0, 0, 0, 0, 'tb_item', 7, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(473, 12, 0, 0, 0, 0, 'tb_item', 2, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(474, 12, 0, 0, 0, 0, 'tb_item', 3, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(475, 12, 0, 0, 0, 0, 'tb_item', 4, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(476, 12, 0, 0, 0, 0, 'tb_item', 5, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(477, 12, 0, 0, 0, 0, 'tb_item', 6, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(478, 12, 0, 0, 0, 0, 'tb_item', 23, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(479, 12, 0, 0, 0, 0, 'tb_item', 22, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(480, 12, 0, 0, 0, 0, 'tb_item', 21, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(481, 12, 0, 0, 0, 0, 'tb_item', 20, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(482, 12, 0, 0, 0, 0, 'tb_item', 19, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(483, 12, 0, 0, 0, 0, 'tb_item', 18, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(484, 12, 0, 0, 0, 0, 'tb_item', 17, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(485, 12, 0, 0, 0, 0, 'tb_item', 16, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(486, 12, 0, 0, 0, 0, 'tb_item', 15, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(487, 12, 0, 0, 0, 0, 'tb_item', 14, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(488, 12, 0, 0, 0, 0, 'tb_item', 27, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(489, 12, 0, 0, 0, 0, 'tb_item', 26, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(490, 12, 0, 0, 0, 0, 'tb_item', 25, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(491, 12, 0, 0, 0, 0, 'tb_item', 24, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(492, 12, 0, 0, 0, 0, 'tb_item', 31, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(493, 12, 0, 0, 0, 0, 'tb_item', 28, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(494, 12, 0, 0, 0, 0, 'tb_item', 29, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(495, 12, 0, 0, 0, 0, 'tb_item', 30, NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1),
(496, 13, 0, 0, 0, 0, 'tb_modulo', 1, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(497, 13, 0, 0, 0, 0, 'tb_modulo', 2, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(498, 13, 0, 0, 0, 0, 'tb_modulo', 3, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(499, 13, 0, 0, 0, 0, 'tb_opcion', 1, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1);
INSERT INTO `tb_detalle_perfil` (`id_det_per`, `id_perfil`, `view_det`, `create_det`, `update_det`, `delete_det`, `tabla`, `id`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`) VALUES
(500, 13, 0, 0, 0, 0, 'tb_opcion', 2, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(501, 13, 0, 0, 0, 0, 'tb_opcion', 3, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(502, 13, 0, 0, 0, 0, 'tb_opcion', 4, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(503, 13, 0, 0, 0, 0, 'tb_opcion', 5, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(504, 13, 0, 0, 0, 0, 'tb_opcion', 6, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(505, 13, 0, 0, 0, 0, 'tb_opcion', 7, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(506, 13, 0, 0, 0, 0, 'tb_opcion', 8, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(507, 13, 0, 0, 0, 0, 'tb_opcion', 9, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(508, 13, 0, 0, 0, 0, 'tb_opcion', 10, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(509, 13, 0, 0, 0, 0, 'tb_opcion', 11, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(510, 13, 0, 0, 0, 0, 'tb_item', 1, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(511, 13, 0, 0, 0, 0, 'tb_item', 13, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(512, 13, 0, 0, 0, 0, 'tb_item', 12, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(513, 13, 0, 0, 0, 0, 'tb_item', 11, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(514, 13, 0, 0, 0, 0, 'tb_item', 10, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(515, 13, 0, 0, 0, 0, 'tb_item', 9, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(516, 13, 0, 0, 0, 0, 'tb_item', 8, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(517, 13, 0, 0, 0, 0, 'tb_item', 7, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(518, 13, 0, 0, 0, 0, 'tb_item', 2, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(519, 13, 0, 0, 0, 0, 'tb_item', 3, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(520, 13, 0, 0, 0, 0, 'tb_item', 4, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(521, 13, 0, 0, 0, 0, 'tb_item', 5, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(522, 13, 0, 0, 0, 0, 'tb_item', 6, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(523, 13, 0, 0, 0, 0, 'tb_item', 23, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(524, 13, 0, 0, 0, 0, 'tb_item', 22, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(525, 13, 0, 0, 0, 0, 'tb_item', 21, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(526, 13, 0, 0, 0, 0, 'tb_item', 20, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(527, 13, 0, 0, 0, 0, 'tb_item', 19, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(528, 13, 0, 0, 0, 0, 'tb_item', 18, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(529, 13, 0, 0, 0, 0, 'tb_item', 17, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(530, 13, 0, 0, 0, 0, 'tb_item', 16, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(531, 13, 0, 0, 0, 0, 'tb_item', 15, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(532, 13, 0, 0, 0, 0, 'tb_item', 14, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(533, 13, 0, 0, 0, 0, 'tb_item', 27, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(534, 13, 0, 0, 0, 0, 'tb_item', 26, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(535, 13, 0, 0, 0, 0, 'tb_item', 25, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(536, 13, 0, 0, 0, 0, 'tb_item', 24, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(537, 13, 0, 0, 0, 0, 'tb_item', 31, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(538, 13, 0, 0, 0, 0, 'tb_item', 28, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(539, 13, 0, 0, 0, 0, 'tb_item', 29, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(540, 13, 0, 0, 0, 0, 'tb_item', 30, NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1),
(541, 14, 1, 1, 1, 1, 'tb_modulo', 1, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(542, 14, 0, 0, 0, 0, 'tb_modulo', 2, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(543, 14, 0, 0, 0, 0, 'tb_modulo', 3, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(544, 14, 1, 1, 1, 1, 'tb_opcion', 1, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(545, 14, 0, 0, 0, 0, 'tb_opcion', 2, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(546, 14, 0, 0, 0, 0, 'tb_opcion', 3, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(547, 14, 0, 0, 0, 0, 'tb_opcion', 4, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(548, 14, 0, 0, 0, 0, 'tb_opcion', 5, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(549, 14, 0, 0, 0, 0, 'tb_opcion', 6, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(550, 14, 0, 0, 0, 0, 'tb_opcion', 7, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(551, 14, 0, 0, 0, 0, 'tb_opcion', 8, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(552, 14, 0, 0, 0, 0, 'tb_opcion', 9, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(553, 14, 0, 0, 0, 0, 'tb_opcion', 10, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(554, 14, 0, 0, 0, 0, 'tb_opcion', 11, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(555, 14, 0, 0, 0, 0, 'tb_item', 1, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(556, 14, 0, 0, 0, 0, 'tb_item', 13, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(557, 14, 0, 0, 0, 0, 'tb_item', 12, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(558, 14, 0, 0, 0, 0, 'tb_item', 11, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(559, 14, 0, 0, 0, 0, 'tb_item', 10, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(560, 14, 0, 0, 0, 0, 'tb_item', 9, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(561, 14, 0, 0, 0, 0, 'tb_item', 8, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(562, 14, 0, 0, 0, 0, 'tb_item', 7, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(563, 14, 0, 0, 0, 0, 'tb_item', 2, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(564, 14, 0, 0, 0, 0, 'tb_item', 3, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(565, 14, 0, 0, 0, 0, 'tb_item', 4, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(566, 14, 0, 0, 0, 0, 'tb_item', 5, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(567, 14, 0, 0, 0, 0, 'tb_item', 6, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(568, 14, 0, 0, 0, 0, 'tb_item', 23, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(569, 14, 0, 0, 0, 0, 'tb_item', 22, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(570, 14, 0, 0, 0, 0, 'tb_item', 21, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(571, 14, 0, 0, 0, 0, 'tb_item', 20, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(572, 14, 0, 0, 0, 0, 'tb_item', 19, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(573, 14, 0, 0, 0, 0, 'tb_item', 18, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(574, 14, 0, 0, 0, 0, 'tb_item', 17, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(575, 14, 0, 0, 0, 0, 'tb_item', 16, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(576, 14, 0, 0, 0, 0, 'tb_item', 15, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(577, 14, 0, 0, 0, 0, 'tb_item', 14, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(578, 14, 0, 0, 0, 0, 'tb_item', 27, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(579, 14, 0, 0, 0, 0, 'tb_item', 26, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(580, 14, 0, 0, 0, 0, 'tb_item', 25, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(581, 14, 0, 0, 0, 0, 'tb_item', 24, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(582, 14, 0, 0, 0, 0, 'tb_item', 31, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(583, 14, 0, 0, 0, 0, 'tb_item', 28, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(584, 14, 0, 0, 0, 0, 'tb_item', 29, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1),
(585, 14, 0, 0, 0, 0, 'tb_item', 30, NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_historial_claves`
--

CREATE TABLE `tb_historial_claves` (
  `id_cl` int(11) NOT NULL,
  `pass_cl` varchar(200) NOT NULL,
  `id_us` int(11) NOT NULL,
  `creacion_cl` datetime(6) NOT NULL,
  `expiracion_cl` decimal(30,6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tb_historial_claves`
--

INSERT INTO `tb_historial_claves` (`id_cl`, `pass_cl`, `id_us`, `creacion_cl`, `expiracion_cl`) VALUES
(4, '0e5a62cae2043ac25c2530d017770cebd0ce338c5330f7b7b253aa1beac233a3db15c6dfea0fcdddba3dee750c40174933d870dd9a8d743b570ad9', 3, '2023-05-01 21:02:46.000000', 1686880966.000000),
(5, 'd2598198b8544a290224c11f8a7c0decd599f0462e447ce821e80d17eeef3da6dcd1fb03c6572c516fcfb6d2f9c60dc97ae5064717c95e9279', 3, '2023-05-01 23:10:30.000000', 1686888630.000000),
(6, '27e60f58ee6dca2e125509ef629b49c5b77ffe1caf4576f3c4f4166ab2df299c2dbb6de3d7265c18d77ac4a774befcd8753e82b8f3568c47b63cbc', 4, '2023-05-02 00:19:04.000000', 1686892744.000000),
(7, '5ebcf719654020fa07f3dd4c134b964c947f3569bbf45b5482537b208b6186f740bb5ab392091916fe95ce02dc1ac9c5844eed7846408a50f4', 4, '2023-05-02 00:19:42.000000', 1686892782.000000),
(8, '6c49d1f520abe4326e368d5b3af33d2f3a66ccfc65766081d7b3cc27d875aceb91185ae2904c1fb91c49061622e224b5c2412b3941047fc9da', 4, '2023-05-02 00:20:19.000000', 1686892819.000000),
(9, '501e909cefdbff295daf8a465b050f0a2ee60b2cf7bfc1ba51cf1e0b6165439113b550b0ce4c04a8d8f9cd4154cbabdaf2964ab86d484b8ea95d', 4, '2023-05-02 00:21:41.000000', 1686892901.000000),
(10, '046c764d4eb2be49d7ffce44f88c043dc520422d5dd8243efb2752ec65b63b17c734c27c36680767d1082eb4239cae96fee1a692322f4d88578bb5', 4, '2023-05-02 00:22:31.000000', 1686892951.000000),
(13, 'c734c32c9472f077dde6d9cef1ba2c6f5ec00f06546084696c2042dc62e801b81ed0e30c49311099859efae2beb4fc04d09de67f04bf825ef2915c', 5, '2023-05-03 11:12:03.000000', 1687018323.000000),
(14, '32ecc86924109bdeaa59935fb9fb3c8fa3d6eb4710fb7b4ff0a7cb58d519f7becf425adf1456e4a6e0bbb463934b4c584abf12405fd62f43270c74', 6, '2023-05-04 16:40:04.000000', 1687124404.000000),
(15, 'f11f0d9a1f6abd7ee91f48d5aeb2123d8fb1ae67cf2247e286b7bfe2145810dbdaf1dd98b7a5a5be958d0adfb64f304b9338b1a895d1631f554fbc', 7, '2023-05-04 17:28:29.000000', 1687127309.000000),
(16, '98a15b7206569dde8a77dd00743fbc5cbdf44dce7f8a47b931c7e62ce30f8436d4db81f9f4d1ab13bc33d30f0dbed38759aa484ca252d042044c99', 8, '2023-05-07 18:04:58.000000', 1687388698.000000),
(17, '2d31b845c78d8fa05209374ff0283034d7baa330020605ba0f93290748927af7e30f2b3616271e2d56531481ee20f5f24fa0b54f5ea6d73b0892', 5, '2023-05-09 17:01:47.000000', 1687557707.000000),
(18, '60c25d30ad2e50ce1079a9cf2e7cac02c2328466f954726a99857b8578b06ef6887bf296da6f169da9fea8b96f52748800e525f2b372e6b98358e6', 9, '2023-05-10 18:46:33.000000', 1687650393.000000),
(19, '558a002e6b936c4d736649c55fd3d7d7db8481984c952bbe2bed3ac61ce5e052e82aaedca01aa0a5baacc6195c410c50a4ffb10e3e2990ee2026b4', 416, '2023-05-11 03:18:29.000000', 1687681109.000000),
(20, '8c3c3f200603007c13fdee6eedefbd300c26d5813738dd22efe2f99b9ff956e7f687c02c18e2d0fde621e7582fb67819621eddfda22488fa5a9156', 4761, '2023-05-11 03:19:21.000000', 1687681161.000000),
(23, '0ca24eabb0264e4d38a6e5f78a8e39490b6a0fbdf46aeb11a3d1da38d06eb5bb2b242a126cce8a39f5ee95e43f71be894fbd992436a77937e1b6e5', 5, '2023-05-11 11:25:21.000000', 1687710321.000000),
(24, 'b2a6de187ef746c6f75416164e79ca086d79aa03af73c7f01d8c91c3897a0eb49e29d41b7f1fdda18b6543901d4dac3dbfece7fc82ef46a535e7', 8, '2023-05-11 15:59:09.000000', 1687726749.000000),
(25, '139cc1f25032f4a470fa163f98fdce77ac9111245ccf765ce515e626422e13e15dd0ff015fd3b1c8493196a0df8ccb0ae9639b0fdb03b30abed28f', 10, '2023-05-12 10:19:40.000000', 1687792780.000000),
(26, '00df6aa07585440545574d138c79ca91319f7d32cff7f810b852f4bfb2c7fc8b1e7d3863c3e85b85dbf5e171e35b5559f8de10559dc60de5fc1e', 10, '2023-05-12 10:20:56.000000', 1687792856.000000),
(27, 'ee9cec7ff4b59747892b0ed6cb262c00d71bc35d54f24922dd51e5bbf7f6611c78bc0446da45344753ffd704fc18c5f4de4177f12e79d279e6a59f', 5, '2023-05-13 11:35:40.000000', 1687883740.000000),
(28, 'a74f3a15def53710b47afae0b71e5ba9584c3a6ab7de31a7d2b5cc2f141379d37752e29d13495aa8025628f894df9d1fda051084295699e9f561', 1, '2023-05-17 10:08:17.000000', 1688224097.000000),
(29, '0fd4b3fd845295c1981ccd34fd4578f3475765a0dade1e5be5bdeb5daba2e079061976d12ff6590c6022cd2e9e59f34da7c64b3aca5b6d192ba5d5', 1, '2023-05-17 21:28:38.000000', 1688264918.000000),
(30, 'f4753003910d10b76a9e8a41d4641d7f5fc9b373e94df241b39d1a9a202e13d63211e32637463e5469b5e8ea5d7b6c51957ba31a274891b548a732cd', 1, '2023-05-17 21:34:59.000000', 1688265299.000000),
(31, 'cb01d1ee618c54168967f4cb72e6385fe96f90ea4c153cfcb4c0e48b5833c5ec555fbfca2da1078b01b0d224fe452ce08636e88a79104495e1a5eb', 1, '2023-05-17 21:35:38.000000', 1688265338.000000),
(32, '19c96c058d99c349f2d530ebf896c5345637da415cb707ea5ce123e8be4b6c3ecd72c28bee400152ca5fa97bf5874f6dcda886a9b589a093a102d4', 11, '2023-05-17 23:17:39.000000', 1688271459.000000),
(33, 'f48a42ad087239669f5df7c324dae24794ea861a2d108d8a52b769195796723d5d07f4fbd66887bcb2068ff85d125d250f1e0438d7256983c6a5bf', 1, '2023-05-18 01:31:12.000000', 1688279472.000000),
(34, '11f4a1a6253ede1cf96fbb598056052f46394828648e45ab0af8c57f18d773ac8db67682889290a114d9d57900b8fe1b46649a1c310b87f66764c6', 1, '2023-05-18 02:58:47.000000', 1688284727.000000),
(35, 'ba635b6f1bfe570eb8b35fd60100786f90d48579c245743cd647f2ce66abc042055b514f076a2d95a9564ec7a0318a881d69724a1e9036b1523f04', 1, '2023-05-18 03:02:44.000000', 1688284964.000000),
(36, '06a1fa3ca12310fca0e7a3c738c64b072ade6d7c208e7d68f244dbda2c663a4a49479d47355dd5a2746710c3929abed9e96c26003a00805362', 1, '2023-05-18 03:03:46.000000', 1688285026.000000),
(37, '590519af4f675d3e9fd571c513a1b2cef819f85f177743edf446333f9e9804fe3ea8529d69cb50f6509a9021d77a38f04ed29c897b53c33965', 1, '2023-05-18 03:24:11.000000', 1688286251.000000),
(38, '13f7501442ecbb7f9c05dbc209c8d474a072ba578e6fab782f406ba345a303361f3cf061e811d64d4b1cf51a5b2f40e492cc7046a2ba1c7b49a7f41b67600171', 12, '2023-05-18 19:49:10.000000', 1688345350.000000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_item`
--

CREATE TABLE `tb_item` (
  `id_item` int(11) NOT NULL,
  `est_item` int(11) DEFAULT NULL,
  `actualizacion_item` int(11) DEFAULT NULL,
  `id_op` int(11) DEFAULT NULL,
  `desc_item` varchar(200) DEFAULT NULL,
  `creacion_item` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tb_item`
--

INSERT INTO `tb_item` (`id_item`, `est_item`, `actualizacion_item`, `id_op`, `desc_item`, `creacion_item`) VALUES
(1, 1, NULL, 4, 'Empresa', '0000-00-00 00:00:00.000000'),
(2, 1, NULL, 4, 'Áreas', '0000-00-00 00:00:00.000000'),
(3, 1, NULL, 4, 'Unidades', '0000-00-00 00:00:00.000000'),
(4, 1, NULL, 4, 'Macroprocesos', '0000-00-00 00:00:00.000000'),
(5, 1, NULL, 4, 'Procesos', '0000-00-00 00:00:00.000000'),
(6, 1, NULL, 4, 'Posición/Puesto', '0000-00-00 00:00:00.000000'),
(7, 1, NULL, 4, 'Aspecto de Seguridad', '0000-00-00 00:00:00.000000'),
(8, 1, NULL, 4, 'Valor de Activo', '0000-00-00 00:00:00.000000'),
(9, 1, NULL, 4, 'Valoración de Activo', '0000-00-00 00:00:00.000000'),
(10, 1, NULL, 4, 'Tipo de Activo', '0000-00-00 00:00:00.000000'),
(11, 1, NULL, 4, 'Categoría de Activo', '0000-00-00 00:00:00.000000'),
(12, 1, NULL, 4, 'Ubicación de Activo', '0000-00-00 00:00:00.000000'),
(13, 1, NULL, 4, 'Clasificación de Información', '0000-00-00 00:00:00.000000'),
(14, 1, NULL, 5, 'Tipo de Riesgo', '0000-00-00 00:00:00.000000'),
(15, 1, NULL, 5, 'Probabilidad de Riesgo', '0000-00-00 00:00:00.000000'),
(16, 1, NULL, 5, 'Impacto de Riesgo', '0000-00-00 00:00:00.000000'),
(17, 1, NULL, 5, 'Nivel de Riesgo', '0000-00-00 00:00:00.000000'),
(18, 1, NULL, 5, 'Valoracion de Riesgo', '0000-00-00 00:00:00.000000'),
(19, 1, NULL, 5, 'Tipo de Amenaza', '0000-00-00 00:00:00.000000'),
(20, 1, NULL, 5, 'Descripcion de Amenaza', '0000-00-00 00:00:00.000000'),
(21, 1, NULL, 5, 'Vulnerabilidad', '0000-00-00 00:00:00.000000'),
(22, 1, NULL, 5, 'Categoría de Vulnerabilidad', '0000-00-00 00:00:00.000000'),
(23, 1, NULL, 5, 'Descripcion de Vulnerabilidad', '0000-00-00 00:00:00.000000'),
(24, 1, NULL, 6, 'Cobertura', '0000-00-00 00:00:00.000000'),
(25, 1, NULL, 6, 'Evaluación de Control', '0000-00-00 00:00:00.000000'),
(26, 1, NULL, 6, 'Aplicación de Probabilidad', '0000-00-00 00:00:00.000000'),
(27, 1, NULL, 6, 'Aplicacón de Impacto', '0000-00-00 00:00:00.000000'),
(28, 1, NULL, 7, 'Estado', '0000-00-00 00:00:00.000000'),
(29, 1, NULL, 7, 'Prioridad', '0000-00-00 00:00:00.000000'),
(30, 1, NULL, 7, 'Alerta de Seguimiento', '0000-00-00 00:00:00.000000'),
(31, 1, NULL, 6, 'Características de control', '2023-04-08 10:53:14.000000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_modulo`
--

CREATE TABLE `tb_modulo` (
  `id_mod` int(11) NOT NULL,
  `desc_mod` varchar(200) NOT NULL,
  `est_mod` int(11) NOT NULL,
  `creacion_mod` datetime(6) NOT NULL,
  `actualizacion_mod` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tb_modulo`
--

INSERT INTO `tb_modulo` (`id_mod`, `desc_mod`, `est_mod`, `creacion_mod`, `actualizacion_mod`) VALUES
(1, 'Accesos', 1, '0000-00-00 00:00:00.000000', NULL),
(2, 'Parametrización', 1, '0000-00-00 00:00:00.000000', NULL),
(3, 'Evaluación de Riesgos de Seguridad en Procesos de Negocio', 1, '0000-00-00 00:00:00.000000', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_opcion`
--

CREATE TABLE `tb_opcion` (
  `id_op` int(11) NOT NULL,
  `desc_op` varchar(50) NOT NULL,
  `est_op` int(11) NOT NULL,
  `creacion_op` datetime(6) NOT NULL,
  `actualizacion_op` datetime(6) DEFAULT NULL,
  `id_mod` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tb_opcion`
--

INSERT INTO `tb_opcion` (`id_op`, `desc_op`, `est_op`, `creacion_op`, `actualizacion_op`, `id_mod`) VALUES
(1, 'Usuarios', 1, '0000-00-00 00:00:00.000000', NULL, 1),
(2, 'Config. Contraseña', 1, '0000-00-00 00:00:00.000000', NULL, 1),
(3, 'Perfiles', 1, '0000-00-00 00:00:00.000000', NULL, 1),
(4, 'Activos', 1, '0000-00-00 00:00:00.000000', NULL, 2),
(5, 'Riesgos SI-C', 1, '0000-00-00 00:00:00.000000', NULL, 2),
(6, 'Controles', 1, '0000-00-00 00:00:00.000000', NULL, 2),
(7, 'Plan de Accion', 1, '0000-00-00 00:00:00.000000', NULL, 2),
(8, 'Inventario y Clasificaci+on de Activos', 1, '0000-00-00 00:00:00.000000', NULL, 3),
(9, 'Evaluación de Riesgos SI-C', 1, '0000-00-00 00:00:00.000000', NULL, 3),
(10, 'Registro de Controles', 1, '0000-00-00 00:00:00.000000', NULL, 3),
(11, 'Registro de Plan de Accion', 1, '0000-00-00 00:00:00.000000', NULL, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_perfiles`
--

CREATE TABLE `tb_perfiles` (
  `id_perfil` int(11) NOT NULL,
  `perfil` varchar(100) NOT NULL,
  `desc_perfil` varchar(200) NOT NULL,
  `est_perfil` int(11) NOT NULL,
  `creacion_perfil` datetime(6) NOT NULL,
  `actualizacion_perfil` datetime(6) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0,
  `is_user_negocio` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tb_perfiles`
--

INSERT INTO `tb_perfiles` (`id_perfil`, `perfil`, `desc_perfil`, `est_perfil`, `creacion_perfil`, `actualizacion_perfil`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`, `is_user_negocio`) VALUES
(1, 'ADMINISTRADOR', 'ADMINISTRADOR DEL SISTEMA', 1, '2023-05-01 20:40:38.000000', '2023-05-07 15:11:18.000000', NULL, NULL, NULL, NULL, NULL, NULL, 0, 1),
(5, 'TESTEOA', 'TESTEOA', 1, '2023-05-07 15:09:28.000000', NULL, NULL, NULL, NULL, '2023-05-07 15:11:11', 1, '2023-05-07 15:11:11', 1, 0),
(6, 'TESTEOA', 'TESTEOA', 1, '2023-05-07 18:09:03.000000', '2023-05-07 18:09:11.000000', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0),
(7, 'TESTEOB', 'TESTEOB', 1, '2023-05-07 18:10:16.000000', NULL, NULL, NULL, NULL, '2023-05-07 18:10:25', 1, '2023-05-07 18:10:25', 1, 1),
(8, 'TESTEOB', 'TESTEOB', 1, '2023-05-17 22:36:00.000000', NULL, NULL, NULL, NULL, '2023-05-17 22:48:25', 1, '2023-05-17 22:48:25', 1, 0),
(9, 'TESTEOA', 'TESTEOA', 1, '2023-05-17 22:36:13.000000', NULL, NULL, NULL, NULL, '2023-05-17 22:41:44', 1, '2023-05-17 22:41:44', 1, 0),
(10, 'TESTEOA', 'TESTEOA', 1, '2023-05-17 22:37:07.000000', NULL, NULL, NULL, NULL, '2023-05-17 22:41:40', 1, '2023-05-17 22:41:40', 1, 0),
(11, 'TESTEOA', 'TESTEOA', 1, '2023-05-17 22:39:17.000000', NULL, NULL, NULL, NULL, '2023-05-17 22:41:35', 1, '2023-05-17 22:41:35', 1, 0),
(12, 'TESTEOCC', 'TESTEOCC', 1, '2023-05-17 22:47:36.000000', '2023-05-17 22:48:16.000000', NULL, NULL, NULL, '2023-05-17 22:50:07', 1, '2023-05-17 22:50:07', 1, 0),
(13, 'TESTEOBB', 'TESTEOBB', 1, '2023-05-17 22:53:37.000000', '2023-05-17 22:53:55.000000', NULL, NULL, NULL, '2023-05-17 22:54:01', 1, '2023-05-17 22:54:01', 1, 0),
(14, 'TESTEOB', 'TESTEOB', 1, '2023-05-17 23:21:54.000000', '2023-05-17 23:22:08.000000', NULL, NULL, NULL, '2023-05-17 23:23:00', 1, '2023-05-17 23:23:00', 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_sesiones`
--

CREATE TABLE `tb_sesiones` (
  `id_se` int(11) NOT NULL,
  `id_us` int(11) NOT NULL,
  `iat` decimal(30,6) NOT NULL,
  `expi` decimal(30,6) NOT NULL,
  `last_activity` datetime(6) DEFAULT NULL,
  `loged` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tb_sesiones`
--

INSERT INTO `tb_sesiones` (`id_se`, `id_us`, `iat`, `expi`, `last_activity`, `loged`) VALUES
(13, 1, 1683001396.000000, 1683004996.000000, '2023-05-01 23:23:16.000000', 0),
(14, 1, 1683001624.000000, 1683005224.000000, '2023-05-01 23:27:04.000000', 0),
(15, 1, 1683001808.000000, 1683005408.000000, '2023-05-01 23:30:08.000000', 0),
(16, 3, 1683002274.000000, 1683005874.000000, '2023-05-01 23:37:54.000000', 0),
(17, 1, 1683003873.000000, 1683007473.000000, '2023-05-02 00:04:33.000000', 0),
(18, 4, 1683004799.000000, 1683008399.000000, '2023-05-02 00:19:59.000000', 0),
(19, 1, 1683004866.000000, 1683008466.000000, '2023-05-02 00:21:06.000000', 0),
(20, 4, 1683004919.000000, 1683008519.000000, '2023-05-02 00:21:59.000000', 0),
(21, 4, 1683004982.000000, 1683008582.000000, '2023-05-02 00:23:02.000000', 0),
(22, 1, 1683013882.000000, 1683017482.000000, '2023-05-02 02:51:22.000000', 0),
(23, 1, 1683041984.000000, 1683045584.000000, '2023-05-02 10:39:44.000000', 0),
(24, 1, 1683050903.000000, 1683054503.000000, '2023-05-02 13:08:23.000000', 0),
(25, 1, 1683056212.000000, 1683059812.000000, '2023-05-02 14:36:52.000000', 0),
(26, 1, 1683067396.000000, 1683070996.000000, '2023-05-02 17:43:16.000000', 0),
(27, 1, 1683130091.000000, 1683133691.000000, '2023-05-03 11:08:11.000000', 0),
(28, 1, 1683130274.000000, 1683133874.000000, '2023-05-03 11:11:14.000000', 0),
(29, 1, 1683131709.000000, 1683135309.000000, '2023-05-03 11:35:09.000000', 0),
(30, 1, 1683151127.000000, 1683154727.000000, '2023-05-03 16:58:48.000000', 0),
(31, 1, 1683158727.000000, 1683162327.000000, '2023-05-03 19:05:27.000000', 0),
(32, 1, 1683161135.000000, 1683164735.000000, '2023-05-03 19:45:35.000000', 0),
(33, 1, 1683226134.000000, 1683229734.000000, '2023-05-04 13:48:54.000000', 0),
(34, 1, 1683232713.000000, 1683236313.000000, '2023-05-04 15:38:33.000000', 0),
(35, 1, 1683293549.000000, 1683297149.000000, '2023-05-05 08:32:29.000000', 0),
(36, 1, 1683299025.000000, 1683302625.000000, '2023-05-05 10:03:45.000000', 0),
(37, 1, 1683302380.000000, 1683305980.000000, '2023-05-05 10:59:40.000000', 0),
(38, 1, 1683314453.000000, 1683318053.000000, '2023-05-05 14:20:53.000000', 0),
(39, 1, 1683315112.000000, 1683318712.000000, '2023-05-05 14:31:52.000000', 0),
(40, 1, 1683481273.000000, 1683484873.000000, '2023-05-07 12:41:13.000000', 0),
(41, 1, 1683482533.000000, 1683486133.000000, '2023-05-07 13:02:13.000000', 0),
(42, 1, 1683487117.000000, 1683490717.000000, '2023-05-07 14:18:37.000000', 0),
(43, 1, 1683489965.000000, 1683493565.000000, '2023-05-07 15:06:05.000000', 0),
(44, 1, 1683500630.000000, 1683504230.000000, '2023-05-07 18:03:50.000000', 0),
(45, 1, 1683526746.000000, 1683530346.000000, '2023-05-08 01:19:06.000000', 0),
(46, 1, 1683526845.000000, 1683530445.000000, '2023-05-08 01:20:45.000000', 0),
(47, 1, 1683529777.000000, 1683533377.000000, '2023-05-08 02:09:37.000000', 0),
(48, 1, 1683530029.000000, 1683533629.000000, '2023-05-08 02:13:49.000000', 0),
(49, 1, 1683558571.000000, 1683562171.000000, '2023-05-08 10:09:31.000000', 0),
(50, 1, 1683563696.000000, 1683567296.000000, '2023-05-08 11:34:56.000000', 0),
(51, 1, 1683568342.000000, 1683571942.000000, '2023-05-08 12:52:22.000000', 0),
(52, 1, 1683585790.000000, 1683589390.000000, '2023-05-08 17:43:10.000000', 0),
(53, 1, 1683654796.000000, 1683658396.000000, '2023-05-09 12:53:16.000000', 0),
(54, 1, 1683664571.000000, 1683668171.000000, '2023-05-09 15:36:11.000000', 0),
(55, 1, 1683665152.000000, 1683668752.000000, '2023-05-09 15:45:52.000000', 0),
(56, 1, 1683665259.000000, 1683668859.000000, '2023-05-09 15:47:39.000000', 0),
(57, 1, 1683669604.000000, 1683673204.000000, '2023-05-09 17:00:04.000000', 0),
(58, 5, 1683669809.000000, 1683673409.000000, '2023-05-09 17:03:29.000000', 0),
(59, 1, 1683673359.000000, 1683676959.000000, '2023-05-09 18:02:39.000000', 0),
(60, 5, 1683673857.000000, 1683677457.000000, '2023-05-09 18:10:57.000000', 0),
(61, 1, 1683674114.000000, 1683677714.000000, '2023-05-09 18:15:14.000000', 0),
(62, 1, 1683675019.000000, 1683678619.000000, '2023-05-09 18:30:19.000000', 0),
(63, 1, 1683699574.000000, 1683703174.000000, '2023-05-10 01:19:34.000000', 0),
(64, 1, 1683707839.000000, 1683711439.000000, '2023-05-10 03:37:19.000000', 0),
(65, 1, 1683729771.000000, 1683733371.000000, '2023-05-10 09:42:51.000000', 0),
(66, 1, 1683733372.000000, 1683736972.000000, '2023-05-10 10:42:52.000000', 0),
(67, 5, 1683733480.000000, 1683737080.000000, '2023-05-10 10:44:40.000000', 0),
(68, 1, 1683734225.000000, 1683737825.000000, '2023-05-10 10:57:05.000000', 0),
(69, 5, 1683736350.000000, 1683739950.000000, '2023-05-10 11:32:30.000000', 0),
(70, 1, 1683754617.000000, 1683758217.000000, '2023-05-10 16:36:57.000000', 0),
(71, 1, 1683760720.000000, 1683764320.000000, '2023-05-10 18:18:40.000000', 0),
(72, 1, 1683765498.000000, 1683769098.000000, '2023-05-10 19:38:18.000000', 0),
(73, 1, 1683785162.000000, 1683788762.000000, '2023-05-11 01:06:02.000000', 0),
(74, 1, 1683787436.000000, 1683791036.000000, '2023-05-11 01:43:56.000000', 0),
(75, 5, 1683788828.000000, 1683792428.000000, '2023-05-11 02:07:08.000000', 0),
(76, 1, 1683789177.000000, 1683792777.000000, '2023-05-11 02:12:57.000000', 0),
(77, 1, 1683793133.000000, 1683796733.000000, '2023-05-11 03:18:53.000000', 0),
(78, 1, 1683793484.000000, 1683797084.000000, '2023-05-11 03:24:44.000000', 0),
(79, 1, 1683793537.000000, 1683797137.000000, '2023-05-11 03:25:37.000000', 0),
(80, 1, 1683793620.000000, 1683797220.000000, '2023-05-11 03:27:00.000000', 0),
(81, 1, 1683794344.000000, 1683797944.000000, '2023-05-11 03:39:04.000000', 0),
(82, 1, 1683819137.000000, 1683822737.000000, '2023-05-11 10:32:17.000000', 0),
(83, 1, 1683821970.000000, 1683825570.000000, '2023-05-11 11:19:30.000000', 0),
(84, 5, 1683823332.000000, 1683826932.000000, '2023-05-11 11:42:12.000000', 0),
(85, 1, 1683838653.000000, 1683842253.000000, '2023-05-11 15:57:33.000000', 0),
(86, 5, 1683847081.000000, 1683850681.000000, '2023-05-11 18:18:01.000000', 0),
(87, 5, 1683847118.000000, 1683850718.000000, '2023-05-11 18:18:38.000000', 0),
(88, 1, 1683851286.000000, 1683854886.000000, '2023-05-11 19:28:06.000000', 0),
(89, 1, 1683851362.000000, 1683854962.000000, '2023-05-11 19:29:22.000000', 0),
(90, 1, 1683851529.000000, 1683855129.000000, '2023-05-11 19:32:09.000000', 0),
(91, 1, 1683852665.000000, 1683856265.000000, '2023-05-11 19:51:05.000000', 0),
(92, 1, 1683874474.000000, 1683878074.000000, '2023-05-12 01:54:34.000000', 0),
(93, 1, 1683874520.000000, 1683878120.000000, '2023-05-12 01:55:20.000000', 0),
(94, 1, 1683876374.000000, 1683879974.000000, '2023-05-12 02:26:14.000000', 0),
(95, 1, 1683877948.000000, 1683881548.000000, '2023-05-12 02:52:28.000000', 0),
(96, 1, 1683877977.000000, 1683881577.000000, '2023-05-12 02:52:57.000000', 0),
(97, 1, 1683879150.000000, 1683882750.000000, '2023-05-12 03:12:30.000000', 0),
(98, 1, 1683904414.000000, 1683908014.000000, '2023-05-12 10:13:34.000000', 0),
(99, 1, 1683904463.000000, 1683908063.000000, '2023-05-12 10:14:23.000000', 0),
(100, 1, 1683904693.000000, 1683908293.000000, '2023-05-12 10:18:13.000000', 0),
(101, 1, 1683904911.000000, 1683908511.000000, '2023-05-12 10:21:51.000000', 0),
(102, 1, 1683904995.000000, 1683908595.000000, '2023-05-12 10:23:15.000000', 0),
(103, 1, 1683905125.000000, 1683908725.000000, '2023-05-12 10:25:25.000000', 0),
(104, 1, 1683905148.000000, 1683908748.000000, '2023-05-12 10:25:48.000000', 0),
(105, 1, 1683906459.000000, 1683910059.000000, '2023-05-12 10:47:39.000000', 0),
(106, 1, 1683916897.000000, 1683920497.000000, '2023-05-12 13:41:37.000000', 0),
(107, 1, 1683926170.000000, 1683929770.000000, '2023-05-12 16:16:10.000000', 0),
(108, 1, 1683926448.000000, 1683930048.000000, '2023-05-12 16:20:48.000000', 0),
(109, 1, 1683926505.000000, 1683930105.000000, '2023-05-12 16:21:45.000000', 0),
(110, 1, 1683948804.000000, 1683952404.000000, '2023-05-12 22:33:24.000000', 0),
(111, 1, 1683951506.000000, 1683955106.000000, '2023-05-12 23:18:26.000000', 0),
(112, 1, 1683953845.000000, 1683957445.000000, '2023-05-12 23:57:25.000000', 0),
(113, 1, 1683956184.000000, 1683959784.000000, '2023-05-13 00:36:24.000000', 0),
(114, 1, 1683995525.000000, 1683999125.000000, '2023-05-13 11:32:05.000000', 0),
(115, 1, 1683995673.000000, 1683999273.000000, '2023-05-13 11:34:33.000000', 0),
(116, 5, 1683995756.000000, 1683999356.000000, '2023-05-13 11:35:56.000000', 0),
(117, 1, 1684258227.000000, 1684261827.000000, '2023-05-16 12:30:27.000000', 0),
(118, 1, 1684276619.000000, 1684280219.000000, '2023-05-16 17:36:59.000000', 0),
(119, 5, 1684277141.000000, 1684280741.000000, '2023-05-16 17:45:41.000000', 0),
(120, 1, 1684277213.000000, 1684280813.000000, '2023-05-16 17:46:53.000000', 0),
(121, 5, 1684277277.000000, 1684280877.000000, '2023-05-16 17:47:57.000000', 0),
(122, 1, 1684277411.000000, 1684281011.000000, '2023-05-16 17:50:11.000000', 0),
(123, 1, 1684302741.000000, 1684306341.000000, '2023-05-17 00:52:21.000000', 0),
(124, 5, 1684306515.000000, 1684310115.000000, '2023-05-17 01:55:15.000000', 0),
(125, 1, 1684306576.000000, 1684310176.000000, '2023-05-17 01:56:16.000000', 0),
(126, 5, 1684306710.000000, 1684310310.000000, '2023-05-17 01:58:30.000000', 0),
(127, 1, 1684306796.000000, 1684310396.000000, '2023-05-17 01:59:56.000000', 0),
(128, 1, 1684312439.000000, 1684316039.000000, '2023-05-17 03:33:59.000000', 0),
(129, 1, 1684335996.000000, 1684339596.000000, '2023-05-17 10:06:36.000000', 0),
(130, 1, 1684336111.000000, 1684339711.000000, '2023-05-17 10:08:31.000000', 0),
(131, 1, 1684369484.000000, 1684373084.000000, '2023-05-17 19:24:44.000000', 0),
(132, 1, 1684369544.000000, 1684373144.000000, '2023-05-17 19:25:44.000000', 0),
(133, 1, 1684369622.000000, 1684373222.000000, '2023-05-17 19:27:02.000000', 0),
(134, 1, 1684369863.000000, 1684373463.000000, '2023-05-17 19:31:03.000000', 0),
(135, 1, 1684369909.000000, 1684373509.000000, '2023-05-17 19:31:49.000000', 0),
(136, 1, 1684369974.000000, 1684373574.000000, '2023-05-17 19:32:54.000000', 0),
(137, 1, 1684370364.000000, 1684373964.000000, '2023-05-17 19:39:24.000000', 0),
(138, 1, 1684378679.000000, 1684382279.000000, '2023-05-17 21:57:59.000000', 0),
(139, 1, 1684386729.000000, 1684390329.000000, '2023-05-18 00:12:09.000000', 0),
(140, 1, 1684388594.000000, 1684392194.000000, '2023-05-18 00:43:14.000000', 0),
(141, 1, 1684392182.000000, 1684395782.000000, '2023-05-18 01:43:02.000000', 0),
(142, 1, 1684392206.000000, 1684395806.000000, '2023-05-18 01:43:26.000000', 0),
(143, 1, 1684392883.000000, 1684396483.000000, '2023-05-18 01:54:43.000000', 0),
(144, 1, 1684392999.000000, 1684396599.000000, '2023-05-18 01:56:39.000000', 0),
(145, 1, 1684393092.000000, 1684396692.000000, '2023-05-18 01:58:12.000000', 0),
(146, 1, 1684393203.000000, 1684396803.000000, '2023-05-18 02:00:03.000000', 0),
(147, 1, 1684394015.000000, 1684397615.000000, '2023-05-18 02:13:35.000000', 0),
(148, 1, 1684394025.000000, 1684397625.000000, '2023-05-18 02:13:45.000000', 0),
(149, 1, 1684394054.000000, 1684397654.000000, '2023-05-18 02:14:14.000000', 0),
(150, 1, 1684396278.000000, 1684399878.000000, '2023-05-18 02:51:18.000000', 0),
(151, 1, 1684396670.000000, 1684400270.000000, '2023-05-18 02:57:50.000000', 0),
(152, 1, 1684398287.000000, 1684401887.000000, '2023-05-18 03:24:47.000000', 0),
(153, 1, 1684398335.000000, 1684401935.000000, '2023-05-18 03:25:35.000000', 0),
(154, 1, 1684428846.000000, 1684432446.000000, '2023-05-18 11:54:06.000000', 0),
(155, 1, 1684428966.000000, 1684432566.000000, '2023-05-18 11:56:06.000000', 0),
(156, 1, 1684431890.000000, 1684435490.000000, '2023-05-18 12:44:50.000000', 0),
(157, 1, 1684456866.000000, 1684460466.000000, '2023-05-18 19:41:06.000000', 0),
(158, 1, 1684468566.000000, 1684472166.000000, '2023-05-18 22:56:06.000000', 0),
(159, 5, 1684470110.000000, 1684473710.000000, '2023-05-18 23:21:50.000000', 0),
(160, 1, 1684470705.000000, 1684474305.000000, '2023-05-18 23:31:45.000000', 0),
(161, 1, 1684482261.000000, 1684485861.000000, '2023-05-19 02:44:21.000000', 0),
(162, 1, 1684500666.000000, 1684504266.000000, '2023-05-19 07:51:06.000000', 0),
(163, 1, 1684513024.000000, 1684516624.000000, '2023-05-19 11:17:04.000000', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tb_users`
--

CREATE TABLE `tb_users` (
  `id_us` int(11) NOT NULL,
  `docident_us` varchar(10) NOT NULL,
  `nombres_us` varchar(50) NOT NULL,
  `apepat_us` varchar(50) NOT NULL,
  `apemat_us` varchar(50) NOT NULL,
  `email_us` varchar(50) DEFAULT NULL,
  `usuario_us` varchar(20) NOT NULL,
  `creacion_us` datetime(6) NOT NULL,
  `actualizacion_us` datetime(6) DEFAULT NULL,
  `estado_us` int(11) NOT NULL,
  `intentos_us` int(11) DEFAULT NULL,
  `bloqueo_us` int(11) DEFAULT NULL,
  `change_pass` int(11) DEFAULT NULL,
  `bloqueo_time` decimal(30,6) DEFAULT NULL,
  `perfil_us` int(11) DEFAULT NULL,
  `idempresa` int(11) DEFAULT NULL,
  `idposicion` int(11) DEFAULT NULL,
  `idarea` int(11) DEFAULT NULL,
  `idunidad` int(11) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0,
  `escenario` int(11) DEFAULT NULL,
  `is_user_negocio` int(11) DEFAULT NULL,
  `date_add` datetime DEFAULT NULL,
  `date_modify` datetime DEFAULT NULL,
  `date_deleted` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tb_users`
--

INSERT INTO `tb_users` (`id_us`, `docident_us`, `nombres_us`, `apepat_us`, `apemat_us`, `email_us`, `usuario_us`, `creacion_us`, `actualizacion_us`, `estado_us`, `intentos_us`, `bloqueo_us`, `change_pass`, `bloqueo_time`, `perfil_us`, `idempresa`, `idposicion`, `idarea`, `idunidad`, `id_user_added`, `id_user_updated`, `id_user_deleted`, `is_deleted`, `escenario`, `is_user_negocio`, `date_add`, `date_modify`, `date_deleted`) VALUES
(1, '33333333', 'Administrador', 'Administrador', 'Administrador', 'mpantach@valtx.pe', 'administrador', '2023-05-01 20:46:14.000000', '2023-05-18 22:55:56.000000', 1, 1, 0, 1, NULL, 1, 3, 3, 2, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
(5, '33333333', 'testeoAA', 'testeoAA', 'testeoAA', 'mpantac@unprg.edu.pe', 'testeo1', '2023-05-03 11:12:03.000000', '2023-05-17 01:23:30.000000', 1, 1, 0, 1, NULL, 6, 3, 1, 2, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
(7, '22222222', 'testeo2', 'testeo2', 'testeo2', 'youkai.miguel@gmail.com', 'testeo2', '2023-05-04 17:28:29.000000', NULL, 1, 1, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, NULL, 1, 1, NULL, NULL, NULL, '2023-05-04 17:28:33', '2023-05-04 17:28:33'),
(8, '44444444', '', '', '', 'youkai.miguel@gmail.com', 'Testeo3', '2023-05-07 18:04:58.000000', '2023-05-18 14:38:35.000000', 1, 1, 1, 1, NULL, 6, 3, 1, 2, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL),
(9, '12345432', 'aisa', 'aisa', 'aisa', 'youkai.miguel@gmail.com', 'aisa123', '2023-05-10 18:46:33.000000', '2023-05-17 01:23:20.000000', 1, 1, 0, 0, NULL, 6, 3, 1, 2, 1, NULL, NULL, 1, 1, NULL, NULL, NULL, '2023-05-17 23:20:41', '2023-05-17 23:20:41'),
(10, '44444445', 'testeo', 'testeo', 'testeo', 'youkai.miguel@gmail.com', 'testeo5', '2023-05-12 10:19:40.000000', NULL, 1, 1, 0, 1, NULL, 1, 3, 1, 2, 1, NULL, NULL, 1, 1, NULL, NULL, NULL, '2023-05-12 13:52:35', '2023-05-12 13:52:35'),
(11, '43454345', 'testeoA', 'testeoA', 'testeoA', 'youkai.miguel@gmail.com', 'testeo6', '2023-05-17 23:17:39.000000', '2023-05-17 23:18:30.000000', 1, 1, 0, 0, NULL, 1, 6, 0, 6, 0, NULL, NULL, 1, 1, NULL, NULL, NULL, '2023-05-17 23:19:19', '2023-05-17 23:19:19'),
(12, '11111110', 'testeo10', 'testeo10', 'testeo10', 'youkai.miguel@gmail.com', 'testeo10', '2023-05-18 19:49:10.000000', NULL, 1, 1, 0, 0, NULL, 1, 0, 0, 0, 0, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_activo`
--

CREATE TABLE `tipo_activo` (
  `id` int(11) NOT NULL,
  `tipo` varchar(150) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_activo`
--

INSERT INTO `tipo_activo` (`id`, `tipo`, `estado`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`) VALUES
(1, 'TIPOACTIVOA', 1, 1, '2023-05-07 18:27:32.000000', NULL, NULL, NULL, NULL, 0),
(2, 'TIPOACTIVOB', 1, 1, '2023-05-07 18:27:39.000000', NULL, NULL, NULL, NULL, 0),
(3, 'ELECTRÓNICOS', 1, 1, '2023-05-18 14:08:57.000000', 1, '2023-05-18 14:13:29.000000', 1, '2023-05-18 14:13:29.000000', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_amenaza`
--

CREATE TABLE `tipo_amenaza` (
  `id` int(11) NOT NULL,
  `tipo` varchar(150) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_amenaza`
--

INSERT INTO `tipo_amenaza` (`id`, `tipo`, `estado`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`) VALUES
(1, 'AMENAZAA', 1, 1, '2023-05-07 18:25:46.000000', NULL, NULL, NULL, NULL, 0),
(2, 'AMENAZAB', 1, 1, '2023-05-07 18:25:55.000000', NULL, NULL, NULL, NULL, 0),
(3, 'AMENAZAC', 1, 1, '2023-05-09 18:06:54.000000', NULL, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_riesgo`
--

CREATE TABLE `tipo_riesgo` (
  `id` int(11) NOT NULL,
  `tipo_riesgo` varchar(150) NOT NULL,
  `descripcion` varchar(150) NOT NULL,
  `estado` int(11) NOT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_riesgo`
--

INSERT INTO `tipo_riesgo` (`id`, `tipo_riesgo`, `descripcion`, `estado`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`) VALUES
(1, 'TipoRiesgoA', 'TipoRiesgoA', 1, 1, '2023-05-07 18:21:35.000000', NULL, NULL, NULL, NULL, 0),
(2, 'TipoRiesgoB', 'TipoRiesgoB', 1, 1, '2023-05-07 18:21:54.000000', NULL, NULL, NULL, NULL, 0),
(3, 'TipoRiesgoCC', 'TipoRiesgoCC', 1, 1, '2023-05-09 18:03:14.000000', 1, '2023-05-09 18:04:10.000000', 1, '2023-05-09 18:04:25.000000', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubicacion_activo`
--

CREATE TABLE `ubicacion_activo` (
  `id` int(11) NOT NULL,
  `continente` varchar(150) DEFAULT NULL,
  `pais` varchar(150) DEFAULT NULL,
  `ciudad` varchar(150) DEFAULT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ubicacion_activo`
--

INSERT INTO `ubicacion_activo` (`id`, `continente`, `pais`, `ciudad`, `direccion`, `descripcion`, `estado`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`) VALUES
(1, 'América', '89', '1610', 'AV. JAVIER PRADO 1333', 'INFRAESTRUCTURA', 1, 1, '2023-05-07 18:28:40.000000', NULL, NULL, NULL, NULL, 0),
(2, 'América', '89', '1605', 'AV. balta', 'INFRAESTRUCTURAA', 1, 1, '2023-05-18 14:26:27.000000', NULL, '2023-05-18 14:30:47.000000', 1, '2023-05-18 14:30:47.000000', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidades`
--

CREATE TABLE `unidades` (
  `id` int(11) NOT NULL,
  `unidad` varchar(50) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `idempresa` int(11) DEFAULT NULL,
  `idarea` int(11) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `unidades`
--

INSERT INTO `unidades` (`id`, `unidad`, `estado`, `idempresa`, `idarea`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`) VALUES
(1, 'PLANEAMIENTO', 1, 3, 2, 1, '2023-05-03 11:09:08.000000', 1, '2023-05-18 12:35:26.000000', NULL, NULL, 0),
(2, 'UnidadB', 1, 3, 3, 1, '2023-05-03 11:09:18.000000', NULL, '2023-05-18 11:56:20.000000', NULL, NULL, 0),
(3, 'UnidadB', 1, 3, 2, 1, '2023-05-18 12:35:34.000000', NULL, '2023-05-18 12:35:51.000000', 1, '2023-05-18 12:35:51.000000', 1),
(4, 'UNIDADA', 1, 3, 2, 1, '2023-05-18 20:12:19.000000', NULL, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `valoracion_activo`
--

CREATE TABLE `valoracion_activo` (
  `id` int(11) NOT NULL,
  `idvalor` int(11) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `valoracion_activo`
--

INSERT INTO `valoracion_activo` (`id`, `idvalor`, `estado`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`) VALUES
(1, 1, 1, 1, '2023-05-03 11:56:19.000000', 1, '2023-05-11 18:04:19.000000', NULL, NULL, 0),
(2, 2, 1, 1, '2023-05-03 11:56:32.000000', 1, '2023-05-11 19:09:31.000000', NULL, NULL, 0),
(4, 3, 1, 1, '2023-05-03 12:07:11.000000', 1, '2023-05-11 19:09:37.000000', NULL, NULL, 0),
(5, 1, 1, 1, '2023-05-18 13:48:25.000000', NULL, NULL, NULL, NULL, 0),
(6, 1, 1, 1, '2023-05-18 13:48:59.000000', NULL, '2023-05-18 14:02:03.000000', 1, '2023-05-18 14:02:03.000000', 1),
(7, 2, 1, 1, '2023-05-18 13:50:22.000000', 1, '2023-05-18 13:56:39.000000', 1, '2023-05-18 13:56:39.000000', 1),
(8, 2, 1, 1, '2023-05-18 20:23:18.000000', 1, '2023-05-18 20:23:31.000000', 1, '2023-05-18 20:23:31.000000', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `valoracion_riesgo`
--

CREATE TABLE `valoracion_riesgo` (
  `id` int(11) NOT NULL,
  `idprobabilidad_riesgo` int(11) DEFAULT NULL,
  `idimpacto_riesgo` int(11) DEFAULT NULL,
  `valor` varchar(100) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `valoracion_riesgo`
--

INSERT INTO `valoracion_riesgo` (`id`, `idprobabilidad_riesgo`, `idimpacto_riesgo`, `valor`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`) VALUES
(1, 2, 1, 'ALTO', 1, '2023-05-07 00:00:00.000000', NULL, '2023-05-07 18:34:00.000000', 1, '2023-05-07 18:34:00.000000', 1),
(2, 2, 2, 'MEDIO', 1, '2023-05-07 00:00:00.000000', NULL, '2023-05-07 18:33:56.000000', 1, '2023-05-07 18:33:56.000000', 1),
(3, 1, 1, 'BAJO', 1, '2023-05-07 00:00:00.000000', NULL, '2023-05-07 18:33:52.000000', 1, '2023-05-07 18:33:52.000000', 1),
(4, 1, 2, 'MEDIO', 1, '2023-05-07 00:00:00.000000', NULL, '2023-05-07 18:33:49.000000', 1, '2023-05-07 18:33:49.000000', 1),
(5, 3, 1, 'ALTO', 1, '2023-05-07 00:00:00.000000', NULL, '2023-05-08 11:41:24.000000', 1, '2023-05-08 11:41:24.000000', 1),
(6, 3, 2, 'ALTO', 1, '2023-05-07 00:00:00.000000', NULL, '2023-05-08 18:25:46.000000', 1, '2023-05-08 18:25:46.000000', 1),
(7, 1, 1, 'MEDIO', 1, '2023-05-07 00:00:00.000000', NULL, '2023-05-08 18:54:27.000000', 1, '2023-05-08 18:54:27.000000', 1),
(8, 1, 2, 'ALTO', 1, '2023-05-07 00:00:00.000000', NULL, '2023-05-08 11:44:47.000000', 1, '2023-05-08 11:44:47.000000', 1),
(9, 3, 1, 'ALTO', 1, '2023-05-08 00:00:00.000000', NULL, '2023-05-08 18:09:11.000000', 1, '2023-05-08 18:09:11.000000', 1),
(10, 1, 2, 'MEDIO', 1, '2023-05-08 00:00:00.000000', NULL, '2023-05-08 18:15:28.000000', 1, '2023-05-08 18:15:28.000000', 1),
(11, 3, 1, 'MEDIO', 1, '2023-05-08 00:00:00.000000', NULL, '2023-05-08 18:27:59.000000', 1, '2023-05-08 18:27:59.000000', 1),
(12, 1, 2, 'BAJO', 1, '2023-05-08 00:00:00.000000', NULL, '2023-05-08 18:52:03.000000', 1, '2023-05-08 18:52:03.000000', 1),
(13, 3, 2, 'ALTO', 1, '2023-05-08 00:00:00.000000', NULL, NULL, NULL, NULL, 0),
(14, 3, 1, 'medio', 1, '2023-05-08 00:00:00.000000', NULL, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `valor_activo`
--

CREATE TABLE `valor_activo` (
  `id` int(11) NOT NULL,
  `valor` varchar(150) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `id_user_added` int(11) DEFAULT NULL,
  `date_add` datetime(6) DEFAULT NULL,
  `id_user_updated` int(11) DEFAULT NULL,
  `date_modify` datetime(6) DEFAULT NULL,
  `id_user_deleted` int(11) DEFAULT NULL,
  `date_deleted` datetime(6) DEFAULT NULL,
  `is_deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `valor_activo`
--

INSERT INTO `valor_activo` (`id`, `valor`, `estado`, `id_user_added`, `date_add`, `id_user_updated`, `date_modify`, `id_user_deleted`, `date_deleted`, `is_deleted`) VALUES
(1, 'NO SIGNIFICATIVOO', 1, 1, '2023-05-03 11:54:49.000000', 1, '2023-05-18 13:25:18.000000', NULL, NULL, 0),
(2, 'ALTO', 1, 1, '2023-05-03 11:55:05.000000', NULL, NULL, NULL, NULL, 0),
(3, 'EXTREMO', 1, 1, '2023-05-03 11:55:10.000000', NULL, NULL, NULL, NULL, 0),
(5, 'MUY ALTO', 1, 1, '2023-05-18 13:43:10.000000', NULL, '2023-05-18 13:43:15.000000', 1, '2023-05-18 13:43:15.000000', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `actividades_plan`
--
ALTER TABLE `actividades_plan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_alerta_act` (`idalerta`),
  ADD KEY `fk_empresa_act` (`idempresa`),
  ADD KEY `fk_area_act` (`idarea`),
  ADD KEY `fk_unidad_act` (`idunidades`),
  ADD KEY `fk_posicion_act` (`idposicion_puesto`),
  ADD KEY `fk_usuario_act` (`idusuario`),
  ADD KEY `FK__actividad__id_us__51851410` (`id_user_added`),
  ADD KEY `FK__actividad__id_us__52793849` (`id_user_updated`),
  ADD KEY `FK__actividad__id_us__536D5C82` (`id_user_deleted`);

--
-- Indices de la tabla `alert_seguimiento`
--
ALTER TABLE `alert_seguimiento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__alert_seg__id_us__5555A4F4` (`id_user_added`),
  ADD KEY `FK__alert_seg__id_us__5649C92D` (`id_user_updated`),
  ADD KEY `FK__alert_seg__id_us__573DED66` (`id_user_deleted`);

--
-- Indices de la tabla `aplicacion_impacto`
--
ALTER TABLE `aplicacion_impacto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__aplicacio__id_us__592635D8` (`id_user_added`),
  ADD KEY `FK__aplicacio__id_us__5A1A5A11` (`id_user_updated`),
  ADD KEY `FK__aplicacio__id_us__5B0E7E4A` (`id_user_deleted`);

--
-- Indices de la tabla `aplicacion_probailidad`
--
ALTER TABLE `aplicacion_probailidad`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__aplicacio__id_us__5CF6C6BC` (`id_user_added`),
  ADD KEY `FK__aplicacio__id_us__5DEAEAF5` (`id_user_updated`),
  ADD KEY `FK__aplicacio__id_us__5EDF0F2E` (`id_user_deleted`);

--
-- Indices de la tabla `area`
--
ALTER TABLE `area`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__area__id_user_ad__60C757A0` (`id_user_added`),
  ADD KEY `FK__area__id_user_up__61BB7BD9` (`id_user_updated`),
  ADD KEY `FK__area__id_user_de__62AFA012` (`id_user_deleted`),
  ADD KEY `FK_area_empresa1` (`idempresa`);

--
-- Indices de la tabla `aspectos_seguridad`
--
ALTER TABLE `aspectos_seguridad`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__aspectos___id_us__6497E884` (`id_user_added`),
  ADD KEY `FK__aspectos___id_us__658C0CBD` (`id_user_updated`),
  ADD KEY `FK__aspectos___id_us__668030F6` (`id_user_deleted`);

--
-- Indices de la tabla `caracteristica_control`
--
ALTER TABLE `caracteristica_control`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__caracteri__id_us__4DB4832C` (`id_user_added`),
  ADD KEY `FK__caracteri__id_us__4EA8A765` (`id_user_updated`),
  ADD KEY `FK__caracteri__id_us__4F9CCB9E` (`id_user_deleted`);

--
-- Indices de la tabla `catalogo_tabla`
--
ALTER TABLE `catalogo_tabla`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `categoria_activo`
--
ALTER TABLE `categoria_activo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_categoria_activo_tipo_activo` (`idtipo_activo`),
  ADD KEY `FK__categoria__id_us__6E2152BE` (`id_user_updated`),
  ADD KEY `FK__categoria__id_us__6F1576F7` (`id_user_deleted`);

--
-- Indices de la tabla `categoria_vulnerabilidad`
--
ALTER TABLE `categoria_vulnerabilidad`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__categoria__id_us__70FDBF69` (`id_user_updated`),
  ADD KEY `FK__categoria__id_us__71F1E3A2` (`id_user_deleted`);

--
-- Indices de la tabla `ciudad`
--
ALTER TABLE `ciudad`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `clasificacion_informacion`
--
ALTER TABLE `clasificacion_informacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__clasifica__id_us__7993056A` (`id_user_updated`),
  ADD KEY `FK__clasifica__id_us__7A8729A3` (`id_user_deleted`);

--
-- Indices de la tabla `cobertura`
--
ALTER TABLE `cobertura`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__cobertura__id_us__7C6F7215` (`id_user_updated`),
  ADD KEY `FK__cobertura__id_us__7D63964E` (`id_user_deleted`);

--
-- Indices de la tabla `config_pass`
--
ALTER TABLE `config_pass`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `continente`
--
ALTER TABLE `continente`
  ADD PRIMARY KEY (`ContinenteCodigo`);

--
-- Indices de la tabla `controles`
--
ALTER TABLE `controles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__controles__id_us__004002F9` (`id_user_deleted`),
  ADD KEY `FK__controles__id_us__7F4BDEC0` (`id_user_updated`);

--
-- Indices de la tabla `correo_actividad`
--
ALTER TABLE `correo_actividad`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `correo_plan`
--
ALTER TABLE `correo_plan`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `datos_correo`
--
ALTER TABLE `datos_correo`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `desc_amenaza`
--
ALTER TABLE `desc_amenaza`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__desc_amen__id_us__0504B816` (`id_user_updated`),
  ADD KEY `FK__desc_amen__id_us__05F8DC4F` (`id_user_deleted`),
  ADD KEY `fk_tipo_amenaza` (`idtipo_amenaza`);

--
-- Indices de la tabla `desc_vulnerabilidad`
--
ALTER TABLE `desc_vulnerabilidad`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__desc_vuln__id_us__07E124C1` (`id_user_updated`),
  ADD KEY `FK__desc_vuln__id_us__08D548FA` (`id_user_deleted`),
  ADD KEY `fk_vulne_cate` (`idcategoria_vulnerabilidad`);

--
-- Indices de la tabla `detalle_controles`
--
ALTER TABLE `detalle_controles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idcaracteristica_control` (`idcaracteristica_control`);

--
-- Indices de la tabla `detalle_evaluacion_control`
--
ALTER TABLE `detalle_evaluacion_control`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `detalle_valoracion_activo`
--
ALTER TABLE `detalle_valoracion_activo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idaspectos_seguridad` (`idaspectos_seguridad`);

--
-- Indices de la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__empresa__id_user__0D99FE17` (`id_user_updated`),
  ADD KEY `FK__empresa__id_user__0E8E2250` (`id_user_deleted`);

--
-- Indices de la tabla `escenario_active`
--
ALTER TABLE `escenario_active`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `estado`
--
ALTER TABLE `estado`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__estado__id_user___10766AC2` (`id_user_updated`),
  ADD KEY `FK__estado__id_user___116A8EFB` (`id_user_deleted`);

--
-- Indices de la tabla `evaluacion_control2`
--
ALTER TABLE `evaluacion_control2`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__evaluacio__id_us__5ECA0095` (`id_user_added`),
  ADD KEY `FK__evaluacio__id_us__5FBE24CE` (`id_user_updated`),
  ADD KEY `FK__evaluacio__id_us__60B24907` (`id_user_deleted`);

--
-- Indices de la tabla `evaluacion_riesgo`
--
ALTER TABLE `evaluacion_riesgo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__evaluacio__id_us__46BD6CDA` (`id_user_added`),
  ADD KEY `FK__evaluacio__id_us__47B19113` (`id_user_updated`),
  ADD KEY `FK__evaluacio__id_us__48A5B54C` (`id_user_deleted`),
  ADD KEY `FK__evaluacio__id_ti__4999D985` (`id_tipo_riesgo`),
  ADD KEY `FK__evaluacio__id_em__4A8DFDBE` (`idempresa`),
  ADD KEY `FK__evaluacio__id_ar__4B8221F7` (`idarea`),
  ADD KEY `FK__evaluacio__id_un__4C764630` (`idunidades`),
  ADD KEY `FK__evaluacio__id_ma__4D6A6A69` (`idmacroproceso`),
  ADD KEY `FK__evaluacio__id_pr__4E5E8EA2` (`idproceso`),
  ADD KEY `FK__evaluacio__id_ti__4F52B2DB` (`id_tipo_amenaza`),
  ADD KEY `FK__evaluacio__id_de__5046D714` (`id_descripcion_amenaza`),
  ADD KEY `idprobabilidad_riesgo` (`idprobabilidad_riesgo`),
  ADD KEY `idimpacto_riesgo` (`idimpacto_riesgo`),
  ADD KEY `idnivel_riesgo` (`idnivel_riesgo`),
  ADD KEY `idvaloracion_riesgo` (`idvaloracion_riesgo`),
  ADD KEY `idinventario_clasificacion_activo` (`idinventario_clasificacion_activo`);

--
-- Indices de la tabla `evaluacion_riesgos_controles`
--
ALTER TABLE `evaluacion_riesgos_controles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idregistro_controles` (`idregistro_controles`),
  ADD KEY `idevaluacion_riesgo` (`idevaluacion_riesgo`);

--
-- Indices de la tabla `evaluacion_riesgo_historial`
--
ALTER TABLE `evaluacion_riesgo_historial`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__evaluacio__id_us__550B8C31` (`id_user_added`),
  ADD KEY `FK__evaluacio__id_us__55FFB06A` (`id_user_updated`),
  ADD KEY `FK__evaluacio__id_us__56F3D4A3` (`id_user_deleted`),
  ADD KEY `FK__evaluacio__id_ti__57E7F8DC` (`id_tipo_riesgo`),
  ADD KEY `FK__evaluacio__id_em__58DC1D15` (`idempresa`),
  ADD KEY `FK__evaluacio__id_ar__59D0414E` (`idarea`),
  ADD KEY `FK__evaluacio__id_un__5AC46587` (`idunidades`),
  ADD KEY `FK__evaluacio__id_ma__5BB889C0` (`idmacroproceso`),
  ADD KEY `FK__evaluacio__id_pr__5CACADF9` (`idproceso`),
  ADD KEY `FK__evaluacio__id_ti__5DA0D232` (`id_tipo_amenaza`),
  ADD KEY `FK__evaluacio__id_de__5E94F66B` (`id_descripcion_amenaza`);

--
-- Indices de la tabla `impacto_riesgo`
--
ALTER TABLE `impacto_riesgo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__impacto_r__id_us__1352D76D` (`id_user_updated`),
  ADD KEY `FK__impacto_r__id_us__1446FBA6` (`id_user_deleted`);

--
-- Indices de la tabla `inventario_clasificacion_activo`
--
ALTER TABLE `inventario_clasificacion_activo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__inventari__idemp__6265874F` (`idempresa`),
  ADD KEY `FK__inventari__idare__6359AB88` (`idarea`),
  ADD KEY `FK__inventari__iduni__644DCFC1` (`idunidades`),
  ADD KEY `FK__inventari__idmac__6541F3FA` (`idmacroproceso`),
  ADD KEY `FK__inventari__idpro__66361833` (`idproceso`),
  ADD KEY `FK__inventari__idtip__672A3C6C` (`idtipo_activo`),
  ADD KEY `FK__inventari__idcat__681E60A5` (`idcategoria_activo`),
  ADD KEY `FK__inventari__idubi__691284DE` (`idubicacion`),
  ADD KEY `FK__inventari__idval__6A06A917` (`idvalor`),
  ADD KEY `FK__inventari__id_us__6AFACD50` (`id_user_added`),
  ADD KEY `FK__inventari__id_us__6BEEF189` (`id_user_updated`),
  ADD KEY `FK__inventari__id_us__6CE315C2` (`id_user_deleted`),
  ADD KEY `fk_inventario_valoracion` (`idvaloracion_activo`),
  ADD KEY `idclasificacion_informacion` (`idclasificacion_informacion`);

--
-- Indices de la tabla `inventario_clasificacion_activo_historial`
--
ALTER TABLE `inventario_clasificacion_activo_historial`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__inventari__idubi__00EA0E6F` (`idubicacion`),
  ADD KEY `FK__inventari__idval__01DE32A8` (`idvalor`),
  ADD KEY `FK__inventari__id_us__02D256E1` (`id_user_added`),
  ADD KEY `FK__inventari__id_us__03C67B1A` (`id_user_updated`),
  ADD KEY `FK__inventari__id_us__04BA9F53` (`id_user_deleted`),
  ADD KEY `FK__inventari__idemp__7A3D10E0` (`idempresa`),
  ADD KEY `FK__inventari__idare__7B313519` (`idarea`),
  ADD KEY `FK__inventari__iduni__7C255952` (`idunidades`),
  ADD KEY `FK__inventari__idmac__7D197D8B` (`idmacroproceso`),
  ADD KEY `FK__inventari__idpro__7E0DA1C4` (`idproceso`),
  ADD KEY `FK__inventari__idtip__7F01C5FD` (`idtipo_activo`),
  ADD KEY `FK__inventari__idcat__7FF5EA36` (`idcategoria_activo`),
  ADD KEY `idclasificacion_informacion` (`idclasificacion_informacion`);

--
-- Indices de la tabla `log_acciones`
--
ALTER TABLE `log_acciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `log_sistema`
--
ALTER TABLE `log_sistema`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `macroproceso`
--
ALTER TABLE `macroproceso`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_macroprocesos_unidades` (`idunidades`),
  ADD KEY `FK__macroproc__id_us__190BB0C3` (`id_user_updated`),
  ADD KEY `FK__macroproc__id_us__19FFD4FC` (`id_user_deleted`),
  ADD KEY `FK_macroprocesos_area` (`idarea`),
  ADD KEY `FK_macroprocesos_empresa` (`idempresa`);

--
-- Indices de la tabla `nivel_riesgo`
--
ALTER TABLE `nivel_riesgo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__nivel_rie__id_us__50B0EB68` (`id_user_added`),
  ADD KEY `FK__nivel_rie__id_us__51A50FA1` (`id_user_updated`),
  ADD KEY `FK__nivel_rie__id_us__529933DA` (`id_user_deleted`);

--
-- Indices de la tabla `pais`
--
ALTER TABLE `pais`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `plan_accion`
--
ALTER TABLE `plan_accion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_prio_plan` (`idprioridad`),
  ADD KEY `fk_alerta_plan` (`idalerta`),
  ADD KEY `fk_empresa_plan` (`idempresa`),
  ADD KEY `fk_area_plan` (`idarea`),
  ADD KEY `fk_unidad_plan` (`idunidades`),
  ADD KEY `fk_posicion_plan` (`idposicion_puesto`),
  ADD KEY `fk_usuario_plan` (`idusuario`),
  ADD KEY `FK__plan_acci__id_us__247D636F` (`id_user_updated`),
  ADD KEY `FK__plan_acci__id_us__257187A8` (`id_user_deleted`),
  ADD KEY `fk_estado_plan` (`idestado`);

--
-- Indices de la tabla `posicion_puesto`
--
ALTER TABLE `posicion_puesto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_posicion_puesto_unidades` (`idunidades`),
  ADD KEY `FK__posicion___id_us__2A363CC5` (`id_user_updated`),
  ADD KEY `FK__posicion___id_us__2B2A60FE` (`id_user_deleted`),
  ADD KEY `FK_posicion_puesto_area` (`idarea`),
  ADD KEY `FK_posicion_puesto_empresa` (`idempresa`);

--
-- Indices de la tabla `prioridad`
--
ALTER TABLE `prioridad`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__prioridad__id_us__2E06CDA9` (`id_user_deleted`),
  ADD KEY `FK__prioridad__id_us__2D12A970` (`id_user_updated`);

--
-- Indices de la tabla `probabilidad_riesgo`
--
ALTER TABLE `probabilidad_riesgo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__probailid__id_us__2FEF161B` (`id_user_updated`),
  ADD KEY `FK__probailid__id_us__30E33A54` (`id_user_deleted`);

--
-- Indices de la tabla `proceso`
--
ALTER TABLE `proceso`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_procesos_area` (`idarea`),
  ADD KEY `FK_procesos_empresa` (`idempresa`),
  ADD KEY `FK_procesos_macroprocesos` (`idmacroproceso`),
  ADD KEY `FK_procesos_unidades` (`idunidades`),
  ADD KEY `FK__procesos__id_use__32CB82C6` (`id_user_updated`),
  ADD KEY `FK__procesos__id_use__33BFA6FF` (`id_user_deleted`);

--
-- Indices de la tabla `registro_controles`
--
ALTER TABLE `registro_controles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__registro___id_us__5728DECD` (`id_user_added`),
  ADD KEY `FK__registro___id_us__581D0306` (`id_user_updated`),
  ADD KEY `FK__registro___id_us__5911273F` (`id_user_deleted`),
  ADD KEY `fk_cobertura_control` (`idCobertura`),
  ADD KEY `idevaluacion_control2` (`idevaluacion_control2`);

--
-- Indices de la tabla `sysdiagrams`
--
ALTER TABLE `sysdiagrams`
  ADD PRIMARY KEY (`diagram_id`),
  ADD UNIQUE KEY `UK_principal_name` (`principal_id`,`name`);

--
-- Indices de la tabla `tb_detalle_perfil`
--
ALTER TABLE `tb_detalle_perfil`
  ADD PRIMARY KEY (`id_det_per`);

--
-- Indices de la tabla `tb_historial_claves`
--
ALTER TABLE `tb_historial_claves`
  ADD PRIMARY KEY (`id_cl`);

--
-- Indices de la tabla `tb_item`
--
ALTER TABLE `tb_item`
  ADD PRIMARY KEY (`id_item`);

--
-- Indices de la tabla `tb_modulo`
--
ALTER TABLE `tb_modulo`
  ADD PRIMARY KEY (`id_mod`);

--
-- Indices de la tabla `tb_opcion`
--
ALTER TABLE `tb_opcion`
  ADD PRIMARY KEY (`id_op`),
  ADD KEY `fk_mod_op` (`id_mod`);

--
-- Indices de la tabla `tb_perfiles`
--
ALTER TABLE `tb_perfiles`
  ADD PRIMARY KEY (`id_perfil`);

--
-- Indices de la tabla `tb_sesiones`
--
ALTER TABLE `tb_sesiones`
  ADD PRIMARY KEY (`id_se`);

--
-- Indices de la tabla `tb_users`
--
ALTER TABLE `tb_users`
  ADD PRIMARY KEY (`id_us`),
  ADD KEY `fk_user_perfil` (`perfil_us`);

--
-- Indices de la tabla `tipo_activo`
--
ALTER TABLE `tipo_activo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__tipo_acti__id_us__43F60EC8` (`id_user_updated`),
  ADD KEY `FK__tipo_acti__id_us__44EA3301` (`id_user_deleted`);

--
-- Indices de la tabla `tipo_amenaza`
--
ALTER TABLE `tipo_amenaza`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__tipo_amen__id_us__46D27B73` (`id_user_updated`),
  ADD KEY `FK__tipo_amen__id_us__47C69FAC` (`id_user_deleted`);

--
-- Indices de la tabla `tipo_riesgo`
--
ALTER TABLE `tipo_riesgo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__tipo_ries__id_us__29971E47` (`id_user_added`),
  ADD KEY `FK__tipo_ries__id_us__2A8B4280` (`id_user_updated`),
  ADD KEY `FK__tipo_ries__id_us__2B7F66B9` (`id_user_deleted`);

--
-- Indices de la tabla `ubicacion_activo`
--
ALTER TABLE `ubicacion_activo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__ubicacion__id_us__49AEE81E` (`id_user_updated`),
  ADD KEY `FK__ubicacion__id_us__4AA30C57` (`id_user_deleted`);

--
-- Indices de la tabla `unidades`
--
ALTER TABLE `unidades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_unidades_area` (`idarea`),
  ADD KEY `FK_unidades_empresa` (`idempresa`),
  ADD KEY `FK__unidades__id_use__542C7691` (`id_user_updated`),
  ADD KEY `FK__unidades__id_use__55209ACA` (`id_user_deleted`);

--
-- Indices de la tabla `valoracion_activo`
--
ALTER TABLE `valoracion_activo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__valoracio__id_us__59E54FE7` (`id_user_updated`),
  ADD KEY `FK__valoracio__id_us__5AD97420` (`id_user_deleted`),
  ADD KEY `fk_user_valoracion` (`id_user_added`),
  ADD KEY `fk_valor_valoracion` (`idvalor`);

--
-- Indices de la tabla `valoracion_riesgo`
--
ALTER TABLE `valoracion_riesgo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__valoracio__id_us__058EC7FB` (`id_user_added`),
  ADD KEY `FK__valoracio__id_us__0682EC34` (`id_user_updated`),
  ADD KEY `FK__valoracio__id_us__0777106D` (`id_user_deleted`),
  ADD KEY `FK__valoracio__idImp__095F58DF` (`idimpacto_riesgo`),
  ADD KEY `FK__valoracio__idPro__086B34A6` (`idprobabilidad_riesgo`);

--
-- Indices de la tabla `valor_activo`
--
ALTER TABLE `valor_activo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK__valor_act__id_us__5708E33C` (`id_user_updated`),
  ADD KEY `FK__valor_act__id_us__57FD0775` (`id_user_deleted`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `actividades_plan`
--
ALTER TABLE `actividades_plan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `alert_seguimiento`
--
ALTER TABLE `alert_seguimiento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `aplicacion_impacto`
--
ALTER TABLE `aplicacion_impacto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `aplicacion_probailidad`
--
ALTER TABLE `aplicacion_probailidad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `area`
--
ALTER TABLE `area`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `aspectos_seguridad`
--
ALTER TABLE `aspectos_seguridad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `caracteristica_control`
--
ALTER TABLE `caracteristica_control`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT de la tabla `catalogo_tabla`
--
ALTER TABLE `catalogo_tabla`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `categoria_activo`
--
ALTER TABLE `categoria_activo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `categoria_vulnerabilidad`
--
ALTER TABLE `categoria_vulnerabilidad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `ciudad`
--
ALTER TABLE `ciudad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2204;

--
-- AUTO_INCREMENT de la tabla `clasificacion_informacion`
--
ALTER TABLE `clasificacion_informacion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `cobertura`
--
ALTER TABLE `cobertura`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `config_pass`
--
ALTER TABLE `config_pass`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `controles`
--
ALTER TABLE `controles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `correo_actividad`
--
ALTER TABLE `correo_actividad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `correo_plan`
--
ALTER TABLE `correo_plan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT de la tabla `datos_correo`
--
ALTER TABLE `datos_correo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `desc_amenaza`
--
ALTER TABLE `desc_amenaza`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `desc_vulnerabilidad`
--
ALTER TABLE `desc_vulnerabilidad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `detalle_controles`
--
ALTER TABLE `detalle_controles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=193;

--
-- AUTO_INCREMENT de la tabla `detalle_evaluacion_control`
--
ALTER TABLE `detalle_evaluacion_control`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT de la tabla `detalle_valoracion_activo`
--
ALTER TABLE `detalle_valoracion_activo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT de la tabla `empresa`
--
ALTER TABLE `empresa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `escenario_active`
--
ALTER TABLE `escenario_active`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `estado`
--
ALTER TABLE `estado`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `evaluacion_control2`
--
ALTER TABLE `evaluacion_control2`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `evaluacion_riesgo`
--
ALTER TABLE `evaluacion_riesgo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT de la tabla `evaluacion_riesgos_controles`
--
ALTER TABLE `evaluacion_riesgos_controles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT de la tabla `evaluacion_riesgo_historial`
--
ALTER TABLE `evaluacion_riesgo_historial`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT de la tabla `impacto_riesgo`
--
ALTER TABLE `impacto_riesgo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `inventario_clasificacion_activo`
--
ALTER TABLE `inventario_clasificacion_activo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT de la tabla `inventario_clasificacion_activo_historial`
--
ALTER TABLE `inventario_clasificacion_activo_historial`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `log_acciones`
--
ALTER TABLE `log_acciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=269;

--
-- AUTO_INCREMENT de la tabla `log_sistema`
--
ALTER TABLE `log_sistema`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=672;

--
-- AUTO_INCREMENT de la tabla `macroproceso`
--
ALTER TABLE `macroproceso`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `nivel_riesgo`
--
ALTER TABLE `nivel_riesgo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `pais`
--
ALTER TABLE `pais`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=247;

--
-- AUTO_INCREMENT de la tabla `plan_accion`
--
ALTER TABLE `plan_accion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `posicion_puesto`
--
ALTER TABLE `posicion_puesto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `prioridad`
--
ALTER TABLE `prioridad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `probabilidad_riesgo`
--
ALTER TABLE `probabilidad_riesgo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `proceso`
--
ALTER TABLE `proceso`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `registro_controles`
--
ALTER TABLE `registro_controles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `sysdiagrams`
--
ALTER TABLE `sysdiagrams`
  MODIFY `diagram_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tb_detalle_perfil`
--
ALTER TABLE `tb_detalle_perfil`
  MODIFY `id_det_per` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=586;

--
-- AUTO_INCREMENT de la tabla `tb_historial_claves`
--
ALTER TABLE `tb_historial_claves`
  MODIFY `id_cl` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de la tabla `tb_item`
--
ALTER TABLE `tb_item`
  MODIFY `id_item` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT de la tabla `tb_modulo`
--
ALTER TABLE `tb_modulo`
  MODIFY `id_mod` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tb_opcion`
--
ALTER TABLE `tb_opcion`
  MODIFY `id_op` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `tb_perfiles`
--
ALTER TABLE `tb_perfiles`
  MODIFY `id_perfil` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `tb_sesiones`
--
ALTER TABLE `tb_sesiones`
  MODIFY `id_se` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=164;

--
-- AUTO_INCREMENT de la tabla `tb_users`
--
ALTER TABLE `tb_users`
  MODIFY `id_us` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `tipo_activo`
--
ALTER TABLE `tipo_activo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tipo_amenaza`
--
ALTER TABLE `tipo_amenaza`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tipo_riesgo`
--
ALTER TABLE `tipo_riesgo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `ubicacion_activo`
--
ALTER TABLE `ubicacion_activo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `unidades`
--
ALTER TABLE `unidades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `valoracion_activo`
--
ALTER TABLE `valoracion_activo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `valoracion_riesgo`
--
ALTER TABLE `valoracion_riesgo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `valor_activo`
--
ALTER TABLE `valor_activo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `actividades_plan`
--
ALTER TABLE `actividades_plan`
  ADD CONSTRAINT `FK__actividad__id_us__51851410` FOREIGN KEY (`id_user_added`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__actividad__id_us__52793849` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__actividad__id_us__536D5C82` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `fk_alerta_act` FOREIGN KEY (`idalerta`) REFERENCES `alert_seguimiento` (`id`),
  ADD CONSTRAINT `fk_area_act` FOREIGN KEY (`idarea`) REFERENCES `area` (`id`),
  ADD CONSTRAINT `fk_empresa_act` FOREIGN KEY (`idempresa`) REFERENCES `empresa` (`id`),
  ADD CONSTRAINT `fk_posicion_act` FOREIGN KEY (`idposicion_puesto`) REFERENCES `posicion_puesto` (`id`),
  ADD CONSTRAINT `fk_unidad_act` FOREIGN KEY (`idunidades`) REFERENCES `unidades` (`id`),
  ADD CONSTRAINT `fk_usuario_act` FOREIGN KEY (`idusuario`) REFERENCES `tb_users` (`id_us`);

--
-- Filtros para la tabla `alert_seguimiento`
--
ALTER TABLE `alert_seguimiento`
  ADD CONSTRAINT `FK__alert_seg__id_us__5555A4F4` FOREIGN KEY (`id_user_added`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__alert_seg__id_us__5649C92D` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__alert_seg__id_us__573DED66` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`);

--
-- Filtros para la tabla `aplicacion_impacto`
--
ALTER TABLE `aplicacion_impacto`
  ADD CONSTRAINT `FK__aplicacio__id_us__592635D8` FOREIGN KEY (`id_user_added`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__aplicacio__id_us__5A1A5A11` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__aplicacio__id_us__5B0E7E4A` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`);

--
-- Filtros para la tabla `aplicacion_probailidad`
--
ALTER TABLE `aplicacion_probailidad`
  ADD CONSTRAINT `FK__aplicacio__id_us__5CF6C6BC` FOREIGN KEY (`id_user_added`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__aplicacio__id_us__5DEAEAF5` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__aplicacio__id_us__5EDF0F2E` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`);

--
-- Filtros para la tabla `area`
--
ALTER TABLE `area`
  ADD CONSTRAINT `FK__area__id_user_ad__60C757A0` FOREIGN KEY (`id_user_added`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__area__id_user_de__62AFA012` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__area__id_user_up__61BB7BD9` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK_area_empresa1` FOREIGN KEY (`idempresa`) REFERENCES `empresa` (`id`);

--
-- Filtros para la tabla `aspectos_seguridad`
--
ALTER TABLE `aspectos_seguridad`
  ADD CONSTRAINT `FK__aspectos___id_us__668030F6` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`);

--
-- Filtros para la tabla `caracteristica_control`
--
ALTER TABLE `caracteristica_control`
  ADD CONSTRAINT `FK__caracteri__id_us__4DB4832C` FOREIGN KEY (`id_user_added`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__caracteri__id_us__4EA8A765` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__caracteri__id_us__4F9CCB9E` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`);

--
-- Filtros para la tabla `categoria_activo`
--
ALTER TABLE `categoria_activo`
  ADD CONSTRAINT `FK__categoria__id_us__6E2152BE` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__categoria__id_us__6F1576F7` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK_categoria_activo_tipo_activo` FOREIGN KEY (`idtipo_activo`) REFERENCES `tipo_activo` (`id`);

--
-- Filtros para la tabla `categoria_vulnerabilidad`
--
ALTER TABLE `categoria_vulnerabilidad`
  ADD CONSTRAINT `FK__categoria__id_us__70FDBF69` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__categoria__id_us__71F1E3A2` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`);

--
-- Filtros para la tabla `clasificacion_informacion`
--
ALTER TABLE `clasificacion_informacion`
  ADD CONSTRAINT `FK__clasifica__id_us__7993056A` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__clasifica__id_us__7A8729A3` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`);

--
-- Filtros para la tabla `cobertura`
--
ALTER TABLE `cobertura`
  ADD CONSTRAINT `FK__cobertura__id_us__7D63964E` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`);

--
-- Filtros para la tabla `controles`
--
ALTER TABLE `controles`
  ADD CONSTRAINT `FK__controles__id_us__004002F9` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__controles__id_us__7F4BDEC0` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`);

--
-- Filtros para la tabla `desc_amenaza`
--
ALTER TABLE `desc_amenaza`
  ADD CONSTRAINT `FK__desc_amen__id_us__0504B816` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__desc_amen__id_us__05F8DC4F` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `fk_tipo_amenaza` FOREIGN KEY (`idtipo_amenaza`) REFERENCES `tipo_amenaza` (`id`);

--
-- Filtros para la tabla `desc_vulnerabilidad`
--
ALTER TABLE `desc_vulnerabilidad`
  ADD CONSTRAINT `FK__desc_vuln__id_us__07E124C1` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__desc_vuln__id_us__08D548FA` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `fk_vulne_cate` FOREIGN KEY (`idcategoria_vulnerabilidad`) REFERENCES `categoria_vulnerabilidad` (`id`);

--
-- Filtros para la tabla `detalle_controles`
--
ALTER TABLE `detalle_controles`
  ADD CONSTRAINT `detalle_controles_ibfk_1` FOREIGN KEY (`idcaracteristica_control`) REFERENCES `caracteristica_control` (`id`),
  ADD CONSTRAINT `detalle_controles_ibfk_2` FOREIGN KEY (`idcaracteristica_control`) REFERENCES `caracteristica_control` (`id`);

--
-- Filtros para la tabla `detalle_valoracion_activo`
--
ALTER TABLE `detalle_valoracion_activo`
  ADD CONSTRAINT `detalle_valoracion_activo_ibfk_1` FOREIGN KEY (`idaspectos_seguridad`) REFERENCES `aspectos_seguridad` (`id`);

--
-- Filtros para la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD CONSTRAINT `FK__empresa__id_user__0D99FE17` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__empresa__id_user__0E8E2250` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`);

--
-- Filtros para la tabla `evaluacion_control2`
--
ALTER TABLE `evaluacion_control2`
  ADD CONSTRAINT `FK__evaluacio__id_us__5ECA0095` FOREIGN KEY (`id_user_added`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__evaluacio__id_us__5FBE24CE` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__evaluacio__id_us__60B24907` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`);

--
-- Filtros para la tabla `evaluacion_riesgo`
--
ALTER TABLE `evaluacion_riesgo`
  ADD CONSTRAINT `FK__evaluacio__id_ar__4B8221F7` FOREIGN KEY (`idarea`) REFERENCES `area` (`id`),
  ADD CONSTRAINT `FK__evaluacio__id_de__5046D714` FOREIGN KEY (`id_descripcion_amenaza`) REFERENCES `desc_amenaza` (`id`),
  ADD CONSTRAINT `FK__evaluacio__id_em__4A8DFDBE` FOREIGN KEY (`idempresa`) REFERENCES `empresa` (`id`),
  ADD CONSTRAINT `FK__evaluacio__id_ma__4D6A6A69` FOREIGN KEY (`idmacroproceso`) REFERENCES `macroproceso` (`id`),
  ADD CONSTRAINT `FK__evaluacio__id_pr__4E5E8EA2` FOREIGN KEY (`idproceso`) REFERENCES `proceso` (`id`),
  ADD CONSTRAINT `FK__evaluacio__id_ti__4999D985` FOREIGN KEY (`id_tipo_riesgo`) REFERENCES `tipo_riesgo` (`id`),
  ADD CONSTRAINT `FK__evaluacio__id_ti__4F52B2DB` FOREIGN KEY (`id_tipo_amenaza`) REFERENCES `tipo_amenaza` (`id`),
  ADD CONSTRAINT `FK__evaluacio__id_un__4C764630` FOREIGN KEY (`idunidades`) REFERENCES `unidades` (`id`),
  ADD CONSTRAINT `FK__evaluacio__id_us__46BD6CDA` FOREIGN KEY (`id_user_added`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__evaluacio__id_us__47B19113` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__evaluacio__id_us__48A5B54C` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `evaluacion_riesgo_ibfk_1` FOREIGN KEY (`idprobabilidad_riesgo`) REFERENCES `probabilidad_riesgo` (`id`),
  ADD CONSTRAINT `evaluacion_riesgo_ibfk_2` FOREIGN KEY (`idimpacto_riesgo`) REFERENCES `impacto_riesgo` (`id`),
  ADD CONSTRAINT `evaluacion_riesgo_ibfk_3` FOREIGN KEY (`idnivel_riesgo`) REFERENCES `nivel_riesgo` (`id`),
  ADD CONSTRAINT `evaluacion_riesgo_ibfk_4` FOREIGN KEY (`idvaloracion_riesgo`) REFERENCES `valoracion_riesgo` (`id`),
  ADD CONSTRAINT `evaluacion_riesgo_ibfk_5` FOREIGN KEY (`idprobabilidad_riesgo`) REFERENCES `probabilidad_riesgo` (`id`),
  ADD CONSTRAINT `evaluacion_riesgo_ibfk_6` FOREIGN KEY (`idimpacto_riesgo`) REFERENCES `impacto_riesgo` (`id`),
  ADD CONSTRAINT `evaluacion_riesgo_ibfk_7` FOREIGN KEY (`idnivel_riesgo`) REFERENCES `nivel_riesgo` (`id`),
  ADD CONSTRAINT `evaluacion_riesgo_ibfk_8` FOREIGN KEY (`idvaloracion_riesgo`) REFERENCES `valoracion_riesgo` (`id`),
  ADD CONSTRAINT `evaluacion_riesgo_ibfk_9` FOREIGN KEY (`idinventario_clasificacion_activo`) REFERENCES `inventario_clasificacion_activo` (`id`);

--
-- Filtros para la tabla `evaluacion_riesgos_controles`
--
ALTER TABLE `evaluacion_riesgos_controles`
  ADD CONSTRAINT `evaluacion_riesgos_controles_ibfk_1` FOREIGN KEY (`idregistro_controles`) REFERENCES `registro_controles` (`id`),
  ADD CONSTRAINT `evaluacion_riesgos_controles_ibfk_2` FOREIGN KEY (`idevaluacion_riesgo`) REFERENCES `evaluacion_riesgo` (`id`);

--
-- Filtros para la tabla `evaluacion_riesgo_historial`
--
ALTER TABLE `evaluacion_riesgo_historial`
  ADD CONSTRAINT `FK__evaluacio__id_ar__59D0414E` FOREIGN KEY (`idarea`) REFERENCES `area` (`id`),
  ADD CONSTRAINT `FK__evaluacio__id_de__5E94F66B` FOREIGN KEY (`id_descripcion_amenaza`) REFERENCES `desc_amenaza` (`id`),
  ADD CONSTRAINT `FK__evaluacio__id_em__58DC1D15` FOREIGN KEY (`idempresa`) REFERENCES `empresa` (`id`),
  ADD CONSTRAINT `FK__evaluacio__id_ma__5BB889C0` FOREIGN KEY (`idmacroproceso`) REFERENCES `macroproceso` (`id`),
  ADD CONSTRAINT `FK__evaluacio__id_pr__5CACADF9` FOREIGN KEY (`idproceso`) REFERENCES `proceso` (`id`),
  ADD CONSTRAINT `FK__evaluacio__id_ti__57E7F8DC` FOREIGN KEY (`id_tipo_riesgo`) REFERENCES `tipo_riesgo` (`id`),
  ADD CONSTRAINT `FK__evaluacio__id_ti__5DA0D232` FOREIGN KEY (`id_tipo_amenaza`) REFERENCES `tipo_amenaza` (`id`),
  ADD CONSTRAINT `FK__evaluacio__id_un__5AC46587` FOREIGN KEY (`idunidades`) REFERENCES `unidades` (`id`),
  ADD CONSTRAINT `FK__evaluacio__id_us__550B8C31` FOREIGN KEY (`id_user_added`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__evaluacio__id_us__55FFB06A` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__evaluacio__id_us__56F3D4A3` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`);

--
-- Filtros para la tabla `impacto_riesgo`
--
ALTER TABLE `impacto_riesgo`
  ADD CONSTRAINT `FK__impacto_r__id_us__1352D76D` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__impacto_r__id_us__1446FBA6` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`);

--
-- Filtros para la tabla `inventario_clasificacion_activo`
--
ALTER TABLE `inventario_clasificacion_activo`
  ADD CONSTRAINT `FK__inventari__id_us__6AFACD50` FOREIGN KEY (`id_user_added`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__inventari__id_us__6BEEF189` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__inventari__id_us__6CE315C2` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__inventari__idare__6359AB88` FOREIGN KEY (`idarea`) REFERENCES `area` (`id`),
  ADD CONSTRAINT `FK__inventari__idcat__681E60A5` FOREIGN KEY (`idcategoria_activo`) REFERENCES `categoria_activo` (`id`),
  ADD CONSTRAINT `FK__inventari__idemp__6265874F` FOREIGN KEY (`idempresa`) REFERENCES `empresa` (`id`),
  ADD CONSTRAINT `FK__inventari__idmac__6541F3FA` FOREIGN KEY (`idmacroproceso`) REFERENCES `macroproceso` (`id`),
  ADD CONSTRAINT `FK__inventari__idpro__66361833` FOREIGN KEY (`idproceso`) REFERENCES `proceso` (`id`),
  ADD CONSTRAINT `FK__inventari__idtip__672A3C6C` FOREIGN KEY (`idtipo_activo`) REFERENCES `tipo_activo` (`id`),
  ADD CONSTRAINT `FK__inventari__idubi__691284DE` FOREIGN KEY (`idubicacion`) REFERENCES `ubicacion_activo` (`id`),
  ADD CONSTRAINT `FK__inventari__iduni__644DCFC1` FOREIGN KEY (`idunidades`) REFERENCES `unidades` (`id`),
  ADD CONSTRAINT `FK__inventari__idval__6A06A917` FOREIGN KEY (`idvalor`) REFERENCES `valor_activo` (`id`),
  ADD CONSTRAINT `fk_inventario_valoracion` FOREIGN KEY (`idvaloracion_activo`) REFERENCES `valoracion_activo` (`id`),
  ADD CONSTRAINT `inventario_clasificacion_activo_ibfk_1` FOREIGN KEY (`idclasificacion_informacion`) REFERENCES `clasificacion_informacion` (`id`);

--
-- Filtros para la tabla `inventario_clasificacion_activo_historial`
--
ALTER TABLE `inventario_clasificacion_activo_historial`
  ADD CONSTRAINT `FK__inventari__id_us__02D256E1` FOREIGN KEY (`id_user_added`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__inventari__id_us__03C67B1A` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__inventari__id_us__04BA9F53` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__inventari__idare__7B313519` FOREIGN KEY (`idarea`) REFERENCES `area` (`id`),
  ADD CONSTRAINT `FK__inventari__idcat__7FF5EA36` FOREIGN KEY (`idcategoria_activo`) REFERENCES `categoria_activo` (`id`),
  ADD CONSTRAINT `FK__inventari__idemp__7A3D10E0` FOREIGN KEY (`idempresa`) REFERENCES `empresa` (`id`),
  ADD CONSTRAINT `FK__inventari__idmac__7D197D8B` FOREIGN KEY (`idmacroproceso`) REFERENCES `macroproceso` (`id`),
  ADD CONSTRAINT `FK__inventari__idpro__7E0DA1C4` FOREIGN KEY (`idproceso`) REFERENCES `proceso` (`id`),
  ADD CONSTRAINT `FK__inventari__idtip__7F01C5FD` FOREIGN KEY (`idtipo_activo`) REFERENCES `tipo_activo` (`id`),
  ADD CONSTRAINT `FK__inventari__idubi__00EA0E6F` FOREIGN KEY (`idubicacion`) REFERENCES `ubicacion_activo` (`id`),
  ADD CONSTRAINT `FK__inventari__iduni__7C255952` FOREIGN KEY (`idunidades`) REFERENCES `unidades` (`id`),
  ADD CONSTRAINT `FK__inventari__idval__01DE32A8` FOREIGN KEY (`idvalor`) REFERENCES `valor_activo` (`id`),
  ADD CONSTRAINT `inventario_clasificacion_activo_historial_ibfk_1` FOREIGN KEY (`idclasificacion_informacion`) REFERENCES `clasificacion_informacion` (`id`);

--
-- Filtros para la tabla `macroproceso`
--
ALTER TABLE `macroproceso`
  ADD CONSTRAINT `FK__macroproc__id_us__190BB0C3` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__macroproc__id_us__19FFD4FC` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK_macroprocesos_area` FOREIGN KEY (`idarea`) REFERENCES `area` (`id`),
  ADD CONSTRAINT `FK_macroprocesos_empresa` FOREIGN KEY (`idempresa`) REFERENCES `empresa` (`id`),
  ADD CONSTRAINT `FK_macroprocesos_unidades` FOREIGN KEY (`idunidades`) REFERENCES `unidades` (`id`);

--
-- Filtros para la tabla `nivel_riesgo`
--
ALTER TABLE `nivel_riesgo`
  ADD CONSTRAINT `FK__nivel_rie__id_us__50B0EB68` FOREIGN KEY (`id_user_added`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__nivel_rie__id_us__51A50FA1` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__nivel_rie__id_us__529933DA` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`);

--
-- Filtros para la tabla `plan_accion`
--
ALTER TABLE `plan_accion`
  ADD CONSTRAINT `FK__plan_acci__id_us__247D636F` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__plan_acci__id_us__257187A8` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `fk_alerta_plan` FOREIGN KEY (`idalerta`) REFERENCES `alert_seguimiento` (`id`),
  ADD CONSTRAINT `fk_area_plan` FOREIGN KEY (`idarea`) REFERENCES `area` (`id`),
  ADD CONSTRAINT `fk_empresa_plan` FOREIGN KEY (`idempresa`) REFERENCES `empresa` (`id`),
  ADD CONSTRAINT `fk_estado_plan` FOREIGN KEY (`idestado`) REFERENCES `estado` (`id`),
  ADD CONSTRAINT `fk_posicion_plan` FOREIGN KEY (`idposicion_puesto`) REFERENCES `posicion_puesto` (`id`),
  ADD CONSTRAINT `fk_prio_plan` FOREIGN KEY (`idprioridad`) REFERENCES `prioridad` (`id`),
  ADD CONSTRAINT `fk_unidad_plan` FOREIGN KEY (`idunidades`) REFERENCES `unidades` (`id`),
  ADD CONSTRAINT `fk_usuario_plan` FOREIGN KEY (`idusuario`) REFERENCES `tb_users` (`id_us`);

--
-- Filtros para la tabla `posicion_puesto`
--
ALTER TABLE `posicion_puesto`
  ADD CONSTRAINT `FK__posicion___id_us__2A363CC5` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__posicion___id_us__2B2A60FE` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK_posicion_puesto_area` FOREIGN KEY (`idarea`) REFERENCES `area` (`id`),
  ADD CONSTRAINT `FK_posicion_puesto_empresa` FOREIGN KEY (`idempresa`) REFERENCES `empresa` (`id`),
  ADD CONSTRAINT `FK_posicion_puesto_unidades` FOREIGN KEY (`idunidades`) REFERENCES `unidades` (`id`);

--
-- Filtros para la tabla `prioridad`
--
ALTER TABLE `prioridad`
  ADD CONSTRAINT `FK__prioridad__id_us__2D12A970` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__prioridad__id_us__2E06CDA9` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`);

--
-- Filtros para la tabla `probabilidad_riesgo`
--
ALTER TABLE `probabilidad_riesgo`
  ADD CONSTRAINT `FK__probailid__id_us__2FEF161B` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__probailid__id_us__30E33A54` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`);

--
-- Filtros para la tabla `proceso`
--
ALTER TABLE `proceso`
  ADD CONSTRAINT `FK__procesos__id_use__32CB82C6` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__procesos__id_use__33BFA6FF` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK_procesos_area` FOREIGN KEY (`idarea`) REFERENCES `area` (`id`),
  ADD CONSTRAINT `FK_procesos_empresa` FOREIGN KEY (`idempresa`) REFERENCES `empresa` (`id`),
  ADD CONSTRAINT `FK_procesos_macroprocesos` FOREIGN KEY (`idmacroproceso`) REFERENCES `macroproceso` (`id`),
  ADD CONSTRAINT `FK_procesos_unidades` FOREIGN KEY (`idunidades`) REFERENCES `unidades` (`id`);

--
-- Filtros para la tabla `registro_controles`
--
ALTER TABLE `registro_controles`
  ADD CONSTRAINT `FK__registro___id_us__5728DECD` FOREIGN KEY (`id_user_added`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__registro___id_us__581D0306` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__registro___id_us__5911273F` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `registro_controles_ibfk_1` FOREIGN KEY (`idCobertura`) REFERENCES `cobertura` (`id`),
  ADD CONSTRAINT `registro_controles_ibfk_2` FOREIGN KEY (`idevaluacion_control2`) REFERENCES `evaluacion_control2` (`id`);

--
-- Filtros para la tabla `tb_opcion`
--
ALTER TABLE `tb_opcion`
  ADD CONSTRAINT `fk_mod_op` FOREIGN KEY (`id_mod`) REFERENCES `tb_modulo` (`id_mod`);

--
-- Filtros para la tabla `tb_users`
--
ALTER TABLE `tb_users`
  ADD CONSTRAINT `fk_user_perfil` FOREIGN KEY (`perfil_us`) REFERENCES `tb_perfiles` (`id_perfil`);

--
-- Filtros para la tabla `tipo_activo`
--
ALTER TABLE `tipo_activo`
  ADD CONSTRAINT `FK__tipo_acti__id_us__43F60EC8` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__tipo_acti__id_us__44EA3301` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`);

--
-- Filtros para la tabla `tipo_amenaza`
--
ALTER TABLE `tipo_amenaza`
  ADD CONSTRAINT `FK__tipo_amen__id_us__46D27B73` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__tipo_amen__id_us__47C69FAC` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`);

--
-- Filtros para la tabla `tipo_riesgo`
--
ALTER TABLE `tipo_riesgo`
  ADD CONSTRAINT `FK__tipo_ries__id_us__29971E47` FOREIGN KEY (`id_user_added`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__tipo_ries__id_us__2A8B4280` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__tipo_ries__id_us__2B7F66B9` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`);

--
-- Filtros para la tabla `ubicacion_activo`
--
ALTER TABLE `ubicacion_activo`
  ADD CONSTRAINT `FK__ubicacion__id_us__49AEE81E` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__ubicacion__id_us__4AA30C57` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`);

--
-- Filtros para la tabla `unidades`
--
ALTER TABLE `unidades`
  ADD CONSTRAINT `FK__unidades__id_use__542C7691` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__unidades__id_use__55209ACA` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK_unidades_area` FOREIGN KEY (`idarea`) REFERENCES `area` (`id`),
  ADD CONSTRAINT `FK_unidades_empresa` FOREIGN KEY (`idempresa`) REFERENCES `empresa` (`id`);

--
-- Filtros para la tabla `valoracion_activo`
--
ALTER TABLE `valoracion_activo`
  ADD CONSTRAINT `FK__valoracio__id_us__59E54FE7` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__valoracio__id_us__5AD97420` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `fk_user_valoracion` FOREIGN KEY (`id_user_added`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `fk_valor_valoracion` FOREIGN KEY (`idvalor`) REFERENCES `valor_activo` (`id`);

--
-- Filtros para la tabla `valoracion_riesgo`
--
ALTER TABLE `valoracion_riesgo`
  ADD CONSTRAINT `FK__valoracio__idImp__095F58DF` FOREIGN KEY (`idimpacto_riesgo`) REFERENCES `impacto_riesgo` (`id`),
  ADD CONSTRAINT `FK__valoracio__idPro__086B34A6` FOREIGN KEY (`idprobabilidad_riesgo`) REFERENCES `probabilidad_riesgo` (`id`),
  ADD CONSTRAINT `FK__valoracio__id_us__058EC7FB` FOREIGN KEY (`id_user_added`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__valoracio__id_us__0682EC34` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__valoracio__id_us__0777106D` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`);

--
-- Filtros para la tabla `valor_activo`
--
ALTER TABLE `valor_activo`
  ADD CONSTRAINT `FK__valor_act__id_us__5708E33C` FOREIGN KEY (`id_user_updated`) REFERENCES `tb_users` (`id_us`),
  ADD CONSTRAINT `FK__valor_act__id_us__57FD0775` FOREIGN KEY (`id_user_deleted`) REFERENCES `tb_users` (`id_us`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
