From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 03/12] iommu/of: Handle iommu-map property for PCI
Date: Mon, 29 Feb 2016 13:46:12 +0000
Message-ID: <961e88620bc9c113dbafa72081f864517fa1043c.1456514380.git.robin.murphy@arm.com>
References: <cover.1456514380.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1456514380.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Thomas.Lendacky-5C7GfCeVMHo@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, stuart.yoder-3arQi8VN3Tc@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Now that we have a way to pick up the RID translation and target IOMMU,
hook up of_iommu_configure() to bring PCI devices into the of_xlate
mechanism and allow them IOMMU-backed DMA ops without the need for
driver-specific handling.

CC: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
CC: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/of_iommu.c | 43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 5fea665..910826c 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -22,6 +22,7 @@
 #include <linux/limits.h>
 #include <linux/of.h>
 #include <linux/of_iommu.h>
+#include <linux/of_pci.h>
 #include <linux/slab.h>
 
 static const struct of_device_id __iommu_of_table_sentinel
@@ -134,20 +135,48 @@ struct iommu_ops *of_iommu_get_ops(struct device_node *np)
 	return ops;
 }
 
+static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
+{
+	struct of_phandle_args *iommu_spec = data;
+	struct device_node *np = pdev->bus->dev.of_node;
+
+	iommu_spec->args[0] = alias;
+	return np == iommu_spec->np;
+}
+
 struct iommu_ops *of_iommu_configure(struct device *dev,
 				     struct device_node *master_np)
 {
 	struct of_phandle_args iommu_spec;
-	struct device_node *np;
+	struct device_node *np = NULL;
 	struct iommu_ops *ops = NULL;
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
+		if (of_pci_map_rid(master_np, "iommu-map", iommu_spec.args[0],
+				   &np, iommu_spec.args))
+			return NULL;
+
+		iommu_spec.np = np;
+		iommu_spec.args_count = 1;
+		ops = of_iommu_get_ops(np);
+		if (!ops || !ops->of_xlate || ops->of_xlate(dev, &iommu_spec))
+			goto err_put_node;
+
+		of_node_put(np);
+		return ops;
+	}
 
 	/*
 	 * We don't currently walk up the tree looking for a parent IOMMU.
-- 
2.7.2.333.g70bd996.dirty
