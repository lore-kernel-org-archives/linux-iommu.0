From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [RFC PATCH v2 10/10] vfio/type1: Attach domain for mdev group
Date: Thu, 30 Aug 2018 12:09:22 +0800
Message-ID: <20180830040922.30426-11-baolu.lu@linux.intel.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830040922.30426-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, tiwei.bie@intel.com, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

When attaching domain to a group of mediated devices which
all have the domain type attributes set to ATTACH_PARENT,
we should attach domain to the parent PCI device instead
of mdev device itself.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/vfio/vfio_iommu_type1.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 64bf55b91de1..c4231df44304 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1411,6 +1411,18 @@ static int vfio_mdev_domain_type(struct device *dev, void *data)
 	return -EINVAL;
 }
 
+static int vfio_parent_bus_type(struct device *dev, void *data)
+{
+	struct bus_type **bus = data;
+
+	if (*bus && *bus != dev->parent->bus)
+		return -EINVAL;
+
+	*bus = dev->parent->bus;
+
+	return 0;
+}
+
 static int vfio_iommu_type1_attach_group(void *iommu_data,
 					 struct iommu_group *iommu_group)
 {
@@ -1458,6 +1470,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 		enum mdev_domain_type type = 0;
 
 		symbol_put(mdev_bus_type);
+		mdev_bus = NULL;
 
 		/* Determine the domain type: */
 		ret = iommu_group_for_each_dev(iommu_group, &type,
@@ -1479,7 +1492,14 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 
 			return 0;
 		case DOMAIN_TYPE_ATTACH_PARENT:
-		/* FALLTHROUGH */
+			bus = NULL;
+			group->attach_parent = true;
+			/* Set @bus to bus type of the parent: */
+			ret = iommu_group_for_each_dev(iommu_group, &bus,
+						       vfio_parent_bus_type);
+			if (ret)
+				goto out_free;
+			break;
 		default:
 			ret = -EINVAL;
 			goto out_free;
-- 
2.17.1
