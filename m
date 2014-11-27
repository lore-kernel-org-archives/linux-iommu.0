From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [PATCH v10 14/20] vfio: add a vfio_ prefix to virqfd_enable and
	virqfd_disable and export
Date: Thu, 27 Nov 2014 18:32:54 +0100
Message-ID: <1417109580-10505-15-git-send-email-a.motakis@virtualopensystems.com>
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
Cc: "open list:VFIO DRIVER" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Gavin Shan <gwshan-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexander Gordeev <agordeev-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

We want to reuse virqfd functionality in multiple VFIO drivers; before
moving these functions to core VFIO, add the vfio_ prefix to the
virqfd_enable and virqfd_disable functions, and export them so they can
be used from other modules.

Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 drivers/vfio/pci/vfio_pci_intrs.c   | 30 ++++++++++++++++--------------
 drivers/vfio/pci/vfio_pci_private.h |  4 ++--
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 553212f..3aaac47 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -126,10 +126,10 @@ static void virqfd_inject(struct work_struct *work)
 		virqfd->thread(virqfd->vdev, virqfd->data);
 }
 
-static int virqfd_enable(struct vfio_pci_device *vdev,
-			 int (*handler)(struct vfio_pci_device *, void *),
-			 void (*thread)(struct vfio_pci_device *, void *),
-			 void *data, struct virqfd **pvirqfd, int fd)
+int vfio_virqfd_enable(struct vfio_pci_device *vdev,
+		       int (*handler)(struct vfio_pci_device *, void *),
+		       void (*thread)(struct vfio_pci_device *, void *),
+		       void *data, struct virqfd **pvirqfd, int fd)
 {
 	struct fd irqfd;
 	struct eventfd_ctx *ctx;
@@ -215,9 +215,9 @@ err_fd:
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(vfio_virqfd_enable);
 
-static void virqfd_disable(struct vfio_pci_device *vdev,
-			   struct virqfd **pvirqfd)
+void vfio_virqfd_disable(struct vfio_pci_device *vdev, struct virqfd **pvirqfd)
 {
 	unsigned long flags;
 
@@ -237,6 +237,7 @@ static void virqfd_disable(struct vfio_pci_device *vdev,
 	 */
 	flush_workqueue(vfio_irqfd_cleanup_wq);
 }
+EXPORT_SYMBOL_GPL(vfio_virqfd_disable);
 
 /*
  * INTx
@@ -440,8 +441,8 @@ static int vfio_intx_set_signal(struct vfio_pci_device *vdev, int fd)
 static void vfio_intx_disable(struct vfio_pci_device *vdev)
 {
 	vfio_intx_set_signal(vdev, -1);
-	virqfd_disable(vdev, &vdev->ctx[0].unmask);
-	virqfd_disable(vdev, &vdev->ctx[0].mask);
+	vfio_virqfd_disable(vdev, &vdev->ctx[0].unmask);
+	vfio_virqfd_disable(vdev, &vdev->ctx[0].mask);
 	vdev->irq_type = VFIO_PCI_NUM_IRQS;
 	vdev->num_ctx = 0;
 	kfree(vdev->ctx);
@@ -605,8 +606,8 @@ static void vfio_msi_disable(struct vfio_pci_device *vdev, bool msix)
 	vfio_msi_set_block(vdev, 0, vdev->num_ctx, NULL, msix);
 
 	for (i = 0; i < vdev->num_ctx; i++) {
-		virqfd_disable(vdev, &vdev->ctx[i].unmask);
-		virqfd_disable(vdev, &vdev->ctx[i].mask);
+		vfio_virqfd_disable(vdev, &vdev->ctx[i].unmask);
+		vfio_virqfd_disable(vdev, &vdev->ctx[i].mask);
 	}
 
 	if (msix) {
@@ -639,11 +640,12 @@ static int vfio_pci_set_intx_unmask(struct vfio_pci_device *vdev,
 	} else if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
 		int32_t fd = *(int32_t *)data;
 		if (fd >= 0)
-			return virqfd_enable(vdev, vfio_pci_intx_unmask_handler,
-					     vfio_send_intx_eventfd, NULL,
-					     &vdev->ctx[0].unmask, fd);
+			return vfio_virqfd_enable(vdev,
+						  vfio_pci_intx_unmask_handler,
+						  vfio_send_intx_eventfd, NULL,
+						  &vdev->ctx[0].unmask, fd);
 
-		virqfd_disable(vdev, &vdev->ctx[0].unmask);
+		vfio_virqfd_disable(vdev, &vdev->ctx[0].unmask);
 	}
 
 	return 0;
diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
index 671c17a..2e2f0ea 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -86,8 +86,8 @@ extern ssize_t vfio_pci_vga_rw(struct vfio_pci_device *vdev, char __user *buf,
 extern int vfio_pci_init_perm_bits(void);
 extern void vfio_pci_uninit_perm_bits(void);
 
-extern int vfio_pci_virqfd_init(void);
-extern void vfio_pci_virqfd_exit(void);
+extern int vfio_virqfd_init(void);
+extern void vfio_virqfd_exit(void);
 
 extern int vfio_config_init(struct vfio_pci_device *vdev);
 extern void vfio_config_free(struct vfio_pci_device *vdev);
-- 
2.1.3
