From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V5 11/12] drivers: acpi: Handle IOMMU lookup failure with
	deferred probing or error
Date: Thu, 19 Jan 2017 20:35:55 +0530
Message-ID: <1484838356-24962-12-git-send-email-sricharan@codeaurora.org>
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

This is an equivalent to the DT's handling of the iommu master's probe
with deferred probing when the corrsponding iommu is not probed yet.
The lack of a registered IOMMU can be caused by the lack of a driver for
the IOMMU, the IOMMU device probe not having been performed yet, having
been deferred, or having failed.

The first case occurs when the firmware describes the bus master and
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

Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 * Removed the dma configuration for the pci devices in case of ACPI
   from pci_dma_configure which was hanging outside separately and
   doing it in dma_configure function itself.

 drivers/acpi/arm64/iort.c  | 25 ++++++++++++++++++++++++-
 drivers/acpi/scan.c        |  7 +++++--
 drivers/base/dma-mapping.c |  2 +-
 include/acpi/acpi_bus.h    |  2 +-
 include/linux/acpi.h       |  7 +++++--
 5 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index bf0ed09..d01bae8 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -550,8 +550,17 @@ static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
 			return NULL;
 
 		ops = iommu_get_instance(iort_fwnode);
+		/*
+		 * If the ops look-up fails, this means that either
+		 * the SMMU drivers have not been probed yet or that
+		 * the SMMU drivers are not built in the kernel;
+		 * Depending on whether the SMMU drivers are built-in
+		 * in the kernel or not, defer the IOMMU configuration
+		 * or just abort it.
+		 */
 		if (!ops)
-			return NULL;
+			return iort_iommu_driver_enabled(node->type) ?
+			       ERR_PTR(-EPROBE_DEFER) : NULL;
 
 		ret = arm_smmu_iort_xlate(dev, streamid, iort_fwnode, ops);
 	}
@@ -625,12 +634,26 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
 
 		while (parent) {
 			ops = iort_iommu_xlate(dev, parent, streamid);
+			if (IS_ERR_OR_NULL(ops))
+				return ops;
 
 			parent = iort_node_get_id(node, &streamid,
 						  IORT_IOMMU_TYPE, i++);
 		}
 	}
 
+	/*
+	 * If we have reason to believe the IOMMU driver missed the initial
+	 * add_device callback for dev, replay it to get things in order.
+	 */
+	if (!IS_ERR_OR_NULL(ops) && ops->add_device &&
+	    dev->bus && !dev->iommu_group) {
+		int err = ops->add_device(dev);
+
+		if (err)
+			ops = ERR_PTR(err);
+	}
+
 	return ops;
 }
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 1926918..823b005 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1373,20 +1373,23 @@ enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
  * @dev: The pointer to the device
  * @attr: device dma attributes
  */
-void acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
+int acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
 {
 	const struct iommu_ops *iommu;
 
 	iort_set_dma_mask(dev);
 
 	iommu = iort_iommu_configure(dev);
-
+	if (IS_ERR(iommu))
+		return PTR_ERR(iommu);
 	/*
 	 * Assume dma valid range starts at 0 and covers the whole
 	 * coherent_dma_mask.
 	 */
 	arch_setup_dma_ops(dev, 0, dev->coherent_dma_mask + 1, iommu,
 			   attr == DEV_DMA_COHERENT);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(acpi_dma_configure);
 
diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
index 294942d..4b62a32 100644
--- a/drivers/base/dma-mapping.c
+++ b/drivers/base/dma-mapping.c
@@ -371,7 +371,7 @@ int dma_configure(struct device *dev)
 		if (attr == DEV_DMA_NOT_SUPPORTED)
 			dev_warn(dev, "DMA not supported.\n");
 		else
-			acpi_dma_configure(dev, attr);
+			ret = acpi_dma_configure(dev, attr);
 	}
 
 	if (is_pci)
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 4242c31..9aa762fe 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -573,7 +573,7 @@ struct acpi_pci_root {
 
 bool acpi_dma_supported(struct acpi_device *adev);
 enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
-void acpi_dma_configure(struct device *dev, enum dev_dma_attr attr);
+int acpi_dma_configure(struct device *dev, enum dev_dma_attr attr);
 void acpi_dma_deconfigure(struct device *dev);
 
 struct acpi_device *acpi_find_child_device(struct acpi_device *parent,
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 5b36974..8b958b6 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -764,8 +764,11 @@ static inline enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
 	return DEV_DMA_NOT_SUPPORTED;
 }
 
-static inline void acpi_dma_configure(struct device *dev,
-				      enum dev_dma_attr attr) { }
+static inline int acpi_dma_configure(struct device *dev,
+				     enum dev_dma_attr attr)
+{
+	return 0;
+}
 
 static inline void acpi_dma_deconfigure(struct device *dev) { }
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
