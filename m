From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 10/10] iommu/ipmmu-vmsa: Support clearing mappings
Date: Thu, 15 May 2014 12:40:51 +0200
Message-ID: <1400150451-13469-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1400150451-13469-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1400150451-13469-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/ipmmu-vmsa.c | 190 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 186 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index a4175d3..c003fae 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -192,14 +192,22 @@ static LIST_HEAD(ipmmu_devices);
 #define ARM_VMSA_PTE_SH_NS		(((pteval_t)0) << 8)
 #define ARM_VMSA_PTE_SH_OS		(((pteval_t)2) << 8)
 #define ARM_VMSA_PTE_SH_IS		(((pteval_t)3) << 8)
+#define ARM_VMSA_PTE_SH_MASK		(((pteval_t)3) << 8)
 #define ARM_VMSA_PTE_NS			(((pteval_t)1) << 5)
 #define ARM_VMSA_PTE_PAGE		(((pteval_t)3) << 0)
 
 /* Stage-1 PTE */
+#define ARM_VMSA_PTE_nG			(((pteval_t)1) << 11)
 #define ARM_VMSA_PTE_AP_UNPRIV		(((pteval_t)1) << 6)
 #define ARM_VMSA_PTE_AP_RDONLY		(((pteval_t)2) << 6)
+#define ARM_VMSA_PTE_AP_MASK		(((pteval_t)3) << 6)
+#define ARM_VMSA_PTE_ATTRINDX_MASK	(((pteval_t)3) << 2)
 #define ARM_VMSA_PTE_ATTRINDX_SHIFT	2
-#define ARM_VMSA_PTE_nG			(((pteval_t)1) << 11)
+
+#define ARM_VMSA_PTE_ATTRS_MASK \
+	(ARM_VMSA_PTE_XN | ARM_VMSA_PTE_CONT | ARM_VMSA_PTE_nG | \
+	 ARM_VMSA_PTE_AF | ARM_VMSA_PTE_SH_MASK | ARM_VMSA_PTE_AP_MASK | \
+	 ARM_VMSA_PTE_NS | ARM_VMSA_PTE_ATTRINDX_MASK)
 
 #define ARM_VMSA_PTE_CONT_ENTRIES	16
 #define ARM_VMSA_PTE_CONT_SIZE		(PAGE_SIZE * ARM_VMSA_PTE_CONT_ENTRIES)
@@ -614,7 +622,7 @@ static int ipmmu_alloc_init_pmd(struct ipmmu_vmsa_device *mmu, pmd_t *pmd,
 	return 0;
 }
 
-static int ipmmu_handle_mapping(struct ipmmu_vmsa_domain *domain,
+static int ipmmu_create_mapping(struct ipmmu_vmsa_domain *domain,
 				unsigned long iova, phys_addr_t paddr,
 				size_t size, int prot)
 {
@@ -668,6 +676,180 @@ done:
 	return ret;
 }
 
+static void ipmmu_clear_pud(struct ipmmu_vmsa_device *mmu, pud_t *pud)
+{
+	/* Free the page table. */
+	pgtable_t table = pud_pgtable(*pud);
+	__free_page(table);
+
+	/* Clear the PUD. */
+	*pud = __pud(0);
+	ipmmu_flush_pgtable(mmu, pud, sizeof(*pud));
+}
+
+static void ipmmu_clear_pmd(struct ipmmu_vmsa_device *mmu, pud_t *pud,
+			    pmd_t *pmd)
+{
+	unsigned int i;
+
+	/* Free the page table. */
+	if (pmd_table(*pmd)) {
+		pgtable_t table = pmd_pgtable(*pmd);
+		__free_page(table);
+	}
+
+	/* Clear the PMD. */
+	*pmd = __pmd(0);
+	ipmmu_flush_pgtable(mmu, pmd, sizeof(*pmd));
+
+	/* Check whether the PUD is still needed. */
+	pmd = pmd_offset(pud, 0);
+	for (i = 0; i < IPMMU_PTRS_PER_PMD; ++i) {
+		if (!pmd_none(pmd[i]))
+			return;
+	}
+
+	/* Clear the parent PUD. */
+	ipmmu_clear_pud(mmu, pud);
+}
+
+static void ipmmu_clear_pte(struct ipmmu_vmsa_device *mmu, pud_t *pud,
+			    pmd_t *pmd, pte_t *pte, unsigned int num_ptes)
+{
+	unsigned int i;
+
+	/* Clear the PTE. */
+	for (i = num_ptes; i; --i)
+		pte[i-1] = __pte(0);
+
+	ipmmu_flush_pgtable(mmu, pte, sizeof(*pte) * num_ptes);
+
+	/* Check whether the PMD is still needed. */
+	pte = pte_offset_kernel(pmd, 0);
+	for (i = 0; i < IPMMU_PTRS_PER_PTE; ++i) {
+		if (!pte_none(pte[i]))
+			return;
+	}
+
+	/* Clear the parent PMD. */
+	ipmmu_clear_pmd(mmu, pud, pmd);
+}
+
+static int ipmmu_split_pmd(struct ipmmu_vmsa_device *mmu, pmd_t *pmd)
+{
+	pte_t *pte, *start;
+	pteval_t pteval;
+	unsigned long pfn;
+	unsigned int i;
+
+	pte = (pte_t *)get_zeroed_page(GFP_ATOMIC);
+	if (!pte)
+		return -ENOMEM;
+
+	/* Copy the PMD attributes. */
+	pteval = (pmd_val(*pmd) & ARM_VMSA_PTE_ATTRS_MASK)
+	       | ARM_VMSA_PTE_CONT | ARM_VMSA_PTE_PAGE;
+
+	pfn = pmd_pfn(*pmd);
+	start = pte;
+
+	for (i = IPMMU_PTRS_PER_PTE; i; --i)
+		*pte++ = pfn_pte(pfn++, __pgprot(pteval));
+
+	ipmmu_flush_pgtable(mmu, start, PAGE_SIZE);
+	*pmd = __pmd(__pa(start) | PMD_NSTABLE | PMD_TYPE_TABLE);
+	ipmmu_flush_pgtable(mmu, pmd, sizeof(*pmd));
+
+	return 0;
+}
+
+static void ipmmu_split_pte(struct ipmmu_vmsa_device *mmu, pte_t *pte)
+{
+	unsigned int i;
+
+	for (i = ARM_VMSA_PTE_CONT_ENTRIES; i; --i)
+		pte[i-1] = __pte(pte_val(*pte) & ~ARM_VMSA_PTE_CONT);
+
+	ipmmu_flush_pgtable(mmu, pte, sizeof(*pte) * ARM_VMSA_PTE_CONT_ENTRIES);
+}
+
+static int ipmmu_clear_mapping(struct ipmmu_vmsa_domain *domain,
+			       unsigned long iova, size_t size)
+{
+	struct ipmmu_vmsa_device *mmu = domain->mmu;
+	unsigned long flags;
+	pgd_t *pgd = domain->pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	int ret = 0;
+
+	if (!pgd)
+		return -EINVAL;
+
+	if (size & ~PAGE_MASK)
+		return -EINVAL;
+
+	pgd += pgd_index(iova);
+	pud = (pud_t *)pgd;
+
+	spin_lock_irqsave(&domain->lock, flags);
+
+	/* If there's no PUD or PMD we're done. */
+	if (pud_none(*pud))
+		goto done;
+
+	pmd = pmd_offset(pud, iova);
+	if (pmd_none(*pmd))
+		goto done;
+
+	/*
+	 * When freeing a 2MB block just clear the PMD. In the unlikely case the
+	 * block is mapped as individual pages this will free the corresponding
+	 * PTE page table.
+	 */
+	if (size == SZ_2M) {
+		ipmmu_clear_pmd(mmu, pud, pmd);
+		goto done;
+	}
+
+	/*
+	 * If the PMD has been mapped as a section remap it as pages to allow
+	 * freeing individual pages.
+	 */
+	if (pmd_sect(*pmd))
+		ipmmu_split_pmd(mmu, pmd);
+
+	pte = pte_offset_kernel(pmd, iova);
+
+	/*
+	 * When freeing a 64kB block just clear the PTE entries. We don't have
+	 * to care about the contiguous hint of the surrounding entries.
+	 */
+	if (size == SZ_64K) {
+		ipmmu_clear_pte(mmu, pud, pmd, pte, ARM_VMSA_PTE_CONT_ENTRIES);
+		goto done;
+	}
+
+	/*
+	 * If the PTE has been mapped with the contiguous hint set remap it and
+	 * its surrounding PTEs to allow unmapping a single page.
+	 */
+	if (pte_val(*pte) & ARM_VMSA_PTE_CONT)
+		ipmmu_split_pte(mmu, pte);
+
+	/* Clear the PTE. */
+	ipmmu_clear_pte(mmu, pud, pmd, pte, 1);
+
+done:
+	spin_unlock_irqrestore(&domain->lock, flags);
+
+	if (ret)
+		ipmmu_tlb_invalidate(domain);
+
+	return 0;
+}
+
 /* -----------------------------------------------------------------------------
  * IOMMU Operations
  */
@@ -768,7 +950,7 @@ static int ipmmu_map(struct iommu_domain *io_domain, unsigned long iova,
 	if (!domain)
 		return -ENODEV;
 
-	return ipmmu_handle_mapping(domain, iova, paddr, size, prot);
+	return ipmmu_create_mapping(domain, iova, paddr, size, prot);
 }
 
 static size_t ipmmu_unmap(struct iommu_domain *io_domain, unsigned long iova,
@@ -777,7 +959,7 @@ static size_t ipmmu_unmap(struct iommu_domain *io_domain, unsigned long iova,
 	struct ipmmu_vmsa_domain *domain = io_domain->priv;
 	int ret;
 
-	ret = ipmmu_handle_mapping(domain, iova, 0, size, 0);
+	ret = ipmmu_clear_mapping(domain, iova, size);
 	return ret ? 0 : size;
 }
 
-- 
1.8.5.5

