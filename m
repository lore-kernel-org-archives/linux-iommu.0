From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Subject: [PATCH - v7] of: Move of_dma_configure() to device.c to help re-use
Date: Mon, 2 Mar 2015 16:59:07 -0500
Message-ID: <1425333548-8802-1-git-send-email-m-karicheri2@ti.com>
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
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Move of_dma_configure() to device.c so it can be re-used for PCI devices to
obtain DMA configuration from DT.  Also add a second argument so that for
PCI, the DT node of root bus host bridge can be used to obtain the DMA
configuration for the slave PCI device.

Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org> (AMD Seattle)
Signed-off-by: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Signed-off-by: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Reviewed-by: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
CC: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
CC: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
CC: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
CC: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
CC: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
---
 - Based on the existing patch applied to arm-pci/pci/iommu for pci next (Bjorn)
 - Fixed the build issue reported on ARCH=x86_64  
 drivers/of/device.c       |   59 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/of/platform.c     |   58 ++------------------------------------------
 include/linux/of_device.h |    2 ++
 3 files changed, 63 insertions(+), 56 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 46d6c75c..31a7875 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -2,6 +2,9 @@
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/of_iommu.h>
+#include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
@@ -66,6 +69,62 @@ int of_device_add(struct platform_device *ofdev)
 	return device_add(&ofdev->dev);
 }
 
+/**
+ * of_dma_configure - Setup DMA configuration
+ * @dev:	Device to apply DMA configuration
+ * @np:		Pointer to OF node having DMA configuration
+ *
+ * Try to get devices's DMA configuration from DT and update it
+ * accordingly.
+ *
+ * If platform code needs to use its own special DMA configuration, it
+ * can use a platform bus notifier and handle BUS_NOTIFY_ADD_DEVICE events
+ * to fix up DMA configuration.
+ */
+void of_dma_configure(struct device *dev, struct device_node *np)
+{
+	u64 dma_addr, paddr, size;
+	int ret;
+	bool coherent;
+	unsigned long offset;
+	struct iommu_ops *iommu;
+
+	/*
+	 * Set default dma-mask to 32 bit.  Drivers are expected to setup
+	 * the correct supported dma_mask.
+	 */
+	dev->coherent_dma_mask = DMA_BIT_MASK(32);
+
+	/*
+	 * Set it to coherent_dma_mask by default if the architecture
+	 * code has not set it.
+	 */
+	if (!dev->dma_mask)
+		dev->dma_mask = &dev->coherent_dma_mask;
+
+	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
+	if (ret < 0) {
+		dma_addr = offset = 0;
+		size = dev->coherent_dma_mask;
+	} else {
+		offset = PFN_DOWN(paddr - dma_addr);
+		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
+	}
+
+	dev->dma_pfn_offset = offset;
+
+	coherent = of_dma_is_coherent(np);
+	dev_dbg(dev, "device is%sdma coherent\n",
+		coherent ? " " : " not ");
+
+	iommu = of_iommu_configure(dev, np);
+	dev_dbg(dev, "device is%sbehind an iommu\n",
+		iommu ? " " : " not ");
+
+	arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
+}
+EXPORT_SYMBOL_GPL(of_dma_configure);
+
 int of_device_register(struct platform_device *pdev)
 {
 	device_initialize(&pdev->dev);
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 667c6f1..a01f57c 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -19,7 +19,6 @@
 #include <linux/slab.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
-#include <linux/of_iommu.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -150,59 +149,6 @@ struct platform_device *of_device_alloc(struct device_node *np,
 }
 EXPORT_SYMBOL(of_device_alloc);
 
-/**
- * of_dma_configure - Setup DMA configuration
- * @dev:	Device to apply DMA configuration
- *
- * Try to get devices's DMA configuration from DT and update it
- * accordingly.
- *
- * In case if platform code need to use own special DMA configuration,it
- * can use Platform bus notifier and handle BUS_NOTIFY_ADD_DEVICE event
- * to fix up DMA configuration.
- */
-static void of_dma_configure(struct device *dev)
-{
-	u64 dma_addr, paddr, size;
-	int ret;
-	bool coherent;
-	unsigned long offset;
-	struct iommu_ops *iommu;
-
-	/*
-	 * Set default dma-mask to 32 bit. Drivers are expected to setup
-	 * the correct supported dma_mask.
-	 */
-	dev->coherent_dma_mask = DMA_BIT_MASK(32);
-
-	/*
-	 * Set it to coherent_dma_mask by default if the architecture
-	 * code has not set it.
-	 */
-	if (!dev->dma_mask)
-		dev->dma_mask = &dev->coherent_dma_mask;
-
-	ret = of_dma_get_range(dev->of_node, &dma_addr, &paddr, &size);
-	if (ret < 0) {
-		dma_addr = offset = 0;
-		size = dev->coherent_dma_mask;
-	} else {
-		offset = PFN_DOWN(paddr - dma_addr);
-		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
-	}
-	dev->dma_pfn_offset = offset;
-
-	coherent = of_dma_is_coherent(dev->of_node);
-	dev_dbg(dev, "device is%sdma coherent\n",
-		coherent ? " " : " not ");
-
-	iommu = of_iommu_configure(dev, dev->of_node);
-	dev_dbg(dev, "device is%sbehind an iommu\n",
-		iommu ? " " : " not ");
-
-	arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
-}
-
 static void of_dma_deconfigure(struct device *dev)
 {
 	arch_teardown_dma_ops(dev);
@@ -236,7 +182,7 @@ static struct platform_device *of_platform_device_create_pdata(
 
 	dev->dev.bus = &platform_bus_type;
 	dev->dev.platform_data = platform_data;
-	of_dma_configure(&dev->dev);
+	of_dma_configure(&dev->dev, dev->dev.of_node);
 
 	if (of_device_add(dev) != 0) {
 		of_dma_deconfigure(&dev->dev);
@@ -299,7 +245,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 		dev_set_name(&dev->dev, "%s", bus_id);
 	else
 		of_device_make_bus_id(&dev->dev);
-	of_dma_configure(&dev->dev);
+	of_dma_configure(&dev->dev, dev->dev.of_node);
 
 	/* Allow the HW Peripheral ID to be overridden */
 	prop = of_get_property(node, "arm,primecell-periphid", NULL);
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index ef37021..be70cb4 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -53,6 +53,7 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
 	return of_node_get(cpu_dev->of_node);
 }
 
+void of_dma_configure(struct device *dev, struct device_node *np);
 #else /* CONFIG_OF */
 
 static inline int of_driver_match_device(struct device *dev,
@@ -90,6 +91,7 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
 {
 	return NULL;
 }
+static inline void of_dma_configure(struct device *dev, struct device_node *np) { }
 #endif /* CONFIG_OF */
 
 #endif /* _LINUX_OF_DEVICE_H */
-- 
1.7.9.5
