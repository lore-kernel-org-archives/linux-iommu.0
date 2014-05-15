From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 06/10] iommu/ipmmu-vmsa: PMD is never folded, PUD always is
Date: Thu, 15 May 2014 12:40:47 +0200
Message-ID: <1400150451-13469-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1400150451-13469-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1400150451-13469-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

The driver only supports the 3-level long descriptor format that has no
PUD and always has a PMD.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/ipmmu-vmsa.c | 66 +++++++---------------------------------------
 1 file changed, 9 insertions(+), 57 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 150e18e..d388749 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -215,7 +215,6 @@ static LIST_HEAD(ipmmu_devices);
 #define IPMMU_PTRS_PER_PTE		512
 #define IPMMU_PTRS_PER_PMD		512
 #define IPMMU_PTRS_PER_PGD		4
-#define IPMMU_PTRS_PER_PUD		1
 
 /* -----------------------------------------------------------------------------
  * Read/Write Access
@@ -465,6 +464,8 @@ static irqreturn_t ipmmu_irq(int irq, void *dev)
  * Page Table Management
  */
 
+#define pud_pgtable(pud) pfn_to_page(__phys_to_pfn(pud_val(pud) & PHYS_MASK))
+
 static void ipmmu_free_ptes(pmd_t *pmd)
 {
 	pgtable_t table = pmd_pgtable(*pmd);
@@ -473,10 +474,10 @@ static void ipmmu_free_ptes(pmd_t *pmd)
 
 static void ipmmu_free_pmds(pud_t *pud)
 {
-	pmd_t *pmd, *pmd_base = pmd_offset(pud, 0);
+	pmd_t *pmd = pmd_offset(pud, 0);
+	pgtable_t table;
 	unsigned int i;
 
-	pmd = pmd_base;
 	for (i = 0; i < IPMMU_PTRS_PER_PMD; ++i) {
 		if (pmd_none(*pmd))
 			continue;
@@ -485,24 +486,8 @@ static void ipmmu_free_pmds(pud_t *pud)
 		pmd++;
 	}
 
-	pmd_free(NULL, pmd_base);
-}
-
-static void ipmmu_free_puds(pgd_t *pgd)
-{
-	pud_t *pud, *pud_base = pud_offset(pgd, 0);
-	unsigned int i;
-
-	pud = pud_base;
-	for (i = 0; i < IPMMU_PTRS_PER_PUD; ++i) {
-		if (pud_none(*pud))
-			continue;
-
-		ipmmu_free_pmds(pud);
-		pud++;
-	}
-
-	pud_free(NULL, pud_base);
+	table = pud_pgtable(*pud);
+	__free_page(table);
 }
 
 static void ipmmu_free_pgtables(struct ipmmu_vmsa_domain *domain)
@@ -520,7 +505,7 @@ static void ipmmu_free_pgtables(struct ipmmu_vmsa_domain *domain)
 	for (i = 0; i < IPMMU_PTRS_PER_PGD; ++i) {
 		if (pgd_none(*pgd))
 			continue;
-		ipmmu_free_puds(pgd);
+		ipmmu_free_pmds((pud_t *)pgd);
 		pgd++;
 	}
 
@@ -624,7 +609,6 @@ static int ipmmu_alloc_init_pmd(struct ipmmu_vmsa_device *mmu, pud_t *pud,
 	pmd_t *pmd;
 	int ret;
 
-#ifndef __PAGETABLE_PMD_FOLDED
 	if (pud_none(*pud)) {
 		pmd = (pmd_t *)get_zeroed_page(GFP_ATOMIC);
 		if (!pmd)
@@ -636,7 +620,6 @@ static int ipmmu_alloc_init_pmd(struct ipmmu_vmsa_device *mmu, pud_t *pud,
 
 		pmd += pmd_index(addr);
 	} else
-#endif
 		pmd = pmd_offset(pud, addr);
 
 	do {
@@ -648,38 +631,6 @@ static int ipmmu_alloc_init_pmd(struct ipmmu_vmsa_device *mmu, pud_t *pud,
 	return ret;
 }
 
-static int ipmmu_alloc_init_pud(struct ipmmu_vmsa_device *mmu, pgd_t *pgd,
-				unsigned long addr, unsigned long end,
-				phys_addr_t phys, int prot)
-{
-	unsigned long next;
-	pud_t *pud;
-	int ret;
-
-#ifndef __PAGETABLE_PUD_FOLDED
-	if (pgd_none(*pgd)) {
-		pud = (pud_t *)get_zeroed_page(GFP_ATOMIC);
-		if (!pud)
-			return -ENOMEM;
-
-		ipmmu_flush_pgtable(mmu, pud, PAGE_SIZE);
-		*pgd = __pgd(__pa(pud) | PMD_NSTABLE | PMD_TYPE_TABLE);
-		ipmmu_flush_pgtable(mmu, pgd, sizeof(*pgd));
-
-		pud += pud_index(addr);
-	} else
-#endif
-		pud = pud_offset(pgd, addr);
-
-	do {
-		next = pud_addr_end(addr, end);
-		ret = ipmmu_alloc_init_pmd(mmu, pud, addr, next, phys, prot);
-		phys += next - addr;
-	} while (pud++, addr = next, addr < end);
-
-	return ret;
-}
-
 static int ipmmu_handle_mapping(struct ipmmu_vmsa_domain *domain,
 				unsigned long iova, phys_addr_t paddr,
 				size_t size, int prot)
@@ -707,7 +658,8 @@ static int ipmmu_handle_mapping(struct ipmmu_vmsa_domain *domain,
 	do {
 		unsigned long next = pgd_addr_end(iova, end);
 
-		ret = ipmmu_alloc_init_pud(mmu, pgd, iova, next, paddr, prot);
+		ret = ipmmu_alloc_init_pmd(mmu, (pud_t *)pgd, iova, next, paddr,
+					   prot);
 		if (ret)
 			break;
 
-- 
1.8.5.5

