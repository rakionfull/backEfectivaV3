
delimiter $
create procedure sp_get_valoracion_by_probabilidad_impacto(in probabilidad_param varchar(100),in impacto_param varchar(100))
begin
	select vr.id,vr.idprobabilidad_riesgo as idprobabilidad_riesgo,pr.descripcion as probabilidad, vr.idimpacto_riesgo as idimpacto_riesgo,ir.descripcion as impacto
	from valoracion_riesgo as vr
	inner join probabilidad_riesgo pr on pr.id=vr.idprobabilidad_riesgo
	inner join impacto_riesgo ir on ir.id=vr.idimpacto_riesgo
	where vr.is_deleted = 0 and pr.descripcion=probabilidad_param and ir.descripcion=impacto_param;
end $
delimiter ;