From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 6/6] iommu/arm-smmu: add .domain_{set,
	get}_attr for coherent walk control
Date: Tue, 12 Aug 2014 17:51:39 -0700
Message-ID: <1407891099-24641-7-git-send-email-mitchelh@codeaurora.org>
References: <1407891099-24641-1-git-send-email-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1407891099-24641-1-git-send-email-mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Under certain conditions coherent hardware translation table walks can
result in degraded performance. Add a new domain attribute to
disable/enable this feature in generic code along with the domain
attribute setter and getter to handle it in the ARM SMMU driver.

Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 57 +++++++++++++++++++++++++++++++-----------------
 include/linux/iommu.h    |  1 +
 2 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 73d056668b..11672a8371 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -426,6 +426,7 @@ struct arm_smmu_cfg {
 	u8				irptndx;
 	u32				cbar;
 	pgd_t				*pgd;
+	bool				htw_disable;
 };
 #define INVALID_IRPTNDX			0xff
 
@@ -833,14 +834,17 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-static void arm_smmu_flush_pgtable(struct arm_smmu_device *smmu, void *addr,
-				   size_t size)
+static void arm_smmu_flush_pgtable(struct arm_smmu_domain *smmu_domain,
+				   void *addr, size_t size)
 {
+	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	unsigned long offset = (unsigned long)addr & ~PAGE_MASK;
 
 
 	/* Ensure new page tables are visible to the hardware walker */
-	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK) {
+	if ((smmu->features & ARM_SMMU_FEAT_COHERENT_WALK) &&
+		!cfg->htw_disable) {
 		dsb(ishst);
 	} else {
 		/*
@@ -943,7 +947,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 	}
 
 	/* TTBR0 */
-	arm_smmu_flush_pgtable(smmu, cfg->pgd,
+	arm_smmu_flush_pgtable(smmu_domain, cfg->pgd,
 			       PTRS_PER_PGD * sizeof(pgd_t));
 	reg = __pa(cfg->pgd);
 	writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_LO);
@@ -1468,7 +1472,8 @@ static bool arm_smmu_pte_is_contiguous_range(unsigned long addr,
 		(addr + ARM_SMMU_PTE_CONT_SIZE <= end);
 }
 
-static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
+static int arm_smmu_alloc_init_pte(struct arm_smmu_domain *smmu_domain,
+				   pmd_t *pmd,
 				   unsigned long addr, unsigned long end,
 				   unsigned long pfn, int prot, int stage)
 {
@@ -1482,9 +1487,10 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 		if (!table)
 			return -ENOMEM;
 
-		arm_smmu_flush_pgtable(smmu, page_address(table), PAGE_SIZE);
+		arm_smmu_flush_pgtable(smmu_domain, page_address(table),
+				PAGE_SIZE);
 		pmd_populate(NULL, pmd, table);
-		arm_smmu_flush_pgtable(smmu, pmd, sizeof(*pmd));
+		arm_smmu_flush_pgtable(smmu_domain, pmd, sizeof(*pmd));
 	}
 
 	if (stage == 1) {
@@ -1558,7 +1564,7 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 				pte_val(*(cont_start + j)) &=
 					~ARM_SMMU_PTE_CONT;
 
-			arm_smmu_flush_pgtable(smmu, cont_start,
+			arm_smmu_flush_pgtable(smmu_domain, cont_start,
 					       sizeof(*pte) *
 					       ARM_SMMU_PTE_CONT_ENTRIES);
 		}
@@ -1568,11 +1574,13 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 		} while (pte++, pfn++, addr += PAGE_SIZE, --i);
 	} while (addr != end);
 
-	arm_smmu_flush_pgtable(smmu, start, sizeof(*pte) * (pte - start));
+	arm_smmu_flush_pgtable(smmu_domain, start,
+			sizeof(*pte) * (pte - start));
 	return 0;
 }
 
-static int arm_smmu_alloc_init_pmd(struct arm_smmu_device *smmu, pud_t *pud,
+static int arm_smmu_alloc_init_pmd(struct arm_smmu_domain *smmu_domain,
+				   pud_t *pud,
 				   unsigned long addr, unsigned long end,
 				   phys_addr_t phys, int prot, int stage)
 {
@@ -1586,9 +1594,9 @@ static int arm_smmu_alloc_init_pmd(struct arm_smmu_device *smmu, pud_t *pud,
 		if (!pmd)
 			return -ENOMEM;
 
-		arm_smmu_flush_pgtable(smmu, pmd, PAGE_SIZE);
+		arm_smmu_flush_pgtable(smmu_domain, pmd, PAGE_SIZE);
 		pud_populate(NULL, pud, pmd);
-		arm_smmu_flush_pgtable(smmu, pud, sizeof(*pud));
+		arm_smmu_flush_pgtable(smmu_domain, pud, sizeof(*pud));
 
 		pmd += pmd_index(addr);
 	} else
@@ -1597,7 +1605,7 @@ static int arm_smmu_alloc_init_pmd(struct arm_smmu_device *smmu, pud_t *pud,
 
 	do {
 		next = pmd_addr_end(addr, end);
-		ret = arm_smmu_alloc_init_pte(smmu, pmd, addr, next, pfn,
+		ret = arm_smmu_alloc_init_pte(smmu_domain, pmd, addr, next, pfn,
 					      prot, stage);
 		phys += next - addr;
 	} while (pmd++, addr = next, addr < end);
@@ -1605,7 +1613,8 @@ static int arm_smmu_alloc_init_pmd(struct arm_smmu_device *smmu, pud_t *pud,
 	return ret;
 }
 
-static int arm_smmu_alloc_init_pud(struct arm_smmu_device *smmu, pgd_t *pgd,
+static int arm_smmu_alloc_init_pud(struct arm_smmu_domain *smmu_domain,
+				   pgd_t *pgd,
 				   unsigned long addr, unsigned long end,
 				   phys_addr_t phys, int prot, int stage)
 {
@@ -1619,9 +1628,9 @@ static int arm_smmu_alloc_init_pud(struct arm_smmu_device *smmu, pgd_t *pgd,
 		if (!pud)
 			return -ENOMEM;
 
-		arm_smmu_flush_pgtable(smmu, pud, PAGE_SIZE);
+		arm_smmu_flush_pgtable(smmu_domain, pud, PAGE_SIZE);
 		pgd_populate(NULL, pgd, pud);
-		arm_smmu_flush_pgtable(smmu, pgd, sizeof(*pgd));
+		arm_smmu_flush_pgtable(smmu_domain, pgd, sizeof(*pgd));
 
 		pud += pud_index(addr);
 	} else
@@ -1630,8 +1639,8 @@ static int arm_smmu_alloc_init_pud(struct arm_smmu_device *smmu, pgd_t *pgd,
 
 	do {
 		next = pud_addr_end(addr, end);
-		ret = arm_smmu_alloc_init_pmd(smmu, pud, addr, next, phys,
-					      prot, stage);
+		ret = arm_smmu_alloc_init_pmd(smmu_domain, pud, addr, next,
+					      phys, prot, stage);
 		phys += next - addr;
 	} while (pud++, addr = next, addr < end);
 
@@ -1677,8 +1686,8 @@ static int arm_smmu_handle_mapping(struct arm_smmu_domain *smmu_domain,
 	do {
 		unsigned long next = pgd_addr_end(iova, end);
 
-		ret = arm_smmu_alloc_init_pud(smmu, pgd, iova, next, paddr,
-					      prot, stage);
+		ret = arm_smmu_alloc_init_pud(smmu_domain, pgd, iova, next,
+					      paddr, prot, stage);
 		if (ret)
 			goto out_unlock;
 
@@ -1908,11 +1917,15 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 				    enum iommu_attr attr, void *data)
 {
 	struct arm_smmu_domain *smmu_domain = domain->priv;
+	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 
 	switch (attr) {
 	case DOMAIN_ATTR_NESTING:
 		*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
 		return 0;
+	case DOMAIN_ATTR_COHERENT_HTW_DISABLE:
+		*((bool *)data) = cfg->htw_disable;
+		return 0;
 	default:
 		return -ENODEV;
 	}
@@ -1922,6 +1935,7 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 				    enum iommu_attr attr, void *data)
 {
 	struct arm_smmu_domain *smmu_domain = domain->priv;
+	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 
 	switch (attr) {
 	case DOMAIN_ATTR_NESTING:
@@ -1933,6 +1947,9 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 			smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
 
 		return 0;
+	case DOMAIN_ATTR_COHERENT_HTW_DISABLE:
+		cfg->htw_disable = *((bool *)data);
+		return 0;
 	default:
 		return -ENODEV;
 	}
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0550286df4..8a6449857a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -81,6 +81,7 @@ enum iommu_attr {
 	DOMAIN_ATTR_FSL_PAMU_ENABLE,
 	DOMAIN_ATTR_FSL_PAMUV1,
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
+	DOMAIN_ATTR_COHERENT_HTW_DISABLE,
 	DOMAIN_ATTR_MAX,
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
