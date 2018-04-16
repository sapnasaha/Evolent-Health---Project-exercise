
IF NOT  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactStatus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ContactStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ContactStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ContactStatus WHERE Name = 'Active')
BEGIN
	INSERT INTO ContactStatus (Id, Name) VALUES ('Active')
END
GO
IF NOT EXISTS (SELECT * FROM ContactStatus WHERE Name = 'Inactive')
BEGIN
	INSERT INTO ContactStatus (Id, Name) VALUES ('Inactive')
END
GO
IF NOT  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactDetails]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ContactDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](50) NULL,
	[PhoneNumber] [nvarchar](50) NULL,
	[Status] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_ContactDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT *	FROM sys.foreign_keys	WHERE object_id = OBJECT_ID(N'[dbo].[FK_ContactDetails_ContactStatus]')	AND parent_object_id = OBJECT_ID(N'[dbo].[ContactDetails]'))
BEGIN
ALTER TABLE [dbo].[ContactDetails]  WITH CHECK ADD  CONSTRAINT [FK_ContactDetails_ContactStatus] FOREIGN KEY([Status])
REFERENCES [dbo].[ContactStatus] ([Id])
END
GO

ALTER TABLE [dbo].[ContactDetails] CHECK CONSTRAINT [FK_ContactDetails_ContactStatus]
GO


