From: Jay Cornwall <jay@jcornwall.me>
Subject: [PATCH] iommu/amd: Apply workaround for ATS write permission check
Date: Wed, 10 Feb 2016 15:48:01 -0600
Message-ID: <1455140881-17041-1-git-send-email-jay@jcornwall.me>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Joerg Roedel <jroedel@suse.de>, Jay Cornwall <jay@jcornwall.me>, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The AMD Family 15h Models 30h-3Fh (Kaveri) BIOS and Kernel Developer's
Guide omitted part of the BIOS IOMMU L2 register setup specification.
Without this setup the IOMMU L2 does not fully respect write permissions
when handling an ATS translation request.

The IOMMU L2 will set PTE dirty bit when handling an ATS translation with
write permission request, even when PTE RW bit is clear. This may occur by
direct translation (which would cause a PPR) or by prefetch request from
the ATC.

This is observed in practice when the IOMMU L2 modifies a PTE which maps a
pagecache page. The ext4 filesystem driver BUGs when asked to writeback
these (non-modified) pages.

Enable ATS write permission check in the Kaveri IOMMU L2 if BIOS has not.

Signed-off-by: Jay Cornwall <jay@jcornwall.me>
Cc: <stable@vger.kernel.org> # v3.19+
---
 drivers/iommu/amd_iommu_init.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 013bdff..0c4257e 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1016,6 +1016,34 @@ static void amd_iommu_erratum_746_workaround(struct amd_iommu *iommu)
 }
 
 /*
+ * Family15h Model 30h-3fh (IOMMU Mishandles ATS Write Permission)
+ * Workaround:
+ *     BIOS should enable ATS write permission check by setting
+ *     L2_DEBUG_3[AtsIgnoreIWDis](D0F2xF4_x47[0]) = 1b
+ */
+static void amd_iommu_ats_write_check_workaround(struct amd_iommu *iommu)
+{
+	u32 value;
+
+	if ((boot_cpu_data.x86 != 0x15) ||
+	    (boot_cpu_data.x86_model < 0x30) ||
+	    (boot_cpu_data.x86_model > 0x3f))
+		return;
+
+	/* Test L2_DEBUG_3[AtsIgnoreIWDis] == 1 */
+	value = iommu_read_l2(iommu, 0x47);
+
+	if (value & BIT(0))
+		return;
+
+	/* Set L2_DEBUG_3[AtsIgnoreIWDis] = 1 */
+	iommu_write_l2(iommu, 0x47, value | BIT(0));
+
+	pr_info("AMD-Vi: Applying ATS write check workaround for IOMMU at %s\n",
+		dev_name(&iommu->dev->dev));
+}
+
+/*
  * This function clues the initialization function for one IOMMU
  * together and also allocates the command buffer and programs the
  * hardware. It does NOT enable the IOMMU. This is done afterwards.
@@ -1284,6 +1312,7 @@ static int iommu_init_pci(struct amd_iommu *iommu)
 	}
 
 	amd_iommu_erratum_746_workaround(iommu);
+	amd_iommu_ats_write_check_workaround(iommu);
 
 	iommu->iommu_dev = iommu_device_create(&iommu->dev->dev, iommu,
 					       amd_iommu_groups, "ivhd%d",
-- 
1.9.1
