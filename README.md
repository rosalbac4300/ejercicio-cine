# Sala de Cine

## Creacion de la base de datos y procedimientos almacenados.

Configurar en el archivo `.env` la contraseña para el usuario `root`.

Este proyecto esta armado de tal manera, que al correr el comando `docker compose up`, la base de datos se cree,
junto con las tablas necesarias y procedimientos almacenados necesarios.

Tambien se arego un script de prueba para agregar datos para asi poder testear.

Si se desea ejecutar el cliente de MySQL, se debe utilizar el comando:

`docker exec -it db-mysql mysql -u root -p`

E ingresar la contraseña configurada en `.env`.

### Ejecutar procedimientos almacenados
Ingresando al cliente de MySQL, se pueden utilizar los procedimientos almacenados de la siguiente manera.

Primero seleccionamos la base de datos con `USE calendario-cine;`.

Luego corremos `CALL <nombre-sp> (...parametros);`

#### Los procedimientos almacenados son:
- SP_Listar_Peliculas (pFecha DATETIME): Retorna una lista de peliculas activas en cartelera segun la fecha.
- SP_Obtener_Pelicula (pIdPelicula INT): Retorna los detalles de una pelicula, y el horario de la proxima funcion en cartelera.
- SP_Reservar_Funcion (pIdFuncion, pIdButaca, pDNI): Reserva una butaca para una funcion.
- SP_Obtener_Butacas_Disponibles (pIdFuncon INT): Obtiene las butacas disponibles para una funcion.

## Levantar la API
El mismo comando `docker compose up` prepara la base de datos y expone el puerto 4000 para probar la API.

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