USE LAB4_FARMACIE
GO

IF OBJECT_ID('COPIE_FARMACIE_DETALII', 'U') IS NOT NULL
BEGIN
	INSERT INTO COPIE_FARMACIE_DETALII(Nume,Locatie) VALUES ('NUME', 'LOCATIE');
END
SELECT * FROM COPIE_FARMACIE_DETALII

IF OBJECT_ID('Tests', 'U') IS NOT NULL
BEGIN
	INSERT INTO Tests(Name) VALUES
	('test')
END
GO
SELECT * FROM Tests


IF OBJECT_ID('Tables', 'U') IS NOT NULL
BEGIN

	INSERT INTO Tables(Name) VALUES 
	('COPIE_FURNIZORI'), -- PK !FK
	('COPIE_MEDICAMENTE'), -- PK & FK
	('COPIE_FURNIZORI_MEDICAMENTE') -- PK FORMAT DIN 2 FIELDS
	
END
SELECT * FROM Tables
GO

IF OBJECT_ID('TestTables') IS NOT NULL
BEGIN
	INSERT INTO TestTables(TestID, TableID, NoOfRows, Position)
	VALUES 
	
	(1,3,1000,1),
	(1,2,1000,2),
	(1,1,1000,3)
END
GO
SELECT * FROM TestTables;
GO


CREATE OR ALTER VIEW VWFurnizori AS
	SELECT Nume, Adresa from COPIE_FURNIZORI;
GO
SELECT * FROM VWFurnizori;
GO

CREATE OR ALTER VIEW VWMedicamente
AS
	SELECT M.MedicamentId, M.Nume, M.Descriere, M.Pret, F.Nume AS FurnizorNume FROM COPIE_MEDICAMENTE M
    INNER JOIN COPIE_FURNIZORI_MEDICAMENTE FM ON FM.MedicamentId = M.MedicamentId
    INNER JOIN COPIE_FURNIZORI F ON F.FurnizoriId = FM.FurnizoriId;
GO
SELECT * FROM VWMedicamente;
GO

CREATE OR ALTER VIEW VWFurnizoriMedicamente AS
	SELECT M.Nume, M.Descriere, COUNT(F.FurnizoriId) AS NumarFurnizori, SUM(M.Stoc) AS CantitateTotala
	FROM COPIE_MEDICAMENTE AS M 
	INNER JOIN COPIE_FURNIZORI_MEDICAMENTE AS FM ON FM.MedicamentId = M.MedicamentId
	INNER JOIN COPIE_FURNIZORI AS F ON FM.FurnizoriId = F.FurnizoriId 
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
SELECT * FROM VIEWS


IF OBJECT_ID('TestViews', 'U') IS NOT NULL
BEGIN
	INSERT INTO TestViews(TestId, ViewId) VALUES 
	(1,1),
	(1,2),
	(1,3)
END
GO
SELECT * FROM TestViews
GO

CREATE OR ALTER PROCEDURE INSERT_COPIE_FURNIZORI
	@numarLinii INT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @number INT SET @number = 0;
	WHILE @number < @numarLinii
	BEGIN
		INSERT INTO COPIE_FURNIZORI(Nume,Adresa) VALUES 
			( 'TESTARE_' + CAST(@number AS NVARCHAR(100)), 'ADRESA_' + CAST(@number AS NVARCHAR(100)))
		SET @number = @number + 1;
	END
	PRINT 'INSERT IN COPIE FURNIZORI -> SUCCES'
END
GO

CREATE OR ALTER PROCEDURE DELETE_COPIE_FURNIZORI
AS
BEGIN
	SET NOCOUNT ON;
	DELETE FROM COPIE_FURNIZORI;
	PRINT 'DELETE DIN COPIE FURNIZORI -> SUCCES'
END
GO

CREATE OR ALTER PROCEDURE INSERT_COPIE_MEDICAMENTE
	@numarLinii INT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @numar INT SET @numar = 0;
	DECLARE @farmacieDetalii INT SET @farmacieDetalii = 1;

	WHILE @numar < @numarLinii
	BEGIN
		INSERT INTO COPIE_MEDICAMENTE(Nume,Descriere,Pret,Stoc,FarmacieId) VALUES
			(
				N'TESTARE' + CAST(@numar AS NVARCHAR(100)),
				N'TESTARE_DESCRIERE_' + CAST(@numar AS NVARCHAR(100)),
				FLOOR(RAND() *  10) + 1,
				FLOOR(RAND() * 10) + 1,
				@farmacieDetalii
			)
		SET @numar = @numar + 1	
	END
	PRINT 'S-A INSERAT IN COPIE_MEDIACMENTE CU SUCCES'
END
GO

EXEC INSERT_COPIE_MEDICAMENTE 1000;
SELECT * FROM COPIE_MEDICAMENTE;
GO

CREATE OR ALTER PROCEDURE DELETE_COPIE_MEDICAMENTE
AS
BEGIN
	SET NOCOUNT ON; 
    DELETE FROM COPIE_MEDICAMENTE 
    PRINT 'S-AU STERS CU SUCCES DIN COPIE MEDIACMENTE';
END
GO

CREATE OR ALTER PROCEDURE INSERT_COPIE_FURNIZORI_MEDICAMENTE
	@numarLinii INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @numar INT SET @numar  = 0;
	
	DECLARE @medicamentId INT;
	DECLARE @furnizoriId INT;

	DECLARE cursorMedicamente CURSOR FOR SELECT CM.MedicamentId FROM COPIE_MEDICAMENTE AS CM;
	DECLARE cursorFurnizori CURSOR FOR SELECT F.FurnizoriId FROM COPIE_FURNIZORI AS F;

	OPEN cursorMedicamente;
	OPEN cursorFurnizori;

	FETCH NEXT FROM cursorMedicamente INTO @medicamentId;
	FETCH NEXT FROM cursorFurnizori INTO @furnizoriId;

	WHILE @numar < @numarLinii AND @@FETCH_STATUS = 0
	BEGIN
		INSERT INTO COPIE_FURNIZORI_MEDICAMENTE(FurnizoriId,MedicamentId) VALUES (@furnizoriId,@medicamentId);
		
		FETCH NEXT FROM cursorMedicamente INTO @medicamentId;
		FETCH NEXT FROM cursorFurnizori INTO @furnizoriId;
		
		SET @numar = @numar + 1;
	END
	CLOSE cursorMedicamente;
	CLOSE cursorFurnizori;
	DEALLOCATE cursorMedicamente;
	DEALLOCATE cursorFurnizori;
	PRINT 'S-A INSERAT CU SUCCES IN FURNIZORI_MEDIACMENTE';
END
GO

CREATE OR ALTER PROCEDURE DELETE_COPIE_FURNIZORI_MEDICAMENTE
AS
BEGIN
	SET NOCOUNT ON;
    DELETE FROM COPIE_FURNIZORI_MEDICAMENTE;
    PRINT 'S-A STERS CU SUCCES DIN FURNIZORI MEDIACMENTE';
END
GO


CREATE OR ALTER PROCEDURE MAIN_RUNS
	@idTest INT 
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @t1 DATETIME SET @t1 = GETDATE();
	DECLARE @description NVARCHAR(100) SET @description = 'TEST';
	INSERT INTO TestRuns(Description,StartAt) VALUES (@description,@t1);
	DECLARE @TestRunId INT SET @TestRunId = SCOPE_IDENTITY();

	
	-- TABLES --

	--- STERGERE ---
	DECLARE deleteCursor CURSOR FOR SELECT TT.TableID FROM TestTables as TT WHERE TT.TestID = @idTest ORDER BY TT.Position ASC;
	OPEN deleteCursor

	DECLARE @idTable INT;

	FETCH NEXT FROM deleteCursor INTO @idTable;
	
	DECLARE @numeTabel NVARCHAR(100);
	DECLARE @proceduraStergere NVARCHAR(100);

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @numeTabel = Tables.Name FROM Tables WHERE @idTable = Tables.TableID;
		
		SET @proceduraStergere = N'EXEC DELETE_' + @numeTabel;
		EXEC sp_executesql @proceduraStergere;
		IF EXISTS (SELECT 1 FROM sys.identity_columns WHERE OBJECT_NAME(object_id) = @numeTabel)
		BEGIN
			DECLARE @reseedCmd NVARCHAR(MAX) = N'DBCC CHECKIDENT (' + QUOTENAME(@numeTabel) + ', RESEED, 0);';
            EXEC sp_executesql @reseedCmd;	
		END 
		FETCH NEXT FROM deleteCursor INTO @idTable;
	END

	CLOSE deleteCursor;
	DEALLOCATE deleteCursor;

	--INSERARE--
	DECLARE insertCursor CURSOR FOR SELECT TT.NoOfRows, TT.TableID FROM TestTables AS TT WHERE @idTest = TT.TestID ORDER BY TT.Position DESC;
	
	OPEN insertCursor;

	DECLARE @numarLinii INT, @idTableInt INT;
	DECLARE @proceduraInsert NVARCHAR(100);

	FETCH NEXT FROM insertCursor INTO @numarLinii, @idTableInt;
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		SELECT @numeTabel = Tables.Name FROM Tables WHERE Tables.TableID = @idTableInt;

		DECLARE @tInsert1 DATETIME = GETDATE();
		SET @proceduraInsert = N'EXEC INSERT_' + @numeTabel + ' ''' + CAST(@numarLinii AS VARCHAR(10)) + '''';
		EXEC sp_executesql @proceduraInsert;
		DECLARE @tInsert2 DATETIME = GETDATE();

		INSERT INTO TestRunTables(TestRunID,TableID,StartAt,EndAt) VALUES (@TestRunId, @idTableInt, @tInsert1, @tInsert2);

		FETCH NEXT FROM insertCursor INTO @numarLinii, @idTableINT;

	END

	CLOSE insertCursor;
	DEALLOCATE insertCursor;

	-- VIEWS --

	DECLARE cursorViews CURSOR FOR SELECT TW.ViewID FROM TestViews AS TW WHERE TW.TestID = @idTest;

	OPEN cursorViews;
		
	DECLARE @IDVIEW INT;

	FETCH NEXT FROM cursorViews INTO @IDVIEW;
	DECLARE @numeViews NVARCHAR(100);
	DECLARE @CMD NVARCHAR(100);
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @numeViews = V.Name FROM Views AS V WHERE @IDVIEW = V.ViewID;
		DECLARE @tView1 DATETIME = GETDATE();
		SET @CMD = 'SELECT * FROM ' + @numeViews;
		EXEC sp_executesql @CMD;
		DECLARE @tView2 DATETIME = GETDATE();

		INSERT INTO TestRunViews(TestRunID,ViewID,StartAt,EndAt) VALUES (@TestRunId, @IDVIEW,@tView1,@tView2);
		FETCH NEXT FROM cursorViews INTO @IDVIEW;
	END
	CLOSE cursorViews;
	DEALLOCATE cursorViews;

	DECLARE @t2 DATETIME SET @t2 = GETDATE();
	UPDATE TestRuns SET EndAt = @t2 WHERE TestRunID = @TestRunId
END

EXEC MAIN_RUNS 1;

SELECT * FROM Tables;
SELECT * FROM Tests;
SELECT * FROM Views;
SELECT * FROM TestTables;
SELECT * FROM TestViews;
SELECT * FROM TestRuns;
SELECT * FROM TestRunTables;
SELECT * FROM TestRunViews;
SELECT * FROM COPIE_FURNIZORI;
SELECT * FROM COPIE_MEDICAMENTE;
SELECT * FROM COPIE_FURNIZORI_MEDICAMENTE;

DELETE FROM TestRuns;