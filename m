From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 9/9] iommu/amd: Correctly encode huge pages in iommu page
	tables
Date: Wed,  1 Apr 2015 14:58:52 +0200
Message-ID: <1427893132-18310-10-git-send-email-joro@8bytes.org>
References: <1427893132-18310-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1427893132-18310-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

When a default page-size for given level should be mapped,
the level encoding must be 0 rather than 7. This fixes an
issue seen on IOMMUv2 hardware, where this encoding is
enforced.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 7a00e5d..aa710b0 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1390,13 +1390,14 @@ static int iommu_map_page(struct protection_domain *dom,
 	u64 __pte, *pte;
 	int i, count;
 
+	BUG_ON(!IS_ALIGNED(bus_addr, page_size));
+	BUG_ON(!IS_ALIGNED(phys_addr, page_size));
+
 	if (!(prot & IOMMU_PROT_MASK))
 		return -EINVAL;
 
-	bus_addr  = PAGE_ALIGN(bus_addr);
-	phys_addr = PAGE_ALIGN(phys_addr);
-	count     = PAGE_SIZE_PTE_COUNT(page_size);
-	pte       = alloc_pte(dom, bus_addr, page_size, NULL, GFP_KERNEL);
+	count = PAGE_SIZE_PTE_COUNT(page_size);
+	pte   = alloc_pte(dom, bus_addr, page_size, NULL, GFP_KERNEL);
 
 	if (!pte)
 		return -ENOMEM;
@@ -1405,7 +1406,7 @@ static int iommu_map_page(struct protection_domain *dom,
 		if (IOMMU_PTE_PRESENT(pte[i]))
 			return -EBUSY;
 
-	if (page_size > PAGE_SIZE) {
+	if (count > 1) {
 		__pte = PAGE_SIZE_PTE(phys_addr, page_size);
 		__pte |= PM_LEVEL_ENC(7) | IOMMU_PTE_P | IOMMU_PTE_FC;
 	} else
-- 
1.9.1
