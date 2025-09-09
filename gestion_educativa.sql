-- Crear base de datos (puedes cambiar el nombre si quieres)
CREATE DATABASE IF NOT EXISTS gestion_educativa;
USE gestion_educativa;

-- Tabla Usuarios
CREATE TABLE Usuarios (
    IdUsuario INT AUTO_INCREMENT PRIMARY KEY,
    NombreUsuario VARCHAR(50) NOT NULL UNIQUE,
    ContraseñaHash VARCHAR(255) NOT NULL,
    Rol ENUM('Administrador', 'Usuario') NOT NULL
);

-- Tabla BitacoraSesiones
CREATE TABLE BitacoraSesiones (
    IdSesion INT AUTO_INCREMENT PRIMARY KEY,
    IdUsuario INT NOT NULL,
    FechaHoraInicio DATETIME NOT NULL,
    DireccionIP VARCHAR(45),
    FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario) ON DELETE CASCADE
);

-- Tabla BitacoraConsultas
CREATE TABLE BitacoraConsultas (
    IdConsulta INT AUTO_INCREMENT PRIMARY KEY,
    IdUsuario INT NOT NULL,
    FechaHora DATETIME NOT NULL,
    DescripcionConsulta VARCHAR(255),
    FOREIGN KEY (IdUsuario) REFERENCES Usuarios(IdUsuario) ON DELETE CASCADE
);

-- Tabla Padres
CREATE TABLE Padres (
    IdPadre INT AUTO_INCREMENT PRIMARY KEY,
    NombreCompleto VARCHAR(100) NOT NULL,
    DUI VARCHAR(20) UNIQUE,
    Telefono VARCHAR(20),
    Correo VARCHAR(100)
);

-- Tabla NivelesEducativos
CREATE TABLE NivelesEducativos (
    IdNivel INT AUTO_INCREMENT PRIMARY KEY,
    NombreNivel VARCHAR(50) NOT NULL,
    Seccion VARCHAR(20),
    AñoLectivo VARCHAR(20)
);

-- Tabla Alumnos
CREATE TABLE Alumnos (
    IdAlumno INT AUTO_INCREMENT PRIMARY KEY,
    Carnet VARCHAR(20) UNIQUE NOT NULL,
    NombreCompleto VARCHAR(100) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    IdNivelActual INT,
    FOREIGN KEY (IdNivelActual) REFERENCES NivelesEducativos(IdNivel)
);

-- Tabla HistorialNiveles
CREATE TABLE HistorialNiveles (
    IdHistorial INT AUTO_INCREMENT PRIMARY KEY,
    IdAlumno INT NOT NULL,
    IdNivel INT NOT NULL,
    AñoLectivo VARCHAR(20) NOT NULL,
    FOREIGN KEY (IdAlumno) REFERENCES Alumnos(IdAlumno) ON DELETE CASCADE,
    FOREIGN KEY (IdNivel) REFERENCES NivelesEducativos(IdNivel) ON DELETE CASCADE
);

-- Tabla RelPadresAlumnos (relación muchos a muchos)
CREATE TABLE RelPadresAlumnos (
    IdRelacion INT AUTO_INCREMENT PRIMARY KEY,
    IdPadre INT NOT NULL,
    IdAlumno INT NOT NULL,
    FOREIGN KEY (IdPadre) REFERENCES Padres(IdPadre) ON DELETE CASCADE,
    FOREIGN KEY (IdAlumno) REFERENCES Alumnos(IdAlumno) ON DELETE CASCADE,
    UNIQUE (IdPadre, IdAlumno)
);

-- Tabla Eventos
CREATE TABLE Eventos (
    IdEvento INT AUTO_INCREMENT PRIMARY KEY,
    NombreEvento VARCHAR(100) NOT NULL,
    Fecha DATE NOT NULL,
    Lugar VARCHAR(100),
    Descripcion TEXT
);

-- Tabla Asistencias
CREATE TABLE Asistencias (
    IdAsistencia INT AUTO_INCREMENT PRIMARY KEY,
    IdEvento INT NOT NULL,
    IdPadre INT NOT NULL,
    IdAlumno INT NOT NULL,
    FechaRegistro DATETIME NOT NULL,
    Estado ENUM('Presente', 'Ausente', 'Justificado') NOT NULL,
    FOREIGN KEY (IdEvento) REFERENCES Eventos(IdEvento) ON DELETE CASCADE,
    FOREIGN KEY (IdPadre) REFERENCES Padres(IdPadre) ON DELETE CASCADE,
    FOREIGN KEY (IdAlumno) REFERENCES Alumnos(IdAlumno) ON DELETE CASCADE
);
