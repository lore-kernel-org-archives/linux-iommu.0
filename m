From: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3 1/3] PCI: Add dma-resv window list
Date: Fri, 25 Jan 2019 15:43:49 +0530
Message-ID: <1548411231-27549-2-git-send-email-srinath.mannam@broadcom.com>
References: <1548411231-27549-1-git-send-email-srinath.mannam@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548411231-27549-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, poza@codeaurora.org, Ray Jui <rjui@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Srinath Mannam <srinath.mannam@broadcom.com>
List-Id: iommu@lists.linux-foundation.org

Add a dma_resv parameter in PCI host bridge structure to hold resource
entries list of memory regions for which IOVAs have to reserve.

PCIe host driver will add resource entries to this list based on its
requirements. Few inbound address ranges can't be allowed by few PCIe host,
so those address ranges will be add to this list to avoid IOMMU mapping.

While initializing IOMMU domain of PCI EPs connected to that host bridge
IOVAs for this given list of address ranges will be reserved.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
---
 drivers/pci/probe.c | 3 +++
 include/linux/pci.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 257b9f6..fd4b143 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -544,6 +544,7 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
 		return NULL;
 
 	INIT_LIST_HEAD(&bridge->windows);
+	INIT_LIST_HEAD(&bridge->dma_resv);
 	bridge->dev.release = pci_release_host_bridge_dev;
 
 	/*
@@ -572,6 +573,7 @@ struct pci_host_bridge *devm_pci_alloc_host_bridge(struct device *dev,
 		return NULL;
 
 	INIT_LIST_HEAD(&bridge->windows);
+	INIT_LIST_HEAD(&bridge->dma_resv);
 	bridge->dev.release = devm_pci_release_host_bridge_dev;
 
 	return bridge;
@@ -581,6 +583,7 @@ EXPORT_SYMBOL(devm_pci_alloc_host_bridge);
 void pci_free_host_bridge(struct pci_host_bridge *bridge)
 {
 	pci_free_resource_list(&bridge->windows);
+	pci_free_resource_list(&bridge->dma_resv);
 
 	kfree(bridge);
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 65f1d8c..aa06105 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -487,6 +487,7 @@ struct pci_host_bridge {
 	void		*sysdata;
 	int		busnr;
 	struct list_head windows;	/* resource_entry */
+	struct list_head dma_resv;	/* reserv dma ranges */
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
-- 
2.7.4
