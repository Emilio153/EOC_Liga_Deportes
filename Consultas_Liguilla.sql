use liguilla;

-- 1. Ranking de equipos por puntos y diferencia de goles
select nombre, puntos, (goles_a_favor - goles_en_contra) as diferencia_goles
from equipo
order by puntos desc, diferencia_goles desc;

-- 2. Jugadores con más goles en la liguilla
select j.nombre, e.nombre as equipo, sum(p.goles) as total_goles
from jugador j
join equipo e on j.id_equipo = e.id_equipo
join participacion p on j.id_jugador = p.id_jugador
group by j.id_jugador, j.nombre, e.nombre
order by total_goles desc
limit 10;

-- 3. Partidos arbitrados por cada árbitro y su promedio de goles
select a.nombre as arbitro, count(pa.id_partido) as partidos_arbitrados,
       avg(pa.goles_local + pa.goles_visitante) as promedio_goles
from arbitro a
join partido pa on a.id_arbitro = pa.id_arbitro
group by a.id_arbitro, a.nombre
order by partidos_arbitrados desc;

-- 4. Espectadores ordenados por el total gastado en entradas
SELECT es.nombre, es.email, COUNT(en.id_entrada) AS entradas_compradas, SUM(en.precio) AS total_gastado
FROM espectador es
JOIN entrada en ON es.id_espectador = en.id_espectador
GROUP BY es.id_espectador, es.nombre, es.email
ORDER BY total_gastado DESC;


-- 5. Total de ventas y recaudación por producto en cafetería
select pr.nombre, sum(ca.cantidad) as total_vendido, sum(ca.cantidad * pr.precio) as recaudacion_total
from producto pr
join cafeteria ca on pr.id_producto = ca.id_producto
group by pr.id_producto, pr.nombre
order by recaudacion_total desc;

-- 6. Partidos ordenados por el total de goles (de mayor a menor)
SELECT pa.id_partido, pa.fecha, el.nombre AS local, ev.nombre AS visitante,
       pa.goles_local, pa.goles_visitante,
       (pa.goles_local + pa.goles_visitante) AS total_goles
FROM partido pa
JOIN equipo el ON pa.id_equipo_local = el.id_equipo
JOIN equipo ev ON pa.id_equipo_visitante = ev.id_equipo
ORDER BY total_goles DESC;


-- 7. Jugadores con más tarjetas rojas
select j.nombre, e.nombre as equipo, sum(p.tarjetas_rojas) as rojas
from jugador j
join equipo e on j.id_equipo = e.id_equipo
join participacion p on j.id_jugador = p.id_jugador
group by j.id_jugador, j.nombre, e.nombre
having sum(p.tarjetas_rojas) > 0
order by rojas desc;

-- 8. Equipos con más partidos como local que como visitante
SELECT 
  e.nombre,
  SUM(CASE WHEN p.id_equipo_local = e.id_equipo THEN 1 ELSE 0 END) AS partidos_local,
  SUM(CASE WHEN p.id_equipo_visitante = e.id_equipo THEN 1 ELSE 0 END) AS partidos_visitante
FROM equipo e
LEFT JOIN partido p ON e.id_equipo = p.id_equipo_local OR e.id_equipo = p.id_equipo_visitante
GROUP BY e.id_equipo, e.nombre
HAVING partidos_local > partidos_visitante
ORDER BY partidos_local DESC;


-- 9. Espectadores que han comprado productos en cafetería y han asistido a partidos
select distinct es.nombre, es.email
from espectador es
join cafeteria ca on es.id_espectador = ca.id_espectador
join entrada en on es.id_espectador = en.id_espectador;

-- 10. Promedio de goles por partido de cada equipo (sumando local y visitante)
select e.nombre,
       round(avg(case when p.id_equipo_local = e.id_equipo then p.goles_local
                      when p.id_equipo_visitante = e.id_equipo then p.goles_visitante end),2) as promedio_goles
from equipo e
join partido p on e.id_equipo = p.id_equipo_local or e.id_equipo = p.id_equipo_visitante
group by e.id_equipo, e.nombre
order by promedio_goles desc;



