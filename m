From: shameer <shameerali.kolothum.thodi@huawei.com>
Subject: [RFCv2 1/2] acpi:iort: Add new helper function to retrieve ITS base addr from dev IORT node
Date: Wed, 31 May 2017 15:32:12 +0100
Message-ID: <20170531143213.82100-2-shameerali.kolothum.thodi@huawei.com>
References: <20170531143213.82100-1-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170531143213.82100-1-shameerali.kolothum.thodi@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: lorenzo.pieralisi@arm.com, marc.zyngier@arm.com, sudeep.holla@arm.com, will.deacon@arm.com, robin.murphy@arm.com, hanjun.guo@linaro.org
Cc: gabriele.paoloni@huawei.com, john.garry@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, devel@acpica.org, linuxarm@huawei.com, wangzhou1@hisilicon.com, guohanjun@huawei.com, shameer <shameerali.kolothum.thodi@huawei.com>
List-Id: iommu@lists.linux-foundation.org

This provides a helper function to find and retrieve the ITS
base address from the ID mappings array reference of a device
IORT node(if any).

This is used in the subsequent patch to retrieve the ITS base 
address associated with a pci dev IORT node.

Signed-off-by: shameer <shameerali.kolothum.thodi@huawei.com>
---
 drivers/acpi/arm64/iort.c        | 47 +++++++++++++++++++++++++++++++++++++---
 drivers/irqchip/irq-gic-v3-its.c |  3 ++-
 include/linux/acpi_iort.h        |  8 ++++++-
 3 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index c5fecf9..12d7347 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -34,6 +34,7 @@
 struct iort_its_msi_chip {
 	struct list_head	list;
 	struct fwnode_handle	*fw_node;
+	u64			base_addr;
 	u32			translation_id;
 };
 
@@ -132,13 +133,14 @@ typedef acpi_status (*iort_find_node_callback)
 
 /**
  * iort_register_domain_token() - register domain token and related ITS ID
- * to the list from where we can get it back later on.
+ * and base address to the list from where we can get it back later on.
  * @trans_id: ITS ID.
  * @fw_node: Domain token.
  *
  * Returns: 0 on success, -ENOMEM if no memory when allocating list element
  */
-int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_node)
+int iort_register_domain_token(int trans_id, u64 base,
+			       struct fwnode_handle *fw_node)
 {
 	struct iort_its_msi_chip *its_msi_chip;
 
@@ -148,6 +150,7 @@ int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_node)
 
 	its_msi_chip->fw_node = fw_node;
 	its_msi_chip->translation_id = trans_id;
+	its_msi_chip->base_addr = base;
 
 	spin_lock(&iort_msi_chip_lock);
 	list_add(&its_msi_chip->list, &iort_msi_chip_list);
@@ -370,7 +373,6 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
 
 		if (!node->mapping_offset || !node->mapping_count)
 			goto fail_map;
-
 		map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
 				   node->mapping_offset);
 
@@ -491,6 +493,45 @@ int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
 	return -ENODEV;
 }
 
+int iort_dev_find_its_base(struct device *dev, u32 req_id,
+			   unsigned int idx, u64 *its_base)
+{
+	struct acpi_iort_its_group *its;
+	struct acpi_iort_node *node;
+	struct iort_its_msi_chip *its_msi_chip;
+	u32  trans_id;
+
+	node = iort_find_dev_node(dev);
+	if (!node)
+		return -ENXIO;
+
+	node = iort_node_map_id(node, req_id, NULL, IORT_MSI_TYPE);
+	if (!node)
+		return -ENXIO;
+
+	/* Move to ITS specific data */
+	its = (struct acpi_iort_its_group *)node->node_data;
+	if (idx > its->its_count) {
+		dev_err(dev, "requested ITS ID index [%d] is greater than available [%d]\n",
+			idx, its->its_count);
+		return -ENXIO;
+	}
+
+	trans_id = its->identifiers[idx];
+
+	spin_lock(&iort_msi_chip_lock);
+	list_for_each_entry(its_msi_chip, &iort_msi_chip_list, list) {
+		if (its_msi_chip->translation_id == trans_id) {
+			*its_base = its_msi_chip->base_addr;
+			spin_unlock(&iort_msi_chip_lock);
+			return 0;
+		}
+	}
+	spin_unlock(&iort_msi_chip_lock);
+
+	return -ENXIO;
+}
+
 /**
  * iort_dev_find_its_id() - Find the ITS identifier for a device
  * @dev: The device.
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 45ea1933..c45a2ad 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1854,7 +1854,8 @@ static int __init gic_acpi_parse_madt_its(struct acpi_subtable_header *header,
 		return -ENOMEM;
 	}
 
-	err = iort_register_domain_token(its_entry->translation_id, dom_handle);
+	err = iort_register_domain_token(its_entry->translation_id, res.start,
+					 dom_handle);
 	if (err) {
 		pr_err("ITS@%pa: Unable to register GICv3 ITS domain token (ITS ID %d) to IORT\n",
 		       &res.start, its_entry->translation_id);
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 3ff9ace..bf7b53d 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -26,7 +26,8 @@
 #define IORT_IRQ_MASK(irq)		(irq & 0xffffffffULL)
 #define IORT_IRQ_TRIGGER_MASK(irq)	((irq >> 32) & 0xffffffffULL)
 
-int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_node);
+int iort_register_domain_token(int trans_id, u64 base,
+			       struct fwnode_handle *fw_node);
 void iort_deregister_domain_token(int trans_id);
 struct fwnode_handle *iort_find_domain_token(int trans_id);
 #ifdef CONFIG_ACPI_IORT
@@ -36,6 +37,8 @@
 struct irq_domain *iort_get_device_domain(struct device *dev, u32 req_id);
 void acpi_configure_pmsi_domain(struct device *dev);
 int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
+int iort_dev_find_its_base(struct device *dev, u32 req_id,
+			   unsigned int idx, u64 *its_base);
 /* IOMMU interface */
 void iort_set_dma_mask(struct device *dev);
 const struct iommu_ops *iort_iommu_configure(struct device *dev);
@@ -48,6 +51,9 @@ static inline struct irq_domain *iort_get_device_domain(struct device *dev,
 							u32 req_id)
 { return NULL; }
 static inline void acpi_configure_pmsi_domain(struct device *dev) { }
+int iort_dev_find_its_base(struct device *dev, u32 req_id,
+			   unsigned int idx, u64 *its_base)
+{ return -ENOSYS; }
 /* IOMMU interface */
 static inline void iort_set_dma_mask(struct device *dev) { }
 static inline
-- 
1.9.1


