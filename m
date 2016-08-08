From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 4/8] of: dma: Split of_configure_dma() into mask and ops
	configuration
Date: Tue,  9 Aug 2016 04:19:06 +0530
Message-ID: <1470696550-3416-5-git-send-email-sricharan@codeaurora.org>
References: <1470696550-3416-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1470696550-3416-1-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org
Cc: sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

The of_configure_dma() function configures both the DMA masks and ops.
Moving DMA ops configuration to probe time would thus also delay
configuration of the DMA masks, which might not be safe. To avoid issues
split the configuration in two to allow keeping masks configuration at
device add time and move ops configuration to device probe time.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 drivers/of/device.c       | 48 ++++++++++++++++++++++++++++++++++-------------
 drivers/of/platform.c     |  6 ++++--
 drivers/pci/probe.c       |  3 ++-
 include/linux/of_device.h | 11 +++++++++--
 4 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 1c843e2..e1fad50 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -71,7 +71,7 @@ int of_device_add(struct platform_device *ofdev)
 }
 
 /**
- * of_dma_configure - Setup DMA configuration
+ * of_dma_configure - Setup DMA masks and offset
  * @dev:	Device to apply DMA configuration
  * @np:		Pointer to OF node having DMA configuration
  *
@@ -82,13 +82,11 @@ int of_device_add(struct platform_device *ofdev)
  * can use a platform bus notifier and handle BUS_NOTIFY_ADD_DEVICE events
  * to fix up DMA configuration.
  */
-void of_dma_configure(struct device *dev, struct device_node *np)
+void of_dma_configure_masks(struct device *dev, struct device_node *np)
 {
-	u64 dma_addr, paddr, size;
-	int ret;
-	bool coherent;
+	u64 dma_addr, paddr, size, range_mask;
 	unsigned long offset;
-	const struct iommu_ops *iommu;
+	int ret;
 
 	/*
 	 * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
@@ -106,9 +104,10 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 
 	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
 	if (ret < 0) {
-		dma_addr = offset = 0;
-		size = dev->coherent_dma_mask + 1;
+		range_mask = dev->coherent_dma_mask + 1;
+		offset = 0;
 	} else {
+		range_mask = DMA_BIT_MASK(ilog2(dma_addr + size));
 		offset = PFN_DOWN(paddr - dma_addr);
 		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
 	}
@@ -119,10 +118,31 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 	 * Limit coherent and dma mask based on size and default mask
 	 * set by the driver.
 	 */
-	dev->coherent_dma_mask = min(dev->coherent_dma_mask,
-				     DMA_BIT_MASK(ilog2(dma_addr + size)));
-	*dev->dma_mask = min((*dev->dma_mask),
-			     DMA_BIT_MASK(ilog2(dma_addr + size)));
+	dev->coherent_dma_mask = min(dev->coherent_dma_mask, range_mask);
+	*dev->dma_mask = min((*dev->dma_mask), range_mask);
+}
+EXPORT_SYMBOL_GPL(of_dma_configure_masks);
+
+/**
+ * of_dma_configure_ops - Setup DMA operations
+ * @dev:	Device to apply DMA configuration
+ * @np:		Pointer to OF node having DMA configuration
+ *
+ * Try to get devices's DMA configuration from DT and update it
+ * accordingly.
+ */
+int of_dma_configure_ops(struct device *dev, struct device_node *np)
+{
+	u64 dma_addr, paddr, size;
+	const struct iommu_ops *iommu;
+	bool coherent;
+	int ret;
+
+	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
+	if (ret < 0) {
+		dma_addr = 0;
+		size = dev->coherent_dma_mask + 1;
+	}
 
 	coherent = of_dma_is_coherent(np);
 	dev_dbg(dev, "device is%sdma coherent\n",
@@ -133,8 +153,10 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 		iommu ? " " : " not ");
 
 	arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
+
+	return 0;
 }
-EXPORT_SYMBOL_GPL(of_dma_configure);
+EXPORT_SYMBOL_GPL(of_dma_configure_ops);
 
 /**
  * of_dma_deconfigure - Clean up DMA configuration
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index b6d6b41..af3b291 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -179,7 +179,8 @@ static struct platform_device *of_platform_device_create_pdata(
 
 	dev->dev.bus = &platform_bus_type;
 	dev->dev.platform_data = platform_data;
-	of_dma_configure(&dev->dev, dev->dev.of_node);
+	of_dma_configure_masks(&dev->dev, dev->dev.of_node);
+	of_dma_configure_ops(&dev->dev, dev->dev.of_node);
 	of_msi_configure(&dev->dev, dev->dev.of_node);
 
 	if (of_device_add(dev) != 0) {
@@ -243,7 +244,8 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 		dev_set_name(&dev->dev, "%s", bus_id);
 	else
 		of_device_make_bus_id(&dev->dev);
-	of_dma_configure(&dev->dev, dev->dev.of_node);
+	of_dma_configure_masks(&dev->dev, dev->dev.of_node);
+	of_dma_configure_ops(&dev->dev, dev->dev.of_node);
 
 	/* Allow the HW Peripheral ID to be overridden */
 	prop = of_get_property(node, "arm,primecell-periphid", NULL);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8e3ef72..f8f5f16 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1717,7 +1717,8 @@ static void pci_dma_configure(struct pci_dev *dev)
 
 	if (IS_ENABLED(CONFIG_OF) &&
 		bridge->parent && bridge->parent->of_node) {
-			of_dma_configure(&dev->dev, bridge->parent->of_node);
+		of_dma_configure_masks(&dev->dev, bridge->parent->of_node);
+		of_dma_configure_ops(&dev->dev, bridge->parent->of_node);
 	} else if (has_acpi_companion(bridge)) {
 		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
 		enum dev_dma_attr attr = acpi_get_dma_attr(adev);
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index d20a31a..4b8cb7d 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -55,7 +55,8 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
 	return of_node_get(cpu_dev->of_node);
 }
 
-void of_dma_configure(struct device *dev, struct device_node *np);
+void of_dma_configure_masks(struct device *dev, struct device_node *np);
+int of_dma_configure_ops(struct device *dev, struct device_node *np);
 void of_dma_deconfigure(struct device *dev);
 #else /* CONFIG_OF */
 
@@ -99,8 +100,14 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
 {
 	return NULL;
 }
-static inline void of_dma_configure(struct device *dev, struct device_node *np)
+static inline void of_dma_configure_masks(struct device *dev,
+					  struct device_node *np)
 {}
+static inline int of_dma_configure_ops(struct device *dev,
+				       struct device_node *np)
+{
+	return 0;
+}
 static inline void of_dma_deconfigure(struct device *dev)
 {}
 #endif /* CONFIG_OF */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
