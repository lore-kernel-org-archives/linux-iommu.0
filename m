From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [PATCH v10 10/20] vfio/platform: return IRQ info
Date: Thu, 27 Nov 2014 18:32:50 +0100
Message-ID: <1417109580-10505-11-git-send-email-a.motakis@virtualopensystems.com>
References: <1417109580-10505-1-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1417109580-10505-1-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: "open list:VFIO DRIVER" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Return information for the interrupts exposed by the device.
This patch extends VFIO_DEVICE_GET_INFO with the number of IRQs
and enables VFIO_DEVICE_GET_IRQ_INFO.

Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 drivers/vfio/platform/Makefile                |  2 +-
 drivers/vfio/platform/vfio_platform_common.c  | 31 +++++++++++++---
 drivers/vfio/platform/vfio_platform_irq.c     | 51 +++++++++++++++++++++++++++
 drivers/vfio/platform/vfio_platform_private.h | 10 ++++++
 4 files changed, 89 insertions(+), 5 deletions(-)
 create mode 100644 drivers/vfio/platform/vfio_platform_irq.c

diff --git a/drivers/vfio/platform/Makefile b/drivers/vfio/platform/Makefile
index 1957170..81de144 100644
--- a/drivers/vfio/platform/Makefile
+++ b/drivers/vfio/platform/Makefile
@@ -1,5 +1,5 @@
 
-vfio-platform-y := vfio_platform.o vfio_platform_common.o
+vfio-platform-y := vfio_platform.o vfio_platform_common.o vfio_platform_irq.o
 
 obj-$(CONFIG_VFIO_PLATFORM) += vfio-platform.o
 
diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index 6bf78ee..cf7bb08 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -100,6 +100,7 @@ static void vfio_platform_release(void *device_data)
 
 	if (!(--vdev->refcnt)) {
 		vfio_platform_regions_cleanup(vdev);
+		vfio_platform_irq_cleanup(vdev);
 	}
 
 	mutex_unlock(&driver_lock);
@@ -121,6 +122,10 @@ static int vfio_platform_open(void *device_data)
 		ret = vfio_platform_regions_init(vdev);
 		if (ret)
 			goto err_reg;
+
+		ret = vfio_platform_irq_init(vdev);
+		if (ret)
+			goto err_irq;
 	}
 
 	vdev->refcnt++;
@@ -128,6 +133,8 @@ static int vfio_platform_open(void *device_data)
 	mutex_unlock(&driver_lock);
 	return 0;
 
+err_irq:
+	vfio_platform_regions_cleanup(vdev);
 err_reg:
 	mutex_unlock(&driver_lock);
 	module_put(THIS_MODULE);
@@ -153,7 +160,7 @@ static long vfio_platform_ioctl(void *device_data,
 
 		info.flags = vdev->flags;
 		info.num_regions = vdev->num_regions;
-		info.num_irqs = 0;
+		info.num_irqs = vdev->num_irqs;
 
 		return copy_to_user((void __user *)arg, &info, minsz);
 
@@ -178,10 +185,26 @@ static long vfio_platform_ioctl(void *device_data,
 
 		return copy_to_user((void __user *)arg, &info, minsz);
 
-	} else if (cmd == VFIO_DEVICE_GET_IRQ_INFO)
-		return -EINVAL;
+	} else if (cmd == VFIO_DEVICE_GET_IRQ_INFO) {
+		struct vfio_irq_info info;
+
+		minsz = offsetofend(struct vfio_irq_info, count);
+
+		if (copy_from_user(&info, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (info.argsz < minsz)
+			return -EINVAL;
+
+		if (info.index >= vdev->num_irqs)
+			return -EINVAL;
+
+		info.flags = vdev->irqs[info.index].flags;
+		info.count = vdev->irqs[info.index].count;
+
+		return copy_to_user((void __user *)arg, &info, minsz);
 
-	else if (cmd == VFIO_DEVICE_SET_IRQS)
+	} else if (cmd == VFIO_DEVICE_SET_IRQS)
 		return -EINVAL;
 
 	else if (cmd == VFIO_DEVICE_RESET)
diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
new file mode 100644
index 0000000..c6c3ec1
--- /dev/null
+++ b/drivers/vfio/platform/vfio_platform_irq.c
@@ -0,0 +1,51 @@
+/*
+ * VFIO platform devices interrupt handling
+ *
+ * Copyright (C) 2013 - Virtual Open Systems
+ * Author: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/eventfd.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/vfio.h>
+#include <linux/irq.h>
+
+#include "vfio_platform_private.h"
+
+int vfio_platform_irq_init(struct vfio_platform_device *vdev)
+{
+	int cnt = 0, i;
+
+	while (vdev->get_irq(vdev, cnt) >= 0)
+		cnt++;
+
+	vdev->irqs = kcalloc(cnt, sizeof(struct vfio_platform_irq), GFP_KERNEL);
+	if (!vdev->irqs)
+		return -ENOMEM;
+
+	for (i = 0; i < cnt; i++) {
+		vdev->irqs[i].flags = 0;
+		vdev->irqs[i].count = 1;
+	}
+
+	vdev->num_irqs = cnt;
+
+	return 0;
+}
+
+void vfio_platform_irq_cleanup(struct vfio_platform_device *vdev)
+{
+	vdev->num_irqs = 0;
+	kfree(vdev->irqs);
+}
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index 1f251b2..3a29a72 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -24,6 +24,11 @@
 #define VFIO_PLATFORM_INDEX_TO_OFFSET(index)	\
 	((u64)(index) << VFIO_PLATFORM_OFFSET_SHIFT)
 
+struct vfio_platform_irq {
+	u32			flags;
+	u32			count;
+};
+
 struct vfio_platform_region {
 	u64			addr;
 	resource_size_t		size;
@@ -37,6 +42,8 @@ struct vfio_platform_region {
 struct vfio_platform_device {
 	struct vfio_platform_region	*regions;
 	u32				num_regions;
+	struct vfio_platform_irq	*irqs;
+	u32				num_irqs;
 	int				refcnt;
 
 	/*
@@ -56,4 +63,7 @@ extern int vfio_platform_probe_common(struct vfio_platform_device *vdev,
 extern struct vfio_platform_device *vfio_platform_remove_common
 				     (struct device *dev);
 
+extern int vfio_platform_irq_init(struct vfio_platform_device *vdev);
+extern void vfio_platform_irq_cleanup(struct vfio_platform_device *vdev);
+
 #endif /* VFIO_PLATFORM_PRIVATE_H */
-- 
2.1.3
