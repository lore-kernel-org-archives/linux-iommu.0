From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [PATCH v9 11/19] vfio/platform: initial interrupts support code
Date: Mon, 27 Oct 2014 19:07:56 +0100
Message-ID: <1414433284-31719-12-git-send-email-a.motakis@virtualopensystems.com>
References: <1414433284-31719-1-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1414433284-31719-1-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
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

This patch is a skeleton for the VFIO_DEVICE_SET_IRQS IOCTL, around which
most IRQ functionality is implemented in VFIO.

Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 drivers/vfio/platform/vfio_platform_common.c  | 52 +++++++++++++++++++++++--
 drivers/vfio/platform/vfio_platform_irq.c     | 56 +++++++++++++++++++++++++++
 drivers/vfio/platform/vfio_platform_private.h |  6 +++
 3 files changed, 111 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index 5f2c205..782b4d3 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -209,10 +209,54 @@ static long vfio_platform_ioctl(void *device_data,
 
 		return copy_to_user((void __user *)arg, &info, minsz);
 
-	} else if (cmd == VFIO_DEVICE_SET_IRQS)
-		return -EINVAL;
+	} else if (cmd == VFIO_DEVICE_SET_IRQS) {
+		struct vfio_irq_set hdr;
+		u8 *data = NULL;
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
+		if (hdr.flags & ~(VFIO_IRQ_SET_DATA_TYPE_MASK |
+				  VFIO_IRQ_SET_ACTION_TYPE_MASK))
+			return -EINVAL;
 
-	else if (cmd == VFIO_DEVICE_RESET)
+		if (!(hdr.flags & VFIO_IRQ_SET_DATA_NONE)) {
+			size_t size;
+
+			if (hdr.flags & VFIO_IRQ_SET_DATA_BOOL)
+				size = sizeof(uint8_t);
+			else if (hdr.flags & VFIO_IRQ_SET_DATA_EVENTFD)
+				size = sizeof(int32_t);
+			else
+				return -EINVAL;
+
+			if (hdr.argsz - minsz < size)
+				return -EINVAL;
+
+			data = memdup_user((void __user *)(arg + minsz), size);
+			if (IS_ERR(data))
+				return PTR_ERR(data);
+		}
+
+		mutex_lock(&vdev->igate);
+
+		ret = vfio_platform_set_irqs_ioctl(vdev, hdr.flags, hdr.index,
+						   hdr.start, hdr.count, data);
+		mutex_unlock(&vdev->igate);
+		kfree(data);
+
+		return ret;
+
+	} else if (cmd == VFIO_DEVICE_RESET)
 		return -EINVAL;
 
 	return -ENOTTY;
@@ -462,6 +506,8 @@ int vfio_platform_probe_common(struct vfio_platform_device *vdev,
 		return ret;
 	}
 
+	mutex_init(&vdev->igate);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vfio_platform_probe_common);
diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
index d99c71c..007b386 100644
--- a/drivers/vfio/platform/vfio_platform_irq.c
+++ b/drivers/vfio/platform/vfio_platform_irq.c
@@ -31,6 +31,53 @@
 
 #include "vfio_platform_private.h"
 
+static int vfio_platform_set_irq_mask(struct vfio_platform_device *vdev,
+				    unsigned index, unsigned start,
+				    unsigned count, uint32_t flags, void *data)
+{
+	return -EINVAL;
+}
+
+static int vfio_platform_set_irq_unmask(struct vfio_platform_device *vdev,
+				    unsigned index, unsigned start,
+				    unsigned count, uint32_t flags, void *data)
+{
+	return -EINVAL;
+}
+
+static int vfio_platform_set_irq_trigger(struct vfio_platform_device *vdev,
+				     unsigned index, unsigned start,
+				     unsigned count, uint32_t flags, void *data)
+{
+	return -EINVAL;
+}
+
+int vfio_platform_set_irqs_ioctl(struct vfio_platform_device *vdev,
+				 uint32_t flags, unsigned index, unsigned start,
+				 unsigned count, void *data)
+{
+	int (*func)(struct vfio_platform_device *vdev, unsigned index,
+		    unsigned start, unsigned count, uint32_t flags,
+		    void *data) = NULL;
+
+	switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
+	case VFIO_IRQ_SET_ACTION_MASK:
+		func = vfio_platform_set_irq_mask;
+		break;
+	case VFIO_IRQ_SET_ACTION_UNMASK:
+		func = vfio_platform_set_irq_unmask;
+		break;
+	case VFIO_IRQ_SET_ACTION_TRIGGER:
+		func = vfio_platform_set_irq_trigger;
+		break;
+	}
+
+	if (!func)
+		return -ENOTTY;
+
+	return func(vdev, index, start, count, flags, data);
+}
+
 int vfio_platform_irq_init(struct vfio_platform_device *vdev)
 {
 	int cnt = 0, i;
@@ -43,13 +90,22 @@ int vfio_platform_irq_init(struct vfio_platform_device *vdev)
 		return -ENOMEM;
 
 	for (i = 0; i < cnt; i++) {
+		int hwirq = vdev->get_irq(vdev, i);
+
+		if (hwirq < 0)
+			goto err;
+
 		vdev->irqs[i].flags = 0;
 		vdev->irqs[i].count = 1;
+		vdev->irqs[i].hwirq = hwirq;
 	}
 
 	vdev->num_irqs = cnt;
 
 	return 0;
+err:
+	kfree(vdev->irqs);
+	return -EINVAL;
 }
 
 void vfio_platform_irq_cleanup(struct vfio_platform_device *vdev)
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index 3a29a72..ffa2459 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -27,6 +27,7 @@
 struct vfio_platform_irq {
 	u32			flags;
 	u32			count;
+	int			hwirq;
 };
 
 struct vfio_platform_region {
@@ -45,6 +46,7 @@ struct vfio_platform_device {
 	struct vfio_platform_irq	*irqs;
 	u32				num_irqs;
 	int				refcnt;
+	struct mutex			igate;
 
 	/*
 	 * These fields should be filled by the bus specific binder
@@ -66,4 +68,8 @@ extern struct vfio_platform_device *vfio_platform_remove_common
 extern int vfio_platform_irq_init(struct vfio_platform_device *vdev);
 extern void vfio_platform_irq_cleanup(struct vfio_platform_device *vdev);
 
+extern int vfio_platform_set_irqs_ioctl(struct vfio_platform_device *vdev,
+			uint32_t flags, unsigned index, unsigned start,
+			unsigned count, void *data);
+
 #endif /* VFIO_PLATFORM_PRIVATE_H */
-- 
2.1.1
