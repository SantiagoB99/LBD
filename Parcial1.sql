-- MySQL Script generated by MySQL Workbench
-- Mon Jun 20 16:49:24 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Parcial1
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Parcial1` ;

-- -----------------------------------------------------
-- Schema Parcial1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Parcial1` DEFAULT CHARACTER SET utf8 ;
USE `Parcial1` ;

-- -----------------------------------------------------
-- Table `Parcial1`.`Categorias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial1`.`Categorias` ;

CREATE TABLE IF NOT EXISTS `Parcial1`.`Categorias` (
  `categoria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`categoria`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Parcial1`.`Conocimientos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial1`.`Conocimientos` ;

CREATE TABLE IF NOT EXISTS `Parcial1`.`Conocimientos` (
  `conocimiento` INT NOT NULL,
  `categoria` INT NOT NULL,
  `nombre` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`conocimiento`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC),
  INDEX `fk_Conocimientos_Categorias_idx` (`categoria` ASC),
  CONSTRAINT `fk_Conocimientos_Categorias`
    FOREIGN KEY (`categoria`)
    REFERENCES `Parcial1`.`Categorias` (`categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Parcial1`.`Niveles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial1`.`Niveles` ;

CREATE TABLE IF NOT EXISTS `Parcial1`.`Niveles` (
  `nivel` INT NOT NULL,
  `nombre` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`nivel`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Parcial1`.`Puestos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial1`.`Puestos` ;

CREATE TABLE IF NOT EXISTS `Parcial1`.`Puestos` (
  `puesto` INT NOT NULL,
  `nombre` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`puesto`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Parcial1`.`Personas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial1`.`Personas` ;

CREATE TABLE IF NOT EXISTS `Parcial1`.`Personas` (
  `persona` INT NOT NULL,
  `nombres` VARCHAR(25) NOT NULL,
  `apellidos` VARCHAR(25) NOT NULL,
  `puesto` INT NOT NULL,
  `fechaIngreso` DATE NOT NULL,
  `fechaBaja` DATE NULL,
  PRIMARY KEY (`persona`),
  INDEX `fk_Personas_Puestos1_idx` (`puesto` ASC),
  CONSTRAINT `fk_Personas_Puestos1`
    FOREIGN KEY (`puesto`)
    REFERENCES `Parcial1`.`Puestos` (`puesto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Parcial1`.`Habilidades`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parcial1`.`Habilidades` ;

CREATE TABLE IF NOT EXISTS `Parcial1`.`Habilidades` (
  `habilidad` INT NOT NULL,
  `persona` INT NOT NULL,
  `conocimiento` INT NOT NULL,
  `nivel` INT NOT NULL,
  `fechaUltimaModificacion` DATE NOT NULL,
  `observaciones` VARCHAR(200) NULL,
  PRIMARY KEY (`habilidad`),
  INDEX `fk_Habilidades_Personas1_idx` (`persona` ASC),
  INDEX `fk_Habilidades_Conocimientos1_idx` (`conocimiento` ASC),
  INDEX `fk_Habilidades_Niveles1_idx` (`nivel` ASC),
  UNIQUE INDEX `conocimientos_iguales` (`persona` ASC, `conocimiento` ASC),
  CONSTRAINT `fk_Habilidades_Personas1`
    FOREIGN KEY (`persona`)
    REFERENCES `Parcial1`.`Personas` (`persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Habilidades_Conocimientos1`
    FOREIGN KEY (`conocimiento`)
    REFERENCES `Parcial1`.`Conocimientos` (`conocimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Habilidades_Niveles1`
    FOREIGN KEY (`nivel`)
    REFERENCES `Parcial1`.`Niveles` (`nivel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- 2) Crear una vista llamada VHabilidades que muestre las personas, nombre del puesto,
-- nombre del conocimiento y nombre del nivel. El formato de salida deberá ser Apellidos,
-- Nombres, Puesto, Conocimiento, Nivel, y la lista deberá estar ordenada por apellidos y
-- nombres. Incluir el código con la consulta a la vista. [20 puntos]

DROP VIEW IF EXISTS VHabilidades;

CREATE VIEW VHabilidades as
    SELECT Personas.apellidos as Apellidos, Personas.nombres as Nombres, Puestos.nombre as Puesto, Conocimientos.nombre as Conocimiento, Niveles.nombre as Nivel
    FROM Puestos INNER JOIN Personas ON
    Puestos.puesto = Personas.puesto
    INNER JOIN Habilidades ON
    Personas.persona = Habilidades.persona
    INNER JOIN Niveles ON
    Habilidades.nivel = Niveles.nivel
    INNER JOIN Conocimientos ON
    Habilidades.conocimiento = Conocimientos.conocimiento
    ORDER BY Apellidos ASC, Nombres ASC;

SELECT * FROM VHabilidades;

-- 3) Realizar un procedimiento almacenado llamado NuevaPersona para dar de alta una
-- persona, incluyendo el control de errores lógicos y mensajes de error necesarios (puesto,
-- apellidos, nombres y fecha de ingreso no deben ser nulos, el puesto debe existir, no debe
-- existir otra persona con el identificador de la persona que se quiere agregar). Incluir el
-- código con la llamada al procedimiento probando todos los casos con datos incorrectos y
-- uno con datos correctos. [20 puntos]

DROP PROCEDURE IF EXISTS NuevaPersona;

DELIMITER //
	CREATE PROCEDURE NuevaPersona(pPersona INT, pNombres VARCHAR(25), pApellidos VARCHAR(25), pPuesto INT, pFechaIngreso DATE, pFechaBaja DATE, OUT pMensaje VARCHAR(100))
	SALIR: BEGIN
		IF (pPersona IS NULL) OR (pPuesto IS NULL) OR (pApellidos IS NULL) OR (pNombres IS NULL) OR (pFechaIngreso IS NULL) THEN
		SET pMensaje = 'Error en los datos del Producto';
        LEAVE SALIR;
	ELSEIF (NOT EXISTS( SELECT puesto FROM Puestos WHERE puesto = pPuesto LIMIT 1) ) THEN
            SET pMensaje = 'No existe el puesto ingresado';
            LEAVE SALIR;
	ELSEIF EXISTS (SELECT * FROM Personas WHERE persona = pPersona) THEN
		SET pMensaje = 'Ya existe una persona con ese id';
        LEAVE SALIR;
        
	ELSE
		START TRANSACTION;
			INSERT INTO Personas(persona, nombres, apellidos, puesto, fechaIngreso, fechaBaja) VALUES (pPersona, pNombres, pApellidos, pPuesto, pFechaIngreso, pFechaBaja);
            SET pMensaje = 'Persona ingresadacon éxito';
		COMMIT;		
    END IF;
END //
DELIMITER ;

-- Falla por ingresar una persona nula
CALL NuevaPersona(null, 'Juan', 'Romano', 1, '2009/08/08', null, @mensaje);
SELECT @mensaje;

-- Falla por ingresar un puesto nulo
CALL NuevaPersona(1, 'Juan', 'Romano', null, '2009/08/08', null, @mensaje);
SELECT @mensaje;

-- Falla por ingresar un apellido nulo
CALL NuevaPersona(1, 'Juan', null, 1, '2009/08/08', null, @mensaje);
SELECT @mensaje;

-- Falla por ingresar un nombre nulo
CALL NuevaPersona(1, null, 'Romano', 1, '2009/08/08', null, @mensaje);
SELECT @mensaje;

-- Falla por ingresar una fecha nula
CALL NuevaPersona(1, 'Juan', 'Romano', 1, null, null, @mensaje);
SELECT @mensaje;

-- Falla por ingresar un puesto inexistente
CALL NuevaPersona(80, 'Pepe', 'Tito', 999, '2010/08/08', null, @mensaje);
SELECT @mensaje;

-- Falla por ingresar una persona que ya existe
CALL NuevaPersona(1, 'Juan', 'Romano', 1, '2009/08/08', null, @mensaje);
SELECT @mensaje;

-- Creacion exitosa de un producto
CALL NuevaPersona(80, 'Pepe', 'Tito', 1, '2010/08/08', null, @mensaje);
SELECT @mensaje;

-- 4) Realizar un procedimiento almacenado llamado PersonasConConocimiento que reciba
-- el identificador de una categoría y de un conocimiento, y devuelva la cantidad de personas
-- con el conocimiento y categoría especificados, y el nivel de los mismos. El formato de salida
-- deberá ser Categoría (el nombre), Conocimiento (el nombre), Nivel (el nombre) y Personas
-- (la cantidad). Incluir en el código la llamada al procedimiento. [15 puntos]

DROP PROCEDURE IF EXISTS PersonasConConocimiento;

DELIMITER //
	CREATE PROCEDURE PersonasConConocimiento(pCategoria INT, pConocimiento INT)
	SALIR: BEGIN
		SELECT Categorias.nombre as Categoria, Conocimientos.nombre as Conocimiento, Niveles.nombre as Nivel, count(*)FROM Personas INNER JOIN Habilidades ON
    Personas.persona = Habilidades.persona
    INNER JOIN Niveles ON
    Habilidades.nivel = Niveles.nivel
    INNER JOIN Conocimientos ON
    Habilidades.conocimiento = Conocimientos.conocimiento
    INNER JOIN Categorias ON
    Conocimientos.categoria = Categorias.categoria
    WHERE Categorias.categoria = pCategoria AND Conocimientos.conocimiento = pConocimiento
    GROUP BY Niveles.nombre
    ORDER BY count(*) DESC, Nivel ASC;
END //
DELIMITER ;

CALL PersonasConConocimiento(1,1);

-- 5) Utilizando triggers, implementar la lógica para que en caso que se quiera borrar un nivel,
-- y exista alguna habilidad con el mismo, se informe mediante un mensaje de error que no se
-- puede. Incluir el código con el borrado de un nivel para el cual no hay habilidades, y otro
-- para el que sí. [20 puntos]

DROP TRIGGER IF EXISTS Trigg_Nivel_Borrado;

DELIMITER //
	CREATE TRIGGER Trigg_Nivel_Borrado
		BEFORE DELETE ON Niveles FOR EACH ROW
		BEGIN
			IF EXISTS (SELECT * FROM Habilidades WHERE Habilidades.nivel = OLD.nivel) THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Hay una habilidad asociado al nivel que se quiere eliminar';
			END IF;			
	END //
DELIMITER ;

DELETE FROM Niveles WHERE nivel=1;
INSERT INTO Niveles VALUES (6, 'Negativo');
DELETE FROM Niveles WHERE nivel=6;