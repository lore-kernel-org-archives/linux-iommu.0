From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 1/7] iommu/of: Respect disabled IOMMUs
Date: Fri,  3 Jun 2016 18:15:36 +0100
Message-ID: <aca0b44206c87f6cb75d156a53e08aa968981119.1464966939.git.robin.murphy@arm.com>
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

If an IOMMU node is present in the DT but marked as disabled, we should
avoid trying to do anything with it. We currently sort-of get away with
this by virtue of a disabled device probably not having called
of_iommu_set_ops(), but that is hardly safe to rely upon in general, and
either way we don't want to treat it as an error condition with the
resulting "Failed to initialise IOMMU" message.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v2: New.

 drivers/iommu/of_iommu.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index af499aea0a1a..662f9a600f4f 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -140,7 +140,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 	struct of_phandle_args iommu_spec;
 	struct device_node *np;
 	const struct iommu_ops *ops = NULL;
-	int idx = 0;
+	int idx;
 
 	/*
 	 * We can't do much for PCI devices without knowing how
@@ -154,24 +154,25 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 	 * See the `Notes:' section of
 	 * Documentation/devicetree/bindings/iommu/iommu.txt
 	 */
-	while (!of_parse_phandle_with_args(master_np, "iommus",
-					   "#iommu-cells", idx,
-					   &iommu_spec)) {
+	for (idx = 0;
+	     !of_parse_phandle_with_args(master_np, "iommus", "#iommu-cells",
+					 idx, &iommu_spec);
+	     of_node_put(np), idx++) {
 		np = iommu_spec.np;
+		if (!of_device_is_available(np))
+			continue;
+
 		ops = of_iommu_get_ops(np);
+		if (!ops || !ops->of_xlate)
+			continue;
 
-		if (!ops || !ops->of_xlate || ops->of_xlate(dev, &iommu_spec))
-			goto err_put_node;
-
-		of_node_put(np);
-		idx++;
+		if (ops->of_xlate(dev, &iommu_spec)) {
+			of_node_put(np);
+			return NULL;
+		}
 	}
 
 	return ops;
-
-err_put_node:
-	of_node_put(np);
-	return NULL;
 }
 
 void __init of_iommu_init(void)
@@ -182,7 +183,7 @@ void __init of_iommu_init(void)
 	for_each_matching_node_and_match(np, matches, &match) {
 		const of_iommu_init_fn init_fn = match->data;
 
-		if (init_fn(np))
+		if (of_device_is_available(np) && init_fn(np))
 			pr_err("Failed to initialise IOMMU %s\n",
 				of_node_full_name(np));
 	}
-- 
2.8.1.dirty
