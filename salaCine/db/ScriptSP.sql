USE `calendario-cine`;

-- Listado de peliculas en carteleras segun fecha
DROP PROCEDURE IF EXISTS `SP_Listar_Peliculas`;
DELIMITER $$
CREATE PROCEDURE `SP_Listar_Peliculas`(pFecha DATETIME)
SALIR: BEGIN
    SELECT
		F.`IdFuncion` AS `Id Funcion`,
        P.`IdPelicula` AS `Id Pelicula`,
        S.`IdSala` AS `Id Sala`,
        P.`Pelicula`,
        S.`Sala`,
        COALESCE(F.`FechaInicio`, F.`FechaProbableInicio`) AS `Hora de Inicio`,
        COALESCE(F.`FechaFin`, F.`FechaProbableFin`) AS `Hora de Fin`,
        F.`Precio`
    FROM
		`Funcion` AS F
        JOIN `Pelicula` AS P ON P.`IdPelicula` = F.`IdPelicula`
        JOIN `Sala` AS S ON S.`IdSala` = F.`IdSala`
    WHERE
		COALESCE(F.`FechaInicio`, F.`FechaProbableInicio`) >= pFecha
        AND COALESCE(F.`FechaFin`, F.`FechaProbableFin`) >= NOW()
        AND F.`Estado` = 'A';
END$$
DELIMITER ;

-- Datos de una pelicula en particular
DROP PROCEDURE IF EXISTS `SP_Obtener_Pelicula`;
DELIMITER $$
CREATE PROCEDURE `SP_Obtener_Pelicula`(pIdPelicula INT)
SALIR: BEGIN
	SELECT
		P.IdPelicula AS `Id Pelicula`,
        G.Genero,
        P.Pelicula,
        P.Sinopsis,
        P.Duracion AS `Duracion (Min)`,
        P.Actores,
        P.Observaciones,
        COUNT(F.IdFuncion) AS `Numero de funciones asociadas`,
        (
			SELECT
				MIN(F2.FechaProbableInicio)
			FROM Funcion F2
			WHERE F2.IdPelicula = pIdPelicula
				AND F2.FechaProbableInicio > NOW()
				AND F2.Estado = 'A'
        ) AS `Proxima Funcion`
    FROM
		Pelicula AS P
        JOIN Genero AS G ON G.IdGenero = P.IdGenero
        JOIN Funcion AS F ON F.IdPelicula = P.IdPelicula
    WHERE P.IdPelicula = pIdPelicula
		AND F.Estado = 'A'
        AND P.Estado = 'A'
	GROUP BY P.IdPelicula;
END$$
DELIMITER ;

-- Reservar una funcion
DROP PROCEDURE IF EXISTS `SP_Reservar_Funcion`;
DELIMITER $$
CREATE PROCEDURE `SP_Reservar_Funcion`(pIdFuncion INT, pIdButaca INT, pDNI VARCHAR(11))
SALIR: BEGIN
	DECLARE pFechaInicio DATETIME;
    DECLARE pIdSala SMALLINT;
    DECLARE pIdPelicula INT;
    DECLARE pIdReserva INT;

    SELECT FechaProbableInicio, IdSala, IdPelicula
        INTO pFechaInicio, pIdSala, pIdPelicula
	FROM Funcion
    WHERE IdFuncion = pIdFuncion AND Estado = 'A'
    LIMIT 1;

	IF pFechaInicio IS NULL THEN
	  	SELECT 'No se encontró la función' Mensaje;
	 	LEAVE SALIR;
    END IF;

    IF (pFechaInicio <= NOW()) THEN
	 	SELECT 'No es posible reservar para una función que ya inició' Mensaje;
	 	LEAVE SALIR;
    END IF;

	IF NOT EXISTS (SELECT IdButaca FROM Butaca WHERE IdButaca = pIdButaca AND Estado = 'A' AND IdSala = pIdSala) THEN
		SELECT 'No se encontró la butaca' Mensaje;
       LEAVE SALIR;
    END IF;

    START TRANSACTION;
		SELECT IdButaca INTO @dummy
		FROM Butaca
        WHERE IdButaca = pIdButaca
			AND IdSala = pIdSala
        FOR UPDATE;

        SELECT R.IdReserva INTO pIdReserva
        FROM Reserva AS R
			JOIN Funcion AS F ON F.IdFuncion = R.IdReserva
        WHERE F.IdFuncion = pIdFuncion
			AND R.IdSala = pIdSala
            AND R.IdButaca = pIdButaca
            AND R.FechaBaja IS NULL
		LIMIT 1;

        IF pIdReserva IS NOT NULL THEN
			SELECT 'La butaca ya fue reservada' Mensaje;
            ROLLBACK;
            LEAVE SALIR;
        END IF;

        INSERT INTO Reserva (IdFuncion, IdPelicula, IdSala, IdButaca, DNI, FechaAlta, EstaPagada, Observaciones)
        VALUES (pIdFuncion, pIdPelicula, pIdSala, pIdButaca, pDNI, NOW(), 'N', NULL);
	COMMIT;

    SELECT 'OK' Mensaje;
END$$
DELIMITER ;

