From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [RFC PATCH v6 15/20] vfio/platform: support for maskable and
	automasked interrupts
Date: Thu,  5 Jun 2014 19:03:23 +0200
Message-ID: <1401987808-23596-16-git-send-email-a.motakis@virtualopensystems.com>
References: <1401987808-23596-1-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1401987808-23596-1-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Vladimir Murzin <vladimir.murzin-5wv7dgnIgG8@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Adds support to mask interrupts, and also for automasked interrupts.
Level sensitive interrupts are exposed as automasked interrupts and
are masked and disabled automatically when they fire.

Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 drivers/vfio/platform/vfio_platform_irq.c     | 112 ++++++++++++++++++++++++--
 drivers/vfio/platform/vfio_platform_private.h |   2 +
 2 files changed, 109 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
index d79f5af..10dfbf0 100644
--- a/drivers/vfio/platform/vfio_platform_irq.c
+++ b/drivers/vfio/platform/vfio_platform_irq.c
@@ -51,9 +51,17 @@ int vfio_platform_irq_init(struct vfio_platform_device *vdev)
 		if (hwirq < 0)
 			goto err;
 
-		vdev->irq[i].flags = VFIO_IRQ_INFO_EVENTFD;
+		spin_lock_init(&vdev->irq[i].lock);
+
+		vdev->irq[i].flags = VFIO_IRQ_INFO_EVENTFD
+					| VFIO_IRQ_INFO_MASKABLE;
+
+		if (irq_get_trigger_type(hwirq) & IRQ_TYPE_LEVEL_MASK)
+			vdev->irq[i].flags |= VFIO_IRQ_INFO_AUTOMASKED;
+
 		vdev->irq[i].count = 1;
 		vdev->irq[i].hwirq = hwirq;
+		vdev->irq[i].masked = false;
 	}
 
 	vdev->num_irqs = cnt;
@@ -77,11 +85,27 @@ void vfio_platform_irq_cleanup(struct vfio_platform_device *vdev)
 
 static irqreturn_t vfio_irq_handler(int irq, void *dev_id)
 {
-	struct eventfd_ctx *trigger = dev_id;
+	struct vfio_platform_irq *irq_ctx = dev_id;
+	unsigned long flags;
+	int ret = IRQ_NONE;
+
+	spin_lock_irqsave(&irq_ctx->lock, flags);
+
+	if (!irq_ctx->masked) {
+		ret = IRQ_HANDLED;
+
+		if (irq_ctx->flags & VFIO_IRQ_INFO_AUTOMASKED) {
+			disable_irq_nosync(irq_ctx->hwirq);
+			irq_ctx->masked = true;
+		}
+	}
 
-	eventfd_signal(trigger, 1);
+	spin_unlock_irqrestore(&irq_ctx->lock, flags);
 
-	return IRQ_HANDLED;
+	if (ret == IRQ_HANDLED)
+		eventfd_signal(irq_ctx->trigger, 1);
+
+	return ret;
 }
 
 static int vfio_set_trigger(struct vfio_platform_device *vdev,
@@ -162,6 +186,82 @@ static int vfio_platform_set_irq_trigger(struct vfio_platform_device *vdev,
 	return -EFAULT;
 }
 
+static int vfio_platform_set_irq_unmask(struct vfio_platform_device *vdev,
+				    unsigned index, unsigned start,
+				    unsigned count, uint32_t flags, void *data)
+{
+	uint8_t arr;
+
+	if (start != 0 || count != 1)
+		return -EINVAL;
+
+	switch (flags & VFIO_IRQ_SET_DATA_TYPE_MASK) {
+	case VFIO_IRQ_SET_DATA_BOOL:
+		if (copy_from_user(&arr, data, sizeof(uint8_t)))
+			return -EFAULT;
+
+		if (arr != 0x1)
+			return -EINVAL;
+
+	case VFIO_IRQ_SET_DATA_NONE:
+
+		spin_lock_irq(&vdev->irq[index].lock);
+
+		if (vdev->irq[index].masked) {
+			enable_irq(vdev->irq[index].hwirq);
+			vdev->irq[index].masked = false;
+		}
+
+		spin_unlock_irq(&vdev->irq[index].lock);
+
+		return 0;
+
+	case VFIO_IRQ_SET_DATA_EVENTFD: /* XXX not implemented yet */
+	default:
+		return -ENOTTY;
+	}
+
+	return 0;
+}
+
+static int vfio_platform_set_irq_mask(struct vfio_platform_device *vdev,
+				    unsigned index, unsigned start,
+				    unsigned count, uint32_t flags, void *data)
+{
+	uint8_t arr;
+
+	if (start != 0 || count != 1)
+		return -EINVAL;
+
+	switch (flags & VFIO_IRQ_SET_DATA_TYPE_MASK) {
+	case VFIO_IRQ_SET_DATA_BOOL:
+		if (copy_from_user(&arr, data, sizeof(uint8_t)))
+			return -EFAULT;
+
+		if (arr != 0x1)
+			return -EINVAL;
+
+	case VFIO_IRQ_SET_DATA_NONE:
+
+		spin_lock_irq(&vdev->irq[index].lock);
+
+		if (!vdev->irq[index].masked) {
+			disable_irq(vdev->irq[index].hwirq);
+			vdev->irq[index].masked = true;
+		}
+
+		spin_unlock_irq(&vdev->irq[index].lock);
+
+		return 0;
+
+	case VFIO_IRQ_SET_DATA_EVENTFD: /* XXX not implemented yet */
+	default:
+		return -ENOTTY;
+	}
+
+	return 0;
+}
+
 int vfio_platform_set_irqs_ioctl(struct vfio_platform_device *vdev,
 				 uint32_t flags, unsigned index, unsigned start,
 				 unsigned count, void *data)
@@ -172,8 +272,10 @@ int vfio_platform_set_irqs_ioctl(struct vfio_platform_device *vdev,
 
 	switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
 	case VFIO_IRQ_SET_ACTION_MASK:
+		func = vfio_platform_set_irq_mask;
+		break;
 	case VFIO_IRQ_SET_ACTION_UNMASK:
-		/* XXX not implemented */
+		func = vfio_platform_set_irq_unmask;
 		break;
 	case VFIO_IRQ_SET_ACTION_TRIGGER:
 		func = vfio_platform_set_irq_trigger;
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index d6200df..4d887fd 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -30,6 +30,8 @@ struct vfio_platform_irq {
 	u32			count;
 	int			hwirq;
 	char			*name;
+	bool			masked;
+	spinlock_t		lock;
 };
 
 struct vfio_platform_region {
-- 
1.8.3.2
