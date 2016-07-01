From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v4 4/8] iommu/of: Handle iommu-map property for PCI
Date: Fri,  1 Jul 2016 17:50:13 +0100
Message-ID: <3e048b1536c4524c688ea1163623c585df0214f1.1467388950.git.robin.murphy@arm.com>
References: <cover.1467388950.git.robin.murphy@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1467388950.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Now that we have a way to pick up the RID translation and target IOMMU,
hook up of_iommu_configure() to bring PCI devices into the of_xlate
mechanism and allow them IOMMU-backed DMA ops without the need for
driver-specific handling.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v4: No change.

 drivers/iommu/of_iommu.c | 43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index af499aea0a1a..1fe1f620f79d 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -22,6 +22,7 @@
 #include <linux/limits.h>
 #include <linux/of.h>
 #include <linux/of_iommu.h>
+#include <linux/of_pci.h>
 #include <linux/slab.h>
 
 static const struct of_device_id __iommu_of_table_sentinel
@@ -134,20 +135,48 @@ const struct iommu_ops *of_iommu_get_ops(struct device_node *np)
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
 const struct iommu_ops *of_iommu_configure(struct device *dev,
 					   struct device_node *master_np)
 {
 	struct of_phandle_args iommu_spec;
-	struct device_node *np;
+	struct device_node *np = NULL;
 	const struct iommu_ops *ops = NULL;
 	int idx = 0;
 
-	/*
-	 * We can't do much for PCI devices without knowing how
-	 * device IDs are wired up from the PCI bus to the IOMMU.
-	 */
-	if (dev_is_pci(dev))
-		return NULL;
+	if (dev_is_pci(dev)) {
+		/*
+		 * Start by tracing the RID alias down the PCI topology as
+		 * far as the host bridge whose OF node we have...
+		 */
+		iommu_spec.np = master_np;
+		pci_for_each_dma_alias(to_pci_dev(dev), __get_pci_rid,
+				       &iommu_spec);
+		/*
+		 * ...then find out what that becomes once it escapes the PCI
+		 * bus into the system beyond, and which IOMMU it ends up at.
+		 */
+		if (of_pci_map_rid(master_np, iommu_spec.args[0], "iommu-map",
+				    "iommu-map-mask", &np, iommu_spec.args))
+			return NULL;
+
+		/* We're not attempting to handle multi-alias devices yet */
+		iommu_spec.np = np;
+		iommu_spec.args_count = 1;
+		ops = of_iommu_get_ops(np);
+		if (!ops || !ops->of_xlate || ops->of_xlate(dev, &iommu_spec))
+			ops = NULL;
+
+		of_node_put(np);
+		return ops;
+	}
 
 	/*
 	 * We don't currently walk up the tree looking for a parent IOMMU.
-- 
2.8.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
