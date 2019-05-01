From: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v5 3/3] PCI: iproc: Add sorted dma ranges resource entries to host bridge
Date: Wed,  1 May 2019 23:06:26 +0530
Message-ID: <1556732186-21630-4-git-send-email-srinath.mannam@broadcom.com>
References: <1556732186-21630-1-git-send-email-srinath.mannam@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556732186-21630-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, Eric Auger <eric.auger@redhat.com>, Joerg Roedel <joro@8bytes.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, poza@codeaurora.org, Ray Jui <rjui@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Srinath Mannam <srinath.mannam@broadcom.com>
List-Id: iommu@lists.linux-foundation.org

IPROC host has the limitation that it can use only those address ranges
given by dma-ranges property as inbound address. So that the memory
address holes in dma-ranges should be reserved to allocate as DMA address.

Inbound address of host accessed by PCIe devices will not be translated
before it comes to IOMMU or directly to PE. But the limitation of this
host is, access to few address ranges are ignored. So that IOVA ranges
for these address ranges have to be reserved.

All allowed address ranges are listed in dma-ranges DT parameter. These
address ranges are converted as resource entries and listed in sorted
order and added to dma_ranges list of PCI host bridge structure.

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
are not allowed to be used as inbound addresses.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index c20fd6b..94ba5c0 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -1146,11 +1146,43 @@ static int iproc_pcie_setup_ib(struct iproc_pcie *pcie,
 	return ret;
 }
 
+static int
+iproc_pcie_add_dma_range(struct device *dev, struct list_head *resources,
+			 struct of_pci_range *range)
+{
+	struct resource *res;
+	struct resource_entry *entry, *tmp;
+	struct list_head *head = resources;
+
+	res = devm_kzalloc(dev, sizeof(struct resource), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	resource_list_for_each_entry(tmp, resources) {
+		if (tmp->res->start < range->cpu_addr)
+			head = &tmp->node;
+	}
+
+	res->start = range->cpu_addr;
+	res->end = res->start + range->size - 1;
+
+	entry = resource_list_create_entry(res, 0);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->offset = res->start - range->cpu_addr;
+	resource_list_add(entry, head);
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
+	LIST_HEAD(resources);
 
 	/* Get the dma-ranges from DT */
 	ret = of_pci_dma_range_parser_init(&parser, pcie->dev->of_node);
@@ -1158,13 +1190,23 @@ static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
 		return ret;
 
 	for_each_of_pci_range(&parser, &range) {
+		ret = iproc_pcie_add_dma_range(pcie->dev,
+					       &resources,
+					       &range);
+		if (ret)
+			goto out;
 		/* Each range entry corresponds to an inbound mapping region */
 		ret = iproc_pcie_setup_ib(pcie, &range, IPROC_PCIE_IB_MAP_MEM);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
+	list_splice_init(&resources, &host->dma_ranges);
+
 	return 0;
+out:
+	pci_free_resource_list(&resources);
+	return ret;
 }
 
 static int iproce_pcie_get_msi(struct iproc_pcie *pcie,
-- 
2.7.4
