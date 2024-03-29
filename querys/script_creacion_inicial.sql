USE [GD2C2022]
GO

--CREACI�N DE SCHEMA--------------------------------
CREATE SCHEMA NOT_FOUND;
GO
--CREACION DE TABLAS

CREATE TABLE NOT_FOUND.MARCA(
MARCA_CODIGO int IDENTITY PRIMARY KEY,
MARCA_DESCRIPCION nvarchar(255),
);
GO

CREATE TABLE NOT_FOUND.CATEGORIA(
CATEGORIA_CODIGO int IDENTITY PRIMARY KEY,
CATEGORIA_DESCRIPCION nvarchar(255),
);
GO

CREATE TABLE NOT_FOUND.MATERIAL(
MATERIAL_CODIGO int IDENTITY PRIMARY KEY,
MATERIAL_DESCRIPCION nvarchar(50)
);
GO

CREATE TABLE NOT_FOUND.PRODUCTO(
PRODUCTO_CODIGO nvarchar(50),
PRODUCTO_NOMBRE nvarchar(50),
PRODUCTO_DESCRIPCION nvarchar(50),
PRODUCTO_MARCA int REFERENCES NOT_FOUND.MARCA NOT NULL,
PRODUCTO_CATEGORIA int REFERENCES NOT_FOUND.CATEGORIA NOT NULL,
PRODUCTO_MATERIAL int REFERENCES NOT_FOUND.MATERIAL NOT NULL
PRIMARY KEY (PRODUCTO_CODIGO)
);
GO

CREATE TABLE NOT_FOUND.TIPO_VARIANTE(
TIPO_VARIANTE_CODIGO int IDENTITY PRIMARY KEY,
TIPO_VARIANTE_DESCRIPCION nvarchar(50)
);
GO

CREATE TABLE NOT_FOUND.VARIANTE(
VARIANTE_CODIGO int IDENTITY PRIMARY KEY,
VARIANTE_TIPO int REFERENCES NOT_FOUND.TIPO_VARIANTE NOT NULL,
VARIANTE_DESCRIPCION nvarchar(50)
);
GO

CREATE TABLE NOT_FOUND.PRODUCTO_VARIANTE(
PRODUCTO_VARIANTE_CODIGO nvarchar(50),
PRODUCTO_VARIANTE_PRODUCTO nvarchar(50) REFERENCES NOT_FOUND.PRODUCTO NOT NULL,
PRODUCTO_VARIANTE_VARIANTE int REFERENCES NOT_FOUND.VARIANTE,
PRODUCTO_VARIANTE_PRECIO_VENTA decimal(18,2),
PRODUCTO_VARIANTE_PRECIO_COMPRA decimal(18,2)
PRIMARY KEY(PRODUCTO_VARIANTE_CODIGO)
);
GO

CREATE TABLE NOT_FOUND.PROVINCIA(
PROVINCIA_CODIGO int IDENTITY PRIMARY KEY,
PROVINCIA_DESCRIPCION nvarchar(255)
);
GO

CREATE TABLE NOT_FOUND.LOCALIDAD(
LOCALIDAD_CODIGO int IDENTITY PRIMARY KEY,
LOCALIDAD_DESCRIPCION nvarchar(255),
LOCALIDAD_PROVINCIA int REFERENCES NOT_FOUND.PROVINCIA NOT NULL,
LOCALIDAD_CODIGO_POSTAL decimal(18,0)
);
GO

CREATE TABLE NOT_FOUND.CLIENTE(
CLIENTE_CODIGO INT IDENTITY PRIMARY KEY,
CLIENTE_NOMBRE nvarchar(255),
CLIENTE_APELLIDO nvarchar(255),
CLIENTE_DNI decimal(18, 0),
CLIENTE_DIRECCION nvarchar(255),
CLIENTE_LOCALIDAD int REFERENCES NOT_FOUND.LOCALIDAD NOT NULL,
CLIENTE_TELEFONO decimal(18, 0),
CLIENTE_MAIL nvarchar(255),
CLIENTE_FECHA_NAC date
);
GO

CREATE TABLE NOT_FOUND.PROVEEDOR(
PROVEEDOR_CUIT nvarchar(50),
PROVEEDOR_RAZON_SOCIAL nvarchar(50),
PROVEEDOR_DOMICILIO nvarchar(50),
PROVEEDOR_MAIL nvarchar(50),
PROVEEDOR_LOCALIDAD int REFERENCES NOT_FOUND.LOCALIDAD NOT NULL,
PRIMARY KEY (PROVEEDOR_CUIT)
);
GO

CREATE TABLE NOT_FOUND.MEDIO_PAGO(
MEDIO_PAGO_CODIGO int IDENTITY PRIMARY KEY,
MEDIO_PAGO_DESCRIPCION nvarchar(255),
MEDIO_PAGO_COSTO decimal(18,2),
MEDIO_PAGO_DESCUENTO decimal(18,2) DEFAULT 0.10
);
GO

CREATE TABLE NOT_FOUND.COMPRA(
COMPRA_NUMERO decimal(19,0),
COMPRA_FECHA date,
COMPRA_PROVEEDOR nvarchar(50) REFERENCES NOT_FOUND.PROVEEDOR NOT NULL,
COMPRA_MEDIO_PAGO nvarchar(255),
COMPRA_TOTAL decimal(18, 2)
PRIMARY KEY (COMPRA_NUMERO)
);
GO

CREATE TABLE NOT_FOUND.CANAL(
CANAL_CODIGO int IDENTITY PRIMARY KEY,
CANAL_DESCRIPCION nvarchar(255),
CANAL_COSTO decimal(18, 2)
);
GO

CREATE TABLE NOT_FOUND.MEDIO_ENVIO(
MEDIO_ENVIO_CODIGO int IDENTITY PRIMARY KEY,
MEDIO_ENVIO_DESCRIPCION nvarchar(255)
);
GO

CREATE TABLE NOT_FOUND.ENVIO_LOCALIDAD(
ENVIO_LOCALIDAD_LOCALIDAD int REFERENCES NOT_FOUND.LOCALIDAD,
ENVIO_LOCALIDAD_MEDIO int REFERENCES NOT_FOUND.MEDIO_ENVIO,
ENVIO_LOCALIDAD_PRECIO decimal(18, 2)
PRIMARY KEY(ENVIO_LOCALIDAD_LOCALIDAD,ENVIO_LOCALIDAD_MEDIO)
);
GO

CREATE TABLE NOT_FOUND.DESCUENTO_COMPRA(
DESCUENTO_COMPRA_CODIGO decimal(19,0),
DESCUENTO_COMPRA_NUMERO decimal(19, 0) REFERENCES NOT_FOUND.COMPRA NOT NULL,
DESCUENTO_COMPRA_TIPO nvarchar(255),
DESCUENTO_COMPRA_VALOR decimal(18, 2)
PRIMARY KEY (DESCUENTO_COMPRA_CODIGO)
);
GO

CREATE TABLE NOT_FOUND.COMPRA_PRODUCTO(
COMPRA_PRODUCTO_CODIGO int IDENTITY PRIMARY KEY,
COMPRA_PRODUCTO_COMPRA decimal(19,0) REFERENCES NOT_FOUND.COMPRA,
COMPRA_PRODUCTO_PRODUCTO nvarchar(50) REFERENCES NOT_FOUND.PRODUCTO_VARIANTE,
COMPRA_PRODUCTO_CANTIDAD decimal(18, 0),
COMPRA_PRODUCTO_PRECIO decimal(18, 2)
);
GO

CREATE TABLE NOT_FOUND.VENTA(
VENTA_CODIGO decimal(19,0),
VENTA_FECHA date,
VENTA_CANAL int REFERENCES NOT_FOUND.CANAL NOT NULL,
VENTA_CANAL_COSTO decimal(18, 2),
VENTA_CLIENTE int REFERENCES NOT_FOUND.CLIENTE NOT NULL,
VENTA_MEDIO_PAGO int REFERENCES NOT_FOUND.MEDIO_PAGO NOT NULL,
VENTA_MEDIO_PAGO_COSTO decimal(18,2),
VENTA_MEDIO_ENVIO int REFERENCES NOT_FOUND.MEDIO_ENVIO NOT NULL,
VENTA_MEDIO_ENVIO_PRECIO decimal(18,2),
VENTA_TOTAL decimal(18,2)
PRIMARY KEY (VENTA_CODIGO)
);
GO

CREATE TABLE NOT_FOUND.VENTA_PRODUCTO(
VENTA_PRODUCTO_CODIGO int IDENTITY PRIMARY KEY,
VENTA_PRODUCTO_VENTA decimal(19,0) REFERENCES NOT_FOUND.VENTA,
VENTA_PRODUCTO_PRODUCTO nvarchar(50) REFERENCES NOT_FOUND.PRODUCTO_VARIANTE,
VENTA_PRODUCTO_CANTIDAD decimal(18, 0),
VENTA_PRODUCTO_PRECIO decimal(18, 2)
);
GO

CREATE TABLE NOT_FOUND.TIPO_DESCUENTO(
TIPO_DESCUENTO_CODIGO int IDENTITY PRIMARY KEY,
TIPO_DESCUENTO_DESCRIPCION nvarchar(255)
);
GO

CREATE TABLE NOT_FOUND.CUPON(
CUPON_CODIGO nvarchar(255),
CUPON_TIPO nvarchar(50),
CUPON_VALOR decimal(18,2),
CUPON_FECHA_DESDE date,
CUPON_FECHA_HASTA date
PRIMARY KEY (CUPON_CODIGO)
);
GO

CREATE TABLE NOT_FOUND.VENTA_CUPON(
VENTA_CUPON_VENTA decimal(19,0) REFERENCES NOT_FOUND.VENTA,
VENTA_CUPON_CUPON nvarchar(255) REFERENCES NOT_FOUND.CUPON,
VENTA_CUPON_IMPORTE decimal(18,2),
VENTA_CUPON_TIPO_DESCUENTO int REFERENCES NOT_FOUND.TIPO_DESCUENTO
PRIMARY KEY (VENTA_CUPON_VENTA,VENTA_CUPON_CUPON)
);
GO

CREATE TABLE NOT_FOUND.VENTA_DESCUENTO(
VENTA_DESCUENTO_CODIGO decimal(19,0) IDENTITY PRIMARY KEY,
VENTA_DESCUENTO_VENTA decimal(19,0) REFERENCES NOT_FOUND.VENTA NOT NULL,
VENTA_DESCUENTO_TIPO int REFERENCES NOT_FOUND.TIPO_DESCUENTO,
VENTA_DESCUENTO_IMPORTE decimal(18,2)
);
GO

--STORED PROCEDURES PARA LA MIGRACION

CREATE PROCEDURE NOT_FOUND.migrar_marcas
 AS
  BEGIN
    INSERT INTO NOT_FOUND.MARCA(MARCA_DESCRIPCION)
	SELECT DISTINCT PRODUCTO_MARCA
	FROM gd_esquema.Maestra
	WHERE PRODUCTO_MARCA IS NOT NULL
  END
GO

CREATE PROCEDURE NOT_FOUND.migrar_categorias
 AS
  BEGIN
    INSERT INTO NOT_FOUND.CATEGORIA(CATEGORIA_DESCRIPCION)
	SELECT DISTINCT PRODUCTO_CATEGORIA
	FROM gd_esquema.Maestra
	WHERE PRODUCTO_CATEGORIA IS NOT NULL
  END
GO

CREATE PROCEDURE NOT_FOUND.migrar_materiales
 AS
  BEGIN
    INSERT INTO NOT_FOUND.MATERIAL(MATERIAL_DESCRIPCION)
	SELECT DISTINCT PRODUCTO_MATERIAL
	FROM gd_esquema.Maestra
	WHERE PRODUCTO_MATERIAL IS NOT NULL
  END
GO

CREATE PROCEDURE NOT_FOUND.migrar_productos
 AS
  BEGIN
    INSERT INTO NOT_FOUND.PRODUCTO(PRODUCTO_CODIGO,PRODUCTO_NOMBRE,PRODUCTO_DESCRIPCION,PRODUCTO_MARCA,PRODUCTO_CATEGORIA,PRODUCTO_MATERIAL)
	SELECT DISTINCT PRODUCTO_CODIGO,PRODUCTO_NOMBRE,PRODUCTO_DESCRIPCION,MARCA_CODIGO,CATEGORIA_CODIGO,MATERIAL_CODIGO
	FROM gd_esquema.Maestra JOIN NOT_FOUND.MARCA ON PRODUCTO_MARCA = MARCA_DESCRIPCION 
						    JOIN NOT_FOUND.CATEGORIA ON PRODUCTO_CATEGORIA = CATEGORIA_DESCRIPCION
						    JOIN NOT_FOUND.MATERIAL ON PRODUCTO_MATERIAL = MATERIAL_DESCRIPCION
	WHERE PRODUCTO_CODIGO IS NOT NULL
  END
GO

CREATE PROCEDURE NOT_FOUND.migrar_tipos_variante
 AS
  BEGIN
    INSERT INTO NOT_FOUND.TIPO_VARIANTE(TIPO_VARIANTE_DESCRIPCION)
	SELECT DISTINCT PRODUCTO_TIPO_VARIANTE
	FROM gd_esquema.Maestra 

	WHERE PRODUCTO_TIPO_VARIANTE IS NOT NULL
  END
GO

CREATE PROCEDURE NOT_FOUND.migrar_variantes
 AS
  BEGIN
    INSERT INTO NOT_FOUND.VARIANTE(VARIANTE_TIPO,VARIANTE_DESCRIPCION)
	SELECT DISTINCT TIPO_VARIANTE_CODIGO,PRODUCTO_VARIANTE
	FROM gd_esquema.Maestra JOIN NOT_FOUND.TIPO_VARIANTE ON PRODUCTO_TIPO_VARIANTE = TIPO_VARIANTE_DESCRIPCION
	WHERE PRODUCTO_VARIANTE IS NOT NULL
  END
GO

CREATE PROCEDURE NOT_FOUND.migrar_provincias
 AS
  BEGIN
    INSERT INTO NOT_FOUND.PROVINCIA(PROVINCIA_DESCRIPCION)
	SELECT PROVEEDOR_PROVINCIA 
	FROM gd_esquema.Maestra 
	WHERE PROVEEDOR_PROVINCIA IS NOT NULL 
	UNION SELECT CLIENTE_PROVINCIA FROM gd_esquema.Maestra WHERE CLIENTE_PROVINCIA IS NOT NULL
  END
GO

CREATE PROCEDURE NOT_FOUND.migrar_localidad
 AS
  BEGIN
   INSERT INTO NOT_FOUND.LOCALIDAD(LOCALIDAD_DESCRIPCION,LOCALIDAD_PROVINCIA,LOCALIDAD_CODIGO_POSTAL)
   (SELECT PROVEEDOR_LOCALIDAD,PROVINCIA_CODIGO,PROVEEDOR_CODIGO_POSTAL
	FROM gd_esquema.Maestra JOIN NOT_FOUND.PROVINCIA ON PROVEEDOR_PROVINCIA = PROVINCIA_DESCRIPCION
	WHERE PROVEEDOR_LOCALIDAD IS NOT NULL)
	UNION (SELECT CLIENTE_LOCALIDAD,PROVINCIA_CODIGO,CLIENTE_CODIGO_POSTAL FROM gd_esquema.Maestra JOIN NOT_FOUND.PROVINCIA ON CLIENTE_PROVINCIA = PROVINCIA_DESCRIPCION WHERE CLIENTE_LOCALIDAD IS NOT NULL)
  END
GO

CREATE PROCEDURE NOT_FOUND.migrar_clientes
 AS
  BEGIN
   INSERT INTO NOT_FOUND.CLIENTE(CLIENTE_NOMBRE,CLIENTE_APELLIDO,CLIENTE_DNI,CLIENTE_DIRECCION,CLIENTE_LOCALIDAD,CLIENTE_TELEFONO,CLIENTE_MAIL,CLIENTE_FECHA_NAC)
   SELECT DISTINCT CLIENTE_NOMBRE,CLIENTE_APELLIDO,CLIENTE_DNI,CLIENTE_DIRECCION,LOCALIDAD_CODIGO,CLIENTE_TELEFONO,CLIENTE_MAIL,CLIENTE_FECHA_NAC
   FROM gd_esquema.Maestra JOIN NOT_FOUND.LOCALIDAD ON CLIENTE_LOCALIDAD = LOCALIDAD_DESCRIPCION AND CLIENTE_CODIGO_POSTAL = LOCALIDAD_CODIGO_POSTAL
   WHERE CLIENTE_NOMBRE IS NOT NULL
  END
GO

CREATE PROCEDURE NOT_FOUND.migrar_proveedores
 AS
  BEGIN
	INSERT INTO NOT_FOUND.PROVEEDOR(PROVEEDOR_CUIT,PROVEEDOR_RAZON_SOCIAL,PROVEEDOR_DOMICILIO,PROVEEDOR_MAIL,PROVEEDOR_LOCALIDAD)
	SELECT DISTINCT PROVEEDOR_CUIT,PROVEEDOR_RAZON_SOCIAL,PROVEEDOR_DOMICILIO,PROVEEDOR_MAIL,LOCALIDAD_CODIGO
	FROM gd_esquema.Maestra JOIN NOT_FOUND.LOCALIDAD ON PROVEEDOR_LOCALIDAD = LOCALIDAD_DESCRIPCION AND PROVEEDOR_CODIGO_POSTAL = LOCALIDAD_CODIGO_POSTAL
	WHERE PROVEEDOR_CUIT IS NOT NULL
  END
GO

CREATE PROCEDURE NOT_FOUND.migrar_medios_pago
 AS
  BEGIN
	INSERT INTO NOT_FOUND.MEDIO_PAGO(MEDIO_PAGO_DESCRIPCION,MEDIO_PAGO_COSTO)
	SELECT DISTINCT VENTA_MEDIO_PAGO, VENTA_MEDIO_PAGO_COSTO FROM gd_esquema.Maestra WHERE VENTA_MEDIO_PAGO IS NOT NULL
  END
GO

CREATE PROCEDURE NOT_FOUND.migrar_canales
 AS
  BEGIN
	INSERT INTO NOT_FOUND.CANAL(CANAL_DESCRIPCION,CANAL_COSTO)
	SELECT DISTINCT VENTA_CANAL,VENTA_CANAL_COSTO
	FROM gd_esquema.Maestra
	WHERE VENTA_CANAL IS NOT NULL
  END
GO

CREATE PROCEDURE NOT_FOUND.migrar_productos_variantes
 AS
  BEGIN
    INSERT INTO NOT_FOUND.PRODUCTO_VARIANTE(PRODUCTO_VARIANTE_CODIGO,PRODUCTO_VARIANTE_PRODUCTO,PRODUCTO_VARIANTE_VARIANTE,PRODUCTO_VARIANTE_PRECIO_VENTA,PRODUCTO_VARIANTE_PRECIO_COMPRA)
	SELECT DISTINCT PRODUCTO_VARIANTE_CODIGO,PRODUCTO_CODIGO,VARIANTE_CODIGO,
		(SELECT TOP 1 M2.VENTA_PRODUCTO_PRECIO FROM gd_esquema.Maestra M2 WHERE M2.PRODUCTO_VARIANTE_CODIGO = M1.PRODUCTO_VARIANTE_CODIGO ORDER BY M2.VENTA_FECHA DESC ),
		(SELECT TOP 1 M2.COMPRA_PRODUCTO_PRECIO FROM gd_esquema.Maestra M2 WHERE M2.PRODUCTO_VARIANTE_CODIGO = M1.PRODUCTO_VARIANTE_CODIGO ORDER BY M2.COMPRA_FECHA DESC )
	FROM gd_esquema.Maestra M1 JOIN NOT_FOUND.VARIANTE ON M1.PRODUCTO_VARIANTE = VARIANTE_DESCRIPCION
	WHERE M1.PRODUCTO_VARIANTE_CODIGO IS NOT NULL
  END
GO

CREATE PROCEDURE NOT_FOUND.migrar_cupones
 AS
  BEGIN
    INSERT INTO NOT_FOUND.CUPON(CUPON_CODIGO,CUPON_TIPO,CUPON_VALOR,CUPON_FECHA_DESDE,CUPON_FECHA_HASTA)
	SELECT DISTINCT VENTA_CUPON_CODIGO, VENTA_CUPON_TIPO, VENTA_CUPON_VALOR, VENTA_CUPON_FECHA_DESDE,VENTA_CUPON_FECHA_HASTA
	FROM gd_esquema.Maestra
	WHERE VENTA_CUPON_CODIGO IS NOT NULL 
  END
GO

CREATE PROCEDURE NOT_FOUND.migrar_medios_envio
 AS
  BEGIN
    INSERT INTO NOT_FOUND.MEDIO_ENVIO(MEDIO_ENVIO_DESCRIPCION)
	SELECT DISTINCT VENTA_MEDIO_ENVIO
	FROM gd_esquema.Maestra 
	WHERE VENTA_MEDIO_ENVIO IS NOT NULL
  END
GO

CREATE PROCEDURE NOT_FOUND.migrar_envio_localidad
 AS
  BEGIN
    INSERT INTO NOT_FOUND.ENVIO_LOCALIDAD(ENVIO_LOCALIDAD_LOCALIDAD,ENVIO_LOCALIDAD_MEDIO,ENVIO_LOCALIDAD_PRECIO)
	SELECT DISTINCT LOCALIDAD_CODIGO,MEDIO_ENVIO_CODIGO, VENTA_ENVIO_PRECIO
	FROM gd_esquema.Maestra M1 JOIN NOT_FOUND.LOCALIDAD ON M1.CLIENTE_LOCALIDAD = LOCALIDAD_DESCRIPCION AND M1.CLIENTE_CODIGO_POSTAL = LOCALIDAD_CODIGO_POSTAL
							   JOIN NOT_FOUND.MEDIO_ENVIO ON M1.VENTA_MEDIO_ENVIO = MEDIO_ENVIO_DESCRIPCION 
	WHERE M1.VENTA_MEDIO_ENVIO IS NOT NULL AND M1.VENTA_MEDIO_ENVIO <> 'Entrega en sucursal'
  END
GO

CREATE PROCEDURE NOT_FOUND.migrar_tipos_descuento
 AS
  BEGIN
    INSERT INTO NOT_FOUND.TIPO_DESCUENTO(TIPO_DESCUENTO_DESCRIPCION) VALUES ('Medio de pago')
	INSERT INTO NOT_FOUND.TIPO_DESCUENTO(TIPO_DESCUENTO_DESCRIPCION) VALUES ('Envio gratis')
	INSERT INTO NOT_FOUND.TIPO_DESCUENTO(TIPO_DESCUENTO_DESCRIPCION) VALUES ('Cupon')
	INSERT INTO NOT_FOUND.TIPO_DESCUENTO(TIPO_DESCUENTO_DESCRIPCION) VALUES ('Especial')
  END
GO

CREATE PROCEDURE NOT_FOUND.migrar_ventas
 AS
  BEGIN
    INSERT INTO NOT_FOUND.VENTA(VENTA_CODIGO,VENTA_FECHA,VENTA_CANAL,VENTA_CANAL_COSTO,VENTA_CLIENTE,VENTA_MEDIO_PAGO,VENTA_MEDIO_PAGO_COSTO,VENTA_MEDIO_ENVIO,VENTA_MEDIO_ENVIO_PRECIO,VENTA_TOTAL)
	SELECT DISTINCT VENTA_CODIGO, VENTA_FECHA,CANAL_CODIGO,VENTA_CANAL_COSTO,CLIENTE_CODIGO,MEDIO_PAGO_CODIGO,VENTA_MEDIO_PAGO_COSTO,MEDIO_ENVIO_CODIGO,VENTA_ENVIO_PRECIO,VENTA_TOTAL
	FROM gd_esquema.Maestra M JOIN NOT_FOUND.CANAL ON M.VENTA_CANAL = CANAL_DESCRIPCION 
	                          JOIN NOT_FOUND.CLIENTE C ON M.CLIENTE_DNI = C.CLIENTE_DNI AND M.CLIENTE_APELLIDO = C.CLIENTE_APELLIDO 
							  JOIN NOT_FOUND.MEDIO_PAGO ON M.VENTA_MEDIO_PAGO = MEDIO_PAGO_DESCRIPCION
							  JOIN NOT_FOUND.MEDIO_ENVIO ON M.VENTA_MEDIO_ENVIO = MEDIO_ENVIO_DESCRIPCION
	WHERE M.VENTA_CODIGO IS NOT NULL 
  END
GO

CREATE PROCEDURE NOT_FOUND.migrar_venta_cupon
 AS
  BEGIN
    INSERT INTO NOT_FOUND.VENTA_CUPON(VENTA_CUPON_VENTA,VENTA_CUPON_CUPON,VENTA_CUPON_IMPORTE, VENTA_CUPON_TIPO_DESCUENTO)
	SELECT DISTINCT VENTA_CODIGO, VENTA_CUPON_CODIGO, VENTA_CUPON_IMPORTE, (SELECT TIPO_DESCUENTO_CODIGO FROM NOT_FOUND.TIPO_DESCUENTO WHERE TIPO_DESCUENTO_DESCRIPCION = 'Cupon')
	FROM gd_esquema.Maestra				  
	WHERE VENTA_CUPON_CODIGO IS NOT NULL 
  END
GO

CREATE PROCEDURE NOT_FOUND.migrar_venta_producto
 AS
  BEGIN
    INSERT INTO NOT_FOUND.VENTA_PRODUCTO(VENTA_PRODUCTO_VENTA,VENTA_PRODUCTO_PRODUCTO,VENTA_PRODUCTO_CANTIDAD,VENTA_PRODUCTO_PRECIO)
	SELECT VENTA_CODIGO, PRODUCTO_VARIANTE_CODIGO, SUM(VENTA_PRODUCTO_CANTIDAD),VENTA_PRODUCTO_PRECIO 
	FROM gd_esquema.Maestra				  
	WHERE VENTA_PRODUCTO_CANTIDAD IS NOT NULL 
	GROUP BY VENTA_CODIGO,PRODUCTO_VARIANTE_CODIGO,VENTA_PRODUCTO_PRECIO,VENTA_PRODUCTO_CANTIDAD
  END
GO

CREATE PROCEDURE NOT_FOUND.migrar_venta_descuento
 AS
  BEGIN
    INSERT INTO NOT_FOUND.VENTA_DESCUENTO(VENTA_DESCUENTO_VENTA,VENTA_DESCUENTO_TIPO,VENTA_DESCUENTO_IMPORTE)
	(SELECT VENTA_CODIGO, TIPO_DESCUENTO_CODIGO, VENTA_DESCUENTO_IMPORTE 
	FROM gd_esquema.Maestra, NOT_FOUND.TIPO_DESCUENTO 
	WHERE VENTA_DESCUENTO_CONCEPTO IS NOT NULL and ((VENTA_DESCUENTO_CONCEPTO = 'Transferencia'	and TIPO_DESCUENTO_DESCRIPCION = 'Medio de pago') or (VENTA_DESCUENTO_CONCEPTO = 'Efectivo' and TIPO_DESCUENTO_DESCRIPCION = 'Medio de pago') or (VENTA_DESCUENTO_CONCEPTO = 'Otros' and TIPO_DESCUENTO_DESCRIPCION = 'Especial')))
  END
GO


CREATE PROCEDURE NOT_FOUND.migrar_compras
 AS
  BEGIN
    INSERT INTO NOT_FOUND.COMPRA(COMPRA_NUMERO,COMPRA_FECHA,COMPRA_PROVEEDOR,COMPRA_MEDIO_PAGO,COMPRA_TOTAL)
	SELECT DISTINCT COMPRA_NUMERO, COMPRA_FECHA,PROVEEDOR_CUIT,COMPRA_MEDIO_PAGO,COMPRA_TOTAL
	FROM gd_esquema.Maestra M 
	WHERE COMPRA_NUMERO IS NOT NULL 
  END
GO

CREATE PROCEDURE NOT_FOUND.migrar_compra_producto
 AS
  BEGIN
    INSERT INTO NOT_FOUND.COMPRA_PRODUCTO(COMPRA_PRODUCTO_COMPRA,COMPRA_PRODUCTO_PRODUCTO,COMPRA_PRODUCTO_CANTIDAD,COMPRA_PRODUCTO_PRECIO)
	SELECT COMPRA_NUMERO,PRODUCTO_VARIANTE_CODIGO, SUM(COMPRA_PRODUCTO_CANTIDAD),COMPRA_PRODUCTO_PRECIO from gd_esquema.Maestra 
    WHERE COMPRA_PRODUCTO_CANTIDAD IS NOT NULL
	GROUP BY COMPRA_NUMERO,PRODUCTO_VARIANTE_CODIGO, COMPRA_PRODUCTO_CANTIDAD,COMPRA_PRODUCTO_PRECIO 
   
  END
GO
	
   
CREATE PROCEDURE NOT_FOUND.migrar_compra_descuento
 AS
  BEGIN
    INSERT INTO NOT_FOUND.DESCUENTO_COMPRA(DESCUENTO_COMPRA_CODIGO,DESCUENTO_COMPRA_NUMERO,DESCUENTO_COMPRA_VALOR)
	SELECT DESCUENTO_COMPRA_CODIGO,COMPRA_NUMERO,DESCUENTO_COMPRA_VALOR
	FROM gd_esquema.Maestra
	WHERE DESCUENTO_COMPRA_CODIGO IS NOT NULL 
  END
GO


CREATE PROCEDURE NOT_FOUND.ejecutar_procedures AS
BEGIN 
	
	BEGIN TRANSACTION
	execute NOT_FOUND.migrar_categorias
	execute NOT_FOUND.migrar_marcas
	execute NOT_FOUND.migrar_materiales
	execute NOT_FOUND.migrar_productos
	execute NOT_FOUND.migrar_tipos_variante
	execute NOT_FOUND.migrar_variantes
	execute NOT_FOUND.migrar_productos_variantes
	execute NOT_FOUND.migrar_provincias
	execute NOT_FOUND.migrar_localidad
	execute NOT_FOUND.migrar_clientes
	execute NOT_FOUND.migrar_proveedores
	execute NOT_FOUND.migrar_medios_pago
	execute NOT_FOUND.migrar_compras
	execute NOT_FOUND.migrar_canales
	execute NOT_FOUND.migrar_medios_envio
	execute NOT_FOUND.migrar_envio_localidad
	execute NOT_FOUND.migrar_compra_descuento
	execute NOT_FOUND.migrar_compra_producto
	execute NOT_FOUND.migrar_ventas
	execute NOT_FOUND.migrar_venta_producto
	execute NOT_FOUND.migrar_tipos_descuento
	execute NOT_FOUND.migrar_cupones
	execute NOT_FOUND.migrar_venta_cupon
	execute NOT_FOUND.migrar_venta_descuento

	COMMIT TRANSACTION

END
GO

execute NOT_FOUND.ejecutar_procedures
GO