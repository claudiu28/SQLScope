use SGBD_LAB_3
go

if object_id('scenariu_inserare_partial', 'P') is not null
    drop procedure scenariu_inserare_partial;
go

create procedure scenariu_inserare_partial
    @NumeMedicament varchar(50),
    @DescriereMedicament varchar(500),
    @Pret float,
    @Stoc int,
    @NumeFarmacie varchar(50),
    @NumeCategorie varchar(100)
as
begin
    set nocount on;

    declare @medicamentId int;
    declare @categorieId int;

    begin try
        begin transaction;

            if dbo.ValidareText(@NumeMedicament, 50, 1) = 0
                raiserror('{"Table":"MEDICAMENTE","Action":"VALIDATION","Error":"Nume medicament invalid","Field":"Nume"}', 16, 1);

            if dbo.ValidareText(@DescriereMedicament, 500, 1) = 0
                raiserror('{"Table":"MEDICAMENTE","Action":"VALIDATION","Error":"Descriere invalida","Field":"Descriere"}', 16, 1);

            if dbo.ValidareNumericFloat(@Pret, 0) = 0
                raiserror('{"Table":"MEDICAMENTE","Action":"VALIDATION","Error":"Pret invalid","Field":"Pret"}', 16, 1);

            if dbo.ValidareNumericInt(@Stoc, 0) = 0
                raiserror('{"Table":"MEDICAMENTE","Action":"VALIDATION","Error":"Stoc invalid","Field":"Stoc"}', 16, 1);

            if dbo.ValidareText(@NumeFarmacie, 50, 1) = 0
                raiserror('{"Table":"FARMACIE_DETALII","Action":"VALIDATION","Error":"Nume farmacie invalid","Field":"Nume"}', 16, 1);

            declare @farmacieId int;
            select @farmacieId = FarmacieId from FARMACIE_DETALII where Nume = @NumeFarmacie;

            if @farmacieId is null
                raiserror('{"Table":"FARMACIE_DETALII","Action":"LOOKUP","Error":"Farmacia nu exista.","Field":"Nume"}', 16, 1);

            select @medicamentId = MedicamentId from MEDICAMENTE where Nume = @NumeMedicament and Descriere = @DescriereMedicament and Pret = @Pret and Stoc = @Stoc and FarmacieId = @FarmacieId;

            if @medicamentId is not null
                begin
                    declare @LogInfoMedJson nvarchar(max) ='{"Table":"MEDICAMENTE","Action":"INFO","Fields":{"MedicamentId":' + cast(@medicamentId as nvarchar) + ',"Nume":"' + @NumeMedicament + '","Pret":' + cast(@Pret as nvarchar) + ',"Stoc":' + cast(@Stoc as nvarchar) + ',"FarmacieId":' + cast(@FarmacieId as nvarchar) + '}}';
                    insert into LogActions(ActionType, Entity, Details, IsError, ErrorMessage) values ('INFO', 'MEDICAMENTE', @LogInfoMedJson, 0, NULL);
                end
            else
                begin
                    insert into MEDICAMENTE(Nume, Descriere, Pret, Stoc, FarmacieId) values (@NumeMedicament, @DescriereMedicament, @Pret, @Stoc, @FarmacieId);
                    set @medicamentId = SCOPE_IDENTITY();

                    declare @LogInsertMedicamenteJson nvarchar(max) = '{"Table":"MEDICAMENTE","Action":"INSERT","Fields":{"MedicamentId":' + cast(@medicamentId as nvarchar) + ',"Nume":"' + @NumeMedicament + '","Pret":' + cast(@Pret as nvarchar) + ',"Stoc":' + cast(@Stoc as nvarchar) + ',"FarmacieId":' + cast(@FarmacieId as nvarchar) + '}}';
                    insert into LogActions(ActionType, Entity, Details, IsError, ErrorMessage) values ('INSERT', 'MEDICAMENTE', @LogInsertMedicamenteJson, 0, NULL);
                end
        commit;
    end try
    begin catch
        rollback;
        declare @JsonMsgMed nvarchar(max) = ERROR_MESSAGE();
        declare @ActionTypeMed nvarchar(20) = ISNULL(JSON_VALUE(@JsonMsgMed, '$.Action'), 'UNKNOWN');
        declare @EntityMed nvarchar(50) = ISNULL(JSON_VALUE(@JsonMsgMed, '$.Table'), 'UNKNOWN');
        declare @ErrorTextMed nvarchar(max) = ISNULL(JSON_VALUE(@JsonMsgMed, '$.Error'), 'Error unknown');

        insert into LogActions(ActionType, Entity, Details, IsError, ErrorMessage) values (@ActionTypeMed, @EntityMed, @JsonMsgMed, 1, @ErrorTextMed);
    end catch;

    begin try
        begin transaction;

            if dbo.ValidareText(@NumeCategorie, 100, 1) = 0
                raiserror('{"Table":"CATEGORIE","Action":"VALIDATION","Error":"Nume categorie invalid.","Field":"NumeCategorie"}', 16, 1);

            select @categorieId = CategorieId from CATEGORIE where NumeCategorie = @NumeCategorie;

            if @categorieId is not null
                begin
                    declare @LogInfoCategorieJson nvarchar(max) = '{"Table":"CATEGORIE","Action":"INFO","Fields":{"CategorieId":' + cast(@categorieId as nvarchar) + ',"NumeCategorie":"' + @NumeCategorie + '"}}';
                    insert into LogActions(ActionType, Entity, Details, IsError, ErrorMessage) values ('INFO', 'CATEGORIE', @LogInfoCategorieJson, 0, NULL);
                end
            else 
                begin
                    insert into CATEGORIE(NumeCategorie) values (@NumeCategorie);
                    set @categorieId = SCOPE_IDENTITY();

                    declare @LogInsertCategorieJson nvarchar(max) ='{"Table":"CATEGORIE","Action":"INSERT","Fields":{"CategorieId":' + cast(@categorieId as nvarchar) + ',"NumeCategorie":"' + @NumeCategorie + '"}}';

                    insert into LogActions(ActionType, Entity, Details, IsError, ErrorMessage) values ('INSERT', 'CATEGORIE', @LogInsertCategorieJson, 0, NULL);
                end    
        commit;
    end try
    begin catch
        rollback;
            declare @JsonMsgCateg nvarchar(max) = ERROR_MESSAGE();
            declare @ActionTypeCateg nvarchar(20) = ISNULL(JSON_VALUE(@JsonMsgCateg, '$.Action'), 'UNKNOWN');
            declare @EntityCateg nvarchar(50) = ISNULL(JSON_VALUE(@JsonMsgCateg, '$.Table'), 'UNKNOWN');
            declare @ErrorTextCateg nvarchar(max) = ISNULL(JSON_VALUE(@JsonMsgCateg, '$.Error'), 'Error unknown');

            insert into LogActions(ActionType, Entity, Details, IsError, ErrorMessage) values (@ActionTypeCateg, @EntityCateg, @JsonMsgCateg, 1, @ErrorTextCateg);
    end catch;

    if @medicamentId is not null and @categorieId is not null
        begin
            begin try
                begin transaction;
            
                if exists (select 1 from MEDS_CATEGORIE where MedicamentId = @medicamentId and CategorieId = @categorieId)
                    begin
                        declare @LogInfoLegaturaJson nvarchar(MAX) = '{"Table":"MEDS_CATEGORIE","Action":"INFO","Fields":{"MedicamentId":' + cast(@medicamentId as nvarchar) + ',"CategorieId":' + cast(@categorieId as nvarchar) + '}}';
                        insert into LogActions(ActionType, Entity, Details, IsError, ErrorMessage) 
                        values ('INFO', 'MEDS_CATEGORIE', @LogInfoLegaturaJson, 0, NULL);
                    end
                else
                    begin
                        insert into MEDS_CATEGORIE(MedicamentId, CategorieId) values (@medicamentId, @categorieId);
                
                        declare @LogMedsCategorieJson nvarchar(MAX) = '{"Table":"MEDS_CATEGORIE","Action":"INSERT","Fields":{"MedicamentId":' + cast(@medicamentId as nvarchar) + ',"CategorieId":' + cast(@categorieId as nvarchar) + '}}';
                        insert into LogActions(ActionType, Entity, Details, IsError, ErrorMessage) values ('INSERT', 'MEDS_CATEGORIE', @LogMedsCategorieJson, 0, NULL);
                    end
                commit;
            end try
            begin catch
                rollback;
                declare @JsonMsgLeg nvarchar(max) = ERROR_MESSAGE();
                declare @ActionTypeLeg nvarchar(20) = ISNULL(JSON_VALUE(@JsonMsgLeg, '$.Action'), 'UNKNOWN');
                declare @EntityLeg nvarchar(50) = ISNULL(JSON_VALUE(@JsonMsgLeg, '$.Table'), 'UNKNOWN');
                declare @ErrorTextLeg nvarchar(max) = ISNULL(JSON_VALUE(@JsonMsgLeg, '$.Error'), 'Error unknown');

                insert into LogActions(ActionType, Entity, Details, IsError, ErrorMessage) values (@ActionTypeLeg, @EntityLeg, @JsonMsgLeg, 1, @ErrorTextLeg);
            end catch;
        end
    else
        begin
            declare @FailureReason nvarchar(100);
            if @medicamentId is null and @categorieId is null
                set @FailureReason = 'Medicamentul cat si categoria au id-uri null.';
            else if @medicamentId is null
                set @FailureReason = 'Inserarea medicamentului a esuat.';
            else
                set @FailureReason = 'Inserarea categoriei a esuat.';
    
            declare @LogFailureLegatura nvarchar(max) = '{"Table":"MEDS_CATEGORIE","Action":"SKIP","Error":"' + @FailureReason + '","Field":"Relatie"}';
            insert into LogActions(ActionType, Entity, Details, IsError, ErrorMessage) values ('SKIP', 'MEDS_CATEGORIE', @LogFailureLegatura, 1, @FailureReason);
        end
end
go

-- test inserare totala
exec scenariu_inserare_partial @NumeMedicament = 'Paracetamol', @DescriereMedicament = 'Analgezic și antipiretic', @Pret = 12.75, @Stoc = 100, @NumeFarmacie = 'Farmacia Catena', @NumeCategorie = 'Analgezice';

-- categorie insert, medicament rollback
exec scenariu_inserare_partial @NumeMedicament = '', @DescriereMedicament = 'Descriere valida.', @Pret = 15.0,@Stoc = 45, @NumeFarmacie = 'Farmacia Dona', @NumeCategorie = 'Antibiotice';

-- categorie rollback, medicament insert 
exec scenariu_inserare_partial @NumeMedicament = 'Ibuprofen', @DescriereMedicament = 'Anti-inflamator.', @Pret = 18.5,@Stoc = 65, @NumeFarmacie = 'Farmacia Sensiblu', @NumeCategorie = '';

-- test farmacie null
exec scenariu_inserare_partial @NumeMedicament = 'Aspirina', @DescriereMedicament = 'Pentru dureri de cap.', @Pret = 9.5,@Stoc = 120, @NumeFarmacie = 'Farmacia Inexistenta', @NumeCategorie = 'Analgezice';
