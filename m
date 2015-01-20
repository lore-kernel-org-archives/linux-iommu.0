From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH v2] iommu/ipmmu-vmsa: Use the ARM LPAE page table allocator
Date: Tue, 20 Jan 2015 18:30:04 +0200
Message-ID: <1421771404-22774-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <20150119140106.GM6343@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150119140106.GM6343-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

Replace the custom page table allocation implementation with the
standard allocator.

The driver loses the ability to map 64kB chunkgs using the PTE
contiguous hint, hence the removal of the SZ_64K page size from the
IOMMU page sizes bitmap.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 drivers/iommu/Kconfig      |   1 +
 drivers/iommu/ipmmu-vmsa.c | 554 +++++----------------------------------------
 2 files changed, 61 insertions(+), 494 deletions(-)

This patch depends on Will Deacon's "[PATCH v2 0/5] Generic IOMMU page table
framework" series.

Joerg, if you want to merge Will's patches in v3.20 with one user, this is a
good candidate.

Changes since v1:

- Rebased on top of latest page table framework and iommu next branch.

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 2e1e19a7f33e..c68c8db0e6f7 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -317,6 +317,7 @@ config IPMMU_VMSA
 	depends on ARM_LPAE
 	depends on ARCH_SHMOBILE || COMPILE_TEST
 	select IOMMU_API
+	select IOMMU_IO_PGTABLE_LPAE
 	select ARM_DMA_USE_IOMMU
 	help
 	  Support for the Renesas VMSA-compatible IPMMU Renesas found in the
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 791c3daec7c0..3d7e7325a1e5 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -24,6 +24,8 @@
 #include <asm/dma-iommu.h>
 #include <asm/pgalloc.h>
 
+#include "io-pgtable.h"
+
 struct ipmmu_vmsa_device {
 	struct device *dev;
 	void __iomem *base;
@@ -38,9 +40,11 @@ struct ipmmu_vmsa_domain {
 	struct ipmmu_vmsa_device *mmu;
 	struct iommu_domain *io_domain;
 
+	struct io_pgtable_cfg cfg;
+	struct io_pgtable_ops *iop;
+
 	unsigned int context_id;
 	spinlock_t lock;			/* Protects mappings */
-	pgd_t *pgd;
 };
 
 struct ipmmu_vmsa_archdata {
@@ -173,52 +177,6 @@ static LIST_HEAD(ipmmu_devices);
 #define IMUASID_ASID0_SHIFT		0
 
 /* -----------------------------------------------------------------------------
- * Page Table Bits
- */
-
-/*
- * VMSA states in section B3.6.3 "Control of Secure or Non-secure memory access,
- * Long-descriptor format" that the NStable bit being set in a table descriptor
- * will result in the NStable and NS bits of all child entries being ignored and
- * considered as being set. The IPMMU seems not to comply with this, as it
- * generates a secure access page fault if any of the NStable and NS bits isn't
- * set when running in non-secure mode.
- */
-#ifndef PMD_NSTABLE
-#define PMD_NSTABLE			(_AT(pmdval_t, 1) << 63)
-#endif
-
-#define ARM_VMSA_PTE_XN			(((pteval_t)3) << 53)
-#define ARM_VMSA_PTE_CONT		(((pteval_t)1) << 52)
-#define ARM_VMSA_PTE_AF			(((pteval_t)1) << 10)
-#define ARM_VMSA_PTE_SH_NS		(((pteval_t)0) << 8)
-#define ARM_VMSA_PTE_SH_OS		(((pteval_t)2) << 8)
-#define ARM_VMSA_PTE_SH_IS		(((pteval_t)3) << 8)
-#define ARM_VMSA_PTE_SH_MASK		(((pteval_t)3) << 8)
-#define ARM_VMSA_PTE_NS			(((pteval_t)1) << 5)
-#define ARM_VMSA_PTE_PAGE		(((pteval_t)3) << 0)
-
-/* Stage-1 PTE */
-#define ARM_VMSA_PTE_nG			(((pteval_t)1) << 11)
-#define ARM_VMSA_PTE_AP_UNPRIV		(((pteval_t)1) << 6)
-#define ARM_VMSA_PTE_AP_RDONLY		(((pteval_t)2) << 6)
-#define ARM_VMSA_PTE_AP_MASK		(((pteval_t)3) << 6)
-#define ARM_VMSA_PTE_ATTRINDX_MASK	(((pteval_t)3) << 2)
-#define ARM_VMSA_PTE_ATTRINDX_SHIFT	2
-
-#define ARM_VMSA_PTE_ATTRS_MASK \
-	(ARM_VMSA_PTE_XN | ARM_VMSA_PTE_CONT | ARM_VMSA_PTE_nG | \
-	 ARM_VMSA_PTE_AF | ARM_VMSA_PTE_SH_MASK | ARM_VMSA_PTE_AP_MASK | \
-	 ARM_VMSA_PTE_NS | ARM_VMSA_PTE_ATTRINDX_MASK)
-
-#define ARM_VMSA_PTE_CONT_ENTRIES	16
-#define ARM_VMSA_PTE_CONT_SIZE		(PAGE_SIZE * ARM_VMSA_PTE_CONT_ENTRIES)
-
-#define IPMMU_PTRS_PER_PTE		512
-#define IPMMU_PTRS_PER_PMD		512
-#define IPMMU_PTRS_PER_PGD		4
-
-/* -----------------------------------------------------------------------------
  * Read/Write Access
  */
 
@@ -307,18 +265,39 @@ static void ipmmu_utlb_disable(struct ipmmu_vmsa_domain *domain,
 	ipmmu_write(mmu, IMUCTR(utlb), 0);
 }
 
-static void ipmmu_flush_pgtable(struct ipmmu_vmsa_device *mmu, void *addr,
-				size_t size)
+static void ipmmu_tlb_flush_all(void *cookie)
 {
-	unsigned long offset = (unsigned long)addr & ~PAGE_MASK;
+	struct ipmmu_vmsa_domain *domain = cookie;
+
+	ipmmu_tlb_invalidate(domain);
+}
+
+static void ipmmu_tlb_add_flush(unsigned long iova, size_t size, bool leaf,
+				void *cookie)
+{
+	/* The hardware doesn't support selective TLB flush. */
+}
+
+static void ipmmu_flush_pgtable(void *ptr, size_t size, void *cookie)
+{
+	unsigned long offset = (unsigned long)ptr & ~PAGE_MASK;
+	struct ipmmu_vmsa_domain *domain = cookie;
 
 	/*
 	 * TODO: Add support for coherent walk through CCI with DVM and remove
 	 * cache handling.
 	 */
-	dma_map_page(mmu->dev, virt_to_page(addr), offset, size, DMA_TO_DEVICE);
+	dma_map_page(domain->mmu->dev, virt_to_page(ptr), offset, size,
+		     DMA_TO_DEVICE);
 }
 
+static struct iommu_gather_ops ipmmu_gather_ops = {
+	.tlb_flush_all = ipmmu_tlb_flush_all,
+	.tlb_add_flush = ipmmu_tlb_add_flush,
+	.tlb_sync = ipmmu_tlb_flush_all,
+	.flush_pgtable = ipmmu_flush_pgtable,
+};
+
 /* -----------------------------------------------------------------------------
  * Domain/Context Management
  */
@@ -326,7 +305,28 @@ static void ipmmu_flush_pgtable(struct ipmmu_vmsa_device *mmu, void *addr,
 static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
 {
 	phys_addr_t ttbr;
-	u32 reg;
+
+	/*
+	 * Allocate the page table operations.
+	 *
+	 * VMSA states in section B3.6.3 "Control of Secure or Non-secure memory
+	 * access, Long-descriptor format" that the NStable bit being set in a
+	 * table descriptor will result in the NStable and NS bits of all child
+	 * entries being ignored and considered as being set. The IPMMU seems
+	 * not to comply with this, as it generates a secure access page fault
+	 * if any of the NStable and NS bits isn't set when running in
+	 * non-secure mode.
+	 */
+	domain->cfg.quirks = IO_PGTABLE_QUIRK_ARM_NS;
+	domain->cfg.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
+	domain->cfg.ias = 32;
+	domain->cfg.oas = 40;
+	domain->cfg.tlb = &ipmmu_gather_ops;
+
+	domain->iop = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &domain->cfg,
+					   domain);
+	if (!domain->iop)
+		return -EINVAL;
 
 	/*
 	 * TODO: When adding support for multiple contexts, find an unused
@@ -335,9 +335,7 @@ static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
 	domain->context_id = 0;
 
 	/* TTBR0 */
-	ipmmu_flush_pgtable(domain->mmu, domain->pgd,
-			    IPMMU_PTRS_PER_PGD * sizeof(*domain->pgd));
-	ttbr = __pa(domain->pgd);
+	ttbr = domain->cfg.arm_lpae_s1_cfg.ttbr[0];
 	ipmmu_ctx_write(domain, IMTTLBR0, ttbr);
 	ipmmu_ctx_write(domain, IMTTUBR0, ttbr >> 32);
 
@@ -350,15 +348,8 @@ static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
 			IMTTBCR_SH0_INNER_SHAREABLE | IMTTBCR_ORGN0_WB_WA |
 			IMTTBCR_IRGN0_WB_WA | IMTTBCR_SL0_LVL_1);
 
-	/*
-	 * MAIR0
-	 * We need three attributes only, non-cacheable, write-back read/write
-	 * allocate and device memory.
-	 */
-	reg = (IMMAIR_ATTR_NC << IMMAIR_ATTR_SHIFT(IMMAIR_ATTR_IDX_NC))
-	    | (IMMAIR_ATTR_WBRWA << IMMAIR_ATTR_SHIFT(IMMAIR_ATTR_IDX_WBRWA))
-	    | (IMMAIR_ATTR_DEVICE << IMMAIR_ATTR_SHIFT(IMMAIR_ATTR_IDX_DEV));
-	ipmmu_ctx_write(domain, IMMAIR0, reg);
+	/* MAIR0 */
+	ipmmu_ctx_write(domain, IMMAIR0, domain->cfg.arm_lpae_s1_cfg.mair[0]);
 
 	/* IMBUSCR */
 	ipmmu_ctx_write(domain, IMBUSCR,
@@ -463,397 +454,6 @@ static irqreturn_t ipmmu_irq(int irq, void *dev)
 }
 
 /* -----------------------------------------------------------------------------
- * Page Table Management
- */
-
-#define pud_pgtable(pud) pfn_to_page(__phys_to_pfn(pud_val(pud) & PHYS_MASK))
-
-static void ipmmu_free_ptes(pmd_t *pmd)
-{
-	pgtable_t table = pmd_pgtable(*pmd);
-	__free_page(table);
-}
-
-static void ipmmu_free_pmds(pud_t *pud)
-{
-	pmd_t *pmd = pmd_offset(pud, 0);
-	pgtable_t table;
-	unsigned int i;
-
-	for (i = 0; i < IPMMU_PTRS_PER_PMD; ++i) {
-		if (!pmd_table(*pmd))
-			continue;
-
-		ipmmu_free_ptes(pmd);
-		pmd++;
-	}
-
-	table = pud_pgtable(*pud);
-	__free_page(table);
-}
-
-static void ipmmu_free_pgtables(struct ipmmu_vmsa_domain *domain)
-{
-	pgd_t *pgd, *pgd_base = domain->pgd;
-	unsigned int i;
-
-	/*
-	 * Recursively free the page tables for this domain. We don't care about
-	 * speculative TLB filling, because the TLB will be nuked next time this
-	 * context bank is re-allocated and no devices currently map to these
-	 * tables.
-	 */
-	pgd = pgd_base;
-	for (i = 0; i < IPMMU_PTRS_PER_PGD; ++i) {
-		if (pgd_none(*pgd))
-			continue;
-		ipmmu_free_pmds((pud_t *)pgd);
-		pgd++;
-	}
-
-	kfree(pgd_base);
-}
-
-/*
- * We can't use the (pgd|pud|pmd|pte)_populate or the set_(pgd|pud|pmd|pte)
- * functions as they would flush the CPU TLB.
- */
-
-static pte_t *ipmmu_alloc_pte(struct ipmmu_vmsa_device *mmu, pmd_t *pmd,
-			      unsigned long iova)
-{
-	pte_t *pte;
-
-	if (!pmd_none(*pmd))
-		return pte_offset_kernel(pmd, iova);
-
-	pte = (pte_t *)get_zeroed_page(GFP_ATOMIC);
-	if (!pte)
-		return NULL;
-
-	ipmmu_flush_pgtable(mmu, pte, PAGE_SIZE);
-	*pmd = __pmd(__pa(pte) | PMD_NSTABLE | PMD_TYPE_TABLE);
-	ipmmu_flush_pgtable(mmu, pmd, sizeof(*pmd));
-
-	return pte + pte_index(iova);
-}
-
-static pmd_t *ipmmu_alloc_pmd(struct ipmmu_vmsa_device *mmu, pgd_t *pgd,
-			      unsigned long iova)
-{
-	pud_t *pud = (pud_t *)pgd;
-	pmd_t *pmd;
-
-	if (!pud_none(*pud))
-		return pmd_offset(pud, iova);
-
-	pmd = (pmd_t *)get_zeroed_page(GFP_ATOMIC);
-	if (!pmd)
-		return NULL;
-
-	ipmmu_flush_pgtable(mmu, pmd, PAGE_SIZE);
-	*pud = __pud(__pa(pmd) | PMD_NSTABLE | PMD_TYPE_TABLE);
-	ipmmu_flush_pgtable(mmu, pud, sizeof(*pud));
-
-	return pmd + pmd_index(iova);
-}
-
-static u64 ipmmu_page_prot(unsigned int prot, u64 type)
-{
-	u64 pgprot = ARM_VMSA_PTE_nG | ARM_VMSA_PTE_AF
-		   | ARM_VMSA_PTE_SH_IS | ARM_VMSA_PTE_AP_UNPRIV
-		   | ARM_VMSA_PTE_NS | type;
-
-	if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
-		pgprot |= ARM_VMSA_PTE_AP_RDONLY;
-
-	if (prot & IOMMU_CACHE)
-		pgprot |= IMMAIR_ATTR_IDX_WBRWA << ARM_VMSA_PTE_ATTRINDX_SHIFT;
-
-	if (prot & IOMMU_NOEXEC)
-		pgprot |= ARM_VMSA_PTE_XN;
-	else if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
-		/* If no access create a faulting entry to avoid TLB fills. */
-		pgprot &= ~ARM_VMSA_PTE_PAGE;
-
-	return pgprot;
-}
-
-static int ipmmu_alloc_init_pte(struct ipmmu_vmsa_device *mmu, pmd_t *pmd,
-				unsigned long iova, unsigned long pfn,
-				size_t size, int prot)
-{
-	pteval_t pteval = ipmmu_page_prot(prot, ARM_VMSA_PTE_PAGE);
-	unsigned int num_ptes = 1;
-	pte_t *pte, *start;
-	unsigned int i;
-
-	pte = ipmmu_alloc_pte(mmu, pmd, iova);
-	if (!pte)
-		return -ENOMEM;
-
-	start = pte;
-
-	/*
-	 * Install the page table entries. We can be called both for a single
-	 * page or for a block of 16 physically contiguous pages. In the latter
-	 * case set the PTE contiguous hint.
-	 */
-	if (size == SZ_64K) {
-		pteval |= ARM_VMSA_PTE_CONT;
-		num_ptes = ARM_VMSA_PTE_CONT_ENTRIES;
-	}
-
-	for (i = num_ptes; i; --i)
-		*pte++ = pfn_pte(pfn++, __pgprot(pteval));
-
-	ipmmu_flush_pgtable(mmu, start, sizeof(*pte) * num_ptes);
-
-	return 0;
-}
-
-static int ipmmu_alloc_init_pmd(struct ipmmu_vmsa_device *mmu, pmd_t *pmd,
-				unsigned long iova, unsigned long pfn,
-				int prot)
-{
-	pmdval_t pmdval = ipmmu_page_prot(prot, PMD_TYPE_SECT);
-
-	*pmd = pfn_pmd(pfn, __pgprot(pmdval));
-	ipmmu_flush_pgtable(mmu, pmd, sizeof(*pmd));
-
-	return 0;
-}
-
-static int ipmmu_create_mapping(struct ipmmu_vmsa_domain *domain,
-				unsigned long iova, phys_addr_t paddr,
-				size_t size, int prot)
-{
-	struct ipmmu_vmsa_device *mmu = domain->mmu;
-	pgd_t *pgd = domain->pgd;
-	unsigned long flags;
-	unsigned long pfn;
-	pmd_t *pmd;
-	int ret;
-
-	if (!pgd)
-		return -EINVAL;
-
-	if (size & ~PAGE_MASK)
-		return -EINVAL;
-
-	if (paddr & ~((1ULL << 40) - 1))
-		return -ERANGE;
-
-	pfn = __phys_to_pfn(paddr);
-	pgd += pgd_index(iova);
-
-	/* Update the page tables. */
-	spin_lock_irqsave(&domain->lock, flags);
-
-	pmd = ipmmu_alloc_pmd(mmu, pgd, iova);
-	if (!pmd) {
-		ret = -ENOMEM;
-		goto done;
-	}
-
-	switch (size) {
-	case SZ_2M:
-		ret = ipmmu_alloc_init_pmd(mmu, pmd, iova, pfn, prot);
-		break;
-	case SZ_64K:
-	case SZ_4K:
-		ret = ipmmu_alloc_init_pte(mmu, pmd, iova, pfn, size, prot);
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-done:
-	spin_unlock_irqrestore(&domain->lock, flags);
-
-	if (!ret)
-		ipmmu_tlb_invalidate(domain);
-
-	return ret;
-}
-
-static void ipmmu_clear_pud(struct ipmmu_vmsa_device *mmu, pud_t *pud)
-{
-	pgtable_t table = pud_pgtable(*pud);
-
-	/* Clear the PUD. */
-	*pud = __pud(0);
-	ipmmu_flush_pgtable(mmu, pud, sizeof(*pud));
-
-	/* Free the page table. */
-	__free_page(table);
-}
-
-static void ipmmu_clear_pmd(struct ipmmu_vmsa_device *mmu, pud_t *pud,
-			    pmd_t *pmd)
-{
-	pmd_t pmdval = *pmd;
-	unsigned int i;
-
-	/* Clear the PMD. */
-	*pmd = __pmd(0);
-	ipmmu_flush_pgtable(mmu, pmd, sizeof(*pmd));
-
-	/* Free the page table. */
-	if (pmd_table(pmdval)) {
-		pgtable_t table = pmd_pgtable(pmdval);
-
-		__free_page(table);
-	}
-
-	/* Check whether the PUD is still needed. */
-	pmd = pmd_offset(pud, 0);
-	for (i = 0; i < IPMMU_PTRS_PER_PMD; ++i) {
-		if (!pmd_none(pmd[i]))
-			return;
-	}
-
-	/* Clear the parent PUD. */
-	ipmmu_clear_pud(mmu, pud);
-}
-
-static void ipmmu_clear_pte(struct ipmmu_vmsa_device *mmu, pud_t *pud,
-			    pmd_t *pmd, pte_t *pte, unsigned int num_ptes)
-{
-	unsigned int i;
-
-	/* Clear the PTE. */
-	for (i = num_ptes; i; --i)
-		pte[i-1] = __pte(0);
-
-	ipmmu_flush_pgtable(mmu, pte, sizeof(*pte) * num_ptes);
-
-	/* Check whether the PMD is still needed. */
-	pte = pte_offset_kernel(pmd, 0);
-	for (i = 0; i < IPMMU_PTRS_PER_PTE; ++i) {
-		if (!pte_none(pte[i]))
-			return;
-	}
-
-	/* Clear the parent PMD. */
-	ipmmu_clear_pmd(mmu, pud, pmd);
-}
-
-static int ipmmu_split_pmd(struct ipmmu_vmsa_device *mmu, pmd_t *pmd)
-{
-	pte_t *pte, *start;
-	pteval_t pteval;
-	unsigned long pfn;
-	unsigned int i;
-
-	pte = (pte_t *)get_zeroed_page(GFP_ATOMIC);
-	if (!pte)
-		return -ENOMEM;
-
-	/* Copy the PMD attributes. */
-	pteval = (pmd_val(*pmd) & ARM_VMSA_PTE_ATTRS_MASK)
-	       | ARM_VMSA_PTE_CONT | ARM_VMSA_PTE_PAGE;
-
-	pfn = pmd_pfn(*pmd);
-	start = pte;
-
-	for (i = IPMMU_PTRS_PER_PTE; i; --i)
-		*pte++ = pfn_pte(pfn++, __pgprot(pteval));
-
-	ipmmu_flush_pgtable(mmu, start, PAGE_SIZE);
-	*pmd = __pmd(__pa(start) | PMD_NSTABLE | PMD_TYPE_TABLE);
-	ipmmu_flush_pgtable(mmu, pmd, sizeof(*pmd));
-
-	return 0;
-}
-
-static void ipmmu_split_pte(struct ipmmu_vmsa_device *mmu, pte_t *pte)
-{
-	unsigned int i;
-
-	for (i = ARM_VMSA_PTE_CONT_ENTRIES; i; --i)
-		pte[i-1] = __pte(pte_val(*pte) & ~ARM_VMSA_PTE_CONT);
-
-	ipmmu_flush_pgtable(mmu, pte, sizeof(*pte) * ARM_VMSA_PTE_CONT_ENTRIES);
-}
-
-static int ipmmu_clear_mapping(struct ipmmu_vmsa_domain *domain,
-			       unsigned long iova, size_t size)
-{
-	struct ipmmu_vmsa_device *mmu = domain->mmu;
-	unsigned long flags;
-	pgd_t *pgd = domain->pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-
-	if (!pgd)
-		return -EINVAL;
-
-	if (size & ~PAGE_MASK)
-		return -EINVAL;
-
-	pgd += pgd_index(iova);
-	pud = (pud_t *)pgd;
-
-	spin_lock_irqsave(&domain->lock, flags);
-
-	/* If there's no PUD or PMD we're done. */
-	if (pud_none(*pud))
-		goto done;
-
-	pmd = pmd_offset(pud, iova);
-	if (pmd_none(*pmd))
-		goto done;
-
-	/*
-	 * When freeing a 2MB block just clear the PMD. In the unlikely case the
-	 * block is mapped as individual pages this will free the corresponding
-	 * PTE page table.
-	 */
-	if (size == SZ_2M) {
-		ipmmu_clear_pmd(mmu, pud, pmd);
-		goto done;
-	}
-
-	/*
-	 * If the PMD has been mapped as a section remap it as pages to allow
-	 * freeing individual pages.
-	 */
-	if (pmd_sect(*pmd))
-		ipmmu_split_pmd(mmu, pmd);
-
-	pte = pte_offset_kernel(pmd, iova);
-
-	/*
-	 * When freeing a 64kB block just clear the PTE entries. We don't have
-	 * to care about the contiguous hint of the surrounding entries.
-	 */
-	if (size == SZ_64K) {
-		ipmmu_clear_pte(mmu, pud, pmd, pte, ARM_VMSA_PTE_CONT_ENTRIES);
-		goto done;
-	}
-
-	/*
-	 * If the PTE has been mapped with the contiguous hint set remap it and
-	 * its surrounding PTEs to allow unmapping a single page.
-	 */
-	if (pte_val(*pte) & ARM_VMSA_PTE_CONT)
-		ipmmu_split_pte(mmu, pte);
-
-	/* Clear the PTE. */
-	ipmmu_clear_pte(mmu, pud, pmd, pte, 1);
-
-done:
-	spin_unlock_irqrestore(&domain->lock, flags);
-
-	ipmmu_tlb_invalidate(domain);
-
-	return 0;
-}
-
-/* -----------------------------------------------------------------------------
  * IOMMU Operations
  */
 
@@ -867,12 +467,6 @@ static int ipmmu_domain_init(struct iommu_domain *io_domain)
 
 	spin_lock_init(&domain->lock);
 
-	domain->pgd = kzalloc(IPMMU_PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL);
-	if (!domain->pgd) {
-		kfree(domain);
-		return -ENOMEM;
-	}
-
 	io_domain->priv = domain;
 	domain->io_domain = io_domain;
 
@@ -888,7 +482,7 @@ static void ipmmu_domain_destroy(struct iommu_domain *io_domain)
 	 * been detached.
 	 */
 	ipmmu_domain_destroy_context(domain);
-	ipmmu_free_pgtables(domain);
+	free_io_pgtable_ops(domain->iop);
 	kfree(domain);
 }
 
@@ -957,53 +551,25 @@ static int ipmmu_map(struct iommu_domain *io_domain, unsigned long iova,
 	if (!domain)
 		return -ENODEV;
 
-	return ipmmu_create_mapping(domain, iova, paddr, size, prot);
+	return domain->iop->map(domain->iop, iova, paddr, size, prot);
 }
 
 static size_t ipmmu_unmap(struct iommu_domain *io_domain, unsigned long iova,
 			  size_t size)
 {
 	struct ipmmu_vmsa_domain *domain = io_domain->priv;
-	int ret;
 
-	ret = ipmmu_clear_mapping(domain, iova, size);
-	return ret ? 0 : size;
+	return domain->iop->unmap(domain->iop, iova, size);
 }
 
 static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
 				      dma_addr_t iova)
 {
 	struct ipmmu_vmsa_domain *domain = io_domain->priv;
-	pgd_t pgd;
-	pud_t pud;
-	pmd_t pmd;
-	pte_t pte;
 
 	/* TODO: Is locking needed ? */
 
-	if (!domain->pgd)
-		return 0;
-
-	pgd = *(domain->pgd + pgd_index(iova));
-	if (pgd_none(pgd))
-		return 0;
-
-	pud = *pud_offset(&pgd, iova);
-	if (pud_none(pud))
-		return 0;
-
-	pmd = *pmd_offset(&pud, iova);
-	if (pmd_none(pmd))
-		return 0;
-
-	if (pmd_sect(pmd))
-		return __pfn_to_phys(pmd_pfn(pmd)) | (iova & ~PMD_MASK);
-
-	pte = *(pmd_page_vaddr(pmd) + pte_index(iova));
-	if (pte_none(pte))
-		return 0;
-
-	return __pfn_to_phys(pte_pfn(pte)) | (iova & ~PAGE_MASK);
+	return domain->iop->iova_to_phys(domain->iop, iova);
 }
 
 static int ipmmu_find_utlbs(struct ipmmu_vmsa_device *mmu, struct device *dev,
@@ -1188,7 +754,7 @@ static const struct iommu_ops ipmmu_ops = {
 	.iova_to_phys = ipmmu_iova_to_phys,
 	.add_device = ipmmu_add_device,
 	.remove_device = ipmmu_remove_device,
-	.pgsize_bitmap = SZ_2M | SZ_64K | SZ_4K,
+	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
 };
 
 /* -----------------------------------------------------------------------------
-- 
Regards,

Laurent Pinchart
