CREATE VIEW [dbo].[V_StudentActive]
	AS 
	SELECT * FROM [Student] WHERE Active = 1
