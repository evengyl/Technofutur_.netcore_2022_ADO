
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;
GO

SET NUMERIC_ROUNDABORT OFF;
GO

IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Le mode SQLCMD doit être activé de manière à pouvoir exécuter ce script.';
        SET NOEXEC ON;
    END
GO

USE [master];
GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END
GO

PRINT N'Création de la base de données $(DatabaseName)...'
GO

CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO

IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END
GO

USE [$(DatabaseName)];
GO

IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END
GO

IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END
GO

IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END
GO

IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END
GO

IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Impossible de modifier les paramètres de base de données. Vous devez être administrateur système pour appliquer ces paramètres.';
    END
GO

IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Impossible de modifier les paramètres de base de données. Vous devez être administrateur système pour appliquer ces paramètres.';
    END
GO

ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;
GO

IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END
GO

IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END
GO

IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END
GO

IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END
GO

IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END
GO

IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';
GO

PRINT N'Création de Table [dbo].[Section]...';
GO

PRINT N'Création de Table [dbo].[Student]...';
GO

PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[Student]...';
GO

PRINT N'Création de Clé étrangère [dbo].[FK_Student_Section]...';
GO

PRINT N'Création de Contrainte de validation [dbo].[CK_Student_YearResult]...';
GO

PRINT N'Création de Contrainte de validation [dbo].[CK_Student_BirthDate]...';
GO

PRINT N'Création de Déclencheur [dbo].[TR_OnDeleteStudent]...';
GO

PRINT N'Création de Vue [dbo].[V_StudentActive]...';
GO

PRINT N'Création de Procédure [dbo].[AddSection]...';
GO

PRINT N'Création de Procédure [dbo].[AddStudent]...';
GO

PRINT N'Création de Procédure [dbo].[DeleteStudent]...';
GO

PRINT N'Création de Procédure [dbo].[UpdateStudent]...';
GO

-- Étape de refactorisation pour mettre à jour le serveur cible avec des journaux de transactions déployés

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    --L'instruction suivante a été importée dans le projet de base de données en tant qu'objet de schéma et porte le nom dbo.__RefactorLog.
--CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)

    --L'instruction suivante a été importée dans le projet de base de données en tant qu'objet de schéma et porte le nom SqlTableBase.dbo.__RefactorLog.microsoft_database_tools_support.
--EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'

END
GO

IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '75f359c2-9c45-4f5d-9e2a-a81d672e73db')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('75f359c2-9c45-4f5d-9e2a-a81d672e73db')
GO

IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '1416f95f-93c9-4342-90fe-68230b02e664')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('1416f95f-93c9-4342-90fe-68230b02e664')
GO

IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '19d19678-ba84-4124-8c5f-267a1fa84e8e')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('19d19678-ba84-4124-8c5f-267a1fa84e8e')
GO

INSERT INTO Section (Id, SectionName) VALUES (1010, 'Informatique de Gestion');
GO

INSERT INTO Section (Id, SectionName) VALUES (1020, 'Comptabilité');
GO

INSERT INTO Section (Id, SectionName) VALUES (1110, 'Tourisme');
GO

INSERT INTO Section (Id, SectionName) VALUES (1120, 'Dessin 3D');
GO

INSERT INTO Section (Id, SectionName) VALUES (1310, 'Administrateurs Système');
GO

INSERT INTO Section (Id, SectionName) VALUES (1320, 'Secrétariat');
GO

Set Identity_insert Student on;
GO

INSERT INTO Student (Id, FirstName, LastName, BirthDate, SectionId, YearResult) VALUES
(1, 'Georges', 'Lucas', '1944-05-17 00:00:00', 1320, 10),
(2, 'Clint', 'Eastwood', '1930-05-31 00:00:00', 1010, 4),
(3, 'Sean', 'Connery', '1930-08-25 00:00:00', 1020, 12),
(4, 'Robert', 'De Niro', '1943-08-17 00:00:00', 1110, 3),
(5, 'Kevin', 'Bacon', '1958-07-08 00:00:00', 1120, 16),
(6, 'Kim', 'Basinger', '1953-12-08 00:00:00', 1310, 19),
(7, 'Johnny', 'Depp', '1963-06-09 00:00:00', 1110, 11),
(8, 'Julia', 'Roberts', '1967-10-28 00:00:00', 1120, 17),
(9, 'Natalie', 'Portman', '1981-06-09 00:00:00', 1010, 4),
(10, 'Georges', 'Clooney', '1961-05-06 00:00:00', 1020, 4),
(11, 'Andy', 'Garcia', '1956-04-12 00:00:00', 1110, 19),
(12, 'Bruce', 'Willis', '1955-03-19 00:00:00', 1010, 6),
(13, 'Tom', 'Cruise', '1962-07-03 00:00:00', 1020, 4),
(14, 'Reese', 'Witherspoon', '1976-03-22 00:00:00', 1020, 7),
(15, 'Sophie', 'Marceau', '1966-11-17 00:00:00', 1110, 6),
(16, 'Sarah', 'Michelle Gellar', '1977-04-14 00:00:00', 1020, 7),
(17, 'Alyssa', 'Milano', '1972-12-19 00:00:00', 1110, 7),
(18, 'Jennifer', 'Garner', '1972-04-17 00:00:00', 1120, 18),
(19, 'Michael J.', 'Fox', '1969-06-20 00:00:00', 1310, 3),
(20, 'Tom', 'Hanks', '1956-07-09 00:00:00', 1020, 8),
(21, 'David', 'Morse', '1953-10-11 00:00:00', 1110, 2),
(22, 'Sandra', 'Bullock', '1964-07-26 00:00:00', 1010, 2),
(23, 'Keanu', 'Reeves', '1964-09-02 00:00:00', 1020, 10),
(24, 'Shannen', 'Doherty', '1971-04-12 00:00:00', 1320, 2),
(25, 'Halle', 'Berry', '1966-08-14 00:00:00', 1320, 18);
GO

Set Identity_insert Student off;
GO

PRINT N'Mise à jour terminée.';
GO

/*
Script de déploiement pour DbSlidesLoic

Ce code a été généré par un outil.
La modification de ce fichier peut provoquer un comportement incorrect et sera perdue si
le code est régénéré.
*/


GO

DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END



GO

:setvar DatabaseName "DbSlidesLoic"
:setvar DefaultFilePrefix "DbSlidesLoic"
:setvar DefaultDataPath "C:\Users\Evengyl\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\NetCoreTechno2022\"
:setvar DefaultLogPath "C:\Users\Evengyl\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\NetCoreTechno2022\"


GO

--Erreur de syntaxe : Syntaxe incorrecte proche de :.
--:setvar DatabaseName "DbSlidesLoic"
--:setvar DefaultFilePrefix "DbSlidesLoic"
--:setvar DefaultDataPath "C:\Users\Evengyl\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\NetCoreTechno2022\"
--:setvar DefaultLogPath "C:\Users\Evengyl\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\NetCoreTechno2022\"
--

GO

:on error exit

GO

--Erreur de syntaxe : Syntaxe incorrecte proche de :.
--:on error exit

GO

/*
Détectez le mode SQLCMD et désactivez l'exécution du script si le mode SQLCMD n'est pas pris en charge.
Pour réactiver le script une fois le mode SQLCMD activé, exécutez ce qui suit :
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"

GO

--Erreur de syntaxe : Syntaxe incorrecte proche de :.
--/*
--Détectez le mode SQLCMD et désactivez l'exécution du script si le mode SQLCMD n'est pas pris en charge.
--Pour réactiver le script une fois le mode SQLCMD activé, exécutez ce qui suit :
--SET NOEXEC OFF; 
--*/
--:setvar __IsSqlCmdEnabled "True"

GO

IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END



GO

--Erreur de syntaxe : Syntaxe incorrecte proche de TEMPORAL_HISTORY_RETENTION.
--IF EXISTS (SELECT 1
--           FROM   [master].[dbo].[sysdatabases]
--           WHERE  [name] = N'$(DatabaseName)')
--    BEGIN
--        ALTER DATABASE [$(DatabaseName)]
--            SET TEMPORAL_HISTORY_RETENTION ON 
--            WITH ROLLBACK IMMEDIATE;
--    END
--
--



GO
