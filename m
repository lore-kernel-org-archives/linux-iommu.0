From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 7/8] iommu: of: Handle IOMMU lookup failure with deferred
	probing or error
Date: Tue,  9 Aug 2016 04:19:09 +0530
Message-ID: <1470696550-3416-8-git-send-email-sricharan@codeaurora.org>
References: <1470696550-3416-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1470696550-3416-1-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org
Cc: sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

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

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/of_iommu.c | 21 +++++++++++++++++----
 drivers/of/device.c      |  2 ++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 4c4219d..3994cf5 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -149,7 +149,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 {
 	struct of_phandle_args iommu_spec;
 	struct device_node *np = NULL;
-	struct iommu_ops *ops = NULL;
+	const struct iommu_ops *ops = NULL;
 	int idx = 0;
 
 	if (dev_is_pci(dev)) {
@@ -189,8 +189,21 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 		np = iommu_spec.np;
 		ops = of_iommu_get_ops(np);
 
-		if (!ops || !ops->of_xlate || ops->of_xlate(dev, &iommu_spec))
+		if (!ops) {
+			const struct of_device_id *oid;
+
+			oid = of_match_node(&__iommu_of_table, np);
+			ops = oid ? ERR_PTR(-EPROBE_DEFER) : NULL;
 			goto err_put_node;
+		}
+
+		if (!ops->of_xlate || ops->of_xlate(dev, &iommu_spec)) {
+			ops = NULL;
+			goto err_put_node;
+		}
+
+		if (ops->add_device)
+			ops = ops->add_device(dev) ? ops : NULL;
 
 		of_node_put(np);
 		idx++;
@@ -200,7 +213,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 
 err_put_node:
 	of_node_put(np);
-	return NULL;
+	return ops;
 }
 
 void __init of_iommu_init(void)
@@ -211,7 +224,7 @@ void __init of_iommu_init(void)
 	for_each_matching_node_and_match(np, matches, &match) {
 		const of_iommu_init_fn init_fn = match->data;
 
-		if (init_fn(np))
+		if (init_fn && init_fn(np))
 			pr_err("Failed to initialise IOMMU %s\n",
 				of_node_full_name(np));
 	}
diff --git a/drivers/of/device.c b/drivers/of/device.c
index e1fad50..92e02dc 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -149,6 +149,8 @@ int of_dma_configure_ops(struct device *dev, struct device_node *np)
 		coherent ? " " : " not ");
 
 	iommu = of_iommu_configure(dev, np);
+	if (IS_ERR(iommu))
+		return PTR_ERR(iommu);
 	dev_dbg(dev, "device is%sbehind an iommu\n",
 		iommu ? " " : " not ");
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
