From: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3 2/3] iommu/dma: Reserve IOVA for PCI host reserve address list
Date: Fri, 25 Jan 2019 15:43:50 +0530
Message-ID: <1548411231-27549-3-git-send-email-srinath.mannam@broadcom.com>
References: <1548411231-27549-1-git-send-email-srinath.mannam@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548411231-27549-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, poza@codeaurora.org, Ray Jui <rjui@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Srinath Mannam <srinath.mannam@broadcom.com>
List-Id: iommu@lists.linux-foundation.org

PCI host bridge has list of resource entries contain address ranges for
which IOVA address mapping has to be reserve. These address ranges are
the address holes in dma-ranges DT property.

It is similar to PCI IO resources address ranges reserving in IOMMU for
each EP connected to host bridge.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
---
 drivers/iommu/dma-iommu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d19f3d6..81b591b 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -221,6 +221,14 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
 		hi = iova_pfn(iovad, window->res->end - window->offset);
 		reserve_iova(iovad, lo, hi);
 	}
+
+	/* Get reserved DMA windows from host bridge */
+	resource_list_for_each_entry(window, &bridge->dma_resv) {
+
+		lo = iova_pfn(iovad, window->res->start - window->offset);
+		hi = iova_pfn(iovad, window->res->end - window->offset);
+		reserve_iova(iovad, lo, hi);
+	}
 }
 
 static int iova_reserve_iommu_regions(struct device *dev,
-- 
2.7.4
