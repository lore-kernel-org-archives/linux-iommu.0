From: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH v2 2/2] drivers: remove force dma flag from buses
Date: Wed, 21 Mar 2018 12:25:23 +0530
Message-ID: <1521615323-4752-2-git-send-email-nipun.gupta@nxp.com>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
	<1521615323-4752-1-git-send-email-nipun.gupta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1521615323-4752-1-git-send-email-nipun.gupta-3arQi8VN3Tc@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: robin.murphy-5wv7dgnIgG8@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, msuchanek-l3A5Bk7waGM@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, leoyang.li-3arQi8VN3Tc@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

With each bus implementing its own DMA configuration callback,
there is no need for bus to explicitly have force_dma in its
global structure. This patch modifies of_dma_configure API to
accept an input parameter which specifies if implicit DMA
configuration is required even when it is not described by the
firmware.

Signed-off-by: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
---

Changes in v2:
  - This is a new change suggested by Robin and Christoph
    and is added to the series.

 drivers/amba/bus.c            | 3 +--
 drivers/base/dma-mapping.c    | 4 ++--
 drivers/base/platform.c       | 3 +--
 drivers/bcma/main.c           | 2 +-
 drivers/dma/qcom/hidma_mgmt.c | 2 +-
 drivers/gpu/host1x/bus.c      | 5 ++---
 drivers/of/device.c           | 6 ++++--
 drivers/of/of_reserved_mem.c  | 2 +-
 drivers/pci/pci-driver.c      | 3 +--
 include/linux/device.h        | 4 ----
 include/linux/dma-mapping.h   | 2 +-
 include/linux/of_device.h     | 4 +++-
 12 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 2fa1e8b..1d58348 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -174,7 +174,7 @@ static int amba_pm_runtime_resume(struct device *dev)
 
 static int amba_dma_configure(struct device *dev)
 {
-	return dma_common_configure(dev);
+	return dma_common_configure(dev, true);
 }
 
 static const struct dev_pm_ops amba_pm = {
@@ -202,7 +202,6 @@ struct bus_type amba_bustype = {
 	.uevent		= amba_uevent,
 	.dma_configure	= amba_dma_configure,
 	.pm		= &amba_pm,
-	.force_dma	= true,
 };
 
 static int __init amba_init(void)
diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index 48f9af0..03f8584 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -335,13 +335,13 @@ void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
  * A bus can use this function in its 'dma_configure' callback, if
  * suitable for the bus.
  */
-int dma_common_configure(struct device *dev)
+int dma_common_configure(struct device *dev, bool force_dma)
 {
 	enum dev_dma_attr attr;
 	int ret = 0;
 
 	if (dev->of_node) {
-		ret = of_dma_configure(dev, dev->of_node);
+		ret = of_dma_configure(dev, dev->of_node, force_dma);
 	} else if (has_acpi_companion(dev)) {
 		attr = acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
 		if (attr != DEV_DMA_NOT_SUPPORTED)
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index d2d5891..154707c 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1132,7 +1132,7 @@ int platform_pm_restore(struct device *dev)
 
 static int platform_dma_configure(struct device *dev)
 {
-	return dma_common_configure(dev);
+	return dma_common_configure(dev, true);
 }
 
 static const struct dev_pm_ops platform_dev_pm_ops = {
@@ -1148,7 +1148,6 @@ struct bus_type platform_bus_type = {
 	.uevent		= platform_uevent,
 	.dma_configure	= platform_dma_configure,
 	.pm		= &platform_dev_pm_ops,
-	.force_dma	= true,
 };
 EXPORT_SYMBOL_GPL(platform_bus_type);
 
diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
index e6986c7..fc1f4ac 100644
--- a/drivers/bcma/main.c
+++ b/drivers/bcma/main.c
@@ -207,7 +207,7 @@ static void bcma_of_fill_device(struct device *parent,
 
 	core->irq = bcma_of_get_irq(parent, core, 0);
 
-	of_dma_configure(&core->dev, node);
+	of_dma_configure(&core->dev, node, false);
 }
 
 unsigned int bcma_core_irq(struct bcma_device *core, int num)
diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
index 000c7019..d64edeb 100644
--- a/drivers/dma/qcom/hidma_mgmt.c
+++ b/drivers/dma/qcom/hidma_mgmt.c
@@ -398,7 +398,7 @@ static int __init hidma_mgmt_of_populate_channels(struct device_node *np)
 		}
 		of_node_get(child);
 		new_pdev->dev.of_node = child;
-		of_dma_configure(&new_pdev->dev, child);
+		of_dma_configure(&new_pdev->dev, child, true);
 		/*
 		 * It is assumed that calling of_msi_configure is safe on
 		 * platforms with or without MSI support.
diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index fa9896d..211eb6b 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -317,7 +317,7 @@ static int host1x_device_match(struct device *dev, struct device_driver *drv)
 static int host1x_dma_configure(struct device *dev)
 {
 	if (dev->of_node)
-		return of_dma_configure(dev, dev->of_node);
+		return of_dma_configure(dev, dev->of_node, true);
 
 	return 0;
 }
@@ -336,7 +336,6 @@ struct bus_type host1x_bus_type = {
 	.match = host1x_device_match,
 	.dma_configure	= host1x_dma_configure,
 	.pm = &host1x_device_pm_ops,
-	.force_dma = true,
 };
 
 static void __host1x_device_del(struct host1x_device *device)
@@ -425,7 +424,7 @@ static int host1x_device_add(struct host1x *host1x,
 	device->dev.bus = &host1x_bus_type;
 	device->dev.parent = host1x->dev;
 
-	of_dma_configure(&device->dev, host1x->dev->of_node);
+	of_dma_configure(&device->dev, host1x->dev->of_node, true);
 
 	err = host1x_device_parse_dt(device, driver);
 	if (err < 0) {
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 064c818..33d8551 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -76,6 +76,8 @@ int of_device_add(struct platform_device *ofdev)
  * of_dma_configure - Setup DMA configuration
  * @dev:	Device to apply DMA configuration
  * @np:		Pointer to OF node having DMA configuration
+ * @force_dma:  Whether device is to be set up by of_dma_configure() even if
+ *		DMA capability is not explicitly described by firmware.
  *
  * Try to get devices's DMA configuration from DT and update it
  * accordingly.
@@ -84,7 +86,7 @@ int of_device_add(struct platform_device *ofdev)
  * can use a platform bus notifier and handle BUS_NOTIFY_ADD_DEVICE events
  * to fix up DMA configuration.
  */
-int of_dma_configure(struct device *dev, struct device_node *np)
+int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
 {
 	u64 dma_addr, paddr, size = 0;
 	int ret;
@@ -100,7 +102,7 @@ int of_dma_configure(struct device *dev, struct device_node *np)
 		 * DMA configuration regardless of whether "dma-ranges" is
 		 * correctly specified or not.
 		 */
-		if (!dev->bus->force_dma)
+		if (!force_dma)
 			return ret == -ENODEV ? 0 : ret;
 
 		dma_addr = offset = 0;
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 9a4f4246..895c83e 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -353,7 +353,7 @@ int of_reserved_mem_device_init_by_idx(struct device *dev,
 		/* ensure that dma_ops is set for virtual devices
 		 * using reserved memory
 		 */
-		of_dma_configure(dev, np);
+		of_dma_configure(dev, np, true);
 
 		dev_info(dev, "assigned reserved memory node %s\n", rmem->name);
 	} else {
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index b473a4c..b15637a 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1541,7 +1541,7 @@ static int pci_dma_configure(struct device *dev)
 
 	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
 	    bridge->parent->of_node) {
-		ret = of_dma_configure(dev, bridge->parent->of_node);
+		ret = of_dma_configure(dev, bridge->parent->of_node, true);
 	} else if (has_acpi_companion(bridge)) {
 		attr = acpi_get_dma_attr(to_acpi_device_node(bridge->fwnode));
 		if (attr != DEV_DMA_NOT_SUPPORTED)
@@ -1566,7 +1566,6 @@ struct bus_type pci_bus_type = {
 	.pm		= PCI_PM_OPS_PTR,
 	.num_vf		= pci_bus_num_vf,
 	.dma_configure	= pci_dma_configure,
-	.force_dma	= true,
 };
 EXPORT_SYMBOL(pci_bus_type);
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 1832d90..92c530e 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -98,8 +98,6 @@ extern int __must_check bus_create_file(struct bus_type *,
  * @p:		The private data of the driver core, only the driver core can
  *		touch this.
  * @lock_key:	Lock class key for use by the lock validator
- * @force_dma:	Assume devices on this bus should be set up by dma_configure()
- * 		even if DMA capability is not explicitly described by firmware.
  *
  * A bus is a channel between the processor and one or more devices. For the
  * purposes of the device model, all devices are connected via a bus, even if
@@ -140,8 +138,6 @@ struct bus_type {
 
 	struct subsys_private *p;
 	struct lock_class_key lock_key;
-
-	bool force_dma;
 };
 
 extern int __must_check bus_register(struct bus_type *bus);
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index c15986b..3dba3e6 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -761,7 +761,7 @@ void *dma_mark_declared_memory_occupied(struct device *dev,
 }
 #endif /* CONFIG_HAVE_GENERIC_DMA_COHERENT */
 
-int dma_common_configure(struct device *dev);
+int dma_common_configure(struct device *dev, bool force_dma);
 #ifdef CONFIG_HAS_DMA
 int dma_configure(struct device *dev);
 void dma_deconfigure(struct device *dev);
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 8da5a1b..b0be3a5 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -55,7 +55,9 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
 	return of_node_get(cpu_dev->of_node);
 }
 
-int of_dma_configure(struct device *dev, struct device_node *np);
+int of_dma_configure(struct device *dev,
+		     struct device_node *np,
+		     bool force_dma);
 void of_dma_deconfigure(struct device *dev);
 #else /* CONFIG_OF */
 
-- 
1.9.1
