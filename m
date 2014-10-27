From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [PATCH v9 18/19] vfio: initialize the virqfd workqueue in VFIO
	generic code
Date: Mon, 27 Oct 2014 19:08:03 +0100
Message-ID: <1414433284-31719-19-git-send-email-a.motakis@virtualopensystems.com>
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
Cc: "open list:VFIO DRIVER" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, Gavin Shan <gwshan-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Now we have finally completely decoupled virqfd from VFIO_PCI. We can
initialize it from the VFIO generic code, in order to safely use it from
multiple independent VFIO bus drivers.

Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
---
 drivers/vfio/pci/vfio_pci.c | 8 --------
 drivers/vfio/vfio.c         | 8 ++++++++
 drivers/vfio/virqfd.c       | 4 ++--
 include/linux/vfio.h        | 4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index f782533..40e176d 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1034,7 +1034,6 @@ static void vfio_pci_try_bus_reset(struct vfio_pci_device *vdev)
 static void __exit vfio_pci_cleanup(void)
 {
 	pci_unregister_driver(&vfio_pci_driver);
-	vfio_pci_virqfd_exit();
 	vfio_pci_uninit_perm_bits();
 }
 
@@ -1047,11 +1046,6 @@ static int __init vfio_pci_init(void)
 	if (ret)
 		return ret;
 
-	/* Start the virqfd cleanup handler */
-	ret = vfio_pci_virqfd_init();
-	if (ret)
-		goto out_virqfd;
-
 	/* Register and scan for devices */
 	ret = pci_register_driver(&vfio_pci_driver);
 	if (ret)
@@ -1060,8 +1054,6 @@ static int __init vfio_pci_init(void)
 	return 0;
 
 out_driver:
-	vfio_pci_virqfd_exit();
-out_virqfd:
 	vfio_pci_uninit_perm_bits();
 	return ret;
 }
diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index f018d8d..8e84471 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -1464,6 +1464,11 @@ static int __init vfio_init(void)
 	if (ret)
 		goto err_cdev_add;
 
+	/* Start the virqfd cleanup handler used by some VFIO bus drivers */
+	ret = vfio_virqfd_init();
+	if (ret)
+		goto err_virqfd;
+
 	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
 
 	/*
@@ -1476,6 +1481,8 @@ static int __init vfio_init(void)
 
 	return 0;
 
+err_virqfd:
+	cdev_del(&vfio.group_cdev);
 err_cdev_add:
 	unregister_chrdev_region(vfio.group_devt, MINORMASK);
 err_alloc_chrdev:
@@ -1490,6 +1497,7 @@ static void __exit vfio_cleanup(void)
 {
 	WARN_ON(!list_empty(&vfio.group_list));
 
+	vfio_virqfd_exit();
 	idr_destroy(&vfio.group_idr);
 	cdev_del(&vfio.group_cdev);
 	unregister_chrdev_region(vfio.group_devt, MINORMASK);
diff --git a/drivers/vfio/virqfd.c b/drivers/vfio/virqfd.c
index 1794f07..7e4c23b 100644
--- a/drivers/vfio/virqfd.c
+++ b/drivers/vfio/virqfd.c
@@ -18,7 +18,7 @@
 static struct workqueue_struct *vfio_irqfd_cleanup_wq;
 static spinlock_t lock;
 
-int __init vfio_pci_virqfd_init(void)
+int __init vfio_virqfd_init(void)
 {
 	vfio_irqfd_cleanup_wq =
 		create_singlethread_workqueue("vfio-irqfd-cleanup");
@@ -30,7 +30,7 @@ int __init vfio_pci_virqfd_init(void)
 	return 0;
 }
 
-void vfio_pci_virqfd_exit(void)
+void vfio_virqfd_exit(void)
 {
 	destroy_workqueue(vfio_irqfd_cleanup_wq);
 }
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 378f320..2fb2e30 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -140,8 +140,8 @@ struct virqfd {
 	struct virqfd		**pvirqfd;
 };
 
-extern int vfio_pci_virqfd_init(void);
-extern void vfio_pci_virqfd_exit(void);
+extern int vfio_virqfd_init(void);
+extern void vfio_virqfd_exit(void);
 extern int vfio_virqfd_enable(void *opaque,
 			      int (*handler)(void *, void *),
 			      void (*thread)(void *, void *),
-- 
2.1.1
