CREATE PROCEDURE [dbo].[AddSection]
	@Id int,
	@SectionName VARCHAR(50)
AS
BEGIN
	INSERT INTO Section (Id, SectionName) 
	VALUES(@Id, @SectionName)
END