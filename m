From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 07/10] iommu/ipmmu-vmsa: Rewrite page table management
Date: Thu, 15 May 2014 12:40:48 +0200
Message-ID: <1400150451-13469-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1400150451-13469-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1400150451-13469-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

The IOMMU core will only call us with page sizes advertized as supported
by the driver. We can thus simplify the code by removing loops over PGD
and PMD entries.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/ipmmu-vmsa.c | 193 ++++++++++++++++++++-------------------------
 1 file changed, 86 insertions(+), 107 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index d388749..159e09a 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -517,118 +517,97 @@ static void ipmmu_free_pgtables(struct ipmmu_vmsa_domain *domain)
  * functions as they would flush the CPU TLB.
  */
 
-static int ipmmu_alloc_init_pte(struct ipmmu_vmsa_device *mmu, pmd_t *pmd,
-				unsigned long addr, unsigned long end,
-				phys_addr_t phys, int prot)
+static pte_t *ipmmu_alloc_pte(struct ipmmu_vmsa_device *mmu, pmd_t *pmd,
+			      unsigned long iova)
 {
-	unsigned long pfn = __phys_to_pfn(phys);
-	pteval_t pteval = ARM_VMSA_PTE_PAGE | ARM_VMSA_PTE_NS | ARM_VMSA_PTE_AF
-			| ARM_VMSA_PTE_XN;
-	pte_t *pte, *start;
+	pte_t *pte;
 
-	if (pmd_none(*pmd)) {
-		/* Allocate a new set of tables */
-		pte = (pte_t *)get_zeroed_page(GFP_ATOMIC);
-		if (!pte)
-			return -ENOMEM;
+	if (!pmd_none(*pmd))
+		return pte_offset_kernel(pmd, iova);
 
-		ipmmu_flush_pgtable(mmu, pte, PAGE_SIZE);
-		*pmd = __pmd(__pa(pte) | PMD_NSTABLE | PMD_TYPE_TABLE);
-		ipmmu_flush_pgtable(mmu, pmd, sizeof(*pmd));
+	pte = (pte_t *)get_zeroed_page(GFP_ATOMIC);
+	if (!pte)
+		return NULL;
 
-		pte += pte_index(addr);
-	} else
-		pte = pte_offset_kernel(pmd, addr);
+	ipmmu_flush_pgtable(mmu, pte, PAGE_SIZE);
+	*pmd = __pmd(__pa(pte) | PMD_NSTABLE | PMD_TYPE_TABLE);
+	ipmmu_flush_pgtable(mmu, pmd, sizeof(*pmd));
 
-	pteval |= ARM_VMSA_PTE_AP_UNPRIV | ARM_VMSA_PTE_nG;
-	if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
-		pteval |= ARM_VMSA_PTE_AP_RDONLY;
+	return pte + pte_index(iova);
+}
 
-	if (prot & IOMMU_CACHE)
-		pteval |= (IMMAIR_ATTR_IDX_WBRWA <<
-			   ARM_VMSA_PTE_ATTRINDX_SHIFT);
+static pmd_t *ipmmu_alloc_pmd(struct ipmmu_vmsa_device *mmu, pgd_t *pgd,
+			      unsigned long iova)
+{
+	pud_t *pud = (pud_t *)pgd;
+	pmd_t *pmd;
 
-	/* If no access, create a faulting entry to avoid TLB fills */
-	if (prot & IOMMU_EXEC)
-		pteval &= ~ARM_VMSA_PTE_XN;
-	else if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
-		pteval &= ~ARM_VMSA_PTE_PAGE;
+	if (!pud_none(*pud))
+		return pmd_offset(pud, iova);
 
-	pteval |= ARM_VMSA_PTE_SH_IS;
-	start = pte;
+	pmd = (pmd_t *)get_zeroed_page(GFP_ATOMIC);
+	if (!pmd)
+		return NULL;
 
-	/*
-	 * Install the page table entries.
-	 *
-	 * Set the contiguous hint in the PTEs where possible. The hint
-	 * indicates a series of ARM_VMSA_PTE_CONT_ENTRIES PTEs mapping a
-	 * physically contiguous region with the following constraints:
-	 *
-	 * - The region start is aligned to ARM_VMSA_PTE_CONT_SIZE
-	 * - Each PTE in the region has the contiguous hint bit set
-	 *
-	 * We don't support partial unmapping so there's no need to care about
-	 * clearing the contiguous hint from neighbour PTEs.
-	 */
-	do {
-		unsigned long chunk_end;
+	ipmmu_flush_pgtable(mmu, pmd, PAGE_SIZE);
+	*pud = __pud(__pa(pmd) | PMD_NSTABLE | PMD_TYPE_TABLE);
+	ipmmu_flush_pgtable(mmu, pud, sizeof(*pud));
 
-		/*
-		 * If the address is aligned to a contiguous region size and the
-		 * mapping size is large enough, process the largest possible
-		 * number of PTEs multiple of ARM_VMSA_PTE_CONT_ENTRIES.
-		 * Otherwise process the smallest number of PTEs to align the
-		 * address to a contiguous region size or to complete the
-		 * mapping.
-		 */
-		if (IS_ALIGNED(addr, ARM_VMSA_PTE_CONT_SIZE) &&
-		    end - addr >= ARM_VMSA_PTE_CONT_SIZE) {
-			chunk_end = round_down(end, ARM_VMSA_PTE_CONT_SIZE);
-			pteval |= ARM_VMSA_PTE_CONT;
-		} else {
-			chunk_end = min(ALIGN(addr, ARM_VMSA_PTE_CONT_SIZE),
-					end);
-			pteval &= ~ARM_VMSA_PTE_CONT;
-		}
+	return pmd + pmd_index(iova);
+}
 
-		do {
-			*pte++ = pfn_pte(pfn++, __pgprot(pteval));
-			addr += PAGE_SIZE;
-		} while (addr != chunk_end);
-	} while (addr != end);
+static u64 ipmmu_page_prot(unsigned int prot, u64 type)
+{
+	u64 pgprot = ARM_VMSA_PTE_XN | ARM_VMSA_PTE_nG | ARM_VMSA_PTE_AF
+		   | ARM_VMSA_PTE_SH_IS | ARM_VMSA_PTE_AP_UNPRIV
+		   | ARM_VMSA_PTE_NS | type;
 
-	ipmmu_flush_pgtable(mmu, start, sizeof(*pte) * (pte - start));
-	return 0;
+	if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
+		pgprot |= ARM_VMSA_PTE_AP_RDONLY;
+
+	if (prot & IOMMU_CACHE)
+		pgprot |= IMMAIR_ATTR_IDX_WBRWA << ARM_VMSA_PTE_ATTRINDX_SHIFT;
+
+	if (prot & IOMMU_EXEC)
+		pgprot &= ~ARM_VMSA_PTE_XN;
+	else if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
+		/* If no access create a faulting entry to avoid TLB fills. */
+		pgprot &= ~ARM_VMSA_PTE_PAGE;
+
+	return pgprot;
 }
 
-static int ipmmu_alloc_init_pmd(struct ipmmu_vmsa_device *mmu, pud_t *pud,
-				unsigned long addr, unsigned long end,
-				phys_addr_t phys, int prot)
+static int ipmmu_alloc_init_pte(struct ipmmu_vmsa_device *mmu, pmd_t *pmd,
+				unsigned long iova, unsigned long pfn,
+				size_t size, int prot)
 {
-	unsigned long next;
-	pmd_t *pmd;
-	int ret;
+	pteval_t pteval = ipmmu_page_prot(prot, ARM_VMSA_PTE_PAGE);
+	unsigned int num_ptes = 1;
+	pte_t *pte, *start;
+	unsigned int i;
 
-	if (pud_none(*pud)) {
-		pmd = (pmd_t *)get_zeroed_page(GFP_ATOMIC);
-		if (!pmd)
-			return -ENOMEM;
+	pte = ipmmu_alloc_pte(mmu, pmd, iova);
+	if (!pte)
+		return -ENOMEM;
+
+	start = pte;
 
-		ipmmu_flush_pgtable(mmu, pmd, PAGE_SIZE);
-		*pud = __pud(__pa(pmd) | PMD_NSTABLE | PMD_TYPE_TABLE);
-		ipmmu_flush_pgtable(mmu, pud, sizeof(*pud));
+	/*
+	 * Install the page table entries. We can be called both for a single
+	 * page or for a block of 16 physically contiguous pages. In the latter
+	 * case set the PTE contiguous hint.
+	 */
+	if (size == SZ_64K) {
+		pteval |= ARM_VMSA_PTE_CONT;
+		num_ptes = ARM_VMSA_PTE_CONT_ENTRIES;
+	}
 
-		pmd += pmd_index(addr);
-	} else
-		pmd = pmd_offset(pud, addr);
+	for (i = num_ptes; i; --i)
+		*pte++ = pfn_pte(pfn++, __pgprot(pteval));
 
-	do {
-		next = pmd_addr_end(addr, end);
-		ret = ipmmu_alloc_init_pte(mmu, pmd, addr, end, phys, prot);
-		phys += next - addr;
-	} while (pmd++, addr = next, addr < end);
+	ipmmu_flush_pgtable(mmu, start, sizeof(*pte) * num_ptes);
 
-	return ret;
+	return 0;
 }
 
 static int ipmmu_handle_mapping(struct ipmmu_vmsa_domain *domain,
@@ -638,7 +617,8 @@ static int ipmmu_handle_mapping(struct ipmmu_vmsa_domain *domain,
 	struct ipmmu_vmsa_device *mmu = domain->mmu;
 	pgd_t *pgd = domain->pgd;
 	unsigned long flags;
-	unsigned long end;
+	unsigned long pfn;
+	pmd_t *pmd;
 	int ret;
 
 	if (!pgd)
@@ -650,26 +630,25 @@ static int ipmmu_handle_mapping(struct ipmmu_vmsa_domain *domain,
 	if (paddr & ~((1ULL << 40) - 1))
 		return -ERANGE;
 
-	spin_lock_irqsave(&domain->lock, flags);
-
+	pfn = __phys_to_pfn(paddr);
 	pgd += pgd_index(iova);
-	end = iova + size;
 
-	do {
-		unsigned long next = pgd_addr_end(iova, end);
+	/* Update the page tables. */
+	spin_lock_irqsave(&domain->lock, flags);
 
-		ret = ipmmu_alloc_init_pmd(mmu, (pud_t *)pgd, iova, next, paddr,
-					   prot);
-		if (ret)
-			break;
+	pmd = ipmmu_alloc_pmd(mmu, pgd, iova);
+	if (!pmd) {
+		ret = -ENOMEM;
+		goto done;
+	}
 
-		paddr += next - iova;
-		iova = next;
-	} while (pgd++, iova != end);
+	ret = ipmmu_alloc_init_pte(mmu, pmd, iova, pfn, size, prot);
 
+done:
 	spin_unlock_irqrestore(&domain->lock, flags);
 
-	ipmmu_tlb_invalidate(domain);
+	if (!ret)
+		ipmmu_tlb_invalidate(domain);
 
 	return ret;
 }
@@ -953,7 +932,7 @@ static struct iommu_ops ipmmu_ops = {
 	.iova_to_phys = ipmmu_iova_to_phys,
 	.add_device = ipmmu_add_device,
 	.remove_device = ipmmu_remove_device,
-	.pgsize_bitmap = SZ_2M | SZ_64K | SZ_4K,
+	.pgsize_bitmap = SZ_64K | SZ_4K,
 };
 
 /* -----------------------------------------------------------------------------
-- 
1.8.5.5

