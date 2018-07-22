From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [RFC PATCH 06/10] iommu: Add iommu_set_bus API interface
Date: Sun, 22 Jul 2018 14:09:29 +0800
Message-ID: <1532239773-15325-7-git-send-email-baolu.lu@linux.intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This adds iommu_set_bus API by adding a new set_bus ops in the
iommu_ops structure. A vendor IOMMU driver could either specify
its callback or safely ignore it. This interface could be used
to set the iommu methods used for a particular non-pci bus. One
consumer of this interface could be vfio/mdev bus when the mdev
devices could be exclusively protected by the IOMMU units.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 23 +++++++++++++++++++++++
 include/linux/iommu.h | 12 ++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 63b3756..b22b0a7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1976,3 +1976,26 @@ int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
+
+int iommu_set_bus(struct bus_type *bus)
+{
+	struct iommu_device *iommu;
+	int ret = -ENODEV;
+
+	spin_lock(&iommu_device_lock);
+	/*
+	 * Iterate over iommu list and try setting bus with
+	 * each iommu until a successful setting.
+	 */
+	list_for_each_entry(iommu, &iommu_device_list, list) {
+		if (iommu->ops->set_bus) {
+			ret = iommu->ops->set_bus(bus, iommu);
+			if (!ret)
+				break;
+		}
+	}
+	spin_unlock(&iommu_device_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_set_bus);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 19938ee..2679796 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -48,6 +48,7 @@ struct bus_type;
 struct device;
 struct iommu_domain;
 struct notifier_block;
+struct iommu_device;
 
 /* iommu fault flags */
 #define IOMMU_FAULT_READ	0x0
@@ -187,6 +188,7 @@ struct iommu_resv_region {
  * @domain_get_windows: Return the number of windows for a domain
  * @of_xlate: add OF master IDs to iommu grouping
  * @pgsize_bitmap: bitmap of all possible supported page sizes
+ * @set_bus: set iommu ops for a non-pci bus
  */
 struct iommu_ops {
 	bool (*capable)(enum iommu_cap);
@@ -235,6 +237,9 @@ struct iommu_ops {
 	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
 	bool (*is_attach_deferred)(struct iommu_domain *domain, struct device *dev);
 
+	/* Set iommu ops for a bus */
+	int (*set_bus)(struct bus_type *bus, struct iommu_device *iommu);
+
 	unsigned long pgsize_bitmap;
 };
 
@@ -412,6 +417,8 @@ void iommu_fwspec_free(struct device *dev);
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
 const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
 
+int iommu_set_bus(struct bus_type *bus);
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -696,6 +703,11 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 	return NULL;
 }
 
+static inline int iommu_set_bus(struct bus_type *bus)
+{
+	return -ENODEV;
+}
+
 #endif /* CONFIG_IOMMU_API */
 
 #endif /* __LINUX_IOMMU_H */
-- 
2.7.4
