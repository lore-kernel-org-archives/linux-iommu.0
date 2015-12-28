From: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
Subject: [PATCH 5/7] iommu: avoid dev iotlb logic in intel-iommu for domains
	with no dev iotlbs
Date: Mon, 28 Dec 2015 18:17:03 +0200
Message-ID: <20151228161703.GA27900@cs.technion.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: serebrin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, dan-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org, omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>

This patch avoids taking the device_domain_lock in iommu_flush_dev_iotlb()
for domains with no dev iotlb devices.

Signed-off-by: Omer Peleg <omer-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
[mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org: rebased and reworded the commit message]
Signed-off-by: Adam Morrison <mad-FrESSTt7Abv7r6psnUbsSmZHpeb/A1Y/@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index c2a6f9e..fc23adc 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -391,6 +391,7 @@ struct dmar_domain {
 					 * to VT-d spec, section 9.3 */
 
 	struct list_head devices;	/* all devices' list */
+	bool has_iotlb_device;
 	struct iova_domain iovad;	/* iova's that belong to this domain */
 
 	struct dma_pte	*pgd;		/* virtual address */
@@ -1463,6 +1464,30 @@ iommu_support_dev_iotlb (struct dmar_domain *domain, struct intel_iommu *iommu,
 	return NULL;
 }
 
+static void domain_update_iotlb(struct dmar_domain *domain)
+{
+	struct device_domain_info *info;
+	bool has_iotlb_device = false;
+	unsigned long flags;
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	list_for_each_entry(info, &domain->devices, link) {
+		struct pci_dev *pdev;
+
+		if (!info->dev || !dev_is_pci(info->dev))
+			continue;
+
+		pdev = to_pci_dev(info->dev);
+		if (pdev->ats_enabled) {
+			has_iotlb_device = true;
+			break;
+		}
+	}
+
+	domain->has_iotlb_device = has_iotlb_device;
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+}
+
 static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 {
 	struct pci_dev *pdev;
@@ -1486,6 +1511,7 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 #endif
 	if (info->ats_supported && !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
 		info->ats_enabled = 1;
+		domain_update_iotlb(info);
 		info->ats_qdep = pci_ats_queue_depth(pdev);
 	}
 }
@@ -1502,6 +1528,7 @@ static void iommu_disable_dev_iotlb(struct device_domain_info *info)
 	if (info->ats_enabled) {
 		pci_disable_ats(pdev);
 		info->ats_enabled = 0;
+		domain_update_iotlb(info);
 	}
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	if (info->pri_enabled) {
@@ -1522,6 +1549,9 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 	unsigned long flags;
 	struct device_domain_info *info;
 
+	if (!domain->has_iotlb_device)
+		return;
+
 	spin_lock_irqsave(&device_domain_lock, flags);
 	list_for_each_entry(info, &domain->devices, link) {
 		if (!info->ats_enabled)
@@ -1739,6 +1769,7 @@ static struct dmar_domain *alloc_domain(int flags)
 	memset(domain, 0, sizeof(*domain));
 	domain->nid = -1;
 	domain->flags = flags;
+	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
 
 	return domain;
-- 
1.9.1
