/*
  Warnings:

  - Added the required column `appliedType` to the `LocationPointSchedule` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "LOCATION_POINT_APPLIED_TYPE" AS ENUM ('GROUP', 'MEMBER');

-- AlterTable
ALTER TABLE "LocationPointSchedule" ADD COLUMN     "appliedType" "LOCATION_POINT_APPLIED_TYPE" NOT NULL;
