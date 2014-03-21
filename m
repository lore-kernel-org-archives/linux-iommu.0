From: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 08/33] iommu/vt-d: Use struct device in device_domain_info,
	not struct pci_dev
Date: Fri, 21 Mar 2014 17:18:49 +0000
Message-ID: <1395422354-19762-9-git-send-email-David.Woodhouse@intel.com>
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
 drivers/iommu/intel-iommu.c | 54 +++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 85ec773..ccef436 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -372,7 +372,7 @@ struct device_domain_info {
 	int segment;		/* PCI domain */
 	u8 bus;			/* PCI bus number */
 	u8 devfn;		/* PCI devfn number */
-	struct pci_dev *dev; /* it's NULL for PCIe-to-PCI bridge */
+	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
 	struct intel_iommu *iommu; /* IOMMU used by this device */
 	struct dmar_domain *domain; /* pointer to domain */
 };
@@ -428,7 +428,7 @@ static void domain_remove_dev_info(struct dmar_domain *domain);
 static void domain_remove_one_dev_info(struct dmar_domain *domain,
 				       struct pci_dev *pdev);
 static void iommu_detach_dependent_devices(struct intel_iommu *iommu,
-					   struct pci_dev *pdev);
+					   struct device *dev);
 
 #ifdef CONFIG_INTEL_IOMMU_DEFAULT_ON
 int dmar_disabled = 0;
@@ -1247,6 +1247,7 @@ static struct device_domain_info *iommu_support_dev_iotlb(
 	unsigned long flags;
 	struct device_domain_info *info;
 	struct intel_iommu *iommu = device_to_iommu(segment, bus, devfn);
+	struct pci_dev *pdev;
 
 	if (!ecap_dev_iotlb_support(iommu->ecap))
 		return NULL;
@@ -1262,13 +1263,15 @@ static struct device_domain_info *iommu_support_dev_iotlb(
 		}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 
-	if (!found || !info->dev)
+	if (!found || !info->dev || !dev_is_pci(info->dev))
 		return NULL;
 
-	if (!pci_find_ext_capability(info->dev, PCI_EXT_CAP_ID_ATS))
+	pdev = to_pci_dev(info->dev);
+
+	if (!pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ATS))
 		return NULL;
 
-	if (!dmar_find_matched_atsr_unit(info->dev))
+	if (!dmar_find_matched_atsr_unit(pdev))
 		return NULL;
 
 	info->iommu = iommu;
@@ -1278,18 +1281,19 @@ static struct device_domain_info *iommu_support_dev_iotlb(
 
 static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 {
-	if (!info)
+	if (!info || !dev_is_pci(info->dev))
 		return;
 
-	pci_enable_ats(info->dev, VTD_PAGE_SHIFT);
+	pci_enable_ats(to_pci_dev(info->dev), VTD_PAGE_SHIFT);
 }
 
 static void iommu_disable_dev_iotlb(struct device_domain_info *info)
 {
-	if (!info->dev || !pci_ats_enabled(info->dev))
+	if (!info->dev || !dev_is_pci(info->dev) ||
+	    !pci_ats_enabled(to_pci_dev(info->dev)))
 		return;
 
-	pci_disable_ats(info->dev);
+	pci_disable_ats(to_pci_dev(info->dev));
 }
 
 static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
@@ -1301,11 +1305,16 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 
 	spin_lock_irqsave(&device_domain_lock, flags);
 	list_for_each_entry(info, &domain->devices, link) {
-		if (!info->dev || !pci_ats_enabled(info->dev))
+		struct pci_dev *pdev;
+		if (!info->dev || !dev_is_pci(info->dev))
+			continue;
+
+		pdev = to_pci_dev(info->dev);
+		if (!pci_ats_enabled(pdev))
 			continue;
 
 		sid = info->bus << 8 | info->devfn;
-		qdep = pci_ats_queue_depth(info->dev);
+		qdep = pci_ats_queue_depth(pdev);
 		qi_flush_dev_iotlb(info->iommu, sid, qdep, addr, mask);
 	}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
@@ -2071,7 +2080,7 @@ static inline void unlink_domain_info(struct device_domain_info *info)
 	list_del(&info->link);
 	list_del(&info->global);
 	if (info->dev)
-		info->dev->dev.archdata.iommu = NULL;
+		info->dev->archdata.iommu = NULL;
 }
 
 static void domain_remove_dev_info(struct dmar_domain *domain)
@@ -2140,7 +2149,7 @@ dmar_search_domain_by_dev_info(int segment, int bus, int devfn)
 }
 
 static int dmar_insert_dev_info(int segment, int bus, int devfn,
-				struct pci_dev *dev, struct dmar_domain **domp)
+				struct device *dev, struct dmar_domain **domp)
 {
 	struct dmar_domain *found, *domain = *domp;
 	struct device_domain_info *info;
@@ -2160,7 +2169,7 @@ static int dmar_insert_dev_info(int segment, int bus, int devfn,
 
 	spin_lock_irqsave(&device_domain_lock, flags);
 	if (dev)
-		found = find_domain(&dev->dev);
+		found = find_domain(dev);
 	else
 		found = dmar_search_domain_by_dev_info(segment, bus, devfn);
 	if (found) {
@@ -2174,7 +2183,7 @@ static int dmar_insert_dev_info(int segment, int bus, int devfn,
 		list_add(&info->link, &domain->devices);
 		list_add(&info->global, &device_domain_list);
 		if (dev)
-			dev->dev.archdata.iommu = info;
+			dev->archdata.iommu = info;
 		spin_unlock_irqrestore(&device_domain_lock, flags);
 	}
 
@@ -2245,7 +2254,7 @@ static struct dmar_domain *get_domain_for_dev(struct pci_dev *pdev, int gaw)
 
 found_domain:
 	if (dmar_insert_dev_info(segment, pdev->bus->number, pdev->devfn,
-				 pdev, &domain) == 0)
+				 &pdev->dev, &domain) == 0)
 		return domain;
 error:
 	if (free)
@@ -2458,7 +2467,7 @@ static int domain_add_dev_info(struct dmar_domain *domain,
 	info->segment = pci_domain_nr(pdev->bus);
 	info->bus = pdev->bus->number;
 	info->devfn = pdev->devfn;
-	info->dev = pdev;
+	info->dev = &pdev->dev;
 	info->domain = domain;
 
 	spin_lock_irqsave(&device_domain_lock, flags);
@@ -3189,7 +3198,6 @@ static void intel_unmap_sg(struct device *hwdev, struct scatterlist *sglist,
 			   int nelems, enum dma_data_direction dir,
 			   struct dma_attrs *attrs)
 {
-	struct pci_dev *pdev = to_pci_dev(hwdev);
 	struct dmar_domain *domain;
 	unsigned long start_pfn, last_pfn;
 	struct iova *iova;
@@ -3985,13 +3993,15 @@ out_free_dmar:
 }
 
 static void iommu_detach_dependent_devices(struct intel_iommu *iommu,
-					   struct pci_dev *pdev)
+					   struct device *dev)
 {
-	struct pci_dev *tmp, *parent;
+	struct pci_dev *tmp, *parent, *pdev;
 
-	if (!iommu || !pdev)
+	if (!iommu || !dev || !dev_is_pci(dev))
 		return;
 
+	pdev = to_pci_dev(dev);
+
 	/* dependent device detach */
 	tmp = pci_find_upstream_pcie_bridge(pdev);
 	/* Secondary interface's bus number and devfn 0 */
@@ -4034,7 +4044,7 @@ static void domain_remove_one_dev_info(struct dmar_domain *domain,
 
 			iommu_disable_dev_iotlb(info);
 			iommu_detach_dev(iommu, info->bus, info->devfn);
-			iommu_detach_dependent_devices(iommu, pdev);
+			iommu_detach_dependent_devices(iommu, &pdev->dev);
 			free_devinfo_mem(info);
 
 			spin_lock_irqsave(&device_domain_lock, flags);
-- 
1.8.5.3
