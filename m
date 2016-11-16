From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v8 16/16] drivers: acpi: iort: introduce iort_iommu_configure
Date: Wed, 16 Nov 2016 15:29:36 +0000
Message-ID: <20161116152936.22955-17-lorenzo.pieralisi@arm.com>
References: <20161116152936.22955-1-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161116152936.22955-1-lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dennis Chen <dennis.chen-5wv7dgnIgG8@public.gmane.org>, Prem Mallappa <prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

DT based systems have a generic kernel API to configure IOMMUs
for devices (ie of_iommu_configure()).

On ARM based ACPI systems, the of_iommu_configure() equivalent can
be implemented atop ACPI IORT kernel API, with the corresponding
functions to map device identifiers to IOMMUs and retrieve the
corresponding IOMMU operations necessary for DMA operations set-up.

By relying on the iommu_fwspec generic kernel infrastructure,
implement the IORT based IOMMU configuration for ARM ACPI systems
and hook it up in the ACPI kernel layer that implements DMA
configuration for a device.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> [ACPI core]
Reviewed-by: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
Tested-by: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Tested-by: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
Cc: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
---
 drivers/acpi/arm64/iort.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/scan.c       |  7 +++-
 include/linux/acpi_iort.h |  6 +++
 3 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 7d30605..5fa585d 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -28,6 +28,8 @@
 
 #define IORT_TYPE_MASK(type)	(1 << (type))
 #define IORT_MSI_TYPE		(1 << ACPI_IORT_NODE_ITS_GROUP)
+#define IORT_IOMMU_TYPE		((1 << ACPI_IORT_NODE_SMMU) |	\
+				(1 << ACPI_IORT_NODE_SMMU_V3))
 
 struct iort_its_msi_chip {
 	struct list_head	list;
@@ -501,6 +503,102 @@ struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id)
 	return irq_find_matching_fwnode(handle, DOMAIN_BUS_PCI_MSI);
 }
 
+static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
+{
+	u32 *rid = data;
+
+	*rid = alias;
+	return 0;
+}
+
+static int arm_smmu_iort_xlate(struct device *dev, u32 streamid,
+			       struct fwnode_handle *fwnode,
+			       const struct iommu_ops *ops)
+{
+	int ret = iommu_fwspec_init(dev, fwnode, ops);
+
+	if (!ret)
+		ret = iommu_fwspec_add_ids(dev, &streamid, 1);
+
+	return ret;
+}
+
+static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
+					struct acpi_iort_node *node,
+					u32 streamid)
+{
+	const struct iommu_ops *ops = NULL;
+	int ret = -ENODEV;
+	struct fwnode_handle *iort_fwnode;
+
+	if (node) {
+		iort_fwnode = iort_get_fwnode(node);
+		if (!iort_fwnode)
+			return NULL;
+
+		ops = iommu_get_instance(iort_fwnode);
+		if (!ops)
+			return NULL;
+
+		ret = arm_smmu_iort_xlate(dev, streamid, iort_fwnode, ops);
+	}
+
+	return ret ? NULL : ops;
+}
+
+/**
+ * iort_iommu_configure - Set-up IOMMU configuration for a device.
+ *
+ * @dev: device to configure
+ *
+ * Returns: iommu_ops pointer on configuration success
+ *          NULL on configuration failure
+ */
+const struct iommu_ops *iort_iommu_configure(struct device *dev)
+{
+	struct acpi_iort_node *node, *parent;
+	const struct iommu_ops *ops = NULL;
+	u32 streamid = 0;
+
+	if (dev_is_pci(dev)) {
+		struct pci_bus *bus = to_pci_dev(dev)->bus;
+		u32 rid;
+
+		pci_for_each_dma_alias(to_pci_dev(dev), __get_pci_rid,
+				       &rid);
+
+		node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
+				      iort_match_node_callback, &bus->dev);
+		if (!node)
+			return NULL;
+
+		parent = iort_node_map_rid(node, rid, &streamid,
+					   IORT_IOMMU_TYPE);
+
+		ops = iort_iommu_xlate(dev, parent, streamid);
+
+	} else {
+		int i = 0;
+
+		node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
+				      iort_match_node_callback, dev);
+		if (!node)
+			return NULL;
+
+		parent = iort_node_get_id(node, &streamid,
+					  IORT_IOMMU_TYPE, i++);
+
+		while (parent) {
+			ops = iort_iommu_xlate(dev, parent, streamid);
+
+			parent = iort_node_get_id(node, &streamid,
+						  IORT_IOMMU_TYPE, i++);
+		}
+	}
+
+	return ops;
+}
+
 static void __init acpi_iort_register_irq(int hwirq, const char *name,
 					  int trigger,
 					  struct resource *res)
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 694e0b6..e5f7004 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/acpi.h>
+#include <linux/acpi_iort.h>
 #include <linux/signal.h>
 #include <linux/kthread.h>
 #include <linux/dmi.h>
@@ -1377,6 +1378,8 @@ enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
  */
 void acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
 {
+	const struct iommu_ops *iommu;
+
 	/*
 	 * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
 	 * setup the correct supported mask.
@@ -1391,11 +1394,13 @@ void acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
 	if (!dev->dma_mask)
 		dev->dma_mask = &dev->coherent_dma_mask;
 
+	iommu = iort_iommu_configure(dev);
+
 	/*
 	 * Assume dma valid range starts at 0 and covers the whole
 	 * coherent_dma_mask.
 	 */
-	arch_setup_dma_ops(dev, 0, dev->coherent_dma_mask + 1, NULL,
+	arch_setup_dma_ops(dev, 0, dev->coherent_dma_mask + 1, iommu,
 			   attr == DEV_DMA_COHERENT);
 }
 EXPORT_SYMBOL_GPL(acpi_dma_configure);
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 79ba1bb..dcb2b60 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -34,6 +34,8 @@ void acpi_iort_init(void);
 bool iort_node_match(u8 type);
 u32 iort_msi_map_rid(struct device *dev, u32 req_id);
 struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
+/* IOMMU interface */
+const struct iommu_ops *iort_iommu_configure(struct device *dev);
 #else
 static inline void acpi_iort_init(void) { }
 static inline bool iort_node_match(u8 type) { return false; }
@@ -42,6 +44,10 @@ static inline u32 iort_msi_map_rid(struct device *dev, u32 req_id)
 static inline struct irq_domain *iort_get_device_domain(struct device *dev,
 							u32 req_id)
 { return NULL; }
+/* IOMMU interface */
+static inline
+const struct iommu_ops *iort_iommu_configure(struct device *dev)
+{ return NULL; }
 #endif
 
 #define IORT_ACPI_DECLARE(name, table_id, fn)		\
-- 
2.10.0
