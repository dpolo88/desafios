create table usuario (
    id SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
		nom_usuario varchar (250)
);

insert into usuario (nom_usuario) values ('daniel');
insert into usuario (nom_usuario) values ('sandra');
insert into usuario (nom_usuario) values ('fabian');
insert into usuario (nom_usuario) values ('lia');
insert into usuario (nom_usuario) values ('rossy');

-- para avistamientos
alter table avistamientos add id_usuario smallint UNSIGNED;
alter table avistamientos add foreign key (id_usuario) references usuario(id);

-- para movimientos_recursos
alter table movimientos_recursos add id_usuario smallint UNSIGNED;
alter table movimientos_recursos add foreign key (id_usuario) references usuario(id);

-- para muertes
alter table muertes add id_usuario smallint UNSIGNED;
alter table muertes add foreign key (id_usuario) references usuario(id);

update avistamientos set id_usuario = 1 where id >= 1 and id < 500;
update avistamientos set id_usuario = 2 where id >= 500 and id < 1002;
update avistamientos set id_usuario = 3 where id >= 1002 and id < 1503;
update avistamientos set id_usuario = 4 where id >= 1503 and id < 2001;
update avistamientos set id_usuario = 5 where id >= 2001 and id <= 3178;

update muertes set id_usuario = 1 where id >= 1 and id < 13;
update muertes set id_usuario = 2 where id >= 13 and id < 19;
update muertes set id_usuario = 3 where id >= 19 and id < 35;
update muertes set id_usuario = 4 where id >= 35 and id < 52;
update muertes set id_usuario = 5 where id >= 52 and id <= 66;

-- AVISTAMIENTOS

select t.nombre as titan, a.fecha as fecha_avistamiento, u.nom_usuario as usuario_reporto 
from avistamientos as a
inner join usuario as u on u.id = a.id_usuario 
inner join titanes as t on t.id = a.id_titan
order by t.nombre

-- QUIEN AUTORIZO EL MOVIMIENTO DE UN RECURSO EN PARTICULAR

select r.nombre as nombre_recurso, cantidad, u.nom_usuario as aprobado_por
from movimientos_recursos as mr
inner join recursos as r on r.id = mr.id_recurso
inner join usuario as u on u.id = mr.id_usuario

-- QUIEN EJECUTO A CADA TITAN
select t.id, t.nombre, fecha, u.nom_usuario
from titanes as t 
inner join muertes as m on t.id = m.id_titan
inner join usuario as u on u.id = m.id_usuario
order by u.nom_usuario

-- QUIEN MATO MAS TITANES EL 2020 =>
select nom_usuario, count(nom_usuario) cantidad_muertes_2020 FROM (
	select t.id, t.nombre, (EXTRACT(YEAR FROM fecha)) as anio, u.nom_usuario
	from titanes as t 
	inner join muertes as m on t.id = m.id_titan
	inner join usuario as u on u.id = m.id_usuario
	where (EXTRACT(YEAR FROM fecha)) = 2020
	order by u.nom_usuario
) as t
group by t.nom_usuario
order by count(t.nom_usuario) desc
LIMIT 1
