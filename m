From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 4/7] iommu/arm-smmu: Support buggy implementations where all
	config accesses are secure
Date: Thu, 10 Oct 2013 00:38:03 +0200
Message-ID: <1381358286-27065-5-git-send-email-andreas.herrmann@calxeda.com>
References: <1381358286-27065-1-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1381358286-27065-1-git-send-email-andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

In such a case we have to use secure aliases of some non-secure
registers.

This handling is switched on by DT property
"arm,smmu-secure-config-access" for an SMMU node.

Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c |   30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index f877d02..91316a8 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -51,6 +51,7 @@
 /* Driver options */
 #define ARM_SMMU_OPT_ISOLATE_DEVICES		(1 << 0)
 #define ARM_SMMU_OPT_MASK_STREAM_IDS		(1 << 1)
+#define ARM_SMMU_OPT_SECURE_CONFIG_ACCESS	(1 << 2)
 
 /* Maximum number of stream IDs assigned to a single device */
 #define MAX_MASTER_STREAMIDS		8
@@ -65,6 +66,15 @@
 #define ARM_SMMU_GR0(smmu)		((smmu)->base)
 #define ARM_SMMU_GR1(smmu)		((smmu)->base + (smmu)->pagesize)
 
+/*
+ * SMMU global address space with conditional offset to access secure aliases of
+ * non-secure registers (e.g. nsCR0: 0x400, nsGFSR: 0x448, nsGFSYNR0: 0x450)
+ */
+#define ARM_SMMU_GR0_NS(smmu)						\
+	((smmu)->base +							\
+		((smmu->options & ARM_SMMU_OPT_SECURE_CONFIG_ACCESS)	\
+			? 0x400 : 0))
+
 /* Page table bits */
 #define ARM_SMMU_PTE_PAGE		(((pteval_t)3) << 0)
 #define ARM_SMMU_PTE_CONT		(((pteval_t)1) << 52)
@@ -414,6 +424,7 @@ struct arm_smmu_option_prop {
 static struct arm_smmu_option_prop arm_smmu_options [] = {
 	{ ARM_SMMU_OPT_ISOLATE_DEVICES, "arm,smmu-isolate-devices" },
 	{ ARM_SMMU_OPT_MASK_STREAM_IDS, "arm,smmu-mask-stream-ids" },
+	{ ARM_SMMU_OPT_SECURE_CONFIG_ACCESS, "arm,smmu-secure-config-access" },
 	{ 0, NULL},
 };
 
@@ -663,16 +674,16 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
 {
 	u32 gfsr, gfsynr0, gfsynr1, gfsynr2;
 	struct arm_smmu_device *smmu = dev;
-	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
+	void __iomem *gr0_base = ARM_SMMU_GR0_NS(smmu);
 
 	gfsr = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSR);
-	if (!gfsr)
-		return IRQ_NONE;
-
 	gfsynr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR0);
 	gfsynr1 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR1);
 	gfsynr2 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR2);
 
+	if (!gfsr)
+		return IRQ_NONE;
+
 	dev_err_ratelimited(smmu->dev,
 		"Unexpected global fault, this could be serious\n");
 	dev_err_ratelimited(smmu->dev,
@@ -1622,8 +1633,8 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	u32 reg;
 
 	/* clear global FSR */
-	reg = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSR);
-	writel(reg, gr0_base + ARM_SMMU_GR0_sGFSR);
+	reg = readl_relaxed(ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sGFSR);
+	writel(reg, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sGFSR);
 
 	/* Mark all SMRn as invalid and all S2CRn as bypass */
 	for (i = 0; i < smmu->num_mapping_groups; ++i) {
@@ -1643,7 +1654,7 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
 	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
 
-	reg = readl_relaxed(gr0_base + ARM_SMMU_GR0_sCR0);
+	reg = readl_relaxed(ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
 
 	/* Enable fault reporting */
 	reg |= (sCR0_GFRE | sCR0_GFIE | sCR0_GCFGFRE | sCR0_GCFGFIE);
@@ -1662,7 +1673,7 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 
 	/* Push the button */
 	arm_smmu_tlb_sync(smmu);
-	writel(reg, gr0_base + ARM_SMMU_GR0_sCR0);
+	writel(reg, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
 }
 
 static int arm_smmu_id_size_to_bits(int size)
@@ -2000,7 +2011,8 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 		free_irq(smmu->irqs[i], smmu);
 
 	/* Turn the thing off */
-	writel(sCR0_CLIENTPD, ARM_SMMU_GR0(smmu) + ARM_SMMU_GR0_sCR0);
+	writel(sCR0_CLIENTPD,
+		ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
 	return 0;
 }
 
-- 
1.7.9.5
