CREATE PROCEDURE [dbo].[AddStudent]
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @BirthDate DATETIME2,
    @YearResult INT,
    @SectionId INT
AS
BEGIN
    DECLARE @tmpSectionId INT
    SET @tmpSectionId = (SELECT Id FROM Section WHERE Id = @SectionId)

    IF @tmpSectionId <> Null
    BEGIN
        INSERT INTO Student (FirstName, LastName, BirthDate, YearResult, SectionId)
        VALUES(@FirstName, @LastName, @BirthDate, @YearResult, @SectionId)
    END
END