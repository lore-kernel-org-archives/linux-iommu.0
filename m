From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [PATCH v10 13/20] vfio/platform: support for level sensitive
	interrupts
Date: Thu, 27 Nov 2014 18:32:53 +0100
Message-ID: <1417109580-10505-14-git-send-email-a.motakis@virtualopensystems.com>
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

Level sensitive interrupts are exposed as maskable and automasked
interrupts and are masked and disabled automatically when they fire.

Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 drivers/vfio/platform/vfio_platform_irq.c     | 99 ++++++++++++++++++++++++++-
 drivers/vfio/platform/vfio_platform_private.h |  2 +
 2 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
index 414b4c5..1765b6c 100644
--- a/drivers/vfio/platform/vfio_platform_irq.c
+++ b/drivers/vfio/platform/vfio_platform_irq.c
@@ -23,12 +23,59 @@
 
 #include "vfio_platform_private.h"
 
+static void vfio_platform_mask(struct vfio_platform_irq *irq_ctx)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&irq_ctx->lock, flags);
+
+	if (!irq_ctx->masked) {
+		disable_irq(irq_ctx->hwirq);
+		irq_ctx->masked = true;
+	}
+
+	spin_unlock_irqrestore(&irq_ctx->lock, flags);
+}
+
 static int vfio_platform_set_irq_mask(struct vfio_platform_device *vdev,
 				      unsigned index, unsigned start,
 				      unsigned count, uint32_t flags,
 				      void *data)
 {
-	return -EINVAL;
+	if (start != 0 || count != 1)
+		return -EINVAL;
+
+	if (!(vdev->irqs[index].flags & VFIO_IRQ_INFO_MASKABLE))
+		return -EINVAL;
+
+	if (flags & VFIO_IRQ_SET_DATA_EVENTFD)
+		return -EINVAL; /* not implemented yet */
+
+	if (flags & VFIO_IRQ_SET_DATA_NONE) {
+		vfio_platform_mask(&vdev->irqs[index]);
+
+	} else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
+		uint8_t mask = *(uint8_t *)data;
+
+		if (mask)
+			vfio_platform_mask(&vdev->irqs[index]);
+	}
+
+	return 0;
+}
+
+static void vfio_platform_unmask(struct vfio_platform_irq *irq_ctx)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&irq_ctx->lock, flags);
+
+	if (irq_ctx->masked) {
+		enable_irq(irq_ctx->hwirq);
+		irq_ctx->masked = false;
+	}
+
+	spin_unlock_irqrestore(&irq_ctx->lock, flags);
 }
 
 static int vfio_platform_set_irq_unmask(struct vfio_platform_device *vdev,
@@ -36,7 +83,50 @@ static int vfio_platform_set_irq_unmask(struct vfio_platform_device *vdev,
 					unsigned count, uint32_t flags,
 					void *data)
 {
-	return -EINVAL;
+	if (start != 0 || count != 1)
+		return -EINVAL;
+
+	if (!(vdev->irqs[index].flags & VFIO_IRQ_INFO_MASKABLE))
+		return -EINVAL;
+
+	if (flags & VFIO_IRQ_SET_DATA_EVENTFD)
+		return -EINVAL; /* not implemented yet */
+
+	if (flags & VFIO_IRQ_SET_DATA_NONE) {
+		vfio_platform_unmask(&vdev->irqs[index]);
+
+	} else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
+		uint8_t unmask = *(uint8_t *)data;
+
+		if (unmask)
+			vfio_platform_unmask(&vdev->irqs[index]);
+	}
+
+	return 0;
+}
+
+static irqreturn_t vfio_automasked_irq_handler(int irq, void *dev_id)
+{
+	struct vfio_platform_irq *irq_ctx = dev_id;
+	unsigned long flags;
+	int ret = IRQ_NONE;
+
+	spin_lock_irqsave(&irq_ctx->lock, flags);
+
+	if (!irq_ctx->masked) {
+		ret = IRQ_HANDLED;
+
+		/* automask maskable interrupts */
+		disable_irq_nosync(irq_ctx->hwirq);
+		irq_ctx->masked = true;
+	}
+
+	spin_unlock_irqrestore(&irq_ctx->lock, flags);
+
+	if (ret == IRQ_HANDLED)
+		eventfd_signal(irq_ctx->trigger, 1);
+
+	return ret;
 }
 
 static irqreturn_t vfio_irq_handler(int irq, void *dev_id)
@@ -97,7 +187,7 @@ static int vfio_platform_set_irq_trigger(struct vfio_platform_device *vdev,
 	irq_handler_t handler;
 
 	if (vdev->irqs[index].flags & VFIO_IRQ_INFO_AUTOMASKED)
-		return -EINVAL; /* not implemented */
+		handler = vfio_automasked_irq_handler;
 	else
 		handler = vfio_irq_handler;
 
@@ -169,6 +259,8 @@ int vfio_platform_irq_init(struct vfio_platform_device *vdev)
 		if (hwirq < 0)
 			goto err;
 
+		spin_lock_init(&vdev->irqs[i].lock);
+
 		vdev->irqs[i].flags = VFIO_IRQ_INFO_EVENTFD;
 
 		if (irq_get_trigger_type(hwirq) & IRQ_TYPE_LEVEL_MASK)
@@ -177,6 +269,7 @@ int vfio_platform_irq_init(struct vfio_platform_device *vdev)
 
 		vdev->irqs[i].count = 1;
 		vdev->irqs[i].hwirq = hwirq;
+		vdev->irqs[i].masked = false;
 	}
 
 	vdev->num_irqs = cnt;
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index b705f17..eef6d1b 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -30,6 +30,8 @@ struct vfio_platform_irq {
 	int			hwirq;
 	char			*name;
 	struct eventfd_ctx	*trigger;
+	bool			masked;
+	spinlock_t		lock;
 };
 
 struct vfio_platform_region {
-- 
2.1.3
