From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 8/9] iommu/amd: Optimize amd_iommu_iova_to_phys for new
	fetch_pte interface
Date: Wed,  1 Apr 2015 14:58:51 +0200
Message-ID: <1427893132-18310-9-git-send-email-joro@8bytes.org>
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

Now that fetch_pte returns the page-size of the pte, this
function can be optimized too.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index f97441b..7a00e5d 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3375,7 +3375,6 @@ static phys_addr_t amd_iommu_iova_to_phys(struct iommu_domain *dom,
 {
 	struct protection_domain *domain = dom->priv;
 	unsigned long offset_mask, pte_pgsize;
-	phys_addr_t paddr;
 	u64 *pte, __pte;
 
 	if (domain->mode == PAGE_MODE_NONE)
@@ -3386,15 +3385,10 @@ static phys_addr_t amd_iommu_iova_to_phys(struct iommu_domain *dom,
 	if (!pte || !IOMMU_PTE_PRESENT(*pte))
 		return 0;
 
-	if (PM_PTE_LEVEL(*pte) == 0)
-		offset_mask = PAGE_SIZE - 1;
-	else
-		offset_mask = PTE_PAGE_SIZE(*pte) - 1;
-
-	__pte = *pte & PM_ADDR_MASK;
-	paddr = (__pte & ~offset_mask) | (iova & offset_mask);
+	offset_mask = pte_pgsize - 1;
+	__pte	    = *pte & PM_ADDR_MASK;
 
-	return paddr;
+	return (__pte & ~offset_mask) | (iova & offset_mask);
 }
 
 static bool amd_iommu_capable(enum iommu_cap cap)
-- 
1.9.1
