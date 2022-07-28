CREATE PROCEDURE [dbo].[UpdateStudent]
	@Id int,
	@SectionId int,
	@YearResult int
AS
BEGIN
	UPDATE Student SET SectionId = @SectionId, 
	YearResult = @YearResult WHERE Id = @Id
END
