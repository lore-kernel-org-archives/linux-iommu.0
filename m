From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [RFC PATCH v6 20/20] vfio/platform: implement IRQ masking/unmasking
	via an eventfd
Date: Thu,  5 Jun 2014 19:03:28 +0200
Message-ID: <1401987808-23596-21-git-send-email-a.motakis@virtualopensystems.com>
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

With this patch the VFIO user will be able to set an eventfd that can be
used in order to mask and unmask IRQs of platform devices.

Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 drivers/vfio/platform/vfio_platform_irq.c     | 86 ++++++++++++++++++++++-----
 drivers/vfio/platform/vfio_platform_private.h |  2 +
 2 files changed, 72 insertions(+), 16 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
index 10dfbf0..6768508 100644
--- a/drivers/vfio/platform/vfio_platform_irq.c
+++ b/drivers/vfio/platform/vfio_platform_irq.c
@@ -108,6 +108,52 @@ static irqreturn_t vfio_irq_handler(int irq, void *dev_id)
 	return ret;
 }
 
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
+}
+
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
+static int vfio_platform_unmask_handler(void *opaque, void *unused)
+{
+	struct vfio_platform_irq *irq_ctx = opaque;
+
+	vfio_platform_unmask(irq_ctx);
+
+	return 0;
+}
+
+static int vfio_platform_mask_handler(void *opaque, void *unused)
+{
+	struct vfio_platform_irq *irq_ctx = opaque;
+
+	vfio_platform_mask(irq_ctx);
+
+	return 0;
+}
+
 static int vfio_set_trigger(struct vfio_platform_device *vdev,
 			    int index, int fd)
 {
@@ -191,6 +237,7 @@ static int vfio_platform_set_irq_unmask(struct vfio_platform_device *vdev,
 				    unsigned count, uint32_t flags, void *data)
 {
 	uint8_t arr;
+	int32_t fd;
 
 	if (start != 0 || count != 1)
 		return -EINVAL;
@@ -204,19 +251,22 @@ static int vfio_platform_set_irq_unmask(struct vfio_platform_device *vdev,
 			return -EINVAL;
 
 	case VFIO_IRQ_SET_DATA_NONE:
+		vfio_platform_unmask(&vdev->irq[index]);
+		return 0;
 
-		spin_lock_irq(&vdev->irq[index].lock);
-
-		if (vdev->irq[index].masked) {
-			enable_irq(vdev->irq[index].hwirq);
-			vdev->irq[index].masked = false;
-		}
+	case VFIO_IRQ_SET_DATA_EVENTFD:
+		if (copy_from_user(&fd, data, sizeof(int32_t)))
+			return -EFAULT;
 
-		spin_unlock_irq(&vdev->irq[index].lock);
+		if (fd >= 0)
+			return virqfd_enable((void *) &vdev->irq[index],
+					     vfio_platform_unmask_handler,
+					     NULL, NULL,
+					     &vdev->irq[index].unmask, fd);
 
+		virqfd_disable(&vdev->irq[index].unmask);
 		return 0;
 
-	case VFIO_IRQ_SET_DATA_EVENTFD: /* XXX not implemented yet */
 	default:
 		return -ENOTTY;
 	}
@@ -229,6 +279,7 @@ static int vfio_platform_set_irq_mask(struct vfio_platform_device *vdev,
 				    unsigned count, uint32_t flags, void *data)
 {
 	uint8_t arr;
+	int32_t fd;
 
 	if (start != 0 || count != 1)
 		return -EINVAL;
@@ -242,19 +293,22 @@ static int vfio_platform_set_irq_mask(struct vfio_platform_device *vdev,
 			return -EINVAL;
 
 	case VFIO_IRQ_SET_DATA_NONE:
+		vfio_platform_mask(&vdev->irq[index]);
+		return 0;
 
-		spin_lock_irq(&vdev->irq[index].lock);
-
-		if (!vdev->irq[index].masked) {
-			disable_irq(vdev->irq[index].hwirq);
-			vdev->irq[index].masked = true;
-		}
+	case VFIO_IRQ_SET_DATA_EVENTFD:
+		if (copy_from_user(&fd, data, sizeof(int32_t)))
+			return -EFAULT;
 
-		spin_unlock_irq(&vdev->irq[index].lock);
+		if (fd >= 0)
+			return virqfd_enable((void *) &vdev->irq[index],
+					     vfio_platform_mask_handler,
+					     NULL, NULL,
+					     &vdev->irq[index].mask, fd);
 
+		virqfd_disable(&vdev->irq[index].mask);
 		return 0;
 
-	case VFIO_IRQ_SET_DATA_EVENTFD: /* XXX not implemented yet */
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index 4d887fd..86a9201 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -32,6 +32,8 @@ struct vfio_platform_irq {
 	char			*name;
 	bool			masked;
 	spinlock_t		lock;
+	struct virqfd		*unmask;
+	struct virqfd		*mask;
 };
 
 struct vfio_platform_region {
-- 
1.8.3.2
