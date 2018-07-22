From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [RFC PATCH 09/10] vfio/mdev: Add mediated device domain type
Date: Sun, 22 Jul 2018 14:09:32 +0800
Message-ID: <1532239773-15325-10-git-send-email-baolu.lu@linux.intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

A parent device might create different types of mediated
devices. For example, a mediated device could be created
on the parent device with a PASID tagged. When the iommu
supports PASID-granular translations, the mediated device
is individually protected and isolated by the iommu. It's
hence possible to allocate a domain for each such device.

This patch defines the domain types of a mediated device
and allows the parent driver to specify this attribute
after a mdev is actually created.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/vfio/mdev/mdev_core.c    | 21 +++++++++++++++++++++
 drivers/vfio/mdev/mdev_private.h |  1 +
 include/linux/mdev.h             | 22 ++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index d8f19ba..4d82b36 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -391,6 +391,27 @@ int mdev_device_remove(struct device *dev, bool force_remove)
 	return 0;
 }
 
+int mdev_set_domain_type(struct device *dev, enum mdev_domain_type type)
+{
+	struct mdev_device *mdev = to_mdev_device(dev);
+
+	if (type == DOMAIN_TYPE_PRIVATE && !iommu_present(&mdev_bus_type))
+		return -EINVAL;
+
+	mdev->domain_type = type;
+
+	return 0;
+}
+EXPORT_SYMBOL(mdev_set_domain_type);
+
+enum mdev_domain_type mdev_get_domain_type(struct device *dev)
+{
+	struct mdev_device *mdev = to_mdev_device(dev);
+
+	return mdev->domain_type;
+}
+EXPORT_SYMBOL(mdev_get_domain_type);
+
 static int __init mdev_init(void)
 {
 	int ret;
diff --git a/drivers/vfio/mdev/mdev_private.h b/drivers/vfio/mdev/mdev_private.h
index b5819b7..d47a670 100644
--- a/drivers/vfio/mdev/mdev_private.h
+++ b/drivers/vfio/mdev/mdev_private.h
@@ -34,6 +34,7 @@ struct mdev_device {
 	struct list_head next;
 	struct kobject *type_kobj;
 	bool active;
+	int domain_type;
 };
 
 #define to_mdev_device(dev)	container_of(dev, struct mdev_device, dev)
diff --git a/include/linux/mdev.h b/include/linux/mdev.h
index b6e048e..5d862b0 100644
--- a/include/linux/mdev.h
+++ b/include/linux/mdev.h
@@ -15,6 +15,28 @@
 
 struct mdev_device;
 
+enum mdev_domain_type {
+	DOMAIN_TYPE_EXTERNAL,	/* Use the external domain and all
+				 * IOMMU staff controlled by the
+				 * parent device driver.
+				 */
+	DOMAIN_TYPE_INHERITANCE,/* Use the same domain as the parent device. */
+	DOMAIN_TYPE_PRIVATE,	/* Capable of having a private domain. For an
+				 * example, the parent device is able to bind
+				 * a specific PASID for a mediated device and
+				 * transferring data with the asigned PASID.
+				 */
+};
+
+/*
+ * Called by the parent device driver to set the domain type.
+ * By default, the domain type is set to DOMAIN_TYPE_EXTERNAL.
+ */
+int mdev_set_domain_type(struct device *dev, enum mdev_domain_type type);
+
+/* Check the domain type. */
+enum mdev_domain_type mdev_get_domain_type(struct device *dev);
+
 /**
  * struct mdev_parent_ops - Structure to be registered for each parent device to
  * register the device to mdev module.
-- 
2.7.4
