ALTER TABLE evaluacion_riesgo add column idprobabilidad_riesgo int;
alter table evaluacion_riesgo add foreign key(idprobabilidad_riesgo) references probabilidad_riesgo(id);

ALTER TABLE evaluacion_riesgo add column idimpacto_riesgo int;
alter table evaluacion_riesgo add foreign key(idimpacto_riesgo) references impacto_riesgo(id);

ALTER TABLE evaluacion_riesgo add column idnivel_riesgo int;
alter table evaluacion_riesgo add foreign key(idnivel_riesgo) references nivel_riesgo(id);

ALTER TABLE evaluacion_riesgo add column idvaloracion_riesgo int;
alter table evaluacion_riesgo add foreign key(idvaloracion_riesgo) references valoracion_riesgo(id);

delimiter $
CREATE PROCEDURE `sp_add_evaluacion_riesgo_nivel`(IN `id_tipo_riesgo` INT, IN `id_empresa` INT, IN `id_area` INT, IN `id_unidad` INT, IN `id_macroproceso` INT, IN `id_proceso` INT, IN `id_activo` INT, IN `id_tipo_amenaza` INT, IN `id_descripcion_amenaza` INT, IN `id_tipo_vulnerabilidad` INT, IN `id_descripcion_vulnerabilidad` INT, IN `riesgo` VARCHAR(150), IN `valor_probabilidad` INT, IN `probabilidad` VARCHAR(150), IN `valor_impacto` VARCHAR(150), IN `impacto` VARCHAR(150), IN `valor` VARCHAR(150), IN `id_control` INT, IN `riesgo_controlado_probabilidad` VARCHAR(150), IN `riesgo_controlado_impacto` VARCHAR(150), IN `riesgo_controlado_valor` VARCHAR(150), IN `estado` INT, IN `id_user_added` INT, IN `date_add` DATETIME,IN id_probabilidad_param int,in id_impacto_param int,IN id_nivel_riesgo_param int)
BEGIN
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
    idnivel_riesgo
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
        id_nivel_riesgo_param
	);
END $
delimiter ;

delimiter $
CREATE PROCEDURE `sp_add_evaluacion_riesgo_valoracion`(IN `id_tipo_riesgo` INT, IN `id_empresa` INT, IN `id_area` INT, IN `id_unidad` INT, IN `id_macroproceso` INT, IN `id_proceso` INT, IN `id_activo` INT, IN `id_tipo_amenaza` INT, IN `id_descripcion_amenaza` INT, IN `id_tipo_vulnerabilidad` INT, IN `id_descripcion_vulnerabilidad` INT, IN `riesgo` VARCHAR(150), IN `valor_probabilidad` INT, IN `probabilidad` VARCHAR(150), IN `valor_impacto` VARCHAR(150), IN `impacto` VARCHAR(150), IN `valor` VARCHAR(150), IN `id_control` INT, IN `riesgo_controlado_probabilidad` VARCHAR(150), IN `riesgo_controlado_impacto` VARCHAR(150), IN `riesgo_controlado_valor` VARCHAR(150), IN `estado` INT, IN `id_user_added` INT, IN `date_add` DATETIME,IN id_probabilidad_param int,in id_impacto_param int,IN id_valoracion_riesgo_param int)
BEGIN
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
    idvaloracion_riesgo
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
        id_valoracion_riesgo_param
	);
END $
delimiter ;

delimiter $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_evaluacion_riesgo_nivel`(IN `idid` INT, IN `idid_tipo_riesgo` INT, IN `idid_empresa` INT, IN `idid_area` INT, IN `idid_unidad` INT, IN `idid_macroproceso` INT, IN `idid_proceso` INT, IN `idid_activo` INT, IN `idid_tipo_amenaza` INT, IN `idid_descripcion_amenaza` INT, IN `idid_tipo_vulnerabilidad` INT, IN `idid_descripcion_vulnerabilidad` INT, IN `idriesgo` VARCHAR(150), IN `idvalor_probabilidad` INT, IN `idprobabilidad` VARCHAR(150), IN `idvalor_impacto` VARCHAR(150), IN `idimpacto` VARCHAR(150), IN `idvalor` VARCHAR(150), IN `idid_control` INT, IN `idriesgo_controlado_probabilidad` VARCHAR(150), IN `idriesgo_controlado_impacto` VARCHAR(150), IN `idriesgo_controlado_valor` VARCHAR(150), IN `idestado` INT, IN `idid_user_updated` INT, IN `iddate_modify` DATETIME,in id_probabilidad_param int, in id_impacto_param int,IN id_nivel_riesgo_param int)
BEGIN
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
	date_modify=iddate_modify,
    idprobabilidad_riesgo=id_probabilidad_param,
    idimpacto_riesgo=id_impacto_param,
    idnivel_riesgo=id_nivel_riesgo_param
	WHERE id=idid;
END $
delimiter ;

delimiter $
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_evaluacion_riesgo_valoracion`(IN `idid` INT, IN `idid_tipo_riesgo` INT, IN `idid_empresa` INT, IN `idid_area` INT, IN `idid_unidad` INT, IN `idid_macroproceso` INT, IN `idid_proceso` INT, IN `idid_activo` INT, IN `idid_tipo_amenaza` INT, IN `idid_descripcion_amenaza` INT, IN `idid_tipo_vulnerabilidad` INT, IN `idid_descripcion_vulnerabilidad` INT, IN `idriesgo` VARCHAR(150), IN `idvalor_probabilidad` INT, IN `idprobabilidad` VARCHAR(150), IN `idvalor_impacto` VARCHAR(150), IN `idimpacto` VARCHAR(150), IN `idvalor` VARCHAR(150), IN `idid_control` INT, IN `idriesgo_controlado_probabilidad` VARCHAR(150), IN `idriesgo_controlado_impacto` VARCHAR(150), IN `idriesgo_controlado_valor` VARCHAR(150), IN `idestado` INT, IN `idid_user_updated` INT, IN `iddate_modify` DATETIME,in id_probabilidad_param int, in id_impacto_param int,IN id_valoracion_riesgo_param int)
BEGIN
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
	date_modify=iddate_modify,
    idprobabilidad_riesgo=id_probabilidad_param,
    idimpacto_riesgo=id_impacto_param,
    idvaloracion_riesgo=id_valoracion_riesgo_param
	WHERE id=idid;
END $
delimiter ;