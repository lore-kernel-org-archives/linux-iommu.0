From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V5 05/12] drivers: platform: Configure dma operations at probe
	time
Date: Thu, 19 Jan 2017 20:35:49 +0530
Message-ID: <1484838356-24962-6-git-send-email-sricharan@codeaurora.org>
References: <1484838356-24962-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1484838356-24962-1-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: robin.murphy-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Configuring DMA ops at probe time will allow deferring device probe when
the IOMMU isn't available yet. The dma_configure for the device is
now called from the generic device_attach callback just before the
bus/driver probe is called. This way, configuring the DMA ops for the
device would be called at the same place for all bus_types, hence the
deferred probing mechanism should work for all buses as well.

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

Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 * Removed the dma configuration for the pci devices in case of DT
   from pci_dma_configure which was hanging outside separately and
   doing it in dma_configure function itself.

 drivers/base/dd.c           |  9 +++++++++
 drivers/base/dma-mapping.c  | 32 ++++++++++++++++++++++++++++++++
 drivers/of/platform.c       |  5 +----
 drivers/pci/probe.c         |  5 +----
 include/linux/dma-mapping.h |  3 +++
 5 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index a1fbf55..4882f06 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -19,6 +19,7 @@
 
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/wait.h>
@@ -356,6 +357,10 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	if (ret)
 		goto pinctrl_bind_failed;
 
+	ret = dma_configure(dev);
+	if (ret)
+		goto dma_failed;
+
 	if (driver_sysfs_add(dev)) {
 		printk(KERN_ERR "%s: driver_sysfs_add(%s) failed\n",
 			__func__, dev_name(dev));
@@ -417,6 +422,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	goto done;
 
 probe_failed:
+	dma_deconfigure(dev);
+dma_failed:
 	if (dev->bus)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
@@ -826,6 +833,8 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 			drv->remove(dev);
 
 		device_links_driver_cleanup(dev);
+		dma_deconfigure(dev);
+
 		devres_release_all(dev);
 		dev->driver = NULL;
 		dev_set_drvdata(dev, NULL);
diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index efd71cf..dfe6fd7 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -10,6 +10,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/export.h>
 #include <linux/gfp.h>
+#include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 
@@ -341,3 +342,34 @@ void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
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
+	struct device *_dev = dev;
+	int is_pci = dev_is_pci(dev);
+
+	if (is_pci) {
+		_dev = pci_get_host_bridge_device(to_pci_dev(dev));
+		if (IS_ENABLED(CONFIG_OF) && _dev->parent &&
+		    _dev->parent->of_node)
+			_dev = _dev->parent;
+	}
+
+	if (_dev->of_node)
+		of_dma_configure(dev, _dev->of_node);
+
+	if (is_pci)
+		pci_put_host_bridge_device(_dev);
+
+	return 0;
+}
+
+void dma_deconfigure(struct device *dev)
+{
+	of_dma_deconfigure(dev);
+}
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 57418f7..cf35030 100644
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
@@ -186,11 +187,9 @@ static struct platform_device *of_platform_device_create_pdata(
 
 	dev->dev.bus = &platform_bus_type;
 	dev->dev.platform_data = platform_data;
-	of_dma_configure(&dev->dev, dev->dev.of_node);
 	of_msi_configure(&dev->dev, dev->dev.of_node);
 
 	if (of_device_add(dev) != 0) {
-		of_dma_deconfigure(&dev->dev);
 		platform_device_put(dev);
 		goto err_clear_flag;
 	}
@@ -248,7 +247,6 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 		dev_set_name(&dev->dev, "%s", bus_id);
 	else
 		of_device_make_bus_id(&dev->dev);
-	of_dma_configure(&dev->dev, dev->dev.of_node);
 
 	/* Allow the HW Peripheral ID to be overridden */
 	prop = of_get_property(node, "arm,primecell-periphid", NULL);
@@ -542,7 +540,6 @@ static int of_platform_device_destroy(struct device *dev, void *data)
 		amba_device_unregister(to_amba_device(dev));
 #endif
 
-	of_dma_deconfigure(dev);
 	of_node_clear_flag(dev->of_node, OF_POPULATED);
 	of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
 	return 0;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index e164b5c..634d34e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1873,10 +1873,7 @@ static void pci_dma_configure(struct pci_dev *dev)
 {
 	struct device *bridge = pci_get_host_bridge_device(dev);
 
-	if (IS_ENABLED(CONFIG_OF) &&
-		bridge->parent && bridge->parent->of_node) {
-			of_dma_configure(&dev->dev, bridge->parent->of_node);
-	} else if (has_acpi_companion(bridge)) {
+	if (has_acpi_companion(bridge)) {
 		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
 		enum dev_dma_attr attr = acpi_get_dma_attr(adev);
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index abf685ed..b56320a 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -718,6 +718,9 @@ void *dma_mark_declared_memory_occupied(struct device *dev,
 }
 #endif /* CONFIG_HAVE_GENERIC_DMA_COHERENT */
 
+int dma_configure(struct device *dev);
+void dma_deconfigure(struct device *dev);
+
 /*
  * Managed DMA API
  */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
