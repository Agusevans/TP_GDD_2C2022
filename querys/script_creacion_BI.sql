USE [GD2C2022]
GO

--CREACION DE TABLAS---- 
CREATE TABLE NOT_FOUND.BI_DIMENSION_TIEMPO(
	TIEMPO_ID INT IDENTITY PRIMARY KEY,
	A�O INT,
	MES INT
)
GO

/* Dimensiones minimas:
 Tiempo (a�o, mes)
 Provincia
 Rango etario cliente
	o <25
	o 25 - 35
	o 35 � 55
	o >55
 Canal de venta
 Medio de pago
 Categor�a de producto
 Producto
 Tipo de descuento
 Tipo de env�o */

CREATE TABLE NOT_FOUND.BI_HECHOS_VENTAS_CANAL(
	----
)
GO

------------------------


--CREACION DE VISTAS----
CREATE VIEW NOT_FOUND.BI_GANANCIAS_MES_CANAL AS
	----
GO


------------------------


--PROCEDURES MIGRACION TRANSACCIONAL A DIMENSIONAL------


--------------------------------------------------------