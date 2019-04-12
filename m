From: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v4 2/3] iommu/dma: Reserve IOVA for PCIe inaccessible DMA address
Date: Fri, 12 Apr 2019 08:43:34 +0530
Message-ID: <1555038815-31916-3-git-send-email-srinath.mannam@broadcom.com>
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, poza@codeaurora.org, Ray Jui <rjui@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Srinath Mannam <srinath.mannam@broadcom.com>
List-Id: iommu@lists.linux-foundation.org

dma_ranges field of PCI host bridge structure has resource entries in
sorted order of address range given through dma-ranges DT property. This
list is the accessible DMA address range. So that this resource list will
be processed and reserve IOVA address to the inaccessible address holes in
the list.

This method is similar to PCI IO resources address ranges reserving in
IOMMU for each EP connected to host bridge.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
---
 drivers/iommu/dma-iommu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d19f3d6..fb42d7c 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -212,6 +212,7 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
 	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
 	struct resource_entry *window;
 	unsigned long lo, hi;
+	phys_addr_t start = 0, end;
 
 	resource_list_for_each_entry(window, &bridge->windows) {
 		if (resource_type(window->res) != IORESOURCE_MEM)
@@ -221,6 +222,24 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
 		hi = iova_pfn(iovad, window->res->end - window->offset);
 		reserve_iova(iovad, lo, hi);
 	}
+
+	/* Get reserved DMA windows from host bridge */
+	resource_list_for_each_entry(window, &bridge->dma_ranges) {
+		end = window->res->start - window->offset;
+resv_iova:
+		if (end - start) {
+			lo = iova_pfn(iovad, start);
+			hi = iova_pfn(iovad, end);
+			reserve_iova(iovad, lo, hi);
+		}
+		start = window->res->end - window->offset + 1;
+		/* If window is last entry */
+		if (window->node.next == &bridge->dma_ranges &&
+		    end != DMA_BIT_MASK(sizeof(dma_addr_t) * BITS_PER_BYTE)) {
+			end = DMA_BIT_MASK(sizeof(dma_addr_t) * BITS_PER_BYTE);
+			goto resv_iova;
+		}
+	}
 }
 
 static int iova_reserve_iommu_regions(struct device *dev,
-- 
2.7.4
