import asyncHandler from "express-async-handler";
import { body, param } from 'express-validator';
import cors from 'cors';
import express, { json } from 'express';

import { connectarseConReintento, correrScriptInicial, correrScriptSP } from './database.js';
import errorMiddleware from './error-middleware.js';
import {
	obtenerButacasDisponibles,
	obtenerDetallePelicula,
	obtenerPeliculas,
	reservarButaca,
} from './funciones.js';
import { validateRequest } from './validate-request.js';

console.log('Starting salaCine service... ');

const conexionDB = await connectarseConReintento();
await correrScriptInicial(conexionDB);
// await correrScriptSP(conexionDB);

const port = 4000;

const app = express();
app.use(cors());
app.use(json());
app.use(errorMiddleware);

const server = app.listen(port, () => {
	console.log(`Listening on port ${port}`);
});

// Agregar las rutas
// Podria armar routers, para organizarlos mejor.
// Ahora lo mantengo simple en un solo archivo.
app.get(
	'/peliculas/detalle/:idPelicula',
	[
		param('idPelicula').isNumeric().withMessage('El Id es numérico'),
		validateRequest,
	],
	async (req, res, next) => {
		const resultado = await obtenerPeliculas(conexionDB, req.params['fecha']);

		return res.status(resultado.status).json(resultado.data);
	}
);

app.get(
	'/peliculas/:fecha',
	[
		param('fecha').isISO8601().toDate().withMessage('La fecha debe estar en formato (AAAA-MM-DD)'),
		validateRequest,
	],
	asyncHandler(
		async (req, res, next) => {
			const resultado = await obtenerDetallePelicula(conexionDB, req.params['fecha']);

			return res.status(resultado.status).json(resultado.data);
		}
	)
);

app.post(
	'/reservas',
	[
		body('idFuncion').isNumeric().withMessage('El Id es numérico'),
		body('idButaca').isNumeric().withMessage('El Id es numérico'), ,
		body('dni').isString().withMessage('El DNI debe ser un strng'), ,
		validateRequest,
	],
	async (req, res, next) => {
		const resultado = await reservarButaca(conexionDB, req.body['idFuncion'], req.body['idButaca'], req.body['dni']);
		return res.status(resultado.status).json(resultado.data);
	}
);

app.get(
	'/funciones/:idFuncion/butacas-disponibles',
	[
		param('idPelicula').isNumeric().withMessage('El Id es numérico'),
		validateRequest,
	],
	async (req, res, next) => {
		const resultado = await obtenerButacasDisponibles(conexionDB, req.params['idFuncion']);
		return res.status(resultado.status).json(resultado.data);
	}
)