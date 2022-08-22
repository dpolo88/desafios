
-- PREGUNTA 1
select t.nombre, t.altura, m.causa, m.fecha as fecha_muerte
from titanes as t 
inner join
muertes as m on m.id_titan = t.id
where m.causa = 'Accidente'
order by m.fecha asc

-- PREGUNTA 2
select t.nombre, t.altura, m.causa, m.fecha as fecha_muerte
from titanes as t 
inner join
muertes as m on m.id_titan = t.id
where m.causa = 'Batallón 1'
order by altura desc
limit 1

-- PREGUNTA 3
select distinct t.id, t.nombre, t.altura as altura, (
	select max(fecha)
	from avistamientos 
	where id_titan = t.id
	order by fecha desc
) as ultimo_avistamiento
from titanes as t 
left join muertes as m on m.id_titan = t.id
inner join avistamientos as a on t.id = a.id_titan
where m.causa is null

-- PREGUNTA 4
SELECT t.id, t.nombre , MAX(t.cantidad_avistamiento) as mayor_cantidad_avistamiento  from  (
	select t.id, t.nombre, count(EXTRACT(YEAR FROM fecha)) as cantidad_avistamiento
	from titanes as t 
	inner join avistamientos as a on t.id = a.id_titan
	GROUP BY t.id, t.nombre, EXTRACT(YEAR FROM fecha)
	having count(EXTRACT(YEAR FROM fecha)) > 1
) AS t
group by t.id

-- PREGUNTA 5

select distinct r.nombre as nom_recurso, mr.cantidad, mo.nombre as nom_movimiento  
from titanes as t
inner join muertes as m on m.id_titan = t.id
inner join movimientos_recursos  as mr on mr.id_muerte = m.id
inner join recursos as r on r.id = mr.id_recurso
inner join movimientos as mo on mo.id = mr.id_movimiento
where altura <= 5

-- PREGUNTA 6
SELECT t.nom_recurso, count(t.nom_recurso) as cantidad_comun FROM (
select r.id, r.nombre as nom_recurso, mr.cantidad, mo.nombre as nom_movimiento  
from titanes as t
inner join muertes as m on m.id_titan = t.id
inner join movimientos_recursos  as mr on mr.id_muerte = m.id
inner join recursos as r on r.id = mr.id_recurso
inner join movimientos as mo on mo.id = mr.id_movimiento
where altura = 9
order by r.nombre
) AS t
group by t.nom_recurso
order by count(t.nom_recurso) desc
limit 1

-- PREGUNTA 7

select distinct t.id, t.nombre, a.fecha as fecha_avistamiento, m.fecha as fecha_muerte,  
DATEDIFF(m.fecha, a.fecha) as incongruencia from titanes as t 
inner join muertes as m on m.id_titan = t.id
inner join avistamientos as a on a.id_titan = t.id
where DATEDIFF(m.fecha, a.fecha) < 0
order by t.id asc

-- PREGUNTA 8
-- no existe un filtro o validación de las fechas para el registro de avistamientos y muertes

