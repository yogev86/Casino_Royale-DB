USE [master]
GO

/****** Object:  Database [Casino_Royale]    Script Date: 19/04/08 08:32:53 AM ******/

/* Create databases for casino data */



DROP DATABASE IF EXISTS [Casino_Royale]
GO

declare @Path varchar(100)
set @Path = 'C:\Casino_Royale\Data'
EXEC master.dbo.xp_create_subdir @Path

set @Path = 'C:\Casino_Royale\Backup'
EXEC master.dbo.xp_create_subdir @Path

set @Path = 'C:\Casino_Royale\Log'
EXEC master.dbo.xp_create_subdir @Path


CREATE DATABASE [Casino_Royale]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Casino_Royale', FILENAME = N'C:\Casino_Royale\Data\Casino_Royale.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
 FILEGROUP [Fg_2019-04-04] 
( NAME = N'Data_File_2019-04-04', FILENAME = N'C:\Casino_Royale\Data\Data_File_2019-04-04.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
 FILEGROUP [Fg_2019-04-05] 
( NAME = N'Data_File_2019-04-05', FILENAME = N'C:\Casino_Royale\Data\Data_File_2019-04-05.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Casino_Royale_log', FILENAME = N'C:\Casino_Royale\Data\Casino_Royale_log.ldf' , SIZE = 204800KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

ALTER DATABASE [Casino_Royale] SET COMPATIBILITY_LEVEL = 140
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Casino_Royale].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [Casino_Royale] SET ANSI_NULL_DEFAULT ON 
GO

ALTER DATABASE [Casino_Royale] SET ANSI_NULLS ON 
GO

ALTER DATABASE [Casino_Royale] SET ANSI_PADDING ON 
GO

ALTER DATABASE [Casino_Royale] SET ANSI_WARNINGS ON 
GO

ALTER DATABASE [Casino_Royale] SET ARITHABORT ON 
GO

ALTER DATABASE [Casino_Royale] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [Casino_Royale] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [Casino_Royale] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [Casino_Royale] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [Casino_Royale] SET CURSOR_DEFAULT  LOCAL 
GO

ALTER DATABASE [Casino_Royale] SET CONCAT_NULL_YIELDS_NULL ON 
GO

ALTER DATABASE [Casino_Royale] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [Casino_Royale] SET QUOTED_IDENTIFIER ON 
GO

ALTER DATABASE [Casino_Royale] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [Casino_Royale] SET  DISABLE_BROKER 
GO

ALTER DATABASE [Casino_Royale] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [Casino_Royale] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [Casino_Royale] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [Casino_Royale] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [Casino_Royale] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [Casino_Royale] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [Casino_Royale] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [Casino_Royale] SET RECOVERY FULL 
GO

ALTER DATABASE [Casino_Royale] SET  MULTI_USER 
GO

ALTER DATABASE [Casino_Royale] SET PAGE_VERIFY NONE  
GO

ALTER DATABASE [Casino_Royale] SET DB_CHAINING OFF 
GO

ALTER DATABASE [Casino_Royale] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [Casino_Royale] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO

ALTER DATABASE [Casino_Royale] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [Casino_Royale] SET QUERY_STORE = OFF
GO

ALTER DATABASE [Casino_Royale] SET  READ_WRITE 
GO



--=======================================================

USE Casino_Royale
GO 

sp_CONFIGURE 'show advanced', 1
GO
RECONFIGURE
GO
sp_CONFIGURE 'Database Mail XPs', 1
GO
RECONFIGURE
GO