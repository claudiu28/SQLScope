USE LAB4_FARMACIE
GO

IF OBJECT_ID('Tables', 'U') IS NOT NULL
BEGIN

	INSERT INTO Tables(Name) VALUES 
	('FURNIZORI'), -- PK !FK
	('MEDICAMENTE'), -- PK & FK
	('FURNIZORI_MEDICAMENTE') -- PK FORMAT DIN 2 FIELDS
	
END
DBCC CHECKIDENT ('Tables', RESEED, 0);
GO
DELETE FROM Tables
SELECT * FROM Tables
GO

CREATE OR ALTER VIEW VWFurnizori AS
	SELECT Nume, Adresa from FURNIZORI;
GO
SELECT * FROM VWFurnizori;
GO

CREATE OR ALTER VIEW VWMedicamente
AS
	SELECT M.MedicamentId, M.Nume, M.Descriere, M.Pret, F.Nume AS FurnizorNume FROM MEDICAMENTE M
    INNER JOIN FURNIZORI_MEDICAMENTE FM ON FM.MedicamentId = M.MedicamentId
    INNER JOIN FURNIZORI F ON F.FurnizoriId = FM.FurnizoriId;
GO
SELECT * FROM VWMedicamente;
GO

CREATE OR ALTER VIEW VWFurnizoriMedicamente AS
	SELECT M.Nume, M.Descriere, COUNT(F.FurnizoriId) AS NumarFurnizori, SUM(M.Stoc) AS CantitateTotala
	FROM MEDICAMENTE AS M 
	INNER JOIN FURNIZORI_MEDICAMENTE ON FURNIZORI_MEDICAMENTE.MedicamentId = M.MedicamentId
	INNER JOIN FURNIZORI AS F ON FURNIZORI_MEDICAMENTE.FurnizoriId = F.FurnizoriId 
	GROUP BY M.Nume, M.Descriere;
GO
SELECT * FROM VWFurnizoriMedicamente
GO


IF OBJECT_ID('Views', 'U') IS NOT NULL
BEGIN
	INSERT INTO VIEWS(Name) VALUES 
	('VWFurnizori'),
	('VWMedicamente'), 
	('VWFurnizoriMedicamente')
END
GO
DBCC CHECKIDENT ('Views', RESEED, 0);
GO
SELECT * FROM VIEWS
DELETE FROM VIEWS
GO

IF OBJECT_ID('Tests', 'U') IS NOT NULL
BEGIN
	INSERT INTO Tests(Name) VALUES
	('test_Furnizori_1000'),
	('test_Medicamente_1000'),
	('test_Furnizori_Medicamente_1000')

END
GO
DBCC CHECKIDENT ('Tests', RESEED, 0);
GO
SELECT * FROM Tests
DELETE FROM Tests;

IF OBJECT_ID('TestViews', 'U') IS NOT NULL
BEGIN
	INSERT INTO TestViews(TestId, ViewId) VALUES 
	(1,1),
	(2,2),
	(3,3)
END
GO
SELECT * FROM TestViews
DELETE FROM TestViews


IF OBJECT_ID('TestTables') IS NOT NULL
BEGIN
	INSERT INTO TestTables(TestID, TableID, NoOfRows, Position)
	VALUES 
	-- insert
	(1,1,1000,1),
	(2,2,1000,2),
	(3,3,1000,1),
	(3,2,1000,2),
	(3,1,1000,3)
END
GO
DELETE FROM TestTables;
SELECT * FROM TestTables;
GO


CREATE OR ALTER PROCEDURE INSERT_FURNIZORI
	@numarLinii INT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @number INT; 
	SET @number = 0;
	DECLARE @lastId INT;

	SELECT @lastId = ISNULL(max(FurnizoriId),0) FROM FURNIZORI; 

	SET IDENTITY_INSERT FURNIZORI ON;

	WHILE @number < @numarLinii
	BEGIN
		
		INSERT INTO FURNIZORI(FurnizoriId, Nume, Adresa) VALUES 
			(@lastId + @number + 1, 
			'FURNIZOR_TEST_' + CAST(@lastId + @number + 1 AS NVARCHAR(100)),
			'ADRESA_TEST_' + CAST(@lastId + @number + 1 AS NVARCHAR(100))
			)
		SET @number = @number + 1;
		
	END
	
	SET IDENTITY_INSERT FURNIZORI OFF;
	PRINT 'S-au inserat ' + CAST(@numarLinii AS NVARCHAR(100)) + ' inregistrari in FURNIZORI';
END
GO

CREATE OR ALTER PROCEDURE INSERT_MEDICAMENTE
	@numarLinii INT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @number INT;
	SET @number = 0;
	DECLARE @lastId INT;
	DECLARE @FarmacieId INT; 
	SET IDENTITY_INSERT MEDICAMENTE ON;

	SELECT TOP 1 @FarmacieId = FarmacieId FROM FARMACIE_DETALII;

	SELECT @lastId = ISNULL(max(MedicamentId), 0) FROM MEDICAMENTE;
	WHILE @number < @numarLinii
	BEGIN
		INSERT INTO MEDICAMENTE(MedicamentId, Nume, Descriere, Pret, Stoc, FarmacieId) VALUES
		(
			@lastId + @number + 1,
			'MEDICAMENT_TEST_' + CAST(@lastId + @number + 1 AS NVARCHAR(100)),
			'DESCRIERE_TEST_' + CAST(@lastId + @number + 1 AS NVARCHAR(100)),
			CAST(FLOOR(1 + (RAND() * 100)) AS INT),
			CAST(FLOOR(1 + (RAND() * 1000)) AS INT),
			@FarmacieId
		)
		SET @number = @number + 1;
	END
	SET IDENTITY_INSERT MEDICAMENTE OFF;
	PRINT 'S-au inserat ' + CAST(@numarLinii AS NVARCHAR(10)) + ' inregistrari in MEDICAMENTE';
END
GO

CREATE OR ALTER PROCEDURE INSERT_FURNIZORI_MEDICAMENTE
	@numarLinii INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @numar INT;
	SET @numar  = 0;
	
	DECLARE @Furnizori INT;
	DECLARE @Medicamente INT;

	DECLARE FURNIZORI_CURSOR CURSOR FOR SELECT TOP (@numarLinii) FurnizoriId FROM FURNIZORI WHERE Nume LIKE 'FURNIZOR_TEST_%' ORDER BY FurnizoriId ASC;  
	DECLARE MEDICAMENTE_CURSOR CURSOR FOR SELECT TOP (@numarLinii) MedicamentId FROM MEDICAMENTE WHERE NUME LIKE 'MEDICAMENT_TEST_%' ORDER BY MedicamentId ASC;

	OPEN FURNIZORI_CURSOR
	OPEN MEDICAMENTE_CURSOR

	FETCH NEXT FROM FURNIZORI_CURSOR INTO @Furnizori
	FETCH NEXT FROM MEDICAMENTE_CURSOR INTO @Medicamente

	WHILE (@numar < @numarLinii AND @@FETCH_STATUS = 0)
	BEGIN
		INSERT INTO FURNIZORI_MEDICAMENTE(FurnizoriId, MedicamentId) VALUES (@Furnizori, @Medicamente)
		
		FETCH NEXT FROM FURNIZORI_CURSOR INTO @Furnizori
		FETCH NEXT FROM MEDICAMENTE_CURSOR INTO @Medicamente

		SET @numar = @numar + 1;
	END

	CLOSE FURNIZORI_CURSOR;
	CLOSE MEDICAMENTE_CURSOR;

	DEALLOCATE  FURNIZORI_CURSOR;
	DEALLOCATE MEDICAMENTE_CURSOR;

	PRINT 'S-au inserat ' + CAST(@numarLinii AS NVARCHAR(10)) + ' inregistrari in FURNIZORI_MEDICAMENTE';
END
GO

CREATE OR ALTER PROCEDURE DELETE_FURNIZORI_MEDICAMENTE
AS
BEGIN
	SET NOCOUNT ON;
    DELETE FM 
    FROM FURNIZORI_MEDICAMENTE FM 
    INNER JOIN FURNIZORI F ON F.FurnizoriId = FM.FurnizoriId
    WHERE F.Nume LIKE 'FURNIZOR_TEST_%';
    PRINT 'S-au Sters ' + CAST(@@ROWCOUNT AS NVARCHAR(10)) + ' inregistrări din FURNIZORI_MEDICAMENTE';
END
GO
DROP PROCEDURE DELETE_FURNIZORI_MEDICAMENTE
GO


CREATE OR ALTER PROCEDURE DELETE_MEDICAMENTE
AS
BEGIN
	SET NOCOUNT ON; 
    DELETE FROM MEDICAMENTE 
    WHERE Nume LIKE 'MEDICAMENT_TEST_%';
    PRINT 'S-au sters ' + CAST(@@ROWCOUNT AS NVARCHAR(10)) + ' inregistrari din MEDICAMENTE';
END
GO


CREATE OR ALTER PROCEDURE DELETE_FURNIZORI
AS
BEGIN
	  SET NOCOUNT ON;
   
    DELETE FROM FURNIZORI 
    WHERE Nume LIKE 'FURNIZOR_TEST_%';
    PRINT 'S-au sters ' + CAST(@@ROWCOUNT AS NVARCHAR(10)) + ' inregistrari din FURNIZORI';
END
GO
DROP PROCEDURE DELETE_FURNIZORI
GO



CREATE OR ALTER PROCEDURE INSERT_GENERIC
	@idTest INT AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @numeTest NVARCHAR(100);
	SELECT @numeTest = Name FROM Tests WHERE TestID = @idTest; 

	DECLARE @numeTabel VARCHAR(100);
	DECLARE @numarLinii INT;
	DECLARE @procedura VARCHAR(1000);

	DECLARE cursorTabele CURSOR FORWARD_ONLY FOR SELECT Tables.Name, TestTables.NoOfRows FROM TestTables
	INNER JOIN Tables ON Tables.TableID = TestTables.TableID
	WHERE TestTables.TestID = @idTest ORDER BY TestTables.Position DESC;

	OPEN cursorTabele;
	FETCH NEXT FROM cursorTabele INTO @numeTabel, @numarLinii;
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		SET @procedura = 'INSERT_' + @numeTabel;
		EXEC @procedura @numarLinii;
		FETCH NEXT FROM cursorTabele INTO @numeTabel, @numarLinii;
	END
	CLOSE cursorTabele;
	DEALLOCATE cursorTabele;
	PRINT 'Inserare pentru testul: ' + @numeTest;
END
GO

CREATE OR ALTER PROCEDURE DELETE_GENERIC
    @idTest INT AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @numeTest NVARCHAR(100);
    SELECT @numeTest = Name FROM Tests WHERE TestID = @idTest; 
    
    
    DECLARE @numeTabel VARCHAR(100);
    DECLARE @numarLinii INT;
    DECLARE @procedura VARCHAR(100);
  
    DECLARE cursorTabele CURSOR FORWARD_ONLY FOR 
        SELECT Tables.Name, TestTables.NoOfRows 
        FROM TestTables
        INNER JOIN Tables ON Tables.TableID = TestTables.TableID
        WHERE TestTables.TestID = @idTest 
        ORDER BY TestTables.Position;

    OPEN cursorTabele;
    FETCH NEXT FROM cursorTabele INTO @numeTabel, @numarLinii;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT 'Ștergere din tabelul: ' + @numeTabel;
        SET @procedura = 'DELETE_' + @numeTabel;
        EXEC @procedura;
        FETCH NEXT FROM cursorTabele INTO @numeTabel, @numarLinii;
    END
      
    CLOSE cursorTabele;
    DEALLOCATE cursorTabele;
END
go


CREATE OR ALTER PROCEDURE SelectTest
	@idTest INT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @numeTabel VARCHAR(100);
	SELECT @numeTabel = Tables.Name FROM Tables INNER JOIN TestTables ON TestTables.TestID = @idTest Where Tables.TableID = TestTables.TableID;
	IF @numeTabel = 'FURNIZORI'
		SELECT * FROM VWFurnizori
	ELSE IF @numeTabel = 'MEDICAMENTE'
		SELECT * FROM VWMedicamente
	ELSE IF @numeTabel= 'FURNIZORI_MEDICAMENTE'
		SELECT * FROM VWFurnizoriMedicamente
	ELSE
		BEGIN
			PRINT 'NU EXISTA PROCEDURA'
			RETURN
		END
END
GO

CREATE OR ALTER PROCEDURE mainTests
	@idTest INT
AS BEGIN

	DECLARE @t1 DATETIME, @t2 DATETIME, @t3 DATETIME, @t4 DATETIME;
	SET @t1 = GETDATE();
	EXEC DELETE_GENERIC @idTest;
	SET @t2 = GETDATE();
	EXEC INSERT_GENERIC @idTest;
	SET @t3 = GETDATE();
	EXEC SelectTest @idTest;
	SET @t4 = GETDATE();
	
	DECLARE @tableName NVARCHAR(100);
	DECLARE @tableId INT;
	SELECT @tableName = Tables.Name, @tableId = Tables.TableID FROM Tables INNER JOIN TestTables ON TestTables.TestID = @idTest Where Tables.TableID = TestTables.TableID;
	DECLARE @viewId INT;
	SELECT @viewId = Views.ViewID FROM Views INNER JOIN TestViews ON TestViews.TestID = @idTest Where TestViews.ViewID = Views.ViewID;
	
	DECLARE @description NVARCHAR(1000) = 'TEST_ID:' + CAST(@idTest AS NVARCHAR(10)) + 'TABLE NAME ' + @tableName;
	DECLARE @testRunId int;
	INSERT INTO TestRuns(Description, StartAt, EndAt) VALUES (@description, @t1, @t4);
	SET @testRunId = (Select TOP 1 TestRunId FROM TestRuns WHERE TestRuns.Description = @description ORDER BY TestRunID);
	INSERT INTO TestRunTables(TestRunID,TableID,StartAt,EndAt) VALUES (@testRunId, @tableId, @t2,@t3);
	INSERT INTO TestRunViews(TestRunID,ViewID,StartAt,EndAt) VALUES (@testRunId, @viewId, @t3, @t4);
	PRINT 'TEST COMPLETE'
END
GO
EXEC mainTests 3



SELECT * FROM TestRuns
SELECT * FROM TestRunTables
SELECT * FROM TestRunViews
SELECT * FROM MEDICAMENTE;
SELECT * FROM FURNIZORI;
SELECT * FROM FURNIZORI_MEDICAMENTE;
SELECT * FROM FURNIZORI WHERE Nume LIKE 'FURNIZOR_TEST_%';
SELECT * FROM MEDICAMENTE WHERE Nume LIKE 'MEDICAMENT_TEST_%';
DELETE FROM MEDICAMENTE;
DELETE FROM FURNIZORI;
DELETE FROM FURNIZORI_MEDICAMENTE
DELETE FROM CATEGORIE;
DELETE FROM MEDICAMENTE  WHERE Nume LIKE 'MEDICAMENT_TEST_%'
DELETE FROM TestRuns
DELETE FROM TestRunTables
DELETE FROM TestRunViews