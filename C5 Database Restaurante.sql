USE MASTER
go

DROP DATABASE if exists  C5_DB_RESTAURANTE
GO

CREATE DATABASE C5_DB_RESTAURANTE
GO

USE C5_DB_RESTAURANTE
GO

CREATE TABLE tb_tipo_usuario(
id_tipo_usuario int IDENTITY(1,1) PRIMARY KEY,
des_tipo_usuario varchar(100) NOT NULL
)
go

CREATE TABLE tb_tipo_colaborador(
id_tipo_colaborador int IDENTITY(1,1) PRIMARY KEY,
des_tipo_colaborador varchar(100) NOT NULL
)
go

CREATE TABLE tb_distrito (
id_distrito int IDENTITY(1,1) PRIMARY KEY,
des_distrito varchar(100) NOT NULL
)
go

CREATE TABLE tb_mediopago(
id_medio_pago int IDENTITY(1,1) PRIMARY KEY,
des_medio_pago varchar(100) NOT NULL
)
go

CREATE TABLE tb_categoria_producto(
id_categoria_producto int IDENTITY(1,1) PRIMARY KEY,
des_categoria_producto varchar(100) NOT NULL
)
go

CREATE TABLE tb_usuario(
id_usuario int IDENTITY(1,1) PRIMARY KEY,
id_tipo_usuario int NOT NULL ,
cod_usuario varchar(100) NOT NULL,
nom_usuario varchar(100) NOT NULL,
ape_usuario varchar(100) NOT NULL,
tel_usuario char(12),
cel_usuario char(12) NOT NULL,
id_distrito int NOT NULL ,
dir_usuario varchar(100) NOT NULL,
dni_usuario char(8) NOT NULL,
email_usuario varchar(100) NOT NULL,
password_usuario varchar(100) NOT NULL,
imagen_usuario varbinary(max),
fechaReg_usuario datetime NOT NULL,
fechaAct_usuario datetime NULL,
estado_usuario varchar(100) NOT NULL,
FOREIGN KEY (id_tipo_usuario) REFERENCES tb_tipo_usuario(id_tipo_usuario),
FOREIGN KEY (id_distrito) REFERENCES tb_distrito(id_distrito)
)
go

CREATE TABLE tb_colaborador(
id_colaborador int IDENTITY(1,1) PRIMARY KEY,
id_tipo_colaborador int,
nom_colaborador varchar(100) NOT NULL,
ape_colaborador varchar(100) NOT NULL,
dni_colaborador char(8) NOT NULL,
imagen_colaborador varbinary(max),
fechaReg_colaborador datetime NOT NULL,
fechaAct_colaborador datetime NULL,
estado_colaborador varchar(100) NOT NULL,
FOREIGN KEY (id_tipo_colaborador) REFERENCES tb_tipo_colaborador (id_tipo_colaborador)
)
go

CREATE TABLE tb_direntrega_usuario(
id_usuario int NOT NULL,
id_direntrega int IDENTITY(1,1),
id_distrito int,
nombre_direntrega varchar(100) null,
des_direntrega varchar(100) not null,
detalle_direntrega varchar(100) null,
fechareg_direntrega datetime NOT NULL,
estado_direntrega varchar(100) NOT NULL,

PRIMARY KEY (id_direntrega, id_usuario),
INDEX idx_id_usuario (id_usuario),  
FOREIGN KEY (id_usuario) REFERENCES tb_usuario (id_usuario),
FOREIGN KEY (id_distrito) REFERENCES tb_distrito(id_distrito)
)
go

CREATE TABLE tb_pedido(
id_pedido int IDENTITY(1,1) PRIMARY KEY,
id_usuario_cliente int NOT NULL,   
id_direntrega int,        
id_colaborador_repartidor int NULL,
tiempoentrega_pedido time NOT NULL,
fechareg_pedido datetime NOT NULL,
fechaact_pedido datetime NULL,    
estado_pedido varchar (100) NOT NULL,

FOREIGN KEY (id_usuario_cliente) REFERENCES tb_usuario (id_usuario), 
FOREIGN KEY (id_colaborador_repartidor) REFERENCES tb_colaborador (id_colaborador),
FOREIGN KEY (id_direntrega, id_usuario_cliente)  REFERENCES tb_direntrega_usuario (id_direntrega, id_usuario)
)
go

CREATE TABLE tb_producto (
id_producto int IDENTITY(1,1) PRIMARY KEY,
id_categoria_producto int NOT NULL,
nom_producto varchar(100) NOT NULL,
des_producto varchar(500),
preciouni_producto money NOT NULL,
stock_producto int NOT NULL,
imagen_producto varbinary(max) NULL,
estado_producto varchar(100) NOT NULL,

FOREIGN KEY (id_categoria_producto) REFERENCES tb_categoria_producto (id_categoria_producto)
)
go

CREATE TABLE  tb_producto_pedido (
id_pedido int NOT NULL,
id_producto_pedido int IDENTITY(1,1) NOT NULL,
id_producto  int NOT NULL,
cantidad_producto int not null,

PRIMARY KEY(id_producto_pedido, id_pedido),
FOREIGN KEY (id_pedido) REFERENCES tb_pedido (id_pedido),
FOREIGN KEY (id_producto) REFERENCES tb_producto (id_producto)
)
go

CREATE TABLE tb_seguimiento_pedido(
id_pedido int NOT NULL,
id_seguimiento_pedido int IDENTITY(1,1),
fechareg_seguimiento_pedido datetime NOT NULL,
estado_seguimmiento_pedido varchar(100) NOT NULL,

PRIMARY KEY (id_seguimiento_pedido,id_pedido),
FOREIGN KEY (id_pedido) REFERENCES tb_pedido(id_pedido)
)
go

create table tb_tarjeta(
	id_tarjeta int identity(1,1) PRIMARY KEY,
	id_usuario int not null ,
	numero_tarjeta varchar(16) not null,
    cvv_tarjeta varchar(3) not null,
	fecha_tarjeta varchar(100) not null,
	nombre_tarjeta varchar(100) not null,
    fechareg_tarjeta datetime not null,
    estado_tarjeta varchar(100) not null,
    foreign key (id_usuario) references tb_usuario (id_usuario)
)
go

CREATE TABLE tb_compra (
id_compra int IDENTITY(1,1) PRIMARY KEY,
id_pedido int NOT NULL UNIQUE,
id_medio_pago int NOT NULL,
id_tarjeta INT NULL,
monto_compra money NOT NULL,
fechareg_compra datetime NOT NULL,
estado_compra varchar(100) NOT NULL,

FOREIGN KEY (id_pedido) REFERENCES tb_pedido(id_pedido),
FOREIGN KEY (id_medio_pago) REFERENCES tb_mediopago(id_medio_pago),
FOREIGN KEY (id_tarjeta) REFERENCES tb_tarjeta(id_tarjeta)
)
go

CREATE TABLE tb_comentario (
id_comentario int IDENTITY(1,1) PRIMARY KEY,
id_usuario_cliente int NOT NULL,
des_comentario varchar(500) NOT NULL,
cantestrella_comentario int NOT NULL,
fechareg_comentario datetime NOT NULL,
estado_comentario varchar(100) NOT NULL,

FOREIGN KEY (id_usuario_cliente) REFERENCES tb_usuario (id_usuario)
)
go




-- Insertar datos en tb_tipo_usuario
INSERT INTO tb_tipo_usuario (des_tipo_usuario)
VALUES ('Admin'), ('Cliente'), ('Repartidor'), ('Colaborador'), ('Invitado');

-- Insertar datos en tb_tipo_colaborador
INSERT INTO tb_tipo_colaborador (des_tipo_colaborador)
VALUES ('Cocinero'), ('Repartidor'), ('Limpieza'), ('Atención al cliente'), ('Encargado');

-- Insertar datos en tb_distrito
INSERT INTO tb_distrito (des_distrito)
VALUES ('Miraflores'), ('San Isidro'), ('Barranco'), ('Surco'), ('Magdalena');

-- Insertar datos en tb_mediopago
INSERT INTO tb_mediopago (des_medio_pago)
VALUES ('Visa'), ('MasterCard'), ('American Express'), ('Paypal'), ('Yape');

-- Insertar datos en tb_categoria_producto
INSERT INTO tb_categoria_producto (des_categoria_producto)
VALUES ('Bebidas'), ('Entradas'), ('Platos principales'), ('Postres'), ('Extras');

-- Insertar datos en tb_usuario
INSERT INTO tb_usuario (id_tipo_usuario, cod_usuario, nom_usuario, ape_usuario, tel_usuario, cel_usuario, id_distrito, dir_usuario, dni_usuario, email_usuario, password_usuario, imagen_usuario, fechaReg_usuario, fechaAct_usuario, estado_usuario)
VALUES (2, 'USER001', 'Juan', 'Perez', '01-1234567', '987654321', 1, 'Av. Los Pinos 123', '12345678', 'juan.perez@example.com', '12345678', NULL, GETDATE(), GETDATE(), 'Activo'),
       (2, 'USER002', 'Maria', 'Lopez', '01-2345678', '987654322', 2, 'Calle Flores 456', '23456789', 'maria.lopez@example.com', '23456789', NULL, GETDATE(), GETDATE(), 'Activo'),
       (2, 'USER003', 'Pedro', 'Gomez', '01-3456789', '987654323', 3, 'Jr. San Martin 789', '34567890', 'pedro.gomez@example.com', '34567890', NULL, GETDATE(), GETDATE(), 'Activo'),
       (2, 'USER004', 'Ana', 'Ramirez', '01-4567890', '987654324', 4, 'Av. Los Alamos 101', '45678901', 'ana.ramirez@example.com', '45678901', NULL, GETDATE(), GETDATE(), 'Activo'),
       (2, 'USER005', 'Carlos', 'Garcia', '01-5678901', '987654325', 5, 'Calle Los Pajaritos 789', '56789012', 'carlos.garcia@example.com', '56789012', NULL, GETDATE(), GETDATE(), 'Activo');

-- Insertar datos en tb_colaborador
INSERT INTO tb_colaborador (id_tipo_colaborador, nom_colaborador, ape_colaborador, dni_colaborador, imagen_colaborador, fechaReg_colaborador, fechaAct_colaborador, estado_colaborador)
VALUES (1, 'Luis', 'Martinez', '11111111', NULL, GETDATE(), GETDATE(), 'Activo'),
       (2, 'Rosa', 'Castillo', '22222222', NULL, GETDATE(), GETDATE(), 'Activo'),
       (3, 'Carlos', 'Vargas', '33333333', NULL, GETDATE(), GETDATE(), 'Activo'),
       (4, 'Elena', 'Lopez', '44444444', NULL, GETDATE(), GETDATE(), 'Activo'),
       (5, 'Mario', 'Gomez', '55555555', NULL, GETDATE(), GETDATE(), 'Activo');

-- Insertar datos en tb_direntrega_usuario
INSERT INTO tb_direntrega_usuario (id_usuario, id_distrito, nombre_direntrega, des_direntrega, detalle_direntrega, fechareg_direntrega, estado_direntrega)
VALUES (1, 1, 'Oficina', 'Av. Los Pinos 123', 'Departamento 201', GETDATE(), 'Activo'),
       (2, 2, 'Casa', 'Calle Flores 456', 'Puerta Marron', GETDATE(), 'Activo'),
       (3, 3, 'Casa', 'Jr. San Martin 789', 'Ref. Jr. Montenegro', GETDATE(), 'Activo'),
       (4, 4, 'Torre 1', 'Av. Los Alamos 101', 'Dejar en seguridad', GETDATE(), 'Activo'),
       (5, 5, 'Depa Surco', 'Calle Los Pajaritos 789', 'Llamar al llegar', GETDATE(), 'Activo');

-- Insertar datos en tb_tarjeta
INSERT INTO tb_tarjeta (id_usuario, numero_tarjeta, cvv_tarjeta, fecha_tarjeta, nombre_tarjeta, fechareg_tarjeta, estado_tarjeta)
VALUES (1, '1111222233334444', '123', '2023-12', 'Juan Perez', GETDATE(), 'Activo'),
       (2, '4444333322221111', '456', '2024-05', 'Maria Lopez', GETDATE(), 'Activo'),
       (3, '7777666655554444', '789', '2025-10', 'Pedro Gomez', GETDATE(), 'Activo'),
       (4, '9999888877776666', '987', '2026-01', 'Ana Ramirez', GETDATE(), 'Activo'),
       (5, '1234123412341234', '234', '2027-06', 'Carlos Garcia', GETDATE(), 'Activo');

-- Insertar datos en tb_pedido
INSERT INTO tb_pedido (id_usuario_cliente, id_direntrega, id_colaborador_repartidor, tiempoentrega_pedido, fechareg_pedido, fechaact_pedido, estado_pedido)
VALUES (1, 1, 1, '12:00:00', GETDATE(), GETDATE(), 'Pendiente'),
       (2, 2, 2, '13:30:00', GETDATE(), GETDATE(), 'Entregado'),
       (3, 3, 3, '14:45:00', GETDATE(), GETDATE(), 'En camino'),
       (4, 4, 4, '16:00:00', GETDATE(), GETDATE(), 'Pendiente'),
       (5, 5, 5, '17:30:00', GETDATE(), GETDATE(), 'En camino');

-- Insertar datos en tb_producto
INSERT INTO tb_producto (id_categoria_producto, nom_producto, des_producto, preciouni_producto, stock_producto, imagen_producto, estado_producto)
VALUES (1, 'Gaseosa', 'Bebida gasificada de varios sabores.', 5.50, 100, NULL, 'Activo'),
       (2, 'Papas Fritas', 'Entrada de papas fritas con salsa.', 8.00, 50, NULL, 'Activo'),
       (3, 'Pollo a la Brasa', 'Pollo asado con acompañamiento.', 18.50, 30, NULL, 'Activo'),
       (4, 'Torta de Chocolate', 'Postre de chocolate con relleno.', 12.00, 20, NULL, 'Activo'),
       (5, 'Salsas Extras', 'Salsas adicionales para acompañar.', 2.50, 100, NULL, 'Activo');

-- Insertar datos en tb_producto_pedido
INSERT INTO tb_producto_pedido (id_pedido, id_producto, cantidad_producto)
VALUES (1, 1, 2),
       (1, 3, 1),
       (2, 2, 3),
       (3, 3, 2),
       (4, 4, 1);

-- Insertar datos en tb_seguimiento_pedido
INSERT INTO tb_seguimiento_pedido (id_pedido, fechareg_seguimiento_pedido, estado_seguimmiento_pedido)
VALUES (1, GETDATE(), 'En camino'),
       (2, GETDATE(), 'Entregado'),
       (3, GETDATE(), 'En camino'),
       (4, GETDATE(), 'Pendiente'),
       (5, GETDATE(), 'En camino');

-- Insertar datos en tb_compra
INSERT INTO tb_compra (id_pedido, id_medio_pago, monto_compra, fechareg_compra, estado_compra)
VALUES (1, 1, 25.00, GETDATE(), 'Exitosa'),
       (2, 2, 24.00, GETDATE(), 'Exitosa'),
       (3, 3, 28.50, GETDATE(), 'Exitosa'),
       (4, 4, 18.50, GETDATE(), 'Exitosa'),
       (5, 5, 20.00, GETDATE(), 'Exitosa');

-- Insertar datos en tb_comentario
INSERT INTO tb_comentario (id_usuario_cliente, des_comentario, cantestrella_comentario, fechareg_comentario, estado_comentario)
VALUES (1, 'Muy buena atención, el pollo a la brasa estaba delicioso.', 5, GETDATE(), 'Activo'),
       (2, 'Las papas fritas estaban un poco frías, pero el resto bien.', 4, GETDATE(), 'Activo'),
       (3, 'Pedí una gaseosa y llegó caliente.', 2, GETDATE(), 'Activo'),
       (4, 'La torta de chocolate estaba increíble.', 5, GETDATE(), 'Activo'),
       (5, 'Las salsas extras no fueron incluidas en el pedido.', 3, GETDATE(), 'Activo');
GO


-- STORE PROCEDURES ============================================================================================================
-- ================ PRODUCTO ========================
CREATE OR ALTER PROC SP_LISTARPRODUCTO
AS
BEGIN 
	SELECT * FROM tb_producto WHERE estado_producto = 'ACTIVO'
END
GO
-- INSERT
CREATE OR ALTER PROC SP_INSERTPRODUCTO
@id_categoria_producto INT,
@nom_producto VARCHAR(150),
@des_producto VARCHAR(150),
@preciouni_producto MONEY,
@stock_producto INT
AS
BEGIN
	INSERT INTO tb_producto(id_categoria_producto, nom_producto, des_producto, preciouni_producto, stock_producto, imagen_producto, estado_producto)
	VALUES (@id_categoria_producto, @nom_producto, @des_producto, @preciouni_producto, @stock_producto, NULL, 'Activo')
END
GO
-- UPDATE
CREATE OR ALTER PROC SP_UPDATEPRODUCTO
@id_producto INT,
@id_categoria_producto INT,
@nom_producto VARCHAR(150),
@des_producto VARCHAR(150),
@preciouni_producto MONEY,
@stock_producto INT
AS
BEGIN
	UPDATE tb_producto SET id_categoria_producto = @id_categoria_producto, nom_producto = @nom_producto, des_producto = @des_producto,
	preciouni_producto = @preciouni_producto, stock_producto = @stock_producto WHERE id_producto = @id_producto
END
GO
-- DELETE
CREATE OR ALTER PROC SP_DELETEPRODUCTO
@id_producto INT
AS
BEGIN
	UPDATE tb_producto SET estado_producto = 'Inactivo' WHERE id_producto = @id_producto
END
GO

-- ================ DIRECCION ========================
CREATE OR ALTER PROC SP_GETDIRECCION
@ID_USUARIO INT
AS
BEGIN 
	SELECT * FROM tb_direntrega_usuario WHERE id_usuario = @ID_USUARIO AND estado_direntrega = 'Activo'
END
GO
-- INSERT
CREATE OR ALTER PROC SP_INSERTDIRECCION
@ID_USUARIO INT, @ID_DISTRITO INT, @NOMBRE VARCHAR(100), @DESCRIPCION VARCHAR(100), @DETALLE VARCHAR(100)
AS
	INSERT INTO tb_direntrega_usuario (id_usuario, id_distrito, nombre_direntrega, des_direntrega, detalle_direntrega, fechareg_direntrega, estado_direntrega)
	VALUES (@ID_USUARIO, @ID_DISTRITO, @NOMBRE, @DESCRIPCION, @DETALLE, GETDATE(), 'Activo')
GO
-- UPDATE
CREATE OR ALTER PROC SP_UPDATEDIRECCION
@ID_DIRECCION INT, @ID_DISTRITO INT, @NOMBRE VARCHAR(100), @DESCRIPCION VARCHAR(100), @DETALLE VARCHAR(100)
AS
	UPDATE tb_direntrega_usuario SET id_distrito = @ID_DISTRITO, nombre_direntrega = @NOMBRE,
	des_direntrega = @DESCRIPCION, detalle_direntrega = @DETALLE
	WHERE id_direntrega = @ID_DIRECCION
GO
-- DELETE
CREATE OR ALTER PROC SP_DELETEDIRECCION
@ID_DIRECCION INT
AS
	UPDATE tb_direntrega_usuario SET estado_direntrega = 'Innactivo'
	WHERE id_direntrega = @ID_DIRECCION
GO

-- ================ DIRECCION ========================
CREATE OR ALTER PROC SP_GETTARJETA
@ID_USUARIO INT
AS
BEGIN 
	SELECT * FROM tb_tarjeta WHERE id_usuario = @ID_USUARIO AND estado_tarjeta = 'Activo'
END
GO
-- INSERT
CREATE OR ALTER PROC SP_INSERTTARJETA
@ID_USUARIO INT, @NUMERO VARCHAR(16), @CVV VARCHAR(3), @FECHA VARCHAR(100), @NOMBRE VARCHAR(100)
AS
	INSERT INTO tb_tarjeta (id_usuario, numero_tarjeta, cvv_tarjeta, fecha_tarjeta,
	nombre_tarjeta, fechareg_tarjeta, estado_tarjeta)
	VALUES (@ID_USUARIO, @NUMERO, @CVV, @FECHA, @NOMBRE, GETDATE(), 'Activo')
GO
-- UPDATE
CREATE OR ALTER PROC SP_UPDATETARJETA
@ID_TARJETA INT, @NUMERO VARCHAR(16), @CVV VARCHAR(3), @FECHA VARCHAR(100), @NOMBRE VARCHAR(100)
AS
	UPDATE tb_tarjeta SET numero_tarjeta = @NUMERO, cvv_tarjeta = @CVV,
	fecha_tarjeta = @FECHA, nombre_tarjeta = @NOMBRE
	WHERE id_tarjeta = @ID_TARJETA
GO
-- DELETE
CREATE OR ALTER PROC SP_DELETETARJETA
@ID_TARJETA INT
AS
	UPDATE tb_tarjeta SET estado_tarjeta = 'Innactivo'
	WHERE id_tarjeta = @ID_TARJETA
GO








SELECT * FROM tb_tarjeta
GO




-- ================ usp_listadoEcommer ========================
CREATE OR ALTER PROC usp_listadoEcommer
AS
Select p.id_producto,p.nom_producto,p.des_producto,cp.des_categoria_producto,
p.preciouni_producto,p.stock_producto
from tb_producto p inner join tb_categoria_producto cp
on p.id_categoria_producto=cp.id_categoria_producto
GO
-- EXEC usp_listadoEcommer


-- ================ T-SQL CREATE PEDIDO ========================
CREATE OR ALTER PROC SP_INSERTPEDIDO
@id_usuario_cliente INT, @id_direntrega INT
AS
	INSERT INTO tb_pedido(ID_USUARIO_CLIENTE, ID_DIRENTREGA, tiempoentrega_pedido, fechareg_pedido, estado_pedido)
	VALUES (@id_usuario_cliente, @id_direntrega, '00:45', GETDATE(), 'Pendiente')
GO
-- EXEC SP_INSERTPEDIDO 2, 2
CREATE OR ALTER PROC SP_GETLASTPEDIDO
@id_usuario_cliente INT
AS
	SELECT TOP 1 id_pedido FROM tb_pedido 
	WHERE id_usuario_cliente = @id_usuario_cliente 
	ORDER BY ID_PEDIDO DESC
GO
-- EXEC SP_GETLASTPEDIDO 2
CREATE OR ALTER PROC SP_INSERTCOMPRAMONEY
@id_pedido INT, @ID_MEDIO_PAGO INT, @MONTO_COMPRA MONEY
AS
	INSERT INTO tb_compra(id_pedido, id_medio_pago, monto_compra, fechareg_compra, estado_compra)
	VALUES (@id_pedido, @ID_MEDIO_PAGO, @MONTO_COMPRA, GETDATE(), 'Exitosa')
GO
CREATE OR ALTER PROC SP_INSERTCOMPRACARD
@id_pedido INT, @ID_MEDIO_PAGO INT, @ID_TARJETA INT, @MONTO_COMPRA MONEY
AS
	INSERT INTO tb_compra(id_pedido, id_medio_pago, id_tarjeta, monto_compra, fechareg_compra, estado_compra)
	VALUES (@id_pedido, @ID_MEDIO_PAGO, @ID_TARJETA, @MONTO_COMPRA, GETDATE(), 'Exitosa')
GO
-- EXEC SP_INSERTCOMPRA 6, 1, 1, 20.25
CREATE OR ALTER PROC SP_INSERTCART
@ID_PEDIDO INT, @ID_PRODUCTO INT, @CANTIDAD INT
AS
	INSERT INTO tb_producto_pedido (id_pedido, id_producto, cantidad_producto)
	VALUES (@ID_PEDIDO, @ID_PRODUCTO, @CANTIDAD)
GO
-- EXEC SP_INSERTCART 6, 3, 3



SELECT * FROM tb_pedido
SELECT * FROM tb_compra
SELECT * FROM tb_producto_pedido