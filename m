From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 2/3] iommu/amd: Add support for higher 64-bit IOMMU Control Register
Date: Fri, 22 Jun 2018 12:02:06 -0500
Message-ID: <1529686927-7665-3-git-send-email-suravee.suthikulpanit@amd.com>
References: <1529686927-7665-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1529686927-7665-1-git-send-email-suravee.suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: joro@8bytes.org, jroedel@suse.de, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
List-Id: iommu@lists.linux-foundation.org

Currently, the driver only supports lower 32-bit of IOMMU Control register.
However, newer AMD IOMMU specification has extended this register
to 64-bit. Therefore, replace the accessing API with the 64-bit version.

Cc: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd_iommu_init.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 904c575..7d494f2 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -280,9 +280,9 @@ static void clear_translation_pre_enabled(struct amd_iommu *iommu)
 
 static void init_translation_status(struct amd_iommu *iommu)
 {
-	u32 ctrl;
+	u64 ctrl;
 
-	ctrl = readl(iommu->mmio_base + MMIO_CONTROL_OFFSET);
+	ctrl = readq(iommu->mmio_base + MMIO_CONTROL_OFFSET);
 	if (ctrl & (1<<CONTROL_IOMMU_EN))
 		iommu->flags |= AMD_IOMMU_FLAG_TRANS_PRE_ENABLED;
 }
@@ -386,30 +386,30 @@ static void iommu_set_device_table(struct amd_iommu *iommu)
 /* Generic functions to enable/disable certain features of the IOMMU. */
 static void iommu_feature_enable(struct amd_iommu *iommu, u8 bit)
 {
-	u32 ctrl;
+	u64 ctrl;
 
-	ctrl = readl(iommu->mmio_base + MMIO_CONTROL_OFFSET);
-	ctrl |= (1 << bit);
-	writel(ctrl, iommu->mmio_base + MMIO_CONTROL_OFFSET);
+	ctrl = readq(iommu->mmio_base +  MMIO_CONTROL_OFFSET);
+	ctrl |= (1ULL << bit);
+	writeq(ctrl, iommu->mmio_base +  MMIO_CONTROL_OFFSET);
 }
 
 static void iommu_feature_disable(struct amd_iommu *iommu, u8 bit)
 {
-	u32 ctrl;
+	u64 ctrl;
 
-	ctrl = readl(iommu->mmio_base + MMIO_CONTROL_OFFSET);
-	ctrl &= ~(1 << bit);
-	writel(ctrl, iommu->mmio_base + MMIO_CONTROL_OFFSET);
+	ctrl = readq(iommu->mmio_base + MMIO_CONTROL_OFFSET);
+	ctrl &= ~(1ULL << bit);
+	writeq(ctrl, iommu->mmio_base + MMIO_CONTROL_OFFSET);
 }
 
 static void iommu_set_inv_tlb_timeout(struct amd_iommu *iommu, int timeout)
 {
-	u32 ctrl;
+	u64 ctrl;
 
-	ctrl = readl(iommu->mmio_base + MMIO_CONTROL_OFFSET);
+	ctrl = readq(iommu->mmio_base + MMIO_CONTROL_OFFSET);
 	ctrl &= ~CTRL_INV_TO_MASK;
 	ctrl |= (timeout << CONTROL_INV_TIMEOUT) & CTRL_INV_TO_MASK;
-	writel(ctrl, iommu->mmio_base + MMIO_CONTROL_OFFSET);
+	writeq(ctrl, iommu->mmio_base + MMIO_CONTROL_OFFSET);
 }
 
 /* Function to enable the hardware */
-- 
2.7.4
