From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/7] iommu/amd: Collect page-table pages in freelist
Date: Fri,  9 Nov 2018 12:07:06 +0100
Message-ID: <20181109110712.12469-2-joro@8bytes.org>
References: <20181109110712.12469-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181109110712.12469-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

Collect all pages that belong to a page-table in a list and
free them after the tree has been traversed. This allows to
implement safer page-table updates in subsequent patches.
Also move the functions for page-table freeing a bit upwards
in the file so that they are usable from the iommu_map() path.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 144 ++++++++++++++++++++++----------------
 1 file changed, 83 insertions(+), 61 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1167ff0416cf..2655bd91af93 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1317,6 +1317,89 @@ static void domain_flush_devices(struct protection_domain *domain)
  *
  ****************************************************************************/
 
+static void free_page_list(struct page *freelist)
+{
+	while (freelist != NULL) {
+		unsigned long p = (unsigned long)page_address(freelist);
+		freelist = freelist->freelist;
+		free_page(p);
+	}
+}
+
+static struct page *free_pt_page(unsigned long pt, struct page *freelist)
+{
+	struct page *p = virt_to_page((void *)pt);
+
+	p->freelist = freelist;
+
+	return p;
+}
+
+#define DEFINE_FREE_PT_FN(LVL, FN)						\
+static struct page *free_pt_##LVL (unsigned long __pt, struct page *freelist)	\
+{										\
+	unsigned long p;							\
+	u64 *pt;								\
+	int i;									\
+										\
+	pt = (u64 *)__pt;							\
+										\
+	for (i = 0; i < 512; ++i) {						\
+		/* PTE present? */						\
+		if (!IOMMU_PTE_PRESENT(pt[i]))					\
+			continue;						\
+										\
+		/* Large PTE? */						\
+		if (PM_PTE_LEVEL(pt[i]) == 0 ||					\
+		    PM_PTE_LEVEL(pt[i]) == 7)					\
+			continue;						\
+										\
+		p = (unsigned long)IOMMU_PTE_PAGE(pt[i]);			\
+		freelist = FN(p, freelist);					\
+	}									\
+										\
+	return free_pt_page((unsigned long)pt, freelist);			\
+}
+
+DEFINE_FREE_PT_FN(l2, free_pt_page)
+DEFINE_FREE_PT_FN(l3, free_pt_l2)
+DEFINE_FREE_PT_FN(l4, free_pt_l3)
+DEFINE_FREE_PT_FN(l5, free_pt_l4)
+DEFINE_FREE_PT_FN(l6, free_pt_l5)
+
+static void free_pagetable(struct protection_domain *domain)
+{
+	unsigned long root = (unsigned long)domain->pt_root;
+	struct page *freelist = NULL;
+
+	switch (domain->mode) {
+	case PAGE_MODE_NONE:
+		break;
+	case PAGE_MODE_1_LEVEL:
+		freelist = free_pt_page(root, freelist);
+		break;
+	case PAGE_MODE_2_LEVEL:
+		freelist = free_pt_l2(root, freelist);
+		break;
+	case PAGE_MODE_3_LEVEL:
+		freelist = free_pt_l3(root, freelist);
+		break;
+	case PAGE_MODE_4_LEVEL:
+		freelist = free_pt_l4(root, freelist);
+		break;
+	case PAGE_MODE_5_LEVEL:
+		freelist = free_pt_l5(root, freelist);
+		break;
+	case PAGE_MODE_6_LEVEL:
+		freelist = free_pt_l6(root, freelist);
+		break;
+	default:
+		BUG();
+	}
+
+	free_page_list(freelist);
+}
+
 /*
  * This function is used to add another level to an IO page table. Adding
  * another level increases the size of the address space by 9 bits to a size up
@@ -1638,67 +1721,6 @@ static void domain_id_free(int id)
 	spin_unlock(&pd_bitmap_lock);
 }
 
-#define DEFINE_FREE_PT_FN(LVL, FN)				\
-static void free_pt_##LVL (unsigned long __pt)			\
-{								\
-	unsigned long p;					\
-	u64 *pt;						\
-	int i;							\
-								\
-	pt = (u64 *)__pt;					\
-								\
-	for (i = 0; i < 512; ++i) {				\
-		/* PTE present? */				\
-		if (!IOMMU_PTE_PRESENT(pt[i]))			\
-			continue;				\
-								\
-		/* Large PTE? */				\
-		if (PM_PTE_LEVEL(pt[i]) == 0 ||			\
-		    PM_PTE_LEVEL(pt[i]) == 7)			\
-			continue;				\
-								\
-		p = (unsigned long)IOMMU_PTE_PAGE(pt[i]);	\
-		FN(p);						\
-	}							\
-	free_page((unsigned long)pt);				\
-}
-
-DEFINE_FREE_PT_FN(l2, free_page)
-DEFINE_FREE_PT_FN(l3, free_pt_l2)
-DEFINE_FREE_PT_FN(l4, free_pt_l3)
-DEFINE_FREE_PT_FN(l5, free_pt_l4)
-DEFINE_FREE_PT_FN(l6, free_pt_l5)
-
-static void free_pagetable(struct protection_domain *domain)
-{
-	unsigned long root = (unsigned long)domain->pt_root;
-
-	switch (domain->mode) {
-	case PAGE_MODE_NONE:
-		break;
-	case PAGE_MODE_1_LEVEL:
-		free_page(root);
-		break;
-	case PAGE_MODE_2_LEVEL:
-		free_pt_l2(root);
-		break;
-	case PAGE_MODE_3_LEVEL:
-		free_pt_l3(root);
-		break;
-	case PAGE_MODE_4_LEVEL:
-		free_pt_l4(root);
-		break;
-	case PAGE_MODE_5_LEVEL:
-		free_pt_l5(root);
-		break;
-	case PAGE_MODE_6_LEVEL:
-		free_pt_l6(root);
-		break;
-	default:
-		BUG();
-	}
-}
-
 static void free_gcr3_tbl_level1(u64 *tbl)
 {
 	u64 *ptr;
-- 
2.17.1
