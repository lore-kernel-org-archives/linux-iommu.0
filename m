From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [RFC 3/5] vfio: platform: move code that can be shared with AMBA to a
	common file
Date: Fri, 22 Aug 2014 11:01:26 +0200
Message-ID: <1408698088-5349-4-git-send-email-a.motakis@virtualopensystems.com>
References: <1408698088-5349-1-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1408698088-5349-1-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Having decoupled a portion of the VFIO_PLATFORM code from platform bus
specific resource discovery code, we can now move that code separate file.
This will allow us to implement discovering AMBA devices and their resources,
but reuse the a large part of the VFIO_PLATFORM implementation.

Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 drivers/vfio/platform/Makefile                |   2 +-
 drivers/vfio/platform/vfio_platform.c         | 351 ------------------------
 drivers/vfio/platform/vfio_platform_common.c  | 380 ++++++++++++++++++++++++++
 drivers/vfio/platform/vfio_platform_private.h |   2 +
 4 files changed, 383 insertions(+), 352 deletions(-)
 create mode 100644 drivers/vfio/platform/vfio_platform_common.c

diff --git a/drivers/vfio/platform/Makefile b/drivers/vfio/platform/Makefile
index 2c53327..115d1b5 100644
--- a/drivers/vfio/platform/Makefile
+++ b/drivers/vfio/platform/Makefile
@@ -1,4 +1,4 @@
 
-vfio-platform-y := vfio_platform.o vfio_platform_irq.o
+vfio-platform-y := vfio_platform.o vfio_platform_irq.o vfio_platform_common.o
 
 obj-$(CONFIG_VFIO_PLATFORM) += vfio-platform.o
diff --git a/drivers/vfio/platform/vfio_platform.c b/drivers/vfio/platform/vfio_platform.c
index 99aa9af..6be305a 100644
--- a/drivers/vfio/platform/vfio_platform.c
+++ b/drivers/vfio/platform/vfio_platform.c
@@ -13,7 +13,6 @@
  */
 
 #include <linux/device.h>
-#include <linux/eventfd.h>
 #include <linux/interrupt.h>
 #include <linux/iommu.h>
 #include <linux/module.h>
@@ -34,356 +33,6 @@
 #define DRIVER_AUTHOR   "Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>"
 #define DRIVER_DESC     "VFIO for platform devices - User Level meta-driver"
 
-static int vfio_platform_regions_init(struct vfio_platform_device *vdev)
-{
-	int cnt = 0, i;
-
-	while (vdev->get_resource(vdev, cnt))
-		cnt++;
-
-	vdev->region = kzalloc(sizeof(struct vfio_platform_region) * cnt,
-				GFP_KERNEL);
-	if (!vdev->region)
-		return -ENOMEM;
-
-	for (i = 0; i < cnt;  i++) {
-		struct resource *res = vdev->get_resource(vdev, i);
-
-		if (!res)
-			goto err;
-
-		vdev->region[i].addr = res->start;
-		vdev->region[i].size = resource_size(res);
-		vdev->region[i].flags = VFIO_REGION_INFO_FLAG_READ
-					| VFIO_REGION_INFO_FLAG_WRITE;
-		/* Only regions addressed with PAGE granularity may be MMAPed
-		 * securely. */
-		if (!(vdev->region[i].addr & ~PAGE_MASK)
-				&& !(vdev->region[i].size & ~PAGE_MASK))
-			vdev->region[i].flags |= VFIO_REGION_INFO_FLAG_MMAP;
-	}
-
-	vdev->num_regions = cnt;
-
-	return 0;
-err:
-	kfree(vdev->region);
-	return -EINVAL;
-}
-
-static void vfio_platform_regions_cleanup(struct vfio_platform_device *vdev)
-{
-	vdev->num_regions = 0;
-	kfree(vdev->region);
-}
-
-static void vfio_platform_release(void *device_data)
-{
-	struct vfio_platform_device *vdev = device_data;
-
-	vfio_platform_regions_cleanup(vdev);
-	vfio_platform_irq_cleanup(vdev);
-
-	module_put(THIS_MODULE);
-}
-
-static int vfio_platform_open(void *device_data)
-{
-	struct vfio_platform_device *vdev = device_data;
-	int ret;
-
-	if (!try_module_get(THIS_MODULE))
-		return -ENODEV;
-
-	ret = vfio_platform_regions_init(vdev);
-	if (ret)
-		goto err_reg;
-
-	ret = vfio_platform_irq_init(vdev);
-	if (ret)
-		goto err_irq;
-
-	return 0;
-
-err_irq:
-	vfio_platform_regions_cleanup(vdev);
-err_reg:
-	module_put(THIS_MODULE);
-
-	return ret;
-}
-
-static long vfio_platform_ioctl(void *device_data,
-			   unsigned int cmd, unsigned long arg)
-{
-	struct vfio_platform_device *vdev = device_data;
-	unsigned long minsz;
-
-	if (cmd == VFIO_DEVICE_GET_INFO) {
-		struct vfio_device_info info;
-
-		minsz = offsetofend(struct vfio_device_info, num_irqs);
-
-		if (copy_from_user(&info, (void __user *)arg, minsz))
-			return -EFAULT;
-
-		if (info.argsz < minsz)
-			return -EINVAL;
-
-		info.flags = VFIO_DEVICE_FLAGS_PLATFORM;
-		info.num_regions = vdev->num_regions;
-		info.num_irqs = vdev->num_irqs;
-
-		return copy_to_user((void __user *)arg, &info, minsz);
-
-	} else if (cmd == VFIO_DEVICE_GET_REGION_INFO) {
-		struct vfio_region_info info;
-
-		minsz = offsetofend(struct vfio_region_info, offset);
-
-		if (copy_from_user(&info, (void __user *)arg, minsz))
-			return -EFAULT;
-
-		if (info.argsz < minsz)
-			return -EINVAL;
-
-		if (info.index >= vdev->num_regions)
-			return -EINVAL;
-
-		/* map offset to the physical address  */
-		info.offset = VFIO_PLATFORM_INDEX_TO_OFFSET(info.index);
-		info.size = vdev->region[info.index].size;
-		info.flags = vdev->region[info.index].flags;
-
-		return copy_to_user((void __user *)arg, &info, minsz);
-
-	} else if (cmd == VFIO_DEVICE_GET_IRQ_INFO) {
-		struct vfio_irq_info info;
-
-		minsz = offsetofend(struct vfio_irq_info, count);
-
-		if (copy_from_user(&info, (void __user *)arg, minsz))
-			return -EFAULT;
-
-		if (info.argsz < minsz)
-			return -EINVAL;
-
-		if (info.index >= vdev->num_irqs)
-			return -EINVAL;
-
-		info.flags = vdev->irq[info.index].flags;
-		info.count = vdev->irq[info.index].count;
-
-		return copy_to_user((void __user *)arg, &info, minsz);
-
-	} else if (cmd == VFIO_DEVICE_SET_IRQS) {
-		struct vfio_irq_set hdr;
-		int ret = 0;
-
-		minsz = offsetofend(struct vfio_irq_set, count);
-
-		if (copy_from_user(&hdr, (void __user *)arg, minsz))
-			return -EFAULT;
-
-		if (hdr.argsz < minsz)
-			return -EINVAL;
-
-		if (hdr.index >= vdev->num_irqs)
-			return -EINVAL;
-
-		if (hdr.start != 0 || hdr.count > 1)
-			return -EINVAL;
-
-		if (hdr.count == 0 &&
-			(!(hdr.flags & VFIO_IRQ_SET_DATA_NONE) ||
-			 !(hdr.flags & VFIO_IRQ_SET_ACTION_TRIGGER)))
-			return -EINVAL;
-
-		if (hdr.flags & ~(VFIO_IRQ_SET_DATA_TYPE_MASK |
-				  VFIO_IRQ_SET_ACTION_TYPE_MASK))
-			return -EINVAL;
-
-		ret = vfio_platform_set_irqs_ioctl(vdev, hdr.flags, hdr.index,
-						   hdr.start, hdr.count,
-						   (void *)arg+minsz);
-
-		return ret;
-
-	} else if (cmd == VFIO_DEVICE_RESET)
-		return -EINVAL;
-
-	return -ENOTTY;
-}
-
-static ssize_t vfio_platform_read(void *device_data, char __user *buf,
-			     size_t count, loff_t *ppos)
-{
-	struct vfio_platform_device *vdev = device_data;
-	unsigned int index = VFIO_PLATFORM_OFFSET_TO_INDEX(*ppos);
-	loff_t off = *ppos & VFIO_PLATFORM_OFFSET_MASK;
-	unsigned int done = 0;
-
-	if (index >= vdev->num_regions)
-		return -EINVAL;
-
-	if (!vdev->region[index].ioaddr) {
-		vdev->region[index].ioaddr =
-			ioremap_nocache(vdev->region[index].addr,
-					vdev->region[index].size);
-
-		if (!vdev->region[index].ioaddr)
-			return -ENOMEM;
-	}
-
-	while (count) {
-		size_t filled;
-
-		if (count >= 4 && !(off % 4)) {
-			u32 val;
-
-			val = ioread32(vdev->region[index].ioaddr + off);
-			if (copy_to_user(buf, &val, 4))
-				goto err;
-
-			filled = 4;
-		} else if (count >= 2 && !(off % 2)) {
-			u16 val;
-
-			val = ioread16(vdev->region[index].ioaddr + off);
-			if (copy_to_user(buf, &val, 2))
-				goto err;
-
-			filled = 2;
-		} else {
-			u8 val;
-
-			val = ioread8(vdev->region[index].ioaddr + off);
-			if (copy_to_user(buf, &val, 1))
-				goto err;
-
-			filled = 1;
-		}
-
-
-		count -= filled;
-		done += filled;
-		off += filled;
-		buf += filled;
-	}
-
-	return done;
-err:
-	return -EFAULT;
-}
-
-static ssize_t vfio_platform_write(void *device_data, const char __user *buf,
-			      size_t count, loff_t *ppos)
-{
-	struct vfio_platform_device *vdev = device_data;
-	unsigned int index = VFIO_PLATFORM_OFFSET_TO_INDEX(*ppos);
-	loff_t off = *ppos & VFIO_PLATFORM_OFFSET_MASK;
-	unsigned int done = 0;
-
-	if (index >= vdev->num_regions)
-		return -EINVAL;
-
-	if (!vdev->region[index].ioaddr) {
-		vdev->region[index].ioaddr =
-			ioremap_nocache(vdev->region[index].addr,
-					vdev->region[index].size);
-
-		if (!vdev->region[index].ioaddr)
-			return -ENOMEM;
-	}
-
-	while (count) {
-		size_t filled;
-
-		if (count >= 4 && !(off % 4)) {
-			u32 val;
-
-			if (copy_from_user(&val, buf, 4))
-				goto err;
-			iowrite32(val, vdev->region[index].ioaddr + off);
-
-			filled = 4;
-		} else if (count >= 2 && !(off % 2)) {
-			u16 val;
-
-			if (copy_from_user(&val, buf, 2))
-				goto err;
-			iowrite16(val, vdev->region[index].ioaddr + off);
-
-			filled = 2;
-		} else {
-			u8 val;
-
-			if (copy_from_user(&val, buf, 1))
-				goto err;
-			iowrite8(val, vdev->region[index].ioaddr + off);
-
-			filled = 1;
-		}
-
-		count -= filled;
-		done += filled;
-		off += filled;
-		buf += filled;
-	}
-
-	return done;
-err:
-	return -EFAULT;
-}
-
-static int vfio_platform_mmap(void *device_data, struct vm_area_struct *vma)
-{
-	struct vfio_platform_device *vdev = device_data;
-	unsigned int index;
-	u64 req_len, pgoff, req_start;
-	struct vfio_platform_region region;
-
-	index = vma->vm_pgoff >> (VFIO_PLATFORM_OFFSET_SHIFT - PAGE_SHIFT);
-
-	if (vma->vm_end < vma->vm_start)
-		return -EINVAL;
-	if ((vma->vm_flags & VM_SHARED) == 0)
-		return -EINVAL;
-	if (index >= vdev->num_regions)
-		return -EINVAL;
-	if (vma->vm_start & ~PAGE_MASK)
-		return -EINVAL;
-	if (vma->vm_end & ~PAGE_MASK)
-		return -EINVAL;
-
-	region = vdev->region[index];
-
-	req_len = vma->vm_end - vma->vm_start;
-	pgoff = vma->vm_pgoff &
-		((1U << (VFIO_PLATFORM_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
-	req_start = pgoff << PAGE_SHIFT;
-
-	if (region.size < PAGE_SIZE || req_start + req_len > region.size)
-		return -EINVAL;
-
-	vma->vm_private_data = vdev;
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	vma->vm_pgoff = (region.addr >> PAGE_SHIFT) + pgoff;
-
-	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
-			       req_len, vma->vm_page_prot);
-}
-
-static const struct vfio_device_ops vfio_platform_ops = {
-	.name		= "vfio-platform",
-	.open		= vfio_platform_open,
-	.release	= vfio_platform_release,
-	.ioctl		= vfio_platform_ioctl,
-	.read		= vfio_platform_read,
-	.write		= vfio_platform_write,
-	.mmap		= vfio_platform_mmap,
-};
-
 /* probing devices from the linux platform bus */
 
 static struct resource* get_platform_resource(struct vfio_platform_device *vdev,
diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
new file mode 100644
index 0000000..6e69703
--- /dev/null
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -0,0 +1,380 @@
+/*
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
+#include <linux/io.h>
+#include <linux/irq.h>
+
+#include "vfio_platform_private.h"
+
+static int vfio_platform_regions_init(struct vfio_platform_device *vdev)
+{
+	int cnt = 0, i;
+
+	while (vdev->get_resource(vdev, cnt))
+		cnt++;
+
+	vdev->region = kzalloc(sizeof(struct vfio_platform_region) * cnt,
+				GFP_KERNEL);
+	if (!vdev->region)
+		return -ENOMEM;
+
+	for (i = 0; i < cnt;  i++) {
+		struct resource *res = vdev->get_resource(vdev, i);
+
+		if (!res)
+			goto err;
+
+		vdev->region[i].addr = res->start;
+		vdev->region[i].size = resource_size(res);
+		vdev->region[i].flags = VFIO_REGION_INFO_FLAG_READ
+					| VFIO_REGION_INFO_FLAG_WRITE;
+		/* Only regions addressed with PAGE granularity may be MMAPed
+		 * securely. */
+		if (!(vdev->region[i].addr & ~PAGE_MASK)
+				&& !(vdev->region[i].size & ~PAGE_MASK))
+			vdev->region[i].flags |= VFIO_REGION_INFO_FLAG_MMAP;
+	}
+
+	vdev->num_regions = cnt;
+
+	return 0;
+err:
+	kfree(vdev->region);
+	return -EINVAL;
+}
+
+static void vfio_platform_regions_cleanup(struct vfio_platform_device *vdev)
+{
+	vdev->num_regions = 0;
+	kfree(vdev->region);
+}
+
+static void vfio_platform_release(void *device_data)
+{
+	struct vfio_platform_device *vdev = device_data;
+
+	vfio_platform_regions_cleanup(vdev);
+	vfio_platform_irq_cleanup(vdev);
+
+	module_put(THIS_MODULE);
+}
+
+static int vfio_platform_open(void *device_data)
+{
+	struct vfio_platform_device *vdev = device_data;
+	int ret;
+
+	if (!try_module_get(THIS_MODULE))
+		return -ENODEV;
+
+	ret = vfio_platform_regions_init(vdev);
+	if (ret)
+		goto err_reg;
+
+	ret = vfio_platform_irq_init(vdev);
+	if (ret)
+		goto err_irq;
+
+	return 0;
+
+err_irq:
+	vfio_platform_regions_cleanup(vdev);
+err_reg:
+	module_put(THIS_MODULE);
+
+	return ret;
+}
+
+static long vfio_platform_ioctl(void *device_data,
+			   unsigned int cmd, unsigned long arg)
+{
+	struct vfio_platform_device *vdev = device_data;
+	unsigned long minsz;
+
+	if (cmd == VFIO_DEVICE_GET_INFO) {
+		struct vfio_device_info info;
+
+		minsz = offsetofend(struct vfio_device_info, num_irqs);
+
+		if (copy_from_user(&info, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (info.argsz < minsz)
+			return -EINVAL;
+
+		info.flags = VFIO_DEVICE_FLAGS_PLATFORM;
+		info.num_regions = vdev->num_regions;
+		info.num_irqs = vdev->num_irqs;
+
+		return copy_to_user((void __user *)arg, &info, minsz);
+
+	} else if (cmd == VFIO_DEVICE_GET_REGION_INFO) {
+		struct vfio_region_info info;
+
+		minsz = offsetofend(struct vfio_region_info, offset);
+
+		if (copy_from_user(&info, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (info.argsz < minsz)
+			return -EINVAL;
+
+		if (info.index >= vdev->num_regions)
+			return -EINVAL;
+
+		/* map offset to the physical address  */
+		info.offset = VFIO_PLATFORM_INDEX_TO_OFFSET(info.index);
+		info.size = vdev->region[info.index].size;
+		info.flags = vdev->region[info.index].flags;
+
+		return copy_to_user((void __user *)arg, &info, minsz);
+
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
+		info.flags = vdev->irq[info.index].flags;
+		info.count = vdev->irq[info.index].count;
+
+		return copy_to_user((void __user *)arg, &info, minsz);
+
+	} else if (cmd == VFIO_DEVICE_SET_IRQS) {
+		struct vfio_irq_set hdr;
+		int ret = 0;
+
+		minsz = offsetofend(struct vfio_irq_set, count);
+
+		if (copy_from_user(&hdr, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (hdr.argsz < minsz)
+			return -EINVAL;
+
+		if (hdr.index >= vdev->num_irqs)
+			return -EINVAL;
+
+		if (hdr.start != 0 || hdr.count > 1)
+			return -EINVAL;
+
+		if (hdr.count == 0 &&
+			(!(hdr.flags & VFIO_IRQ_SET_DATA_NONE) ||
+			 !(hdr.flags & VFIO_IRQ_SET_ACTION_TRIGGER)))
+			return -EINVAL;
+
+		if (hdr.flags & ~(VFIO_IRQ_SET_DATA_TYPE_MASK |
+				  VFIO_IRQ_SET_ACTION_TYPE_MASK))
+			return -EINVAL;
+
+		ret = vfio_platform_set_irqs_ioctl(vdev, hdr.flags, hdr.index,
+						   hdr.start, hdr.count,
+						   (void *)arg+minsz);
+
+		return ret;
+
+	} else if (cmd == VFIO_DEVICE_RESET)
+		return -EINVAL;
+
+	return -ENOTTY;
+}
+
+static ssize_t vfio_platform_read(void *device_data, char __user *buf,
+			     size_t count, loff_t *ppos)
+{
+	struct vfio_platform_device *vdev = device_data;
+	unsigned int index = VFIO_PLATFORM_OFFSET_TO_INDEX(*ppos);
+	loff_t off = *ppos & VFIO_PLATFORM_OFFSET_MASK;
+	unsigned int done = 0;
+
+	if (index >= vdev->num_regions)
+		return -EINVAL;
+
+	if (!vdev->region[index].ioaddr) {
+		vdev->region[index].ioaddr =
+			ioremap_nocache(vdev->region[index].addr,
+					vdev->region[index].size);
+
+		if (!vdev->region[index].ioaddr)
+			return -ENOMEM;
+	}
+
+	while (count) {
+		size_t filled;
+
+		if (count >= 4 && !(off % 4)) {
+			u32 val;
+
+			val = ioread32(vdev->region[index].ioaddr + off);
+			if (copy_to_user(buf, &val, 4))
+				goto err;
+
+			filled = 4;
+		} else if (count >= 2 && !(off % 2)) {
+			u16 val;
+
+			val = ioread16(vdev->region[index].ioaddr + off);
+			if (copy_to_user(buf, &val, 2))
+				goto err;
+
+			filled = 2;
+		} else {
+			u8 val;
+
+			val = ioread8(vdev->region[index].ioaddr + off);
+			if (copy_to_user(buf, &val, 1))
+				goto err;
+
+			filled = 1;
+		}
+
+
+		count -= filled;
+		done += filled;
+		off += filled;
+		buf += filled;
+	}
+
+	return done;
+err:
+	return -EFAULT;
+}
+
+static ssize_t vfio_platform_write(void *device_data, const char __user *buf,
+			      size_t count, loff_t *ppos)
+{
+	struct vfio_platform_device *vdev = device_data;
+	unsigned int index = VFIO_PLATFORM_OFFSET_TO_INDEX(*ppos);
+	loff_t off = *ppos & VFIO_PLATFORM_OFFSET_MASK;
+	unsigned int done = 0;
+
+	if (index >= vdev->num_regions)
+		return -EINVAL;
+
+	if (!vdev->region[index].ioaddr) {
+		vdev->region[index].ioaddr =
+			ioremap_nocache(vdev->region[index].addr,
+					vdev->region[index].size);
+
+		if (!vdev->region[index].ioaddr)
+			return -ENOMEM;
+	}
+
+	while (count) {
+		size_t filled;
+
+		if (count >= 4 && !(off % 4)) {
+			u32 val;
+
+			if (copy_from_user(&val, buf, 4))
+				goto err;
+			iowrite32(val, vdev->region[index].ioaddr + off);
+
+			filled = 4;
+		} else if (count >= 2 && !(off % 2)) {
+			u16 val;
+
+			if (copy_from_user(&val, buf, 2))
+				goto err;
+			iowrite16(val, vdev->region[index].ioaddr + off);
+
+			filled = 2;
+		} else {
+			u8 val;
+
+			if (copy_from_user(&val, buf, 1))
+				goto err;
+			iowrite8(val, vdev->region[index].ioaddr + off);
+
+			filled = 1;
+		}
+
+		count -= filled;
+		done += filled;
+		off += filled;
+		buf += filled;
+	}
+
+	return done;
+err:
+	return -EFAULT;
+}
+
+static int vfio_platform_mmap(void *device_data, struct vm_area_struct *vma)
+{
+	struct vfio_platform_device *vdev = device_data;
+	unsigned int index;
+	u64 req_len, pgoff, req_start;
+	struct vfio_platform_region region;
+
+	index = vma->vm_pgoff >> (VFIO_PLATFORM_OFFSET_SHIFT - PAGE_SHIFT);
+
+	if (vma->vm_end < vma->vm_start)
+		return -EINVAL;
+	if ((vma->vm_flags & VM_SHARED) == 0)
+		return -EINVAL;
+	if (index >= vdev->num_regions)
+		return -EINVAL;
+	if (vma->vm_start & ~PAGE_MASK)
+		return -EINVAL;
+	if (vma->vm_end & ~PAGE_MASK)
+		return -EINVAL;
+
+	region = vdev->region[index];
+
+	req_len = vma->vm_end - vma->vm_start;
+	pgoff = vma->vm_pgoff &
+		((1U << (VFIO_PLATFORM_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
+	req_start = pgoff << PAGE_SHIFT;
+
+	if (region.size < PAGE_SIZE || req_start + req_len > region.size)
+		return -EINVAL;
+
+	vma->vm_private_data = vdev;
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	vma->vm_pgoff = (region.addr >> PAGE_SHIFT) + pgoff;
+
+	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+			       req_len, vma->vm_page_prot);
+}
+
+const struct vfio_device_ops vfio_platform_ops = {
+	.name		= "vfio-platform",
+	.open		= vfio_platform_open,
+	.release	= vfio_platform_release,
+	.ioctl		= vfio_platform_ioctl,
+	.read		= vfio_platform_read,
+	.write		= vfio_platform_write,
+	.mmap		= vfio_platform_mmap,
+};
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index b79f485..45d0bab 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -56,6 +56,8 @@ struct vfio_platform_device {
 	int	(*get_irq)(struct vfio_platform_device *vdev, int i);
 };
 
+extern const struct vfio_device_ops vfio_platform_ops;
+
 extern int vfio_platform_irq_init(struct vfio_platform_device *vdev);
 
 extern void vfio_platform_irq_cleanup(struct vfio_platform_device *vdev);
-- 
1.8.3.2
