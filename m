From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 3/2] pci: Remove unused pci_find_upstream_pcie_bridge()
Date: Tue, 28 May 2013 16:53:11 -0600
Message-ID: <20130528225045.15653.3333.stgit@bling.home>
References: <20130528183527.3318.5365.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130528183527.3318.5365.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: stephen-OTpzqLSitTUnbdJkjeBofR2eb7JE58TQ@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This no longer has any users.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Acked-by: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
---

I figured I'd follow up with this after the series is accepted, but I
won't turn down an pre-emptive ack from Bjorn.

 drivers/pci/search.c |   35 -----------------------------------
 include/linux/pci.h  |   11 -----------
 2 files changed, 46 deletions(-)

diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index d0627fa..da2e82e 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -17,41 +17,6 @@
 DECLARE_RWSEM(pci_bus_sem);
 EXPORT_SYMBOL_GPL(pci_bus_sem);
 
-/*
- * find the upstream PCIe-to-PCI bridge of a PCI device
- * if the device is PCIE, return NULL
- * if the device isn't connected to a PCIe bridge (that is its parent is a
- * legacy PCI bridge and the bridge is directly connected to bus 0), return its
- * parent
- */
-struct pci_dev *
-pci_find_upstream_pcie_bridge(struct pci_dev *pdev)
-{
-	struct pci_dev *tmp = NULL;
-
-	if (pci_is_pcie(pdev))
-		return NULL;
-	while (1) {
-		if (pci_is_root_bus(pdev->bus))
-			break;
-		pdev = pdev->bus->self;
-		/* a p2p bridge */
-		if (!pci_is_pcie(pdev)) {
-			tmp = pdev;
-			continue;
-		}
-		/* PCI device should connect to a PCIe bridge */
-		if (pci_pcie_type(pdev) != PCI_EXP_TYPE_PCI_BRIDGE) {
-			/* Busted hardware? */
-			WARN_ON_ONCE(1);
-			return NULL;
-		}
-		return pdev;
-	}
-
-	return tmp;
-}
-
 static struct pci_bus *pci_do_find_bus(struct pci_bus *bus, unsigned char busnr)
 {
 	struct pci_bus* child;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 710067f..890d426 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1851,15 +1851,4 @@ static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
 }
 #endif
 
-/**
- * pci_find_upstream_pcie_bridge - find upstream PCIe-to-PCI bridge of a device
- * @pdev: the PCI device
- *
- * if the device is PCIE, return NULL
- * if the device isn't connected to a PCIe bridge (that is its parent is a
- * legacy PCI bridge and the bridge is directly connected to bus 0), return its
- * parent
- */
-struct pci_dev *pci_find_upstream_pcie_bridge(struct pci_dev *pdev);
-
 #endif /* LINUX_PCI_H */
