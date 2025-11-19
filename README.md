# Sala de Cine
Creacion de la base de datos y procedimientos almacenados.

## Configutación Inicial
1. Configurar en el archivo `.env` la contraseña para el usuario `root`.
2. Ejecutar `docker compose up`.

Este comando crea la base de datos, las tablas necesarias, y los procedimientos almacenados. Tambien agrega datos de prueba para facilitar el testing.

## Acceder al cliente MYSQL

Para ingresar al cliente desde el contenedor::

`docker exec -it db-mysql mysql -u root -p`

E ingresar la contraseña configurada en `.env`.

### Ejecutar procedimientos almacenados
Dentro del Cliente MySQL se debe ejecutar:
1. `USE calendario-cine;` para seleccionar la base de datos.
2. Ejecutar `CALL <nombre-sp> (...parametros);`

#### Lista de procedimientos almacenados son:
- SP_Listar_Peliculas (pFecha DATETIME): Retorna una lista de peliculas activas en cartelera segun la fecha.
- SP_Obtener_Pelicula (pIdPelicula INT): Retorna los detalles de una pelicula, y el horario de la proxima funcion en cartelera.
- SP_Reservar_Funcion (pIdFuncion, pIdButaca, pDNI): Reserva una butaca para una funcion.
- SP_Obtener_Butacas_Disponibles (pIdFuncon INT): Obtiene las butacas disponibles para una funcion.

## Levantar la API
El mismo comando `docker compose up` prepara la base de datos y expone el puerto 4000 para utilizar la API.

La documentacion de las api se encuentra detallada en el archivo `api-doc.yaml`.

Ejemplo de llamada con curl para obtener el detalle de una pelicula:

```
curl --request GET \
  --url http://localhost:4000/peliculas/detalle/10
```

Ejemplo de llamada con curl para reservar una funcion:

```
curl --request POST \
  --url http://localhost:4000/reservas \
  --header 'content-type: application/json' \
  --data '{
  "dni": "11111111",
  "idFuncion": 8,
  "idButaca": 23
}'
```