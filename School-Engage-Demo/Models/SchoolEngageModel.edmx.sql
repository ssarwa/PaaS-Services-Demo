
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 07/10/2020 15:17:45
-- Generated from EDMX file: C:\code\school-engage\School-Engage-Demo\Models\SchoolEngageModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [schooleng-db];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_dbo_Enrollment_dbo_Course_CourseID]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Enrollments] DROP CONSTRAINT [FK_dbo_Enrollment_dbo_Course_CourseID];
GO
IF OBJECT_ID(N'[dbo].[FK_dbo_Enrollment_dbo_Student_StudentID]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Enrollments] DROP CONSTRAINT [FK_dbo_Enrollment_dbo_Student_StudentID];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Courses]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Courses];
GO
IF OBJECT_ID(N'[dbo].[Enrollments]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Enrollments];
GO
IF OBJECT_ID(N'[dbo].[Students]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Students];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Courses'
CREATE TABLE [dbo].[Courses] (
    [CourseID] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(50)  NULL,
    [Credits] int  NULL
);
GO

-- Creating table 'Enrollments'
CREATE TABLE [dbo].[Enrollments] (
    [EnrollmentID] int IDENTITY(1,1) NOT NULL,
    [Grade] decimal(3,2)  NULL,
    [CourseID] int  NOT NULL,
    [StudentID] int  NOT NULL
);
GO

-- Creating table 'Students'
CREATE TABLE [dbo].[Students] (
    [StudentID] int IDENTITY(1,1) NOT NULL,
    [LastName] nvarchar(50)  NULL,
    [FirstName] nvarchar(50)  NULL,
    [EnrollmentDate] datetime  NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [CourseID] in table 'Courses'
ALTER TABLE [dbo].[Courses]
ADD CONSTRAINT [PK_Courses]
    PRIMARY KEY CLUSTERED ([CourseID] ASC);
GO

-- Creating primary key on [EnrollmentID] in table 'Enrollments'
ALTER TABLE [dbo].[Enrollments]
ADD CONSTRAINT [PK_Enrollments]
    PRIMARY KEY CLUSTERED ([EnrollmentID] ASC);
GO

-- Creating primary key on [StudentID] in table 'Students'
ALTER TABLE [dbo].[Students]
ADD CONSTRAINT [PK_Students]
    PRIMARY KEY CLUSTERED ([StudentID] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [CourseID] in table 'Enrollments'
ALTER TABLE [dbo].[Enrollments]
ADD CONSTRAINT [FK_dbo_Enrollment_dbo_Course_CourseID]
    FOREIGN KEY ([CourseID])
    REFERENCES [dbo].[Courses]
        ([CourseID])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_dbo_Enrollment_dbo_Course_CourseID'
CREATE INDEX [IX_FK_dbo_Enrollment_dbo_Course_CourseID]
ON [dbo].[Enrollments]
    ([CourseID]);
GO

-- Creating foreign key on [StudentID] in table 'Enrollments'
ALTER TABLE [dbo].[Enrollments]
ADD CONSTRAINT [FK_dbo_Enrollment_dbo_Student_StudentID]
    FOREIGN KEY ([StudentID])
    REFERENCES [dbo].[Students]
        ([StudentID])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_dbo_Enrollment_dbo_Student_StudentID'
CREATE INDEX [IX_FK_dbo_Enrollment_dbo_Student_StudentID]
ON [dbo].[Enrollments]
    ([StudentID]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------