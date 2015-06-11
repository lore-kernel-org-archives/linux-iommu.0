From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/4] iommu/vt-d: Remove unmap_device_dma()
Date: Thu, 11 Jun 2015 15:47:42 +0200
Message-ID: <1434030463-942-4-git-send-email-joro@8bytes.org>
References: <1434030463-942-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1434030463-942-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, zhen-hual-VXdhtT5mjnY@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

This removes the unmap_device_dma() function and the
code-path calling it. That code looks like a left-over from
Bill Sumners patch-set, as it only makes sense when kdump
recovery is implemented like in his original patch-set.

With the way it is implemented now this code doesn't make
sense at all and can be removed.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 44 --------------------------------------------
 1 file changed, 44 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f50d065..fcb9310 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -400,9 +400,6 @@ static LIST_HEAD(__iommu_remapped_mem);
  */
 static int intel_iommu_load_translation_tables(struct intel_iommu *iommu);
 
-static void unmap_device_dma(struct dmar_domain *domain,
-				struct device *dev,
-				struct intel_iommu *iommu);
 static void iommu_check_pre_te_status(struct intel_iommu *iommu);
 static u8 g_translation_pre_enabled;
 
@@ -3120,25 +3117,6 @@ static struct dmar_domain *__get_valid_domain_for_dev(struct device *dev)
 		return NULL;
 	}
 
-	/* if in kdump kernel, we need to unmap the mapped dma pages,
-	 * detach this device first.
-	 */
-	if (likely(domain_context_mapped(dev))) {
-		iommu = domain_get_iommu(domain);
-		if (iommu->pre_enabled_trans) {
-			unmap_device_dma(domain, dev, iommu);
-
-			domain = get_domain_for_dev(dev,
-				DEFAULT_DOMAIN_ADDRESS_WIDTH);
-			if (!domain) {
-				pr_err("Allocating domain for %s failed",
-				       dev_name(dev));
-				return NULL;
-			}
-		} else
-			return domain;
-	}
-
 	ret = domain_context_mapping(domain, dev, CONTEXT_TT_MULTI_LEVEL);
 	if (ret) {
 		pr_err("Domain context map for %s failed",
@@ -5063,28 +5041,6 @@ out_unmap:
 	return ret;
 }
 
-static void unmap_device_dma(struct dmar_domain *domain,
-				struct device *dev,
-				struct intel_iommu *iommu)
-{
-	struct context_entry *ce;
-	struct iova *iova;
-	phys_addr_t phys_addr;
-	dma_addr_t dev_addr;
-	struct pci_dev *pdev;
-
-	pdev = to_pci_dev(dev);
-	ce = iommu_context_addr(iommu, pdev->bus->number, pdev->devfn, 1);
-	phys_addr = context_address_root(ce) << VTD_PAGE_SHIFT;
-	dev_addr = phys_to_dma(dev, phys_addr);
-
-	iova = find_iova(&domain->iovad, IOVA_PFN(dev_addr));
-	if (iova)
-		intel_unmap(dev, dev_addr);
-
-	domain_remove_one_dev_info(domain, dev);
-}
-
 static void iommu_check_pre_te_status(struct intel_iommu *iommu)
 {
 	u32 sts;
-- 
1.9.1
