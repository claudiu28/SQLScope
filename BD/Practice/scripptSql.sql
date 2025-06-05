go
-------------------------------
CREATE VIEW VW_Angajati_Salariu_Mare AS
SELECT idAngajat, nume, salariu 
FROM Angajati
WHERE salariu > 5000;

SELECT * FROM VW_Angajati_Salariu_Mare;

go
-------------------------------------------------------------------------------
CREATE PROCEDURE NumarAngajatiInDepartament
    @idDepartament INT,
    @numarAngajati INT OUTPUT
AS
BEGIN
    SELECT @numarAngajati = COUNT(*) 
    FROM Angajati
    WHERE idDepartament = @idDepartament;
END;
GO
----------------------------------------------------------------------------------
DECLARE @nr INT;
EXEC NumarAngajatiInDepartament @idDepartament = 2, @numarAngajati = @nr OUTPUT;
PRINT 'Număr angajați: ' + CAST(@nr AS VARCHAR);
go
CREATE FUNCTION SalariuMaxim (@idDepartament INT)
RETURNS INT
AS
BEGIN
    DECLARE @maxSalariu INT;
    SELECT @maxSalariu = MAX(salariu)
    FROM Angajati
    WHERE idDepartament = @idDepartament;
    RETURN @maxSalariu;
END;
GO

SELECT dbo.SalariuMaxim(2) AS Salariu_Maxim;
go
-----------------------------------------------------------------------------
CREATE FUNCTION AngajatiInDepartament (@idDepartament INT)
RETURNS TABLE
AS
RETURN 
(
    SELECT idAngajat, nume, salariu
    FROM Angajati
    WHERE idDepartament = @idDepartament
);

GO
SELECT * FROM dbo.AngajatiInDepartament(2);
---------------------------------------------------------------------------
go
DECLARE numeCursor CURSOR FOR
SELECT coloana1, coloana2 FROM Tabel WHERE conditie;

OPEN numeCursor;

FETCH NEXT FROM numeCursor INTO @variabila1, @variabila2;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Operațiuni pe fiecare rând
    FETCH NEXT FROM numeCursor INTO @variabila1, @variabila2;
END;

CLOSE numeCursor;
DEALLOCATE numeCursor;

go
CREATE PROCEDURE TotalSalarii
    @totalSalarii INT OUTPUT
AS
BEGIN
    DECLARE @salariu INT;
    SET @totalSalarii = 0;

    DECLARE cursorSalarii CURSOR FOR
    SELECT salariu FROM Angajati;

    OPEN cursorSalarii;
    FETCH NEXT FROM cursorSalarii INTO @salariu;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @totalSalarii = @totalSalarii + @salariu;
        FETCH NEXT FROM cursorSalarii INTO @salariu;
    END;

    CLOSE cursorSalarii;
    DEALLOCATE cursorSalarii;
END;
GO
----------------------------------------------------
CREATE TRIGGER NumeTrigger 
ON NumeTabel
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Acțiuni pe datele nou inserate sau modificate
END;
--------------------------------------------------------
CREATE TABLE LogActiuni (
    idLog INT IDENTITY(1,1) PRIMARY KEY,
    descriere VARCHAR(255),
    dataActiune DATETIME DEFAULT GETDATE()
);
go
CREATE TRIGGER trg_AfterInsert_Angajati
ON Angajati
AFTER INSERT
AS
BEGIN
    INSERT INTO LogActiuni (descriere)
    SELECT 'Angajat adăugat: ' + nume FROM inserted;
END;
--------------------------------------