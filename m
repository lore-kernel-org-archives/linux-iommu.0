From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] amd_iommu: Fix leak in free_pagetable()
Date: Mon, 17 Jun 2013 19:48:08 -0600
Message-ID: <20130618014459.20440.73844.stgit@bling.home>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

AMD IOMMU initializes domains with a 3 level page table by default
and will dynamically size it up to a 6 level page table.  Sadly,
free_pagetable() ignores this feature and statically frees as if
it's a 3 level page table.  Recurse through all the levels to
free everything.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---

This is obviously a version rewritten to be recursive.  I'll also
post a flat version, take your pick.

 drivers/iommu/amd_iommu.c |   36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 565c745..5496025 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1906,32 +1906,26 @@ static void domain_id_free(int id)
 	write_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
 }
 
-static void free_pagetable(struct protection_domain *domain)
+static void free_pagetable_level(int level, int max_level, u64 *pt)
 {
-	int i, j;
-	u64 *p1, *p2, *p3;
+	if (level < max_level) {
+		int i;
+		for (i = 0; i < 512; ++i) {
+			if (IOMMU_PTE_PRESENT(pt[i]))
+				free_pagetable_level(level + 1, max_level,
+						     IOMMU_PTE_PAGE(pt[i]));
+		}
+	}
 
-	p1 = domain->pt_root;
+	free_page((unsigned long)pt);
+}
 
-	if (!p1)
+static void free_pagetable(struct protection_domain *domain)
+{
+	if (!domain->pt_root)
 		return;
 
-	for (i = 0; i < 512; ++i) {
-		if (!IOMMU_PTE_PRESENT(p1[i]))
-			continue;
-
-		p2 = IOMMU_PTE_PAGE(p1[i]);
-		for (j = 0; j < 512; ++j) {
-			if (!IOMMU_PTE_PRESENT(p2[j]))
-				continue;
-			p3 = IOMMU_PTE_PAGE(p2[j]);
-			free_page((unsigned long)p3);
-		}
-
-		free_page((unsigned long)p2);
-	}
-
-	free_page((unsigned long)p1);
+	free_pagetable_level(PAGE_MODE_1_LEVEL, domain->mode, domain->pt_root);
 
 	domain->pt_root = NULL;
 }
