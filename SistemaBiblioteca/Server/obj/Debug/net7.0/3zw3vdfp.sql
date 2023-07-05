IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [Categoria] (
    [IdCategoria] int NOT NULL IDENTITY,
    [Descripcion] varchar(50) NULL,
    [Estado] bit NULL DEFAULT (((1))),
    [FechaCreacion] datetime NULL DEFAULT ((getdate())),
    CONSTRAINT [PK__Categori__A3C02A10D5997664] PRIMARY KEY ([IdCategoria])
);
GO

CREATE TABLE [EstadoPrestamo] (
    [IdEstadoPrestamo] int NOT NULL,
    [Descripcion] varchar(50) NULL,
    [Estado] bit NULL DEFAULT (((1))),
    [FechaCreacion] datetime NULL DEFAULT ((getdate())),
    CONSTRAINT [PK__EstadoPr__BCB87549B1EE39F5] PRIMARY KEY ([IdEstadoPrestamo])
);
GO

CREATE TABLE [Lector] (
    [IdLector] int NOT NULL IDENTITY,
    [Codigo] varchar(50) NULL,
    [Nombre] varchar(50) NULL,
    [Apellido] varchar(50) NULL,
    [Correo] varchar(50) NULL,
    [Clave] varchar(50) NULL,
    [Estado] bit NULL DEFAULT (((1))),
    [FechaCreacion] datetime NULL DEFAULT ((getdate())),
    CONSTRAINT [PK__Lector__9644AB8B7D446B38] PRIMARY KEY ([IdLector])
);
GO

CREATE TABLE [NumeroCorrelativo] (
    [IdNumeroCorrelativo] int NOT NULL IDENTITY,
    [Prefijo] varchar(2) NOT NULL,
    [Tipo] varchar(100) NOT NULL,
    [UltimoNumero] int NOT NULL,
    [FechaRegistro] datetime NULL DEFAULT ((getdate())),
    CONSTRAINT [PK__NumeroCo__84369489B5E6D532] PRIMARY KEY ([IdNumeroCorrelativo])
);
GO

CREATE TABLE [Usuario] (
    [idUsuario] int NOT NULL IDENTITY,
    [nombreApellidos] varchar(100) NULL,
    [correo] varchar(40) NULL,
    [clave] varchar(40) NULL,
    [esActivo] bit NULL,
    [FechaCreacion] datetime NULL DEFAULT ((getdate())),
    CONSTRAINT [PK__Usuario__645723A6E6669CDA] PRIMARY KEY ([idUsuario])
);
GO

CREATE TABLE [Libro] (
    [IdLibro] int NOT NULL IDENTITY,
    [Titulo] varchar(100) NULL,
    [Autor] varchar(100) NULL,
    [IdCategoria] int NULL,
    [Editorial] varchar(100) NULL,
    [Ubicacion] varchar(50) NULL,
    [Ejemplares] int NULL,
    [Portada] varbinary(max) NULL,
    [Estado] bit NULL DEFAULT (((1))),
    [FechaCreacion] datetime NULL DEFAULT ((getdate())),
    [PDF] varbinary(max) NULL,
    CONSTRAINT [PK__Libro__3E0B49AD304D2310] PRIMARY KEY ([IdLibro]),
    CONSTRAINT [FK__Libro__IdCategor__145C0A3F] FOREIGN KEY ([IdCategoria]) REFERENCES [Categoria] ([IdCategoria])
);
GO

CREATE TABLE [Prestamo] (
    [IdPrestamo] int NOT NULL IDENTITY,
    [Codigo] varchar(50) NULL,
    [IdEstadoPrestamo] int NULL,
    [IdLector] int NULL,
    [IdLibro] int NULL,
    [FechaDevolucion] datetime NULL,
    [FechaConfirmacionDevolucion] datetime NULL,
    [EstadoEntregado] varchar(100) NULL,
    [EstadoRecibido] varchar(100) NULL,
    [Estado] bit NULL DEFAULT (((1))),
    [FechaCreacion] datetime NULL DEFAULT ((getdate())),
    CONSTRAINT [PK__Prestamo__6FF194C04495825A] PRIMARY KEY ([IdPrestamo]),
    CONSTRAINT [FK__Prestamo__IdEsta__2D27B809] FOREIGN KEY ([IdEstadoPrestamo]) REFERENCES [EstadoPrestamo] ([IdEstadoPrestamo]),
    CONSTRAINT [FK__Prestamo__IdLect__2E1BDC42] FOREIGN KEY ([IdLector]) REFERENCES [Lector] ([IdLector]),
    CONSTRAINT [FK__Prestamo__IdLibr__2F10007B] FOREIGN KEY ([IdLibro]) REFERENCES [Libro] ([IdLibro])
);
GO

CREATE INDEX [IX_Libro_IdCategoria] ON [Libro] ([IdCategoria]);
GO

CREATE INDEX [IX_Prestamo_IdEstadoPrestamo] ON [Prestamo] ([IdEstadoPrestamo]);
GO

CREATE INDEX [IX_Prestamo_IdLector] ON [Prestamo] ([IdLector]);
GO

CREATE INDEX [IX_Prestamo_IdLibro] ON [Prestamo] ([IdLibro]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20230704162003_ASDs', N'7.0.5');
GO

COMMIT;
GO

