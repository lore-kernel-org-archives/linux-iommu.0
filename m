From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH V3 5/8] iommu: of: Handle IOMMU lookup failure with deferred probing or error
Date: Tue,  4 Oct 2016 22:33:49 +0530
Message-ID: <1475600632-21289-6-git-send-email-sricharan@codeaurora.org>
References: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, laurent.pinchart@ideasonboard.com, m.szyprowski@samsung.com, tfiga@chromium.org, srinivas.kandagatla@linaro.org
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

The current iommu framework handles pci and non-pci devices separately,
so taken care of both the paths in this patch. The iommu's add_device
callback is invoked after the master's configuration data is added in
xlate. This is needed because the iommu core calls add_device callback
during the BUS_ADD_DEVICE notifier, which is of no use now. Eventually
that call has to be removed.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/iommu/of_iommu.c  | 47 +++++++++++++++++++++++++++++++++++++++++++----
 drivers/of/device.c       |  7 ++++++-
 include/linux/of_device.h |  6 ++++--
 3 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 5b82862..1a5e28b 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -23,6 +23,7 @@
 #include <linux/of.h>
 #include <linux/of_iommu.h>
 #include <linux/of_pci.h>
+#include <linux/pci.h>
 #include <linux/slab.h>
 
 static const struct of_device_id __iommu_of_table_sentinel
@@ -167,12 +168,29 @@ static const struct iommu_ops
 		return NULL;
 
 	ops = of_iommu_get_ops(iommu_spec.np);
+
+	if (!ops) {
+		const struct of_device_id *oid;
+
+		oid = of_match_node(&__iommu_of_table, iommu_spec.np);
+		ops = oid ? ERR_PTR(-EPROBE_DEFER) : NULL;
+		return ops;
+	}
+
 	if (!ops || !ops->of_xlate ||
 	    iommu_fwspec_init(&pdev->dev, &iommu_spec.np->fwnode, ops) ||
 	    ops->of_xlate(&pdev->dev, &iommu_spec))
 		ops = NULL;
 
+	if (ops && ops->add_device) {
+		ops = (ops->add_device(&pdev->dev) == 0) ? ops : NULL;
+
+		if (!ops)
+			dev_err(&pdev->dev, "Failed to setup iommu ops\n");
+	}
+
 	of_node_put(iommu_spec.np);
+
 	return ops;
 }
 
@@ -183,9 +201,15 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 	struct device_node *np;
 	const struct iommu_ops *ops = NULL;
 	int idx = 0;
+	struct device *bridge;
+
+	if (dev_is_pci(dev)) {
+		bridge = pci_get_host_bridge_device(to_pci_dev(dev));
 
-	if (dev_is_pci(dev))
-		return of_pci_iommu_configure(to_pci_dev(dev), master_np);
+		if (bridge && bridge->parent && bridge->parent->of_node)
+			return of_pci_iommu_configure(to_pci_dev(dev),
+						      bridge->parent->of_node);
+	}
 
 	/*
 	 * We don't currently walk up the tree looking for a parent IOMMU.
@@ -198,6 +222,14 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 		np = iommu_spec.np;
 		ops = of_iommu_get_ops(np);
 
+		if (!ops) {
+			const struct of_device_id *oid;
+
+			oid = of_match_node(&__iommu_of_table, np);
+			ops = oid ? ERR_PTR(-EPROBE_DEFER) : NULL;
+			goto err_put_node;
+		}
+
 		if (!ops || !ops->of_xlate ||
 		    iommu_fwspec_init(dev, &np->fwnode, ops) ||
 		    ops->of_xlate(dev, &iommu_spec))
@@ -207,11 +239,18 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 		idx++;
 	}
 
+	if (ops && ops->add_device) {
+		ops = (ops->add_device(dev) == 0) ? ops : NULL;
+
+		if (!ops)
+			dev_err(dev, "Failed to setup iommu_ops\n");
+	}
+
 	return ops;
 
 err_put_node:
 	of_node_put(np);
-	return NULL;
+	return ops;
 }
 
 static int __init of_iommu_init(void)
@@ -222,7 +261,7 @@ static int __init of_iommu_init(void)
 	for_each_matching_node_and_match(np, matches, &match) {
 		const of_iommu_init_fn init_fn = match->data;
 
-		if (init_fn(np))
+		if (init_fn && init_fn(np))
 			pr_err("Failed to initialise IOMMU %s\n",
 				of_node_full_name(np));
 	}
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 1c843e2..c8e74d7 100644
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
 
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index d20a31a..2bdb872 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -55,7 +55,7 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
 	return of_node_get(cpu_dev->of_node);
 }
 
-void of_dma_configure(struct device *dev, struct device_node *np);
+int of_dma_configure(struct device *dev, struct device_node *np);
 void of_dma_deconfigure(struct device *dev);
 #else /* CONFIG_OF */
 
@@ -100,7 +100,9 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
 	return NULL;
 }
 static inline void of_dma_configure(struct device *dev, struct device_node *np)
-{}
+{
+	return 0;
+}
 static inline void of_dma_deconfigure(struct device *dev)
 {}
 #endif /* CONFIG_OF */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
