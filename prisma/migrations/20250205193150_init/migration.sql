-- CreateEnum
CREATE TYPE "DisciplinesProps" AS ENUM ('History', 'Geography', 'Sociology', 'Philosophy', 'Biology', 'Chemistry', 'Physics', 'Portuguese', 'Literature', 'English');

-- CreateEnum
CREATE TYPE "Penalty" AS ENUM ('VERBAL_WARNING', 'WRITTEN_WARNING', 'EXTRACURRICULAR_BAN', 'TEMPORARY_SUSPENSION', 'EDUCATIONAL_ASSIGNMENT', 'PARENTAL_MEETING', 'CLASS_TRANSFER', 'SCHOOL_SERVICE', 'PERMANENT_RECORD_ENTRY', 'EXPULSION', 'OTHER');

-- CreateEnum
CREATE TYPE "SchoolSeries" AS ENUM ('ElementarySchool', 'MiddleSchool', 'Highschool');

-- CreateEnum
CREATE TYPE "SchoolYearsProps" AS ENUM ('first', 'second', 'third', 'fourth', 'fifith', 'sixth', 'seventh', 'eight', 'night', 'tenght');

-- CreateEnum
CREATE TYPE "UserTypes" AS ENUM ('Student', 'Teacher', 'Other');

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "cpf" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" "UserTypes" NOT NULL DEFAULT 'Student',
    "studentSituation" BOOLEAN NOT NULL,
    "skipClasses" INTEGER NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Occurrence" (
    "id" SERIAL NOT NULL,
    "studentId" INTEGER NOT NULL,
    "studentName" TEXT NOT NULL,
    "situation" TEXT NOT NULL,
    "penalty" "Penalty" NOT NULL,
    "other" TEXT NOT NULL DEFAULT '',

    CONSTRAINT "Occurrence_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Class" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "time" TIMESTAMP(3) NOT NULL,
    "teachersId" INTEGER NOT NULL,
    "discipline" "DisciplinesProps" NOT NULL,

    CONSTRAINT "Class_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Disciplines" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "teachersId" INTEGER NOT NULL,

    CONSTRAINT "Disciplines_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Bulletin" (
    "id" SERIAL NOT NULL,
    "disciplines" "DisciplinesProps" NOT NULL,
    "studentId" INTEGER NOT NULL,

    CONSTRAINT "Bulletin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TestsScores" (
    "id" SERIAL NOT NULL,
    "testScore" DOUBLE PRECISION NOT NULL,
    "teacherId" INTEGER NOT NULL,
    "bulletinId" INTEGER NOT NULL,

    CONSTRAINT "TestsScores_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SchoolYears" (
    "id" SERIAL NOT NULL,
    "schollSeries" "SchoolSeries" NOT NULL,
    "schoolYears" "SchoolYearsProps" NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "SchoolYears_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Class_teachersId_key" ON "Class"("teachersId");

-- CreateIndex
CREATE UNIQUE INDEX "Disciplines_teachersId_key" ON "Disciplines"("teachersId");

-- CreateIndex
CREATE UNIQUE INDEX "Bulletin_studentId_key" ON "Bulletin"("studentId");

-- AddForeignKey
ALTER TABLE "Occurrence" ADD CONSTRAINT "Occurrence_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Class" ADD CONSTRAINT "Class_teachersId_fkey" FOREIGN KEY ("teachersId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Disciplines" ADD CONSTRAINT "Disciplines_teachersId_fkey" FOREIGN KEY ("teachersId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Bulletin" ADD CONSTRAINT "Bulletin_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TestsScores" ADD CONSTRAINT "TestsScores_bulletinId_fkey" FOREIGN KEY ("bulletinId") REFERENCES "Bulletin"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TestsScores" ADD CONSTRAINT "TestsScores_teacherId_fkey" FOREIGN KEY ("teacherId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SchoolYears" ADD CONSTRAINT "SchoolYears_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
