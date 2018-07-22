From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [RFC PATCH 08/10] vfio/mdev: Set iommu ops for mdev bus
Date: Sun, 22 Jul 2018 14:09:31 +0800
Message-ID: <1532239773-15325-9-git-send-email-baolu.lu@linux.intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This sets the iommu ops for the mdev bus with iommu_set_bus().
With the iommu ops setting, a mediated device might be isolated
and protected by an IOMMU unit.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/vfio/mdev/mdev_core.c   |  9 ++++++++-
 drivers/vfio/mdev/mdev_driver.c | 10 ++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index 0212f0e..d8f19ba 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -16,6 +16,7 @@
 #include <linux/uuid.h>
 #include <linux/sysfs.h>
 #include <linux/mdev.h>
+#include <linux/iommu.h>
 
 #include "mdev_private.h"
 
@@ -392,7 +393,13 @@ int mdev_device_remove(struct device *dev, bool force_remove)
 
 static int __init mdev_init(void)
 {
-	return mdev_bus_register();
+	int ret;
+
+	ret = mdev_bus_register();
+	if (!ret)
+		iommu_set_bus(&mdev_bus_type);
+
+	return ret;
 }
 
 static void __exit mdev_exit(void)
diff --git a/drivers/vfio/mdev/mdev_driver.c b/drivers/vfio/mdev/mdev_driver.c
index 6f0391f..76ac9e6 100644
--- a/drivers/vfio/mdev/mdev_driver.c
+++ b/drivers/vfio/mdev/mdev_driver.c
@@ -21,6 +21,13 @@ static int mdev_attach_iommu(struct mdev_device *mdev)
 	int ret;
 	struct iommu_group *group;
 
+	/*
+	 * If iommu_ops is set for bus, add_device() will allocate
+	 * a group and add the device in the group.
+	 */
+	if (iommu_present(mdev->dev.bus))
+		return 0;
+
 	group = iommu_group_alloc();
 	if (IS_ERR(group))
 		return PTR_ERR(group);
@@ -36,6 +43,9 @@ static int mdev_attach_iommu(struct mdev_device *mdev)
 
 static void mdev_detach_iommu(struct mdev_device *mdev)
 {
+	if (iommu_present(mdev->dev.bus))
+		return;
+
 	iommu_group_remove_device(&mdev->dev);
 	dev_info(&mdev->dev, "MDEV: detaching iommu\n");
 }
-- 
2.7.4
