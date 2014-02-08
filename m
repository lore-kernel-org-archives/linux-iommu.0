From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [RFC PATCH v4 08/10] VFIO_PLATFORM: Return IRQ info
Date: Sat,  8 Feb 2014 18:29:38 +0100
Message-ID: <1391880580-471-9-git-send-email-a.motakis@virtualopensystems.com>
References: <1391880580-471-1-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1391880580-471-1-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, R65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Return information for the interrupts exposed by the device.
This patch extends VFIO_DEVICE_GET_INFO with the number of IRQs
and enables VFIO_DEVICE_GET_IRQ_INFO

Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 drivers/vfio/platform/Makefile                |  2 +-
 drivers/vfio/platform/vfio_platform.c         | 35 +++++++++++++--
 drivers/vfio/platform/vfio_platform_irq.c     | 63 +++++++++++++++++++++++++++
 drivers/vfio/platform/vfio_platform_private.h | 11 +++++
 4 files changed, 106 insertions(+), 5 deletions(-)
 create mode 100644 drivers/vfio/platform/vfio_platform_irq.c

diff --git a/drivers/vfio/platform/Makefile b/drivers/vfio/platform/Makefile
index df3a014..2c53327 100644
--- a/drivers/vfio/platform/Makefile
+++ b/drivers/vfio/platform/Makefile
@@ -1,4 +1,4 @@
 
-vfio-platform-y := vfio_platform.o
+vfio-platform-y := vfio_platform.o vfio_platform_irq.o
 
 obj-$(CONFIG_VFIO_PLATFORM) += vfio-platform.o
diff --git a/drivers/vfio/platform/vfio_platform.c b/drivers/vfio/platform/vfio_platform.c
index 6b4b033..ef1ac17 100644
--- a/drivers/vfio/platform/vfio_platform.c
+++ b/drivers/vfio/platform/vfio_platform.c
@@ -79,6 +79,7 @@ static void vfio_platform_release(void *device_data)
 	struct vfio_platform_device *vdev = device_data;
 
 	vfio_platform_regions_cleanup(vdev);
+	vfio_platform_irq_cleanup(vdev);
 
 	module_put(THIS_MODULE);
 }
@@ -92,12 +93,22 @@ static int vfio_platform_open(void *device_data)
 	if (ret)
 		return ret;
 
+	ret = vfio_platform_irq_init(vdev);
+	if (ret)
+		goto err_irq;
+
 	if (!try_module_get(THIS_MODULE)) {
-		vfio_platform_regions_cleanup(vdev);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_mod;
 	}
 
 	return 0;
+
+err_mod:
+	vfio_platform_irq_cleanup(vdev);
+err_irq:
+	vfio_platform_regions_cleanup(vdev);
+	return ret;
 }
 
 static long vfio_platform_ioctl(void *device_data,
@@ -119,7 +130,7 @@ static long vfio_platform_ioctl(void *device_data,
 
 		info.flags = VFIO_DEVICE_FLAGS_PLATFORM;
 		info.num_regions = vdev->num_regions;
-		info.num_irqs = 0;
+		info.num_irqs = vdev->num_irqs;
 
 		return copy_to_user((void __user *)arg, &info, minsz);
 
@@ -142,7 +153,23 @@ static long vfio_platform_ioctl(void *device_data,
 		return copy_to_user((void __user *)arg, &info, minsz);
 
 	} else if (cmd == VFIO_DEVICE_GET_IRQ_INFO) {
-		return -EINVAL;
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
+		info.flags = vdev->irq[info.index].flags;
+		info.count = vdev->irq[info.index].count;
+
+		return copy_to_user((void __user *)arg, &info, minsz);
 
 	} else if (cmd == VFIO_DEVICE_SET_IRQS)
 		return -EINVAL;
diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
new file mode 100644
index 0000000..075c401
--- /dev/null
+++ b/drivers/vfio/platform/vfio_platform_irq.c
@@ -0,0 +1,63 @@
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
+#include <linux/device.h>
+#include <linux/eventfd.h>
+#include <linux/interrupt.h>
+#include <linux/iommu.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <linux/vfio.h>
+#include <linux/platform_device.h>
+#include <linux/irq.h>
+
+#include "vfio_platform_private.h"
+
+int vfio_platform_irq_init(struct vfio_platform_device *vdev)
+{
+	int cnt = 0, i;
+
+	while (platform_get_irq(vdev->pdev, cnt) > 0)
+		cnt++;
+
+	vdev->num_irqs = cnt;
+
+	vdev->irq = kzalloc(sizeof(struct vfio_platform_irq) * vdev->num_irqs,
+				GFP_KERNEL);
+	if (!vdev->irq)
+		return -ENOMEM;
+
+	for (i = 0; i < cnt; i++) {
+		struct vfio_platform_irq irq;
+
+		irq.flags = 0;
+		irq.count = 1;
+
+		vdev->irq[i] = irq;
+	}
+
+	return 0;
+}
+
+void vfio_platform_irq_cleanup(struct vfio_platform_device *vdev)
+{
+	kfree(vdev->irq);
+}
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index 4705aa5..726f5d1 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -15,6 +15,11 @@
 #ifndef VFIO_PLATFORM_PRIVATE_H
 #define VFIO_PLATFORM_PRIVATE_H
 
+struct vfio_platform_irq {
+	u32			flags;
+	u32			count;
+};
+
 struct vfio_platform_region {
 	u64			addr;
 	resource_size_t		size;
@@ -25,6 +30,12 @@ struct vfio_platform_device {
 	struct platform_device		*pdev;
 	struct vfio_platform_region	*region;
 	u32				num_regions;
+	struct vfio_platform_irq	*irq;
+	u32				num_irqs;
 };
 
+extern int vfio_platform_irq_init(struct vfio_platform_device *vdev);
+
+extern void vfio_platform_irq_cleanup(struct vfio_platform_device *vdev);
+
 #endif /* VFIO_PCI_PRIVATE_H */
-- 
1.8.3.2
