From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 6/8] vfio/mdev: Add iommu place holders in mdev_device
Date: Mon,  5 Nov 2018 15:34:06 +0800
Message-ID: <20181105073408.21815-7-baolu.lu@linux.intel.com>
References: <20181105073408.21815-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181105073408.21815-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, tiwei.bie@intel.com, Zeng Xin <xin.zeng@intel.com>, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

A parent device might create different types of mediated
devices. For example, a mediated device could be created
by the parent device with full isolation and protection
provided by the IOMMU. One usage case could be found on
Intel platforms where a mediated device is an assignable
subset of a PCI, the DMA requests on behalf of it are all
tagged with a PASID. Since IOMMU supports PASID-granular
translations (scalable mode in vt-d 3.0), this mediated
device could be individually protected and isolated by an
IOMMU.

This patch adds two new members in struct mdev_device:
* iommu_device
  - This, if set, indicates that the mediated device could
    be fully isolated and protected by IOMMU via attaching
    an iommu domain to this device. If empty, it indicates
    using vendor defined isolation.

* iommu_domain
  - This is a place holder for an iommu domain. A domain
    could be store here for later use once it has been
    attached to the iommu_device of this mdev.

Below helpers are added to set and get above iommu device
and iommu domain pointers.

* mdev_set/get_iommu_device(dev, iommu_device)
  - Set or get the iommu device which represents this mdev
    in IOMMU's device scope. Drivers don't need to set the
    iommu device if it uses vendor defined isolation.

* mdev_set/get_iommu_domain(domain)
  - A iommu domain which has been attached to the iommu
    device in order to protect and isolate the mediated
    device will be kept in the mdev data structure and
    could be retrieved later.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/vfio/mdev/mdev_core.c    | 36 ++++++++++++++++++++++++++++++++
 drivers/vfio/mdev/mdev_private.h |  2 ++
 include/linux/mdev.h             | 23 ++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index 0212f0ee8aea..5119809225c5 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -390,6 +390,42 @@ int mdev_device_remove(struct device *dev, bool force_remove)
 	return 0;
 }
 
+int mdev_set_iommu_device(struct device *dev, struct device *iommu_device)
+{
+	struct mdev_device *mdev = to_mdev_device(dev);
+
+	mdev->iommu_device = iommu_device;
+
+	return 0;
+}
+EXPORT_SYMBOL(mdev_set_iommu_device);
+
+struct device *mdev_get_iommu_device(struct device *dev)
+{
+	struct mdev_device *mdev = to_mdev_device(dev);
+
+	return mdev->iommu_device;
+}
+EXPORT_SYMBOL(mdev_get_iommu_device);
+
+int mdev_set_iommu_domain(struct device *dev, void *domain)
+{
+	struct mdev_device *mdev = to_mdev_device(dev);
+
+	mdev->iommu_domain = domain;
+
+	return 0;
+}
+EXPORT_SYMBOL(mdev_set_iommu_domain);
+
+void *mdev_get_iommu_domain(struct device *dev)
+{
+	struct mdev_device *mdev = to_mdev_device(dev);
+
+	return mdev->iommu_domain;
+}
+EXPORT_SYMBOL(mdev_get_iommu_domain);
+
 static int __init mdev_init(void)
 {
 	return mdev_bus_register();
diff --git a/drivers/vfio/mdev/mdev_private.h b/drivers/vfio/mdev/mdev_private.h
index b5819b7d7ef7..c01518068e84 100644
--- a/drivers/vfio/mdev/mdev_private.h
+++ b/drivers/vfio/mdev/mdev_private.h
@@ -34,6 +34,8 @@ struct mdev_device {
 	struct list_head next;
 	struct kobject *type_kobj;
 	bool active;
+	struct device *iommu_device;
+	void *iommu_domain;
 };
 
 #define to_mdev_device(dev)	container_of(dev, struct mdev_device, dev)
diff --git a/include/linux/mdev.h b/include/linux/mdev.h
index b6e048e1045f..c46777d3e568 100644
--- a/include/linux/mdev.h
+++ b/include/linux/mdev.h
@@ -14,6 +14,29 @@
 #define MDEV_H
 
 struct mdev_device;
+struct iommu_domain;
+
+/*
+ * Called by the parent device driver to set the PCI device which represents
+ * this mdev in iommu protection scope. By default, the iommu device is NULL,
+ * that indicates using vendor defined isolation.
+ *
+ * @dev: the mediated device that iommu will isolate.
+ * @iommu_device: a pci device which represents the iommu for @dev.
+ *
+ * Return 0 for success, otherwise negative error value.
+ */
+int mdev_set_iommu_device(struct device *dev, struct device *iommu_device);
+
+struct device *mdev_get_iommu_device(struct device *dev);
+
+/*
+ * Called by vfio iommu modules to save the iommu domain after a domain being
+ * attached to the mediated device.
+ */
+int mdev_set_iommu_domain(struct device *dev, void *domain);
+
+void *mdev_get_iommu_domain(struct device *dev);
 
 /**
  * struct mdev_parent_ops - Structure to be registered for each parent device to
-- 
2.17.1
