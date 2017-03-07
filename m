From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 3/4] iommu/arm-smmu: Tidy up context bank indexing
Date: Tue,  7 Mar 2017 18:09:06 +0000
Message-ID: <a74e55292cd7a3372aa80c6b12a71f0b4e8e4242.1488907474.git.robin.murphy@arm.com>
References: <cover.1488907474.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1488907474.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

ARM_AMMU_CB() is calculated relative to ARM_SMMU_CB_BASE(), but the
latter is never of use on its own, and what we end up with is the same
ARM_SMMU_CB_BASE() + ARM_AMMU_CB() expression being duplicated at every
callsite. Folding the two together gives us a self-contained context
bank accessor which is much more pleasant to work with.

Secondly, we might as well simplify CB_BASE itself at the same time.
We use the address space size for its own sake precisely once, at probe
time, and every other usage is to dynamically calculate CB_BASE over
and over and over again. Let's flip things around so that we just
maintain the CB_BASE address directly.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 0b64852baa6a..c8aafe304171 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -216,8 +216,7 @@ enum arm_smmu_s2cr_privcfg {
 #define CBA2R_VMID_MASK			0xffff
 
 /* Translation context bank */
-#define ARM_SMMU_CB_BASE(smmu)		((smmu)->base + ((smmu)->size >> 1))
-#define ARM_SMMU_CB(smmu, n)		((n) * (1 << (smmu)->pgshift))
+#define ARM_SMMU_CB(smmu, n)	((smmu)->cb_base + ((n) << (smmu)->pgshift))
 
 #define ARM_SMMU_CB_SCTLR		0x0
 #define ARM_SMMU_CB_ACTLR		0x4
@@ -344,7 +343,7 @@ struct arm_smmu_device {
 	struct device			*dev;
 
 	void __iomem			*base;
-	unsigned long			size;
+	void __iomem			*cb_base;
 	unsigned long			pgshift;
 
 #define ARM_SMMU_FEAT_COHERENT_WALK	(1 << 0)
@@ -603,7 +602,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	void __iomem *base;
 
 	if (stage1) {
-		base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
+		base = ARM_SMMU_CB(smmu, cfg->cbndx);
 		writel_relaxed(cfg->asid, base + ARM_SMMU_CB_S1_TLBIASID);
 	} else {
 		base = ARM_SMMU_GR0(smmu);
@@ -623,7 +622,7 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 	void __iomem *reg;
 
 	if (stage1) {
-		reg = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
+		reg = ARM_SMMU_CB(smmu, cfg->cbndx);
 		reg += leaf ? ARM_SMMU_CB_S1_TLBIVAL : ARM_SMMU_CB_S1_TLBIVA;
 
 		if (cfg->fmt != ARM_SMMU_CTX_FMT_AARCH64) {
@@ -642,7 +641,7 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 			} while (size -= granule);
 		}
 	} else if (smmu->version == ARM_SMMU_V2) {
-		reg = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
+		reg = ARM_SMMU_CB(smmu, cfg->cbndx);
 		reg += leaf ? ARM_SMMU_CB_S2_TLBIIPAS2L :
 			      ARM_SMMU_CB_S2_TLBIIPAS2;
 		iova >>= 12;
@@ -672,7 +671,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	void __iomem *cb_base;
 
-	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
+	cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
 	fsr = readl_relaxed(cb_base + ARM_SMMU_CB_FSR);
 
 	if (!(fsr & FSR_FAULT))
@@ -725,7 +724,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 
 	gr1_base = ARM_SMMU_GR1(smmu);
 	stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
-	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
+	cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
 
 	if (smmu->version > ARM_SMMU_V1) {
 		if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH64)
@@ -1007,7 +1006,7 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 	 * Disable the context bank and free the page tables before freeing
 	 * it.
 	 */
-	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
+	cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
 	writel_relaxed(0, cb_base + ARM_SMMU_CB_SCTLR);
 
 	if (cfg->irptndx != INVALID_IRPTNDX) {
@@ -1358,7 +1357,7 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 	u64 phys;
 	unsigned long va;
 
-	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
+	cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
 
 	/* ATS1 registers can only be written atomically */
 	va = iova & ~0xfffUL;
@@ -1685,7 +1684,7 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 
 	/* Make sure all context banks are disabled and clear CB_FSR  */
 	for (i = 0; i < smmu->num_context_banks; ++i) {
-		cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, i);
+		cb_base = ARM_SMMU_CB(smmu, i);
 		writel_relaxed(0, cb_base + ARM_SMMU_CB_SCTLR);
 		writel_relaxed(FSR_FAULT, cb_base + ARM_SMMU_CB_FSR);
 		/*
@@ -1865,12 +1864,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 
 	/* Check for size mismatch of SMMU address space from mapped region */
 	size = 1 << (((id >> ID1_NUMPAGENDXB_SHIFT) & ID1_NUMPAGENDXB_MASK) + 1);
-	size *= 2 << smmu->pgshift;
-	if (smmu->size != size) {
+	size <<= smmu->pgshift;
+	if (smmu->cb_base != gr0_base + size) {
 		dev_warn(smmu->dev,
 			"SMMU address space size (0x%lx) differs from mapped region size (0x%lx)!\n",
-			size, smmu->size);
-		smmu->size = size;
+			size * 2, (smmu->cb_base - gr0_base) * 2);
+		smmu->cb_base = gr0_base + size;
 	}
 
 	smmu->num_s2_context_banks = (id >> ID1_NUMS2CB_SHIFT) & ID1_NUMS2CB_MASK;
@@ -2107,7 +2106,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	smmu->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(smmu->base))
 		return PTR_ERR(smmu->base);
-	smmu->size = resource_size(res);
+	smmu->cb_base = smmu->base + resource_size(res) / 2;
 
 	num_irqs = 0;
 	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
-- 
2.11.0.dirty
