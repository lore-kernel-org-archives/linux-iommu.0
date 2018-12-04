From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/5] driver core: Introduce device_iommu_mapped() function
Date: Tue,  4 Dec 2018 18:25:00 +0100
Message-ID: <20181204172504.19708-2-joro@8bytes.org>
References: <20181204172504.19708-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204172504.19708-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

Some places in the kernel check the iommu_group pointer in
'struct device' in order to find ot whether a device is
mapped by an IOMMU.

This is not good way to make this check, as the pointer will
be moved to 'struct dev_iommu_data'. This way to make the
check is also not very readable.

Introduce an explicit function to perform this check.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 include/linux/device.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 1b25c7a43f4c..6cb4640b6160 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1058,6 +1058,16 @@ static inline struct device *kobj_to_dev(struct kobject *kobj)
 	return container_of(kobj, struct device, kobj);
 }
 
+/**
+ * device_iommu_mapped - Returns true when the device DMA is translated
+ *			 by an IOMMU
+ * @dev: Device to perform the check on
+ */
+static inline bool device_iommu_mapped(struct device *dev)
+{
+	return (dev->iommu_group != NULL);
+}
+
 /* Get the wakeup routines, which depend on struct device */
 #include <linux/pm_wakeup.h>
 
-- 
2.17.1
