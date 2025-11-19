CREATE SCHEMA IF NOT EXISTS `calendario-cine`;
USE `calendario-cine`;

-- CREACION TABLAS
DROP TABLE IF EXISTS `Genero`;
CREATE TABLE `Genero` (
  `IdGenero` SMALLINT NOT NULL AUTO_INCREMENT,

  `Genero` VARCHAR(50) NOT NULL,
  `Estado` CHAR(1) NOT NULL,

  PRIMARY KEY (`IdGenero`),
  UNIQUE INDEX `Genero-Genero-UX` (`Genero`) VISIBLE
);

CREATE TABLE IF NOT EXISTS `Sala` (
  `IdSala` SMALLINT NOT NULL AUTO_INCREMENT,

  `Sala` VARCHAR(60) NOT NULL,
  `TipoSala` CHAR(1) NOT NULL,
  `Direccion` VARCHAR(60) NOT NULL,
  `Estado` CHAR(1) NOT NULL,
  `Observaciones` VARCHAR(255) NULL,

  PRIMARY KEY (`IdSala`),
  UNIQUE INDEX `Sala-Sala-UX` (`Sala`) VISIBLE
);

DROP TABLE IF EXISTS `Butaca`;
CREATE TABLE `Butaca` (
	`IdButaca` INT NOT NULL AUTO_INCREMENT,
	`IdSala` SMALLINT NOT NULL,

    `NroButaca` SMALLINT NOT NULL,
    `Fila` SMALLINT NOT NULL,
    `Columna` SMALLINT NOT NULL,
    `Estado` CHAR(1) NOT NULL,
    `Observaciones` VARCHAR(255) NULL,

    PRIMARY KEY (`IdButaca`, `IdSala`),
    FOREIGN KEY (`IdSala`) REFERENCES `Sala`(`IdSala`),
    UNIQUE INDEX `Butaca-idButaca-UX` (`IdButaca`),
    UNIQUE INDEX `Butaca-NroButacaIdSala-UX` (`NroButaca`, `IdSala`)
);

DROP TABLE IF EXISTS `Pelicula`;
CREATE TABLE `Pelicula` (
	`IdPelicula` INT NOT NULL AUTO_INCREMENT,
    `IdGenero` SMALLINT NOT NULL,

    `Pelicula` VARCHAR(100) NOT NULL,
    `Sinopsis` TEXT NOT NULL,
    `Duracion` SMALLINT NOT NULL,
    `Actores` LONG VARCHAR NOT NULL,

	`Estado` CHAR(1) NOT NULL,
    `Observaciones` VARCHAR(255) NULL,

    PRIMARY KEY (`IdPelicula`),
    UNIQUE INDEX `Pelicula-Pelicula-UX` (`Pelicula`),
    FOREIGN KEY (`IdGenero`) REFERENCES `Genero`(`IdGenero`)
);

DROP TABLE IF EXISTS `Funcion`;
CREATE TABLE `Funcion` (
	`IdFuncion` INT NOT NULL UNIQUE AUTO_INCREMENT,
    `IdPelicula` INT NOT NULL,
	`IdSala` SMALLINT NOT NULL,
    `FechaProbableInicio` DATETIME NOT NULL,
    `FechaProbableFin` DATETIME NOT NULL,
	`FechaInicio` DATETIME NULL,
	`FechaFin` DATETIME NULL,
    `Precio` DECIMAL(12, 2) NOT NULL,

    `Estado` CHAR(1) NOT NULL,
    `Observaciones` VARCHAR(255) NULL,

    PRIMARY KEY (`IdFuncion`, `IdPelicula`, `IdSala`),
    FOREIGN KEY (`IdPelicula`) REFERENCES `Pelicula`(`IdPelicula`),
    FOREIGN KEY (`IdSala`) REFERENCES `Sala`(`IdSala`)
);

DROP TABLE IF EXISTS `Reserva`;
CREATE TABLE `Reserva` (
	`IdReserva` BIGINT UNIQUE AUTO_INCREMENT,
    `IdFuncion` INT NOT NULL,
    `IdPelicula` INT NOT NULL,
    `IdSala` SMALLINT NOT NULL,
    `IdButaca` INT NOT NULL,

    `DNI` VARCHAR(11) NOT NULL,
    `FechaAlta` DATETIME NOT NULL,
    `FechaBaja` DATETIME NULL,
    `EstaPagada` CHAR(1) NOT NULL,
    `Observaciones` VARCHAR(255) NULL,

	PRIMARY KEY (`IdReserva`, `IdFuncion`, `IdPelicula`, `IdSala`, `IdButaca`),
    FOREIGN KEY (`IdFuncion`) REFERENCES `Funcion`(`IdFuncion`),
    FOREIGN KEY (`IdPelicula`) REFERENCES `Pelicula`(`IdPelicula`),
    FOREIGN KEY (`IdSala`) REFERENCES `Sala`(`IdSala`),
    FOREIGN KEY (`IdButaca`) REFERENCES `Butaca`(`IdButaca`)
);

-- CONSTRAINTS
-- Campo Precio debe ser Mayor a Cero
ALTER TABLE `Funcion`
	ADD CONSTRAINT `Funcion-Precio-CHK` CHECK (`Precio` > 0);

-- Todos los campos Estado deben ser 'A' o 'I'
ALTER TABLE `Genero`
	ADD CONSTRAINT `Genero-Estado-CHK` CHECK (`Estado` IN ('A', 'I'));

ALTER TABLE `Sala`
	ADD CONSTRAINT `Sala-Estado-CHK` CHECK (`Estado` IN ('A', 'I'));

ALTER TABLE `Butaca`
	ADD CONSTRAINT `Butaca-Estado-CHK` CHECK (`Estado` IN ('A', 'I'));

ALTER TABLE `Pelicula`
	ADD CONSTRAINT `Pelicula-Estado-CHK` CHECK (`Estado` IN ('A', 'I'));

ALTER TABLE `Funcion`
	ADD CONSTRAINT `Funcion-Estado-CHK` CHECK (`Estado` IN ('A', 'I'));

-- Constraints de fechas
ALTER TABLE `Funcion`
		ADD CONSTRAINT `Funcion-Fecha-CHK` CHECK (`FechaInicio` < `FechaFin`);

ALTER TABLE `Funcion`
		ADD CONSTRAINT `Funcion-FechaProbable-CHK` CHECK (`FechaProbableInicio` <= `FechaProbableFin`);

-- Constraints para nombres de butacas
ALTER TABLE `Butaca`
	ADD UNIQUE INDEX `Butaca-FilaColumna-UX` (`IdSala`, `Columna`, `Fila`);

-- Agrego constraint de duracion de la pelicula:
ALTER TABLE `Pelicula`
	ADD CONSTRAINT `Pelicula-Duracion-CHK` CHECK (`Duracion` > 0);

-- Agregar constraint de valor EstaPagada?

-- INDICES
CREATE INDEX `Funcion-FechaInicio-IX`
	ON `Funcion`
	(`FechaInicio`);

CREATE INDEX `Butaca-IdSalaNroButaca-IX`
	ON `Butaca`
	(`IdSala`, `NroButaca`);

CREATE INDEX `Reserva-IdFuncionIdButaca-IX`
	ON `Reserva`
	(`IdFuncion`, `IdButaca`);

-- Otros indices Necesarios:
