From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 2/3] iommu/amd: Add support for higher 64-bit IOMMU Control
	Register
Date: Wed, 27 Jun 2018 10:31:21 -0500
Message-ID: <1530113482-85632-3-git-send-email-suravee.suthikulpanit@amd.com>
References: <1530113482-85632-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1530113482-85632-1-git-send-email-suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Currently, the driver only supports lower 32-bit of IOMMU Control register.
However, newer AMD IOMMU specification has extended this register
to 64-bit. Therefore, replace the accessing API with the 64-bit version.

Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
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
