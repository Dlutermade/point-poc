-- CreateTable
CREATE TABLE "_LocationMemberToLocationPointSchedule" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_LocationMemberToLocationPointSchedule_AB_unique" ON "_LocationMemberToLocationPointSchedule"("A", "B");

-- CreateIndex
CREATE INDEX "_LocationMemberToLocationPointSchedule_B_index" ON "_LocationMemberToLocationPointSchedule"("B");

-- AddForeignKey
ALTER TABLE "_LocationMemberToLocationPointSchedule" ADD CONSTRAINT "_LocationMemberToLocationPointSchedule_A_fkey" FOREIGN KEY ("A") REFERENCES "LocationMember"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_LocationMemberToLocationPointSchedule" ADD CONSTRAINT "_LocationMemberToLocationPointSchedule_B_fkey" FOREIGN KEY ("B") REFERENCES "LocationPointSchedule"("id") ON DELETE CASCADE ON UPDATE CASCADE;
