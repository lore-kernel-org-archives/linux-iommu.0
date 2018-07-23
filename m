From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 2/7] dma-mapping: Generalise dma_32bit_limit flag
Date: Mon, 23 Jul 2018 23:16:07 +0100
Message-ID: <c1720f0181b66f711e4097d85149757b16a7b0a7.1532382222.git.robin.murphy@arm.com>
References: <cover.1532382222.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1532382222.git.robin.murphy@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: hch@lst.de, m.szyprowski@samsung.com
Cc: lorenzo.pieralisi@arm.com, gregkh@linuxfoundation.org, joro@8bytes.org, x86@kernel.org, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, robh+dt@kernel.org, hanjun.guo@linaro.org, sudeep.holla@arm.com, frowand.list@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Whilst the notion of an upstream DMA restriction is most commonly seen
in PCI host bridges saddled with a 32-bit native interface, a more
general version of the same issue can exist on complex SoCs where a bus
or point-to-point interconnect link from a device's DMA master interface
to another component along the path to memory (often an IOMMU) may carry
fewer address bits than the interfaces at both ends nominally support.
In order to properly deal with this, the first step is to expand the
dma_32bit_limit flag into an arbitrary mask.

To minimise the impact on existing code, we'll make sure to only
consider this new mask valid if set. That makes sense anyway, since a
mask of zero would represent DMA not being wired up at all, and that
would be better handled by not providing valid ops in the first place.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/x86/kernel/pci-dma.c | 2 +-
 include/linux/device.h    | 6 +++---
 kernel/dma/direct.c       | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index ab5d9dd668d2..c29b0d453db3 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -175,7 +175,7 @@ rootfs_initcall(pci_iommu_init);
 
 static int via_no_dac_cb(struct pci_dev *pdev, void *data)
 {
-	pdev->dev.dma_32bit_limit = true;
+	pdev->bus_dma_mask = DMA_BIT_MASK(32);
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
index 8be8106270c2..c2860c5a9e96 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -180,10 +180,10 @@ int dma_direct_supported(struct device *dev, u64 mask)
 		return 0;
 #endif
 	/*
-	 * Various PCI/PCIe bridges have broken support for > 32bit DMA even
-	 * if the device itself might support it.
+	 * Upstream PCI/PCIe bridges or SoC interconnects may not carry
+	 * as many DMA address bits as the device itself supports.
 	 */
-	if (dev->dma_32bit_limit && mask > DMA_BIT_MASK(32))
+	if (dev->bus_dma_mask && mask > dev->bus_dma_mask)
 		return 0;
 	return 1;
 }
-- 
2.17.1.dirty
