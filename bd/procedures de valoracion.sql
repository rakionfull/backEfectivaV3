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
	select dva.id as id,ass.id as id_aspecto,ass.aspecto as aspecto,dva.idvaloracion_activo as id_valoracion_activo,dva.valoracion as valoracion
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