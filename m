From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v8 8/9] vfio/type1: Add domain at(de)taching group helpers
Date: Mon, 25 Mar 2019 09:30:35 +0800
Message-ID: <20190325013036.18400-9-baolu.lu@linux.intel.com>
References: <20190325013036.18400-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325013036.18400-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, tiwei.bie@intel.com, xin.zeng@intel.com, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This adds helpers to attach or detach a domain to a
group. This will replace iommu_attach_group() which
only works for non-mdev devices.

If a domain is attaching to a group which includes the
mediated devices, it should attach to the iommu device
(a pci device which represents the mdev in iommu scope)
instead. The added helper supports attaching domain to
groups for both pci and mdev devices.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/vfio/vfio_iommu_type1.c | 84 ++++++++++++++++++++++++++++++---
 1 file changed, 77 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 73652e21efec..ccc4165474aa 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -91,6 +91,7 @@ struct vfio_dma {
 struct vfio_group {
 	struct iommu_group	*iommu_group;
 	struct list_head	next;
+	bool			mdev_group;	/* An mdev group */
 };
 
 /*
@@ -1298,6 +1299,75 @@ static bool vfio_iommu_has_sw_msi(struct iommu_group *group, phys_addr_t *base)
 	return ret;
 }
 
+static struct device *vfio_mdev_get_iommu_device(struct device *dev)
+{
+	struct device *(*fn)(struct device *dev);
+	struct device *iommu_device;
+
+	fn = symbol_get(mdev_get_iommu_device);
+	if (fn) {
+		iommu_device = fn(dev);
+		symbol_put(mdev_get_iommu_device);
+
+		return iommu_device;
+	}
+
+	return NULL;
+}
+
+static int vfio_mdev_attach_domain(struct device *dev, void *data)
+{
+	struct iommu_domain *domain = data;
+	struct device *iommu_device;
+
+	iommu_device = vfio_mdev_get_iommu_device(dev);
+	if (iommu_device) {
+		if (iommu_dev_feature_enabled(iommu_device, IOMMU_DEV_FEAT_AUX))
+			return iommu_aux_attach_device(domain, iommu_device);
+		else
+			return iommu_attach_device(domain, iommu_device);
+	}
+
+	return -EINVAL;
+}
+
+static int vfio_mdev_detach_domain(struct device *dev, void *data)
+{
+	struct iommu_domain *domain = data;
+	struct device *iommu_device;
+
+	iommu_device = vfio_mdev_get_iommu_device(dev);
+	if (iommu_device) {
+		if (iommu_dev_feature_enabled(iommu_device, IOMMU_DEV_FEAT_AUX))
+			iommu_aux_detach_device(domain, iommu_device);
+		else
+			iommu_detach_device(domain, iommu_device);
+	}
+
+	return 0;
+}
+
+static int vfio_iommu_attach_group(struct vfio_domain *domain,
+				   struct vfio_group *group)
+{
+	if (group->mdev_group)
+		return iommu_group_for_each_dev(group->iommu_group,
+						domain->domain,
+						vfio_mdev_attach_domain);
+	else
+		return iommu_attach_group(domain->domain, group->iommu_group);
+}
+
+static void vfio_iommu_detach_group(struct vfio_domain *domain,
+				    struct vfio_group *group)
+{
+	if (group->mdev_group)
+		iommu_group_for_each_dev(group->iommu_group, domain->domain,
+					 vfio_mdev_detach_domain);
+	else
+		iommu_detach_group(domain->domain, group->iommu_group);
+}
+
 static int vfio_iommu_type1_attach_group(void *iommu_data,
 					 struct iommu_group *iommu_group)
 {
@@ -1373,7 +1443,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 			goto out_domain;
 	}
 
-	ret = iommu_attach_group(domain->domain, iommu_group);
+	ret = vfio_iommu_attach_group(domain, group);
 	if (ret)
 		goto out_domain;
 
@@ -1405,8 +1475,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	list_for_each_entry(d, &iommu->domain_list, next) {
 		if (d->domain->ops == domain->domain->ops &&
 		    d->prot == domain->prot) {
-			iommu_detach_group(domain->domain, iommu_group);
-			if (!iommu_attach_group(d->domain, iommu_group)) {
+			vfio_iommu_detach_group(domain, group);
+			if (!vfio_iommu_attach_group(d, group)) {
 				list_add(&group->next, &d->group_list);
 				iommu_domain_free(domain->domain);
 				kfree(domain);
@@ -1414,7 +1484,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 				return 0;
 			}
 
-			ret = iommu_attach_group(domain->domain, iommu_group);
+			ret = vfio_iommu_attach_group(domain, group);
 			if (ret)
 				goto out_domain;
 		}
@@ -1440,7 +1510,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	return 0;
 
 out_detach:
-	iommu_detach_group(domain->domain, iommu_group);
+	vfio_iommu_detach_group(domain, group);
 out_domain:
 	iommu_domain_free(domain->domain);
 out_free:
@@ -1531,7 +1601,7 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 		if (!group)
 			continue;
 
-		iommu_detach_group(domain->domain, iommu_group);
+		vfio_iommu_detach_group(domain, group);
 		list_del(&group->next);
 		kfree(group);
 		/*
@@ -1596,7 +1666,7 @@ static void vfio_release_domain(struct vfio_domain *domain, bool external)
 	list_for_each_entry_safe(group, group_tmp,
 				 &domain->group_list, next) {
 		if (!external)
-			iommu_detach_group(domain->domain, group->iommu_group);
+			vfio_iommu_detach_group(domain, group);
 		list_del(&group->next);
 		kfree(group);
 	}
-- 
2.17.1
