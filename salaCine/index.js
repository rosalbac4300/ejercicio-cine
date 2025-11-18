import express, { json } from 'express';
import cors from 'cors';
import mysql from 'mysql2/promise';

import errorMiddleware from './error-middleware.js';

console.log('Starting salaCine service... ');

async function connectWithRetry() {
	while (true) {
		try {
			const connection = await mysql.createConnection({
				host: 'db',
				user: 'root',
				password: process.env.MYSQL_ROOT_PASSWORD || '',
				database: 'calendario-cine'
			});

			console.log('Connected to the MySQL database.');
			return connection;

		} catch (err) {
			console.error('DB not ready yet, retrying in 3 seconds...');
			await new Promise(res => setTimeout(res, 3000));
		}
	}
}

const dbConnection = await connectWithRetry();

const port = 4000;

const app = express();
app.use(cors());
app.use(json());
app.use(errorMiddleware);

const server = app.listen(port, () => {
	console.log(`Listening on port ${port}`);
});

// Agregar las rutas
