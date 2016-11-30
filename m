From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH 05/10] drivers: platform: Configure dma operations at probe time
Date: Wed, 30 Nov 2016 05:52:19 +0530
Message-ID: <1480465344-11862-6-git-send-email-sricharan@codeaurora.org>
References: <1480465344-11862-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1480465344-11862-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org, lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc: sricharan@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

Configuring DMA ops at probe time will allow deferring device probe when
the IOMMU isn't available yet. The dma_configure for the device is now called
from the generic device_attach callback just before the bus/driver probe
is called. This way, configuring the DMA ops for the device would be called
at the same place for all bus_types, hence the deferred probing mechanism
should work for all buses as well.

pci_bus_add_devices    (platform/amba)(_device_create/driver_register)
       |                         |
pci_bus_add_device     (device_add/driver_register)
       |                         |
device_attach           device_initial_probe
       |                         |
__device_attach_driver    __device_attach_driver
       |
driver_probe_device
       |
really_probe
       |
dma_configure

Similarly on the device/driver_unregister path __device_release_driver is
called which inturn calls dma_deconfigure.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
[rm: PCI hacks]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/base/dd.c           | 10 ++++++++++
 drivers/base/dma-mapping.c  | 20 ++++++++++++++++++++
 drivers/of/platform.c       |  5 +----
 drivers/pci/probe.c         | 15 +++++++--------
 include/linux/dma-mapping.h |  3 +++
 include/linux/pci.h         |  5 +++++
 6 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index d76cd97..6c0a885 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -19,6 +19,7 @@
 
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/wait.h>
@@ -351,6 +352,10 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	if (ret)
 		goto pinctrl_bind_failed;
 
+	ret = dma_configure(dev);
+	if (ret)
+		goto dma_failed;
+
 	if (driver_sysfs_add(dev)) {
 		printk(KERN_ERR "%s: driver_sysfs_add(%s) failed\n",
 			__func__, dev_name(dev));
@@ -412,6 +417,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	goto done;
 
 probe_failed:
+	dma_deconfigure(dev);
+dma_failed:
 	if (dev->bus)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
@@ -796,6 +803,9 @@ static void __device_release_driver(struct device *dev)
 			dev->bus->remove(dev);
 		else if (drv->remove)
 			drv->remove(dev);
+
+		dma_deconfigure(dev);
+
 		devres_release_all(dev);
 		dev->driver = NULL;
 		dev_set_drvdata(dev, NULL);
diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index 8f8b68c..b2a5629 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -10,6 +10,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/export.h>
 #include <linux/gfp.h>
+#include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 
@@ -341,3 +342,22 @@ void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
 	vunmap(cpu_addr);
 }
 #endif
+
+/*
+ * Common configuration to enable DMA API use for a device
+ */
+#include <linux/pci.h>
+
+int dma_configure(struct device *dev)
+{
+	if (dev_is_pci(dev))
+		pci_dma_configure(dev);
+	else if (dev->of_node)
+		of_dma_configure(dev, dev->of_node);
+	return 0;
+}
+
+void dma_deconfigure(struct device *dev)
+{
+	of_dma_deconfigure(dev);
+}
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index fdb6f8e..b0a2f9e 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/of_iommu.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -183,11 +184,9 @@ static struct platform_device *of_platform_device_create_pdata(
 
 	dev->dev.bus = &platform_bus_type;
 	dev->dev.platform_data = platform_data;
-	of_dma_configure(&dev->dev, dev->dev.of_node);
 	of_msi_configure(&dev->dev, dev->dev.of_node);
 
 	if (of_device_add(dev) != 0) {
-		of_dma_deconfigure(&dev->dev);
 		platform_device_put(dev);
 		goto err_clear_flag;
 	}
@@ -245,7 +244,6 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 		dev_set_name(&dev->dev, "%s", bus_id);
 	else
 		of_device_make_bus_id(&dev->dev);
-	of_dma_configure(&dev->dev, dev->dev.of_node);
 
 	/* Allow the HW Peripheral ID to be overridden */
 	prop = of_get_property(node, "arm,primecell-periphid", NULL);
@@ -539,7 +537,6 @@ static int of_platform_device_destroy(struct device *dev, void *data)
 		amba_device_unregister(to_amba_device(dev));
 #endif
 
-	of_dma_deconfigure(dev);
 	of_node_clear_flag(dev->of_node, OF_POPULATED);
 	of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
 	return 0;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c29e07a..04af770 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1719,26 +1719,26 @@ static void pci_set_msi_domain(struct pci_dev *dev)
 
 /**
  * pci_dma_configure - Setup DMA configuration
- * @dev: ptr to pci_dev struct of the PCI device
+ * @dev: ptr to device struct of the PCI device
  *
  * Function to update PCI devices's DMA configuration using the same
  * info from the OF node or ACPI node of host bridge's parent (if any).
  */
-static void pci_dma_configure(struct pci_dev *dev)
+void pci_dma_configure(struct device *dev)
 {
-	struct device *bridge = pci_get_host_bridge_device(dev);
+	struct device *bridge = pci_get_host_bridge_device(to_pci_dev(dev));
 
 	if (IS_ENABLED(CONFIG_OF) &&
-		bridge->parent && bridge->parent->of_node) {
-			of_dma_configure(&dev->dev, bridge->parent->of_node);
+	    bridge->parent && bridge->parent->of_node) {
+		of_dma_configure(dev, bridge->parent->of_node);
 	} else if (has_acpi_companion(bridge)) {
 		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
 		enum dev_dma_attr attr = acpi_get_dma_attr(adev);
 
 		if (attr == DEV_DMA_NOT_SUPPORTED)
-			dev_warn(&dev->dev, "DMA not supported.\n");
+			dev_warn(dev, "DMA not supported.\n");
 		else
-			acpi_dma_configure(&dev->dev, attr);
+			acpi_dma_configure(dev, attr);
 	}
 
 	pci_put_host_bridge_device(bridge);
@@ -1757,7 +1757,6 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	dev->dev.dma_mask = &dev->dma_mask;
 	dev->dev.dma_parms = &dev->dma_parms;
 	dev->dev.coherent_dma_mask = 0xffffffffull;
-	pci_dma_configure(dev);
 
 	pci_set_dma_max_seg_size(dev, 65536);
 	pci_set_dma_seg_boundary(dev, 0xffffffff);
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 08528af..6f3e6ca 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -702,6 +702,9 @@ void *dma_mark_declared_memory_occupied(struct device *dev,
 }
 #endif /* CONFIG_HAVE_GENERIC_DMA_COHERENT */
 
+int dma_configure(struct device *dev);
+void dma_deconfigure(struct device *dev);
+
 /*
  * Managed DMA API
  */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0e49f70..d04f651 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -870,6 +870,8 @@ struct resource *pci_find_parent_resource(const struct pci_dev *dev,
 #define dev_is_pf(d) ((dev_is_pci(d) ? to_pci_dev(d)->is_physfn : false))
 #define dev_num_vf(d) ((dev_is_pci(d) ? pci_num_vf(to_pci_dev(d)) : 0))
 
+void pci_dma_configure(struct device *dev);
+
 /* Generic PCI functions exported to card drivers */
 
 enum pci_lost_interrupt_reason {
@@ -1601,6 +1603,9 @@ static inline struct pci_dev *pci_get_bus_and_slot(unsigned int bus,
 #define dev_is_pci(d) (false)
 #define dev_is_pf(d) (false)
 #define dev_num_vf(d) (0)
+
+static inline void pci_dma_configure(struct device *dev) { }
+
 #endif /* CONFIG_PCI */
 
 /* Include architecture-dependent settings and functions */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
