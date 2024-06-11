/*
  Warnings:

  - The values [SUCCESSED] on the enum `SCHEDULE_HISTORY_STATUS` will be removed. If these variants are still used in the database, this will fail.
  - The values [CYCLOCALLY] on the enum `SCHEDULE_TYPE` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `triggerValue` on the `Schedule` table. All the data in the column will be lost.

*/
-- CreateEnum
CREATE TYPE "LOCATION_BUDGET_ACTION" AS ENUM ('IMPORT', 'RETURN', 'USE', 'EXPORT', 'INVALID');

-- AlterEnum
BEGIN;
CREATE TYPE "SCHEDULE_HISTORY_STATUS_new" AS ENUM ('SUCCESSES', 'FAILED');
ALTER TABLE "ScheduleHistory" ALTER COLUMN "status" TYPE "SCHEDULE_HISTORY_STATUS_new" USING ("status"::text::"SCHEDULE_HISTORY_STATUS_new");
ALTER TYPE "SCHEDULE_HISTORY_STATUS" RENAME TO "SCHEDULE_HISTORY_STATUS_old";
ALTER TYPE "SCHEDULE_HISTORY_STATUS_new" RENAME TO "SCHEDULE_HISTORY_STATUS";
DROP TYPE "SCHEDULE_HISTORY_STATUS_old";
COMMIT;

-- AlterEnum
BEGIN;
CREATE TYPE "SCHEDULE_TYPE_new" AS ENUM ('CYCLICALLY', 'ONCE');
ALTER TABLE "Schedule" ALTER COLUMN "type" TYPE "SCHEDULE_TYPE_new" USING ("type"::text::"SCHEDULE_TYPE_new");
ALTER TYPE "SCHEDULE_TYPE" RENAME TO "SCHEDULE_TYPE_old";
ALTER TYPE "SCHEDULE_TYPE_new" RENAME TO "SCHEDULE_TYPE";
DROP TYPE "SCHEDULE_TYPE_old";
COMMIT;

-- AlterTable
ALTER TABLE "LocationMember" ADD COLUMN     "isDeleted" BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE "Schedule" DROP COLUMN "triggerValue",
ADD COLUMN     "triggerValues" INTEGER[];

-- CreateTable
CREATE TABLE "LocationBudget" (
    "id" TEXT NOT NULL,
    "action" "LOCATION_BUDGET_ACTION" NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "remark" TEXT,
    "locationId" TEXT NOT NULL,
    "creditedAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "LocationBudget_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "LocationBudget_locationId_idx" ON "LocationBudget"("locationId");

-- CreateIndex
CREATE INDEX "LocationBudget_action_idx" ON "LocationBudget"("action");

-- CreateIndex
CREATE INDEX "LocationMember_isDeleted_idx" ON "LocationMember"("isDeleted");

-- AddForeignKey
ALTER TABLE "LocationBudget" ADD CONSTRAINT "LocationBudget_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "Location"("id") ON DELETE CASCADE ON UPDATE CASCADE;
