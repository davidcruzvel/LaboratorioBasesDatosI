-- DDL BASE DE DATOS ESCOLAR 

create database if not exists Escuela;
use Escuela;

-- Tablas de direccion
create table departamentos(
	idDepartamento char(2) primary key,
    departamento varchar(25) not null,
    pais varchar(25) not null
);

create table municipios(
	idMunicipio char(3) primary key,
    municipio varchar(50) not null,
    idDepartamento char(2) not null
);

create table distritos(
	idDistrito char(5) primary key,
    distrito varchar(50) not null,
    idMunicipio char(3) not null
);

create table direcciones(
	idDireccion int primary key auto_increment,
    linea1 varchar(100) not null,
    linea2 varchar(50),
    idDistrito char(5) not null,
    codigoPostal varchar(7)
);

-- Tablas de los empleados
create table cargos(
	idCargo int primary key auto_increment,
    cargo varchar(25) not null
);

create table empleados(
	idEmpleado int primary key auto_increment,
    nombresEmpleado varchar(100) not null,
    apellidosEmpleado varchar(100) not null,
    duiEmpleado char(10) not null,
    isssEmpleado char(9),
    fechaNacEmpleado date not null,
    telefonoEmpleado varchar(15) not null,
    correoEmpleado varchar(100),
    idCargo int not null,
    idDireccion int not null
);

create table especialidades(
	idEspecialidad int primary key auto_increment,
    especialidad varchar(100) not null,
    carrera varchar(100) not null
);

create table docentes(
	idDocente int primary key auto_increment,
    escalafon varchar(20) not null,
    idEmpleado int not null,
    idEspecialidad int not null
);

-- Tablas de los grupos
create table aulas(
	idAula int primary key auto_increment,
    edificio varchar(10),
    piso int,
    numeroAula int not null
);

create table turnos(
	idTurno int primary key auto_increment,
    turno varchar(20) not null
);

create table grupos(
	idGrupo int primary key auto_increment,
    grado varchar(50) not null,
    seccion varchar(5),
    anio year not null,
    idDocente int not null,
    idTurno int not null,
    idAula int not null
);

-- Tablas de los estudiantes
create table estudiantes(
	nie int primary key,
	nombresEstudiante varchar(100) not null,
    apellidosEstudiante varchar(100) not null,
    fechaNacEstudiante date not null,
    generoEstudiante char(1) not null,
    telefonoEstudiante varchar(15),
    correoEstudiante varchar(100),
    idEncargado int not null,
    idDireccion int not null
);

create table matriculas(
	idMatricula int primary key auto_increment,
    fechaMatricula date not null,
    nie int not null,
    idGrupo int not null
);

create table encargados(
	idEncargado int primary key auto_increment,
    nombresEncargado varchar(100),
    apellidosEncargado varchar(100) not null,
    telefonoEncargado varchar(15) not null,
    duiEncargado char(10) not null,
    idDireccion int not null
);

create table materias(
	idMateria int primary key auto_increment,
    materia varchar(100) not null
);

create table calificaciones(
	idCalificacion int primary key auto_increment,
    idMateria int not null,
    nie int not null,
    -- decimal(3, 1) indica 3 digitos con 1 decimal, ej.: 10.0
    examen1 decimal(3, 1) not null,
    examen2 decimal(3, 1) not null,
    examen3 decimal(3, 1) not null,
    examenFinal decimal(3, 1) not null,
    tareas decimal(3, 1) not null,
    promedio decimal(3, 1) not null,
    estado char(1) not null,
    idDocente int not null
);

-- Llaves foraneas de direcciones
alter table municipios add foreign key (idDepartamento) references departamentos(idDepartamento);
alter table distritos add foreign key (idMunicipio) references municipios(idMunicipio);
alter table direcciones add foreign key (idDistrito) references distritos(idDistrito);
-- Llaves foraneas de empleados
alter table empleados add foreign key (idCargo) references cargos(idCargo);
alter table empleados add foreign key (idDireccion) references direcciones(idDireccion);
alter table docentes add foreign key (idEmpleado) references empleados(idEmpleado);
alter table docentes add foreign key (idEspecialidad) references especialidades(idEspecialidad);
-- Llaves foraneas de grupos
alter table grupos add foreign key (idDocente) references docentes(idDocente);
alter table grupos add foreign key (idAula) references aulas(idAula);
alter table grupos add foreign key (idTurno) references turnos(idTurno);
-- Llaves foraneas de estudiantes
alter table encargados add foreign key (idDireccion) references direcciones(idDireccion);
alter table estudiantes add foreign key (idEncargado) references encargados(idEncargado);
alter table estudiantes add foreign key (idDireccion) references direcciones(idDireccion);
alter table matriculas add foreign key (nie) references estudiantes(nie);
alter table matriculas add foreign key (idGrupo) references grupos(idGrupo);
alter table calificaciones add foreign key (nie) references estudiantes(nie);
alter table calificaciones add foreign key (idMateria) references materias(idMateria);
alter table calificaciones add foreign key (idDocente) references docentes(idDocente);

