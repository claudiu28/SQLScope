USE LAB4_FARMACIE
GO


IF OBJECT_ID('VERSIONARE', 'U') IS NOT NULL
    PRINT 'Tabelul VERSIONARE exista deja.'
ELSE
BEGIN
    CREATE TABLE VERSIONARE (
        IdVersionare INT PRIMARY KEY IDENTITY(1,1),
        VERSIUNE INT
    );
    PRINT 'Tabelul VERSIONARE a fost creat cu succes.'
END;
GO

INSERT INTO VERSIONARE(VERSIUNE) VALUES (0);
GO
DELETE FROM VERSIONARE;
SELECT VERSIUNE FROM VERSIONARE;
GO

CREATE PROCEDURE do1
AS BEGIN
	ALTER TABLE CUMPARATORI
	ALTER COLUMN Nume NVARCHAR(500);
	PRINT 'S-a modificat cu succes coloana Nume din CUMPARATORI!';
END;
GO

CREATE PROCEDURE undo1
AS BEGIN
	ALTER TABLE CUMPARATORI
	ALTER COLUMN Nume NVARCHAR(50);
	PRINT 'S-a reintors la varianta de dinainte!';
END;
GO

CREATE PROCEDURE do2
AS BEGIN
	ALTER TABLE CUMPARATORI
	ADD CONSTRAINT constrangereDefault DEFAULT 'Necunoscut' FOR Nume;
	PRINT 'S-a pus canstragere default!';
END;
GO

CREATE PROCEDURE undo2
AS BEGIN
	ALTER TABLE CUMPARATORI
	DROP CONSTRAINT constrangereDefault;
	PRINT 'S-a sters constragere default!';
END;
GO

CREATE PROCEDURE do3
AS BEGIN
	CREATE TABLE ReteteTabel(
		IdRetete INT PRIMARY KEY IDENTITY(1,1)
	);
	PRINT 'S-a creat tabelul ReteleTabel!';
END;
GO

CREATE PROCEDURE undo3
AS BEGIN
	IF OBJECT_ID('ReteteTabel', 'U') IS NOT NULL
	BEGIN	
		DROP TABLE ReteteTabel;
		PRINT 'S-a sters tabelul ReteleTabel!';
	END;
END;
GO

CREATE PROCEDURE do4
AS BEGIN
	ALTER TABLE ReteteTabel
	ADD idCumparatori INT;
	PRINT 'S-a adaugat corect coloana idCumparatori!';
END;
GO


CREATE PROCEDURE undo4
AS BEGIN
	ALTER TABLE ReteteTabel
	DROP COLUMN idCumparatori;
	PRINT 'S-a sters coloana idCumparatori!';
END;
GO

CREATE PROCEDURE do5
AS BEGIN
	ALTER TABLE ReteteTabel
	ADD CONSTRAINT CheieStraina FOREIGN KEY (idCumparatori) REFERENCES CUMPARATORI(CumparatorId);
	PRINT 'S-a adaugat cheie straina pe idCumparatori!';
END;
GO

CREATE PROCEDURE undo5
AS BEGIN
	ALTER TABLE ReteteTabel
	DROP CONSTRAINT CheieStraina;
	PRINT 'S-a sters cheie straina pe idCumparatori!';

END; 
GO

CREATE PROCEDURE MainProcedure
    @numarVersiune INT
AS
BEGIN
    IF @numarVersiune < 0 OR @numarVersiune > 5
    BEGIN
        PRINT 'Numarul de versiune este invalid!';
        RETURN;
    END;

    DECLARE @versiuneCurenta INT;
    SET @versiuneCurenta = (SELECT TOP 1 VERSIUNE FROM VERSIONARE);

    IF @versiuneCurenta = @numarVersiune
    BEGIN
        PRINT 'DEJA SUNTEM LA VERSIUNEA ACTUALA!';
        RETURN;
    END;

    DECLARE @procedura NVARCHAR(50);

    IF @numarVersiune > @versiuneCurenta
    BEGIN
        WHILE @versiuneCurenta < @numarVersiune
        BEGIN
            SET @versiuneCurenta = @versiuneCurenta + 1;
            SET @procedura = CONCAT('do', CAST(@versiuneCurenta AS NVARCHAR(10)));
            EXEC @procedura; 
        END;
    END
    ELSE
    BEGIN
        WHILE @versiuneCurenta > @numarVersiune
        BEGIN
            SET @procedura = CONCAT('undo', CAST(@versiuneCurenta AS NVARCHAR(10)));
            EXEC @procedura; 
            SET @versiuneCurenta = @versiuneCurenta - 1;
        END;
    END;
    DELETE FROM VERSIONARE;
    INSERT INTO VERSIONARE(VERSIUNE) VALUES (@numarVersiune);
END;
GO


SELECT * from VERSIONARE;

EXEC MainProcedure 0
EXEC MainProcedure 1
EXEC MainProcedure 2
EXEC MainProcedure 3
EXEC MainProcedure 4
EXEC MainProcedure 5