From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [RFC][PATCH] iommu/arm-smmu: Huge page mapping support for ARM SMMU
	driver.
Date: Wed, 12 Nov 2014 23:56:30 +0530
Message-ID: <1415816790-27626-1-git-send-email-Varun.Sethi@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch adds huge page mapping support for the ARM SMMU Driver.
Patch allows creation of 1G and 2MB page mappings. It's also possible
to create contiguous huge page mappings.

The loop in PMD/PUD intialization code has been removed, considering that
iommu_map would work on page size granularity (exported by the arm smmu
driver).

The code doesn't support creation of new mapping, without unmaping an
existing mapping.

Code does support splitting up of huge page mappings in to smaller mappings,
as a part of unmap.

Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/iommu/arm-smmu.c |  324 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 257 insertions(+), 67 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 60558f7..cf05a1f 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -81,16 +81,22 @@
 #define ARM_SMMU_PTE_PAGE		(((pteval_t)3) << 0)
 
 #if PAGE_SIZE == SZ_4K
-#define ARM_SMMU_PTE_CONT_ENTRIES	16
+#define ARM_SMMU_PGTBL_CONT_ENTRIES	16
 #elif PAGE_SIZE == SZ_64K
-#define ARM_SMMU_PTE_CONT_ENTRIES	32
+#define ARM_SMMU_PGTBL_CONT_ENTRIES	32
 #else
-#define ARM_SMMU_PTE_CONT_ENTRIES	1
+#define ARM_SMMU_PGTBL_CONT_ENTRIES	1
 #endif
 
-#define ARM_SMMU_PTE_CONT_SIZE		(PAGE_SIZE * ARM_SMMU_PTE_CONT_ENTRIES)
+#define ARM_SMMU_PTE_CONT_SIZE		(PAGE_SIZE * ARM_SMMU_PGTBL_CONT_ENTRIES)
 #define ARM_SMMU_PTE_CONT_MASK		(~(ARM_SMMU_PTE_CONT_SIZE - 1))
 
+#define ARM_SMMU_PMD_CONT_SIZE		(PMD_SIZE * ARM_SMMU_PGTBL_CONT_ENTRIES)
+#define ARM_SMMU_PMD_CONT_MASK		(~(ARM_SMMU_PMD_CONT_SIZE - 1))
+
+#define ARM_SMMU_PUD_CONT_SIZE		(PUD_SIZE * ARM_SMMU_PGTBL_CONT_ENTRIES)
+#define ARM_SMMU_PUD_CONT_MASK		(~(ARM_SMMU_PUD_CONT_SIZE - 1))
+
 /* Stage-1 PTE */
 #define ARM_SMMU_PTE_AP_UNPRIV		(((pteval_t)1) << 6)
 #define ARM_SMMU_PTE_AP_RDONLY		(((pteval_t)2) << 6)
@@ -1272,64 +1278,105 @@ static void arm_smmu_detach_dev(struct iommu_domain *domain, struct device *dev)
 static bool arm_smmu_pte_is_contiguous_range(unsigned long addr,
 					     unsigned long end)
 {
-	return !(addr & ~ARM_SMMU_PTE_CONT_MASK) &&
+	return IS_ALIGNED(addr, ARM_SMMU_PTE_CONT_SIZE) &&
 		(addr + ARM_SMMU_PTE_CONT_SIZE <= end);
 }
 
-static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
-				   unsigned long addr, unsigned long end,
-				   unsigned long pfn, int prot, int stage)
+static bool arm_smmu_pmd_is_contiguous_range(unsigned long addr,
+					     unsigned long end)
 {
-	pte_t *pte, *start;
-	pteval_t pteval = ARM_SMMU_PTE_PAGE | ARM_SMMU_PTE_AF | ARM_SMMU_PTE_XN;
-
-	if (pmd_none(*pmd)) {
-		/* Allocate a new set of tables */
-		pgtable_t table = alloc_page(GFP_ATOMIC|__GFP_ZERO);
+	return IS_ALIGNED(addr, ARM_SMMU_PMD_CONT_SIZE) &&
+		(addr + ARM_SMMU_PMD_CONT_SIZE <= end);
+}
 
-		if (!table)
-			return -ENOMEM;
+static bool arm_smmu_pud_is_contiguous_range(unsigned long addr,
+					     unsigned long end)
+{
+	return IS_ALIGNED(addr, ARM_SMMU_PUD_CONT_SIZE) &&
+		(addr + ARM_SMMU_PUD_CONT_SIZE <= end);
+}
 
-		arm_smmu_flush_pgtable(smmu, page_address(table), PAGE_SIZE);
-		pmd_populate(NULL, pmd, table);
-		arm_smmu_flush_pgtable(smmu, pmd, sizeof(*pmd));
-	}
+static pteval_t arm_smmu_page_prot(int prot, int stage, u64 type)
+{
+	pteval_t pgprot = ARM_SMMU_PTE_AF | ARM_SMMU_PTE_XN | type;
 
 	if (stage == 1) {
-		pteval |= ARM_SMMU_PTE_AP_UNPRIV | ARM_SMMU_PTE_nG;
+		pgprot |= ARM_SMMU_PTE_AP_UNPRIV | ARM_SMMU_PTE_nG;
 		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
-			pteval |= ARM_SMMU_PTE_AP_RDONLY;
+			pgprot |= ARM_SMMU_PTE_AP_RDONLY;
 
 		if (prot & IOMMU_CACHE)
-			pteval |= (MAIR_ATTR_IDX_CACHE <<
+			pgprot |= (MAIR_ATTR_IDX_CACHE <<
 				   ARM_SMMU_PTE_ATTRINDX_SHIFT);
 	} else {
-		pteval |= ARM_SMMU_PTE_HAP_FAULT;
+		pgprot |= ARM_SMMU_PTE_HAP_FAULT;
 		if (prot & IOMMU_READ)
-			pteval |= ARM_SMMU_PTE_HAP_READ;
+			pgprot |= ARM_SMMU_PTE_HAP_READ;
 		if (prot & IOMMU_WRITE)
-			pteval |= ARM_SMMU_PTE_HAP_WRITE;
+			pgprot |= ARM_SMMU_PTE_HAP_WRITE;
 		if (prot & IOMMU_CACHE)
-			pteval |= ARM_SMMU_PTE_MEMATTR_OIWB;
+			pgprot |= ARM_SMMU_PTE_MEMATTR_OIWB;
 		else
-			pteval |= ARM_SMMU_PTE_MEMATTR_NC;
+			pgprot |= ARM_SMMU_PTE_MEMATTR_NC;
 	}
 
 	/* If no access, create a faulting entry to avoid TLB fills */
 	if (prot & IOMMU_EXEC)
-		pteval &= ~ARM_SMMU_PTE_XN;
+		pgprot &= ~ARM_SMMU_PTE_XN;
 	else if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
-		pteval &= ~ARM_SMMU_PTE_PAGE;
+		pgprot &= ~ARM_SMMU_PTE_PAGE;
+
+	pgprot |= ARM_SMMU_PTE_SH_IS;
+
+	return pgprot;
+}
+
+static int arm_smmu_alloc_pgtable(struct arm_smmu_device *smmu,
+					 pmd_t *pmd)
+{
+	pgtable_t table;
+	/* Allocate a new set of tables */
+	table = alloc_page(GFP_ATOMIC|__GFP_ZERO);
+	if (!table)
+		return -ENOMEM;
+
+	arm_smmu_flush_pgtable(smmu, page_address(table), PAGE_SIZE);
+	if (!pgtable_page_ctor(table)) {
+		__free_page(table);
+		return -ENOMEM;
+	}
+	pmd_populate(NULL, pmd, table);
+	arm_smmu_flush_pgtable(smmu, pmd, sizeof(*pmd));
+
+	return 0;
+}
+
+static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
+				   unsigned long addr, unsigned long size,
+				   unsigned long pfn, int prot, int stage)
+{
+	pte_t *pte, *start;
+	pteval_t pteval;
+	unsigned long end;
 
-	pteval |= ARM_SMMU_PTE_SH_IS;
+	if (pmd_none(*pmd)) {
+		/* Allocate a new set of tables */
+		int ret = arm_smmu_alloc_pgtable(smmu, pmd);
+		if (ret)
+			return ret;
+	}
+
+
+	pteval = arm_smmu_page_prot(prot, stage, ARM_SMMU_PTE_PAGE);
 	start = pmd_page_vaddr(*pmd) + pte_index(addr);
 	pte = start;
+	end = addr + size;
 
 	/*
 	 * Install the page table entries. This is fairly complicated
 	 * since we attempt to make use of the contiguous hint in the
 	 * ptes where possible. The contiguous hint indicates a series
-	 * of ARM_SMMU_PTE_CONT_ENTRIES ptes mapping a physically
+	 * of ARM_SMMU_PGTBL_CONT_ENTRIES ptes mapping a physically
 	 * contiguous region with the following constraints:
 	 *
 	 *   - The region start is aligned to ARM_SMMU_PTE_CONT_SIZE
@@ -1352,7 +1399,7 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 		pteval &= ~ARM_SMMU_PTE_CONT;
 
 		if (arm_smmu_pte_is_contiguous_range(addr, end)) {
-			i = ARM_SMMU_PTE_CONT_ENTRIES;
+			i = ARM_SMMU_PGTBL_CONT_ENTRIES;
 			pteval |= ARM_SMMU_PTE_CONT;
 		} else if (pte_val(*pte) &
 			   (ARM_SMMU_PTE_CONT | ARM_SMMU_PTE_PAGE)) {
@@ -1360,15 +1407,15 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 			pte_t *cont_start;
 			unsigned long idx = pte_index(addr);
 
-			idx &= ~(ARM_SMMU_PTE_CONT_ENTRIES - 1);
+			idx &= ~(ARM_SMMU_PGTBL_CONT_ENTRIES - 1);
 			cont_start = pmd_page_vaddr(*pmd) + idx;
-			for (j = 0; j < ARM_SMMU_PTE_CONT_ENTRIES; ++j)
+			for (j = 0; j < ARM_SMMU_PGTBL_CONT_ENTRIES; ++j)
 				pte_val(*(cont_start + j)) &=
 					~ARM_SMMU_PTE_CONT;
 
 			arm_smmu_flush_pgtable(smmu, cont_start,
 					       sizeof(*pte) *
-					       ARM_SMMU_PTE_CONT_ENTRIES);
+					       ARM_SMMU_PGTBL_CONT_ENTRIES);
 		}
 
 		do {
@@ -1380,13 +1427,73 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 	return 0;
 }
 
+static void arm_smmu_clear_contiguous_pmd_mapping(struct arm_smmu_device *smmu, pmd_t *pmd)
+{
+	unsigned long idx;
+	pmd_t *pmd_base;
+	int i;
+
+	idx = (unsigned long)pmd & (PAGE_SIZE - 1);
+	idx &= ~(ARM_SMMU_PGTBL_CONT_ENTRIES - 1);
+	pmd_base = (pmd_t *)((unsigned long)pmd & ~(PAGE_SIZE - 1));
+	for (i = 0; i < ARM_SMMU_PGTBL_CONT_ENTRIES; i++)
+		pmd_val(pmd_base[idx + i]) &= ~ARM_SMMU_PTE_CONT;
+
+	arm_smmu_flush_pgtable(smmu, &pmd_base[idx],
+			       sizeof(*pmd) * ARM_SMMU_PGTBL_CONT_ENTRIES);
+}
+
+static int arm_smmu_split_pmd(struct arm_smmu_device *smmu, pmd_t *pmd)
+{
+	pte_t *pgtable;
+	pmdval_t pteval;
+	unsigned long pfn;
+	unsigned int i;
+	int ret;
+
+	pfn = pmd_pfn(*pmd);
+	/* extract the page  attributes */
+	pteval = pmd_val(*pmd) & ~(__pfn_to_phys(pfn));
+	if (pteval & ARM_SMMU_PTE_CONT)
+		arm_smmu_clear_contiguous_pmd_mapping(smmu, pmd);
+
+	ret = arm_smmu_alloc_pgtable(smmu, pmd);
+	if (ret)
+		return ret;
+
+	pgtable = pmd_page_vaddr(*pmd);
+
+	/* Mark the entries as contiguous */
+	for (i = 0; i < PTRS_PER_PTE; i++)
+		pgtable[i] = pfn_pte(pfn++, pteval | ARM_SMMU_PTE_CONT);
+
+	arm_smmu_flush_pgtable(smmu, pgtable, PAGE_SIZE);
+
+	return 0;
+}
+
+static void arm_smmu_set_contiguous_pmd_mapping(struct arm_smmu_device *smmu, pmd_t *pmd,
+					    pmdval_t pmdval, phys_addr_t phys)
+{
+	int i;
+
+	pmdval |= ARM_SMMU_PTE_CONT;
+
+	for (i = 0; i < ARM_SMMU_PGTBL_CONT_ENTRIES; i++) {
+		*pmd = pfn_pmd(__phys_to_pfn(phys), __pgprot(pmdval));
+		arm_smmu_flush_pgtable(smmu, pmd, sizeof(*pmd));
+		pmd++;
+		phys += PMD_SIZE;
+	}
+}
+
 static int arm_smmu_alloc_init_pmd(struct arm_smmu_device *smmu, pud_t *pud,
-				   unsigned long addr, unsigned long end,
+				   unsigned long addr, size_t size,
 				   phys_addr_t phys, int prot, int stage)
 {
-	int ret;
+	int ret = 0;
 	pmd_t *pmd;
-	unsigned long next, pfn = __phys_to_pfn(phys);
+	unsigned long pfn = __phys_to_pfn(phys);
 
 #ifndef __PAGETABLE_PMD_FOLDED
 	if (pud_none(*pud)) {
@@ -1403,24 +1510,98 @@ static int arm_smmu_alloc_init_pmd(struct arm_smmu_device *smmu, pud_t *pud,
 #endif
 		pmd = pmd_offset(pud, addr);
 
-	do {
-		next = pmd_addr_end(addr, end);
-		ret = arm_smmu_alloc_init_pte(smmu, pmd, addr, next, pfn,
-					      prot, stage);
-		phys += next - addr;
-		pfn = __phys_to_pfn(phys);
-	} while (pmd++, addr = next, addr < end);
+		if (size == PMD_SIZE || size == ARM_SMMU_PMD_CONT_SIZE) {
+			pmdval_t pmdval = arm_smmu_page_prot(prot, stage,
+							     PMD_TYPE_SECT);
+
+			if (size != ARM_SMMU_PMD_CONT_SIZE) {
+				*pmd = pfn_pmd(pfn, __pgprot(pmdval));
+				arm_smmu_flush_pgtable(smmu, pmd, sizeof(*pmd));
+			} else if (arm_smmu_pmd_is_contiguous_range(addr,
+								 addr + size))
+				arm_smmu_set_contiguous_pmd_mapping(smmu,
+								    pmd,
+							            pmdval,
+								    phys);
+			else
+				ret = -EINVAL;
+			return ret;
+		} else if (pmd_sect(*pmd)) {
+			ret = arm_smmu_split_pmd(smmu, pmd);
+		}
 
+		if (!ret)
+			ret = arm_smmu_alloc_init_pte(smmu, pmd, addr,
+						     size, pfn,
+						     prot, stage);
 	return ret;
 }
 
+static void arm_smmu_clear_contiguous_pud_mapping(struct arm_smmu_device *smmu, pud_t *pud)
+{
+	unsigned long idx;
+	pud_t *pud_base;
+	int i;
+
+	idx = (unsigned long)pud & (PAGE_SIZE -1);
+	idx &= ~(ARM_SMMU_PGTBL_CONT_ENTRIES - 1);
+	pud_base = (pud_t  *)((unsigned long)pud & ~(PAGE_SIZE - 1));
+	for (i = 0; i < ARM_SMMU_PGTBL_CONT_ENTRIES; i++)
+		pud_val(pud_base[idx + i]) &= ~ARM_SMMU_PTE_CONT;
+
+	arm_smmu_flush_pgtable(smmu, &pud_base[idx],
+			       sizeof(*pud) * ARM_SMMU_PGTBL_CONT_ENTRIES);
+}
+
+static int arm_smmu_split_pud(struct arm_smmu_device *smmu, pud_t *pud)
+{
+	pmd_t *pmd;
+	pmdval_t pmdval;
+	unsigned long pfn;
+	unsigned int i;
+
+	pmd = (pmd_t *)get_zeroed_page(GFP_ATOMIC);
+	if (!pmd)
+		return -ENOMEM;
+
+	pfn = ((pud_val(*pud) & PUD_MASK) & PHYS_MASK) >> PAGE_SHIFT;
+	pmdval = pud_val(*pud) & ~(pfn << PAGE_SHIFT);
+	if (pmdval & ARM_SMMU_PTE_CONT)
+		arm_smmu_clear_contiguous_pud_mapping(smmu, pud);
+
+	for (i = 0; i < PTRS_PER_PMD; i++) {
+		pmd[i] = pfn_pmd(pfn, pmdval | ARM_SMMU_PTE_CONT);
+		pfn += (PMD_SIZE >> PAGE_SHIFT);
+	}
+
+	arm_smmu_flush_pgtable(smmu, pmd, PAGE_SIZE);
+	pud_populate(NULL, pud, pmd);
+	arm_smmu_flush_pgtable(smmu, pud, sizeof(*pud));
+
+	return 0;
+}
+
+static void arm_smmu_set_contiguous_pud_mapping(struct arm_smmu_device *smmu, pud_t *pud,
+					    pmdval_t pmdval, phys_addr_t phys)
+{
+	int i;
+
+	pmdval |= ARM_SMMU_PTE_CONT;
+
+	for (i = 0; i < ARM_SMMU_PGTBL_CONT_ENTRIES; i++) {
+		*pud = (pud_t){((phys) | pgprot_val(__pgprot(pmdval)))};
+		arm_smmu_flush_pgtable(smmu, pud, sizeof(*pud));
+		pud++;
+		phys+= PUD_SIZE;
+	}
+}
+
 static int arm_smmu_alloc_init_pud(struct arm_smmu_device *smmu, pgd_t *pgd,
-				   unsigned long addr, unsigned long end,
+				   unsigned long addr, size_t size,
 				   phys_addr_t phys, int prot, int stage)
 {
 	int ret = 0;
 	pud_t *pud;
-	unsigned long next;
 
 #ifndef __PAGETABLE_PUD_FOLDED
 	if (pgd_none(*pgd)) {
@@ -1437,12 +1618,29 @@ static int arm_smmu_alloc_init_pud(struct arm_smmu_device *smmu, pgd_t *pgd,
 #endif
 		pud = pud_offset(pgd, addr);
 
-	do {
-		next = pud_addr_end(addr, end);
-		ret = arm_smmu_alloc_init_pmd(smmu, pud, addr, next, phys,
-					      prot, stage);
-		phys += next - addr;
-	} while (pud++, addr = next, addr < end);
+	if (size == PUD_SIZE || size == ARM_SMMU_PUD_CONT_SIZE) {
+		pmdval_t pmdval = arm_smmu_page_prot(prot, stage,
+						     PMD_TYPE_SECT);
+
+		if (size != ARM_SMMU_PUD_CONT_SIZE) {
+			*pud = (pud_t){((phys) | pgprot_val(__pgprot(pmdval)))};
+			arm_smmu_flush_pgtable(smmu, pud, sizeof(*pud));
+		} else if (arm_smmu_pud_is_contiguous_range(addr, addr + size))
+			arm_smmu_set_contiguous_pud_mapping(smmu, pud,
+							    pmdval, phys);
+		else
+			ret = -EINVAL;
+
+		return ret;
+
+	} else if ((pud_val(*pud) & PMD_TYPE_MASK) == PMD_TYPE_SECT) {
+		ret = arm_smmu_split_pud(smmu, pud);
+
+	}
+
+	if (!ret)
+		ret = arm_smmu_alloc_init_pmd(smmu, pud, addr, size,
+					      phys, prot, stage);
 
 	return ret;
 }
@@ -1452,7 +1650,6 @@ static int arm_smmu_handle_mapping(struct arm_smmu_domain *smmu_domain,
 				   size_t size, int prot)
 {
 	int ret, stage;
-	unsigned long end;
 	phys_addr_t input_mask, output_mask;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
@@ -1483,20 +1680,11 @@ static int arm_smmu_handle_mapping(struct arm_smmu_domain *smmu_domain,
 
 	spin_lock_irqsave(&smmu_domain->lock, flags);
 	pgd += pgd_index(iova);
-	end = iova + size;
-	do {
-		unsigned long next = pgd_addr_end(iova, end);
 
-		ret = arm_smmu_alloc_init_pud(smmu, pgd, iova, next, paddr,
-					      prot, stage);
-		if (ret)
-			goto out_unlock;
 
-		paddr += next - iova;
-		iova = next;
-	} while (pgd++, iova != end);
+	ret = arm_smmu_alloc_init_pud(smmu, pgd, iova, size, paddr,
+					      prot, stage);
 
-out_unlock:
 	spin_unlock_irqrestore(&smmu_domain->lock, flags);
 
 	return ret;
@@ -1655,8 +1843,10 @@ static const struct iommu_ops arm_smmu_ops = {
 	.iova_to_phys	= arm_smmu_iova_to_phys,
 	.add_device	= arm_smmu_add_device,
 	.remove_device	= arm_smmu_remove_device,
-	.pgsize_bitmap	= (SECTION_SIZE |
+	.pgsize_bitmap	= (SECTION_SIZE | PUD_SIZE |
 			   ARM_SMMU_PTE_CONT_SIZE |
+			   ARM_SMMU_PMD_CONT_SIZE |
+			   ARM_SMMU_PUD_CONT_SIZE |
 			   PAGE_SIZE),
 };
 
-- 
1.7.9.5
