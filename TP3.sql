-- Año: 2022
-- Grupo Nro: 02
-- Integrantes: Santiago José Gianotti, Santiago Martin Berretta Gali
-- Tema: Pasteleria Chocolart Web
-- Nombre del esquema: LBD2022G02PASTELERIA
-- Plataforma: Linux Manjaro 2022 | Windows 10
-- Motor y Version: 10.7.3-MariaDB Arch Linux | MySQL community 8.0.22
-- GitHub Repositorio: https://github.com/matiasmendiondo/LBD2022G02
-- GitHub Usuario: SantiagoGianotti, SantiagoB99


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


-- Insercion de datos agregados en el tp2:
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

UPDATE Pedidos SET fechaCreado = '2022-04-16 20:54:59' WHERE idPedido = 6;

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
    
-- TP3
-- Se crea una tabla de auditoria para productos
-- Ahora en el campo "tipo", MN significa modificado nuevo y MV modificado viejo

DROP TABLE IF EXISTS `AuditoriaProductos` ;

CREATE TABLE IF NOT EXISTS `AuditoriaProductos` (
    id INT NOT NULL AUTO_INCREMENT,
    `idProducto` INT UNSIGNED NOT NULL,
    `idCategoria` INT UNSIGNED NOT NULL,
    `activo` TINYINT NOT NULL,
    `nombreProducto` VARCHAR(45) NOT NULL,
    `descripcionProducto` text not null,
    `fechaCreado` DATETIME NOT NULL,
    `tipo` CHAR(2) NOT NULL,
    `usuario` VARCHAR(45) NOT NULL,
    `maquina` VARCHAR(45) NOT NULL,
    `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
);

-- Punto 1 - Trigger de creación de producto
DROP TRIGGER IF EXISTS Trigg_Productos_Insercion;

DELIMITER //
	CREATE TRIGGER Trigg_Productos_Insercion
		AFTER INSERT ON Productos FOR EACH ROW
		BEGIN
			INSERT INTO AuditoriaProductos VALUES (
				DEFAULT,
				NEW.idProducto,
				NEW.idCategoria,
				NEW.activo,
				NEW.nombreProducto,
				NEW.descripcionProducto,
				NEW.fechaCreado,
				'I',
				SUBSTRING_INDEX(USER(), '@', 1),
				SUBSTRING_INDEX(USER(), '@', -1),
				NOW()
		);
	END //
DELIMITER ;

-- Punto 2 -- Trigger de modificacion de producto
DROP TRIGGER IF EXISTS Trigg_Productos_Modificacion;

DELIMITER //
CREATE TRIGGER `Trigg_Productos_Modificacion` 
AFTER UPDATE ON `Productos` FOR EACH ROW
BEGIN
			INSERT INTO AuditoriaProductos VALUES (
				DEFAULT,
				OLD.idProducto,
				OLD.idCategoria,
				OLD.activo,
				OLD.nombreProducto,
				OLD.descripcionProducto,
				OLD.fechaCreado,
				'MV', 
				SUBSTRING_INDEX(USER(), '@', 1), 
				SUBSTRING_INDEX(USER(), '@', -1), 
				NOW()
			);
    -- valores nuevos
			INSERT INTO AuditoriaProductos VALUES (
				DEFAULT,
				NEW.idProducto,
				NEW.idCategoria,
				NEW.activo,
				NEW.nombreProducto,
				NEW.descripcionProducto,
				NEW.fechaCreado,
				'MN',
				SUBSTRING_INDEX(USER(), '@', 1),
				SUBSTRING_INDEX(USER(), '@', -1),
				NOW()
		);
END //
DELIMITER ;


-- Punto 3 -- Trigger de eliminación de producto
DROP TRIGGER IF EXISTS Trigg_Productos_Borrado;


DELIMITER //
	CREATE TRIGGER `Trigg_Productos_Borrado` 
		AFTER DELETE ON Productos FOR EACH ROW
		BEGIN
			INSERT INTO AuditoriaProductos VALUES (
				DEFAULT,
				OLD.idProducto,
				OLD.idCategoria,
				OLD.activo,
				OLD.nombreProducto,
				OLD.descripcionProducto,
				OLD.fechaCreado,
				'B', 
				SUBSTRING_INDEX(USER(), '@', 1), 
				SUBSTRING_INDEX(USER(), '@', -1), 
				NOW()
			);
	END //
DELIMITER ;

-- Punto 4 - Store Procedure de Creado de un Producto
-- Un producto debe pertenecer a una categoria, por lo tanto el idCategoria no puede ser nulo y debe existir
-- Crea un producto siempre y cuando el nombre no sea nulo y no se repita. Ademas la descripcion tampoco puede ser nula

DROP PROCEDURE IF EXISTS CrearProducto;

DELIMITER //
	CREATE PROCEDURE CrearProducto(pIdCategoria INT, pNombreProducto VARCHAR(45), pDescripcionProducto TEXT, OUT pMensaje VARCHAR(100))
	SALIR: BEGIN
		IF (pIdCategoria IS NULL) OR (pNombreProducto IS NULL) OR (pDescripcionProducto IS NULL) THEN
		SET pMensaje = 'Error en los datos del Producto';
        LEAVE SALIR;
	ELSEIF (NOT EXISTS( SELECT idCategoria FROM Categoria WHERE idCategoria = pIdCategoria LIMIT 1) ) THEN
            SET pMensaje = 'No existe la categoria ingresada';
            LEAVE SALIR;
	ELSEIF EXISTS (SELECT * FROM Productos WHERE nombreProducto = pNombreProducto) THEN
		SET pMensaje = 'Ya existe un producto con ese nombre';
        LEAVE SALIR;
        
	ELSE
		START TRANSACTION;
			INSERT INTO Productos(idCategoria, activo, nombreProducto, descripcionProducto) values (pIdCategoria, 1, pNombreProducto, pDescripcionProducto);
            SET pMensaje = 'Producto creado con éxito';
		COMMIT;		
    END IF;
END //
DELIMITER ;



-- Falla por ingresar una categoria nula
CALL CrearProducto(Null,'Mini Torta Oreo', 'Version miniatura de la torta oreo', @mensaje);
SELECT @mensaje;

-- Falla por ingresar un nombre nulo
CALL CrearProducto(13,Null, 'Version miniatura de la torta oreo', @mensaje);
SELECT @mensaje;

-- Falla por ingresar una categoria inexistente
CALL CrearProducto(999,'Mini Torta Oreo', 'Version miniatura de la torta oreo', @mensaje);
SELECT @mensaje;

-- Creacion exitosa de un producto
CALL CrearProducto(13,'Mini Torta Oreo', 'Version miniatura de la torta oreo', @mensaje);
SELECT @mensaje;


-- Punto 5 - Store Procedure de Modificado de un Producto
-- Un producto debe pertenecer a una categoria, por lo tanto el idCategoria no puede ser nulo y debe existir
-- Se modifica un producto siempre y cuando el producto no seas nulo y exista, el nombre del nuevo producto ingresado no sea nulo y no se repita, y la descripcion tampoco sea nula.

DROP PROCEDURE IF EXISTS ModificarProducto;

DELIMITER //
	CREATE PROCEDURE ModificarProducto(pIdProducto INT, pIdCategoria INT, pNombreProducto VARCHAR(45), pDescripcionProducto TEXT, OUT pMensaje VARCHAR(100))
	SALIR: BEGIN
		IF (pIdProducto IS NULL) OR (pIdCategoria IS NULL AND pNombreProducto IS NULL AND pDescripcionProducto IS NULL) THEN
		SET pMensaje = 'Error en los datos del Producto';
        LEAVE SALIR;
	ELSEIF (NOT EXISTS( SELECT iDProducto FROM Productos WHERE idProducto = pIdProducto LIMIT 1) ) THEN
            SET pMensaje = 'No existe el producto para modificar';
            LEAVE SALIR;
	ELSEIF EXISTS (SELECT * FROM Productos WHERE nombreProducto = pNombreProducto) THEN
		SET pMensaje = 'Ya existe un producto con ese nombre';
        LEAVE SALIR;   
	ELSEIF(pIdCategoria IS NULL) THEN
            SELECT idCategoria INTO pIdCategoria FROM Productos WHERE idProducto = pIdProducto;
            END IF;
	IF(pNombreProducto IS NULL) THEN
            SELECT nombreProducto INTO pNombreProducto FROM Productos WHERE idProducto = pIdProducto;
        END IF;
	IF(pDescripcionProducto IS NULL) THEN
            SELECT descripcionProducto INTO pDescripcionProducto FROM Productos WHERE idProducto = pIdProducto;
        END IF;
	IF (NOT EXISTS( SELECT idCategoria FROM Categoria WHERE idCategoria = pIdCategoria LIMIT 1) ) THEN
            SET pMensaje = 'No existe la categoria ingresada';
            LEAVE SALIR;     
	ELSE
		START TRANSACTION;
			UPDATE Productos SET
            idCategoria=pIdCategoria,
            nombreProducto=pNombreProducto,
            descripcionProducto=pDescripcionProducto
            WHERE idProducto = pIdProducto;
            SET pMensaje = 'Producto modificado con éxito';
		COMMIT;		
    END IF;
END //
DELIMITER ;

-- Insercion de un producto para modificarlo y probar el sp
INSERT INTO Productos
    (idCategoria, activo, nombreProducto, descripcionProducto) values
    (4, 1, 'Torta Brownie', 'Delicia que está compuesta por una fina base de brownie, cubierta con una capa de dulce de leche y por último unos delicados copos de merengue italiano'),
	(4, 1, 'Torta Chocolate Blanco', 'asass');
    
-- Falla por ingresar un producto nulo
CALL ModificarProducto(NULL,13,'Mini Torta Brownie', 'Version miniatura de la torta brownie', @mensaje);
SELECT @mensaje;

-- Falla por ingresar un nombre repetido
CALL ModificarProducto(23,13,'Mini Torta Oreo', 'Version miniatura de la torta Brownie', @mensaje);
SELECT @mensaje;

-- Falla por elegir un producto inexistente
CALL ModificarProducto(999, 13,'Mini Torta Brownie', 'Version miniatura de la torta Brownie', @mensaje);
SELECT @mensaje;

-- Falla por ingresar una categoria inexistente
CALL ModificarProducto(23, 999,'Mini Torta Brownie', 'Version miniatura de la torta Brownie', @mensaje);
SELECT @mensaje;

-- No pueden ser todos los atributos a modificar nulos
CALL ModificarProducto(24,NULL,NULL, NULL, @mensaje);
SELECT @mensaje;

-- Se modifica solo la descripcion exitosamente
CALL ModificarProducto(24,NULL,NULL, 'Torta rellena y cubierta de chocolate blanco', @mensaje);
SELECT @mensaje;

-- Se modifica solo el nombre exitosamente
CALL ModificarProducto(24,NULL,'Proucto de prueba', NULL, @mensaje);
SELECT @mensaje;

-- Se modifican todos los atributos de un producto exitosamente
CALL ModificarProducto(23, 13,'Mini Torta Brownie', 'Version miniatura de la torta Brownie', @mensaje);
SELECT @mensaje;



-- Punto 6 - Stored Procedure de Borrado de un Producto

DROP PROCEDURE IF EXISTS BorrarProducto;

DELIMITER //
    CREATE PROCEDURE BorrarProducto(pIdProducto INT, OUT pMensaje VARCHAR(100))
    SALIR: BEGIN

        IF ( NOT EXISTS( SELECT idProducto FROM Productos WHERE idProducto = pIdProducto ) ) THEN
            SET pMensaje = 'Este producto no existe';
            LEAVE SALIR;
        ELSEIF ( EXISTS( SELECT idLineasPedido FROM LineasPedido WHERE idProducto = pIdProducto LIMIT 1) ) THEN
            SET pMensaje = 'No se puede borrar un producto que tiene pedidos';
            LEAVE SALIR;
        ELSEIF ( EXISTS( SELECT idProducto FROM PersonalizacionProductos WHERE idProducto = pIdProducto LIMIT 1) ) THEN
            SET pMensaje = 'No se puede borrar un producto que tiene opciones de personalizacion';
            LEAVE SALIR;
        END IF;

        DELETE FROM Productos WHERE idProducto = pIdProducto;

        SET pMensaje = 'Borrado Exitoso';
        LEAVE SALIR;
    END //
DELIMITER ;


-- Falla por que no existe el producto
CALL BorrarProducto(555, @mensaje);
SELECT @mensaje;

-- Falla por pertenecer a un pedido
CALL BorrarProducto(1, @mensaje);
SELECT @mensaje;

-- Falla por tener opciones de personalizacion
CALL BorrarProducto(15, @mensaje);
SELECT @mensaje;

-- Este borrado sera exitoso
CALL BorrarProducto(12, @mensaje);
SELECT @mensaje;

-- Punto 7

DROP PROCEDURE IF EXISTS BuscarProductos;

DELIMITER //
    CREATE PROCEDURE BuscarProductos(pNombreProducto VARCHAR(45), pNombreCategoria VARCHAR(45), OUT pMensaje VARCHAR(100))
    SALIR: BEGIN

        IF ( NOT EXISTS( SELECT idProducto FROM Productos WHERE Productos.nombreProducto LIKE CONCAT(pNombreProducto,'%') LIMIT 1 ) ) THEN
            SET pMensaje = 'No existen productos con este nombre';
            LEAVE SALIR;
        ELSEIF ( NOT EXISTS( SELECT Categoria.idCategoria FROM Categoria WHERE Categoria.nombreCategoria LIKE CONCAT(pNombreCategoria, '%') LIMIT 1) ) THEN
            SET pMensaje = 'No existen categorias con este nombre';
            LEAVE SALIR;
        ELSEIF ( NOT EXISTS(
            SELECT idProducto FROM Productos JOIN Categoria C2 on Productos.idCategoria = C2.idCategoria
            WHERE
                  Productos.activo = 1 AND
                  Productos.nombreProducto LIKE CONCAT(pNombreProducto,'%') AND
                  C2.nombreCategoria LIKE CONCAT(pNombreCategoria, '%')
            LIMIT 1
            )) THEN
                SET pMensaje = 'No se encontraron resultados';
                LEAVE SALIR;
        END IF;

        SELECT idProducto, Productos.idCategoria, nombreProducto, nombreCategoria, fechaCreado FROM Productos
            JOIN Categoria C on Productos.idCategoria = C.idCategoria
            WHERE
                  Productos.activo = 1 AND
                  Productos.nombreProducto LIKE CONCAT(pNombreProducto,'%') AND
                  C.nombreCategoria LIKE CONCAT(pNombreCategoria, '%')
        ORDER BY nombreCategoria, nombreProducto;

        SET pMensaje = 'Se encontraron resultados';
        LEAVE SALIR;
    END //
DELIMITER ;

-- Trae todos los productos porque no hay criterio de busqueda
CALL BuscarProductos('', '', @param);
SELECT @param;

-- Traer los productos que empiezan con asdasd ( no existe ninguno )
CALL BuscarProductos('asdasd', 's', @param);
SELECT @param;

-- Traer los productos que empiezan con nombre de categoria asdasd ( no existe ninguno )
CALL BuscarProductos('', 'sASDASD', @param);
SELECT @param;

-- Traer los productos que empiezan con nombre de categoria asdasd ( no existe ninguno )
CALL BuscarProductos('tar', 'sand', @param);
SELECT @param;


-- Traer los productos que empiezan con t
CALL BuscarProductos('t', '', @param);
SELECT @param;

-- Traer los productos que empiezan con t y pertenecen a una categoria que tambien empiece con t
CALL BuscarProductos('t', 't', @param);
SELECT @param;

-- Traer los productos que empiezan con t y pertenecen a una categoria que empiece con s
CALL BuscarProductos('t', 's', @param);
SELECT @param;

-- Punto 8 - Listado de productos, ordenados por el criterio que considere más adecuado.
-- Se ordena solo por el nombre, pues no existirán 2 productos iguales por ende no tiene sentido ordenar con otro criterio despues del nombre

-- Ingresando el parametro 'inactivos' como 1 se muestran todos los productos incluidos los inactivos, y solo los activos si se ingresa 0

DROP PROCEDURE IF EXISTS ListarProductos;

DELIMITER //
	CREATE PROCEDURE ListarProductos(inactivos TINYINT (1), OUT pMensaje VARCHAR(100))
	SALIR: BEGIN
		IF(inactivos IS NULL) OR (inactivos!=0 AND inactivos!=1) THEN
			SET pMensaje = 'El parametro ingresado no es valido';
        LEAVE SALIR;
        
		ELSEIF(inactivos=1) THEN 
			SELECT nombreProducto, descripcionProducto, fechaCreado, activo FROM Productos
				ORDER BY activo DESC, nombreProducto ASC;
			SET pMensaje = 'Consulta exitosa';
			LEAVE SALIR;
		
		ELSEIF(inactivos=0) THEN
			SELECT nombreProducto, descripcionProducto, fechaCreado, activo FROM Productos
				WHERE activo = 1
				ORDER BY activo DESC, nombreProducto ASC;
			SET pMensaje = 'Consulta exitosa';
			LEAVE SALIR;
		END IF;
    END //
DELIMITER ;

-- Se insertan productos dado de baja asi la consulta es mas distinguible

INSERT INTO Productos
    (idCategoria, activo, nombreProducto, descripcionProducto) values
    (9, 0, 'Combo 6', '1 Huevo Triple Tentación + 1 Huevo Brownie'),
    (9, 0, 'Combo 7', '2 Sanguches de Jamon y Queso + 2 sanguches Salame y Queso'),
    (9, 0, 'Combo 8', 'Tarta de frutilla + Tarta Lemon Pie'),
    (9, 0, 'Combo 9', '10 alfajores de maicena, 10 minitortas dulce de leche, 10 corazones de dulce de leche bañados en chocolate blanco');


CALL ListarProductos(5, @mensaje);
SELECT @mensaje;

CALL ListarProductos(NULL, @mensaje);
SELECT @mensaje;

CALL ListarProductos(1, @mensaje);
SELECT @mensaje;

CALL ListarProductos(0, @mensaje);
SELECT @mensaje;

-- Punto 9

DROP PROCEDURE IF EXISTS ListarProductosEnPedidos;

DELIMITER //
    CREATE PROCEDURE ListarProductosEnPedidos( pProducto_id INT , pFechaInicio DATETIME, pFechaFin DATETIME, OUT pMensaje VARCHAR(100))
    SALIR: BEGIN

        IF(pFechaFin < pFechaInicio) THEN
            SET pMensaje = 'La fecha de fin no puede ser menor a la de inicio';
            LEAVE SALIR;
        ELSEIF(pFechaInicio = pFechaFin) THEN
            SET pMensaje = 'La fecha de fin no puede igual a la de inicio';
            LEAVE SALIR;
        ELSEIF(NOT EXISTS(SELECT idProducto FROM Productos WHERE idProducto = pProducto_id LIMIT 1)) THEN
            SET pMensaje = 'El producto no existe';
            LEAVE SALIR;
        ELSEIF(NOT EXISTS(SELECT idProducto FROM LineasPedido WHERE idProducto = pProducto_id LIMIT 1)) THEN
            SET pMensaje = 'El producto no pertenece a ningun pedido';
            LEAVE SALIR;
        END IF;

        SELECT Productos.nombreProducto, Pedidos.idPedido, Pedidos.codigoPedido, LineasPedido.precioUnitario, LineasPedido.cantidad, Pedidos.fechaCreado  FROM Productos
            JOIN LineasPedido ON Productos.idProducto = LineasPedido.idProducto
            JOIN Pedidos ON LineasPedido.idPedido = Pedidos.idPedido
            WHERE
                  Productos.idProducto = pProducto_id AND
                  Pedidos.fechaCreado BETWEEN pFechaInicio AND pFechaFin
            ORDER BY Pedidos.fechaCreado;


        SET pMensaje = 'Consulta exitosa';
        LEAVE SALIR;
    END //
DELIMITER ;

SET @fecha_inicio = '2021-01-15 18:35:02';
SET @fecha_fin = '2023-12-15 18:35:02';

-- Falla por tener iguales las fechas de inicio y fin
CALL ListarProductosEnPedidos(1, @fecha_inicio, @fecha_inicio, @mensaje);
SELECT @mensaje;

-- Falla por tener fecha de fin menor a la de inicio
CALL ListarProductosEnPedidos(1, @fecha_fin, @fecha_inicio, @mensaje);
SELECT @mensaje;

-- Falla por que no existe el producto
CALL ListarProductosEnPedidos(999, @fecha_inicio, @fecha_fin, @mensaje);
SELECT @mensaje;

-- Falla por que no existe el producto en un pedido
CALL ListarProductosEnPedidos(20, @fecha_inicio, @fecha_fin, @mensaje);
SELECT @mensaje;

-- Exito
CALL ListarProductosEnPedidos(1, @fecha_inicio, @fecha_fin, @mensaje);
SELECT @mensaje;


-- Punto 10 - Realizar un procedimiento almacenado con alguna funcionalidad que considere de interés.
-- Dada una categoria, ponerla en estado inactivo
/*
    Permite cambiar el estado de una Categoria a '0' si no se encuentra en
    ese estado. No se puede poner en inactivo una Categoria que tiene productos asociados
    en estado '1'. Controla que los parametros ingresados sean correctos.
    Devuelve OK o el mensaje de error en Mensaje.
*/

DROP PROCEDURE IF EXISTS BajaCategoria;

DELIMITER //
CREATE PROCEDURE BajaCategoria(pIdCategoria INT, OUT pMensaje VARCHAR(100))
	SALIR: BEGIN
		IF (pIdCategoria IS NULL) THEN
			SET pMensaje = 'Error en el dato ingresado';
			LEAVE SALIR;
		ELSEIF(NOT EXISTS(SELECT idCategoria FROM Categoria WHERE idCategoria = pIdCategoria) ) THEN
            SET pMensaje = 'Esta categoria no existe';
            LEAVE SALIR;
		ELSEIF(EXISTS(SELECT idCategoria FROM Categoria WHERE idCategoria = pIdCategoria AND activo = 0)) THEN
			SET pMensaje = 'Esta categoria ya esta inactiva';
            LEAVE SALIR;
		ELSEIF(EXISTS(SELECT c.idCategoria FROM Categoria c INNER JOIN Productos p ON c.idCategoria = p.idCategoria
				WHERE c.idCategoria = pIdCategoria AND p.activo = 1)) THEN
			SET pMensaje = 'Esta categoria posee productos activos';
            LEAVE SALIR;
		END IF;
        
	UPDATE Categoria SET activo = 0 WHERE idCategoria = pIdCategoria;
    
	SET pMensaje = 'La categoria fue dada de baja con éxito';
    LEAVE SALIR;
    END //
DELIMITER ;

-- Ingreso una categoria inactiva para probar
INSERT INTO Categoria (idCategoria, idPadre, activo, nombreCategoria) values (21, 1, 0, 'Golosinas');

-- Ingreso una productos inactivos a una categoria para probar
INSERT INTO Productos (idCategoria, activo, nombreProducto, descripcionProducto) values (14, 0, 'Pico Dulce', 'Chupetin duro y colorido, de hasta 10 a 15 cm de alto, de forma cónica o piramidal con punta muy aguda, con un palito de plástico en la base que sirve para sostenerlo, y que viene envuelto en papel plástico transparente');


-- Falla por que la categoria no existe
CALL BajaCategoria(999, @mensaje);
SELECT @mensaje;

-- Falla porque la categoria ya está inactiva
CALL BajaCategoria(21, @mensaje);
SELECT @mensaje;

-- Falla porque la categoria posee productos inactivos
CALL BajaCategoria(21, @mensaje);
SELECT @mensaje;

-- La categoria tiene productos inactivos y es dada de baja con exito
CALL BajaCategoria(14, @mensaje);
SELECT @mensaje;
