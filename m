From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [RFC PATCH 10/10] vfio/type1: Allocate domain for mediated device
Date: Sun, 22 Jul 2018 14:09:33 +0800
Message-ID: <1532239773-15325-11-git-send-email-baolu.lu@linux.intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This allocates a domain for the mediated device if it is able to
be isolated and protected individually by IOMMU.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/vfio/vfio_iommu_type1.c | 43 ++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 3e5b177..496bea6 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1177,6 +1177,22 @@ static int vfio_bus_type(struct device *dev, void *data)
 	return 0;
 }
 
+static int mdev_private_domain(struct device *dev, void *data)
+{
+	enum mdev_domain_type type;
+	enum mdev_domain_type (*fn)(struct device *dev);
+
+	fn = symbol_get(mdev_get_domain_type);
+	if (fn) {
+		type = fn(dev);
+		symbol_put(mdev_get_domain_type);
+
+		return type != DOMAIN_TYPE_PRIVATE;
+	}
+
+	return -EINVAL;
+}
+
 static int vfio_iommu_replay(struct vfio_iommu *iommu,
 			     struct vfio_domain *domain)
 {
@@ -1371,18 +1387,23 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	mdev_bus = symbol_get(mdev_bus_type);
 
 	if (mdev_bus) {
-		if ((bus == mdev_bus) && !iommu_present(bus)) {
-			symbol_put(mdev_bus_type);
-			if (!iommu->external_domain) {
-				INIT_LIST_HEAD(&domain->group_list);
-				iommu->external_domain = domain;
-			} else
-				kfree(domain);
+		if (bus == mdev_bus) {
+			ret = iommu_group_for_each_dev(iommu_group, NULL,
+						       mdev_private_domain);
+			if (!iommu_present(bus) || ret) {
+				symbol_put(mdev_bus_type);
+				if (!iommu->external_domain) {
+					INIT_LIST_HEAD(&domain->group_list);
+					iommu->external_domain = domain;
+				} else {
+					kfree(domain);
+				}
 
-			list_add(&group->next,
-				 &iommu->external_domain->group_list);
-			mutex_unlock(&iommu->lock);
-			return 0;
+				list_add(&group->next,
+					 &iommu->external_domain->group_list);
+				mutex_unlock(&iommu->lock);
+				return 0;
+			}
 		}
 		symbol_put(mdev_bus_type);
 	}
-- 
2.7.4
