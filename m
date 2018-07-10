From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH 1/4] dma-mapping: Generalise dma_32bit_limit flag
Date: Tue, 10 Jul 2018 18:17:16 +0100
Message-ID: <a85a5fe22fced65b2960251fc6e8d8f1e68f828a.1531239284.git.robin.murphy@arm.com>
References: <cover.1531239284.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1531239284.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: hch-jcswGhMUV9g@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Whilst the notion of an upstream DMA restriction is most commonly seen
via PCI host bridges saddled with a 32-bit native interface, a more
general version of the same issue can exist on complex SoCs where a bus
or point-to-point interconnect link carries fewer address bits between a
device and a downstream component (often an IOMMU) than both blocks
nominally support. In order to properly deal with this, first grow the
dma_32bit_limit flag into an arbitrary mask.

To minimise the impact on existing code, we'll only consider this new
mask valid if set. That makes sense anyway, since cases where DMA is not
wired up at all would be better handled by not giving the device valid
ops in the first place.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 arch/x86/kernel/pci-dma.c | 2 +-
 include/linux/device.h    | 6 +++---
 kernel/dma/direct.c       | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index ab5d9dd668d2..0b60f2a9dace 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -175,7 +175,7 @@ rootfs_initcall(pci_iommu_init);
 
 static int via_no_dac_cb(struct pci_dev *pdev, void *data)
 {
-	pdev->dev.dma_32bit_limit = true;
+	pdev->dev_dma_mask = DMA_BIT_MASK(32);
 	return 0;
 }
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 055a69dbcd18..6d3b000be57e 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -886,6 +886,8 @@ struct dev_links_info {
  * @coherent_dma_mask: Like dma_mask, but for alloc_coherent mapping as not all
  * 		hardware supports 64-bit addresses for consistent allocations
  * 		such descriptors.
+ * @bus_dma_mask: Mask of an upstream bridge or bus which imposes a smaller DMA
+ *		limit than the device itself supports.
  * @dma_pfn_offset: offset of DMA memory range relatively of RAM
  * @dma_parms:	A low level driver may set these to teach IOMMU code about
  * 		segment limitations.
@@ -912,8 +914,6 @@ struct dev_links_info {
  * @offline:	Set after successful invocation of bus type's .offline().
  * @of_node_reused: Set if the device-tree node is shared with an ancestor
  *              device.
- * @dma_32bit_limit: bridge limited to 32bit DMA even if the device itself
- *		indicates support for a higher limit in the dma_mask field.
  *
  * At the lowest level, every device in a Linux system is represented by an
  * instance of struct device. The device structure contains the information
@@ -967,6 +967,7 @@ struct device {
 					     not all hardware supports
 					     64 bit addresses for consistent
 					     allocations such descriptors. */
+	u64		bus_dma_mask;	/* upstream dma_mask constraint */
 	unsigned long	dma_pfn_offset;
 
 	struct device_dma_parameters *dma_parms;
@@ -1002,7 +1003,6 @@ struct device {
 	bool			offline_disabled:1;
 	bool			offline:1;
 	bool			of_node_reused:1;
-	bool			dma_32bit_limit:1;
 };
 
 static inline struct device *kobj_to_dev(struct kobject *kobj)
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 8be8106270c2..95e185347e34 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -183,7 +183,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
 	 * Various PCI/PCIe bridges have broken support for > 32bit DMA even
 	 * if the device itself might support it.
 	 */
-	if (dev->dma_32bit_limit && mask > DMA_BIT_MASK(32))
+	if (dev->bus_dma_mask && mask > dev->bus_dma_mask)
 		return 0;
 	return 1;
 }
-- 
2.17.1.dirty
