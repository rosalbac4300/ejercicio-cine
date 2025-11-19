CREATE SCHEMA IF NOT EXISTS `calendario-cine`;
USE `calendario-cine`;

-- CREACION TABLAS
CREATE TABLE IF NOT EXISTS `Genero` (
  `IdGenero` SMALLINT NOT NULL AUTO_INCREMENT,

  `Genero` VARCHAR(50) NOT NULL,
  `Estado` CHAR(1) NOT NULL,

  PRIMARY KEY (`IdGenero`),
  UNIQUE INDEX `Genero-Genero-UX` (`Genero`) VISIBLE,

  -- Todos los campos Estado deben ser 'A' o 'I'
  CONSTRAINT `Genero-Estado-CHK` CHECK (`Estado` IN ('A', 'I'))
);

CREATE TABLE IF NOT EXISTS `Sala` (
  `IdSala` SMALLINT NOT NULL AUTO_INCREMENT,

  `Sala` VARCHAR(60) NOT NULL,
  `TipoSala` CHAR(1) NOT NULL,
  `Direccion` VARCHAR(60) NOT NULL,
  `Estado` CHAR(1) NOT NULL,
  `Observaciones` VARCHAR(255) NULL,

  PRIMARY KEY (`IdSala`),
  UNIQUE INDEX `Sala-Sala-UX` (`Sala`) VISIBLE,
  -- Todos los campos Estado deben ser 'A' o 'I'
  CONSTRAINT `Sala-Estado-CHK` CHECK (`Estado` IN ('A', 'I'))
);

CREATE TABLE IF NOT EXISTS `Butaca` (
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
    UNIQUE INDEX `Butaca-NroButacaIdSala-UX` (`NroButaca`, `IdSala`),

    -- Todos los campos Estado deben ser 'A' o 'I'
    CONSTRAINT `Butaca-Estado-CHK` CHECK (`Estado` IN ('A', 'I')),
    -- Nombre butaca
    UNIQUE INDEX `Butaca-FilaColumna-UX` (`IdSala`, `Columna`, `Fila`),

    -- Indices
    INDEX `Butaca-IdSalaNroButaca-IX` (`IdSala`, `NroButaca`)
);

CREATE TABLE IF NOT EXISTS `Pelicula` (
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
    FOREIGN KEY (`IdGenero`) REFERENCES `Genero`(`IdGenero`),

    -- Todos los campos Estado deben ser 'A' o 'I'
    CONSTRAINT `Pelicula-Estado-CHK` CHECK (`Estado` IN ('A', 'I')),
    -- Duracion
    CONSTRAINT `Pelicula-Duracion-CHK` CHECK (`Duracion` > 0)
);

CREATE TABLE IF NOT EXISTS `Funcion` (
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
    FOREIGN KEY (`IdSala`) REFERENCES `Sala`(`IdSala`),

    -- Campo Precio debe ser Mayor a Cero
	CONSTRAINT `Funcion-Precio-CHK` CHECK (`Precio` > 0),
    -- Todos los campos Estado deben ser 'A' o 'I'
    CONSTRAINT `Funcion-Estado-CHK` CHECK (`Estado` IN ('A', 'I')),
    -- Fechas
    CONSTRAINT `Funcion-Fecha-CHK` CHECK (`FechaInicio` < `FechaFin`),
    CONSTRAINT `Funcion-FechaProbable-CHK` CHECK (`FechaProbableInicio` <= `FechaProbableFin`),

    -- Indices
    INDEX `Funcion-FechaInicio-IX` (`FechaInicio`)
);

CREATE TABLE IF NOT EXISTS `Reserva` (
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
    FOREIGN KEY (`IdButaca`) REFERENCES `Butaca`(`IdButaca`),
    
    -- Indices
    INDEX `Reserva-IdFuncionIdButaca-IX` (`IdFuncion`, `IdReserva`)
);
