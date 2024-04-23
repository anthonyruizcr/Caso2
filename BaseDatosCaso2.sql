USE [master]
GO

CREATE DATABASE [CasoEstudioJN]
GO

USE [CasoEstudioJN]
GO


CREATE TABLE [dbo].[CasasSistema](
    [IdCasa] [bigint] IDENTITY(1,1) NOT NULL,
    [DescripcionCasa] [varchar](30) NOT NULL,
    [PrecioCasa] [decimal](10, 2) NOT NULL,
    [UsuarioAlquiler] [varchar](30) NULL,
    [FechaAlquiler] [datetime] NULL,
 CONSTRAINT [PK_CasasSistema] PRIMARY KEY CLUSTERED 
(
    [IdCasa] ASC
)WITH (
    PAD_INDEX = OFF, 
    STATISTICS_NORECOMPUTE = OFF, 
    IGNORE_DUP_KEY = OFF, 
    ALLOW_ROW_LOCKS = ON, 
    ALLOW_PAGE_LOCKS = ON, 
    OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
) ON [PRIMARY]
) ON [PRIMARY]
GO


INSERT INTO [dbo].[CasasSistema] ([DescripcionCasa],[PrecioCasa],[UsuarioAlquiler],[FechaAlquiler])
VALUES ('Casa en San José',190000,null,null)
INSERT INTO [dbo].[CasasSistema] ([DescripcionCasa],[PrecioCasa],[UsuarioAlquiler],[FechaAlquiler])
VALUES ('Casa en Alajuela',145000,null,null)
INSERT INTO [dbo].[CasasSistema] ([DescripcionCasa],[PrecioCasa],[UsuarioAlquiler],[FechaAlquiler])
VALUES ('Casa en Cartago',115000,null,null)
INSERT INTO [dbo].[CasasSistema] ([DescripcionCasa],[PrecioCasa],[UsuarioAlquiler],[FechaAlquiler])
VALUES ('Casa en Heredia',122000,null,null)
INSERT INTO [dbo].[CasasSistema] ([DescripcionCasa],[PrecioCasa],[UsuarioAlquiler],[FechaAlquiler])
VALUES ('Casa en Guanacaste',105000,null,null)


USE [master]
GO
ALTER DATABASE [CasoEstudioJN] SET  READ_WRITE 
GO

USE CasoEstudioJN
GO

CREATE PROCEDURE SP_ALQUILAR_CASA (
    @ID BIGINT,
    @USER VARCHAR(30)
)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM [dbo].CasasSistema WHERE IdCasa = @ID)
    BEGIN
        UPDATE [dbo].CasasSistema
        SET UsuarioAlquiler = @USER,
            FechaAlquiler = SYSDATETIME()
        WHERE IdCasa = @ID;

        SELECT @@IDENTITY 'IdCasa';
    END
    ELSE
    BEGIN
        SELECT -1 'IdCasa';
    END
END
GO


CREATE PROCEDURE SP_CONSULTAR_CASAS
AS
BEGIN
    SELECT 
        DescripcionCasa,
        PrecioCasa,
        ISNULL(UsuarioAlquiler, 'Sin dueño') AS UsuarioAlquiler,
        CASE 
            WHEN UsuarioAlquiler IS NULL THEN 'Disponible'
            ELSE 'Reservada'
        END AS Estado,
        CASE 
            WHEN FechaAlquiler IS NULL THEN 'Sin Fecha'
            ELSE CONVERT(varchar, FechaAlquiler, 103) 
        END AS FechaAlquiler
    FROM 
        [dbo].CasasSistema
    WHERE 
        PrecioCasa BETWEEN 115000 AND 180000
    ORDER BY 
        CASE 
            WHEN UsuarioAlquiler IS NULL THEN 0 
            ELSE 1 
        END,
        PrecioCasa;
END
GO
