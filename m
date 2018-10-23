From: Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH 2/3] iommu/arm-smmu: Prepare fault, probe, sync functions for sharing code
Date: Tue, 23 Oct 2018 15:39:06 -0700
Message-ID: <1540334347-7178-3-git-send-email-vdumpa@nvidia.com>
References: <1540334347-7178-1-git-send-email-vdumpa@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540334347-7178-1-git-send-email-vdumpa@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, treding@nvidia.com, yhsu@nvidia.com, snikam@nvidia.com, praithatha@nvidia.com, talho@nvidia.com, avanbrunt@nvidia.com, Krishna Reddy <vdumpa@nvidia.com>
List-Id: iommu@lists.linux-foundation.org

Prepare fault handling, probe and tlb sync functions to allow sharing
code between ARM SMMU driver and Tegra194 SMMU driver.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 drivers/iommu/arm-smmu-common.c | 53 +++++++++++++++++++++++++++++++++++++++--
 drivers/iommu/arm-smmu.c        | 42 +++++++-------------------------
 2 files changed, 60 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/arm-smmu-common.c b/drivers/iommu/arm-smmu-common.c
index 1ad8e5f..0166319 100644
--- a/drivers/iommu/arm-smmu-common.c
+++ b/drivers/iommu/arm-smmu-common.c
@@ -166,7 +166,7 @@ static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu,
 {
 	unsigned int spin_cnt, delay;
 
-	writel_relaxed(0, sync);
+	writel_relaxed_one(0, sync);
 	for (delay = 1; delay < TLB_LOOP_TIMEOUT; delay *= 2) {
 		for (spin_cnt = TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
 			if (!(readl_relaxed(status) & sTLBGSTATUS_GSACTIVE))
@@ -287,6 +287,52 @@ static const struct iommu_gather_ops arm_smmu_s2_tlb_ops_v1 = {
 	.tlb_sync	= arm_smmu_tlb_sync_vmid,
 };
 
+static irqreturn_t arm_smmu_context_fault_common(struct arm_smmu_device *smmu,
+	struct arm_smmu_cfg *cfg, void __iomem *cb_base)
+{
+	u32 fsr, fsynr;
+	unsigned long iova;
+
+	cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
+	fsr = readl_relaxed(cb_base + ARM_SMMU_CB_FSR);
+
+	if (!(fsr & FSR_FAULT))
+		return IRQ_NONE;
+
+	fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
+	iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
+
+	dev_err_ratelimited(smmu->dev,
+	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d\n",
+			    fsr, iova, fsynr, cfg->cbndx);
+
+	writel_one(fsr, cb_base + ARM_SMMU_CB_FSR);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t arm_smmu_global_fault_common(
+	struct arm_smmu_device *smmu, void __iomem *gr0_base)
+{
+	u32 gfsr, gfsynr0, gfsynr1, gfsynr2;
+
+	gfsr = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSR);
+	gfsynr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR0);
+	gfsynr1 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR1);
+	gfsynr2 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR2);
+
+	if (!gfsr)
+		return IRQ_NONE;
+
+	dev_err_ratelimited(smmu->dev,
+		"Unexpected global fault, this could be serious\n");
+	dev_err_ratelimited(smmu->dev,
+		"\tGFSR 0x%08x, GFSYNR0 0x%08x, GFSYNR1 0x%08x, GFSYNR2 0x%08x\n",
+		gfsr, gfsynr0, gfsynr1, gfsynr2);
+
+	writel_one(gfsr, gr0_base + ARM_SMMU_GR0_sGFSR);
+	return IRQ_HANDLED;
+}
+
 static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
@@ -1757,7 +1803,8 @@ static void arm_smmu_bus_init(void)
 #endif
 }
 
-static int arm_smmu_device_probe(struct platform_device *pdev)
+static int arm_smmu_device_probe_common(struct platform_device *pdev,
+					  void __iomem **pbase)
 {
 	struct resource *res;
 	resource_size_t ioaddr;
@@ -1786,6 +1833,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (IS_ERR(smmu->base))
 		return PTR_ERR(smmu->base);
 	smmu->cb_base = smmu->base + resource_size(res) / 2;
+	if (pbase)
+		*pbase = smmu->base;
 
 	num_irqs = 0;
 	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index a341c9f..d076b3b 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -31,6 +31,8 @@
 
 #include "arm-smmu-common.h"
 
+#define writel_one writel
+#define writel_relaxed_one writel_relaxed
 #include "arm-smmu-common.c"
 
 static void arm_smmu_tlb_sync_global(struct arm_smmu_device *smmu)
@@ -59,8 +61,6 @@ static void arm_smmu_tlb_sync_context(void *cookie)
 
 static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 {
-	u32 fsr, fsynr;
-	unsigned long iova;
 	struct iommu_domain *domain = dev;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
@@ -68,44 +68,15 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	void __iomem *cb_base;
 
 	cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
-	fsr = readl_relaxed(cb_base + ARM_SMMU_CB_FSR);
-
-	if (!(fsr & FSR_FAULT))
-		return IRQ_NONE;
-
-	fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
-	iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
-
-	dev_err_ratelimited(smmu->dev,
-	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d\n",
-			    fsr, iova, fsynr, cfg->cbndx);
-
-	writel(fsr, cb_base + ARM_SMMU_CB_FSR);
-	return IRQ_HANDLED;
+	return arm_smmu_context_fault_common(smmu, cfg, cb_base);
 }
 
 static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
 {
-	u32 gfsr, gfsynr0, gfsynr1, gfsynr2;
 	struct arm_smmu_device *smmu = dev;
 	void __iomem *gr0_base = ARM_SMMU_GR0_NS(smmu);
 
-	gfsr = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSR);
-	gfsynr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR0);
-	gfsynr1 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR1);
-	gfsynr2 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR2);
-
-	if (!gfsr)
-		return IRQ_NONE;
-
-	dev_err_ratelimited(smmu->dev,
-		"Unexpected global fault, this could be serious\n");
-	dev_err_ratelimited(smmu->dev,
-		"\tGFSR 0x%08x, GFSYNR0 0x%08x, GFSYNR1 0x%08x, GFSYNR2 0x%08x\n",
-		gfsr, gfsynr0, gfsynr1, gfsynr2);
-
-	writel(gfsr, gr0_base + ARM_SMMU_GR0_sGFSR);
-	return IRQ_HANDLED;
+	return arm_smmu_global_fault_common(smmu, gr0_base);
 }
 
 ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
@@ -125,6 +96,11 @@ static const struct of_device_id arm_smmu_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
 
+static int arm_smmu_device_probe(struct platform_device *pdev)
+{
+	return arm_smmu_device_probe_common(pdev, NULL);
+}
+
 static struct platform_driver arm_smmu_driver = {
 	.driver	= {
 		.name		= "arm-smmu",
-- 
2.1.4
