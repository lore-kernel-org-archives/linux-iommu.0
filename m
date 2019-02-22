From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v7 9/9] vfio/type1: Handle different mdev isolation type
Date: Fri, 22 Feb 2019 10:19:27 +0800
Message-ID: <20190222021927.13132-10-baolu.lu@linux.intel.com>
References: <20190222021927.13132-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190222021927.13132-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, tiwei.bie@intel.com, xin.zeng@intel.com, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This adds the support to determine the isolation type
of a mediated device group by checking whether it has
an iommu device. If an iommu device exists, an iommu
domain will be allocated and then attached to the iommu
device. Otherwise, keep the same behavior as it is.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/vfio/vfio_iommu_type1.c | 48 ++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index ccc4165474aa..f1392c582a3c 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1368,13 +1368,40 @@ static void vfio_iommu_detach_group(struct vfio_domain *domain,
 		iommu_detach_group(domain->domain, group->iommu_group);
 }
 
+static bool vfio_bus_is_mdev(struct bus_type *bus)
+{
+	struct bus_type *mdev_bus;
+	bool ret = false;
+
+	mdev_bus = symbol_get(mdev_bus_type);
+	if (mdev_bus) {
+		ret = (bus == mdev_bus);
+		symbol_put(mdev_bus_type);
+	}
+
+	return ret;
+}
+
+static int vfio_mdev_iommu_device(struct device *dev, void *data)
+{
+	struct device **old = data, *new;
+
+	new = vfio_mdev_get_iommu_device(dev);
+	if (!new || (*old && *old != new))
+		return -EINVAL;
+
+	*old = new;
+
+	return 0;
+}
+
 static int vfio_iommu_type1_attach_group(void *iommu_data,
 					 struct iommu_group *iommu_group)
 {
 	struct vfio_iommu *iommu = iommu_data;
 	struct vfio_group *group;
 	struct vfio_domain *domain, *d;
-	struct bus_type *bus = NULL, *mdev_bus;
+	struct bus_type *bus = NULL;
 	int ret;
 	bool resv_msi, msi_remap;
 	phys_addr_t resv_msi_base;
@@ -1409,23 +1436,30 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	if (ret)
 		goto out_free;
 
-	mdev_bus = symbol_get(mdev_bus_type);
+	if (vfio_bus_is_mdev(bus)) {
+		struct device *iommu_device = NULL;
 
-	if (mdev_bus) {
-		if ((bus == mdev_bus) && !iommu_present(bus)) {
-			symbol_put(mdev_bus_type);
+		group->mdev_group = true;
+
+		/* Determine the isolation type */
+		ret = iommu_group_for_each_dev(iommu_group, &iommu_device,
+					       vfio_mdev_iommu_device);
+		if (ret || !iommu_device) {
 			if (!iommu->external_domain) {
 				INIT_LIST_HEAD(&domain->group_list);
 				iommu->external_domain = domain;
-			} else
+			} else {
 				kfree(domain);
+			}
 
 			list_add(&group->next,
 				 &iommu->external_domain->group_list);
 			mutex_unlock(&iommu->lock);
+
 			return 0;
 		}
-		symbol_put(mdev_bus_type);
+
+		bus = iommu_device->bus;
 	}
 
 	domain->domain = iommu_domain_alloc(bus);
-- 
2.17.1
