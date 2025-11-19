INSERT INTO Genero (IdGenero, Genero, Estado) VALUES
(1, 'Acción', 'A'),
(2, 'Comedia', 'A'),
(3, 'Drama', 'A'),
(4, 'Terror', 'A'),
(5, 'Romance', 'A'),
(6, 'Aventura', 'A'),
(7, 'Documental', 'A'),
(8, 'Animación', 'A'),
(9, 'Fantasía', 'A'),
(10, 'Suspenso', 'A'),
(11, 'Ciencia Ficción', 'A'),
(12, 'Musical', 'A'),
(13, 'Biografía', 'A'),
(14, 'Histórica', 'A'),
(15, 'Crimen', 'A'),
(16, 'Misterio', 'A'),
(17, 'Western', 'A'),
(18, 'Deportes', 'A'),
(19, 'Guerra', 'A'),
(20, 'Infantil', 'A');

INSERT INTO Pelicula (IdPelicula, IdGenero, Pelicula, Sinopsis, Duracion, Actores, Estado, Observaciones) VALUES
(1, 1, 'Fuerza Delta', 'Acción intensa.', 120, 'Actor 1', 'A', NULL),
(2, 2, 'Risas Infinitas', 'Comedia familiar.', 95, 'Actor 2', 'A', NULL),
(3, 3, 'Lágrimas del Alma', 'Drama emocional.', 130, 'Actor 3', 'A', NULL),
(4, 4, 'La Noche Oscura', 'Terror psicológico.', 110, 'Actor 4', 'A', NULL),
(5, 5, 'Corazones Unidos', 'Historia romántica.', 108, 'Actor 5', 'A', NULL),
(6, 6, 'Aventura Extrema', 'Viaje peligroso.', 140, 'Actor 6', 'A', NULL),
(7, 7, 'El Mundo Real', 'Documental educativo.', 80, 'Narrador 1', 'A', NULL),
(8, 8, 'Sueños Animados', 'Película animada.', 90, 'Voces varias', 'A', NULL),
(9, 9, 'Reino Fantástico', 'Historia de fantasía.', 125, 'Actor 7', 'A', NULL),
(10, 10, 'El Sospechoso', 'Suspenso policial.', 118, 'Actor 8', 'A', NULL),
(11, 11, 'Horizonte Final', 'Sci-Fi épica.', 145, 'Actor 9', 'A', NULL),
(12, 12, 'Melodías del Alma', 'Musical emotivo.', 100, 'Actor 10', 'A', NULL),
(13, 13, 'Vida de un Genio', 'Biografía inspiradora.', 155, 'Actor 11', 'A', NULL),
(14, 14, 'Imperio Antiguo', 'Relato histórico.', 135, 'Actor 12', 'A', NULL),
(15, 15, 'Crimen Perfecto', 'Misterio criminal.', 122, 'Actor 13', 'A', NULL),
(16, 16, 'La Gran Pista', 'Investigación oscura.', 128, 'Actor 14', 'A', NULL),
(17, 17, 'Cowboys del Oeste', 'Western clásico.', 115, 'Actor 15', 'A', NULL),
(18, 18, 'En la Cancha', 'Película de deportes.', 105, 'Actor 16', 'A', NULL),
(19, 19, 'Batalla Final', 'Película de guerra.', 150, 'Actor 17', 'A', NULL),
(20, 20, 'Aventuras Mini', 'Para niños.', 85, 'Voces varias', 'A', NULL);

INSERT INTO Sala (IdSala, Sala, TipoSala, Direccion, Estado, Observaciones) VALUES
(1, 'Sala 1', 'A', 'Piso 1', 'A', NULL),
(2, 'Sala 2', 'A', 'Piso 1', 'A', NULL),
(3, 'Sala 3', 'B', 'Piso 1', 'A', NULL),
(4, 'Sala 4', 'B', 'Piso 2', 'A', NULL),
(5, 'Sala 5', 'A', 'Piso 2', 'A', NULL);

INSERT INTO Butaca(IdButaca, IdSala, NroButaca, Fila, Columna, Estado, Observaciones) VALUES
	(51,1,11,4,4,'I',NULL),
	(52,2,11,4,4,'I',NULL),
	(53,3,11,4,4,'I',NULL),
	(54,4,11,4,4,'I',NULL),
	(55,5,11,4,4,'I',NULL);

INSERT INTO Butaca(IdButaca, IdSala, NroButaca, Fila, Columna, Estado, Observaciones) VALUES
-- Sala 1: butacas 1–10
	(1,1,1,1,1,'A',NULL),
	(2,1,2,1,2,'A',NULL),
	(3,1,3,1,3,'A',NULL),
	(4,1,4,2,1,'A',NULL),
	(5,1,5,2,2,'A',NULL),
	(6,1,6,2,3,'A',NULL),
    (7,1,7,3,1,'A',NULL),
    (8,1,8,3,2,'A',NULL),
    (9,1,9,3,3,'A',NULL),
    (0,1,10,4,1,'A',NULL),
-- Sala 2: butacas 11–20
	(11,2,1,1,1,'A',NULL),
	(12,2,2,1,2,'A',NULL),
	(13,2,3,1,3,'A',NULL),
	(14,2,4,2,1,'A',NULL),
	(15,2,5,2,2,'A',NULL),
	(16,2,6,2,3,'A',NULL),
    (17,2,7,3,1,'A',NULL),
    (18,2,8,3,2,'A',NULL),
    (19,2,9,3,3,'A',NULL),
    (20,2,10,4,1,'A',NULL),
-- Sala 3: butacas 21–30
	(21,3,1,1,1,'A',NULL),
	(22,3,2,1,2,'A',NULL),
	(23,3,3,1,3,'A',NULL),
	(24,3,4,2,1,'A',NULL),
	(25,3,5,2,2,'A',NULL),
	(26,3,6,2,3,'A',NULL),
    (27,3,7,3,1,'A',NULL),
    (28,3,8,3,2,'A',NULL),
    (29,3,9,3,3,'A',NULL),
    (30,3,10,4,1,'A',NULL),
-- Sala 4: butacas 31–40
	(31,4,1,1,1,'A',NULL),
	(32,4,2,1,2,'A',NULL),
	(33,4,3,1,3,'A',NULL),
	(34,4,4,2,1,'A',NULL),
	(35,4,5,2,2,'A',NULL),
	(36,4,6,2,3,'A',NULL),
    (37,4,7,3,1,'A',NULL),
    (38,4,8,3,2,'A',NULL),
    (39,4,9,3,3,'A',NULL),
    (40,4,10,4,1,'A',NULL),
-- Sala 5: butacas 41–50
	(41,5,1,1,1,'A',NULL),
	(42,5,2,1,2,'A',NULL),
	(43,5,3,1,3,'A',NULL),
	(44,5,4,2,1,'A',NULL),
	(45,5,5,2,2,'A',NULL),
	(46,5,6,2,3,'A',NULL),
    (47,5,7,3,1,'A',NULL),
    (48,5,8,3,2,'A',NULL),
    (49,5,9,3,3,'A',NULL),
    (50,5,10,4,1,'A',NULL);

INSERT INTO Funcion (
    IdFuncion, IdPelicula, IdSala, FechaProbableInicio, FechaProbableFin, FechaInicio, FechaFin,
    Precio, Estado, Observaciones
) VALUES
(1,1,1,'2025-11-17 18:00','2025-11-17 20:00','2025-11-17 18:00','2025-11-17 20:00',4500,'A',NULL),
(2,2,2,'2025-11-17 20:00','2025-11-17 21:40','2025-11-17 20:00','2025-11-17 21:40',3000,'I',NULL),
(3,3,3,'2025-11-17 22:00','2025-11-18 00:10','2025-11-17 22:00','2025-11-18 00:10',3800,'A',NULL),
(4,4,4,'2025-11-18 18:00','2025-11-18 19:50','2025-11-18 18:00','2025-11-18 19:50',4200,'I',NULL),
(5,5,5,'2025-11-18 20:00','2025-11-18 21:48','2025-11-18 20:00','2025-11-18 21:48',3100,'A',NULL),
(6,6,1,'2025-11-18 22:00','2025-11-19 00:20',NULL,NULL,5000,'A',NULL),
(7,7,2,'2025-11-19 18:00','2025-11-19 19:20','2025-11-19 18:00','2025-11-19 19:20',2500,'I',NULL),
(8,8,3,'2025-11-19 20:00','2025-11-19 21:30','2025-11-19 20:00','2025-11-19 21:30',2800,'A',NULL),
(9,9,4,'2025-11-19 22:00','2025-11-20 00:05','2025-11-19 22:00','2025-11-20 00:05',3500,'A',NULL),
(10,10,5,'2025-11-20 18:00','2025-11-20 20:00',NULL,NULL,3600,'A',NULL),
(11,11,1,'2025-11-20 20:00','2025-11-20 22:25','2025-11-20 20:00','2025-11-20 22:25',6000,'A',NULL),
(12,12,2,'2025-11-20 22:00','2025-11-21 00:10','2025-11-20 22:00','2025-11-21 00:10',3900,'A',NULL),
(13,13,3,'2025-11-21 18:00','2025-11-21 20:35','2025-11-21 18:00','2025-11-21 20:35',4100,'A',NULL),
(14,14,4,'2025-11-21 20:00','2025-11-21 22:15','2025-11-21 20:00','2025-11-21 22:15',4800,'I',NULL),
(15,15,5,'2025-11-21 22:00','2025-11-22 00:05','2025-11-21 22:00','2025-11-22 00:05',4500,'A',NULL),
(16,16,1,'2025-11-22 18:00','2025-11-22 19:55','2025-11-22 18:00','2025-11-22 19:55',3200,'A',NULL),
(17,17,2,'2025-11-22 20:00','2025-11-22 21:50','2025-11-22 20:00','2025-11-22 21:50',2700,'I',NULL),
(18,18,3,'2025-11-22 22:00','2025-11-22 23:45','2025-11-22 22:00','2025-11-22 23:45',3300,'A',NULL),
(19,19,4,'2025-11-23 18:00','2025-11-23 20:30','2025-11-23 18:00','2025-11-23 20:30',5200,'A',NULL),
(20,20,5,'2025-11-23 20:00','2025-11-23 21:25','2025-11-23 20:00','2025-11-23 21:25',2900,'A',NULL);

INSERT INTO Funcion (
    IdPelicula, IdSala, FechaProbableInicio, FechaProbableFin, FechaInicio, FechaFin,
    Precio, Estado, Observaciones
) VALUES
(1,1,'2025-11-18 18:00','2025-11-18 20:00',NULL,NULL,4500,'I',NULL),
(1,1,'2025-11-19 18:00','2025-11-19 20:00',NULL,NULL,4500,'I',NULL),
(1,1,'2025-11-20 18:00','2025-11-20 20:00',NULL,NULL,4500,'A',NULL),
(1,1,'2025-11-21 18:00','2025-11-21 20:00',NULL,NULL,4500,'A',NULL);
