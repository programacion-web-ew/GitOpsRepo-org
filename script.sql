use biblioteca1;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS prestamos;
DROP TABLE IF EXISTS libros;
DROP TABLE IF EXISTS autores;
DROP TABLE IF EXISTS usuarios;
DROP TABLE IF EXISTS categoria;
DROP TABLE IF EXISTS nacionalidad;

-- 1. Tabla nacionalidad
CREATE TABLE nacionalidad (
    id_nacionalidad INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

-- 2. Tabla categoria
CREATE TABLE categoria (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

-- 3. Tabla autores
CREATE TABLE autores (
    id_autor INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    id_nacionalidad INT,
    fecha_nacimiento DATE,
    FOREIGN KEY (id_nacionalidad) REFERENCES nacionalidad(id_nacionalidad)
);

-- 4. Tabla usuarios
CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(20),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BIT(1)
);

-- 5. Tabla libros
CREATE TABLE libros (
    id_libro INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(200) NOT NULL,
    id_autor INT NOT NULL,
    anio_publicacion INT,
    id_categoria INT NOT NULL,
    existencias INT NOT NULL,
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor),
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

-- 6. Tabla prestamos
CREATE TABLE prestamos (
    id_prestamo INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_libro INT NOT NULL,
    fecha_prestamo TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_devolucion TIMESTAMP,
    fecha_entrega TIMESTAMP,
    estado ENUM('PRESTADO', 'DEVUELTO', 'VENCIDO', 'ARCHIVADO') DEFAULT 'PRESTADO',
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_libro) REFERENCES libros(id_libro)
);

-- Habilitar la verificación de claves foráneas (útil para MySQL)
SET FOREIGN_KEY_CHECKS = 1;


-- 1. Insertar datos en la tabla `nacionalidad`
INSERT INTO nacionalidad (id_nacionalidad, nombre) VALUES
(2, 'Argentina'),
(7, 'Británica'),
(3, 'Chilena'),
(1, 'Colombiana'),
(5, 'España'),
(6, 'Japonesa'),
(4, 'Peruana');

-- 2. Insertar datos en la tabla `categoria`
INSERT INTO categoria (id_categoria, nombre) VALUES
(6, 'Ciencia ficción'),
(7, 'Fantasia'),
(4, 'Ficción contemporánea'),
(3, 'Misterio'),
(1, 'Novela'),
(2, 'Relatos'),
(5, 'Romance');

-- 3. Insertar datos en la tabla `autores`
INSERT INTO autores (id_autor, nombre, id_nacionalidad, fecha_nacimiento) VALUES
(1, 'Gabriel García Márquez', 1, '1927-03-06'),
(2, 'Julio Cortázar', 2, '1914-08-26'),
(3, 'Isabel Allende', 3, '1942-08-02'),
(4, 'Mario Vargas Llosa', 4, '1936-03-28'),
(5, 'Jorge Luis Borges', 2, '1899-08-24'),
(6, 'Carlos Ruiz Zafón', 5, '1964-09-25'),
(7, 'Haruki Murakami', 6, '1949-01-12'),
(8, 'Jane Austen', 7, '1775-12-16'),
(9, 'George Orwell', 7, '1903-06-25'),
(10, 'J.K. Rowling', 7, '1965-07-30'),
(11, 'nuevoautor', 3, '2025-04-17'),
(12, 'nuevoautor 2', 4, '1992-11-11'),
(13, 'autornuevo', 5, '2025-04-14'),
(14, 'Edison Williams', 7, '2025-04-25'),
(15, 'Nombre vaco', 5, NULL),
(16, 'nuevoautorjnjasd', 3, '2025-05-09');

-- 4. Insertar datos en la tabla `usuarios`
-- -- Nota: La columna 'activo' es BIT(1). '0' o '1' son valores válidos.
-- Las fechas de registro se insertan tal cual, aunque TIMESTAMP DEFAULT CURRENT_TIMESTAMP las generaría.
INSERT INTO usuarios (id_usuario, nombre, correo, telefono, fecha_registro, activo) VALUES
(1, 'Juan Pérez', 'juan.perez@email.com', '3001234567', '2025-04-13 19:37:44', b'0'),
(2, 'María Gómeza', 'maria.gomez@email.com', '3107654321', '2025-04-13 19:37:44', b'0'),
(3, 'Carlos Rodríguez', 'carlos.rodriguez@email.com', '3209876541', '2025-04-13 19:37:44', b'0'),
(4, 'ususario', 'usuario@correo.com', '31212135564', '2025-04-13 20:00:41', b'1'),
(5, 'Juan Pérez 1', 'juan.pere 1z@email.com', '3001234567', '2025-04-13 20:02:01', b'0'),
(6, 'Nuevo usuario', 'nuevousuario@correo.com', '3001234567', '2025-04-18 13:17:55', NULL), -- El valor es NULL en la imagen
(7, 'usernew', 'usernew@email.com', '3113123231', '2025-04-18 18:10:33', b'1'),
(9, 'nuevoautor 1', 'nuevo.autor@email.com', '3121354165', '2025-04-26 10:24:27', b'1'),
(10, 'Juan Perez', 'juan.perez@example.com', '3001234567', '2025-05-11 12:46:56', b'1'),
(11, 'Maria Lopez', 'maria.lopez@example.com', '3009876543', '2025-05-11 12:46:56', b'1'),
(12, 'Carlos Garcia', 'carlos.garcia@test.com', NULL, '2025-05-11 12:46:56', b'1'), -- Teléfono es NULL en la imagen
(13, 'Laura Gomez', 'laura.gomez@dominio.org', '3101122334', '2025-05-11 12:46:56', b'1'),
(14, 'Ana Diaz', 'ana.diaz@example.com', '3005551212', '2025-05-11 12:46:56', b'1'),
(15, 'J.K. Rowlingww ...', 'carlosawasda.rodriguez@e ...', '3209876543', '2025-05-15 22:15:34', b'1'), -- Valores truncados en la imagen
(16, 'Juan 1 Perez', 'juan2.perez@example.com', '3001234567', '2025-05-15 22:26:38', b'1'),
(17, 'Ana 122 Diaz', 'ana234234.diaz@example ....', '3005551212', '2025-05-15 22:26:38', b'1'), -- Valores truncados en la imagen
(18, 'nuevoautorasda', 'carlos 131.rodriguez@email ...', '32135465841', '2025-05-15 23:13:35', b'1'), -- Valores truncados en la imagen
(19, 'Roberto Gomez', 'roberto.gomez@nuevaemp ...', '3119876543', '2025-05-15 23:13:44', b'1'); -- Valores truncados en la imagen

-- 5. Insertar datos en la tabla `libros`
-- -- Nota: La columna 'anio_publicacion' para 'El Principito' es NULL en la imagen.
INSERT INTO libros (id_libro, titulo, id_autor, anio_publicacion, id_categoria, existencias) VALUES
(1, 'Cien años de soledad', 1, 1967, 1, 5),
(2, 'Rayuela', 2, 1963, 1, 3),
(3, 'La casa de los espíritus', 3, 1982, 1, 4),
(4, 'La ciudad y los perros', 4, 1963, 1, 6),
(5, 'Ficciones', 5, 1944, 2, 3),
(6, 'La sombra del viento', 6, 2001, 3, 7),
(7, 'Tokio Blues', 7, 1987, 4, 6),
(8, 'Orgullo y prejuicio', 8, 1813, 5, 4),
(9, '1984', 9, 1949, 6, 1),
(10, 'Harry Potter y la piedra filosofal', 10, 1997, 7, 10),
(11, 'libronuevo', 1, 1900, 7, 3),
(12, 'nuevolibro', 10, 1990, 6, 1),
(13, 'nuevolibronuevo', 13, 1900, 2, 1),
(14, 'nuevolibro 1', 4, 1900, 6, 1),
(15, 'mybook', 14, 1920, 5, 2),
(16, 'Cien Aos de Soledad', 1, 1967, 1, 10),
(17, 'El Amor en Tiempos del Colera', 1, 1985, 1, 5),
(18, 'El Principito', 4, NULL, 3, 9);

-- 6. Insertar datos en la tabla `prestamos`
-- -- Nota: Las fechas de devolución y entrega son TIMESTAMP, se insertan tal cual.
INSERT INTO prestamos (id_prestamo, id_usuario, id_libro, fecha_prestamo, fecha_devolucion, fecha_entrega, estado) VALUES
(1, 1, 1, '2025-05-03 08:21:31', '2025-05-10 00:00:00', '2025-05-11 00:00:00', 'ARCHIVADO'),
(2, 2, 5, '2025-05-03 08:21:31', '2025-05-17 00:00:00', '2025-05-08 00:00:00', 'ARCHIVADO'),
(3, 4, 11, '2025-05-03 08:21:31', '2025-04-15 00:00:00', '2025-05-01 00:00:00', 'VENCIDO'),
(4, 6, 1, '2025-05-03 08:21:31', '2025-05-02 00:00:00', '2025-05-02 00:00:00', 'ARCHIVADO'),
(5, 7, 7, '2025-05-03 08:21:31', '2025-05-24 00:00:00', '2025-05-26 00:00:00', 'VENCIDO'),
(6, 1, 14, '2025-05-08 17:45:34', '2025-05-09 00:00:00', '2025-05-10 00:00:00', 'VENCIDO'),
(7, 1, 13, '2025-05-08 18:24:31', '2025-05-09 00:00:00', '2025-05-09 00:00:00', 'ARCHIVADO'),
(8, 1, 14, '2025-05-08 18:48:16', '2025-05-09 00:00:00', '2025-05-08 00:00:00', 'ARCHIVADO'),
(9, 1, 13, '2025-05-08 18:49:13', '2025-05-09 00:00:00', '2025-05-08 00:00:00', 'ARCHIVADO'),
(10, 1, 14, '2025-05-08 18:56:14', '2025-05-09 00:00:00', '2025-05-08 00:00:00', 'ARCHIVADO'),
(11, 1, 13, '2025-05-08 18:56:59', '2025-05-09 00:00:00', '2025-05-08 00:00:00', 'ARCHIVADO'),
(12, 5, 2, '2025-05-08 18:57:58', '2025-05-09 00:00:00', '2025-05-08 00:00:00', 'ARCHIVADO'),
(13, 1, 2, '2025-05-08 19:00:42', '2025-05-10 00:00:00', '2025-05-08 00:00:00', 'ARCHIVADO'),
(14, 1, 14, '2025-05-08 19:04:01', '2025-05-10 00:00:00', '2025-05-08 00:00:00', 'ARCHIVADO'),
(15, 1, 14, '2025-05-08 19:07:25', '2025-05-10 00:00:00', '2025-05-08 00:00:00', 'ARCHIVADO'),
(16, 1, 12, '2025-05-08 19:25:54', '2025-05-10 00:00:00', '2025-05-08 00:00:00', 'ARCHIVADO'),
(17, 9, 2, '2025-05-08 19:27:10', '2025-05-10 00:00:00', '2025-05-08 00:00:00', 'ARCHIVADO'),
(18, 1, 2, '2025-05-08 21:26:16', '2025-05-10 00:00:00', '2025-05-09 22:43:00', 'ARCHIVADO');

-- Habilitar la verificación de claves foráneas
SET FOREIGN_KEY_CHECKS = 1;

-- query:
Select * from autores;
Select * from usuarios;
Select * from categoria;
Select * from nacionalidad;
Select * from prestamos;
Select * from libros;