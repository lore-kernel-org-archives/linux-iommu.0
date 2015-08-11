From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v6 09/16] vfio: Register/unregister irq_bypass_producer
Date: Tue, 11 Aug 2015 14:03:51 +0800
Message-ID: <1439273038-59463-10-git-send-email-feng.wu@intel.com>
References: <1439273038-59463-1-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1439273038-59463-1-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch adds the registration/unregistration of an
irq_bypass_producer for MSI/MSIx on vfio pci devices.

v6:
- Make the add_consumer and del_consumer callbacks static
- Remove pointless INIT_LIST_HEAD to 'vdev->ctx[vector].producer.node)'
- Use dev_info instead of WARN_ON() when irq_bypass_register_producer fails
- Remove optional dummy callbacks for irq producer

Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/vfio/pci/vfio_pci_intrs.c   | 9 +++++++++
 drivers/vfio/pci/vfio_pci_private.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 1f577b4..c65299d 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -319,6 +319,7 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_device *vdev,
 
 	if (vdev->ctx[vector].trigger) {
 		free_irq(irq, vdev->ctx[vector].trigger);
+		irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
 		kfree(vdev->ctx[vector].name);
 		eventfd_ctx_put(vdev->ctx[vector].trigger);
 		vdev->ctx[vector].trigger = NULL;
@@ -360,6 +361,14 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_device *vdev,
 		return ret;
 	}
 
+	vdev->ctx[vector].producer.token = trigger;
+	vdev->ctx[vector].producer.irq = irq;
+	ret = irq_bypass_register_producer(&vdev->ctx[vector].producer);
+	if (unlikely(ret))
+		dev_info(&pdev->dev,
+		"irq bypass producer (token %p) registeration fails: %d\n",
+		vdev->ctx[vector].producer.token, ret);
+
 	vdev->ctx[vector].trigger = trigger;
 
 	return 0;
diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
index ae0e1b4..0e7394f 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -13,6 +13,7 @@
 
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/irqbypass.h>
 
 #ifndef VFIO_PCI_PRIVATE_H
 #define VFIO_PCI_PRIVATE_H
@@ -29,6 +30,7 @@ struct vfio_pci_irq_ctx {
 	struct virqfd		*mask;
 	char			*name;
 	bool			masked;
+	struct irq_bypass_producer	producer;
 };
 
 struct vfio_pci_device {
-- 
2.1.0
