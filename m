From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 03/11] iommu/arm-smmu: Support buggy implementation where all
	config accesses are secure
Date: Thu, 16 Jan 2014 13:44:15 +0100
Message-ID: <1389876263-25759-4-git-send-email-andreas.herrmann@calxeda.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1389876263-25759-1-git-send-email-andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
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
Cc: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

In such a case we have to use secure aliases of some non-secure
registers.

This handling is switched on by DT property
"calxeda,smmu-secure-config-access" for an SMMU node.

Cc: Andreas Herrmann <herrmann.der.user-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c |   31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index bc81dd0..823699e 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -50,6 +50,7 @@
 
 /* Driver options */
 #define ARM_SMMU_OPT_ISOLATE_DEVICES		(1 << 0)
+#define ARM_SMMU_OPT_SECURE_CONFIG_ACCESS	(1 << 1)
 
 /* Maximum number of stream IDs assigned to a single device */
 #define MAX_MASTER_STREAMIDS		8
@@ -64,6 +65,15 @@
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
@@ -410,6 +420,7 @@ struct arm_smmu_option_prop {
 
 static struct arm_smmu_option_prop arm_smmu_options [] = {
 	{ ARM_SMMU_OPT_ISOLATE_DEVICES, "arm,smmu-isolate-devices" },
+	{ ARM_SMMU_OPT_SECURE_CONFIG_ACCESS, "calxeda,smmu-secure-config-access" },
 	{ 0, NULL},
 };
 
@@ -639,16 +650,16 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
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
@@ -1586,9 +1597,9 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	int i = 0;
 	u32 reg;
 
-	/* Clear Global FSR */
-	reg = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSR);
-	writel(reg, gr0_base + ARM_SMMU_GR0_sGFSR);
+	/* clear global FSR */
+	reg = readl_relaxed(ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sGFSR);
+	writel(reg, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sGFSR);
 
 	/* Mark all SMRn as invalid and all S2CRn as bypass */
 	for (i = 0; i < smmu->num_mapping_groups; ++i) {
@@ -1608,7 +1619,7 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
 	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
 
-	reg = readl_relaxed(gr0_base + ARM_SMMU_GR0_sCR0);
+	reg = readl_relaxed(ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
 
 	/* Enable fault reporting */
 	reg |= (sCR0_GFRE | sCR0_GFIE | sCR0_GCFGFRE | sCR0_GCFGFIE);
@@ -1627,7 +1638,7 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 
 	/* Push the button */
 	arm_smmu_tlb_sync(smmu);
-	writel_relaxed(reg, gr0_base + ARM_SMMU_GR0_sCR0);
+	writel(reg, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
 }
 
 static int arm_smmu_id_size_to_bits(int size)
@@ -1961,7 +1972,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 		free_irq(smmu->irqs[i], smmu);
 
 	/* Turn the thing off */
-	writel_relaxed(sCR0_CLIENTPD, ARM_SMMU_GR0(smmu) + ARM_SMMU_GR0_sCR0);
+	writel(sCR0_CLIENTPD,ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
 	return 0;
 }
 
-- 
1.7.9.5
