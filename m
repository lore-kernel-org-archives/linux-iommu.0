From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] amd_iommu: Fix leak in free_pagetable()
Date: Mon, 17 Jun 2013 19:52:14 -0600
Message-ID: <20130618015116.20711.90269.stgit@bling.home>
References: <20130618014459.20440.73844.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130618014459.20440.73844.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
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
it's a 3 level page table.  Add support for the extra levels.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---

Here's the flat version.  It's not terrible, but checkpatch whines
about the level of nesting.

 drivers/iommu/amd_iommu.c |   32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 565c745..95da421 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1908,23 +1908,47 @@ static void domain_id_free(int id)
 
 static void free_pagetable(struct protection_domain *domain)
 {
-	int i, j;
-	u64 *p1, *p2, *p3;
+	int i, j, k, l, m, depth = domain->mode;
+	u64 *p1, *p2, *p3, *p4, *p5, *p6;
 
 	p1 = domain->pt_root;
 
 	if (!p1)
 		return;
 
-	for (i = 0; i < 512; ++i) {
+	for (i = 0; depth > 1 && i < 512; ++i) {
 		if (!IOMMU_PTE_PRESENT(p1[i]))
 			continue;
 
 		p2 = IOMMU_PTE_PAGE(p1[i]);
-		for (j = 0; j < 512; ++j) {
+		for (j = 0; depth > 2 && j < 512; ++j) {
 			if (!IOMMU_PTE_PRESENT(p2[j]))
 				continue;
+
 			p3 = IOMMU_PTE_PAGE(p2[j]);
+			for (k = 0; depth > 3 && k < 512; ++k) {
+				if (!IOMMU_PTE_PRESENT(p3[k]))
+					continue;
+
+				p4 = IOMMU_PTE_PAGE(p3[k]);
+				for (l = 0; depth > 4 && l < 512; ++l) {
+					if (!IOMMU_PTE_PRESENT(p4[l]))
+						continue;
+
+					p5 = IOMMU_PTE_PAGE(p4[l]);
+					for (m = 0; depth > 5 && m < 512; ++m) {
+						if (!IOMMU_PTE_PRESENT(p5[m]))
+							continue;
+						p6 = IOMMU_PTE_PAGE(p5[m]);
+						free_page((unsigned long)p6);
+					}
+
+					free_page((unsigned long)p5);
+				}
+
+				free_page((unsigned long)p4);
+			}
+
 			free_page((unsigned long)p3);
 		}
 
