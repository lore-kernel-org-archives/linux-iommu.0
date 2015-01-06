From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [PATCH v11 12/20] vfio/platform: trigger an interrupt via eventfd
Date: Tue,  6 Jan 2015 11:48:47 +0100
Message-ID: <1420541335-17190-13-git-send-email-a.motakis@virtualopensystems.com>
References: <1420541335-17190-1-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1420541335-17190-1-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
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

This patch allows to set an eventfd for a platform device's interrupt,
and also to trigger the interrupt eventfd from userspace for testing.
Level sensitive interrupts are marked as maskable and are handled in
a later patch. Edge triggered interrupts are not advertised as maskable
and are implemented here using a simple and efficient IRQ handler.

Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 drivers/vfio/platform/vfio_platform_irq.c     | 102 +++++++++++++++++++++++++-
 drivers/vfio/platform/vfio_platform_private.h |   2 +
 2 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
index df5c919..4896581 100644
--- a/drivers/vfio/platform/vfio_platform_irq.c
+++ b/drivers/vfio/platform/vfio_platform_irq.c
@@ -39,12 +39,100 @@ static int vfio_platform_set_irq_unmask(struct vfio_platform_device *vdev,
 	return -EINVAL;
 }
 
+static irqreturn_t vfio_irq_handler(int irq, void *dev_id)
+{
+	struct vfio_platform_irq *irq_ctx = dev_id;
+
+	eventfd_signal(irq_ctx->trigger, 1);
+
+	return IRQ_HANDLED;
+}
+
+static int vfio_set_trigger(struct vfio_platform_device *vdev, int index,
+			    int fd, irq_handler_t handler)
+{
+	struct vfio_platform_irq *irq = &vdev->irqs[index];
+	struct eventfd_ctx *trigger;
+	unsigned long flags;
+	int ret;
+
+	if (irq->trigger) {
+		free_irq(irq->hwirq, irq);
+		kfree(irq->name);
+		eventfd_ctx_put(irq->trigger);
+		irq->trigger = NULL;
+	}
+
+	if (fd < 0) /* Disable only */
+		return 0;
+
+	irq->name = kasprintf(GFP_KERNEL, "vfio-irq[%d](%s)",
+						irq->hwirq, vdev->name);
+	if (!irq->name)
+		return -ENOMEM;
+
+	trigger = eventfd_ctx_fdget(fd);
+	if (IS_ERR(trigger)) {
+		kfree(irq->name);
+		return PTR_ERR(trigger);
+	}
+
+	irq->trigger = trigger;
+
+	ret = request_irq(irq->hwirq, handler, 0, irq->name, irq);
+	if (ret) {
+		kfree(irq->name);
+		eventfd_ctx_put(trigger);
+		irq->trigger = NULL;
+		return ret;
+	}
+
+	/* if the IRQ has been masked by the user before setting an eventfd,
+	 * then we need to make sure it is properly disabled */
+	spin_lock_irqsave(&irq->lock, flags);
+	if (irq->masked)
+		disable_irq_nosync(irq->hwirq);
+	spin_unlock_irqrestore(&irq->lock, flags);
+
+	return 0;
+}
+
 static int vfio_platform_set_irq_trigger(struct vfio_platform_device *vdev,
 					 unsigned index, unsigned start,
 					 unsigned count, uint32_t flags,
 					 void *data)
 {
-	return -EINVAL;
+	struct vfio_platform_irq *irq = &vdev->irqs[index];
+	irq_handler_t handler;
+
+	if (vdev->irqs[index].flags & VFIO_IRQ_INFO_AUTOMASKED)
+		return -EINVAL; /* not implemented */
+	else
+		handler = vfio_irq_handler;
+
+	if (!count && (flags & VFIO_IRQ_SET_DATA_NONE))
+		return vfio_set_trigger(vdev, index, -1, handler);
+
+	if (start != 0 || count != 1)
+		return -EINVAL;
+
+	if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
+		int32_t fd = *(int32_t *)data;
+
+		return vfio_set_trigger(vdev, index, fd, handler);
+	}
+
+	if (flags & VFIO_IRQ_SET_DATA_NONE) {
+		handler(irq->hwirq, irq);
+
+	} else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
+		uint8_t trigger = *(uint8_t *)data;
+
+		if (trigger)
+			handler(irq->hwirq, irq);
+	}
+
+	return 0;
 }
 
 int vfio_platform_set_irqs_ioctl(struct vfio_platform_device *vdev,
@@ -90,7 +178,12 @@ int vfio_platform_irq_init(struct vfio_platform_device *vdev)
 		if (hwirq < 0)
 			goto err;
 
-		vdev->irqs[i].flags = 0;
+		vdev->irqs[i].flags = VFIO_IRQ_INFO_EVENTFD;
+
+		if (irq_get_trigger_type(hwirq) & IRQ_TYPE_LEVEL_MASK)
+			vdev->irqs[i].flags |= VFIO_IRQ_INFO_MASKABLE
+						| VFIO_IRQ_INFO_AUTOMASKED;
+
 		vdev->irqs[i].count = 1;
 		vdev->irqs[i].hwirq = hwirq;
 	}
@@ -105,6 +198,11 @@ err:
 
 void vfio_platform_irq_cleanup(struct vfio_platform_device *vdev)
 {
+	int i;
+
+	for (i = 0; i < vdev->num_irqs; i++)
+		vfio_set_trigger(vdev, i, -1, NULL);
+
 	vdev->num_irqs = 0;
 	kfree(vdev->irqs);
 }
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index 61f3ed4..b705f17 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -28,6 +28,8 @@ struct vfio_platform_irq {
 	u32			flags;
 	u32			count;
 	int			hwirq;
+	char			*name;
+	struct eventfd_ctx	*trigger;
 };
 
 struct vfio_platform_region {
-- 
2.1.4
