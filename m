From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 4/7] iommu/of: Handle iommu-map property for PCI
Date: Fri,  3 Jun 2016 18:15:39 +0100
Message-ID: <69952eda726c370ed6e5739bdd2e32cdc4466bfb.1464966939.git.robin.murphy@arm.com>
References: <cover.1464966939.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1464966939.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Now that we have a way to pick up the RID translation and target IOMMU,
hook up of_iommu_configure() to bring PCI devices into the of_xlate
mechanism and allow them IOMMU-backed DMA ops without the need for
driver-specific handling.

CC: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
CC: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v2: Skip disabled IOMMUs.

 drivers/iommu/of_iommu.c | 44 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 662f9a600f4f..5716131199b3 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -22,6 +22,7 @@
 #include <linux/limits.h>
 #include <linux/of.h>
 #include <linux/of_iommu.h>
+#include <linux/of_pci.h>
 #include <linux/slab.h>
 
 static const struct of_device_id __iommu_of_table_sentinel
@@ -134,20 +135,49 @@ const struct iommu_ops *of_iommu_get_ops(struct device_node *np)
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
 	int idx;
 
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
+		if (of_pci_map_rid(master_np, "iommu-map", iommu_spec.args[0],
+				   &np, iommu_spec.args) ||
+		    !of_device_is_available(np))
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
