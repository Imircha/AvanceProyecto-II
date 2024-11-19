DROP DATABASE AdminSeguridad;
-- Crear la base de datos
CREATE DATABASE AdminSeguridad;
USE AdminSeguridad;

-- Tabla Pais
CREATE TABLE Pais (
    PaisID INT PRIMARY KEY IDENTITY(1,1),
    NombrePais VARCHAR(50) NOT NULL
);

-- Tabla Provincias
CREATE TABLE Provincias (
    ProvinciaID INT PRIMARY KEY IDENTITY(1,1),
    NombreProvincia VARCHAR(50) NOT NULL,
    PaisID INT FOREIGN KEY REFERENCES Pais(PaisID)
);

-- Tabla Cantones
CREATE TABLE Cantones (
    CantonID INT PRIMARY KEY IDENTITY(1,1),
    NombreCanton VARCHAR(50) NOT NULL,
    ProvinciaID INT FOREIGN KEY REFERENCES Provincias(ProvinciaID)
);

-- Tabla Distritos
CREATE TABLE Distritos (
    DistritoID INT PRIMARY KEY IDENTITY(1,1),
    NombreDistrito VARCHAR(50) NOT NULL,
    CantonID INT FOREIGN KEY REFERENCES Cantones(CantonID)
);

-- Tabla Direcciones
CREATE TABLE Direcciones (
    DireccionID INT PRIMARY KEY IDENTITY(1,1),
    Calle VARCHAR(50) NOT NULL,
    Ciudad VARCHAR(50) NOT NULL,
    DistritoID INT FOREIGN KEY REFERENCES Distritos(DistritoID),
    CantonID INT FOREIGN KEY REFERENCES Cantones(CantonID),
    ProvinciaID INT FOREIGN KEY REFERENCES Provincias(ProvinciaID),
    PaisID INT FOREIGN KEY REFERENCES Pais(PaisID),
    UsuarioID INT
);

-- Tabla Areas
CREATE TABLE Areas (
    CodigoArea INT PRIMARY KEY IDENTITY(1,1),
    NombreArea VARCHAR(10) NOT NULL
);

-- Tabla Telefonos
CREATE TABLE Telefonos (
    TelefonoID INT PRIMARY KEY IDENTITY(1,1),
    CodigoArea INT FOREIGN KEY REFERENCES Areas(CodigoArea),
    Numero VARCHAR(20) NOT NULL
);

-- Tabla Roles
CREATE TABLE Roles (
    RolID INT PRIMARY KEY IDENTITY(1,1),
    NombreRol VARCHAR(50) NOT NULL
);

-- Tabla Permisos
CREATE TABLE Permisos (
    PermisoID INT PRIMARY KEY IDENTITY(1,1),
    NombrePermiso VARCHAR(50) NOT NULL,
    PermisoLectura BIT NOT NULL DEFAULT 0,
    PermisoEscritura BIT NOT NULL DEFAULT 0,
    PermisoModificacion BIT NOT NULL DEFAULT 0,
    PermisoEliminacion BIT NOT NULL DEFAULT 0
);

-- Tabla Menus
CREATE TABLE Menus (
    MenuID INT PRIMARY KEY IDENTITY(1,1),
    NombreMenu VARCHAR(255) NOT NULL
);

-- Tabla Usuarios
CREATE TABLE Usuarios (
    UsuarioID INT PRIMARY KEY IDENTITY(1,1),
    Usuario VARCHAR(50) NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    Apellido1 VARCHAR(50) NOT NULL,
    Apellido2 VARCHAR(50),
    Email VARCHAR(50) UNIQUE NOT NULL,
    Clave VARCHAR(255) NOT NULL,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    FechaActualizacion DATETIME NOT NULL DEFAULT GETDATE()
);

-- Tabla RolPermisos (Relación entre Roles y Permisos)
CREATE TABLE RolPermisos (
    RolID INT FOREIGN KEY REFERENCES Roles(RolID),
    PermisoID INT FOREIGN KEY REFERENCES Permisos(PermisoID),
    PRIMARY KEY (RolID, PermisoID)
);

-- Tabla MenuPermiso (Relación entre Menús y Permisos)
CREATE TABLE MenuPermiso (
    MenuID INT FOREIGN KEY REFERENCES Menus(MenuID),
    PermisoID INT FOREIGN KEY REFERENCES Permisos(PermisoID),
    PRIMARY KEY (MenuID, PermisoID)
);

INSERT INTO Usuarios (Usuario, Nombre, Apellido1, Apellido2, Email, Clave, FechaCreacion, FechaActualizacion)
VALUES ('admin', 'Admin', '1', '2', 'admin@gmail.com', '1234', GETDATE(), GETDATE());


ALTER TABLE Usuarios
ADD RolID INT FOREIGN KEY REFERENCES Roles(RolID); --cambiar el rollID y agregarlo a la tabla usuarios por un error el código

INSERT INTO Roles (NombreRol)
VALUES ('Administrator');
UPDATE Usuarios
SET RolID = (SELECT TOP 1 RolID FROM Roles WHERE NombreRol = 'Administrator')
WHERE Usuario = 'admin'; -- Update only the specific user

Select * from Roles;
