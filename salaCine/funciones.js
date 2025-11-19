import { BadRequest, NotFound } from "./error-middleware.js"

export async function obtenerPeliculas(conexion, fecha) {
	const [resultados] = await conexion.execute("CALL SP_Listar_Peliculas(?)", [fecha]);

	return {
		status: 200,
		data: resultados[0]
	}
}

export async function obtenerDetallePelicula(conexion, idPelicula) {
	const [resultados] = await conexion.execute("CALL SP_Obtener_Pelicula(?)", [idPelicula]);

	if (resultados[0].length === 0) {
		throw new NotFound("La pelicula no existe");
	}

	return {
		status: 200,
		data: resultados[0]
	}
}

export async function reservarButaca(conexion, idFuncion, idButaca, dni) {
	const regexDNI = /^[0-9]{1,11}$/;

	if (!regexDNI.test(dni)) {
		throw new BadRequest("El DNI debe contener solo números y tener hasta 11 dígitos");
	}

	const [resultados] = await conexion.execute("CALL SP_Reservar_Funcion(?, ?, ?)", [idFuncion, idButaca, dni]);

	if (resultados[0][0]["Mensaje"] !== "OK") {
		throw new BadRequest(resultados[0][0]["Mensaje"]);
	}

	return {
		status: 201
	}
}

export async function obtenerButacasDisponibles(conexion, idFuncion) {
	return {
		status: 200,
		data: {}
	}
}