From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 05/13] pci: Add ACS validation utility
Date: Mon, 21 May 2012 23:05:08 -0600
Message-ID: <20120522050508.5871.96269.stgit@bling.home>
References: <20120522043607.5871.11340.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120522043607.5871.11340.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org, joerg.roedel-5C7GfCeVMHo@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, benve-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

In a PCI environment, transactions aren't always required to reach
the root bus before being re-routed.  Intermediate switches between
an endpoint and the root bus can redirect DMA back downstream before
things like IOMMUs have a chance to intervene.  Legacy PCI is always
susceptible to this as it operates on a shared bus.  PCIe added a
new capability to describe and control this behavior, Access Control
Services, or ACS.  The utility function pci_acs_enabled() allows us
to test the ACS capabilities of an individual devices against a set
of flags while pci_acs_path_enabled() tests a complete path from
a given downstream device up to the specified upstream device.  We
also include the ability to add device specific tests as it's
likely we'll see devices that do no implement ACS, but want to
indicate support for various capabilities in this space.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---

 drivers/pci/pci.c    |   76 ++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/quirks.c |   29 +++++++++++++++++++
 include/linux/pci.h  |   10 ++++++-
 3 files changed, 114 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 111569c..ab6c2a6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2359,6 +2359,82 @@ void pci_enable_acs(struct pci_dev *dev)
 }
 
 /**
+ * pci_acs_enable - test ACS against required flags for a given device
+ * @pdev: device to test
+ * @acs_flags: required PCI ACS flags
+ *
+ * Return true if the device supports the provided flags.  Automatically
+ * filters out flags that are not implemented on multifunction devices.
+ */
+bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
+{
+	int pos;
+	u16 ctrl;
+
+	if (pci_dev_specific_acs_enabled(pdev, acs_flags))
+		return true;
+
+	if (!pci_is_pcie(pdev))
+		return false;
+
+	if (pdev->pcie_type == PCI_EXP_TYPE_DOWNSTREAM ||
+	    pdev->pcie_type == PCI_EXP_TYPE_ROOT_PORT) {
+		pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ACS);
+		if (!pos)
+			return false;
+
+		pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl);
+		if ((ctrl & acs_flags) != acs_flags)
+			return false;
+	} else if (pdev->multifunction) {
+		/* Filter out flags not applicable to multifunction */
+		acs_flags &= (PCI_ACS_RR | PCI_ACS_CR |
+			      PCI_ACS_EC | PCI_ACS_DT);
+
+		pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ACS);
+		if (!pos)
+			return false;
+
+		pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl);
+		if ((ctrl & acs_flags) != acs_flags)
+			return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(pci_acs_enabled);
+
+/**
+ * pci_acs_path_enable - test ACS flags from start to end in a hierarchy
+ * @start: starting downstream device
+ * @end: ending upstream device or NULL to search to the root bus
+ * @acs_flags: required flags
+ *
+ * Walk up a device tree from start to end testing PCI ACS support.  If
+ * any step along the way does not support the required flags, return false.
+ */
+bool pci_acs_path_enabled(struct pci_dev *start,
+			  struct pci_dev *end, u16 acs_flags)
+{
+	struct pci_dev *pdev, *parent = start;
+
+	do {
+		pdev = parent;
+
+		if (!pci_acs_enabled(pdev, acs_flags))
+			return false;
+
+		if (pci_is_root_bus(pdev->bus))
+			return (end == NULL);
+
+		parent = pdev->bus->self;
+	} while (pdev != end);
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(pci_acs_path_enabled);
+
+/**
  * pci_swizzle_interrupt_pin - swizzle INTx for device behind bridge
  * @dev: the PCI device
  * @pin: the INTx pin (1=INTA, 2=INTB, 3=INTD, 4=INTD)
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a2dd77f..4ed6aa6 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3149,3 +3149,32 @@ struct pci_dev *pci_dma_source(struct pci_dev *dev)
 
 	return dev;
 }
+
+static const struct pci_dev_acs_enabled {
+	u16 vendor;
+	u16 device;
+	bool (*acs_enabled)(struct pci_dev *dev, u16 acs_flags);
+} pci_dev_acs_enabled[] = {
+	{ 0 }
+};
+
+bool pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags)
+{
+	const struct pci_dev_acs_enabled *i;
+
+	/*
+	 * Allow devices that do not expose standard PCI ACS capabilities
+	 * or control to indicate their support here.  Multi-function devices
+	 * which do not allow internal peer-to-peer between functions, but
+	 * do not implement PCI ACS may wish to return true here.
+	 */
+	for (i = pci_dev_acs_enabled; i->acs_enabled; i++) {
+		if ((i->vendor == dev->vendor ||
+		     i->vendor == (u16)PCI_ANY_ID) &&
+		    (i->device == dev->device ||
+		     i->device == (u16)PCI_ANY_ID))
+			return i->acs_enabled(dev, acs_flags);
+	}
+
+	return false;
+}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 02dbfed..2559735 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1480,6 +1480,7 @@ enum pci_fixup_pass {
 #ifdef CONFIG_PCI_QUIRKS
 void pci_fixup_device(enum pci_fixup_pass pass, struct pci_dev *dev);
 struct pci_dev *pci_dma_source(struct pci_dev *dev);
+bool pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
 #else
 static inline void pci_fixup_device(enum pci_fixup_pass pass,
 				    struct pci_dev *dev) {}
@@ -1487,6 +1488,11 @@ static inline struct pci_dev *pci_dma_source(struct pci_dev *dev)
 {
 	return dev;
 }
+static inline bool pci_dev_specific_acs_enabled(struct pci_dev *dev,
+						u16 acs_flags)
+{
+	return false;
+}
 #endif
 
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
@@ -1589,7 +1595,9 @@ static inline bool pci_is_pcie(struct pci_dev *dev)
 }
 
 void pci_request_acs(void);
-
+bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
+bool pci_acs_path_enabled(struct pci_dev *start,
+			  struct pci_dev *end, u16 acs_flags);
 
 #define PCI_VPD_LRDT			0x80	/* Large Resource Data Type */
 #define PCI_VPD_LRDT_ID(x)		(x | PCI_VPD_LRDT)
