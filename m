From: Jacek Lawrynowicz <jacek.lawrynowicz-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] iommu/vt-d: Add support for multiple DMA aliases
Date: Fri,  6 Nov 2015 16:21:31 +0100
Message-ID: <1446823291-22486-1-git-send-email-jacek.lawrynowicz@intel.com>
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
To: iommu-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org
Cc: david.woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch solves IOMMU support issues with PCIe non-transparent bridges
that use Requester ID look-up tables (LUT), e.g. PEX8733. Before exiting
the bridge, packet's RID is rewritten according to LUT programmed by
a driver. Modified packets are then passed to a destination bus and
processed upstream. The problem is that such packets seem to come from
non-existent nodes that are hidden behind NTB and are not discoverable
by a destination node, so IOMMU discards them. Adding DMA alias for a
given LUT entry allows IOMMU to create a proper mapping that enables
inter-node communication.

The current DMA alias implementation supports only single alias, so it's
not possible to connect more than two nodes when IOMMU is enabled. This
implementation enables all possible aliases on a given bus (256) that
are stored in a bitset. Alias devfn is directly translated to a bit
number. The bitset is not allocated for devices that have no need for
DMA aliases.

More details can be found in following article:
http://www.plxtech.com/files/pdf/technical/expresslane/RTC_Enabling%20MulitHostSystemDesigns.pdf

Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/amd_iommu.c |  3 +--
 drivers/iommu/iommu.c     |  8 ++++----
 drivers/pci/pci.c         | 19 +++++++++++++++++++
 drivers/pci/probe.c       |  1 +
 drivers/pci/quirks.c      | 15 ++++++---------
 drivers/pci/search.c      | 14 +++++++++-----
 include/linux/pci.h       | 15 ++++++++-------
 7 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 532e2a2..35a67b2 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -363,8 +363,7 @@ static u16 get_alias(struct device *dev)
 	 */
 	if (pci_alias == devid &&
 	    PCI_BUS_NUM(ivrs_alias) == pdev->bus->number) {
-		pdev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
-		pdev->dma_alias_devfn = ivrs_alias & 0xff;
+		pci_add_dma_alias(pdev, ivrs_alias & 0xff);
 		pr_info("AMD-Vi: Added PCI DMA alias %02x.%d for %s\n",
 			PCI_SLOT(ivrs_alias), PCI_FUNC(ivrs_alias),
 			dev_name(dev));
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 049df49..53d58b3 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -686,10 +686,10 @@ static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
 			continue;
 
 		/* We alias them or they alias us */
-		if (((pdev->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN) &&
-		     pdev->dma_alias_devfn == tmp->devfn) ||
-		    ((tmp->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN) &&
-		     tmp->dma_alias_devfn == pdev->devfn)) {
+		if ((pdev->dma_alias_mask &&
+		     test_bit(tmp->devfn, pdev->dma_alias_mask)) ||
+		    ((tmp->dma_alias_mask &&
+		     test_bit(pdev->devfn, tmp->dma_alias_mask)))) {
 
 			group = get_pci_alias_group(tmp, devfns);
 			if (group) {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6a9a111..ccdb598c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4297,6 +4297,25 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
 	return 0;
 }
 
+/**
+ * pci_add_dma_alias - Allows to add multiple devfn aliases for given device
+ * @dev: the PCI device for which alias is added
+ * @devfn: alias slot and function
+ *
+ * This helper encodes 8-bit devfn as bit number in dma_alias_mask
+ */
+void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
+{
+	if (!dev->dma_alias_mask) {
+		dev->dma_alias_mask = kcalloc(BITS_TO_LONGS(U8_MAX),
+					      sizeof(long), GFP_KERNEL);
+		dev_warn(&dev->dev, "Unable to allocate DMA alias mask.\n");
+	}
+	if (dev->dma_alias_mask)
+		set_bit(devfn, dev->dma_alias_mask);
+}
+EXPORT_SYMBOL_GPL(pci_add_dma_alias);
+
 bool pci_device_is_present(struct pci_dev *pdev)
 {
 	u32 v;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8361d27..b258e9a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1505,6 +1505,7 @@ static void pci_release_dev(struct device *dev)
 	pcibios_release_device(pci_dev);
 	pci_bus_put(pci_dev->bus);
 	kfree(pci_dev->driver_override);
+	kfree(pci_dev->dma_alias_mask);
 	kfree(pci_dev);
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b03373f..6cb711b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3567,8 +3567,7 @@ int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 static void quirk_dma_func0_alias(struct pci_dev *dev)
 {
 	if (PCI_FUNC(dev->devfn) != 0) {
-		dev->dma_alias_devfn = PCI_DEVFN(PCI_SLOT(dev->devfn), 0);
-		dev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
+		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
 	}
 }
 
@@ -3583,8 +3582,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, 0xe476, quirk_dma_func0_alias);
 static void quirk_dma_func1_alias(struct pci_dev *dev)
 {
 	if (PCI_FUNC(dev->devfn) != 1) {
-		dev->dma_alias_devfn = PCI_DEVFN(PCI_SLOT(dev->devfn), 1);
-		dev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
+		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 1));
 	}
 }
 
@@ -3648,11 +3646,10 @@ static void quirk_fixed_dma_alias(struct pci_dev *dev)
 
 	id = pci_match_id(fixed_dma_alias_tbl, dev);
 	if (id) {
-		dev->dma_alias_devfn = id->driver_data;
-		dev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
-		dev_info(&dev->dev, "Enabling fixed DMA alias to %02x.%d\n",
-			 PCI_SLOT(dev->dma_alias_devfn),
-			 PCI_FUNC(dev->dma_alias_devfn));
+		pci_add_dma_alias(dev, id->driver_data);
+		dev_info(&dev->dev, "Enabling fixed DMA alias to %02lx.%ld\n",
+			 PCI_SLOT(id->driver_data),
+			 PCI_FUNC(id->driver_data));
 	}
 }
 
diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index a20ce7d..33e0f03 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -40,11 +40,15 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 	 * If the device is broken and uses an alias requester ID for
 	 * DMA, iterate over that too.
 	 */
-	if (unlikely(pdev->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN)) {
-		ret = fn(pdev, PCI_DEVID(pdev->bus->number,
-					 pdev->dma_alias_devfn), data);
-		if (ret)
-			return ret;
+	if (unlikely(pdev->dma_alias_mask)) {
+		u8 devfn;
+
+		for_each_set_bit(devfn, pdev->dma_alias_mask, U8_MAX) {
+			ret = fn(pdev, PCI_DEVID(pdev->bus->number, devfn),
+				 data);
+			if (ret)
+				return ret;
+		}
 	}
 
 	for (bus = pdev->bus; !pci_is_root_bus(bus); bus = bus->parent) {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e90eb22..fae187d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -172,16 +172,14 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_ASSIGNED = (__force pci_dev_flags_t) (1 << 2),
 	/* Flag for quirk use to store if quirk-specific ACS is enabled */
 	PCI_DEV_FLAGS_ACS_ENABLED_QUIRK = (__force pci_dev_flags_t) (1 << 3),
-	/* Flag to indicate the device uses dma_alias_devfn */
-	PCI_DEV_FLAGS_DMA_ALIAS_DEVFN = (__force pci_dev_flags_t) (1 << 4),
 	/* Use a PCIe-to-PCI bridge alias even if !pci_is_pcie */
-	PCI_DEV_FLAG_PCIE_BRIDGE_ALIAS = (__force pci_dev_flags_t) (1 << 5),
+	PCI_DEV_FLAG_PCIE_BRIDGE_ALIAS = (__force pci_dev_flags_t) (1 << 4),
 	/* Do not use bus resets for device */
-	PCI_DEV_FLAGS_NO_BUS_RESET = (__force pci_dev_flags_t) (1 << 6),
+	PCI_DEV_FLAGS_NO_BUS_RESET = (__force pci_dev_flags_t) (1 << 5),
 	/* Do not use PM reset even if device advertises NoSoftRst- */
-	PCI_DEV_FLAGS_NO_PM_RESET = (__force pci_dev_flags_t) (1 << 7),
+	PCI_DEV_FLAGS_NO_PM_RESET = (__force pci_dev_flags_t) (1 << 6),
 	/* Get VPD from function 0 VPD */
-	PCI_DEV_FLAGS_VPD_REF_F0 = (__force pci_dev_flags_t) (1 << 8),
+	PCI_DEV_FLAGS_VPD_REF_F0 = (__force pci_dev_flags_t) (1 << 7),
 };
 
 enum pci_irq_reroute_variant {
@@ -279,7 +277,7 @@ struct pci_dev {
 	u8		rom_base_reg;	/* which config register controls the ROM */
 	u8		pin;		/* which interrupt pin this device uses */
 	u16		pcie_flags_reg;	/* cached PCIe Capabilities Register */
-	u8		dma_alias_devfn;/* devfn of DMA alias, if any */
+	unsigned long	*dma_alias_mask;/* mask of enabled devfn aliases */
 
 	struct pci_driver *driver;	/* which driver has allocated this device */
 	u64		dma_mask;	/* Mask of the bits of bus address this
@@ -1217,6 +1215,9 @@ resource_size_t pcibios_iov_resource_alignment(struct pci_dev *dev, int resno);
 
 int pci_set_vga_state(struct pci_dev *pdev, bool decode,
 		      unsigned int command_bits, u32 flags);
+
+void pci_add_dma_alias(struct pci_dev *dev, u8 devfn);
+
 /* kmem_cache style wrapper around pci_alloc_consistent() */
 
 #include <linux/pci-dma.h>
-- 
2.5.0
