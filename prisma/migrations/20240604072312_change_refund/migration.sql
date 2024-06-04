/*
  Warnings:

  - You are about to drop the column `fromExpenditureRecordId` on the `LocationPointIncomeRecord` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "LocationPointIncomeRecord" DROP CONSTRAINT "LocationPointIncomeRecord_fromExpenditureRecordId_fkey";

-- DropIndex
DROP INDEX "LocationPointIncomeRecord_fromExpenditureRecordId_idx";

-- AlterTable
ALTER TABLE "LocationPointIncomeRecord" DROP COLUMN "fromExpenditureRecordId",
ADD COLUMN     "fromTranscationIdWithRefund" TEXT;

-- CreateIndex
CREATE INDEX "LocationPointIncomeRecord_fromTranscationIdWithRefund_idx" ON "LocationPointIncomeRecord"("fromTranscationIdWithRefund");

-- AddForeignKey
ALTER TABLE "LocationPointIncomeRecord" ADD CONSTRAINT "LocationPointIncomeRecord_fromTranscationIdWithRefund_fkey" FOREIGN KEY ("fromTranscationIdWithRefund") REFERENCES "LocationPointTranscation"("id") ON DELETE NO ACTION ON UPDATE CASCADE;
