From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 02/15] PCI: quirk pci_for_each_dma_alias()
Date: Fri, 09 May 2014 09:28:37 -0600
Message-ID: <20140509152837.8321.90171.stgit@bling.home>
References: <20140509151735.8321.22017.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140509151735.8321.22017.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

There are a few broken devices that use the requester ID of a different
function in the slot for their DMA.  To handle these, add a bitmap to
struct pci_dev (using an alignment gap) that quirks can populate.  As
we iterate over the device and bus DMA aliases, also iterate over any
bits in the map.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/pci/search.c |   21 +++++++++++++++++++++
 include/linux/pci.h  |    2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index 5601cdb..ad698b2 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -37,6 +37,27 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
+	/*
+	 * dma_func_alias provides a bitmap of other function numbers on
+	 * this same PCI slot to use as DMA aliases.
+	 */
+	if (unlikely(pdev->dma_func_alias)) {
+		u8 map = pdev->dma_func_alias & ~(1 << PCI_FUNC(pdev->devfn));
+		int func;
+
+		for (func = 0; map && func < 8; func++, map >>= 1) {
+			if (!(map & 1))
+				continue;
+
+			ret = fn(pdev,
+				 PCI_DEVID(pdev->bus->number,
+					   PCI_DEVFN(PCI_SLOT(pdev->devfn),
+					   func)), data);
+			if (ret)
+				return ret;
+		}
+	}
+
 	for (bus = pdev->bus; !pci_is_root_bus(bus); bus = bus->parent) {
 		struct pci_dev *tmp;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 14b074b..b4c97d2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -268,6 +268,8 @@ struct pci_dev {
 	u8		rom_base_reg;	/* which config register controls the ROM */
 	u8		pin;		/* which interrupt pin this device uses */
 	u16		pcie_flags_reg;	/* cached PCIe Capabilities Register */
+	u8		dma_func_alias;	/* bitmap of functions used as DMA
+					   aliases for this device */
 
 	struct pci_driver *driver;	/* which driver has allocated this device */
 	u64		dma_mask;	/* Mask of the bits of bus address this
