-- CreateEnum
CREATE TYPE "SCHEDULE_TIME_UNIT" AS ENUM ('DAILY', 'WEEKLY', 'MONTHLY', 'YEARLY');

-- CreateEnum
CREATE TYPE "SCHEDULE_TYPE" AS ENUM ('CYCLOCALLY', 'ONCE');

-- CreateEnum
CREATE TYPE "SCHEDULE_STATUS" AS ENUM ('ACTIVATED', 'STOPPED', 'TERMINATED');

-- CreateEnum
CREATE TYPE "SCHEDULE_HISTORY_STATUS" AS ENUM ('SUCCESSED', 'FAILED');

-- CreateEnum
CREATE TYPE "LOCATION_POINT_INCOME_RECORD_TYPE" AS ENUM ('SCHEDULE', 'MANUAL', 'REFUND');

-- CreateEnum
CREATE TYPE "LOCATION_POINT_TRANSACTION_TYPE" AS ENUM ('ORDER', 'RECOVERY');

-- CreateTable
CREATE TABLE "Discount" (
    "amount" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "campaignId" TEXT NOT NULL,
    "id" TEXT NOT NULL,
    "name" TEXT,
    "orderId" TEXT NOT NULL,
    "time" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Discount_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Campaign" (
    "id" TEXT NOT NULL,

    CONSTRAINT "Campaign_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Schedule" (
    "id" TEXT NOT NULL,
    "startedAt" TIMESTAMP(3),
    "endedAt" TIMESTAMP(3),
    "triggerTimeType" "SCHEDULE_TIME_UNIT",
    "triggerValue" INTEGER,
    "onceTriggerTime" TIMESTAMP(3),
    "type" "SCHEDULE_TYPE" NOT NULL,
    "status" "SCHEDULE_STATUS" NOT NULL DEFAULT 'ACTIVATED',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Schedule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ScheduleHistory" (
    "scheduleId" TEXT NOT NULL,
    "scheduleName" TEXT NOT NULL,
    "status" "SCHEDULE_HISTORY_STATUS" NOT NULL,
    "detail" JSONB NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ScheduleHistory_pkey" PRIMARY KEY ("scheduleId","status","createdAt")
);

-- CreateTable
CREATE TABLE "SystemSchedule" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SystemSchedule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Location" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Location_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LocationPointCampaign" (
    "id" TEXT NOT NULL,
    "locationId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "LocationPointCampaign_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LocationMember" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "locationId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "LocationMember_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LocationPoint" (
    "id" TEXT NOT NULL,
    "expiredAt" TIMESTAMP(3),
    "ownerId" TEXT NOT NULL,
    "fromRecordId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "LocationPoint_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LocationMemberGroup" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "ownerId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "LocationMemberGroup_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LocationPointSchedule" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "campaignId" TEXT NOT NULL,
    "durationDays" INTEGER,
    "expiredAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "LocationPointSchedule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LocationPointIncomeRecord" (
    "id" TEXT NOT NULL,
    "eachAmount" DOUBLE PRECISION NOT NULL,
    "name" TEXT NOT NULL,
    "campaignId" TEXT NOT NULL,
    "fromScheduleId" TEXT,
    "fromExpenditureRecordId" TEXT,
    "type" "LOCATION_POINT_INCOME_RECORD_TYPE" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "LocationPointIncomeRecord_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LocationPointExpenditureRecord" (
    "id" TEXT NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "pointId" TEXT NOT NULL,
    "pointTranscationId" TEXT NOT NULL,
    "discountId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "LocationPointExpenditureRecord_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LocationPointTranscation" (
    "id" TEXT NOT NULL,
    "orderId" TEXT,
    "type" "LOCATION_POINT_TRANSACTION_TYPE" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "LocationPointTranscation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_LocationMemberToLocationMemberGroup" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_LocationMemberGroupToLocationPointSchedule" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE INDEX "Discount_orderId_idx" ON "Discount"("orderId");

-- CreateIndex
CREATE INDEX "Schedule_type_idx" ON "Schedule"("type");

-- CreateIndex
CREATE INDEX "Schedule_status_idx" ON "Schedule"("status");

-- CreateIndex
CREATE INDEX "ScheduleHistory_status_idx" ON "ScheduleHistory"("status");

-- CreateIndex
CREATE INDEX "ScheduleHistory_scheduleId_idx" ON "ScheduleHistory"("scheduleId");

-- CreateIndex
CREATE INDEX "ScheduleHistory_createdAt_idx" ON "ScheduleHistory"("createdAt");

-- CreateIndex
CREATE INDEX "ScheduleHistory_scheduleName_idx" ON "ScheduleHistory"("scheduleName");

-- CreateIndex
CREATE UNIQUE INDEX "SystemSchedule_name_key" ON "SystemSchedule"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Location_name_key" ON "Location"("name");

-- CreateIndex
CREATE UNIQUE INDEX "LocationPointCampaign_locationId_key" ON "LocationPointCampaign"("locationId");

-- CreateIndex
CREATE INDEX "LocationMember_locationId_idx" ON "LocationMember"("locationId");

-- CreateIndex
CREATE INDEX "LocationMember_name_idx" ON "LocationMember"("name");

-- CreateIndex
CREATE UNIQUE INDEX "LocationMember_locationId_name_key" ON "LocationMember"("locationId", "name");

-- CreateIndex
CREATE INDEX "LocationPoint_fromRecordId_idx" ON "LocationPoint"("fromRecordId");

-- CreateIndex
CREATE INDEX "LocationPoint_ownerId_idx" ON "LocationPoint"("ownerId");

-- CreateIndex
CREATE INDEX "LocationPoint_expiredAt_idx" ON "LocationPoint"("expiredAt");

-- CreateIndex
CREATE INDEX "LocationPoint_createdAt_idx" ON "LocationPoint"("createdAt");

-- CreateIndex
CREATE INDEX "LocationMemberGroup_ownerId_idx" ON "LocationMemberGroup"("ownerId");

-- CreateIndex
CREATE UNIQUE INDEX "LocationMemberGroup_ownerId_name_key" ON "LocationMemberGroup"("ownerId", "name");

-- CreateIndex
CREATE INDEX "LocationPointSchedule_campaignId_idx" ON "LocationPointSchedule"("campaignId");

-- CreateIndex
CREATE UNIQUE INDEX "LocationPointSchedule_campaignId_name_key" ON "LocationPointSchedule"("campaignId", "name");

-- CreateIndex
CREATE INDEX "LocationPointIncomeRecord_campaignId_idx" ON "LocationPointIncomeRecord"("campaignId");

-- CreateIndex
CREATE INDEX "LocationPointIncomeRecord_fromScheduleId_idx" ON "LocationPointIncomeRecord"("fromScheduleId");

-- CreateIndex
CREATE INDEX "LocationPointIncomeRecord_fromExpenditureRecordId_idx" ON "LocationPointIncomeRecord"("fromExpenditureRecordId");

-- CreateIndex
CREATE INDEX "LocationPointIncomeRecord_name_idx" ON "LocationPointIncomeRecord"("name");

-- CreateIndex
CREATE INDEX "LocationPointIncomeRecord_type_idx" ON "LocationPointIncomeRecord"("type");

-- CreateIndex
CREATE UNIQUE INDEX "LocationPointExpenditureRecord_discountId_key" ON "LocationPointExpenditureRecord"("discountId");

-- CreateIndex
CREATE INDEX "LocationPointExpenditureRecord_pointId_idx" ON "LocationPointExpenditureRecord"("pointId");

-- CreateIndex
CREATE INDEX "LocationPointExpenditureRecord_pointTranscationId_idx" ON "LocationPointExpenditureRecord"("pointTranscationId");

-- CreateIndex
CREATE INDEX "LocationPointExpenditureRecord_discountId_idx" ON "LocationPointExpenditureRecord"("discountId");

-- CreateIndex
CREATE INDEX "LocationPointTranscation_orderId_idx" ON "LocationPointTranscation"("orderId");

-- CreateIndex
CREATE INDEX "LocationPointTranscation_type_idx" ON "LocationPointTranscation"("type");

-- CreateIndex
CREATE INDEX "LocationPointTranscation_createdAt_idx" ON "LocationPointTranscation"("createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "_LocationMemberToLocationMemberGroup_AB_unique" ON "_LocationMemberToLocationMemberGroup"("A", "B");

-- CreateIndex
CREATE INDEX "_LocationMemberToLocationMemberGroup_B_index" ON "_LocationMemberToLocationMemberGroup"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_LocationMemberGroupToLocationPointSchedule_AB_unique" ON "_LocationMemberGroupToLocationPointSchedule"("A", "B");

-- CreateIndex
CREATE INDEX "_LocationMemberGroupToLocationPointSchedule_B_index" ON "_LocationMemberGroupToLocationPointSchedule"("B");

-- AddForeignKey
ALTER TABLE "Discount" ADD CONSTRAINT "Discount_campaignId_fkey" FOREIGN KEY ("campaignId") REFERENCES "Campaign"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ScheduleHistory" ADD CONSTRAINT "ScheduleHistory_scheduleId_fkey" FOREIGN KEY ("scheduleId") REFERENCES "Schedule"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SystemSchedule" ADD CONSTRAINT "SystemSchedule_id_fkey" FOREIGN KEY ("id") REFERENCES "Schedule"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LocationPointCampaign" ADD CONSTRAINT "LocationPointCampaign_id_fkey" FOREIGN KEY ("id") REFERENCES "Campaign"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LocationPointCampaign" ADD CONSTRAINT "LocationPointCampaign_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "Location"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LocationMember" ADD CONSTRAINT "LocationMember_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "Location"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LocationPoint" ADD CONSTRAINT "LocationPoint_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "LocationMember"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LocationPoint" ADD CONSTRAINT "LocationPoint_fromRecordId_fkey" FOREIGN KEY ("fromRecordId") REFERENCES "LocationPointIncomeRecord"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LocationMemberGroup" ADD CONSTRAINT "LocationMemberGroup_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "Location"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LocationPointSchedule" ADD CONSTRAINT "LocationPointSchedule_id_fkey" FOREIGN KEY ("id") REFERENCES "Schedule"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LocationPointSchedule" ADD CONSTRAINT "LocationPointSchedule_campaignId_fkey" FOREIGN KEY ("campaignId") REFERENCES "LocationPointCampaign"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LocationPointIncomeRecord" ADD CONSTRAINT "LocationPointIncomeRecord_campaignId_fkey" FOREIGN KEY ("campaignId") REFERENCES "LocationPointCampaign"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LocationPointIncomeRecord" ADD CONSTRAINT "LocationPointIncomeRecord_fromScheduleId_fkey" FOREIGN KEY ("fromScheduleId") REFERENCES "LocationPointSchedule"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LocationPointIncomeRecord" ADD CONSTRAINT "LocationPointIncomeRecord_fromExpenditureRecordId_fkey" FOREIGN KEY ("fromExpenditureRecordId") REFERENCES "LocationPointExpenditureRecord"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LocationPointExpenditureRecord" ADD CONSTRAINT "LocationPointExpenditureRecord_pointId_fkey" FOREIGN KEY ("pointId") REFERENCES "LocationPoint"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LocationPointExpenditureRecord" ADD CONSTRAINT "LocationPointExpenditureRecord_pointTranscationId_fkey" FOREIGN KEY ("pointTranscationId") REFERENCES "LocationPointTranscation"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LocationPointExpenditureRecord" ADD CONSTRAINT "LocationPointExpenditureRecord_discountId_fkey" FOREIGN KEY ("discountId") REFERENCES "Discount"("id") ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_LocationMemberToLocationMemberGroup" ADD CONSTRAINT "_LocationMemberToLocationMemberGroup_A_fkey" FOREIGN KEY ("A") REFERENCES "LocationMember"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_LocationMemberToLocationMemberGroup" ADD CONSTRAINT "_LocationMemberToLocationMemberGroup_B_fkey" FOREIGN KEY ("B") REFERENCES "LocationMemberGroup"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_LocationMemberGroupToLocationPointSchedule" ADD CONSTRAINT "_LocationMemberGroupToLocationPointSchedule_A_fkey" FOREIGN KEY ("A") REFERENCES "LocationMemberGroup"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_LocationMemberGroupToLocationPointSchedule" ADD CONSTRAINT "_LocationMemberGroupToLocationPointSchedule_B_fkey" FOREIGN KEY ("B") REFERENCES "LocationPointSchedule"("id") ON DELETE CASCADE ON UPDATE CASCADE;
