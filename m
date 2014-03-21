From: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 24/33] iommu/vt-d: Make get_valid_domain_for_dev() take struct
	device
Date: Fri, 21 Mar 2014 17:19:05 +0000
Message-ID: <1395422354-19762-25-git-send-email-David.Woodhouse@intel.com>
References: <1395422354-19762-1-git-send-email-David.Woodhouse@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1395422354-19762-1-git-send-email-David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 15371ec..41eafc3 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2862,26 +2862,24 @@ static struct iova *intel_alloc_iova(struct device *dev,
 	return iova;
 }
 
-static struct dmar_domain *__get_valid_domain_for_dev(struct pci_dev *pdev)
+static struct dmar_domain *__get_valid_domain_for_dev(struct device *dev)
 {
 	struct dmar_domain *domain;
 	int ret;
 
-	domain = get_domain_for_dev(&pdev->dev, DEFAULT_DOMAIN_ADDRESS_WIDTH);
+	domain = get_domain_for_dev(dev, DEFAULT_DOMAIN_ADDRESS_WIDTH);
 	if (!domain) {
-		printk(KERN_ERR
-			"Allocating domain for %s failed", pci_name(pdev));
+		printk(KERN_ERR "Allocating domain for %s failed",
+		       dev_name(dev));
 		return NULL;
 	}
 
 	/* make sure context mapping is ok */
-	if (unlikely(!domain_context_mapped(&pdev->dev))) {
-		ret = domain_context_mapping(domain, &pdev->dev,
-					     CONTEXT_TT_MULTI_LEVEL);
+	if (unlikely(!domain_context_mapped(dev))) {
+		ret = domain_context_mapping(domain, dev, CONTEXT_TT_MULTI_LEVEL);
 		if (ret) {
-			printk(KERN_ERR
-				"Domain context map for %s failed",
-				pci_name(pdev));
+			printk(KERN_ERR "Domain context map for %s failed",
+			       dev_name(dev));
 			return NULL;
 		}
 	}
@@ -2889,12 +2887,12 @@ static struct dmar_domain *__get_valid_domain_for_dev(struct pci_dev *pdev)
 	return domain;
 }
 
-static inline struct dmar_domain *get_valid_domain_for_dev(struct pci_dev *dev)
+static inline struct dmar_domain *get_valid_domain_for_dev(struct device *dev)
 {
 	struct device_domain_info *info;
 
 	/* No lock here, assumes no domain exit in normal case */
-	info = dev->dev.archdata.iommu;
+	info = dev->archdata.iommu;
 	if (likely(info))
 		return info->domain;
 
@@ -2975,7 +2973,7 @@ static dma_addr_t __intel_map_single(struct device *hwdev, phys_addr_t paddr,
 	if (iommu_no_mapping(hwdev))
 		return paddr;
 
-	domain = get_valid_domain_for_dev(pdev);
+	domain = get_valid_domain_for_dev(hwdev);
 	if (!domain)
 		return 0;
 
@@ -3280,7 +3278,7 @@ static int intel_map_sg(struct device *hwdev, struct scatterlist *sglist, int ne
 	if (iommu_no_mapping(hwdev))
 		return intel_nontranslate_map_sg(hwdev, sglist, nelems, dir);
 
-	domain = get_valid_domain_for_dev(pdev);
+	domain = get_valid_domain_for_dev(hwdev);
 	if (!domain)
 		return 0;
 
-- 
1.8.5.3
