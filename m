From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [RFC PATCH v6 18/20] vfio: pass an opaque pointer on virqfd
	initialization
Date: Thu,  5 Jun 2014 19:03:26 +0200
Message-ID: <1401987808-23596-19-git-send-email-a.motakis@virtualopensystems.com>
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
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Alexander Gordeev <agordeev-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

VFIO_PCI passes the VFIO device structure *vdev via eventfd to the handler
that implements masking/unmasking of IRQs via an eventfd. We can replace
it in the virqfd infrastructure with an opaque type so we can make use
of the mechanism from other VFIO bus drivers.

Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 drivers/vfio/pci/vfio_pci_intrs.c | 11 +++++++----
 drivers/vfio/virqfd.c             | 17 ++++++++---------
 include/linux/vfio.h              | 12 ++++++------
 3 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index e56c814..6ca22a8 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -27,8 +27,10 @@
 /*
  * INTx
  */
-static void vfio_send_intx_eventfd(struct vfio_pci_device *vdev, void *unused)
+static void vfio_send_intx_eventfd(void *opaque, void *unused)
 {
+	struct vfio_pci_device *vdev = opaque;
+
 	if (likely(is_intx(vdev) && !vdev->virq_disabled))
 		eventfd_signal(vdev->ctx[0].trigger, 1);
 }
@@ -71,9 +73,9 @@ void vfio_pci_intx_mask(struct vfio_pci_device *vdev)
  * a signal is necessary, which can then be handled via a work queue
  * or directly depending on the caller.
  */
-static int vfio_pci_intx_unmask_handler(struct vfio_pci_device *vdev,
-					void *unused)
+static int vfio_pci_intx_unmask_handler(void *opaque, void *unused)
 {
+	struct vfio_pci_device *vdev = opaque;
 	struct pci_dev *pdev = vdev->pdev;
 	unsigned long flags;
 	int ret = 0;
@@ -411,7 +413,8 @@ static int vfio_pci_set_intx_unmask(struct vfio_pci_device *vdev,
 	} else if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
 		int32_t fd = *(int32_t *)data;
 		if (fd >= 0)
-			return virqfd_enable(vdev, vfio_pci_intx_unmask_handler,
+			return virqfd_enable((void *) vdev,
+					     vfio_pci_intx_unmask_handler,
 					     vfio_send_intx_eventfd, NULL,
 					     &vdev->ctx[0].unmask, fd);
 
diff --git a/drivers/vfio/virqfd.c b/drivers/vfio/virqfd.c
index 4528450..8c97e2e 100644
--- a/drivers/vfio/virqfd.c
+++ b/drivers/vfio/virqfd.c
@@ -14,7 +14,6 @@
 #include <linux/eventfd.h>
 #include <linux/file.h>
 #include <linux/slab.h>
-#include "pci/vfio_pci_private.h"
 
 static struct workqueue_struct *vfio_irqfd_cleanup_wq;
 static spinlock_t lock;
@@ -49,7 +48,7 @@ static int virqfd_wakeup(wait_queue_t *wait, unsigned mode, int sync, void *key)
 	if (flags & POLLIN) {
 		/* An event has been signaled, call function */
 		if ((!virqfd->handler ||
-		     virqfd->handler(virqfd->vdev, virqfd->data)) &&
+		     virqfd->handler(virqfd->opaque, virqfd->data)) &&
 		    virqfd->thread)
 			schedule_work(&virqfd->inject);
 	}
@@ -99,13 +98,13 @@ static void virqfd_inject(struct work_struct *work)
 {
 	struct virqfd *virqfd = container_of(work, struct virqfd, inject);
 	if (virqfd->thread)
-		virqfd->thread(virqfd->vdev, virqfd->data);
+		virqfd->thread(virqfd->opaque, virqfd->data);
 }
 
-int virqfd_enable(struct vfio_pci_device *vdev,
-			 int (*handler)(struct vfio_pci_device *, void *),
-			 void (*thread)(struct vfio_pci_device *, void *),
-			 void *data, struct virqfd **pvirqfd, int fd)
+int virqfd_enable(void *opaque,
+		  int (*handler)(void *, void *),
+		  void (*thread)(void *, void *),
+		  void *data, struct virqfd **pvirqfd, int fd)
 {
 	struct fd irqfd;
 	struct eventfd_ctx *ctx;
@@ -118,7 +117,7 @@ int virqfd_enable(struct vfio_pci_device *vdev,
 		return -ENOMEM;
 
 	virqfd->pvirqfd = pvirqfd;
-	virqfd->vdev = vdev;
+	virqfd->opaque = opaque;
 	virqfd->handler = handler;
 	virqfd->thread = thread;
 	virqfd->data = data;
@@ -171,7 +170,7 @@ int virqfd_enable(struct vfio_pci_device *vdev,
 	 * before we registered and trigger it as if we didn't miss it.
 	 */
 	if (events & POLLIN) {
-		if ((!handler || handler(vdev, data)) && thread)
+		if ((!handler || handler(opaque, data)) && thread)
 			schedule_work(&virqfd->inject);
 	}
 
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 44c9808..e4f7de8 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -105,10 +105,10 @@ extern long vfio_external_check_extension(struct vfio_group *group,
  * IRQFD support
  */
 struct virqfd {
-	struct vfio_pci_device	*vdev;
+	void			*opaque;
 	struct eventfd_ctx	*eventfd;
-	int			(*handler)(struct vfio_pci_device *, void *);
-	void			(*thread)(struct vfio_pci_device *, void *);
+	int			(*handler)(void *, void *);
+	void			(*thread)(void *, void *);
 	void			*data;
 	struct work_struct	inject;
 	wait_queue_t		wait;
@@ -119,9 +119,9 @@ struct virqfd {
 
 extern int vfio_pci_virqfd_init(void);
 extern void vfio_pci_virqfd_exit(void);
-extern int virqfd_enable(struct vfio_pci_device *vdev,
-			 int (*handler)(struct vfio_pci_device *, void *),
-			 void (*thread)(struct vfio_pci_device *, void *),
+extern int virqfd_enable(void *opaque,
+			 int (*handler)(void *, void *),
+			 void (*thread)(void *, void *),
 			 void *data, struct virqfd **pvirqfd, int fd);
 extern void virqfd_disable(struct virqfd **pvirqfd);
 
-- 
1.8.3.2
