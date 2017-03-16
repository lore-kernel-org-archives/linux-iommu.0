From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 4/4] iommu/dma: Make PCI window reservation generic
Date: Thu, 16 Mar 2017 17:00:19 +0000
Message-ID: <3876a855b7b5ba4684ac3e3af632b817d224c753.1489683129.git.robin.murphy@arm.com>
References: <cover.1489683129.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1489683129.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Now that we're applying the IOMMU API reserved regions to our IOVA
domains, we shouldn't need to privately special-case PCI windows, or
indeed anything else which isn't specific to our iommu-dma layer.
However, since those aren't IOMMU-specific either, rather than start
duplicating code into IOMMU drivers let's transform the existing
function into an iommu_get_resv_regions() helper that they can share.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

Notes:
    v2:
    - New

 drivers/iommu/arm-smmu-v3.c |  2 ++
 drivers/iommu/arm-smmu.c    |  2 ++
 drivers/iommu/dma-iommu.c   | 38 ++++++++++++++++++++++++++++----------
 include/linux/dma-iommu.h   |  5 +++++
 4 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 591bb96047c9..bbd46efbe075 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1893,6 +1893,8 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 		return;
 
 	list_add_tail(&region->list, head);
+
+	iommu_dma_get_resv_regions(dev, head);
 }
 
 static void arm_smmu_put_resv_regions(struct device *dev,
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index b493c99e17f7..9b33700b7c69 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1613,6 +1613,8 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 		return;
 
 	list_add_tail(&region->list, head);
+
+	iommu_dma_get_resv_regions(dev, head);
 }
 
 static void arm_smmu_put_resv_regions(struct device *dev,
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 5787f919f4ec..85652110c8ff 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -167,22 +167,43 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 }
 EXPORT_SYMBOL(iommu_put_dma_cookie);
 
-static void iova_reserve_pci_windows(struct pci_dev *dev,
-		struct iova_domain *iovad)
+/**
+ * iommu_dma_get_resv_regions - Reserved region driver helper
+ * @dev: Device from iommu_get_resv_regions()
+ * @list: Reserved region list from iommu_get_resv_regions()
+ *
+ * IOMMU drivers can use this to implement their .get_resv_regions callback
+ * for general non-IOMMU-specific reservations. Currently, this covers host
+ * bridge windows for PCI devices.
+ */
+void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 {
-	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
+	struct pci_host_bridge *bridge;
 	struct resource_entry *window;
-	unsigned long lo, hi;
 
+	if (!dev_is_pci(dev))
+		return;
+
+	bridge = pci_find_host_bridge(to_pci_dev(dev)->bus);
 	resource_list_for_each_entry(window, &bridge->windows) {
+		struct iommu_resv_region *region;
+		phys_addr_t start;
+		size_t length;
+
 		if (resource_type(window->res) != IORESOURCE_MEM)
 			continue;
 
-		lo = iova_pfn(iovad, window->res->start - window->offset);
-		hi = iova_pfn(iovad, window->res->end - window->offset);
-		reserve_iova(iovad, lo, hi);
+		start = window->res->start - window->offset;
+		length = window->res->end - window->res->start + 1;
+		region = iommu_alloc_resv_region(start, length, 0,
+				IOMMU_RESV_RESERVED);
+		if (!region)
+			return;
+
+		list_add_tail(&region->list, list);
 	}
 }
+EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 
 static int cookie_init_hw_msi_region(struct iommu_dma_cookie *cookie,
 		phys_addr_t start, phys_addr_t end)
@@ -218,9 +239,6 @@ static int iova_reserve_iommu_regions(struct device *dev,
 	LIST_HEAD(resv_regions);
 	int ret = 0;
 
-	if (dev_is_pci(dev))
-		iova_reserve_pci_windows(to_pci_dev(dev), iovad);
-
 	iommu_get_resv_regions(dev, &resv_regions);
 	list_for_each_entry(region, &resv_regions, list) {
 		unsigned long lo, hi;
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 5725c94b1f12..b6635a46fc7c 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -71,6 +71,7 @@ int iommu_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
 
 /* The DMA API isn't _quite_ the whole story, though... */
 void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
+void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
 #else
 
@@ -100,6 +101,10 @@ static inline void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
 {
 }
 
+static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
+{
+}
+
 #endif	/* CONFIG_IOMMU_DMA */
 #endif	/* __KERNEL__ */
 #endif	/* __DMA_IOMMU_H */
-- 
2.11.0.dirty
