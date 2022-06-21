-- apuntes que no tengo

-- Control de fechas en la creacion de una tabla
CREATE TABLE Exhibiciones(
    IDExhibicion    INT             NOT NULL,
    Titulo          VARCHAR(50)     NOT NULL,
    Descripcion     VARCHAR(200),
    Inauguracion    DATE            NOT NULL,
    Clausura        DATE,
    PRIMARY KEY (IDExhibicion), 
    INDEX IX_Titulo(Titulo),
    CONSTRAINT chk_1  CHECK (Inauguracion < Clausura),
    CONSTRAINT chk_2 CHECK (Clausura > Inauguracion)
)ENGINE=INNODB
;

-- Check de un atributo en una tabla
CREATE TABLE MateriaPrima(
    IDMateriaPrima    INT            NOT NULL,
    Nombre            VARCHAR(35)    NOT NULL,
    PrecioUnitario    FLOAT    NOT NULL
                      CHECK (PrecioUnitario > 0),
    Unidad            VARCHAR(10)    NOT NULL,
    PRIMARY KEY (IDMateriaPrima), 
    UNIQUE INDEX UI_Nombre(Nombre),
    INDEX Ref29(Unidad), 
    CONSTRAINT RefUnidades9 FOREIGN KEY (Unidad)
    REFERENCES Unidades(Nombre)
)ENGINE=INNODB
;

-- Check entre una lista de valores
CREATE TABLE Propuestas(
    IDPropuesta     CHAR(10)          NOT NULL,
    IDCuadro        INT               NOT NULL,
    IDPintor        INT               NOT NULL,
    IDExhibicion    INT               NOT NULL,
    Fecha           DATE,
    Importe         DECIMAL(12, 2)    NOT NULL
                    CHECK (Importe > 0),
    Persona         VARCHAR(100)      NOT NULL,
    Vendido         CHAR(1)           NOT NULL
                    CHECK (Vendido IN ('S', 'N')),
    PRIMARY KEY (IDPropuesta, IDCuadro, IDPintor, IDExhibicion), 
    UNIQUE INDEX UI_IDPropuesta(IDPropuesta),
    INDEX IX_Fecha(Fecha),
    INDEX IX_Persona(Persona),
    INDEX Ref64(IDCuadro, IDPintor, IDExhibicion), 
    CONSTRAINT RefCertamenes4 FOREIGN KEY (IDCuadro, IDPintor, IDExhibicion)
    REFERENCES Certamenes(IDCuadro, IDPintor, IDExhibicion)
)ENGINE=INNODB
;

-- controlar que lo que se quiere borrar no tenga nada asociado
    IF EXISTS(SELECT IDCuadro FROM Certamenes WHERE IDCuadro = pIDCuadro) THEN 
        LEAVE SALIR; 
	END IF;
    
-- Mostrar nobmres y apellidos en una columna
SELECT 		cua.IDCuadro, cua.Titulo AS Cuadro, met.Metodo, pin.IDPintor, 
			CONCAT(pin.Apellidos, ', ', pin.Nombres) AS Pintor, exh.IDExhibicion,
			exh.Titulo AS Exhibicion, pro.Fecha, pro.Persona, pro.Importe


-- ejemplo con un count
DELIMITER $$
USE DNI$$
CREATE PROCEDURE `TotalPeliculas` ()
BEGIN
	DROP VIEW IF EXISTS aux;
	CREATE VIEW aux AS
	SELECT 		act.idActor, CONCAT(act.Apellidos, ', ', act.Nombres) Actor, COUNT(act.idActor) AS Cantidad
	FROM		Actores act 
	INNER JOIN	ActoresDePeliculas adp ON act.idActor = adp.idActor
	GROUP BY	act.idActor, Actor
	ORDER BY	act.Apellidos, act.Nombres;

	SELECT * FROM aux
	UNION
	SELECT IFNULL(NULL,'---'),IFNULL(NULL,'---'), SUM(aux.Cantidad) FROM aux;
END$$

DELIMITER ;