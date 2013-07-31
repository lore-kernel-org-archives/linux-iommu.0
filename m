From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 4/4] iommu: arm smmu: simplify VMID and ASID allocation
Date: Wed, 31 Jul 2013 19:21:28 +0100
Message-ID: <1375294888-10826-5-git-send-email-will.deacon@arm.com>
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

We only use ASIDs and VMIDs to identify individual stage-1 and stage-2
context-banks respectively, so rather than allocate these separately
from the context-banks, just calculate them based on the context bank
index.

Note that VMIDs are offset by 1, since VMID 0 is reserved for stage-1.
This doesn't cause us any issues with the numberspaces, since the
maximum number of context banks is half the minimum number of VMIDs.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 07a0308..f417e89 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -56,9 +56,6 @@
 /* Maximum number of mapping groups per SMMU */
 #define ARM_SMMU_MAX_SMRS		128
 
-/* Number of VMIDs per SMMU */
-#define ARM_SMMU_NUM_VMIDS		256
-
 /* SMMU global address space */
 #define ARM_SMMU_GR0(smmu)		((smmu)->base)
 #define ARM_SMMU_GR1(smmu)		((smmu)->base + (smmu)->pagesize)
@@ -369,21 +366,21 @@ struct arm_smmu_device {
 	u32				num_context_irqs;
 	unsigned int			*irqs;
 
-	DECLARE_BITMAP(vmid_map, ARM_SMMU_NUM_VMIDS);
-
 	struct list_head		list;
 	struct rb_root			masters;
 };
 
 struct arm_smmu_cfg {
 	struct arm_smmu_device		*smmu;
-	u8				vmid;
 	u8				cbndx;
 	u8				irptndx;
 	u32				cbar;
 	pgd_t				*pgd;
 };
 
+#define ARM_SMMU_CB_ASID(cfg)		((cfg)->cbndx)
+#define ARM_SMMU_CB_VMID(cfg)		((cfg)->cbndx + 1)
+
 struct arm_smmu_domain {
 	/*
 	 * A domain can span across multiple, chained SMMUs and requires
@@ -545,10 +542,12 @@ static void arm_smmu_tlb_inv_context(struct arm_smmu_cfg *cfg)
 
 	if (stage1) {
 		base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
-		writel_relaxed(cfg->vmid, base + ARM_SMMU_CB_S1_TLBIASID);
+		writel_relaxed(ARM_SMMU_CB_ASID(cfg),
+			       base + ARM_SMMU_CB_S1_TLBIASID);
 	} else {
 		base = ARM_SMMU_GR0(smmu);
-		writel_relaxed(cfg->vmid, base + ARM_SMMU_GR0_TLBIVMID);
+		writel_relaxed(ARM_SMMU_CB_VMID(cfg),
+			       base + ARM_SMMU_GR0_TLBIVMID);
 	}
 
 	arm_smmu_tlb_sync(smmu);
@@ -650,7 +649,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 	if (stage1)
 		reg |= (CBAR_S1_MEMATTR_WB << CBAR_S1_MEMATTR_SHIFT);
 	else
-		reg |= root_cfg->vmid << CBAR_VMID_SHIFT;
+		reg |= ARM_SMMU_CB_VMID(root_cfg) << CBAR_VMID_SHIFT;
 	writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBAR(root_cfg->cbndx));
 
 	if (smmu->version > 1) {
@@ -715,7 +714,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 	writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_LO);
 	reg = (phys_addr_t)__pa(root_cfg->pgd) >> 32;
 	if (stage1)
-		reg |= root_cfg->vmid << TTBRn_HI_ASID_SHIFT;
+		reg |= ARM_SMMU_CB_ASID(root_cfg) << TTBRn_HI_ASID_SHIFT;
 	writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_HI);
 
 	/*
@@ -807,12 +806,6 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		return -ENODEV;
 	}
 
-	/* VMID zero is reserved for stage-1 mappings */
-	ret = __arm_smmu_alloc_bitmap(smmu->vmid_map, 1, ARM_SMMU_NUM_VMIDS);
-	if (IS_ERR_VALUE(ret))
-		return ret;
-
-	root_cfg->vmid = ret;
 	if (smmu->features & ARM_SMMU_FEAT_TRANS_NESTED) {
 		/*
 		 * We will likely want to change this if/when KVM gets
@@ -831,10 +824,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	ret = __arm_smmu_alloc_bitmap(smmu->context_map, start,
 				      smmu->num_context_banks);
 	if (IS_ERR_VALUE(ret))
-		goto out_free_vmid;
+		return ret;
 
 	root_cfg->cbndx = ret;
-
 	if (smmu->version == 1) {
 		root_cfg->irptndx = atomic_inc_return(&smmu->irptndx);
 		root_cfg->irptndx %= smmu->num_context_irqs;
@@ -858,8 +850,6 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 
 out_free_context:
 	__arm_smmu_free_bitmap(smmu->context_map, root_cfg->cbndx);
-out_free_vmid:
-	__arm_smmu_free_bitmap(smmu->vmid_map, root_cfg->vmid);
 	return ret;
 }
 
@@ -884,7 +874,6 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 		free_irq(irq, domain);
 	}
 
-	__arm_smmu_free_bitmap(smmu->vmid_map, root_cfg->vmid);
 	__arm_smmu_free_bitmap(smmu->context_map, root_cfg->cbndx);
 }
 
@@ -1936,7 +1925,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 		of_node_put(master->of_node);
 	}
 
-	if (!bitmap_empty(smmu->vmid_map, ARM_SMMU_NUM_VMIDS))
+	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
 		dev_err(dev, "removing device with active domains!\n");
 
 	for (i = 0; i < smmu->num_global_irqs; ++i)
-- 
1.8.2.2
