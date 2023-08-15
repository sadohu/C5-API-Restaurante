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
des_direntrega varchar(100) null,
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
imagen_producto varchar(500) NULL,
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
VALUES ('Cocinero'), ('Repartidor'), ('Limpieza'), ('Atenci�n al cliente'), ('Encargado');

-- Insertar datos en tb_distrito
INSERT INTO tb_distrito (des_distrito)
VALUES   ('Lima'), ('Barranco'), ('Bre�a'), ('Comas'), ('El Agustino'), ('Independencia'), ('Los Olivos'), ('Rimac'), ('San Juan de Lurigancho'),
	('San Juan de Miraflores'), ('San Martin de Porres'), ('Surquillo'), ('Villa Maria del Triunfo'), ('Callao');

-- Insertar datos en tb_mediopago
INSERT INTO tb_mediopago (des_medio_pago)
VALUES ('Efectivo'), ('Tarjeta');

-- Insertar datos en tb_categoria_producto
INSERT INTO tb_categoria_producto (des_categoria_producto)
VALUES ('Pollos y Carnes'), ('Bebidas'), ('Salsas y Aderezos'), ('Combos y Men�s'), ('Acompa�amientos');

-- Insertar datos en tb_usuario
INSERT INTO tb_usuario (id_tipo_usuario, cod_usuario, nom_usuario, ape_usuario, tel_usuario, cel_usuario, id_distrito, dir_usuario, dni_usuario, email_usuario, password_usuario, imagen_usuario, fechaReg_usuario, fechaAct_usuario, estado_usuario)
VALUES (1, 'ADMI001', 'Mark', 'Julca', '01-9999999', '999999999', 1, 'Admin', '99999999', 'admin@admin.com', 'Admin', NULL, GETDATE(), GETDATE(), 'Activo');
--,  
--	   (3, 'USER001', 'Juan', 'Perez', '01-1234567', '987654321', 1, 'Av. Los Pinos 123', '12345678', 'juan.perez@example.com', '12345678', NULL, GETDATE(), GETDATE(), 'Activo'),
--       (3, 'USER002', 'Maria', 'Lopez', '01-2345678', '987654322', 2, 'Calle Flores 456', '23456789', 'maria.lopez@example.com', '23456789', NULL, GETDATE(), GETDATE(), 'Activo'),
--       (3, 'USER003', 'Pedro', 'Gomez', '01-3456789', '987654323', 3, 'Jr. San Martin 789', '34567890', 'pedro.gomez@example.com', '34567890', NULL, GETDATE(), GETDATE(), 'Activo'),
--       (3, 'USER004', 'Ana', 'Ramirez', '01-4567890', '987654324', 4, 'Av. Los Alamos 101', '45678901', 'ana.ramirez@example.com', '45678901', NULL, GETDATE(), GETDATE(), 'Activo'),
--       (3, 'USER005', 'Carlos', 'Garcia', '01-5678901', '987654325', 5, 'Calle Los Pajaritos 789', '56789012', 'carlos.garcia@example.com', '56789012', NULL, GETDATE(), GETDATE(), 'Activo');

INSERT INTO tb_usuario (id_tipo_usuario, cod_usuario, nom_usuario, ape_usuario, tel_usuario, cel_usuario, id_distrito, dir_usuario, dni_usuario, email_usuario, password_usuario, imagen_usuario, fechaReg_usuario, fechaAct_usuario, estado_usuario)
VALUES
    (2, 'CLI001', 'Juan', 'P�rez', '1234567', '987654321', 1, 'Av. Los Pinos 123', '12345678', 'juan@example.com', 'password123', NULL, '2023-07-02', NULL, 'Activo'),
    (2, 'CLI002', 'Mar�a', 'G�mez', '9876543', '987654322', 2, 'Jr. Las Rosas 456', '87654321', 'maria@example.com', 'securepwd456', NULL, '2023-07-02', NULL, 'Activo'),
    (2, 'CLI003', 'Carlos', 'L�pez', '7654321', '987654323', 3, 'Calle San Mart�n 789', '56789012', 'carlos@example.com', 'adminpass789', NULL, '2023-07-02', NULL, 'Activo'),
    (2, 'CLI004', 'Ana', 'Rodr�guez', '9876541', '987654324', 4, 'Av. Principal 101', '34567890', 'ana@example.com', 'adminsecure123', NULL, '2023-07-02', NULL, 'Activo'),
    (2, 'CLI005', 'Pedro', 'Mart�nez', '8765432', '987654325', 5, 'Jr. Los P�jaros 234', '23456789', 'pedro@example.com', 'deliverypwd456', NULL, '2023-07-02', NULL, 'Activo'),
    (2, 'CLI006', 'Laura', 'S�nchez', '7654321', '987654326', 6, 'Calle Los Olivos 567', '45678901', 'laura@example.com', 'deliverysecure789', NULL, '2023-07-02', NULL, 'Activo'),
    (2, 'CLI007', 'Andr�s', 'Hern�ndez', '9876543', '987654327', 7, 'Av. Las Flores 789', '56789012', 'andres@example.com', 'delivery123', NULL, '2023-07-02', NULL, 'Activo'),
    (2, 'CLI008', 'Luis', 'Ram�rez', '8765432', '987654328', 8, 'Jr. Los Cerezos 567', '12345678', 'luis@example.com', 'clientpwd456', NULL, '2023-07-02', NULL, 'Activo'),
    (2, 'CLI009', 'Sof�a', 'Garc�a', '7654321', '987654329', 9, 'Calle Los Pinos 123', '23456789', 'sofia@example.com', 'clientsecure789', NULL, '2023-07-02', NULL, 'Activo'),
    (2, 'CLI010', 'Mart�n', 'D�az', '9876543', '987654330', 10, 'Av. Principal 456', '34567890', 'martin@example.com', 'client123', NULL, '2023-07-02', NULL, 'Activo'),
    (2, 'CLI011', 'Isabel', 'Luna', '8765432', '987654331', 11, 'Jr. Las Rosas 789', '45678901', 'isabel@example.com', 'clientsecure456', NULL, '2023-07-02', NULL, 'Activo'),
    (2, 'CLI012', 'Diego', 'Peralta', '7654321', '987654332', 12, 'Calle San Mart�n 101', '56789012', 'diego@example.com', 'clientpwd789', NULL, '2023-07-02', NULL, 'Activo'),
    (2, 'CLI013', 'Valeria', 'Mendoza', '9876543', '987654333', 13, 'Av. Los P�jaros 234', '12345678', 'valeria@example.com', 'clientsecure123', NULL, '2023-07-02', NULL, 'Activo'),
    (2, 'CLI014', 'Jorge', 'Herrera', '8765432', '987654334', 14, 'Jr. Los Cerezos 567', '23456789', 'jorge@example.com', 'clientpwd123', NULL, '2023-07-02', NULL, 'Activo'),
    (2, 'CLI015', 'Carolina', 'Silva', '7654321', '987654335', 5, 'Calle Los Olivos 123', '34567890', 'carolina@example.com', 'clientsecure456', NULL, '2023-07-02', NULL, 'Activo'),
    (2, 'CLI016', 'Jos�', 'Rojas', '9876543', '987654336', 1, 'Av. Las Flores 456', '45678901', 'jose@example.com', 'clientpwd789', NULL, '2023-07-02', NULL, 'Activo'),
    (2, 'CLI017', 'Fernanda', 'Ch�vez', '8765432', '987654337', 2, 'Jr. Los Pinos 789', '56789012', 'fernanda@example.com', 'clientsecure123', NULL, '2023-07-02', NULL, 'Activo');


-- Insertar datos en tb_colaborador
INSERT INTO tb_colaborador (id_tipo_colaborador, nom_colaborador, ape_colaborador, dni_colaborador, imagen_colaborador, fechaReg_colaborador, fechaAct_colaborador, estado_colaborador)
VALUES (1, 'Luis', 'Martinez', '11111111', NULL, GETDATE(), GETDATE(), 'Activo'),
       (2, 'Rosa', 'Castillo', '22222222', NULL, GETDATE(), GETDATE(), 'Activo'),
       (3, 'Carlos', 'Vargas', '33333333', NULL, GETDATE(), GETDATE(), 'Activo'),
       (4, 'Elena', 'Lopez', '44444444', NULL, GETDATE(), GETDATE(), 'Activo'),
       (5, 'Mario', 'Gomez', '55555555', NULL, GETDATE(), GETDATE(), 'Activo');

-- Insertar datos en tb_direntrega_usuario
INSERT INTO tb_direntrega_usuario (id_usuario, id_distrito, nombre_direntrega, des_direntrega, detalle_direntrega, fechareg_direntrega, estado_direntrega)
VALUES (2, 1, 'Oficina', 'Av. Los Pinos 123', 'Departamento 201', GETDATE(), 'Activo'),
       (2, 2, 'Casa', 'Calle Flores 456', 'Puerta Marron', GETDATE(), 'Activo'),
       (2, 3, 'Casa', 'Jr. San Martin 789', 'Ref. Jr. Montenegro', GETDATE(), 'Activo'),
       (3, 4, 'Torre 1', 'Av. Los Alamos 101', 'Dejar en seguridad', GETDATE(), 'Activo'),
       (3, 5, 'Depa Surco', 'Calle Los Pajaritos 789', 'Llamar al llegar', GETDATE(), 'Activo');

-- Insertar datos en tb_tarjeta
INSERT INTO tb_tarjeta (id_usuario, numero_tarjeta, cvv_tarjeta, fecha_tarjeta, nombre_tarjeta, fechareg_tarjeta, estado_tarjeta)
VALUES (2, '1111222233334444', '123', '2023-12', 'Juan Perez', GETDATE(), 'Activo'),
       (2, '4444333322221111', '456', '2024-05', 'Maria Lopez', GETDATE(), 'Activo'),
       (3, '7777666655554444', '789', '2025-10', 'Pedro Gomez', GETDATE(), 'Activo'),
       (3, '9999888877776666', '987', '2026-01', 'Ana Ramirez', GETDATE(), 'Activo'),
       (4, '1234123412341234', '234', '2027-06', 'Carlos Garcia', GETDATE(), 'Activo');

-- Insertar datos en tb_pedido
INSERT INTO tb_pedido (id_usuario_cliente, id_direntrega, id_colaborador_repartidor, tiempoentrega_pedido, fechareg_pedido, fechaact_pedido, estado_pedido)
VALUES (2, 1, 1, '12:00:00', GETDATE(), GETDATE(), 'Pendiente'),
       (2, 2, 2, '13:30:00', GETDATE(), GETDATE(), 'Entregado'),
       (2, 3, 3, '14:45:00', GETDATE(), GETDATE(), 'En camino'),
       (3, 4, 4, '16:00:00', GETDATE(), GETDATE(), 'Pendiente'),
       (3, 5, 5, '17:30:00', GETDATE(), GETDATE(), 'En camino');

-- Insertar datos en tb_producto
INSERT INTO tb_producto (id_categoria_producto, nom_producto, des_producto, preciouni_producto, stock_producto, imagen_producto, estado_producto)
VALUES
	   (1, '1/4 de Pollo', '1/4 de pollo a la brasa + papas fritas + ensalada + limonada personal', 21.90, 100, 'https://d1v8f0fkg48ska.cloudfront.net/media/chaty_lenaycarbon/products/1689295869-413763--cuarto-oferton.jpg', 'Activo'),
       (1, 'Pollo + Papas + Chaufa + Ensalada', 'Pollo a la brasa acompa�ado de abundantes papas fritas, chaufa de hot dog familiar y ensalada', 73.90, 50, 'https://d1v8f0fkg48ska.cloudfront.net/media/chaty_lenaycarbon/products/1676984400-658712--mega-promo-online.jpg', 'Activo'),
       (1, 'Pollo a la Brasa', '1 Pollo a la brasa + abundantes papas fritas + ensalada de lechuga, tomate y pepino.', 60.90, 30, 'https://d1v8f0fkg48ska.cloudfront.net/media/chaty_lenaycarbon/products/1677213828-059195--mega-promo.jpg', 'Activo'),
       (1, '1/4 Anticuchero', '1/4 Pollo a la brasa + anticucho + abundantes papas fritas + ensalada de lechuga, tomate y pepino', 30.90, 20, 'https://d1v8f0fkg48ska.cloudfront.net/media/chaty_lenaycarbon/products/1689285227-709844--cuarto_anticuchero.jpg', 'Activo'),
       (1, '1/4 Carretillero', '1/4 Pollo a la brasa + mollejitas + abundantes papas fritas + ensalada de lechuga, tomate y pepino', 32.90, 100, 'https://d1v8f0fkg48ska.cloudfront.net/media/chaty_lenaycarbon/products/1689286372-328585--cuarto-carretillero_1.jpg', 'Activo'),
	   (1, '1/4 Choricero', '1/4 Pollo a la brasa + chorizo + abundantes papas fritas + ensalada de lechuga, tomate y pepino', 30.90, 20, 'https://d1v8f0fkg48ska.cloudfront.net/media/chaty_lenaycarbon/products/1689285262-817818--cuarto_choricero.jpg', 'Activo'),
	   (1, 'Parrilla Para 2', '1/4 de pollo a la brasa, chorizo parrillero, hot dog, 2 palitos de anticucho, chuleta, crocantes papas fritas y ensalada mediana', 68.90, 20, 'https://d1v8f0fkg48ska.cloudfront.net/media/chaty_lenaycarbon/products/1686591138-333056--parrilla_personal_1.jpg', 'Activo'),
	   (1, 'Parrilla Familiar', '1/4 de pollo, bife, chorizo parrillero, chuleta o pechuga, hot dog, 2 palitos de anticuchos acompa�ado de papas fritas y ensalada', 93.90, 20, 'https://d1v8f0fkg48ska.cloudfront.net/media/chaty_lenaycarbon/products/1686588754-599284--parrilla_familiar.jpg', 'Activo'),
	   (1, 'Parrilla Le�a & Carbon', '1/2 pollo a la brasa, 2 palitos de anticucho, chuleta, mollejitas, filete de pierna, lomo fino, churrasco, 2 chorizos, 2 hot dog, papas fritas, ensalada familiar y 1.5L. de limonada', 119.90, 20, 'https://d1v8f0fkg48ska.cloudfront.net/media/chaty_lenaycarbon/products/1686588631-24924--parrilla_le%C3%B1aycarbon.jpg', 'Activo');

-- Insertar datos en tb_producto_pedido
INSERT INTO tb_producto_pedido (id_pedido, id_producto, cantidad_producto)
VALUES (1, 1, 2),
       (2, 3, 1),
       (3, 2, 3),
       (4, 3, 2),
       (5, 4, 1);

-- Insertar datos en tb_seguimiento_pedido
INSERT INTO tb_seguimiento_pedido (id_pedido, fechareg_seguimiento_pedido, estado_seguimmiento_pedido)
VALUES (1, GETDATE(), 'En camino'),
       (2, GETDATE(), 'Entregado'),
       (3, GETDATE(), 'En camino'),
       (4, GETDATE(), 'Pendiente'),
       (5, GETDATE(), 'En camino');

-- Insertar datos en tb_compra
INSERT INTO tb_compra (id_pedido, id_medio_pago, monto_compra, fechareg_compra, estado_compra)
VALUES (1, 1, 43.80, GETDATE(), 'Exitosa'),
       (2, 2, 60.90, GETDATE(), 'Exitosa'),
       (3, 1, 221.70, GETDATE(), 'Exitosa'),
       (4, 1, 147.80, GETDATE(), 'Exitosa'),
       (5, 1, 30.90, GETDATE(), 'Exitosa');

-- Insertar datos en tb_comentario
INSERT INTO tb_comentario (id_usuario_cliente, des_comentario, cantestrella_comentario, fechareg_comentario, estado_comentario)
VALUES (1, 'Muy buena atenci�n, el pollo a la brasa estaba delicioso.', 5, GETDATE(), 'Activo'),
       (2, 'Las papas fritas estaban un poco fr�as, pero el resto bien.', 4, GETDATE(), 'Activo'),
       (3, 'Ped� una gaseosa y lleg� caliente.', 2, GETDATE(), 'Activo'),
       (4, 'La torta de chocolate estaba incre�ble.', 5, GETDATE(), 'Activo'),
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

-- ================ TARJETA ========================
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

-- ================ DISTRITO ========================
CREATE OR ALTER PROC SP_GETDISTRITO
AS
BEGIN 
	SELECT * FROM tb_distrito
END
GO

-- ================ CATEGORIA ========================
CREATE OR ALTER PROC SP_GETCATEGORIA
AS
BEGIN 
	SELECT * FROM tb_categoria_producto
END
GO
-- INSERT
CREATE OR ALTER PROC SP_INSERTCATEGORIA
@DESCRIPCION VARCHAR(100)
AS
	INSERT INTO tb_categoria_producto (des_categoria_producto)
	VALUES (@DESCRIPCION)
GO
-- UPDATE
CREATE OR ALTER PROC SP_UPDATECATEGORIA
@ID INT, @DESCRIPCION VARCHAR(100)
AS
	UPDATE tb_categoria_producto SET des_categoria_producto = @DESCRIPCION
	WHERE id_categoria_producto = @ID
GO
-- DELETE
CREATE OR ALTER PROC SP_DELETECATEGORIA
@ID INT
AS
	DELETE FROM tb_categoria_producto WHERE id_categoria_producto = @ID
GO

-- ================ PEDIDO ========================
CREATE OR ALTER PROC SP_GETPEDIDOPENDIENTE
AS
	SELECT * FROM tb_pedido 
	WHERE estado_pedido = 'Pendiente'
	ORDER BY id_pedido ASC
GO

CREATE OR ALTER PROC SP_GETLASTPEDIDO
@id_usuario_cliente INT
AS
	SELECT TOP 1 id_pedido FROM tb_pedido 
	WHERE id_usuario_cliente = @id_usuario_cliente 
	ORDER BY ID_PEDIDO DESC
GO
--INSERT
CREATE OR ALTER PROC SP_INSERTPEDIDO
@id_usuario_cliente INT, @id_direntrega INT
AS
	INSERT INTO tb_pedido(ID_USUARIO_CLIENTE, ID_DIRENTREGA, tiempoentrega_pedido, fechareg_pedido, estado_pedido)
	VALUES (@id_usuario_cliente, @id_direntrega, '00:45', GETDATE(), 'Pendiente')
GO
-- UPDATE																																				TODO
CREATE OR ALTER PROC SP_UPDATEPEDIDOESTADO
@ESTADO VARCHAR(100)
AS
	INSERT INTO tb_pedido(estado_pedido, fechaact_pedido)
	VALUES (@ESTADO, GETDATE())
GO

-- ================ COMPRAS ========================
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

-- ================ CART ========================
CREATE OR ALTER PROC SP_INSERTCART
@ID_PEDIDO INT, @ID_PRODUCTO INT, @CANTIDAD INT
AS
	INSERT INTO tb_producto_pedido (id_pedido, id_producto, cantidad_producto)
	VALUES (@ID_PEDIDO, @ID_PRODUCTO, @CANTIDAD)
GO

-- ================ USUARIO ========================
CREATE OR ALTER PROC SP_LISTARUSUARIO
AS
BEGIN 
	SELECT * FROM tb_usuario WHERE estado_usuario = 'ACTIVO'
END
GO
-- LOGIN
CREATE OR ALTER PROC SP_LOGINUSUARIO
@USER VARCHAR(100), @PASS VARCHAR(100)
AS
BEGIN 
	SELECT * FROM tb_usuario WHERE email_usuario = @USER OR cel_usuario = @USER AND password_usuario = @PASS AND estado_usuario = 'ACTIVO'
END
GO
-- INSERT
CREATE OR ALTER PROC SP_INSERTUSUARIO
@NOMBRE VARCHAR(150),
@APELLIDOS VARCHAR(150),
@TELEFONO VARCHAR(150),
@EMAIL VARCHAR(150),
@PASS VARCHAR(150)
AS
BEGIN
	INSERT INTO tb_usuario(id_tipo_usuario, nom_usuario, ape_usuario, cel_usuario, email_usuario, password_usuario, fechaReg_usuario, estado_usuario)
	VALUES (2, @NOMBRE, @APELLIDOS, @TELEFONO, @EMAIL, @PASS, GETDATE(), 'Activo')
END
GO
-- UPDATE
CREATE OR ALTER PROC SP_UPDATEUSUARIO
@ID INT,
@NOMBRE VARCHAR(150),
@APELLIDOS VARCHAR(150),
@TELEFONO VARCHAR(150),
@EMAIL VARCHAR(150),
@PASS VARCHAR(150)
AS
BEGIN
	UPDATE tb_usuario SET nom_usuario = @NOMBRE, ape_usuario = @APELLIDOS, cel_usuario = @TELEFONO,
	email_usuario = @EMAIL, password_usuario = @PASS, fechaAct_usuario = GETDATE() WHERE id_usuario = @ID
END
GO
CREATE OR ALTER PROC SP_UPDATEUSUARIOPASS
@ID INT,
@PASS VARCHAR(150)
AS
BEGIN
	UPDATE tb_usuario SET password_usuario = @PASS, fechaAct_usuario = GETDATE() WHERE id_usuario = @ID
END
GO
-- DELETE
CREATE OR ALTER PROC SP_DELETEUSUARIO
@ID INT
AS
BEGIN
	UPDATE tb_usuario SET estado_usuario = 'Inactivo' WHERE id_usuario = @ID
END
GO




-- ================ usp_listadoEcommer ========================																							TODO
CREATE OR ALTER PROC usp_listadoEcommer
AS
Select p.id_producto,p.nom_producto,p.des_producto,cp.des_categoria_producto,
p.preciouni_producto,p.stock_producto
from tb_producto p inner join tb_categoria_producto cp
on p.id_categoria_producto=cp.id_categoria_producto
GO
-- EXEC usp_listadoEcommer

SELECT * FROM tb_usuario
SELECT * FROM tb_direntrega_usuario
SELECT * FROM tb_tarjeta
SELECT * FROM tb_pedido
SELECT * FROM tb_compra
SELECT * FROM tb_producto_pedido

GO

SELECT @@IDENTITY