From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH] iommu/amd: Assign default IOMMU when there is only one IOMMU
Date: Fri, 11 Dec 2015 16:54:38 -0600
Message-ID: <1449874478-31770-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
List-Id: iommu@lists.linux-foundation.org

Current driver makes assumption that device with devid zero is always
included in the range of devices to be managed by IOMMU. However,
certain FW does not include devid zero in IVRS table.
This has caused IOMMU perf driver to fail to initialize.

This patch implements a workaround for this case by always assign
devid zero to be handled by the first IOMMU.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 drivers/iommu/amd_iommu_init.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 013bdff..3bbad5c 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -656,6 +656,16 @@ static void __init set_iommu_for_device(struct amd_iommu *iommu, u16 devid)
 	amd_iommu_rlookup_table[devid] = iommu;
 }
 
+static struct amd_iommu *get_iommu_for_device(u16 devid)
+{
+	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
+
+	/* Workaround: Always assign devid zero to the first IOMMU */
+	if (!iommu && !devid && amd_iommus_present)
+		iommu = amd_iommus[0];
+	return iommu;
+}
+
 /*
  * This function takes the device specific flags read from the ACPI
  * table and sets up the device table entry with that information
@@ -751,7 +761,7 @@ static int __init add_early_maps(void)
  */
 static void __init set_device_exclusion_range(u16 devid, struct ivmd_header *m)
 {
-	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
+	struct amd_iommu *iommu = get_iommu_for_device(devid);
 
 	if (!(m->flags & IVMD_FLAG_EXCL_RANGE))
 		return;
@@ -2255,7 +2265,7 @@ u8 amd_iommu_pc_get_max_banks(u16 devid)
 	u8 ret = 0;
 
 	/* locate the iommu governing the devid */
-	iommu = amd_iommu_rlookup_table[devid];
+	iommu = get_iommu_for_device(devid);
 	if (iommu)
 		ret = iommu->max_banks;
 
@@ -2275,7 +2285,7 @@ u8 amd_iommu_pc_get_max_counters(u16 devid)
 	u8 ret = 0;
 
 	/* locate the iommu governing the devid */
-	iommu = amd_iommu_rlookup_table[devid];
+	iommu = get_iommu_for_device(devid);
 	if (iommu)
 		ret = iommu->max_counters;
 
@@ -2295,7 +2305,7 @@ int amd_iommu_pc_get_set_reg_val(u16 devid, u8 bank, u8 cntr, u8 fxn,
 		return -ENODEV;
 
 	/* Locate the iommu associated with the device ID */
-	iommu = amd_iommu_rlookup_table[devid];
+	iommu = get_iommu_for_device(devid);
 
 	/* Check for valid iommu and pc register indexing */
 	if (WARN_ON((iommu == NULL) || (fxn > 0x28) || (fxn & 7)))
-- 
1.9.1
