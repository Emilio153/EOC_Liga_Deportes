drop database if exists liguilla;
create database liguilla;
use liguilla;

-- tabla de equipos
create table equipo (
    id_equipo int primary key auto_increment,
    nombre varchar(100) not null,
    apellido1 varchar(100),
    apellido2 varchar(100),
    entrenador varchar(100),
    puntos int,
    partidos_jugados int,
    partidos_ganados int,
    partidos_empatados int,
    partidos_perdidos int,
    goles_a_favor int,
    goles_en_contra int
   );

create table jugador (
    id_jugador int primary key auto_increment,
    nombre varchar(100) not null,
	apellido1 varchar(100),
    apellido2 varchar(100),
    fecha_nacimiento date,
    dorsal int,
    posicion varchar(30),
    id_equipo int,
    constraint fk_equipo_jugador foreign key (id_equipo) references equipo(id_equipo)
);

create table arbitro (
    id_arbitro int primary key auto_increment,
    nombre varchar(100) not null,
	apellido1 varchar(100),
    apellido2 varchar(100),
    categoria varchar(50)
);

create table partido (
    id_partido int primary key auto_increment,
    fecha date,
    hora time,
    id_equipo_local int,
    id_equipo_visitante int,
    id_arbitro int,
    goles_local int,
    goles_visitante int,
    constraint fk_equipol_partido foreign key (id_equipo_local) references equipo(id_equipo),
    constraint fk_equipov_partido foreign key (id_equipo_visitante) references equipo(id_equipo),
    constraint fk_arbitro_partido foreign key (id_arbitro) references arbitro(id_arbitro)
);

create table espectador (
    id_espectador int primary key auto_increment,
    nombre varchar(100),
	apellido1 varchar(100),
    apellido2 varchar(100),
    email varchar(100)
);

create table entrada (
    id_entrada int primary key auto_increment,
    id_espectador int,
    id_partido int,
    fecha_compra date,
    precio decimal(5,2),
    constraint fk_espectador_entrada foreign key (id_espectador) references espectador(id_espectador),
    constraint fk_partido_entrada foreign key (id_partido) references partido(id_partido)
);

create table participacion (
    id_partido int,
    id_jugador int,
    minutos_jugados int,
    goles int,
    asistencias int,
    tarjetas_amarillas int,
    tarjetas_rojas int,
    primary key (id_partido, id_jugador),
    constraint fk_partido_participacion foreign key (id_partido) references partido(id_partido),
    constraint fk_jugador_participacion foreign key (id_jugador) references jugador(id_jugador)
);

create table producto (
    id_producto int primary key auto_increment,
    nombre varchar(100) not null,
    precio decimal(5,2) not null
);

create table cafeteria (
    id_venta int primary key auto_increment,
    id_producto int,
    id_espectador int,
    cantidad int not null,
    fecha date not null,
    constraint fk_producto_cafeteria foreign key (id_producto) references producto(id_producto),
    constraint fk_espectador_cafeteria foreign key (id_espectador) references espectador(id_espectador)
);

