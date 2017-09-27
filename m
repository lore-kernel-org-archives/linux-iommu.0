From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v8 3/5] iommu/of: Add msi address regions reservation helper
Date: Wed, 27 Sep 2017 14:32:39 +0100
Message-ID: <20170927133241.21036-4-shameerali.kolothum.thodi@huawei.com>
References: <20170927133241.21036-1-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170927133241.21036-1-shameerali.kolothum.thodi@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: lorenzo.pieralisi@arm.com, marc.zyngier@arm.com, sudeep.holla@arm.com, will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org, mark.rutland@arm.com, robh@kernel.org
Cc: gabriele.paoloni@huawei.com, john.garry@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, devel@acpica.org, linuxarm@huawei.com, wangzhou1@hisilicon.com, guohanjun@huawei.com, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
List-Id: iommu@lists.linux-foundation.org

From: John Garry <john.garry@huawei.com>

On some platforms msi-controller address regions have to be excluded
from normal IOVA allocation in that they are detected and decoded in
a HW specific way by system components and so they cannot be considered
normal IOVA address space.

Add a helper function that retrieves msi address regions through device
tree msi mapping, so that these regions will not be translated by IOMMU
and will be excluded from IOVA allocations.

Signed-off-by: John Garry <john.garry@huawei.com>
[Shameer: Modified msi-parent retrieval logic]
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/of_iommu.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_iommu.h | 10 +++++
 2 files changed, 105 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index e60e3db..ffd7fb7 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -21,6 +21,7 @@
 #include <linux/iommu.h>
 #include <linux/limits.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_iommu.h>
 #include <linux/of_pci.h>
 #include <linux/slab.h>
@@ -138,6 +139,14 @@ static int of_iommu_xlate(struct device *dev,
 	return ops->of_xlate(dev, iommu_spec);
 }
 
+static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
+{
+	u32 *rid = data;
+
+	*rid = alias;
+	return 0;
+}
+
 struct of_pci_iommu_alias_info {
 	struct device *dev;
 	struct device_node *np;
@@ -163,6 +172,73 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 	return info->np == pdev->bus->dev.of_node;
 }
 
+static int of_iommu_alloc_resv_region(struct device_node *np,
+				      struct list_head *head)
+{
+	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
+	struct iommu_resv_region *region;
+	struct resource res;
+	int err;
+
+	err = of_address_to_resource(np, 0, &res);
+	if (err)
+		return err;
+
+	region = iommu_alloc_resv_region(res.start, resource_size(&res),
+					 prot, IOMMU_RESV_MSI);
+	if (!region)
+		return -ENOMEM;
+
+	list_add_tail(&region->list, head);
+
+	return 0;
+}
+
+static int of_pci_msi_get_resv_regions(struct device *dev,
+				       struct list_head *head)
+{
+	struct device_node *msi_np;
+	struct device *pdev;
+	u32 rid;
+	int err, resv = 0;
+
+	pci_for_each_dma_alias(to_pci_dev(dev), __get_pci_rid, &rid);
+
+	for_each_node_with_property(msi_np, "msi-controller") {
+		for (pdev = dev; pdev; pdev = pdev->parent) {
+			if (!of_pci_map_rid(pdev->of_node, rid, "msi-map",
+					    "msi-map-mask", &msi_np, NULL)) {
+
+				err = of_iommu_alloc_resv_region(msi_np, head);
+				if (err)
+					return err;
+				resv++;
+			}
+		}
+	}
+
+	return resv;
+}
+
+static int of_platform_msi_get_resv_regions(struct device *dev,
+				       struct list_head *head)
+{
+	struct of_phandle_args args;
+	int err, resv = 0;
+
+	while (!of_parse_phandle_with_args(dev->of_node, "msi-parent",
+					   "#msi-cells", resv, &args)) {
+
+		err = of_iommu_alloc_resv_region(args.np, head);
+		of_node_put(args.np);
+		if (err)
+			return err;
+		resv++;
+	}
+
+	return resv;
+}
+
 const struct iommu_ops *of_iommu_configure(struct device *dev,
 					   struct device_node *master_np)
 {
@@ -235,6 +311,25 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 	return ops;
 }
 
+/**
+ * of_iommu_msi_get_resv_regions - Reserved region driver helper
+ * @dev: Device from iommu_get_resv_regions()
+ * @head: Reserved region list from iommu_get_resv_regions()
+ *
+ * Returns: Number of reserved regions on success (0 if no associated
+ *          msi parent), appropriate error value otherwise.
+ */
+int of_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
+{
+
+	if (dev_is_pci(dev))
+		return of_pci_msi_get_resv_regions(dev, head);
+	else if (dev->of_node)
+		return of_platform_msi_get_resv_regions(dev, head);
+
+	return 0;
+}
+
 static int __init of_iommu_init(void)
 {
 	struct device_node *np;
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index 13394ac..9267772 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -14,6 +14,9 @@ extern int of_get_dma_window(struct device_node *dn, const char *prefix,
 extern const struct iommu_ops *of_iommu_configure(struct device *dev,
 					struct device_node *master_np);
 
+extern int of_iommu_msi_get_resv_regions(struct device *dev,
+					struct list_head *head);
+
 #else
 
 static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
@@ -29,6 +32,13 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
 	return NULL;
 }
 
+static int of_iommu_msi_get_resv_regions(struct device *dev,
+					struct list_head *head)
+{
+	return -ENODEV;
+}
+
+
 #endif	/* CONFIG_OF_IOMMU */
 
 extern struct of_device_id __iommu_of_table;
-- 
1.9.1


