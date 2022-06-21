USE Parcial1;

-- DELETE FROM Habilidades;
-- DELETE FROM Personas;
-- DELETE FROM Puestos;
-- DELETE FROM Conocimientos;
-- DELETE FROM Categorias;
-- DELETE FROM Niveles;

INSERT INTO `Categorias` (`categoria`, `nombre`) VALUES (1, 'IDIOMA');
INSERT INTO `Categorias` (`categoria`, `nombre`) VALUES (2, '.NET');
INSERT INTO `Categorias` (`categoria`, `nombre`) VALUES (3, 'JAVA');
INSERT INTO `Categorias` (`categoria`, `nombre`) VALUES (4, 'SO');
INSERT INTO `Categorias` (`categoria`, `nombre`) VALUES (5, 'REDES');

INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (1, 1, 'INGLES ORAL');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (2, 1, 'INGLES ESCRITO');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (3, 1, 'FRANCES ORAL');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (4, 1, 'FRANCES ESCRITO');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (5, 2, 'MVC');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (6, 2, 'ASP.NET');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (7, 2, 'VB.NET');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (8, 2, 'C#.NET');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (9, 3, 'J2SE ');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (10, 3, 'Escritorio');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (11, 3, 'WEB');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (12, 3, 'Servicios');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (13, 4, 'W Server 2000');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (14, 4, 'W Server 2003');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (15, 4, 'W Server 2008');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (16, 4, 'Ubuntu');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (17, 4, 'Unix');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (18, 4, 'DOS');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (19, 5, 'Virtualización');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (20, 5, 'LAN');
INSERT INTO `Conocimientos` (`conocimiento`, `categoria`, `nombre`) VALUES (21, 5, 'WAN');

INSERT INTO `Niveles` (`nivel`, `nombre`) VALUES (0, 'Nivel de prueba');
INSERT INTO `Niveles` (`nivel`, `nombre`) VALUES (1, 'Nulo');
INSERT INTO `Niveles` (`nivel`, `nombre`) VALUES (2, 'Básico');
INSERT INTO `Niveles` (`nivel`, `nombre`) VALUES (3, 'Intermedio');
INSERT INTO `Niveles` (`nivel`, `nombre`) VALUES (4, 'Avanzado');
INSERT INTO `Niveles` (`nivel`, `nombre`) VALUES (5, 'Experto');

INSERT INTO `Puestos` (`puesto`, `nombre`) VALUES (1, 'Programador');
INSERT INTO `Puestos` (`puesto`, `nombre`) VALUES (2, 'Analista');
INSERT INTO `Puestos` (`puesto`, `nombre`) VALUES (3, 'Líder');

INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (1, 'Juan', 'Romano', 1, '2009/08/08', null);
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (2, 'Pablo', 'García', 1, '2014/01/01', null);
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (3, 'Miguel', 'Godoy', 1, '2014/01/01', null);
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (4, 'Luis', 'Rolandi', 1, '2014/01/01', null);
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (5, 'Maximiliano', 'Villafañez', 1, '2013/10/01', '2014/11/01');
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (6, 'Alejandro', 'Boixados', 1, '2013/10/01', '2014/10/10');
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (7, 'Cecilia', 'López', 1, '2009/08/08', null);
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (8, 'Alba', 'Gómez', 1, '2013/10/01', '2014/11/01');
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (9, 'Soledad', 'Alderete', 1, '2009/08/08', null);
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (10, 'Alfredo', 'López', 1, '2009/08/08', null);
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (11, 'Romina', 'Torrez', 1, '2009/08/08', null);
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (12, 'Juan', 'Giobellina', 1, '2009/08/08', '2014/10/10');
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (13, 'Sebastián', 'Gómez', 2, '2009/08/08', null);
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (14, 'Martín', 'Gonzáles', 2, '2009/08/08', null);
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (15, 'María Laura', 'Torres', 2, '2009/08/08', null);
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (16, 'Jorge', 'Ibañez', 2, '2009/08/08', null);
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (17, 'Ariel', 'Ceballos', 2, '2009/08/08', '2014/10/10');
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (18, 'Alfredo', 'Alcorta', 3, '2012/10/01', null);
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (19, 'Miguel', 'Algañarás', 3, '2012/10/01', null);
INSERT INTO `Personas` (`persona`, `nombres`, `apellidos`, `puesto`, `fechaIngreso`, `fechaBaja`) VALUES (20, 'Antonio', 'Martínez', 3, '2012/10/01', null);

INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (1, 1, 1, 1, '2014/11/03');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (2, 1, 2, 1, '2014/11/03');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (3, 1, 3, 1, '2014/11/03');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (4, 1, 4, 1, '2014/11/03');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (5, 1, 5, 1, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (6, 1, 6, 2, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (7, 1, 7, 2, '2013/08/12');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (8, 1, 8, 2, '2013/08/12');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (9, 1, 9, 2, '2013/08/12');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (10, 2, 1, 3, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (11, 2, 2, 3, '2013/08/12');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (12, 3, 1, 3, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (13, 3, 2, 4, '2013/08/12');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (14, 4, 1, 4, '2014/04/04');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (15, 4, 2, 4, '2014/04/04');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (16, 4, 3, 5, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (17, 5, 1, 5, '2014/04/04');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (18, 5, 2, 4, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (19, 6, 1, 3, '2014/04/04');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (20, 6, 2, 3, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES (21, 7, 1, 2, '2014/04/04');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('22', 7, 2, 3, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('23', 8, 1, 4, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('24', 9, 2, 5, '2014/04/04');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('25', 10, 1, 3, '2014/04/04');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('26', 10, 2, 3, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('27', 10, 3, 3, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('28', 10, 4, 4, '2014/11/03');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('29', 10, 5, 5, '2014/11/03');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('30', 10, 6, 3, '2014/11/03');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('31', 10, 7, 1, '2014/11/03');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('32', 10, 8, 1, '2014/11/03');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('33', 10, 9, 1, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('34', 10, 10, 2, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('35', 10, 11, 2, '2013/08/12');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('36', 11, 1, 2, '2013/08/12');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('37', 11, 2, 3, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('38', 11, 3, 3, '2013/08/12');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('39', 11, 4, 3, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('40', 11, 5, 4, '2013/08/12');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('41', 11, 6, 4, '2014/04/04');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('42', 11, 7, 5, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('43', 11, 8, 5, '2014/04/04');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('44', 11, 9, 4, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('45', 11, 10, 3, '2014/04/04');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('46', 11, 11, 3, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('47', 11, 12, 2, '2014/04/04');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('48', 11, 13, 3, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('49', 11, 14, 4, '2014/10/01');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`) VALUES ('50', 11, 21, 5, '2014/04/04');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`, `observaciones`) VALUES ('51', 1, 13, 1, '2014/10/01', 'Con Certificacion');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`, `observaciones`) VALUES ('52', 10, 14, 1, '2013/08/12', 'Autodidacta');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`, `observaciones`) VALUES ('53', 11, 16, 4, '2014/10/01', 'Realizando formacion');
INSERT INTO `Habilidades` (`habilidad`, `persona`, `conocimiento`, `nivel`, `fechaUltimaModificacion`, `observaciones`) VALUES ('54', 11, 17, 2, '2013/08/12', 'En uso actualmente');
