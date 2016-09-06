From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v6 20/20] iommu/dma: Avoid PCI host bridge windows
Date: Tue,  6 Sep 2016 16:33:53 +0100
Message-ID: <62a69c1684baee6f977fe722de3530670aac938f.1473173789.git.robin.murphy@arm.com>
References: <cover.1473173789.git.robin.murphy@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1473173789.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

With our DMA ops enabled for PCI devices, we should avoid allocating
IOVAs which a host bridge might misinterpret as peer-to-peer DMA and
lead to faults, corruption or other badness. To be safe, punch out holes
for all of the relevant host bridge's windows when initialising a DMA
domain for a PCI device.

Reported-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

---

- New
---
 arch/arm64/mm/dma-mapping.c |  2 +-
 drivers/iommu/dma-iommu.c   | 25 ++++++++++++++++++++++++-
 include/linux/dma-iommu.h   |  3 ++-
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index c4284c432ae8..610d8e53011e 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -827,7 +827,7 @@ static bool do_iommu_attach(struct device *dev, const struct iommu_ops *ops,
 	 * then the IOMMU core will have already configured a group for this
 	 * device, and allocated the default domain for that group.
 	 */
-	if (!domain || iommu_dma_init_domain(domain, dma_base, size)) {
+	if (!domain || iommu_dma_init_domain(domain, dma_base, size, dev)) {
 		pr_warn("Failed to set up IOMMU for device %s; retaining platform DMA ops\n",
 			dev_name(dev));
 		return false;
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 90f9c6b7d472..424c04112398 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -27,6 +27,7 @@
 #include <linux/iova.h>
 #include <linux/irq.h>
 #include <linux/mm.h>
+#include <linux/pci.h>
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
 
@@ -103,18 +104,38 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 }
 EXPORT_SYMBOL(iommu_put_dma_cookie);
 
+static void iova_reserve_pci_windows(struct pci_dev *dev,
+		struct iova_domain *iovad)
+{
+	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
+	struct resource_entry *window;
+	unsigned long lo, hi;
+
+	resource_list_for_each_entry(window, &bridge->windows) {
+		if (resource_type(window->res) != IORESOURCE_MEM &&
+		    resource_type(window->res) != IORESOURCE_IO)
+			continue;
+
+		lo = iova_pfn(iovad, window->res->start - window->offset);
+		hi = iova_pfn(iovad, window->res->end - window->offset);
+		reserve_iova(iovad, lo, hi);
+	}
+}
+
 /**
  * iommu_dma_init_domain - Initialise a DMA mapping domain
  * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
  * @base: IOVA at which the mappable address space starts
  * @size: Size of IOVA space
+ * @dev: Device the domain is being initialised for
  *
  * @base and @size should be exact multiples of IOMMU page granularity to
  * avoid rounding surprises. If necessary, we reserve the page at address 0
  * to ensure it is an invalid IOVA. It is safe to reinitialise a domain, but
  * any change which could make prior IOVAs invalid will fail.
  */
-int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base, u64 size)
+int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
+		u64 size, struct device *dev)
 {
 	struct iova_domain *iovad = cookie_iovad(domain);
 	unsigned long order, base_pfn, end_pfn;
@@ -152,6 +173,8 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base, u64 size
 		iovad->dma_32bit_pfn = end_pfn;
 	} else {
 		init_iova_domain(iovad, 1UL << order, base_pfn, end_pfn);
+		if (dev && dev_is_pci(dev))
+			iova_reserve_pci_windows(to_pci_dev(dev), iovad);
 	}
 	return 0;
 }
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 5ee806e41b5c..32c589062bd9 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -30,7 +30,8 @@ int iommu_get_dma_cookie(struct iommu_domain *domain);
 void iommu_put_dma_cookie(struct iommu_domain *domain);
 
 /* Setup call for arch DMA mapping code */
-int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base, u64 size);
+int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
+		u64 size, struct device *dev);
 
 /* General helpers for DMA-API <-> IOMMU-API interaction */
 int dma_direction_to_prot(enum dma_data_direction dir, bool coherent);
-- 
2.8.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
