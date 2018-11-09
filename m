From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 6/7] iommu/amd: Allow to upgrade page-size
Date: Fri,  9 Nov 2018 12:07:11 +0100
Message-ID: <20181109110712.12469-7-joro@8bytes.org>
References: <20181109110712.12469-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181109110712.12469-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

Before this patch the iommu_map_page() function failed when
it tried to map a huge-page where smaller mappings existed
before.

With this change the page-table pages of the old mappings
are teared down, so that the huge-page can be mapped.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index c539b2a59019..71797b3d67e5 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1557,6 +1557,25 @@ static u64 *fetch_pte(struct protection_domain *domain,
 	return pte;
 }
 
+static struct page *free_clear_pte(u64 *pte, u64 pteval, struct page *freelist)
+{
+	unsigned long pt;
+	int mode;
+
+	while (cmpxchg64(pte, pteval, 0) != pteval) {
+		pr_warn("AMD-Vi: IOMMU pte changed since we read it\n");
+		pteval = *pte;
+	}
+
+	if (!IOMMU_PTE_PRESENT(pteval))
+		return freelist;
+
+	pt   = (unsigned long)IOMMU_PTE_PAGE(pteval);
+	mode = IOMMU_PTE_MODE(pteval);
+
+	return free_sub_pt(pt, mode, freelist);
+}
+
 /*
  * Generic mapping functions. It maps a physical address into a DMA
  * address space. It allocates the page table pages if necessary.
@@ -1571,6 +1590,7 @@ static int iommu_map_page(struct protection_domain *dom,
 			  int prot,
 			  gfp_t gfp)
 {
+	struct page *freelist = NULL;
 	u64 __pte, *pte;
 	int i, count;
 
@@ -1587,8 +1607,10 @@ static int iommu_map_page(struct protection_domain *dom,
 		return -ENOMEM;
 
 	for (i = 0; i < count; ++i)
-		if (IOMMU_PTE_PRESENT(pte[i]))
-			return -EBUSY;
+		freelist = free_clear_pte(&pte[i], pte[i], freelist);
+
+	if (freelist != NULL)
+		dom->updated = true;
 
 	if (count > 1) {
 		__pte = PAGE_SIZE_PTE(__sme_set(phys_addr), page_size);
@@ -1606,6 +1628,9 @@ static int iommu_map_page(struct protection_domain *dom,
 
 	update_domain(dom);
 
+	/* Everything flushed out, free pages now */
+	free_page_list(freelist);
+
 	return 0;
 }
 
-- 
2.17.1
