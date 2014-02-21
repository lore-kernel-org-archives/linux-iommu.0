From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 4/5] iommu/arm-smmu: clean up use of `flags' in page table
	handling code
Date: Fri, 21 Feb 2014 17:16:31 +0000
Message-ID: <1393002992-24561-5-git-send-email-will.deacon@arm.com>
References: <1393002992-24561-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1393002992-24561-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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

Commit 972157cac528 ("arm/smmu: Use irqsafe spinlock for domain lock")
fixed our page table locks to be the irq{save,restore} variants, since
the DMA mapping API can be invoked from interrupt context.

This patch cleans up our use of the flags variable so we can distinguish
between IRQ flags (now `flags') and pte protection bits (now `prot').

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index e04fdcb4b9ba..83297fe0878d 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1254,7 +1254,7 @@ static bool arm_smmu_pte_is_contiguous_range(unsigned long addr,
 
 static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 				   unsigned long addr, unsigned long end,
-				   unsigned long pfn, int flags, int stage)
+				   unsigned long pfn, int prot, int stage)
 {
 	pte_t *pte, *start;
 	pteval_t pteval = ARM_SMMU_PTE_PAGE | ARM_SMMU_PTE_AF | ARM_SMMU_PTE_XN;
@@ -1276,28 +1276,28 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 
 	if (stage == 1) {
 		pteval |= ARM_SMMU_PTE_AP_UNPRIV | ARM_SMMU_PTE_nG;
-		if (!(flags & IOMMU_WRITE) && (flags & IOMMU_READ))
+		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
 			pteval |= ARM_SMMU_PTE_AP_RDONLY;
 
-		if (flags & IOMMU_CACHE)
+		if (prot & IOMMU_CACHE)
 			pteval |= (MAIR_ATTR_IDX_CACHE <<
 				   ARM_SMMU_PTE_ATTRINDX_SHIFT);
 	} else {
 		pteval |= ARM_SMMU_PTE_HAP_FAULT;
-		if (flags & IOMMU_READ)
+		if (prot & IOMMU_READ)
 			pteval |= ARM_SMMU_PTE_HAP_READ;
-		if (flags & IOMMU_WRITE)
+		if (prot & IOMMU_WRITE)
 			pteval |= ARM_SMMU_PTE_HAP_WRITE;
-		if (flags & IOMMU_CACHE)
+		if (prot & IOMMU_CACHE)
 			pteval |= ARM_SMMU_PTE_MEMATTR_OIWB;
 		else
 			pteval |= ARM_SMMU_PTE_MEMATTR_NC;
 	}
 
 	/* If no access, create a faulting entry to avoid TLB fills */
-	if (flags & IOMMU_EXEC)
+	if (prot & IOMMU_EXEC)
 		pteval &= ~ARM_SMMU_PTE_XN;
-	else if (!(flags & (IOMMU_READ | IOMMU_WRITE)))
+	else if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
 		pteval &= ~ARM_SMMU_PTE_PAGE;
 
 	pteval |= ARM_SMMU_PTE_SH_IS;
@@ -1359,7 +1359,7 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 
 static int arm_smmu_alloc_init_pmd(struct arm_smmu_device *smmu, pud_t *pud,
 				   unsigned long addr, unsigned long end,
-				   phys_addr_t phys, int flags, int stage)
+				   phys_addr_t phys, int prot, int stage)
 {
 	int ret;
 	pmd_t *pmd;
@@ -1383,7 +1383,7 @@ static int arm_smmu_alloc_init_pmd(struct arm_smmu_device *smmu, pud_t *pud,
 	do {
 		next = pmd_addr_end(addr, end);
 		ret = arm_smmu_alloc_init_pte(smmu, pmd, addr, end, pfn,
-					      flags, stage);
+					      prot, stage);
 		phys += next - addr;
 	} while (pmd++, addr = next, addr < end);
 
@@ -1392,7 +1392,7 @@ static int arm_smmu_alloc_init_pmd(struct arm_smmu_device *smmu, pud_t *pud,
 
 static int arm_smmu_alloc_init_pud(struct arm_smmu_device *smmu, pgd_t *pgd,
 				   unsigned long addr, unsigned long end,
-				   phys_addr_t phys, int flags, int stage)
+				   phys_addr_t phys, int prot, int stage)
 {
 	int ret = 0;
 	pud_t *pud;
@@ -1416,7 +1416,7 @@ static int arm_smmu_alloc_init_pud(struct arm_smmu_device *smmu, pgd_t *pgd,
 	do {
 		next = pud_addr_end(addr, end);
 		ret = arm_smmu_alloc_init_pmd(smmu, pud, addr, next, phys,
-					      flags, stage);
+					      prot, stage);
 		phys += next - addr;
 	} while (pud++, addr = next, addr < end);
 
@@ -1425,7 +1425,7 @@ static int arm_smmu_alloc_init_pud(struct arm_smmu_device *smmu, pgd_t *pgd,
 
 static int arm_smmu_handle_mapping(struct arm_smmu_domain *smmu_domain,
 				   unsigned long iova, phys_addr_t paddr,
-				   size_t size, int flags)
+				   size_t size, int prot)
 {
 	int ret, stage;
 	unsigned long end;
@@ -1433,7 +1433,7 @@ static int arm_smmu_handle_mapping(struct arm_smmu_domain *smmu_domain,
 	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
 	pgd_t *pgd = root_cfg->pgd;
 	struct arm_smmu_device *smmu = root_cfg->smmu;
-	unsigned long irqflags;
+	unsigned long flags;
 
 	if (root_cfg->cbar == CBAR_TYPE_S2_TRANS) {
 		stage = 2;
@@ -1456,14 +1456,14 @@ static int arm_smmu_handle_mapping(struct arm_smmu_domain *smmu_domain,
 	if (paddr & ~output_mask)
 		return -ERANGE;
 
-	spin_lock_irqsave(&smmu_domain->lock, irqflags);
+	spin_lock_irqsave(&smmu_domain->lock, flags);
 	pgd += pgd_index(iova);
 	end = iova + size;
 	do {
 		unsigned long next = pgd_addr_end(iova, end);
 
 		ret = arm_smmu_alloc_init_pud(smmu, pgd, iova, next, paddr,
-					      flags, stage);
+					      prot, stage);
 		if (ret)
 			goto out_unlock;
 
@@ -1472,13 +1472,13 @@ static int arm_smmu_handle_mapping(struct arm_smmu_domain *smmu_domain,
 	} while (pgd++, iova != end);
 
 out_unlock:
-	spin_unlock_irqrestore(&smmu_domain->lock, irqflags);
+	spin_unlock_irqrestore(&smmu_domain->lock, flags);
 
 	return ret;
 }
 
 static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
-			phys_addr_t paddr, size_t size, int flags)
+			phys_addr_t paddr, size_t size, int prot)
 {
 	struct arm_smmu_domain *smmu_domain = domain->priv;
 
@@ -1489,7 +1489,7 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 	if ((phys_addr_t)iova & ~smmu_domain->output_mask)
 		return -ERANGE;
 
-	return arm_smmu_handle_mapping(smmu_domain, iova, paddr, size, flags);
+	return arm_smmu_handle_mapping(smmu_domain, iova, paddr, size, prot);
 }
 
 static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
-- 
1.8.2.2
