From: Oza Pawandeep via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: [RFC PATCH] iommu/dma: check pci host bridge dma_mask for IOVA
	allocation
Date: Tue, 14 Mar 2017 14:18:47 +0530
Message-ID: <1489481327-2862-1-git-send-email-oza.oza@broadcom.com>
Reply-To: Oza Pawandeep <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

It is possible that PCI device supports 64-bit DMA addressing,
and thus it's driver sets device's dma_mask to DMA_BIT_MASK(64),
however PCI host bridge may have limitations on the inbound
transaction addressing. As an example, consider NVME SSD device
connected to iproc-PCIe controller.

Currently, the IOMMU DMA ops only considers PCI device dma_mask
when allocating an IOVA. This is particularly problematic on
ARM/ARM64 SOCs where the IOMMU (i.e. SMMU) translates IOVA to
PA for in-bound transactions only after PCI Host has forwarded
these transactions on SOC IO bus. This means on such ARM/ARM64
SOCs the IOVA of in-bound transactions has to honor the addressing
restrictions of the PCI Host.

This patch tries to solve above described IOVA allocation
problem by:
1. Adding iommu_get_dma_mask() to get dma_mask of any device
2. For PCI device, iommu_get_dma_mask() compare dma_mask of
PCI device and corresponding PCI Host dma_mask (if set).
3. Use iommu_get_dma_mask() in IOMMU DMA ops implementation
instead of dma_get_mask()

Signed-off-by: Oza Pawandeep <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Reviewed-by: Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Reviewed-by: Scott Branden <scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---
 drivers/iommu/dma-iommu.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 48d36ce..e93e536 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -108,6 +108,42 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
 }
 EXPORT_SYMBOL(iommu_get_dma_cookie);
 
+static u64 __iommu_dma_mask(struct device *dev, bool is_coherent)
+{
+#ifdef CONFIG_PCI
+	u64 pci_hb_dma_mask;
+
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+		struct pci_host_bridge *br = pci_find_host_bridge(pdev->bus);
+
+		if ((!is_coherent) && !(br->dev.dma_mask))
+			goto default_dev_dma_mask;
+
+		/* pci host bridge dma-mask. */
+		pci_hb_dma_mask = (!is_coherent) ? *br->dev.dma_mask :
+				   br->dev.coherent_dma_mask;
+
+		if (pci_hb_dma_mask && ((pci_hb_dma_mask) < (*dev->dma_mask)))
+			return pci_hb_dma_mask;
+	}
+default_dev_dma_mask:
+#endif
+	return (!is_coherent) ? dma_get_mask(dev) :
+		dev->coherent_dma_mask;
+}
+
+static u64 __iommu_dma_get_coherent_mask(struct device *dev)
+{
+	return __iommu_dma_mask(dev, true);
+}
+
+static u64 __iommu_dma_get_mask(struct device *dev)
+{
+	return __iommu_dma_mask(dev, false);
+}
+
+
 /**
  * iommu_get_msi_cookie - Acquire just MSI remapping resources
  * @domain: IOMMU domain to prepare
@@ -461,7 +497,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 	if (!pages)
 		return NULL;
 
-	iova = __alloc_iova(domain, size, dev->coherent_dma_mask, dev);
+	iova = __alloc_iova(domain, size, __iommu_dma_get_coherent_mask(dev), dev);
 	if (!iova)
 		goto out_free_pages;
 
@@ -532,7 +568,7 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 	struct iova_domain *iovad = cookie_iovad(domain);
 	size_t iova_off = iova_offset(iovad, phys);
 	size_t len = iova_align(iovad, size + iova_off);
-	struct iova *iova = __alloc_iova(domain, len, dma_get_mask(dev), dev);
+	struct iova *iova = __alloc_iova(domain, len, __iommu_dma_get_mask(dev), dev);
 
 	if (!iova)
 		return DMA_ERROR_CODE;
@@ -690,7 +726,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		prev = s;
 	}
 
-	iova = __alloc_iova(domain, iova_len, dma_get_mask(dev), dev);
+	iova = __alloc_iova(domain, iova_len, __iommu_dma_get_mask(dev), dev);
 	if (!iova)
 		goto out_restore_sg;
 
@@ -760,7 +796,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 
 	msi_page->phys = msi_addr;
 	if (iovad) {
-		iova = __alloc_iova(domain, size, dma_get_mask(dev), dev);
+		iova = __alloc_iova(domain, size, __iommu_dma_get_mask(dev), dev);
 		if (!iova)
 			goto out_free_page;
 		msi_page->iova = iova_dma_addr(iovad, iova);
-- 
1.9.1
