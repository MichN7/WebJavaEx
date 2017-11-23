create database empresa;

use empresa;

create table empleado(
nomina int,
nombre varchar(30),
aMaterno varchar(30),
aPaterno varchar(30),
fechaIngreso date,
primary key (nomina)
);