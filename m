From: shameer <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH 1/2] acpi:iort: Add an IORT helper function to reserve HW ITS address regions for IOMMU drivers
Date: Tue, 13 Jun 2017 12:48:28 +0100
Message-ID: <20170613114829.188036-2-shameerali.kolothum.thodi@huawei.com>
References: <20170613114829.188036-1-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170613114829.188036-1-shameerali.kolothum.thodi@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: lorenzo.pieralisi@arm.com, marc.zyngier@arm.com, sudeep.holla@arm.com, will.deacon@arm.com, robin.murphy@arm.com, hanjun.guo@linaro.org
Cc: gabriele.paoloni@huawei.com, john.garry@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, devel@acpica.org, linuxarm@huawei.com, wangzhou1@hisilicon.com, guohanjun@huawei.com, shameer <shameerali.kolothum.thodi@huawei.com>
List-Id: iommu@lists.linux-foundation.org

The helper function retrieves ITS address regions through IORT
device <-> ITS mappings and reserves it so that these regions
will not be translated by IOMMU and will be excluded from IOVA
allocations. IOMMU drivers can use this to implement their
.get_resv_regions callback.

Signed-off-by: shameer <shameerali.kolothum.thodi@huawei.com>
---
 drivers/acpi/arm64/iort.c        | 92 ++++++++++++++++++++++++++++++++++++++--
 drivers/irqchip/irq-gic-v3-its.c |  3 +-
 include/linux/acpi_iort.h        |  7 ++-
 3 files changed, 97 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index c5fecf9..0ee9965 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -34,6 +34,7 @@
 struct iort_its_msi_chip {
 	struct list_head	list;
 	struct fwnode_handle	*fw_node;
+	phys_addr_t		base_addr;
 	u32			translation_id;
 };
 
@@ -131,14 +132,16 @@ typedef acpi_status (*iort_find_node_callback)
 static DEFINE_SPINLOCK(iort_msi_chip_lock);
 
 /**
- * iort_register_domain_token() - register domain token and related ITS ID
- * to the list from where we can get it back later on.
+ * iort_register_domain_token() - register domain token along with related
+ * ITS ID and base address to the list from where we can get it back later on.
  * @trans_id: ITS ID.
+ * @base: ITS base address.
  * @fw_node: Domain token.
  *
  * Returns: 0 on success, -ENOMEM if no memory when allocating list element
  */
-int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_node)
+int iort_register_domain_token(int trans_id, phys_addr_t base,
+			       struct fwnode_handle *fw_node)
 {
 	struct iort_its_msi_chip *its_msi_chip;
 
@@ -148,6 +151,7 @@ int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_node)
 
 	its_msi_chip->fw_node = fw_node;
 	its_msi_chip->translation_id = trans_id;
+	its_msi_chip->base_addr = base;
 
 	spin_lock(&iort_msi_chip_lock);
 	list_add(&its_msi_chip->list, &iort_msi_chip_list);
@@ -491,6 +495,24 @@ int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
 	return -ENODEV;
 }
 
+static int iort_find_its_base(u32 its_id, phys_addr_t *base)
+{
+	struct iort_its_msi_chip *its_msi_chip;
+	bool match = false;
+
+	spin_lock(&iort_msi_chip_lock);
+	list_for_each_entry(its_msi_chip, &iort_msi_chip_list, list) {
+		if (its_msi_chip->translation_id == its_id) {
+			*base = its_msi_chip->base_addr;
+			match = true;
+			break;
+		}
+	}
+	spin_unlock(&iort_msi_chip_lock);
+
+	return match ? 0 : -ENODEV;
+}
+
 /**
  * iort_dev_find_its_id() - Find the ITS identifier for a device
  * @dev: The device.
@@ -649,6 +671,68 @@ int iort_add_device_replay(const struct iommu_ops *ops, struct device *dev)
 
 	return err;
 }
+
+/**
+ * iort_iommu_its_get_resv_regions - Reserved region driver helper
+ * @dev: Device from iommu_get_resv_regions()
+ * @list: Reserved region list from iommu_get_resv_regions()
+ *
+ * Returns: 0 on at least one ITS address region reservation,
+ *          appropriate error value otherwise.
+ *
+ * IOMMU drivers can use this to implement their .get_resv_regions callback
+ * for reserving the HW ITS address regions.
+ */
+int iort_iommu_its_get_resv_regions(struct device *dev, struct list_head *head)
+{
+	int i;
+	struct acpi_iort_node *node;
+	struct acpi_iort_its_group *its;
+	bool resv = false;
+
+	node = iort_find_dev_node(dev);
+	if (!node)
+		return -ENODEV;
+
+	if (dev_is_pci(dev)) {
+		u32 rid;
+
+		pci_for_each_dma_alias(to_pci_dev(dev), __get_pci_rid, &rid);
+		node = iort_node_map_id(node, rid, NULL, IORT_MSI_TYPE);
+
+	} else {
+		for (i = 0; i < node->mapping_count; i++) {
+			node = iort_node_map_platform_id(node, NULL,
+							 IORT_MSI_TYPE, i);
+			if (node)
+				break;
+		}
+	}
+
+	if (!node)
+		return -ENODEV;
+
+	/* Move to ITS specific data */
+	its = (struct acpi_iort_its_group *)node->node_data;
+
+	for (i = 0; i < its->its_count; i++) {
+		phys_addr_t base;
+
+		if (!iort_find_its_base(its->identifiers[i], &base)) {
+			int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
+			struct iommu_resv_region *region;
+
+			region = iommu_alloc_resv_region(base, SZ_128K, prot,
+							 IOMMU_RESV_MSI);
+			if (region) {
+				list_add_tail(&region->list, head);
+				resv = true;
+			}
+		}
+	}
+
+	return resv ? 0 : -ENODEV;
+}
 #else
 static inline
 const struct iommu_ops *iort_fwspec_iommu_ops(struct iommu_fwspec *fwspec)
@@ -656,6 +740,8 @@ const struct iommu_ops *iort_fwspec_iommu_ops(struct iommu_fwspec *fwspec)
 static inline
 int iort_add_device_replay(const struct iommu_ops *ops, struct device *dev)
 { return 0; }
+int iort_iommu_its_get_resv_regions(struct device *dev, struct list_head *head)
+{ return -ENODEV; }
 #endif
 
 static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
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
index 3ff9ace..35cf45c 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -26,7 +26,8 @@
 #define IORT_IRQ_MASK(irq)		(irq & 0xffffffffULL)
 #define IORT_IRQ_TRIGGER_MASK(irq)	((irq >> 32) & 0xffffffffULL)
 
-int iort_register_domain_token(int trans_id, struct fwnode_handle *fw_node);
+int iort_register_domain_token(int trans_id, phys_addr_t base,
+			       struct fwnode_handle *fw_node);
 void iort_deregister_domain_token(int trans_id);
 struct fwnode_handle *iort_find_domain_token(int trans_id);
 #ifdef CONFIG_ACPI_IORT
@@ -39,6 +40,7 @@
 /* IOMMU interface */
 void iort_set_dma_mask(struct device *dev);
 const struct iommu_ops *iort_iommu_configure(struct device *dev);
+int iort_iommu_its_get_resv_regions(struct device *dev, struct list_head *head);
 #else
 static inline void acpi_iort_init(void) { }
 static inline bool iort_node_match(u8 type) { return false; }
@@ -53,6 +55,9 @@ static inline void iort_set_dma_mask(struct device *dev) { }
 static inline
 const struct iommu_ops *iort_iommu_configure(struct device *dev)
 { return NULL; }
+static inline
+int iort_iommu_its_get_resv_regions(struct device *dev, struct list_head *head)
+{ return -ENODEV; }
 #endif
 
 #endif /* __ACPI_IORT_H__ */
-- 
1.9.1


