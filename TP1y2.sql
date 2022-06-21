-- Año: 2022
-- Grupo Nro: 02
-- Integrantes: Santiago José Gianotti, Santiago Martin Berretta Gali
-- Tema: Pasteleria Chocolart Web
-- Nombre del esquema: LBD2022G02PASTELERIA
-- Plataforma: Linux Manjaro 2022 | Windows 10
-- Motor y Version: 10.7.3-MariaDB Arch Linux | MySQL community 8.0.22
-- GitHub Repositorio: https://github.com/matiasmendiondo/LBD2022G02
-- GitHub Usuario: SantiagoGianotti, SantiagoB99

-- Se creo la base nuevamente con los cambios del TP1

DROP SCHEMA IF EXISTS LBD2022G02PASTELERIA;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LBD2022G02PASTELERIA
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LBD2022G02PASTELERIA
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LBD2022G02PASTELERIA` ;
USE `LBD2022G02PASTELERIA` ;

-- -----------------------------------------------------
-- Table `LBD2022G02PASTELERIA`.`Administradores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LBD2022G02PASTELERIA`.`Administradores` (
  `idAdministrador` INT UNSIGNED NOT NULL auto_increment,
  `activo` TINYINT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `documento` VARCHAR(8) NOT NULL,
  `tipoDocumento` VARCHAR(45) NOT NULL,
  `correoElectronico` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAdministrador`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LBD2022G02PASTELERIA`.`Pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LBD2022G02PASTELERIA`.`Pedidos` (
  `idPedido` INT UNSIGNED NOT NULL auto_increment,
  `estadoPedido` VARCHAR(45) NOT NULL,
  `codigoPedido` VARCHAR(45) NOT NULL,
  `observaciones` VARCHAR(255) NULL,
  `fechaCreado` DATETIME DEFAULT current_timestamp() NOT NULL,
  `fechaModificado` TIMESTAMP DEFAULT current_timestamp() NOT NULL ON update current_timestamp(),
  PRIMARY KEY (`idPedido`),
  UNIQUE INDEX `codigoPedido_UNIQUE` (`codigoPedido` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LBD2022G02PASTELERIA`.`Contactos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LBD2022G02PASTELERIA`.`Contactos` (
  `idContacto` INT UNSIGNED NOT NULL auto_increment,
  `idPedido` INT UNSIGNED NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `correoElectronico` VARCHAR(45) NOT NULL,
  `numeroTelefonico` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idContacto`),
  INDEX `fk_Contactos_Pedidos1_idx` (`idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Contactos_Pedidos1`
    FOREIGN KEY (`idPedido`)
    REFERENCES `LBD2022G02PASTELERIA`.`Pedidos` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LBD2022G02PASTELERIA`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LBD2022G02PASTELERIA`.`Categoria` (
  `idCategoria` INT UNSIGNED NOT NULL,
  `idPadre` INT UNSIGNED NULL,
  `activo` TINYINT NOT NULL,
  `nombreCategoria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategoria`),
  INDEX `fk_Categoria_Categoria_idx` (`idPadre` ASC) VISIBLE,
  CONSTRAINT `fk_Categoria_Categoria`
    FOREIGN KEY (`idPadre`)
    REFERENCES `LBD2022G02PASTELERIA`.`Categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LBD2022G02PASTELERIA`.`Productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LBD2022G02PASTELERIA`.`Productos` (
  `idProducto` INT UNSIGNED NOT NULL auto_increment,
  `idCategoria` INT UNSIGNED NOT NULL,
  `activo` TINYINT NOT NULL,
  `nombreProducto` VARCHAR(45) NOT NULL,
  `descripcionProducto` VARCHAR(255) NOT NULL,
  `fechaCreado` DATETIME DEFAULT CURRENT_TIMESTAMP() NOT NULL,
  PRIMARY KEY (`idProducto`),
  INDEX `fk_Productos_Categoria1_idx` (`idCategoria` ASC) VISIBLE,
  CONSTRAINT `fk_Productos_Categoria1`
    FOREIGN KEY (`idCategoria`)
    REFERENCES `LBD2022G02PASTELERIA`.`Categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LBD2022G02PASTELERIA`.`Recursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LBD2022G02PASTELERIA`.`Recursos` (
  `idRecurso` INT UNSIGNED NOT NULL auto_increment,
  `idProducto` INT UNSIGNED NOT NULL,
  `nombreRecurso` VARCHAR(45) NOT NULL,
  `url` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idRecurso`, `idProducto`),
  INDEX `fk_Recursos_Productos1_idx` (`idProducto` ASC) VISIBLE,
  CONSTRAINT `fk_Recursos_Productos1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `LBD2022G02PASTELERIA`.`Productos` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LBD2022G02PASTELERIA`.`Personalizacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LBD2022G02PASTELERIA`.`Personalizacion` (
  `idPersonalizacion` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `activo` TINYINT NOT NULL,
  `nombrePersonalizacion` VARCHAR(45) NOT NULL,
  `costo` DECIMAL(8,2) NOT NULL,
  `descripcion` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idPersonalizacion`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `LBD2022G02PASTELERIA`.`LineasPedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LBD2022G02PASTELERIA`.`LineasPedido` (
  `idLineasPedido` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idPedido` INT UNSIGNED NOT NULL,
  `idProducto` INT UNSIGNED NOT NULL,
  `cantidad` INT UNSIGNED NOT NULL,
  `precioUnitario` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idLineasPedido`),
  INDEX `fk_Pedidos_has_Productos_Productos1_idx` (`idProducto` ASC),
  INDEX `fk_Pedidos_has_Productos_Pedidos1_idx` (`idPedido` ASC),
  CONSTRAINT `fk_Pedidos_has_Productos_Pedidos1`
    FOREIGN KEY (`idPedido`)
    REFERENCES `LBD2022G02PASTELERIA`.`Pedidos` (`idPedido`),
  CONSTRAINT `fk_Pedidos_has_Productos_Productos1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `LBD2022G02PASTELERIA`.`Productos` (`idProducto`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `LBD2022G02PASTELERIA`.`LPPersonalizacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LBD2022G02PASTELERIA`.`LPPersonalizacion` (
  `idLineasPedido` INT UNSIGNED NOT NULL,
  `idPersonalizacion` INT UNSIGNED NOT NULL,
  `cantidad` INT UNSIGNED NOT NULL,
  `precioUnitario` DECIMAL(10,2) NOT NULL,
  INDEX `fk_OpcionesPersonalizacion_has_Pedidos_has_Productos_Pedido_idx` (`idLineasPedido` ASC),
  INDEX `fk_OpcionesPersonalizacion_has_Pedidos_has_Productos_Opcion_idx` (`idPersonalizacion` ASC),
  PRIMARY KEY (`idLineasPedido`, `idPersonalizacion`),
  CONSTRAINT `fk_OpcionesPersonalizacion_has_Pedidos_has_Productos_Opciones1`
    FOREIGN KEY (`idPersonalizacion`)
    REFERENCES `LBD2022G02PASTELERIA`.`Personalizacion` (`idPersonalizacion`),
  CONSTRAINT `fk_OpcionesPersonalizacion_has_Pedidos_has_Productos_Pedidos_1`
    FOREIGN KEY (`idLineasPedido`)
    REFERENCES `LBD2022G02PASTELERIA`.`LineasPedido` (`idLineasPedido`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `LBD2022G02PASTELERIA`.`PersonalizacionProductos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LBD2022G02PASTELERIA`.`PersonalizacionProductos` (
  `idProducto` INT UNSIGNED NOT NULL,
  `idPersonalizacion` INT UNSIGNED NOT NULL,
  INDEX `fk_Productos_has_OpcionesPersonalizacion_OpcionesPersonaliz_idx` (`idPersonalizacion` ASC),
  INDEX `fk_Productos_has_OpcionesPersonalizacion_Productos1_idx` (`idProducto` ASC),
  PRIMARY KEY (`idProducto`, `idPersonalizacion`),
  CONSTRAINT `fk_Productos_has_OpcionesPersonalizacion_OpcionesPersonalizac1`
    FOREIGN KEY (`idPersonalizacion`)
    REFERENCES `LBD2022G02PASTELERIA`.`Personalizacion` (`idPersonalizacion`),
  CONSTRAINT `fk_Productos_has_OpcionesPersonalizacion_Productos1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `LBD2022G02PASTELERIA`.`Productos` (`idProducto`))
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb4;

alter table Personalizacion 
ADD CHECK (costo >=0);
alter table LPPersonalizacion
ADD CHECK (precioUnitario>=0),
ADD CHECK (cantidad>0);
alter table LineasPedido
ADD CHECK (precioUnitario>0),
ADD CHECK (cantidad>0);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- Inserción de categorias

INSERT INTO Categoria (idCategoria, idPadre, activo, nombreCategoria) values (1, null, 1, 'Dulce');
INSERT INTO Categoria (idCategoria, idPadre, activo, nombreCategoria) values (2, null, 1, 'Salado');

INSERT INTO Categoria (idCategoria, idPadre, activo, nombreCategoria) values (3, 1, 1, 'Mesas Dulces');
INSERT INTO Categoria (idCategoria, idPadre, activo, nombreCategoria) values (4, 1, 1, 'Tortas');
INSERT INTO Categoria (idCategoria, idPadre, activo, nombreCategoria) values (5, 1, 1, 'Tartas');
INSERT INTO Categoria (idCategoria, idPadre, activo, nombreCategoria) values (6, 1, 1, 'Huevos de Pascua');
INSERT INTO Categoria (idCategoria, idPadre, activo, nombreCategoria) values (7, 1, 1, 'Gomitas');
INSERT INTO Categoria (idCategoria, idPadre, activo, nombreCategoria) values (8, 1, 1, 'Drip Cake');
INSERT INTO Categoria (idCategoria, idPadre, activo, nombreCategoria) values (9, 1, 1, 'Boxes');
INSERT INTO Categoria (idCategoria, idPadre, activo, nombreCategoria) values (10, 1, 1, 'Muffins');
INSERT INTO Categoria (idCategoria, idPadre, activo, nombreCategoria) values (11, 1, 1, 'Macaroons');
INSERT INTO Categoria (idCategoria, idPadre, activo, nombreCategoria) values (12, 1, 1, 'Alfajores');
INSERT INTO Categoria (idCategoria, idPadre, activo, nombreCategoria) values (13, 1, 1, 'Mini Tortas');
INSERT INTO Categoria (idCategoria, idPadre, activo, nombreCategoria) values (14, 1, 1, 'Chupetines');
INSERT INTO Categoria (idCategoria, idPadre, activo, nombreCategoria) values (15, 1, 1, 'Conitos');

INSERT INTO Categoria (idCategoria, idPadre, activo, nombreCategoria) values (16, 2, 1, 'Sandwiches');
INSERT INTO Categoria (idCategoria, idPadre, activo, nombreCategoria) values (17, 2, 1, 'Panificados');
INSERT INTO Categoria (idCategoria, idPadre, activo, nombreCategoria) values (18, 2, 1, 'Otros');

INSERT INTO Categoria (idCategoria, idPadre, activo, nombreCategoria) values (19, 2, 1, 'Snacks');

INSERT INTO Categoria (idCategoria, idPadre, activo, nombreCategoria) values (20, 1, 1, 'Otros');

-- Alteramos la tabla para no ingresar la fecha de creación de los Productos todo el tiempo.


-- Alteramos la descripción del producto para ingresar descripciones mas largas

alter table Productos modify descripcionProducto text not null;

INSERT INTO Productos
    (idCategoria, activo, nombreProducto, descripcionProducto) values
    (4, 1, 'Rogel', 'Este es el postre más argentino de todos, se trata de un alfajor gigante elaborado a base de una masa de manteca, harina y yema de huevo. Con ésta se forman discos y entre ellos se colocan generosas capas de dulce de leche para finalizar con un gran copete de merengue italiano.'),
    (4, 1, 'Balcarce', 'Preparada a base de ingredientes simples, deleita a grandes y chicos gracias a su sencillez y a su combinación de texturas crujientes, suaves y húmedas. Se elabora con bizcochuelo de vainilla, merengue seco, dulce de leche, crema chantilly, castañas en almíbar y tiene una cubierta de azúcar impalpable grabada a fuego.'),
    (4, 1, 'Selva Negra', 'La versión argentina lleva bizcochuelo de cacao amargo, almendras, crema chantilly, cerezas en almíbar y grandes trozos de chocolate.'),
    (4, 1, 'Bizcochuelo', 'Esta torta es personalizable a elección del cliente.'),
    (5, 1, 'Tarta Mantecol', 'Masa sablee con cacao rellena con dulce de leche, cream bon o bon y arriba con trozos de mantecol con trozos de almendra.'),
    (5, 1, 'Tarta De Frutillas', 'La tarta de frutillas es una clásica torta y con ingredientes que por lo general gustan a la mayoría. Está compuesta por una delicada masa de base, rellena con una suave crema diplomática y decorada en la superficie con frutillas. Es una riquísima y fresca receta, ideal para el verano.'),
    (5, 1, 'Lemon Pie', 'Este bocado dulce consiste en una crujiente base de masa quebrada, una cremosa crema de limón y se termina con un merengue italiano. El toque ácido del cítrico y el dulzor del merengue hacen de este postre una auténtica delicia.'),
    (5, 1, 'Tarta Havannette', 'Masa sablee con cacao, rellena con dulce de leche y ganache blanco.'),
    (6, 1, 'Huevo Triple Tentación', 'Una combinación perfecta para degustar lo rico del chocolate kínder acompañado de la crema brigadeiro y la crema Bariloche.'),
    (6, 1, 'Huevo Red Velvet', 'El huevo Velvet es una versión de pascuas de la famosa torta Red Velvet'),
    (6, 1, 'Huevo Brownie', 'Cáscara del huevo de brownie súper húmedo y chocolatoso, una capa de chocolate semiamargo, trozos de brownie, dulce de leche y chantilly.'),
    (6, 1, 'Huevo Bruce', 'Este huevo es la versión de pascuas de la famosa torta basada en la pelicula Matilda.'),
    (16, 1, 'Jamon y Queso', 'Sandwiches de Miga de Jamon y queso.'),
    (16, 1, 'Ternera y Queso', 'Sandwiches de Miga de Ternera y queso.'),
    (16, 1, 'Salame y Queso', 'Sandwiches de Miga de Salame y queso.'),
    (16, 1, 'Croque Maddame', 'Este Sandwich frances es ideal para acompañar con un café una tarde fria de invierno.'),
    (9, 1, 'Combo 1', '2 alfajores de maicena, 2 chocolates de dulce de leche bañados en chocolate, 1 jugo ades y 1 minitorta de frutilla..'),
    (9, 1, 'Combo 2', '6 alfajores de dulce de leche, 2 chocolates blancos rellenos de dulce de leche, 1 vino malbec y 1 minitorta de frutilla..'),
    (9, 1, 'Combo 3', '6 minitortas de dulce de leche, 2 chocolates de dulce de leche bañados en chocolate, 1 jugo ades y 1 minitorta de frutilla..'),
    (9, 1, 'Combo 4', '6 corazones de dulce leche bañados en chocolate, 1 jugo ades y 1 minitorta de frutilla..'),
    (9, 1, 'Combo 5', '2 galletas de avena con chips de chocolate, 2 chocolates de dulce de leche bañados en chocolate, 1 jugo ades y 1 minitorta de frutilla..');




INSERT INTO Personalizacion
    (activo, nombrePersonalizacion, costo, descripcion) VALUES
    (1, 'Baño de Chocolate', 100, 'Agregado de baño de chocolate fundido.'),
    (1, 'Baño de Chocolate Blanco', 100, 'Agregado de baño de chocolate blanco fundido.'),
    (1, 'Chips de Chocolate', 100, 'Agregado de chips de chocolate.'),
    (1, 'Chips de Chocolate Blanco', 100, 'Agregado de chips de chocolate blanco.'),
    (1, 'Baño de Crema Chocolart', 100, 'Agregado de crema especial.'),
    (1, 'Sabor Frutilla', 0, 'Agregado de crema especial.'),
    (1, 'Sabor Vainilla', 0, 'Agregado de crema especial.'),
    (1, 'Sabor Chocolate', 0, 'Agregado de crema especial.'),
    (1, 'Sabor Limon', 0, 'Agregado de crema especial.'),
    (1, 'Piso extra de torta', 500, 'Agrandar la torta por un piso.'),
    (1, 'Extra Queso', 50, 'Agregado de queso extra.'),
    (1, 'Extra Jamon', 50, 'Agregado de jamon extra.'),
    (1, 'Extra Salame', 50, 'Agregado de salame extra.'),
    (1, 'Extra Ternera', 50, 'Agregado de ternera extra.'),
    (1, 'Merenguitos', 200, 'Agregado de merenguitos.'),
    (1, 'Dulce de leche', 0, 'Relleno de dulce de leche.'),
    (1, 'Crema Chantilli', 0, 'Relleno de Crema Chantilli.'),
    (1, 'Crema Cookies', 0, 'Relleno de Crema Cookies.'),
    (1, 'Crema Con Frutas', 0, 'Relleno de Crema Con Frutas.'),
    (1, 'Crema Nutella', 0, 'Relleno de Crema Nutella.'),
    (1, 'Crema Dulce de Leche', 0, 'Relleno de Crema Dulce de Leche.'),
    (1, 'Crema De Frutilla', 0, 'Relleno de Crema De Frutilla.'),
    (1, 'Crema Bonobon', 0, 'Relleno de Crema Bonobon.'),
    (1, 'Crema Bariloche', 0, 'Relleno de Crema Bariloche.'),
    (1, 'Crema De Naranja', 0, 'Relleno de Crema De Naranja.'),
    (1, 'Crema De Limon', 0, 'Relleno de Crema De Limon.');



INSERT INTO PersonalizacionProductos
    (idProducto, idPersonalizacion) VALUES
    (7, 1),
    (7, 15),
    (7, 2),
    (7, 10),
    (13, 11),
    (13, 12),
    (14, 11),
    (14, 14),
    (15, 11),
    (15, 13),
	(4,17),
	(4,18),
	(4,19),
	(4,20),
	(4,21),
	(4,22),
	(4,23),
	(4,24),
	(4,25),
	(4,26);


INSERT INTO Pedidos
    (estadoPedido, codigoPedido, observaciones) VALUES
    ('pendiente', 'asdfgskasfgjn', 'Entregar a juana'),
    ('confirmado', '0159616165156', 'Sin glutten'),
    ('entregado', '16168160324', 'Poner texto que diga: Feliz cumple juan'),
    ('pendiente', '1231231245', 'Dibujar un corazon'),
    ('cancelado', '2345234234', 'El cliente cancelo por razones personales');


INSERT INTO LineasPedido
    (idPedido, idProducto, cantidad, precioUnitario) VALUES
    (1, 1, 1, 1000),
    (1, 2, 2, 1500),
    (1, 3, 1, 1200),
    (1, 4, 1, 750),
    (1, 5, 2, 600),
    (2, 6, 1, 180),
    (2, 4, 5, 750),
    (2, 8, 1, 210),
    (2, 9, 4, 500),
    (2, 7, 1, 999),
    (3, 11, 1, 2000),
    (3, 4, 1, 750),
    (3, 13, 6, 1300),
    (3, 14, 1, 1700),
    (3, 5, 1, 600),
    (4, 16, 9, 700),
    (4, 17, 7, 820),
    (5, 18, 1, 980);



INSERT INTO LPPersonalizacion
    (idLineasPedido, idPersonalizacion, cantidad, precioUnitario) VALUES
    (4, 21, 1, 0), -- bizcochuelo con relleno de dulce de leche
    (7, 23, 1, 0), -- bizcochuelo con relleno de bonobon
    (10, 1, 1, 100), -- lemon pie con baño de chocolate
    (10, 10, 1, 500), -- lemon pie con piso extra
    (10, 15, 1, 200), -- lemon pie con merenguitos
    (12, 18, 1, 50), -- bizcochuelo con crema cookies
    (13, 11, 1, 50), -- sandwich jamon y queso con queso extra
    (13, 12, 1, 50), -- sandwich de jamon y queso con jamon extra
    (14, 14, 1, 50); -- sandwich de ternera y queso con ternera extra

INSERT INTO Contactos
    (idPedido, nombre, apellido, correoElectronico, numeroTelefonico) VALUES
    (1, 'Ana', 'Costa', 'ana@hotmail.com', '38150123123'),
    (2, 'Juan', 'Perez', 'juan@hotmail.com', '38150123553'),
    (3, 'Carlos', 'Caceres', 'carloncho@hotmail.com', '38150123125'),
    (4, 'Francisca', 'Juarez', 'franchu@hotmail.com', '38156233123'),
    (5, 'Pedro', 'Gonzales', 'pedro@hotmail.com', '38150123893');


-- ejercicios TP2
-- Primero se realiza la siguiente insercion de datos:
-- se agregan mas Pedidos 
INSERT INTO Pedidos
    (estadoPedido, codigoPedido, observaciones) VALUES
    ('confirmado', '14842154', 'El pedido fue confirmado con exito'),
    ('entregado', '1781651655', 'Entregar a direccion Falsa 1234');

-- Agregado un pedido fuera del rango de la fechas para que no lo muestre
INSERT INTO Pedidos
	(estadoPedido, codigoPedido, observaciones, fechaCreado) VALUES
    ('cancelado', '4516523155', 'El pedido fue cancelado', '2020-05-15 18:35:02');

-- Agregado mas Pedidos con fecha distinta para consulta 4
INSERT INTO Pedidos
	(estadoPedido, codigoPedido, observaciones, fechaCreado) VALUES
    ('cancelado', '1234892', 'El pedido fue cancelado', '2021-06-15 18:35:02'),
    ('confirmado', '78165418', 'El pedido fue confirmado con exito', '2021-06-15 18:35:02');

-- Se agrega cada pedido al mismo contacto
INSERT INTO Contactos
    (idPedido, nombre, apellido, correoElectronico, numeroTelefonico) VALUES
    (6, 'Ana', 'Costa', 'ana@hotmail.com', '38150123123'),
    (7, 'Ana', 'Costa', 'ana@hotmail.com', '38150123123'),
    (8, 'Ana', 'Costa', 'ana@hotmail.com', '38150123123'),
    (9, 'Jose', 'Costa', 'jose@hotmail.com', '38150158462'),
    (10, 'Jose', 'Costa', 'jose@hotmail.com', '38150158462');

-- Se modifica una fecha asi se muestra en el punto 4
UPDATE Pedidos SET fechaCreado = '2022-04-16 20:54:59' WHERE idPedido = 6;

-- Se agregan productos a los pedidos añadidos para este TP
INSERT INTO LineasPedido
    (idPedido, idProducto, cantidad, precioUnitario) VALUES
	(6, 18, 1, 980),
	(6, 5, 3, 600),
	(6, 16, 2, 700),
	(7, 7, 1, 999),
	(7, 13, 2, 1300),
	(8, 1, 1, 1000),
	(8, 2, 1, 1500),
	(8, 3, 3, 1200),
	(9, 4, 1, 700),
	(9, 5, 1, 600),
	(10, 1, 1, 1000);

-- 1. Dado un correo electrónico, listar todos sus Pedidos entre un rango de fechas.
SET @fecha_inicio = '2021-05-15 18:35:02';
SET @fecha_fin = '2023-05-15 18:35:02';

-- Se utiliza un INNER JOIN debido a que la tabla Contactos posee idPedido como not null, entonces no existe
-- la posibilidad que un correo electronico que existe no posea pedidos.

SELECT nombre, apellido, correoElectronico, codigoPedido, estadoPedido, observaciones, fechaCreado FROM Contactos
	INNER join Pedidos
		on Contactos.idPedido = Pedidos.idPedido
	WHERE 
		correoElectronico="ana@hotmail.com" AND
		fechaCreado BETWEEN @fecha_inicio AND @fecha_fin
	ORDER BY correoElectronico, apellido, nombre, fechaCreado;


-- 2. Realizar un listado de Productos agrupados por categorías.

-- Se utiliza un INNER JOIN debido a que la tabla Productos especifica que el idCategoria es not null, entonces no existe
-- la posibilidad que un producto no posea categorias

SELECT nombreCategoria, nombreProducto FROM Productos INNER JOIN Categoria ON
    Productos.idCategoria = Categoria.idCategoria
	ORDER BY nombreCategoria, nombreProducto;

-- 3. Mostrar la diferencia entre el total de Pedidos realizados y el total Pedidos confirmados para una fecha en particular.

SELECT 
		count(*) as pedidos_realizados,
		count(IF(estadoPedido = 'confirmado', 1, null)) as pedidos_confirmados,
		count(IF(estadoPedido != 'confirmado', 1, null)) as diferencia
    FROM Pedidos;

-- 4. Dado un rango de fechas, mostrar mes a mes el total de Pedidos realizados, el total de
-- Pedidos confirmados y el total de Pedidos rechazados. El formato deberá ser: mes, total de
-- Pedidos, total de confirmados, total de rechazados.

SET @fecha_inicio = '2021-05-15 18:35:02';
SET @fecha_fin = '2023-05-15 18:35:02';

SELECT
		YEAR(fechaCreado) as anio,
		MONTHNAME(fechaCreado) as mes,
        count(estadoPedido) as total,
        count(IF(estadoPedido = 'confirmado', 1, NULL)) as confirmados,
        count(IF(estadoPedido = 'cancelado', 1, NULL)) as rechazados
    FROM Pedidos
    WHERE fechaCreado BETWEEN @fecha_inicio AND @fecha_fin
    GROUP BY anio, mes
    ORDER BY anio, mes;

-- 5. Hacer un ranking con las categorías de Productos que más se piden (por cantidad) entre un rango de fechas.

-- Se utiliza un INNER JOIN debido a que la tabla Productos especifica que el idCategoria es not null, entonces no existe
-- la posibilidad que un producto no posea categorias
-- Se utiliza un INNER JOIN debido a que la tabla LineasPedido especifica que el idProducto es not null, entonces no existe
-- la posibilidad que una LineaPedido tenga un producto null.
-- Se tuvo en cuenta que las categorias que tengan 0 productos en un pedido no se muestren ya que "no pertenecerian a un ranking"

SET @fecha_inicio = '2021-05-15 18:35:02';
SET @fecha_fin = '2023-05-15 18:35:02';
    
SELECT nombreCategoria, sum(cantidad) as cantidad_total FROM Categoria
	INNER JOIN Productos on Categoria.idCategoria = Productos.idCategoria
    INNER JOIN LineasPedido on Productos.idProducto = LineasPedido.idProducto
    WHERE fechaCreado BETWEEN @fecha_inicio AND @fecha_fin
    GROUP BY Categoria.nombreCategoria
    ORDER BY cantidad_total, nombreCategoria DESC
    LIMIT 10;

-- 6. Hacer un ranking con los Productos más Pedidos (por importe) entre un rango de fechas.

-- Se utiliza un INNER JOIN debido a que la tabla LineaPedidos especifica que el idProducto es not null, entonces no existe
-- la posibilidad que una lineaPedido tenga un producto nulo.

SET @fecha_inicio = '2021-05-15 18:35:02';
SET @fecha_fin = '2023-05-15 18:35:02';

SELECT nombreProducto, sum(cantidad) as cantidad_total, sum(cantidad*precioUnitario) as importe FROM LineasPedido
    INNER JOIN Productos P on LineasPedido.idProducto = P.idProducto
    WHERE fechaCreado BETWEEN @fecha_inicio AND @fecha_fin
    GROUP BY P.idProducto, nombreProducto
    ORDER BY importe DESC, cantidad_total DESC
    LIMIT 10;

-- 7. Hacer un ranking con los Productos más Pedidos (por cantidad) entre un rango de fechas.

SET @fecha_inicio = '2021-05-15 18:35:02';
SET @fecha_fin = '2023-05-15 18:35:02';

-- Se utiliza un INNER JOIN debido a que la tabla LineaPedidos especifica que el idProducto es not null, entonces no existe
-- la posibilidad que una lineaPedido tenga un producto nulo.

SELECT nombreProducto, sum(cantidad) as cantidad_total FROM LineasPedido
    INNER JOIN Productos P on LineasPedido.idProducto = P.idProducto
    WHERE fechaCreado BETWEEN @fecha_inicio AND @fecha_fin
    GROUP BY P.idProducto, nombreProducto
    ORDER BY cantidad_total DESC, nombreProducto
    LIMIT 10;

-- 8. Crear una vista con la funcionalidad del apartado 2.
DROP VIEW IF EXISTS view_productos_categorias;

CREATE VIEW view_productos_categorias as
    SELECT nombreCategoria, nombreProducto FROM Productos INNER JOIN Categoria ON
    Productos.idCategoria = Categoria.idCategoria;

SELECT * FROM view_productos_categorias;


-- punto 9
-- Crear una copia de la tabla LineasPedido, que además tenga una columna del tipo
-- JSON para guardar el detalle de las opciones de personalización de ese producto pedido.
-- Llenar esta tabla con los mismos datos del TP1 y resolver la consulta: Dado un producto
-- listar todos los pedidos que tuvo con sus opciones de personalización. (Insertar datos si
-- fuera necesario para que el resultado sea variado)

	-- Formato del json a utilizar
	-- {
	-- 	"cantidad": 50,
	-- 	"precio_unitario": 1000,
	-- 	"nombrePersonalizacion": "Juanjo",
	-- 	"descripcion": "EL mate es rico"
	-- }

	-- Primero se crea la tabla copiada de la anterior
	DROP TABLE IF EXISTS LineasPedidoJson;

	-- Luego se genera la copia de la tabla
	CREATE TABLE IF NOT EXISTS `LBD2022G02PASTELERIA`.`LineasPedidoJson` (
		`idLineasPedido` INT UNSIGNED NOT NULL,
		`idPedido` INT UNSIGNED NOT NULL,
		`idProducto` INT UNSIGNED NOT NULL,
		`cantidad` INT UNSIGNED NOT NULL,
		`precioUnitario` DECIMAL(10,2) NOT NULL,
		`detalles` JSON NULL);

	-- Se genera la inserción de datos a la tabla
    INSERT INTO LineasPedidoJson
        (idLineasPedido, idPedido, idProducto, cantidad, precioUnitario, detalles)
    SELECT
            LP.idLineasPedido,
            LP.idPedido,
            LP.idProducto,
            LP.cantidad,
            LP.precioUnitario,
            IF(LPP.cantidad IS NULL,
                JSON_ARRAY(),
                JSON_ARRAYAGG(
                    JSON_OBJECT(
                        'cantidad', LPP.cantidad,
                        'precioUnitario', LPP.precioUnitario,
                        'nombrePersonalizacion', P.nombrePersonalizacion,
                        'descripcion', P.descripcion,
                        'idPersonalizacion', P.idPersonalizacion
                    )
                )
            )
    FROM LineasPedido LP
        LEFT JOIN LPPersonalizacion LPP
            on LP.idLineasPedido = LPP.idLineasPedido
        LEFT JOIN Personalizacion P
            on LPP.idPersonalizacion = P.idPersonalizacion
            GROUP BY LP.idLineasPedido;

	-- Por ultimo la consulta

    SET @producto_id = 4;

SELECT idPedido,
		nombreProducto,
	    LPJ.cantidad as 'cantidad de producto',
-- 	    LPJ.precioUnitario,
        TablaJSON.cantidad as 'cantidad personalizacion',
        TablaJSON.precioUnitario as 'precio unitario de personalizacion',
        TablaJSON.nombrePersonalizacion as 'personalizacion'
--         TablaJSON.descripcion
    FROM LineasPedidoJson AS LPJ
    LEFT JOIN
        JSON_TABLE(
            detalles, '$[*]' COLUMNS (
               cantidad INT PATH '$.cantidad' NULL ON EMPTY,
               precioUnitario DECIMAL(10,2) PATH '$.precioUnitario'NULL ON EMPTY,
               nombrePersonalizacion VARCHAR (45) PATH '$.nombrePersonalizacion' NULL ON EMPTY,
               descripcion VARCHAR(255) PATH '$.descripcion' NULL ON EMPTY
           ))
        AS TablaJSON ON TRUE
    INNER JOIN Productos P ON P.idProducto = LPJ.idProducto
    WHERE LPJ.idProducto = @producto_id;


-- punto 10
-- Mostrar todos los Productos que tienen opciones de personalizacion

DROP VIEW IF EXISTS view_ver_personalizacion_en_productos;

CREATE VIEW view_ver_personalizacion_en_productos as

SELECT nombreProducto, nombrePersonalizacion FROM Productos
    join PersonalizacionProductos OPP
        on Productos.idProducto = OPP.idProducto
    join Personalizacion OP on OPP.idPersonalizacion = OP.idPersonalizacion;
    
SELECT * FROM view_ver_personalizacion_en_productos;