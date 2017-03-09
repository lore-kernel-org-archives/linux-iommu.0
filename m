From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 3/3] iommu/dma: Handle IOMMU API reserved regions
Date: Thu,  9 Mar 2017 19:50:38 +0000
Message-ID: <ccb0f5ef6822c760c253038e27e55752210b754b.1489088954.git.robin.murphy@arm.com>
References: <1b012c7e82ccef1a34be38d81e82e74f129dfedc.1489088954.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1b012c7e82ccef1a34be38d81e82e74f129dfedc.1489088954.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Now that it's simple to discover the necessary reservations for a given
device/IOMMU combination, let's wire up the appropriate handling. Basic
reserved regions and direct-mapped regions are obvious enough to handle;
hardware MSI regions we can handle by pre-populating the appropriate
msi_pages in the cookie. That way, irqchip drivers which normally assume
MSIs to require mapping at the IOMMU can keep working without having
to special-case their iommu_dma_map_msi_msg() hook, or indeed be aware
at all of integration quirks preventing the IOMMU translating certain
addresses.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/dma-iommu.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 1e0983488a8d..1082ebf8a415 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -167,6 +167,69 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 }
 EXPORT_SYMBOL(iommu_put_dma_cookie);
 
+static int cookie_init_hw_msi_region(struct iommu_dma_cookie *cookie,
+		phys_addr_t start, phys_addr_t end)
+{
+	struct iova_domain *iovad = &cookie->iovad;
+	struct iommu_dma_msi_page *msi_page;
+	int i, num_pages;
+
+	start &= ~iova_mask(iovad);
+	end = iova_align(iovad, end);
+	num_pages = (end - start) >> iova_shift(iovad);
+
+	msi_page = kcalloc(num_pages, sizeof(*msi_page), GFP_KERNEL);
+	if (!msi_page)
+		return -ENOMEM;
+
+	for (i = 0; i < num_pages; i++) {
+		msi_page[i].phys = start;
+		msi_page[i].iova = start;
+		INIT_LIST_HEAD(&msi_page[i].list);
+		list_add(&msi_page[i].list, &cookie->msi_page_list);
+		start += iovad->granule;
+	}
+
+	return 0;
+}
+
+static int iova_reserve_iommu_regions(struct device *dev,
+		struct iommu_domain *domain)
+{
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
+	struct iommu_resv_region *region;
+	struct list_head resv_regions;
+	unsigned long lo, hi;
+	int ret = 0;
+
+	INIT_LIST_HEAD(&resv_regions);
+	iommu_get_resv_regions(dev, &resv_regions);
+	list_for_each_entry(region, &resv_regions, list) {
+		/* We ARE the software that manages these! */
+		if (region->type & IOMMU_RESV_SW_MSI)
+			continue;
+
+		lo = iova_pfn(iovad, region->start);
+		hi = iova_pfn(iovad, region->start + region->length);
+		reserve_iova(iovad, lo, hi);
+
+		if (region->type & IOMMU_RESV_DIRECT) {
+			ret = iommu_map(domain, region->start, region->start,
+					region->length, region->prot);
+		} else if (region->type & IOMMU_RESV_MSI) {
+			ret = cookie_init_hw_msi_region(cookie, region->start,
+					region->start + region->length);
+		}
+
+		if (ret)
+			break;
+	}
+	iommu_put_resv_regions(dev, &resv_regions);
+
+	return ret;
+}
+
 static void iova_reserve_pci_windows(struct pci_dev *dev,
 		struct iova_domain *iovad)
 {
@@ -251,6 +314,8 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 		init_iova_domain(iovad, 1UL << order, base_pfn, end_pfn);
 		if (pci)
 			iova_reserve_pci_windows(to_pci_dev(dev), iovad);
+		if (dev)
+			iova_reserve_iommu_regions(dev, domain);
 	}
 	return 0;
 }
-- 
2.11.0.dirty
