From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] iommu/omap: fix printk formats for dma_addr_t
Date: Thu, 30 May 2013 18:10:38 -0500
Message-ID: <1369955438-51067-1-git-send-email-s-anna@ti.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Fixed the following printk format warnings for dma_addr_t
for OMAP IOMMU.

drivers/iommu/omap-iommu.c: In function 'omap_iommu_iova_to_phys':
drivers/iommu/omap-iommu.c:1238:4: warning: format '%lx' expects type 'long unsigned int', but argument 4 has type 'dma_addr_t'
drivers/iommu/omap-iommu.c:1245:4: warning: format '%lx' expects type 'long unsigned int', but argument 4 has type 'dma_addr_t'

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 drivers/iommu/omap-iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index e02e5d7..0cc658c 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1235,14 +1235,16 @@ static phys_addr_t omap_iommu_iova_to_phys(struct iommu_domain *domain,
 		else if (iopte_is_large(*pte))
 			ret = omap_iommu_translate(*pte, da, IOLARGE_MASK);
 		else
-			dev_err(dev, "bogus pte 0x%x, da 0x%lx", *pte, da);
+			dev_err(dev, "bogus pte 0x%x, da 0x%llx", *pte,
+							(unsigned long long)da);
 	} else {
 		if (iopgd_is_section(*pgd))
 			ret = omap_iommu_translate(*pgd, da, IOSECTION_MASK);
 		else if (iopgd_is_super(*pgd))
 			ret = omap_iommu_translate(*pgd, da, IOSUPER_MASK);
 		else
-			dev_err(dev, "bogus pgd 0x%x, da 0x%lx", *pgd, da);
+			dev_err(dev, "bogus pgd 0x%x, da 0x%llx", *pgd,
+							(unsigned long long)da);
 	}
 
 	return ret;
-- 
1.8.2
