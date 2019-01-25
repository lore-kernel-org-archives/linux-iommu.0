From: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3 3/3] PCI: iproc: Add dma reserve resources to host
Date: Fri, 25 Jan 2019 15:43:51 +0530
Message-ID: <1548411231-27549-4-git-send-email-srinath.mannam@broadcom.com>
References: <1548411231-27549-1-git-send-email-srinath.mannam@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548411231-27549-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, poza@codeaurora.org, Ray Jui <rjui@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Srinath Mannam <srinath.mannam@broadcom.com>
List-Id: iommu@lists.linux-foundation.org

IPROC host has the limitation that it can use only those address ranges
given by dma-ranges property as inbound address. So that the memory
address holes in dma-ranges should be reserved to allocate as DMA address.

Inbound address of host accessed by PCIe devices will not be translated
before it comes to IOMMU or directly to PE. But the limitation of this
host is, access to few address ranges are ignored. So that IOVA ranges
for these address ranges have to be reserved.

All such addresses ranges are created as resource entries by parsing
dma-ranges DT parameter and add to dma_resv list of PCI host bridge.

Ex:
dma-ranges = < \
  0x43000000 0x00 0x80000000 0x00 0x80000000 0x00 0x80000000 \
  0x43000000 0x08 0x00000000 0x08 0x00000000 0x08 0x00000000 \
  0x43000000 0x80 0x00000000 0x80 0x00000000 0x40 0x00000000>

In the above example of dma-ranges, memory address from
0x0 - 0x80000000,
0x100000000 - 0x800000000,
0x1000000000 - 0x8000000000 and
0x10000000000 - 0xffffffffffffffff.
are not allowed to use as inbound addresses.
So that we need to add these address ranges to dma_resv list to reserve
corresponding IOVA address ranges.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
---
 drivers/pci/controller/pcie-iproc.c | 51 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index c20fd6b..b7bef1c 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -1146,25 +1146,74 @@ static int iproc_pcie_setup_ib(struct iproc_pcie *pcie,
 	return ret;
 }
 
+static int
+iproc_pcie_add_dma_resv_range(struct device *dev, struct list_head *resources,
+			      uint64_t start, uint64_t end)
+{
+	struct resource *res;
+
+	res = devm_kzalloc(dev, sizeof(struct resource), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	res->start = (resource_size_t)start;
+	res->end = (resource_size_t)end;
+	pci_add_resource_offset(resources, res, 0);
+
+	return 0;
+}
+
 static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
 {
+	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
 	struct of_pci_range range;
 	struct of_pci_range_parser parser;
 	int ret;
+	uint64_t start, end;
+	LIST_HEAD(resources);
 
 	/* Get the dma-ranges from DT */
 	ret = of_pci_dma_range_parser_init(&parser, pcie->dev->of_node);
 	if (ret)
 		return ret;
 
+	start = 0;
 	for_each_of_pci_range(&parser, &range) {
+		end = range.pci_addr;
+		/* dma-ranges list expected in sorted order */
+		if (end < start) {
+			ret = -EINVAL;
+			goto out;
+		}
 		/* Each range entry corresponds to an inbound mapping region */
 		ret = iproc_pcie_setup_ib(pcie, &range, IPROC_PCIE_IB_MAP_MEM);
 		if (ret)
-			return ret;
+			goto out;
+
+		if (end - start) {
+			ret = iproc_pcie_add_dma_resv_range(pcie->dev,
+							    &resources,
+							    start, end);
+			if (ret)
+				goto out;
+		}
+		start = range.pci_addr + range.size;
 	}
 
+	end = DMA_BIT_MASK(sizeof(dma_addr_t) * BITS_PER_BYTE);
+	if (end - start) {
+		ret = iproc_pcie_add_dma_resv_range(pcie->dev, &resources,
+						    start, end);
+		if (ret)
+			goto out;
+	}
+
+	list_splice_init(&resources, &host->dma_resv);
+
 	return 0;
+out:
+	pci_free_resource_list(&resources);
+	return ret;
 }
 
 static int iproce_pcie_get_msi(struct iproc_pcie *pcie,
-- 
2.7.4
