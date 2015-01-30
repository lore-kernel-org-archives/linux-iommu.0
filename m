From: Baptiste Reynal <b.reynal@virtualopensystems.com>
Subject: [PATCH v13 18/18] vfio/platform: implement IRQ masking/unmasking via an eventfd
Date: Fri, 30 Jan 2015 14:46:24 +0100
Message-ID: <1422625584-3741-19-git-send-email-b.reynal@virtualopensystems.com>
References: <1422625584-3741-1-git-send-email-b.reynal@virtualopensystems.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422625584-3741-1-git-send-email-b.reynal@virtualopensystems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kvmarm@lists.cs.columbia.edu, iommu@lists.linux-foundation.org, alex.williamson@redhat.com
Cc: will.deacon@arm.com, tech@virtualopensystems.com, christoffer.dall@linaro.org, eric.auger@linaro.org, kim.phillips@freescale.com, marc.zyngier@arm.com, Antonios Motakis <a.motakis@virtualopensystems.com>, Baptiste Reynal <b.reynal@virtualopensystems.com>, "open list:VFIO DRIVER" <kvm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

From: Antonios Motakis <a.motakis@virtualopensystems.com>

With this patch the VFIO user will be able to set an eventfd that can be
used in order to mask and unmask IRQs of platform devices.

Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
---
 drivers/vfio/platform/vfio_platform_irq.c     | 47 ++++++++++++++++++++++++---
 drivers/vfio/platform/vfio_platform_private.h |  2 ++
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
index e0e6388..88bba57 100644
--- a/drivers/vfio/platform/vfio_platform_irq.c
+++ b/drivers/vfio/platform/vfio_platform_irq.c
@@ -37,6 +37,15 @@ static void vfio_platform_mask(struct vfio_platform_irq *irq_ctx)
 	spin_unlock_irqrestore(&irq_ctx->lock, flags);
 }
 
+static int vfio_platform_mask_handler(void *opaque, void *unused)
+{
+	struct vfio_platform_irq *irq_ctx = opaque;
+
+	vfio_platform_mask(irq_ctx);
+
+	return 0;
+}
+
 static int vfio_platform_set_irq_mask(struct vfio_platform_device *vdev,
 				      unsigned index, unsigned start,
 				      unsigned count, uint32_t flags,
@@ -48,8 +57,18 @@ static int vfio_platform_set_irq_mask(struct vfio_platform_device *vdev,
 	if (!(vdev->irqs[index].flags & VFIO_IRQ_INFO_MASKABLE))
 		return -EINVAL;
 
-	if (flags & VFIO_IRQ_SET_DATA_EVENTFD)
-		return -EINVAL; /* not implemented yet */
+	if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
+		int32_t fd = *(int32_t *)data;
+
+		if (fd >= 0)
+			return vfio_virqfd_enable((void *) &vdev->irqs[index],
+						  vfio_platform_mask_handler,
+						  NULL, NULL,
+						  &vdev->irqs[index].mask, fd);
+
+		vfio_virqfd_disable(&vdev->irqs[index].mask);
+		return 0;
+	}
 
 	if (flags & VFIO_IRQ_SET_DATA_NONE) {
 		vfio_platform_mask(&vdev->irqs[index]);
@@ -78,6 +97,15 @@ static void vfio_platform_unmask(struct vfio_platform_irq *irq_ctx)
 	spin_unlock_irqrestore(&irq_ctx->lock, flags);
 }
 
+static int vfio_platform_unmask_handler(void *opaque, void *unused)
+{
+	struct vfio_platform_irq *irq_ctx = opaque;
+
+	vfio_platform_unmask(irq_ctx);
+
+	return 0;
+}
+
 static int vfio_platform_set_irq_unmask(struct vfio_platform_device *vdev,
 					unsigned index, unsigned start,
 					unsigned count, uint32_t flags,
@@ -89,8 +117,19 @@ static int vfio_platform_set_irq_unmask(struct vfio_platform_device *vdev,
 	if (!(vdev->irqs[index].flags & VFIO_IRQ_INFO_MASKABLE))
 		return -EINVAL;
 
-	if (flags & VFIO_IRQ_SET_DATA_EVENTFD)
-		return -EINVAL; /* not implemented yet */
+	if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
+		int32_t fd = *(int32_t *)data;
+
+		if (fd >= 0)
+			return vfio_virqfd_enable((void *) &vdev->irqs[index],
+						  vfio_platform_unmask_handler,
+						  NULL, NULL,
+						  &vdev->irqs[index].unmask,
+						  fd);
+
+		vfio_virqfd_disable(&vdev->irqs[index].unmask);
+		return 0;
+	}
 
 	if (flags & VFIO_IRQ_SET_DATA_NONE) {
 		vfio_platform_unmask(&vdev->irqs[index]);
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index ff2db1d..5d31e04 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -35,6 +35,8 @@ struct vfio_platform_irq {
 	struct eventfd_ctx	*trigger;
 	bool			masked;
 	spinlock_t		lock;
+	struct virqfd		*unmask;
+	struct virqfd		*mask;
 };
 
 struct vfio_platform_region {
-- 
2.2.2
