/*Agregar*/
delimiter $
create procedure sp_get_unidades_by_empresa_by_area(in idempresa_param int, in idarea_param int)
begin
	SELECT U.id,U.unidad,E.empresa,A.area,U.estado,U.idempresa,U.idarea
	FROM unidades AS U 
    INNER JOIN empresa AS E ON U.idempresa = E.id
	INNER JOIN area AS A ON U.idarea = A.id AND U.is_deleted=0
    where U.idempresa=idempresa_param and U.idarea=idarea_param;
end $
delimiter ;

alter table inventario_clasificacion_activo add column idvaloracion_activo int;
alter table inventario_clasificacion_activo add constraint foreign key fk_inventario_valoracion(idvaloracion_activo) references valoracion_activo(id);

/*MODIFICAR*/
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_add_inventario_clasificacion_activo`(IN `idempresa` INT, IN `idarea` INT, IN `idunidad` INT, IN `idmacroproceso` INT, IN `idproceso` INT, IN `activo` VARCHAR(150), IN `desc_activo` VARCHAR(500), IN `idtipo_activo` INT, IN `idcategoria_activo` INT, IN `idubicacion` INT, IN `idpropietario` INT, IN `idcustodio` INT, IN `idvalor` INT, IN `estado` INT, IN `comentario` VARCHAR(500), IN `id_user_added` INT, IN `date_add` DATETIME, IN `estado_2_param` INT, IN `vals_param` TEXT,IN idvaloracion_activo_param int)
BEGIN
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
    idvaloracion_activo
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
        idvaloracion_activo_param
	);
END


CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_edit_inventario_clasificacion_activo`(IN `idid` INT, IN `idempresa` INT, IN `idarea` INT, IN `idunidad` INT, IN `idmacroproceso` INT, IN `idproceso` INT, IN `activo` VARCHAR(150), IN `desc_activo` VARCHAR(500), IN `idtipo_activo` INT, IN `idcategoria_activo` INT, IN `idubicacion` INT, IN `idpropietario` INT, IN `idcustodio` INT, IN `idvalor` INT, IN `estado` INT, IN `comentario` VARCHAR(500), IN `id_user_updated` INT, IN `date_modify` DATETIME, IN `observacion` VARCHAR(200), IN `estado_2_param` INT, IN `vals_param` TEXT, IN idvaloracion_activo_param INT)
BEGIN
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
    idvaloracion_activo=idvaloracion_activo_param
    where id=idid;
END