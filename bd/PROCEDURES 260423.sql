select * from detalle_valoracion_activo;
select * from inventario_clasificacion_activo;
select * from valor_activo;
select * from evaluacion_riesgo;
select * from evaluacion_riesgos_controles;
/*MODIFICAR*/
delimiter $
create procedure sp_delete_evaluacion_riesgo_controles(in id_evaluacion_riesgo_param int)
begin
	update evaluacion_riesgos_controles set is_deleted='1' where id_evaluacion_riesgo = id_evaluacion_riesgo_param;
end $
delimiter ;
CREATE PROCEDURE `sp_get_detalle_valoracion_activo`(IN `idaspecto_param` VARCHAR(50))
begin
	select distinct ass.id as id_aspecto,ass.aspecto as aspecto,dva.valoracion as valoracion
	from detalle_valoracion_activo dva
	inner join aspectos_seguridad ass on ass.id=dva.idaspectos_seguridad
	where dva.is_deleted = 0 and ass.id=idaspecto_param;
end