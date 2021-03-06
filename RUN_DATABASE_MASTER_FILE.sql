/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2016 (13.0.4206)
    Source Database Engine Edition : Microsoft SQL Server Standard Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/

USE [Pokemon]
GO

-- =============================================
--             DROP TABLES
-- =============================================

DROP TABLE [dbo].[Round]
DROP TABLE [dbo].[Battle]
DROP TABLE [dbo].[Friends]
DROP TABLE [dbo].[TrainerPokemon]
DROP TABLE [dbo].[Trainer]
DROP TABLE [dbo].[Pokemon]


-- =============================================
--             CREATE TABLES
-- =============================================


/****** Object:  Table [dbo].[Pokemon]    Script Date: 14/11/2018 19:02:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pokemon](
	[PokemonID] [smallint] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Attack] [smallint] NOT NULL,
	[Defence] [smallint] NOT NULL,
	[SpecialAttack] [smallint] NOT NULL,
	[SpecialDefence] [smallint] NOT NULL,
	[Speed] [smallint] NOT NULL,
	[Image] [image] NULL,
 CONSTRAINT [PK_Pokemon_1] PRIMARY KEY CLUSTERED 
(
	[PokemonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  View [dbo].[view_pokemon]    Script Date: 14/11/2018 19:02:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER  VIEW [dbo].[view_pokemon] AS
SELECT PokemonID,Name, Attack, Defence, SpecialAttack, SpecialDefence, Speed 
FROM Pokemon;
GO

/****** Object:  Table [dbo].[Battle]    Script Date: 14/11/2018 19:02:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Battle](
	[BattleID] [smallint] NOT NULL DEFAULT (NEXT VALUE FOR Seq_BattleID),
	[TrainerID1] [smallint] NULL,
	[TrainerID2] [smallint] NULL,
	[Date] [datetime] NULL,
 CONSTRAINT [PK_Battle_1] PRIMARY KEY CLUSTERED 
(
	[BattleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[Round]    Script Date: 14/11/2018 19:02:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Round](
	[RoundID] [smallint] NOT NULL DEFAULT (NEXT VALUE FOR Seq_RoundID),
	[BattleID] [smallint] NOT NULL,
	[TrainerPokemonID] [smallint] NOT NULL,
	[Trainer2PokemonID] [smallint] NOT NULL,
	[FirstTrainerID] [smallint] NOT NULL,
	[StatChosen] [nchar](15) NOT NULL,
	[WinnerID] [smallint] NOT NULL,
 CONSTRAINT [PK_Round_1] PRIMARY KEY CLUSTERED 
(
	[RoundID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/****** Object:  View [dbo].[view_Trainer1WinCheck]    Script Date: 14/11/2018 19:02:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[view_Trainer1WinCheck] AS
SELECT COUNT(r.WinnerID)Rounds_Won
FROM Battle b JOIN Round r ON b.BattleID = r.BattleID
WHERE r.WinnerID = b.TrainerID1
GO

/****** Object:  View [dbo].[view_Trainer2WinCheck]    Script Date: 14/11/2018 19:24:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER  VIEW [dbo].[view_Trainer2WinCheck] AS
SELECT COUNT(r.WinnerID)Rounds_Won
FROM Battle b JOIN Round r ON b.BattleID = r.BattleID
WHERE r.WinnerID = b.TrainerID2
GO

/****** Object:  Table [dbo].[Friends]    Script Date: 14/11/2018 19:02:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Friends](
	[TrainerID1] [smallint] NOT NULL,
	[TrainerID2] [smallint] NOT NULL,
	[CreationDate] [datetime] NULL,
 CONSTRAINT [PK_Friends] PRIMARY KEY CLUSTERED 
(
	[TrainerID1] ASC,
	[TrainerID2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[Trainer]    Script Date: 14/11/2018 19:02:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trainer](
	[TrainerID] [smallint] NOT NULL DEFAULT (NEXT VALUE FOR Seq_TrainerID),
	[TName] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Email] [varchar](max) NOT NULL,
	[CreationDate] [datetime] NULL,
 CONSTRAINT [PK_Trainer_1] PRIMARY KEY CLUSTERED 
(
	[TrainerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


/****** Object:  Table [dbo].[TrainerPokemon]    Script Date: 14/11/2018 19:02:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrainerPokemon](
	[PokemonID] [smallint] NOT NULL,
	[TrainerID] [smallint] NOT NULL,
	[Team] [bit] NOT NULL,
	[Favourite] [bit] NOT NULL,
 CONSTRAINT [PK_TrainerPokemon] PRIMARY KEY CLUSTERED 
(
	[PokemonID] ASC,
	[TrainerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Battle]  WITH CHECK ADD  CONSTRAINT [FK_Battle_Trainer] FOREIGN KEY([TrainerID1])
REFERENCES [dbo].[Trainer] ([TrainerID])
GO
ALTER TABLE [dbo].[Battle] CHECK CONSTRAINT [FK_Battle_Trainer]
GO
ALTER TABLE [dbo].[Battle]  WITH CHECK ADD  CONSTRAINT [FK_Battle_Trainer1] FOREIGN KEY([TrainerID2])
REFERENCES [dbo].[Trainer] ([TrainerID])
GO
ALTER TABLE [dbo].[Battle] CHECK CONSTRAINT [FK_Battle_Trainer1]
GO
ALTER TABLE [dbo].[Friends]  WITH CHECK ADD  CONSTRAINT [FK_Friends_Trainer] FOREIGN KEY([TrainerID1])
REFERENCES [dbo].[Trainer] ([TrainerID])
GO
ALTER TABLE [dbo].[Friends] CHECK CONSTRAINT [FK_Friends_Trainer]
GO
ALTER TABLE [dbo].[Friends]  WITH CHECK ADD  CONSTRAINT [FK_Friends_Trainer1] FOREIGN KEY([TrainerID2])
REFERENCES [dbo].[Trainer] ([TrainerID])
GO
ALTER TABLE [dbo].[Friends] CHECK CONSTRAINT [FK_Friends_Trainer1]
GO
ALTER TABLE [dbo].[Round]  WITH CHECK ADD  CONSTRAINT [FK_Round_Battle] FOREIGN KEY([BattleID])
REFERENCES [dbo].[Battle] ([BattleID])
GO
ALTER TABLE [dbo].[Round] CHECK CONSTRAINT [FK_Round_Battle]
GO
ALTER TABLE [dbo].[TrainerPokemon]  WITH CHECK ADD  CONSTRAINT [FK_TrainerPokemon_Pokemon] FOREIGN KEY([PokemonID])
REFERENCES [dbo].[Pokemon] ([PokemonID])
GO
ALTER TABLE [dbo].[TrainerPokemon] CHECK CONSTRAINT [FK_TrainerPokemon_Pokemon]
GO
ALTER TABLE [dbo].[TrainerPokemon]  WITH CHECK ADD  CONSTRAINT [FK_TrainerPokemon_Trainer] FOREIGN KEY([TrainerID])
REFERENCES [dbo].[Trainer] ([TrainerID])
GO
ALTER TABLE [dbo].[TrainerPokemon] CHECK CONSTRAINT [FK_TrainerPokemon_Trainer]
GO



-- =============================================
--             Stored Procedures
-- =============================================




/****** Object:  StoredProcedure [dbo].[addFavourate]    Script Date: 14/11/2018 19:02:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[addFavourate] @TrainerID smallint, @PokemonId smallint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	IF (SELECT COUNT(TrainerID) FROM TrainerPokemon WHERE TrainerID =@TrainerID AND Favourite=1) <3
	UPDATE TrainerPokemon SET Favourite = 1 WHERE PokemonID = @PokemonID AND TrainerID = @TrainerID;    

END
GO

/****** Object:  StoredProcedure [dbo].[checkBattleWinner]    Script Date: 15/11/2018 18:35:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER  PROCEDURE [dbo].[checkBattleWinner] @TrainerID smallint, @BattleID smallint
AS
DECLARE @Count INT
BEGIN

SET @Count = (SELECT COUNT(RoundID) From Round where WinnerID = @TrainerID AND BattleID = @BattleID)

RETURN @Count
END

/****** Object:  StoredProcedure [dbo].[checkFivePokemon]    Script Date: 14/11/2018 19:02:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[checkFivePokemon]
@trainerID INT
AS 
BEGIN
	IF (SELECT COUNT(PokemonID) FROM TrainerPokemon WHERE 
	TrainerID=@trainerID) != 5
	RAISERROR (N'%*.*s>>',10,1,50,3,N'Must have 5 Pokemon!');
END
GO



/****** Object:  StoredProcedure [dbo].[flipCoin]    Script Date: 14/11/2018 19:02:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[flipCoin]
AS
DECLARE @Coin INT

BEGIN

SET @Coin = 2*RAND();
PRINT @Coin

RETURN @Coin
END

/****** Object:  StoredProcedure [dbo].[getEnemyStat]    Script Date: 14/11/2018 19:02:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [dbo].[getEnemyStat] @statchosen nvarchar(15), @Trainer2PokemonID smallint
AS
BEGIN

DECLARE @STAT smallint
	
IF (@statchosen = 'Attack')  
BEGIN     
	SET @STAT = (SELECT Defence FROM dbo.Pokemon WHERE PokemonID = @Trainer2PokemonID)
END

ELSE IF (@StatChosen = 'Defence')
BEGIN
	SET @STAT = (SELECT Attack FROM dbo.Pokemon WHERE PokemonID = @Trainer2PokemonID)
END

ELSE IF (@StatChosen = 'SpecialAttack')
BEGIN
	SET @STAT = (SELECT SpecialDefence FROM dbo.Pokemon WHERE PokemonID = @Trainer2PokemonID)
END

ELSE IF (@StatChosen = 'SpecialDefence')
BEGIN
	SET @STAT = (SELECT SpecialAttack FROM dbo.Pokemon WHERE PokemonID = @Trainer2PokemonID)
END

ELSE  
BEGIN
    SET @STAT = (SELECT Speed FROM dbo.Pokemon WHERE PokemonID = @Trainer2PokemonID)
END
RETURN @STAT

END





/****** Object:  StoredProcedure [dbo].[getRoundWinner]    Script Date: 14/11/2018 19:02:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[getRoundWinner] @Stat1 smallint, @Stat2 smallint, @Trainer1ID smallint, @Trainer2ID smallint
AS
BEGIN
IF @Stat1 > @Stat2
	RETURN @Trainer1ID
ELSE
	RETURN @Trainer2ID
END


/****** Object:  StoredProcedure [dbo].[getStatChosen]    Script Date: 14/11/2018 19:02:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[getStatChosen] @StatChosen nvarchar(15), @Trainer2PokemonID smallint
AS
BEGIN
DECLARE @STAT smallint
	
IF (@statchosen = 'Attack')  
BEGIN     
	SET @STAT = (SELECT Attack FROM dbo.Pokemon WHERE PokemonID = @Trainer2PokemonID)
END

ELSE IF (@StatChosen = 'Defence')
BEGIN
	SET @STAT = (SELECT Defence FROM dbo.Pokemon WHERE PokemonID = @Trainer2PokemonID)
END

ELSE IF (@StatChosen = 'SpecialAttack')
BEGIN
	SET @STAT = (SELECT SpecialAttack FROM dbo.Pokemon WHERE PokemonID = @Trainer2PokemonID)
END

ELSE IF (@StatChosen = 'SpecialDefence')
BEGIN
	SET @STAT = (SELECT SpecialDefence FROM dbo.Pokemon WHERE PokemonID = @Trainer2PokemonID)
END

ELSE  
BEGIN
    SET @STAT = (SELECT Speed FROM dbo.Pokemon WHERE PokemonID = @Trainer2PokemonID)
END
RETURN @STAT

END
/****** Object:  StoredProcedure [dbo].[getValidEmail]    Script Date: 14/11/2018 19:02:25 ******/
SET ANSI_NULLS ON


/****** Object:  StoredProcedure [dbo].[getValidEmail]    Script Date: 14/11/2018 19:02:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [dbo].[getValidEmail] @Email varchar(50)
AS
BEGIN
	IF (SELECT COUNT(Email) FROM Trainer WHERE Email = @Email) != 0
		RAISERROR (N'%*.*s>>',10,1,50,3,N'Invalid email address, email already exists!'); 
END
GO


/****** Object:  StoredProcedure [dbo].[getValidTName]    Script Date: 14/11/2018 19:02:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [dbo].[getValidTName] @TName varchar(50)
AS
BEGIN
	IF (SELECT COUNT(TName) FROM Trainer WHERE TName = @TName) != 0
		RAISERROR (N'%*.*s>>',10,1,50,3,N'Invalid trainer name, trainer name already exists!'); 
END
GO

/****** Object:  StoredProcedure [dbo].[initiateRound]    Script Date: 15/11/2018 18:35:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [dbo].[initiateRound] @TrainerID1 smallint, @TrainerID2 smallint, @BattleID smallint, @Pokemon1ID smallint, @Pokemon2ID smallint
AS
BEGIN

	DECLARE @RoundID smallint
	DECLARE @Stat nvarchar(MAX)
	DECLARE @RandStat INT
	 
	SET @RandStat = 5*RAND();
	
	SET @Stat =
		CASE @RandStat
			WHEN 1 THEN 'Attack'
			WHEN 2 THEN	'Defence'
			WHEN 3 THEN 'SpecialAttack'
			WHEN 4 THEN 'SpecialDefence'
			ELSE  'Speed'
		END
	
	DECLARE @Trainer1Stat  INT;
	EXEC @Trainer1Stat = dbo.getStatChosen @StatChosen= @Stat, @Trainer2PokemonID =@Pokemon1ID;

	DECLARE @Trainer2Stat  INT;	
	EXEC @Trainer2Stat = dbo.getEnemyStat @StatChosen= @Stat, @Trainer2PokemonID =@Pokemon2ID;

	DECLARE @Winner INT;
	EXEC @Winner = dbo.getRoundWinner @Trainer1Stat, @Trainer2Stat, @TrainerID1, @TrainerID2;

	SET @RoundID = (SELECT MAX(RoundID)FROM Round)+1
	

	INSERT INTO round VALUES (@RoundID, @BattleID, @Pokemon1ID, @Pokemon2ID, 0, @Stat, @Winner);
	
	
END

/****** Object:  StoredProcedure [dbo].[updateTeam]    Script Date: 14/11/2018 19:02:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [dbo].[updateTeam] @TrainerID smallint, @PokemonOff smallint, @PokemonOn smallint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	IF (SELECT COUNT(TrainerID) FROM TrainerPokemon WHERE TrainerID =@TrainerID AND Team=1) =5
	UPDATE TrainerPokemon SET Team = 0 WHERE PokemonID = @PokemonOff AND TrainerID = @TrainerID;    
	
	IF (SELECT COUNT(TrainerID) FROM TrainerPokemon WHERE TrainerID =@TrainerID AND Team=1) <5
	UPDATE TrainerPokemon SET Team = 1 WHERE PokemonID = @PokemonOn AND TrainerID = @TrainerID;  
		

END
GO
/****** Object:  StoredProcedure [dbo].[getNewPokemon]    Script Date: 14/11/2018 19:02:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [dbo].[getNewPokemon] @TrainerID smallint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	

	DECLARE @RandPoke INT = 82;
	SET @RandPoke = 82*RAND();


	IF (SELECT COUNT(TrainerID) FROM TrainerPokemon WHERE TrainerID =@TrainerID) =82
			RETURN
            
    ELSE
	WHILE (Select TrainerID from dbo.TrainerPokemon WHERE TrainerID = @TrainerID And PokemonID =@RandPoke) != 0 
		BEGIN
        SET @RandPoke =82*RAND();
        END

		INSERT INTO TrainerPokemon VALUES(@RandPoke, @TrainerID, 0, 0);  
     
     
	 EXEC dbo.updateTeam @TrainerID = @TrainerID, @PokemonOff = 0, @PokemonOn = @RandPoke
	    
		 RETURN

END
GO

/****** Object:  StoredProcedure [dbo].[initiateBattle]    Script Date: 15/11/2018 20:27:08 ******/
SET ANSI_NULLS ON


/****** Object:  StoredProcedure [dbo].[initiateBattle]    Script Date: 15/11/2018 20:27:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [dbo].[initiateBattle] @TrainerID1 smallint, @TrainerID2 smallint, @BattleID smallint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	

DECLARE @Trainer1Score  INT;
	SET @Trainer1Score = 0;

	DECLARE @Trainer2Score  INT;
	SET @Trainer2Score = 0;

    DECLARE @Coin BIT;
	SET @Coin = 0;
	EXEC @Coin = dbo.flipCoin
	
	DECLARE @TempTrainer INT = @TrainerID1;
	
	IF (@Coin = 1)
	BEGIN
		SET @TRAINERID1 = @TRAINERID2;
		SET @TRAINERID2 = @TempTrainer;
	END

	DECLARE  Team1Cursor CURSOR FOR SELECT PokemonID FROM TrainerPokemon WHERE TrainerID = @TrainerID1 AND Team = 1;

	DECLARE  Team2Cursor CURSOR FOR SELECT PokemonID FROM TrainerPokemon WHERE TrainerID = @TrainerID2 AND Team = 1;

	DECLARE @Pokemon1ID  smallint;
	DECLARE @Pokemon2ID  smallint;

	OPEN Team1Cursor
	FETCH NEXT FROM Team1Cursor INTO @Pokemon1ID

	OPEN Team2Cursor
	FETCH NEXT FROM Team2Cursor INTO @Pokemon2ID

	INSERT INTO Battle VALUES(@BattleID, @TrainerID1, @TrainerID2, GETDATE())

	WHILE (@Trainer1Score < 3 AND @Trainer2Score <3 )
	BEGIN 

	EXEC dbo.initiateRound @TrainerID1, @TrainerID2, @BattleID, @Pokemon1ID, @Pokemon2ID
	
	FETCH NEXT FROM Team1Cursor INTO @Pokemon1ID
	FETCH NEXT FROM Team2Cursor INTO @Pokemon2ID
	
	SET @Trainer1Score = (SELECT COUNT(RoundID) From Round where WinnerID = @TrainerID1 AND BattleID = @BattleID)
	SET @Trainer2Score = (SELECT COUNT(RoundID) From Round where WinnerID = @TrainerID2 AND BattleID = @BattleID)

	SET @TempTrainer = @TrainerID1;
	SET @TRAINERID1 = @TRAINERID2;
	SET @TRAINERID2 = @TempTrainer;	
	

	END
	
	IF (@Trainer1Score=3)
	EXEC dbo.getNewPokemon @TrainerID2

	ELSE
	EXEC dbo.getNewPokemon @TrainerID1

	CLOSE Team1Cursor
	DEALLOCATE Team1Cursor

	CLOSE Team2Cursor
	DEALLOCATE Team2Cursor


END

/****** Object:  StoredProcedure [dbo].[insertRoundWinner]    Script Date: 15/11/2018 18:35:56 ******/
SET ANSI_NULLS ON

/****** Object:  StoredProcedure [dbo].[insertRoundWinner]    Script Date: 15/11/2018 18:35:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER  PROCEDURE [dbo].[insertRoundWinner] @BattleID INT, @WinnerID INT
AS
BEGIN
UPDATE dbo.Round
SET WinnerID = @WinnerID
WHERE BattleID = @BattleID
AND RoundID = (SELECT MAX(RoundID) FROM dbo.Round)

END
GO


/****** Object:  StoredProcedure [dbo].[LoadPokemonImage]    Script Date: 14/11/2018 19:02:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[LoadPokemonImage] 
	-- Add the parameters for the stored procedure here
	@PokemonName  NVARCHAR(200) 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @fileName NVARCHAR(MAX)
	DECLARE @sql NVARCHAR(MAX)
	PRINT 'Stored Proc '
	SET @fileName = 'C:\pokemon\main-sprites\firered-leafgreen\' + @PokemonName + '.png'
    -- Insert statements for procedure here
	SET @sql ='UPDATE [dbo].[Pokemon] SET [Image] = (SELECT BulkColumn FROM OPENROWSET (BULK N'''+ @fileName+ ''' , SINGLE_BLOB) as x) WHERE [Name] = ''' + @PokemonName +'''' 
	PRINT (@sql)
	EXEC (@sql)

END
GO


/****** Object:  StoredProcedure [dbo].[maxFavourites]    Script Date: 14/11/2018 19:02:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[maxFavourites]
@trainerID INT
AS 
BEGIN
	IF (SELECT COUNT(Favourite) FROM TrainerPokemon WHERE 
	TrainerID=@trainerID) > 3
	RAISERROR (N'%*.*s>>',10,1,50,3,N'Cannot have more than 3!');
END
GO


/****** Object:  StoredProcedure [dbo].[maxRounds]    Script Date: 14/11/2018 19:02:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[maxRounds]
@BattleID INT
AS 
BEGIN
	IF (SELECT COUNT(RoundID) FROM Round WHERE 
	BattleID=@BattleID) <= 5
	RAISERROR (N'%*.*s>>',10,1,50,3,N'Game is over');
END
GO


/****** Object:  StoredProcedure [dbo].[removeFavourate]    Script Date: 14/11/2018 19:02:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [dbo].[removeFavourate] @TrainerID smallint, @PokemonId smallint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	UPDATE TrainerPokemon SET Favourite = 0 WHERE PokemonID = @PokemonID AND TrainerID = @TrainerID;    

END
GO



-- =============================================
--             TRIGGERS
-- =============================================


/****** Object:  Trigger [dbo].[trainerNameCheck]    Script Date: 14/11/2018 19:02:25 ******/
SET ANSI_NULLS ON
GO 
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER TRIGGER trainerNameCheck
 ON Trainer
FOR INSERT AS 
     DECLARE @valid bit 
	 DECLARE @name varchar(max)
	 
BEGIN  
	SET @name = (Select TName FROM inserted)		
	SET @valid = 0 

     IF @name IS NOT NULL   
        IF len(@name)>3 
			AND len(@name)<21  
			 AND PATINDEX('%[0-9a-zA-Z]%', @name) >0    
               SET @valid=1  
		ELSE
			PRINT 'Username is not valid!'
	ELSE
		PRINT 'Username is Null!';

END
GO

/****** Object:  Trigger [dbo].[battleIDCheck]    Script Date: 08/11/2018 14:53:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER TRIGGER battleIDCheck
ON Battle
FOR INSERT AS
DECLARE @TrainerID1 INT
DECLARE @TrainerID2 INT

BEGIN

SET @TrainerID1 = (Select TrainerID1 FROM inserted)
SET @TrainerID2 = (Select TrainerID2 FROM inserted)

	IF (@TrainerID1 = @TrainerID2)
		RAISERROR (N'%*.*s>>',10,1,50,3,N'Trainer IDs cannot be the same!'); 
END
GO

/****** Object:  Trigger [dbo].[trainerPasswordCheck]    Script Date: 08/11/2018 14:53:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER TRIGGER trainerPasswordCheck
 ON Trainer
FOR INSERT AS 
     DECLARE @valid bit 
	 DECLARE @password varchar(max)
	 
BEGIN  
	SET @password = (Select Password FROM inserted)		
	SET @valid = 0 

     IF @password IS NOT NULL   
        IF len(@password)>5
			AND len(@password)<16	  
			 AND PATINDEX('%[0-9a-zA-Z,.?!]%', @password) > 0 
               SET @valid=1  
		ELSE
			PRINT 'Password is not valid!'
	ELSE
		PRINT 'Password is Null!';

  
END

/****** Object:  Trigger [dbo].[trainerEmailCheck]    Script Date: 08/11/2018 14:53:23 ******/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER TRIGGER trainerEmailCheck
 ON Trainer
FOR INSERT AS 
     DECLARE @valid bit 
	 DECLARE @email varchar(max)
	 
BEGIN  
	SET @email = (Select Email FROM inserted)		
	SET @valid = 0 

     IF @email IS NOT NULL   
        IF @email like '[a-z,0-9,_,-]%@[a-z,0-9,_,-]%.[a-z][a-z]%'  
			 AND @email NOT like '%@%@%'  
             AND CHARINDEX('.@',@email) = 0  
             AND CHARINDEX('..',@email) = 0  
             AND CHARINDEX(',',@email) = 0  
             AND RIGHT(@email,1) between 'a' AND 'z'  
               SET @valid=1  
		ELSE
			PRINT 'Email is not valid!'
	ELSE
		PRINT 'Email is Null!';

END

/****** Object:  Trigger [dbo].[insertBulkImage]    Script Date: 08/11/2018 14:53:23 ******/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER TRIGGER insertBulkImage  
ON Pokemon  
FOR INSERT AS  
DECLARE @pokemonName NVARCHAR(200)
IF @@ROWCOUNT = 1  
BEGIN  
	SET @pokemonName = (SELECT Name FROM inserted)
	EXEC dbo.LoadPokemonImage @pokemonName   
END  
ELSE  
BEGIN  
	DECLARE  insert_Cursor CURSOR FOR
	SELECT Name FROM inserted AS Names

	OPEN insert_Cursor
	FETCH NEXT FROM insert_Cursor INTO @pokemonName

	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC dbo.LoadPokemonImage @pokemonName
		FETCH NEXT FROM insert_Cursor INTO @pokemonName
	END
	
	CLOSE insert_Cursor
	DEALLOCATE insert_Cursor
	 
END

GO


GO


-- =============================================
--						INDEXES
-- =============================================

/****** Object:  Index [Index_Pokemon_Attack]    Script Date: 16/11/2018 12:52:23 ******/
--DROP INDEX [Index_Pokemon_Attack] ON [dbo].[Pokemon]
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [Index_Pokemon_Attack]    Script Date: 16/11/2018 12:52:23 ******/
CREATE NONCLUSTERED INDEX [Index_Pokemon_Attack] ON [dbo].[Pokemon]
(
	[PokemonID] ASC,
	[Name] ASC,
	[Attack] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** Object:  Index [Index_Pokemon_Defence]    Script Date: 16/11/2018 12:52:23 ******/
--DROP INDEX [Index_Pokemon_Defence] ON [dbo].[Pokemon]
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [Index_Pokemon_Defence]    Script Date: 16/11/2018 12:52:23 ******/
CREATE NONCLUSTERED INDEX [Index_Pokemon_Defence] ON [dbo].[Pokemon]
(
	[PokemonID] ASC,
	[Name] ASC,
	[Defence] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** Object:  Index [Index_Pokemon_SpecialAttack]    Script Date: 16/11/2018 12:52:23 ******/
--DROP INDEX [Index_Pokemon_SpecialAttack] ON [dbo].[Pokemon]
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [Index_Pokemon_SpecialAttack]    Script Date: 16/11/2018 12:52:23 ******/
CREATE NONCLUSTERED INDEX [Index_Pokemon_SpecialAttack] ON [dbo].[Pokemon]
(
	[PokemonID] ASC,
	[Name] ASC,
	[SpecialAttack] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** Object:  Index [Index_Pokemon_SpecialDefence]    Script Date: 16/11/2018 12:52:23 ******/
--DROP INDEX [Index_Pokemon_SpecialDefence] ON [dbo].[Pokemon]
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [Index_Pokemon_SpecialDefence]    Script Date: 16/11/2018 12:52:23 ******/
CREATE NONCLUSTERED INDEX [Index_Pokemon_SpecialDefence] ON [dbo].[Pokemon]
(
	[PokemonID] ASC,
	[Name] ASC,
	[SpecialDefence] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** Object:  Index [Index_Pokemon_Speed]    Script Date: 16/11/2018 12:52:23 ******/
--DROP INDEX [Index_Pokemon_Speed] ON [dbo].[Pokemon]
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [Index_Pokemon_Speed]    Script Date: 16/11/2018 12:52:23 ******/
CREATE NONCLUSTERED INDEX [Index_Pokemon_Speed] ON [dbo].[Pokemon]
(
	[PokemonID] ASC,
	[Name] ASC,
	[Speed] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/*EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Pokemon"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 4
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_InsertPokemon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_InsertPokemon'
GO*/
