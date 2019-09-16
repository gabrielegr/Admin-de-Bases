--00199518
--Gabriel Enrique Gonzalez Rodriguez
--Consulta 1
SELECT m.nombre,m.dui,s.nombre as superpachanga,s.anyo as año from miembro m,asiste a,superpachanga s where m.dui=a.dui_miembro and a.nombre_superpachanga=s.nombre and s.anyo=2018
--Consulta 2
--Proyecto que mas dinero ha acumulado
SELECT codigo,denominacion, monto_acumulado from proyecto order by monto_acumulado desc limit 1
--proyecto que menos dinero ha acumulado
SELECT codigo,denominacion, monto_acumulado from proyecto order by monto_acumulado asc limit 1
--Consulta 3
SELECT extract(year from implantacion_fecha_inicio) as año,sum(implantacion_precio) as monto from contrata group by extract(year from implantacion_fecha_inicio) order by año asc
--Consulta 4
SELECT c.dui, c.denominacion, c.tipo, sum(p.monto_acumulado) as total from cliente c,contrata con,proyecto p where c.dui=con.dui_cliente and con.codigo_proyecto=p.codigo group by c.dui, c.denominacion, c.tipo order by total desc 
--Consulta 5
SELECT tipo, sum(monto_acumulado) from proyecto group by tipo
--Consulta 6
SELECT tipo, sum(monto_acumulado) from proyecto group by tipo having sum(monto_acumulado)::numeric>100000
--Consulta 7
SELECT p.codigo,p.denominacion,s.nombre,s.anyo from proyecto p left join presenta pre on p.codigo=pre.codigo_proyecto left join superpachanga s on pre.nombre_superpachanga=s.nombre
--Consulta 8
SELECT p.codigo,p.denominacion, max(v.numero) as version_mas_reciente from proyecto p,version v where p.codigo=v.codigo_proyecto and v.numero>1.0 group by p.codigo,p.denominacion
--Consulta 9
SELECT (SELECT codigo from proyecto p where p.denominacion='aulavirt') as codigo_subproyecto,'aulavirt' as subproyecto,p.codigo as codigo_macroproyecto,p.denominacion as macroproyecto from proyecto p,proyecto_parte pp where p.codigo=pp.codigo_macroproyecto and pp.codigo_subproyecto=(SELECT codigo from proyecto p where p.denominacion='aulavirt')
--Consulta 10
WITH RECURSIVE macroproyectos(subproyecto,macroproyecto)
as(
SELECT 'aulavirt' as subproyecto,p.denominacion as macroproyecto from proyecto p,proyecto_parte pp where p.codigo=pp.codigo_macroproyecto and pp.codigo_subproyecto=(SELECT codigo from proyecto p where p.denominacion='aulavirt')
UNION ALL
SELECT 'aulavirt' as subproyecto,p.denominacion as macroproyecto from proyecto p, proyecto_parte pp,macroproyectos m where p.codigo=pp.codigo_macroproyecto and pp.codigo_subproyecto=(SELECT codigo from proyecto p where p.denominacion='aulavirt') and m.macroproyecto=p.denominacion
)
SELECT * from macroproyectos