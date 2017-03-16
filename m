From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 3/4] iommu/dma: Handle IOMMU API reserved regions
Date: Thu, 16 Mar 2017 17:00:18 +0000
Message-ID: <a8e9c04c92e708232f8787844f9e8b7cfc518e86.1489683129.git.robin.murphy@arm.com>
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

Now that it's simple to discover the necessary reservations for a given
device/IOMMU combination, let's wire up the appropriate handling. Basic
reserved regions and direct-mapped regions we simply have to carve out
of IOVA space (the IOMMU core having already mapped the latter before
attaching the device). For hardware MSI regions, we also pre-populate
the cookie with matching msi_pages. That way, irqchip drivers which
normally assume MSIs to require mapping at the IOMMU can keep working
without having to special-case their iommu_dma_map_msi_msg() hook, or
indeed be aware at all of quirks preventing the IOMMU from translating
certain addresses.

Reviewed-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

Notes:
    v2:
    - Make the IOVA alignment logic safer [Eric]
    - Don't duplicate direct region mapping [Eric]
    - Don't wait for the subsequent patch to start using the return value [Eric]
    - Fix the sneaky off-by-one for pfn_hi
    - Minor cosmetic tweaks

 drivers/iommu/dma-iommu.c | 76 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 69 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 1e0983488a8d..5787f919f4ec 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -184,6 +184,66 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
 	}
 }
 
+static int cookie_init_hw_msi_region(struct iommu_dma_cookie *cookie,
+		phys_addr_t start, phys_addr_t end)
+{
+	struct iova_domain *iovad = &cookie->iovad;
+	struct iommu_dma_msi_page *msi_page;
+	int i, num_pages;
+
+	start -= iova_offset(iovad, start);
+	num_pages = iova_align(iovad, end - start) >> iova_shift(iovad);
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
+	LIST_HEAD(resv_regions);
+	int ret = 0;
+
+	if (dev_is_pci(dev))
+		iova_reserve_pci_windows(to_pci_dev(dev), iovad);
+
+	iommu_get_resv_regions(dev, &resv_regions);
+	list_for_each_entry(region, &resv_regions, list) {
+		unsigned long lo, hi;
+
+		/* We ARE the software that manages these! */
+		if (region->type == IOMMU_RESV_SW_MSI)
+			continue;
+
+		lo = iova_pfn(iovad, region->start);
+		hi = iova_pfn(iovad, region->start + region->length - 1);
+		reserve_iova(iovad, lo, hi);
+
+		if (region->type == IOMMU_RESV_MSI)
+			ret = cookie_init_hw_msi_region(cookie, region->start,
+					region->start + region->length);
+		if (ret)
+			break;
+	}
+	iommu_put_resv_regions(dev, &resv_regions);
+
+	return ret;
+}
+
 /**
  * iommu_dma_init_domain - Initialise a DMA mapping domain
  * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
@@ -202,7 +262,6 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	unsigned long order, base_pfn, end_pfn;
-	bool pci = dev && dev_is_pci(dev);
 
 	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
 		return -EINVAL;
@@ -232,7 +291,7 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	 * leave the cache limit at the top of their range to save an rb_last()
 	 * traversal on every allocation.
 	 */
-	if (pci)
+	if (dev && dev_is_pci(dev))
 		end_pfn &= DMA_BIT_MASK(32) >> order;
 
 	/* start_pfn is always nonzero for an already-initialised domain */
@@ -247,12 +306,15 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 		 * area cache limit down for the benefit of the smaller one.
 		 */
 		iovad->dma_32bit_pfn = min(end_pfn, iovad->dma_32bit_pfn);
-	} else {
-		init_iova_domain(iovad, 1UL << order, base_pfn, end_pfn);
-		if (pci)
-			iova_reserve_pci_windows(to_pci_dev(dev), iovad);
+
+		return 0;
 	}
-	return 0;
+
+	init_iova_domain(iovad, 1UL << order, base_pfn, end_pfn);
+	if (!dev)
+		return 0;
+
+	return iova_reserve_iommu_regions(dev, domain);
 }
 EXPORT_SYMBOL(iommu_dma_init_domain);
 
-- 
2.11.0.dirty
