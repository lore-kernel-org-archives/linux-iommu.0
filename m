From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v7 03/22] iommu/of: Handle iommu-map property for PCI
Date: Mon, 12 Sep 2016 17:13:41 +0100
Message-ID: <39a69a44a9c998be2bd102d2f60000ad31e00ce7.1473695704.git.robin.murphy@arm.com>
References: <cover.1473695704.git.robin.murphy@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1473695704.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Now that we have a way to pick up the RID translation and target IOMMU,
hook up of_iommu_configure() to bring PCI devices into the of_xlate
mechanism and allow them IOMMU-backed DMA ops without the need for
driver-specific handling.

Reviewed-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

---

- Split PCI handling into a separate function
---
 drivers/iommu/of_iommu.c | 46 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 57f23eaaa2f9..19e1e8f2f871 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -22,6 +22,7 @@
 #include <linux/limits.h>
 #include <linux/of.h>
 #include <linux/of_iommu.h>
+#include <linux/of_pci.h>
 #include <linux/slab.h>
 
 static const struct of_device_id __iommu_of_table_sentinel
@@ -134,6 +135,45 @@ const struct iommu_ops *of_iommu_get_ops(struct device_node *np)
 	return ops;
 }
 
+static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
+{
+	struct of_phandle_args *iommu_spec = data;
+
+	iommu_spec->args[0] = alias;
+	return iommu_spec->np == pdev->bus->dev.of_node;
+}
+
+static const struct iommu_ops
+*of_pci_iommu_configure(struct pci_dev *pdev, struct device_node *bridge_np)
+{
+	const struct iommu_ops *ops;
+	struct of_phandle_args iommu_spec;
+
+	/*
+	 * Start by tracing the RID alias down the PCI topology as
+	 * far as the host bridge whose OF node we have...
+	 * (we're not even attempting to handle multi-alias devices yet)
+	 */
+	iommu_spec.args_count = 1;
+	iommu_spec.np = bridge_np;
+	pci_for_each_dma_alias(pdev, __get_pci_rid, &iommu_spec);
+	/*
+	 * ...then find out what that becomes once it escapes the PCI
+	 * bus into the system beyond, and which IOMMU it ends up at.
+	 */
+	iommu_spec.np = NULL;
+	if (of_pci_map_rid(bridge_np, iommu_spec.args[0], "iommu-map",
+			   "iommu-map-mask", &iommu_spec.np, iommu_spec.args))
+		return NULL;
+
+	ops = of_iommu_get_ops(iommu_spec.np);
+	if (!ops || !ops->of_xlate || ops->of_xlate(&pdev->dev, &iommu_spec))
+		ops = NULL;
+
+	of_node_put(iommu_spec.np);
+	return ops;
+}
+
 const struct iommu_ops *of_iommu_configure(struct device *dev,
 					   struct device_node *master_np)
 {
@@ -142,12 +182,8 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 	const struct iommu_ops *ops = NULL;
 	int idx = 0;
 
-	/*
-	 * We can't do much for PCI devices without knowing how
-	 * device IDs are wired up from the PCI bus to the IOMMU.
-	 */
 	if (dev_is_pci(dev))
-		return NULL;
+		return of_pci_iommu_configure(to_pci_dev(dev), master_np);
 
 	/*
 	 * We don't currently walk up the tree looking for a parent IOMMU.
-- 
2.8.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
