export class HttpException extends Error {
	status; // Numero
	error; // Objeto

	constructor(status, message) {
		super(message);
		this.status = status;
		this.error = { message }
	}
}

export class BadRequest extends HttpException {
	constructor(message) {
		super(400, message);
	}
}

export class Unauthorized extends HttpException {
	constructor(message) {
		super(401, message);
	}
}

export class Forbidden extends HttpException {
	constructor(message) {
		super(403, message);
	}
}

export class NotFound extends HttpException {
	constructor(message) {
		super(404, message);
	}
}

export class TooManyRequests extends HttpException {
	constructor(message) {
		super(429, message);
	}
}

function errorMiddleware(error, _request, response, _next) {
	response.status(error.status ? error.status : 500).json({ error: error.message });
}

export default errorMiddleware;
