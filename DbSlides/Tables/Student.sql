CREATE TABLE [dbo].[Student] (
    [Id]         INT           IDENTITY (1, 1) NOT NULL,
    [FirstName]  VARCHAR (50)  NOT NULL,
    [LastName]   VARCHAR (50)  NOT NULL,
    [BirthDate]  DATETIME2 (7) NOT NULL,
    [YearResult] INT           NOT NULL,
    [SectionId]  INT           NOT NULL,
    [Active]     BIT           NOT NULL,
    CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED ([Id] ASC)
);

GO
CREATE TRIGGER [dbo].[TR_OnDeleteStudent]
    ON [dbo].[Student]
    INSTEAD OF DELETE
    AS
    BEGIN
        SET NoCount ON
        UPDATE Student SET Active = 0 WHERE Id in (SELECT Id FROM deleted)
    END
GO
ALTER TABLE [dbo].[Student]
    ADD CONSTRAINT [CK_Student_BirthDate] CHECK (BirthDate > '1930-01-01');
GO
ALTER TABLE [dbo].[Student]
    ADD CONSTRAINT [CK_Student_YearResult] CHECK (YearResult between 0 and 20);
GO
ALTER TABLE [dbo].[Student]
    ADD CONSTRAINT [FK_Student_Section] FOREIGN KEY ([SectionId]) REFERENCES [dbo].[Section] ([Id]);
GO
ALTER TABLE [dbo].[Student]
    ADD DEFAULT 1 FOR [Active];