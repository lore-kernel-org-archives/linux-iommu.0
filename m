From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 08/10] iommu/ipmmu-vmsa: Support 2MB mappings
Date: Thu, 15 May 2014 12:40:49 +0200
Message-ID: <1400150451-13469-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1400150451-13469-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1400150451-13469-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Add support for 2MB block mappings at the PMD level.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/ipmmu-vmsa.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 159e09a..27fd4d0 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -479,7 +479,7 @@ static void ipmmu_free_pmds(pud_t *pud)
 	unsigned int i;
 
 	for (i = 0; i < IPMMU_PTRS_PER_PMD; ++i) {
-		if (pmd_none(*pmd))
+		if (!pmd_table(*pmd))
 			continue;
 
 		ipmmu_free_ptes(pmd);
@@ -610,6 +610,18 @@ static int ipmmu_alloc_init_pte(struct ipmmu_vmsa_device *mmu, pmd_t *pmd,
 	return 0;
 }
 
+static int ipmmu_alloc_init_pmd(struct ipmmu_vmsa_device *mmu, pmd_t *pmd,
+				unsigned long iova, unsigned long pfn,
+				int prot)
+{
+	pmdval_t pmdval = ipmmu_page_prot(prot, PMD_TYPE_SECT);
+
+	*pmd = pfn_pmd(pfn, __pgprot(pmdval));
+	ipmmu_flush_pgtable(mmu, pmd, sizeof(*pmd));
+
+	return 0;
+}
+
 static int ipmmu_handle_mapping(struct ipmmu_vmsa_domain *domain,
 				unsigned long iova, phys_addr_t paddr,
 				size_t size, int prot)
@@ -642,7 +654,18 @@ static int ipmmu_handle_mapping(struct ipmmu_vmsa_domain *domain,
 		goto done;
 	}
 
-	ret = ipmmu_alloc_init_pte(mmu, pmd, iova, pfn, size, prot);
+	switch (size) {
+	case SZ_2M:
+		ret = ipmmu_alloc_init_pmd(mmu, pmd, iova, pfn, prot);
+		break;
+	case SZ_64K:
+	case SZ_4K:
+		ret = ipmmu_alloc_init_pte(mmu, pmd, iova, pfn, size, prot);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
 
 done:
 	spin_unlock_irqrestore(&domain->lock, flags);
@@ -792,6 +815,9 @@ static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
 	if (pmd_none(pmd))
 		return 0;
 
+	if (pmd_sect(pmd))
+		return __pfn_to_phys(pmd_pfn(pmd)) | (iova & ~PMD_MASK);
+
 	pte = *(pmd_page_vaddr(pmd) + pte_index(iova));
 	if (pte_none(pte))
 		return 0;
@@ -932,7 +958,7 @@ static struct iommu_ops ipmmu_ops = {
 	.iova_to_phys = ipmmu_iova_to_phys,
 	.add_device = ipmmu_add_device,
 	.remove_device = ipmmu_remove_device,
-	.pgsize_bitmap = SZ_64K | SZ_4K,
+	.pgsize_bitmap = SZ_2M | SZ_64K | SZ_4K,
 };
 
 /* -----------------------------------------------------------------------------
-- 
1.8.5.5

