From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH 06/10] iommu: of: Handle IOMMU lookup failure with deferred probing or error
Date: Wed, 30 Nov 2016 05:52:20 +0530
Message-ID: <1480465344-11862-7-git-send-email-sricharan@codeaurora.org>
References: <1480465344-11862-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1480465344-11862-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org, lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc: sricharan@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Failures to look up an IOMMU when parsing the DT iommus property need to
be handled separately from the .of_xlate() failures to support deferred
probing.

The lack of a registered IOMMU can be caused by the lack of a driver for
the IOMMU, the IOMMU device probe not having been performed yet, having
been deferred, or having failed.

The first case occurs when the device tree describes the bus master and
IOMMU topology correctly but no device driver exists for the IOMMU yet
or the device driver has not been compiled in. Return NULL, the caller
will configure the device without an IOMMU.

The second and third cases are handled by deferring the probe of the bus
master device which will eventually get reprobed after the IOMMU.

The last case is currently handled by deferring the probe of the bus
master device as well. A mechanism to either configure the bus master
device without an IOMMU or to fail the bus master device probe depending
on whether the IOMMU is optional or mandatory would be a good
enhancement.

Signed-off-by: Laurent Pichart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
[rm: massive PCI hacks]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/base/dma-mapping.c | 4 ++--
 drivers/iommu/dma-iommu.c  | 1 +
 drivers/iommu/of_iommu.c   | 5 +++--
 drivers/of/device.c        | 9 +++++++--
 drivers/pci/probe.c        | 6 ++++--
 include/linux/of_device.h  | 9 ++++++---
 include/linux/pci.h        | 4 ++--
 7 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index b2a5629..576fdfb 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -351,9 +351,9 @@ void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
 int dma_configure(struct device *dev)
 {
 	if (dev_is_pci(dev))
-		pci_dma_configure(dev);
+		return pci_dma_configure(dev);
 	else if (dev->of_node)
-		of_dma_configure(dev, dev->of_node);
+		return of_dma_configure(dev, dev->of_node);
 	return 0;
 }
 
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index c5ab866..d2a7a46 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -148,6 +148,7 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	base_pfn = max_t(unsigned long, 1, base >> order);
 	end_pfn = (base + size - 1) >> order;
 
+	dev_info(dev, "0x%llx 0x%llx, 0x%llx 0x%llx, 0x%llx 0x%llx\n", base, size, domain->geometry.aperture_start, domain->geometry.aperture_end, *dev->dma_mask, dev->coherent_dma_mask);
 	/* Check the domain allows at least some access to the device... */
 	if (domain->geometry.force_aperture) {
 		if (base > domain->geometry.aperture_end ||
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 349bd1d..9529d6c 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -23,6 +23,7 @@
 #include <linux/of.h>
 #include <linux/of_iommu.h>
 #include <linux/of_pci.h>
+#include <linux/pci.h>
 #include <linux/slab.h>
 
 static const struct of_device_id __iommu_of_table_sentinel
@@ -223,7 +224,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 			ops = ERR_PTR(err);
 	}
 
-	return IS_ERR(ops) ? NULL : ops;
+	return ops;
 }
 
 static int __init of_iommu_init(void)
@@ -234,7 +235,7 @@ static int __init of_iommu_init(void)
 	for_each_matching_node_and_match(np, matches, &match) {
 		const of_iommu_init_fn init_fn = match->data;
 
-		if (init_fn(np))
+		if (init_fn && init_fn(np))
 			pr_err("Failed to initialise IOMMU %s\n",
 				of_node_full_name(np));
 	}
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 1c843e2..d58595c 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -82,7 +82,7 @@ int of_device_add(struct platform_device *ofdev)
  * can use a platform bus notifier and handle BUS_NOTIFY_ADD_DEVICE events
  * to fix up DMA configuration.
  */
-void of_dma_configure(struct device *dev, struct device_node *np)
+int of_dma_configure(struct device *dev, struct device_node *np)
 {
 	u64 dma_addr, paddr, size;
 	int ret;
@@ -107,7 +107,7 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
 	if (ret < 0) {
 		dma_addr = offset = 0;
-		size = dev->coherent_dma_mask + 1;
+		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
 	} else {
 		offset = PFN_DOWN(paddr - dma_addr);
 		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
@@ -129,10 +129,15 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 		coherent ? " " : " not ");
 
 	iommu = of_iommu_configure(dev, np);
+	if (IS_ERR(iommu))
+		return PTR_ERR(iommu);
+
 	dev_dbg(dev, "device is%sbehind an iommu\n",
 		iommu ? " " : " not ");
 
 	arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(of_dma_configure);
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 04af770..6316cae 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1724,13 +1724,14 @@ static void pci_set_msi_domain(struct pci_dev *dev)
  * Function to update PCI devices's DMA configuration using the same
  * info from the OF node or ACPI node of host bridge's parent (if any).
  */
-void pci_dma_configure(struct device *dev)
+int pci_dma_configure(struct device *dev)
 {
 	struct device *bridge = pci_get_host_bridge_device(to_pci_dev(dev));
+	int ret = 0;
 
 	if (IS_ENABLED(CONFIG_OF) &&
 	    bridge->parent && bridge->parent->of_node) {
-		of_dma_configure(dev, bridge->parent->of_node);
+		ret = of_dma_configure(dev, bridge->parent->of_node);
 	} else if (has_acpi_companion(bridge)) {
 		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
 		enum dev_dma_attr attr = acpi_get_dma_attr(adev);
@@ -1742,6 +1743,7 @@ void pci_dma_configure(struct device *dev)
 	}
 
 	pci_put_host_bridge_device(bridge);
+	return ret;
 }
 
 void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index d20a31a..6dca65c 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -55,7 +55,7 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
 	return of_node_get(cpu_dev->of_node);
 }
 
-void of_dma_configure(struct device *dev, struct device_node *np);
+int of_dma_configure(struct device *dev, struct device_node *np);
 void of_dma_deconfigure(struct device *dev);
 #else /* CONFIG_OF */
 
@@ -99,8 +99,11 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
 {
 	return NULL;
 }
-static inline void of_dma_configure(struct device *dev, struct device_node *np)
-{}
+
+static inline int of_dma_configure(struct device *dev, struct device_node *np)
+{
+	return 0;
+}
 static inline void of_dma_deconfigure(struct device *dev)
 {}
 #endif /* CONFIG_OF */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d04f651..989ca44 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -870,7 +870,7 @@ struct resource *pci_find_parent_resource(const struct pci_dev *dev,
 #define dev_is_pf(d) ((dev_is_pci(d) ? to_pci_dev(d)->is_physfn : false))
 #define dev_num_vf(d) ((dev_is_pci(d) ? pci_num_vf(to_pci_dev(d)) : 0))
 
-void pci_dma_configure(struct device *dev);
+int pci_dma_configure(struct device *dev);
 
 /* Generic PCI functions exported to card drivers */
 
@@ -1604,7 +1604,7 @@ static inline struct pci_dev *pci_get_bus_and_slot(unsigned int bus,
 #define dev_is_pf(d) (false)
 #define dev_num_vf(d) (0)
 
-static inline void pci_dma_configure(struct device *dev) { }
+static inline int pci_dma_configure(struct device *dev) { return 0; }
 
 #endif /* CONFIG_PCI */
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
