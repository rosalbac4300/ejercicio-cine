import fs from 'fs';
import mysql from 'mysql2/promise';

export async function connectarseConReintento() {
	while (true) {
		try {
			const connection = await mysql.createConnection({
				host: 'db',
				user: 'root',
				password: process.env.MYSQL_ROOT_PASSWORD || '',
				database: 'calendario-cine',
				multipleStatements: true,
			});

			console.log('Conectado a la Base de Datos MySQL');
			return connection;

		} catch (err) {
			console.error('La DB not esta lista, reintentando en 3 segundos...');
			await new Promise(res => setTimeout(res, 3000));
		}
	}
}
