--Identidades: Películas, Cliente, Alquiler

--Pasar a 1FN
-- peliculas(#id, title, director, year)
-- clientes(#id, name, return_date, movie_id)

--Pasar a 2FN y 3FN
-- peliculas(#id, title, director, year)
-- clientes(#id, name)
-- rents(#id, return_date, movie_id, client_id)

--Cambiarse a base postgres
\c postgres;

-- Create a new database called 'videoclub'
CREATE DATABASE videoclub;

--Conexión base videoclub
\c videoclub;

--Crear Tablas
CREATE TABLE movies(
  id SMALLINT NOT NULL,
  title VARCHAR(50) NOT NULL,
  director VARCHAR(50) NOT NULL,
  year SMALLINT NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE clients(
  id SERIAL NOT NULL,
  client_name VARCHAR(50),
  PRIMARY KEY(id)
);

CREATE TABLE rents(
  id SERIAL NOT NULL,
  return_date DATE NOT NULL,
  movie_id SMALLINT NOT NULL,
  client_id SMALLINT NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY(movie_id) REFERENCES movies(id),
  FOREIGN KEY(client_id) REFERENCES clients(id)
);

--Agregar movies
INSERT INTO movies(id, title, director, year) VALUES (55, 'Avengers: Endgame', 'Russo, A y Russo, J', 2019);

INSERT INTO movies(id, title, director, year) VALUES (50, 'Avatar', 'Cameron, J', 2009);

INSERT INTO movies(id, title, director, year) VALUES (53, 'Titanic', 'Cameron, J', 1997);

INSERT INTO movies(id, title, director, year) VALUES (51, 'Star Wars: Episodio VII', 'Abramas, J', 2015);

INSERT INTO movies(id, title, director, year) VALUES (52, 'Avengers: Infinity War', 'Russo, A y Russo, J', 2018);

--Agregar clients
INSERT INTO clients(client_name) VALUES ('Gonzalez, Gómez, Juan');

INSERT INTO clients(client_name) VALUES ('Juvenal, Pereira, James');

INSERT INTO clients(client_name) VALUES ('García, Soto, Rosa');

INSERT INTO clients(client_name) VALUES ('Sanchez, Molina, Ana');

--Agregar a Rents
INSERT INTO rents(return_date, movie_id, client_id) VALUES ('2019-10-15', (SELECT id FROM movies WHERE title= 'Avengers: Endgame'), (SELECT id FROM clients WHERE client_name='Gonzalez, Gómez, Juan'));

INSERT INTO rents(return_date, movie_id, client_id) VALUES ('2019-10-23', (SELECT id FROM movies WHERE title= 'Avatar'), (SELECT id FROM clients WHERE client_name='Juvenal, Pereira, James'));

INSERT INTO rents(return_date, movie_id, client_id) VALUES ('2019-10-24', (SELECT id FROM movies WHERE title= 'Titanic'), (SELECT id FROM clients WHERE client_name='García, Soto, Rosa'));

INSERT INTO rents(return_date, movie_id, client_id) VALUES ('2019-10-18', (SELECT id FROM movies WHERE title= 'Star Wars: Episodio VII'), (SELECT id FROM clients WHERE client_name='Sanchez, Molina, Ana'));

INSERT INTO rents(return_date, movie_id, client_id) VALUES ('2019-10-17', (SELECT id FROM movies WHERE title= 'Avengers: Infinity War'), (SELECT id FROM clients WHERE client_name='Gonzalez, Gómez, Juan'));

--Mostrar tabla rents
SELECT * FROM rents;

--Mostrar todos los datos
SELECT movies.id, movies.title, movies.director, movies.year, clients.client_name, rents.return_date FROM
rents INNER JOIN movies ON rents.movie_id=movies.id INNER JOIN clients ON rents.client_id=clients.id;
