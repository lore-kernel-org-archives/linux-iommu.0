From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 3/4] iommu: arm smmu: don't use VMIDs for stage-1 translations
Date: Wed, 31 Jul 2013 19:21:27 +0100
Message-ID: <1375294888-10826-4-git-send-email-will.deacon@arm.com>
References: <1375294888-10826-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1375294888-10826-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Although permitted by the architecture, using VMIDs for stage-1
translations causes a complete nightmare for hypervisors, who end up
having to virtualise the VMID space across VMs, which may be using
multiple VMIDs each.

To make life easier for hypervisors (which might just decide not to
support this VMID virtualisation), this patch reworks the stage-1
context-bank TLB invalidation so that:

	- Stage-1 mappings are marked non-global in the ptes
	- Each Stage-1 context-bank is assigned an ASID in TTBR0
	- VMID 0 is reserved for Stage-1 context-banks

This allows the hypervisor to overwrite the Stage-1 VMID in the CBAR
when trapping the write from the guest.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 59 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 3a595bb..07a0308 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -87,6 +87,7 @@
 #define ARM_SMMU_PTE_AP_UNPRIV		(((pteval_t)1) << 6)
 #define ARM_SMMU_PTE_AP_RDONLY		(((pteval_t)2) << 6)
 #define ARM_SMMU_PTE_ATTRINDX_SHIFT	2
+#define ARM_SMMU_PTE_nG			(((pteval_t)1) << 11)
 
 /* Stage-2 PTE */
 #define ARM_SMMU_PTE_HAP_FAULT		(((pteval_t)0) << 6)
@@ -223,6 +224,7 @@
 #define ARM_SMMU_CB_FAR_LO		0x60
 #define ARM_SMMU_CB_FAR_HI		0x64
 #define ARM_SMMU_CB_FSYNR0		0x68
+#define ARM_SMMU_CB_S1_TLBIASID		0x610
 
 #define SCTLR_S1_ASIDPNE		(1 << 12)
 #define SCTLR_CFCFG			(1 << 7)
@@ -282,6 +284,8 @@
 #define TTBCR2_ADDR_44			4
 #define TTBCR2_ADDR_48			5
 
+#define TTBRn_HI_ASID_SHIFT		16
+
 #define MAIR_ATTR_SHIFT(n)		((n) << 3)
 #define MAIR_ATTR_MASK			0xff
 #define MAIR_ATTR_DEVICE		0x04
@@ -533,6 +537,23 @@ static void arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
 	}
 }
 
+static void arm_smmu_tlb_inv_context(struct arm_smmu_cfg *cfg)
+{
+	struct arm_smmu_device *smmu = cfg->smmu;
+	void __iomem *base = ARM_SMMU_GR0(smmu);
+	bool stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
+
+	if (stage1) {
+		base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
+		writel_relaxed(cfg->vmid, base + ARM_SMMU_CB_S1_TLBIASID);
+	} else {
+		base = ARM_SMMU_GR0(smmu);
+		writel_relaxed(cfg->vmid, base + ARM_SMMU_GR0_TLBIVMID);
+	}
+
+	arm_smmu_tlb_sync(smmu);
+}
+
 static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 {
 	int flags, ret;
@@ -621,14 +642,15 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, root_cfg->cbndx);
 
 	/* CBAR */
-	reg = root_cfg->cbar |
-	      (root_cfg->vmid << CBAR_VMID_SHIFT);
+	reg = root_cfg->cbar;
 	if (smmu->version == 1)
 	      reg |= root_cfg->irptndx << CBAR_IRPTNDX_SHIFT;
 
 	/* Use the weakest memory type, so it is overridden by the pte */
 	if (stage1)
 		reg |= (CBAR_S1_MEMATTR_WB << CBAR_S1_MEMATTR_SHIFT);
+	else
+		reg |= root_cfg->vmid << CBAR_VMID_SHIFT;
 	writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBAR(root_cfg->cbndx));
 
 	if (smmu->version > 1) {
@@ -692,6 +714,8 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 	reg = __pa(root_cfg->pgd);
 	writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_LO);
 	reg = (phys_addr_t)__pa(root_cfg->pgd) >> 32;
+	if (stage1)
+		reg |= root_cfg->vmid << TTBRn_HI_ASID_SHIFT;
 	writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_HI);
 
 	/*
@@ -747,10 +771,6 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 		writel_relaxed(reg, cb_base + ARM_SMMU_CB_S1_MAIR0);
 	}
 
-	/* Nuke the TLB */
-	writel_relaxed(root_cfg->vmid, gr0_base + ARM_SMMU_GR0_TLBIVMID);
-	arm_smmu_tlb_sync(smmu);
-
 	/* SCTLR */
 	reg = SCTLR_CFCFG | SCTLR_CFIE | SCTLR_CFRE | SCTLR_M | SCTLR_EAE_SBOP;
 	if (stage1)
@@ -787,7 +807,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		return -ENODEV;
 	}
 
-	ret = __arm_smmu_alloc_bitmap(smmu->vmid_map, 0, ARM_SMMU_NUM_VMIDS);
+	/* VMID zero is reserved for stage-1 mappings */
+	ret = __arm_smmu_alloc_bitmap(smmu->vmid_map, 1, ARM_SMMU_NUM_VMIDS);
 	if (IS_ERR_VALUE(ret))
 		return ret;
 
@@ -847,11 +868,17 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 	struct arm_smmu_domain *smmu_domain = domain->priv;
 	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
 	struct arm_smmu_device *smmu = root_cfg->smmu;
+	void __iomem *cb_base;
 	int irq;
 
 	if (!smmu)
 		return;
 
+	/* Disable the context bank and nuke the TLB before freeing it. */
+	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, root_cfg->cbndx);
+	writel_relaxed(0, cb_base + ARM_SMMU_CB_SCTLR);
+	arm_smmu_tlb_inv_context(root_cfg);
+
 	if (root_cfg->irptndx != -1) {
 		irq = smmu->irqs[smmu->num_global_irqs + root_cfg->irptndx];
 		free_irq(irq, domain);
@@ -956,6 +983,11 @@ static void arm_smmu_free_pgtables(struct arm_smmu_domain *smmu_domain)
 static void arm_smmu_domain_destroy(struct iommu_domain *domain)
 {
 	struct arm_smmu_domain *smmu_domain = domain->priv;
+
+	/*
+	 * Free the domain resources. We assume that all devices have
+	 * already been detached.
+	 */
 	arm_smmu_destroy_domain_context(domain);
 	arm_smmu_free_pgtables(smmu_domain);
 	kfree(smmu_domain);
@@ -1196,7 +1228,7 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 	}
 
 	if (stage == 1) {
-		pteval |= ARM_SMMU_PTE_AP_UNPRIV;
+		pteval |= ARM_SMMU_PTE_AP_UNPRIV | ARM_SMMU_PTE_nG;
 		if (!(flags & IOMMU_WRITE) && (flags & IOMMU_READ))
 			pteval |= ARM_SMMU_PTE_AP_RDONLY;
 
@@ -1412,13 +1444,9 @@ static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 {
 	int ret;
 	struct arm_smmu_domain *smmu_domain = domain->priv;
-	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
-	struct arm_smmu_device *smmu = root_cfg->smmu;
-	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
 
 	ret = arm_smmu_handle_mapping(smmu_domain, iova, 0, size, 0);
-	writel_relaxed(root_cfg->vmid, gr0_base + ARM_SMMU_GR0_TLBIVMID);
-	arm_smmu_tlb_sync(smmu);
+	arm_smmu_tlb_inv_context(&smmu_domain->root_cfg);
 	return ret ? ret : size;
 }
 
@@ -1541,6 +1569,7 @@ static struct iommu_ops arm_smmu_ops = {
 static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 {
 	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
+	void __iomem *sctlr_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB_SCTLR;
 	int i = 0;
 	u32 scr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sCR0);
 
@@ -1550,6 +1579,10 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		writel_relaxed(S2CR_TYPE_BYPASS, gr0_base + ARM_SMMU_GR0_S2CR(i));
 	}
 
+	/* Make sure all context banks are disabled */
+	for (i = 0; i < smmu->num_context_banks; ++i)
+		writel_relaxed(0, sctlr_base + ARM_SMMU_CB(smmu, i));
+
 	/* Invalidate the TLB, just in case */
 	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_STLBIALL);
 	writel_relaxed(0, gr0_base + ARM_SMMU_GR0_TLBIALLH);
-- 
1.8.2.2
