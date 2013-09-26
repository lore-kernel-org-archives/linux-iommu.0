From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 6/9] iommu/arm-smmu: Support buggy implemenations where all
	config accesses are secure
Date: Fri, 27 Sep 2013 00:36:18 +0200
Message-ID: <1380234982-1677-7-git-send-email-andreas.herrmann@calxeda.com>
References: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1380234982-1677-1-git-send-email-andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
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

This behaviour is controlled via a flag in smmu->bugs. It is set
based on DT information when probing an SMMU device.

Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c |   64 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 9d31ad9..5fa34f9 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -159,6 +159,12 @@
 #define PIDR2_ARCH_SHIFT		4
 #define PIDR2_ARCH_MASK			0xf
 
+/* secure aliases for non-secure registers */
+#define ARM_SMMU_GR0_nsCR0		0x400
+#define ARM_SMMU_GR0_nsGFSR		0x448
+#define ARM_SMMU_GR0_nsGFSYNR0		0x450
+#define ARM_SMMU_GR0_nsGFSYNR1		0x454
+
 /* Global TLB invalidation */
 #define ARM_SMMU_GR0_STLBIALL		0x60
 #define ARM_SMMU_GR0_TLBIVMID		0x64
@@ -349,6 +355,8 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_TRANS_S2		(1 << 3)
 #define ARM_SMMU_FEAT_TRANS_NESTED	(1 << 4)
 	u32				features;
+#define ARM_SMMU_BUG_SECURE_CFG_ACCESS	(1 << 0)
+	u32				bugs;
 	int				version;
 
 	u32				num_context_banks;
@@ -611,21 +619,32 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
 	struct arm_smmu_device *smmu = dev;
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 
-	gfsr = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSR);
+	if (smmu->bugs & ARM_SMMU_BUG_SECURE_CFG_ACCESS) {
+		gfsr = readl_relaxed(gr0_base + ARM_SMMU_GR0_nsGFSR);
+		gfsynr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_nsGFSYNR0);
+		gfsynr1 = readl_relaxed(gr0_base + ARM_SMMU_GR0_nsGFSYNR1);
+		gfsynr2 = 0;
+	} else {
+		gfsr = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSR);
+		gfsynr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR0);
+		gfsynr1 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR1);
+		gfsynr2 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR2);
+	}
+
 	if (!gfsr)
 		return IRQ_NONE;
 
-	gfsynr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR0);
-	gfsynr1 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR1);
-	gfsynr2 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR2);
-
 	dev_err_ratelimited(smmu->dev,
 		"Unexpected global fault, this could be serious\n");
 	dev_err_ratelimited(smmu->dev,
 		"\tGFSR 0x%08x, GFSYNR0 0x%08x, GFSYNR1 0x%08x, GFSYNR2 0x%08x\n",
 		gfsr, gfsynr0, gfsynr1, gfsynr2);
 
-	writel(gfsr, gr0_base + ARM_SMMU_GR0_sGFSR);
+	if (smmu->bugs & ARM_SMMU_BUG_SECURE_CFG_ACCESS)
+		writel(gfsr, gr0_base + ARM_SMMU_GR0_nsGFSR);
+	else
+		writel(gfsr, gr0_base + ARM_SMMU_GR0_sGFSR);
+
 	return IRQ_HANDLED;
 }
 
@@ -1565,10 +1584,16 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 	void __iomem *sctlr_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB_SCTLR;
 	int i = 0;
-	u32 scr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sCR0);
+	u32 cr0;
 
 	/* clear global FSRs */
-	writel(0xffffffff, gr0_base + ARM_SMMU_GR0_sGFSR);
+	if (smmu->bugs & ARM_SMMU_BUG_SECURE_CFG_ACCESS) {
+		writel(0xffffffff, gr0_base + ARM_SMMU_GR0_nsGFSR);
+		cr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_nsCR0);
+	} else {
+		writel(0xffffffff, gr0_base + ARM_SMMU_GR0_sGFSR);
+		cr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sCR0);
+	}
 
 	/* Mark all SMRn as invalid and all S2CRn as bypass */
 	for (i = 0; i < smmu->num_mapping_groups; ++i) {
@@ -1586,23 +1611,26 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLNSNH);
 
 	/* Enable fault reporting */
-	scr0 |= (sCR0_GFRE | sCR0_GFIE | sCR0_GCFGFRE | sCR0_GCFGFIE);
+	cr0 |= (sCR0_GFRE | sCR0_GFIE | sCR0_GCFGFRE | sCR0_GCFGFIE);
 
 	/* Disable TLB broadcasting. */
-	scr0 |= (sCR0_VMIDPNE | sCR0_PTM);
+	cr0 |= (sCR0_VMIDPNE | sCR0_PTM);
 
 	/* Enable client access, but bypass when no mapping is found */
-	scr0 &= ~(sCR0_CLIENTPD | sCR0_USFCFG);
+	cr0 &= ~(sCR0_CLIENTPD | sCR0_USFCFG);
 
 	/* Disable forced broadcasting */
-	scr0 &= ~sCR0_FB;
+	cr0 &= ~sCR0_FB;
 
 	/* Don't upgrade barriers */
-	scr0 &= ~(sCR0_BSU_MASK << sCR0_BSU_SHIFT);
+	cr0 &= ~(sCR0_BSU_MASK << sCR0_BSU_SHIFT);
 
 	/* Push the button */
 	arm_smmu_tlb_sync(smmu);
-	writel(scr0, gr0_base + ARM_SMMU_GR0_sCR0);
+	if (smmu->bugs & ARM_SMMU_BUG_SECURE_CFG_ACCESS)
+		writel(cr0, gr0_base + ARM_SMMU_GR0_nsCR0);
+	else
+		writel(cr0, gr0_base + ARM_SMMU_GR0_sCR0);
 }
 
 static int arm_smmu_id_size_to_bits(int size)
@@ -1894,6 +1922,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (of_property_read_bool(dev->of_node, "calxeda,smmu-secure-cfg-access"))
+		smmu->bugs |= ARM_SMMU_BUG_SECURE_CFG_ACCESS;
+
 	INIT_LIST_HEAD(&smmu->list);
 	spin_lock(&arm_smmu_devices_lock);
 	list_add(&smmu->list, &arm_smmu_devices);
@@ -1956,7 +1987,10 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 		free_irq(smmu->irqs[i], smmu);
 
 	/* Turn the thing off */
-	writel(sCR0_CLIENTPD, ARM_SMMU_GR0(smmu) + ARM_SMMU_GR0_sCR0);
+	if (smmu->bugs & ARM_SMMU_BUG_SECURE_CFG_ACCESS)
+		writel(sCR0_CLIENTPD, ARM_SMMU_GR0(smmu) + ARM_SMMU_GR0_nsCR0);
+	else
+		writel(sCR0_CLIENTPD, ARM_SMMU_GR0(smmu) + ARM_SMMU_GR0_sCR0);
 	return 0;
 }
 
-- 
1.7.9.5
