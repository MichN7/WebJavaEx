CREATE DATABASE biblio; 
USE biblio;

CREATE TABLE libros ( id INT, isbn INT, titulo VARCHAR(50), autor VARCHAR(50), disponible TINYINT, PRIMARY KEY (id));

CREATE TABLE usuarios ( clave int , nombre varchar(60), dir varchar(60), telefono varchar(15) , PRIMARY KEY (clave));

CREATE TABLE prestamos ( id int, claveLibro int, claveUsuario int, fechaPrestamo date, fechaEntrega date, recargos float, PRIMARY KEY (id));

SHOW TABLES;