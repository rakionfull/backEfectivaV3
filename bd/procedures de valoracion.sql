delimiter $
CREATE PROCEDURE `sp_get_all_detalle_valoracion_activo`()
begin
	select dva.id as id,ass.id as id_aspecto,ass.aspecto as aspecto,dva.idvaloracion_activo as id_valoracion_activo,dva.valoracion as valoracion
	from detalle_valoracion_activo dva
	inner join aspectos_seguridad ass on ass.id=dva.idaspectos_seguridad
	where dva.is_deleted = 0;
end $
delimiter ;

delimiter $
CREATE PROCEDURE `sp_get_detalle_valoracion_activo`(in aspecto_param varchar(50))
begin
	select distinct ass.id as id_aspecto,ass.aspecto as aspecto,dva.valoracion as valoracion
	from detalle_valoracion_activo dva
	inner join aspectos_seguridad ass on ass.id=dva.idaspectos_seguridad
	where dva.is_deleted = 0 and ass.aspecto=aspecto_param;
end $
delimiter ;


delimiter $
create procedure sp_get_valoracion_activo_by_id(in id_param int)
begin
	select valoracion_activo.id,valoracion_activo.idvalor,valor_activo.valor from valoracion_activo inner join valor_activo on valor_activo.id=valoracion_activo.idvalor where valoracion_activo.id=id_param and valoracion_activo.is_deleted =0;
end $
delimiter ;

delimiter $
create procedure sp_get_detalle_perfil_to_reporte()
begin
	(SELECT tp.perfil,tp.desc_perfil,tp.creacion_perfil,tp.est_perfil,TI.desc_item,DP.view_det,DP.create_det,DP.update_det,DP.delete_det
	FROM tb_detalle_perfil as DP 
	inner join tb_perfiles tp on tp.id_perfil=DP.id_perfil
	inner join tb_item as TI on DP.id=TI.id_item where DP.tabla='tb_item' and DP.is_deleted=0 order by TI.id_op,TI.id_item ASC 
    )
    union all 
    (
		SELECT tp.perfil,tp.desc_perfil,tp.creacion_perfil,tp.est_perfil,TM.desc_mod as desc_item,DP.view_det,DP.create_det,DP.update_det,DP.delete_det
        FROM tb_detalle_perfil as DP
        inner join tb_perfiles tp on tp.id_perfil=DP.id_perfil
        inner join tb_modulo as TM on DP.id=TM.id_mod 
		where DP.tabla='tb_modulo' and DP.is_deleted=0 and TP.is_deleted=0
    )
    union all
    (
		SELECT tp.perfil,tp.desc_perfil,tp.creacion_perfil,tp.est_perfil,T.desc_op as desc_item,DP.view_det,DP.create_det,DP.update_det,DP.delete_det
        from tb_detalle_perfil as DP
		inner join tb_perfiles tp on tp.id_perfil=DP.id_perfil
        inner join tb_opcion as T on DP.id=T.id_op 
        where DP.tabla='tb_opcion' and DP.is_deleted=0
    );
end $
delimiter ;

/*Modificar*/
CREATE PROCEDURE `sp_list_desc_amenaza`()
BEGIN
	select da.id as id,ta.id as id_tipo_amenaza,ta.tipo as tipo_amenaza,da.amenaza as amenaza from desc_amenaza as da inner join tipo_amenaza as ta on da.idtipo_amenaza = ta.id WHERE da.is_deleted=0;
END


CREATE DEFINER=`root`@`localhost` PROCEDURE `getDetalleEvaluacionActivo`(IN `idid` INT)
begin
select * from detalle_valoracion_activo as DVA
inner join aspectos_seguridad as ass on ass.id=DVA.idaspectos_seguridad
inner join valoracion_activo as VA on DVA.idvaloracion_activo=va.id
WHERE VA.id=idid and DVA.is_deleted=0 and ass.is_deleted=0 and ass.estado=1;
end


CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_add_inventario_clasificacion_activo`(IN `idempresa` INT, IN `idarea` INT, IN `idunidad` INT, IN `idmacroproceso` INT, IN `idproceso` INT, IN `activo` VARCHAR(150), IN `desc_activo` VARCHAR(500), IN `idtipo_activo` INT, IN `idcategoria_activo` INT, IN `idubicacion` INT, IN `idpropietario` INT, IN `idcustodio` INT, IN `idvalor` INT, IN `estado` INT, IN `comentario` VARCHAR(500), IN `id_user_added` INT, IN `date_add` DATETIME, IN `estado_2_param` INT, in vals_param text)
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
    vals
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
        vals_param
	);
END


CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_edit_inventario_clasificacion_activo`(IN `idid` INT, IN `idempresa` INT, IN `idarea` INT, IN `idunidad` INT, IN `idmacroproceso` INT, IN `idproceso` INT, IN `activo` VARCHAR(150), IN `desc_activo` VARCHAR(500), IN `idtipo_activo` INT, IN `idcategoria_activo` INT, IN `idubicacion` INT, IN `idpropietario` INT, IN `idcustodio` INT, IN `idvalor` INT, IN `estado` INT, IN `comentario` VARCHAR(500), IN `id_user_updated` INT, IN `date_modify` DATETIME, IN `observacion` VARCHAR(200), IN `estado_2_param` INT,IN vals_param text)
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
    vals=vals_param
    where id=idid;
END


CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_list_inventario_clasificacion_activo`(IN `empresa` INT)
BEGIN
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
	va.valor AS valor
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
	WHERE ica.is_deleted=0 AND e.id=empresa;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_list_inventario_clasificacion_activo_by_user`(IN `id_user` INT, IN `empresa` INT)
BEGIN
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
	va.valor AS valor
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
	WHERE ica.is_deleted=0 AND ica.id_user_added=id_user AND e.id=empresa
;
END
