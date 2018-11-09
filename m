From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/7] iommu/amd: Allow downgrading page-sizes in alloc_pte()
Date: Fri,  9 Nov 2018 12:07:09 +0100
Message-ID: <20181109110712.12469-5-joro@8bytes.org>
References: <20181109110712.12469-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181109110712.12469-1-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Before this patch it was not possible the downgrade a
mapping established with page-mode 7 to a mapping using
smaller page-sizes, because the pte_level != level check
prevented that.

Treat page-mode 7 like a non-present mapping and allow to
overwrite it in alloc_pte().

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 49b5d3115e56..6a88ba9321d1 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1460,10 +1460,13 @@ static u64 *alloc_pte(struct protection_domain *domain,
 
 	while (level > end_lvl) {
 		u64 __pte, __npte;
+		int pte_level;
 
-		__pte = *pte;
+		__pte     = *pte;
+		pte_level = PM_PTE_LEVEL(__pte);
 
-		if (!IOMMU_PTE_PRESENT(__pte)) {
+		if (!IOMMU_PTE_PRESENT(__pte) ||
+		    pte_level == PAGE_MODE_7_LEVEL) {
 			page = (u64 *)get_zeroed_page(gfp);
 			if (!page)
 				return NULL;
@@ -1475,10 +1478,13 @@ static u64 *alloc_pte(struct protection_domain *domain,
 				free_page((unsigned long)page);
 				continue;
 			}
+
+			if (pte_level == PAGE_MODE_7_LEVEL)
+				domain->updated = true;
 		}
 
 		/* No level skipping support yet */
-		if (PM_PTE_LEVEL(*pte) != level)
+		if (pte_level != level)
 			return NULL;
 
 		level -= 1;
-- 
2.17.1
