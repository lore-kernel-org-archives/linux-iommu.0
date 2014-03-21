From: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 07/33] iommu/vt-d: Make dmar_insert_dev_info() take struct
	device instead of struct pci_dev
Date: Fri, 21 Mar 2014 17:18:48 +0000
Message-ID: <1395422354-19762-8-git-send-email-David.Woodhouse@intel.com>
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
 drivers/iommu/intel-iommu.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index db7e44b..85ec773 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2113,15 +2113,14 @@ static void domain_remove_dev_info(struct dmar_domain *domain)
 
 /*
  * find_domain
- * Note: we use struct pci_dev->dev.archdata.iommu stores the info
+ * Note: we use struct device->archdata.iommu stores the info
  */
-static struct dmar_domain *
-find_domain(struct pci_dev *pdev)
+static struct dmar_domain *find_domain(struct device *dev)
 {
 	struct device_domain_info *info;
 
 	/* No lock here, assumes no domain exit in normal case */
-	info = pdev->dev.archdata.iommu;
+	info = dev->archdata.iommu;
 	if (info)
 		return info->domain;
 	return NULL;
@@ -2161,7 +2160,7 @@ static int dmar_insert_dev_info(int segment, int bus, int devfn,
 
 	spin_lock_irqsave(&device_domain_lock, flags);
 	if (dev)
-		found = find_domain(dev);
+		found = find_domain(&dev->dev);
 	else
 		found = dmar_search_domain_by_dev_info(segment, bus, devfn);
 	if (found) {
@@ -2193,7 +2192,7 @@ static struct dmar_domain *get_domain_for_dev(struct pci_dev *pdev, int gaw)
 	int bus = 0, devfn = 0;
 	int segment;
 
-	domain = find_domain(pdev);
+	domain = find_domain(&pdev->dev);
 	if (domain)
 		return domain;
 
@@ -2252,7 +2251,7 @@ error:
 	if (free)
 		domain_exit(free);
 	/* recheck it here, maybe others set it */
-	return find_domain(pdev);
+	return find_domain(&pdev->dev);
 }
 
 static int iommu_identity_mapping;
@@ -3108,7 +3107,7 @@ static void intel_unmap_page(struct device *dev, dma_addr_t dev_addr,
 	if (iommu_no_mapping(dev))
 		return;
 
-	domain = find_domain(pdev);
+	domain = find_domain(dev);
 	BUG_ON(!domain);
 
 	iommu = domain_get_iommu(domain);
@@ -3200,7 +3199,7 @@ static void intel_unmap_sg(struct device *hwdev, struct scatterlist *sglist,
 	if (iommu_no_mapping(hwdev))
 		return;
 
-	domain = find_domain(pdev);
+	domain = find_domain(hwdev);
 	BUG_ON(!domain);
 
 	iommu = domain_get_iommu(domain);
@@ -3808,7 +3807,7 @@ static int device_notifier(struct notifier_block *nb,
 	    action != BUS_NOTIFY_DEL_DEVICE)
 		return 0;
 
-	domain = find_domain(pdev);
+	domain = find_domain(dev);
 	if (!domain)
 		return 0;
 
@@ -4147,7 +4146,7 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 	if (unlikely(domain_context_mapped(pdev))) {
 		struct dmar_domain *old_domain;
 
-		old_domain = find_domain(pdev);
+		old_domain = find_domain(dev);
 		if (old_domain) {
 			if (dmar_domain->flags & DOMAIN_FLAG_VIRTUAL_MACHINE ||
 			    dmar_domain->flags & DOMAIN_FLAG_STATIC_IDENTITY)
-- 
1.8.5.3
