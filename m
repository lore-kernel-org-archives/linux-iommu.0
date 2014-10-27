From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [PATCH v9 17/19] vfio: virqfd: add vfio_ prefix to virqfd_enable and
	virqfd_disable
Date: Mon, 27 Oct 2014 19:08:02 +0100
Message-ID: <1414433284-31719-18-git-send-email-a.motakis@virtualopensystems.com>
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
Cc: "open list:VFIO DRIVER" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexander Gordeev <agordeev-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The virqfd_enable and virqfd_disable functions are now global. Add the
vfio_ prefix to those functions.

Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 drivers/vfio/pci/vfio_pci_intrs.c | 18 +++++++++---------
 drivers/vfio/virqfd.c             | 14 +++++++-------
 include/linux/vfio.h              | 10 +++++-----
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 6ca22a8..2aedff1 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -228,8 +228,8 @@ static int vfio_intx_set_signal(struct vfio_pci_device *vdev, int fd)
 static void vfio_intx_disable(struct vfio_pci_device *vdev)
 {
 	vfio_intx_set_signal(vdev, -1);
-	virqfd_disable(&vdev->ctx[0].unmask);
-	virqfd_disable(&vdev->ctx[0].mask);
+	vfio_virqfd_disable(&vdev->ctx[0].unmask);
+	vfio_virqfd_disable(&vdev->ctx[0].mask);
 	vdev->irq_type = VFIO_PCI_NUM_IRQS;
 	vdev->num_ctx = 0;
 	kfree(vdev->ctx);
@@ -379,8 +379,8 @@ static void vfio_msi_disable(struct vfio_pci_device *vdev, bool msix)
 	vfio_msi_set_block(vdev, 0, vdev->num_ctx, NULL, msix);
 
 	for (i = 0; i < vdev->num_ctx; i++) {
-		virqfd_disable(&vdev->ctx[i].unmask);
-		virqfd_disable(&vdev->ctx[i].mask);
+		vfio_virqfd_disable(&vdev->ctx[i].unmask);
+		vfio_virqfd_disable(&vdev->ctx[i].mask);
 	}
 
 	if (msix) {
@@ -413,12 +413,12 @@ static int vfio_pci_set_intx_unmask(struct vfio_pci_device *vdev,
 	} else if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
 		int32_t fd = *(int32_t *)data;
 		if (fd >= 0)
-			return virqfd_enable((void *) vdev,
-					     vfio_pci_intx_unmask_handler,
-					     vfio_send_intx_eventfd, NULL,
-					     &vdev->ctx[0].unmask, fd);
+			return vfio_virqfd_enable((void *) vdev,
+						  vfio_pci_intx_unmask_handler,
+						  vfio_send_intx_eventfd, NULL,
+						  &vdev->ctx[0].unmask, fd);
 
-		virqfd_disable(&vdev->ctx[0].unmask);
+		vfio_virqfd_disable(&vdev->ctx[0].unmask);
 	}
 
 	return 0;
diff --git a/drivers/vfio/virqfd.c b/drivers/vfio/virqfd.c
index ac63ec0..1794f07 100644
--- a/drivers/vfio/virqfd.c
+++ b/drivers/vfio/virqfd.c
@@ -101,10 +101,10 @@ static void virqfd_inject(struct work_struct *work)
 		virqfd->thread(virqfd->opaque, virqfd->data);
 }
 
-int virqfd_enable(void *opaque,
-		  int (*handler)(void *, void *),
-		  void (*thread)(void *, void *),
-		  void *data, struct virqfd **pvirqfd, int fd)
+int vfio_virqfd_enable(void *opaque,
+		       int (*handler)(void *, void *),
+		       void (*thread)(void *, void *),
+		       void *data, struct virqfd **pvirqfd, int fd)
 {
 	struct fd irqfd;
 	struct eventfd_ctx *ctx;
@@ -190,9 +190,9 @@ err_fd:
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(virqfd_enable);
+EXPORT_SYMBOL_GPL(vfio_virqfd_enable);
 
-void virqfd_disable(struct virqfd **pvirqfd)
+void vfio_virqfd_disable(struct virqfd **pvirqfd)
 {
 	unsigned long flags;
 
@@ -212,4 +212,4 @@ void virqfd_disable(struct virqfd **pvirqfd)
 	 */
 	flush_workqueue(vfio_irqfd_cleanup_wq);
 }
-EXPORT_SYMBOL_GPL(virqfd_disable);
+EXPORT_SYMBOL_GPL(vfio_virqfd_disable);
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index ce23a42..378f320 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -142,10 +142,10 @@ struct virqfd {
 
 extern int vfio_pci_virqfd_init(void);
 extern void vfio_pci_virqfd_exit(void);
-extern int virqfd_enable(void *opaque,
-			 int (*handler)(void *, void *),
-			 void (*thread)(void *, void *),
-			 void *data, struct virqfd **pvirqfd, int fd);
-extern void virqfd_disable(struct virqfd **pvirqfd);
+extern int vfio_virqfd_enable(void *opaque,
+			      int (*handler)(void *, void *),
+			      void (*thread)(void *, void *),
+			      void *data, struct virqfd **pvirqfd, int fd);
+extern void vfio_virqfd_disable(struct virqfd **pvirqfd);
 
 #endif /* VFIO_H */
-- 
2.1.1
