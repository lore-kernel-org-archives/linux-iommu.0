From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/5] pci: Add PCI DMA source ID quirk
Date: Tue, 29 May 2012 22:48:34 -0600
Message-ID: <20120530044834.1164.9081.stgit@bling.home>
References: <20120530043142.1164.63415.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120530043142.1164.63415.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

DMA transactions are tagged with the source ID of the device making
the request.  Occasionally hardware screws this up and uses the
source ID of a different device (often the wrong function number of
a multifunction device).  A specific Ricoh multifunction device is
a prime example of this problem and included in this patch.  The
purpose of this function is that given a pci_dev, return the pci_dev
to use as the source ID for DMA.  When hardware works correctly,
this returns the input device.  For the components of the Ricoh
multifunction device, return the pci_dev for function 0.

This will be used by IOMMU drivers for determining the boundaries
of IOMMU groups as multiple devices using the same source ID must
be contained within the same group.  This can also be used by
existing streaming DMA paths for the same purpose.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---

 drivers/pci/quirks.c |   40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h  |    5 +++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 2a75216..004e167 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3179,3 +3179,43 @@ int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 
 	return -ENOTTY;
 }
+
+static struct pci_dev *pci_func_0_dma_source(struct pci_dev *dev)
+{
+	return pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
+}
+
+static const struct pci_dev_dma_source {
+	u16 vendor;
+	u16 device;
+	struct pci_dev *(*dma_source)(struct pci_dev *dev);
+} pci_dev_dma_source[] = {
+	/*
+	 * https://bugzilla.redhat.com/show_bug.cgi?id=605888
+	 *
+	 * Some Ricoh devices use the function 0 source ID for DMA on
+	 * other functions of a multifunction device.  The DMA devices
+	 * is therefore function 0, which will have implications of the
+	 * iommu grouping of these devices.
+	 */
+	{ PCI_VENDOR_ID_RICOH, 0xe822, pci_func_0_dma_source },
+	{ PCI_VENDOR_ID_RICOH, 0xe230, pci_func_0_dma_source },
+	{ PCI_VENDOR_ID_RICOH, 0xe832, pci_func_0_dma_source },
+	{ PCI_VENDOR_ID_RICOH, 0xe832, pci_func_0_dma_source },
+	{ 0 }
+};
+
+struct pci_dev *pci_dma_source(struct pci_dev *dev)
+{
+	const struct pci_dev_dma_source *i;
+
+	for (i = pci_dev_dma_source; i->dma_source; i++) {
+		if ((i->vendor == dev->vendor ||
+		     i->vendor == (u16)PCI_ANY_ID) &&
+		    (i->device == dev->device ||
+		     i->device == (u16)PCI_ANY_ID))
+			return i->dma_source(dev);
+	}
+
+	return dev;
+}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d8c379d..5bc7502 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1486,9 +1486,14 @@ enum pci_fixup_pass {
 
 #ifdef CONFIG_PCI_QUIRKS
 void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev);
+struct pci_dev *pci_dma_source(struct pci_dev *dev);
 #else
 static inline void pci_fixup_device(enum pci_fixup_pass pass,
 				    struct pci_dev *dev) {}
+static inline struct pci_dev *pci_dma_source(struct pci_dev *dev)
+{
+	return dev;
+}
 #endif
 
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
