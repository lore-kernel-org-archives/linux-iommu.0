From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [RFC PATCH v2 09/10] vfio/type1: Determine domain type of an mdev group
Date: Thu, 30 Aug 2018 12:09:21 +0800
Message-ID: <20180830040922.30426-10-baolu.lu@linux.intel.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830040922.30426-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, tiwei.bie@intel.com, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This adds the support to determine the domain type of a group
of mediated devices according to the domain type attribute of
each device.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/vfio/vfio_iommu_type1.c | 47 ++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 89e2e6123223..64bf55b91de1 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1390,6 +1390,27 @@ static void vfio_iommu_detach_group(struct vfio_domain *domain,
 		iommu_detach_group(domain->domain, group->iommu_group);
 }
 
+static int vfio_mdev_domain_type(struct device *dev, void *data)
+{
+	enum mdev_domain_type new, *old = data;
+	enum mdev_domain_type (*fn)(struct device *dev);
+
+	fn = symbol_get(mdev_get_domain_type);
+	if (fn) {
+		new = fn(dev);
+		symbol_put(mdev_get_domain_type);
+
+		if (*old && *old != new)
+			return -EINVAL;
+
+		*old = new;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static int vfio_iommu_type1_attach_group(void *iommu_data,
 					 struct iommu_group *iommu_group)
 {
@@ -1433,9 +1454,19 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 
 	mdev_bus = symbol_get(mdev_bus_type);
 
-	if (mdev_bus) {
-		if ((bus == mdev_bus) && !iommu_present(bus)) {
-			symbol_put(mdev_bus_type);
+	if (mdev_bus && bus == mdev_bus) {
+		enum mdev_domain_type type = 0;
+
+		symbol_put(mdev_bus_type);
+
+		/* Determine the domain type: */
+		ret = iommu_group_for_each_dev(iommu_group, &type,
+					       vfio_mdev_domain_type);
+		if (ret)
+			goto out_free;
+
+		switch (type) {
+		case DOMAIN_TYPE_NO_IOMMU:
 			if (!iommu->external_domain) {
 				INIT_LIST_HEAD(&domain->group_list);
 				iommu->external_domain = domain;
@@ -1445,11 +1476,19 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 			list_add(&group->next,
 				 &iommu->external_domain->group_list);
 			mutex_unlock(&iommu->lock);
+
 			return 0;
+		case DOMAIN_TYPE_ATTACH_PARENT:
+		/* FALLTHROUGH */
+		default:
+			ret = -EINVAL;
+			goto out_free;
 		}
-		symbol_put(mdev_bus_type);
 	}
 
+	if (mdev_bus)
+		symbol_put(mdev_bus_type);
+
 	domain->domain = iommu_domain_alloc(bus);
 	if (!domain->domain) {
 		ret = -EIO;
-- 
2.17.1
