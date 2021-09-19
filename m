Return-Path: <SRS0=PYNz=OJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FE0C433F5
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:42:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7342E60F51
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7342E60F51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5306E83AF0;
	Sun, 19 Sep 2021 06:42:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2AFajmWQJhzu; Sun, 19 Sep 2021 06:42:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 42DA3837AC;
	Sun, 19 Sep 2021 06:42:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FECEC0011;
	Sun, 19 Sep 2021 06:42:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 631C3C000D
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:42:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4560F404FB
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:42:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 49mCOX7cC1jO for <iommu@lists.linux-foundation.org>;
 Sun, 19 Sep 2021 06:42:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7CE1F404E7
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:42:25 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10111"; a="284011051"
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="284011051"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2021 23:42:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="510701998"
Received: from yiliu-dev.bj.intel.com (HELO iov-dual.bj.intel.com)
 ([10.238.156.135])
 by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2021 23:42:18 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, jgg@nvidia.com, hch@lst.de,
 jasowang@redhat.com, joro@8bytes.org
Subject: [RFC 08/20] vfio/pci: Add VFIO_DEVICE_BIND_IOMMUFD
Date: Sun, 19 Sep 2021 14:38:36 +0800
Message-Id: <20210919063848.1476776-9-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210919063848.1476776-1-yi.l.liu@intel.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, kwankhede@nvidia.com, jean-philippe@linaro.org,
 dave.jiang@intel.com, ashok.raj@intel.com, corbet@lwn.net,
 kevin.tian@intel.com, parav@mellanox.com, lkml@metux.net,
 david@gibson.dropbear.id.au, robin.murphy@arm.com, jun.j.tian@intel.com,
 linux-kernel@vger.kernel.org, lushenming@huawei.com,
 iommu@lists.linux-foundation.org, pbonzini@redhat.com, dwmw2@infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This patch adds VFIO_DEVICE_BIND_IOMMUFD for userspace to bind the vfio
device to an iommufd. No VFIO_DEVICE_UNBIND_IOMMUFD interface is provided
because it's implicitly done when the device fd is closed.

In concept a vfio device can be bound to multiple iommufds, each hosting
a subset of I/O address spaces attached by this device. However as a
starting point (matching current vfio), only one I/O address space is
supported per vfio device. It implies one device can only be attached
to one iommufd at this point.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/vfio/pci/Kconfig            |  1 +
 drivers/vfio/pci/vfio_pci.c         | 72 ++++++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_private.h |  8 ++++
 include/uapi/linux/vfio.h           | 30 ++++++++++++
 4 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index 5e2e1b9a9fd3..3abfb098b4dc 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -5,6 +5,7 @@ config VFIO_PCI
 	depends on MMU
 	select VFIO_VIRQFD
 	select IRQ_BYPASS_MANAGER
+	select IOMMUFD
 	help
 	  Support for the PCI VFIO bus driver.  This is required to make
 	  use of PCI drivers using the VFIO framework.
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 145addde983b..20006bb66430 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -552,6 +552,16 @@ static void vfio_pci_release(struct vfio_device *core_vdev)
 			vdev->req_trigger = NULL;
 		}
 		mutex_unlock(&vdev->igate);
+
+		mutex_lock(&vdev->videv_lock);
+		if (vdev->videv) {
+			struct vfio_iommufd_device *videv = vdev->videv;
+
+			vdev->videv = NULL;
+			iommufd_unbind_device(videv->idev);
+			kfree(videv);
+		}
+		mutex_unlock(&vdev->videv_lock);
 	}
 
 	mutex_unlock(&vdev->reflck->lock);
@@ -780,7 +790,66 @@ static long vfio_pci_ioctl(struct vfio_device *core_vdev,
 		container_of(core_vdev, struct vfio_pci_device, vdev);
 	unsigned long minsz;
 
-	if (cmd == VFIO_DEVICE_GET_INFO) {
+	if (cmd == VFIO_DEVICE_BIND_IOMMUFD) {
+		struct vfio_device_iommu_bind_data bind_data;
+		unsigned long minsz;
+		struct iommufd_device *idev;
+		struct vfio_iommufd_device *videv;
+
+		/*
+		 * Reject the request if the device is already opened and
+		 * attached to a container.
+		 */
+		if (vfio_device_in_container(core_vdev))
+			return -ENOTTY;
+
+		minsz = offsetofend(struct vfio_device_iommu_bind_data, dev_cookie);
+
+		if (copy_from_user(&bind_data, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (bind_data.argsz < minsz ||
+		    bind_data.flags || bind_data.iommu_fd < 0)
+			return -EINVAL;
+
+		mutex_lock(&vdev->videv_lock);
+		/*
+		 * Allow only one iommufd per device until multiple
+		 * address spaces (e.g. vSVA) support is introduced
+		 * in the future.
+		 */
+		if (vdev->videv) {
+			mutex_unlock(&vdev->videv_lock);
+			return -EBUSY;
+		}
+
+		idev = iommufd_bind_device(bind_data.iommu_fd,
+					   &vdev->pdev->dev,
+					   bind_data.dev_cookie);
+		if (IS_ERR(idev)) {
+			mutex_unlock(&vdev->videv_lock);
+			return PTR_ERR(idev);
+		}
+
+		videv = kzalloc(sizeof(*videv), GFP_KERNEL);
+		if (!videv) {
+			iommufd_unbind_device(idev);
+			mutex_unlock(&vdev->videv_lock);
+			return -ENOMEM;
+		}
+		videv->idev = idev;
+		videv->iommu_fd = bind_data.iommu_fd;
+		/*
+		 * A security context has been established. Unblock
+		 * user access.
+		 */
+		if (atomic_read(&vdev->block_access))
+			atomic_set(&vdev->block_access, 0);
+		vdev->videv = videv;
+		mutex_unlock(&vdev->videv_lock);
+
+		return 0;
+	} else if (cmd == VFIO_DEVICE_GET_INFO) {
 		struct vfio_device_info info;
 		struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
 		unsigned long capsz;
@@ -2031,6 +2100,7 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	mutex_init(&vdev->vma_lock);
 	INIT_LIST_HEAD(&vdev->vma_list);
 	init_rwsem(&vdev->memory_lock);
+	mutex_init(&vdev->videv_lock);
 
 	ret = vfio_pci_reflck_attach(vdev);
 	if (ret)
diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
index f12012e30b53..bd784accac35 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/uuid.h>
 #include <linux/notifier.h>
+#include <linux/iommufd.h>
 
 #ifndef VFIO_PCI_PRIVATE_H
 #define VFIO_PCI_PRIVATE_H
@@ -99,6 +100,11 @@ struct vfio_pci_mmap_vma {
 	struct list_head	vma_next;
 };
 
+struct vfio_iommufd_device {
+	struct iommufd_device *idev;
+	int iommu_fd;
+};
+
 struct vfio_pci_device {
 	struct vfio_device	vdev;
 	struct pci_dev		*pdev;
@@ -144,6 +150,8 @@ struct vfio_pci_device {
 	struct list_head	vma_list;
 	struct rw_semaphore	memory_lock;
 	atomic_t		block_access;
+	struct mutex		videv_lock;
+	struct vfio_iommufd_device *videv;
 };
 
 #define is_intx(vdev) (vdev->irq_type == VFIO_PCI_INTX_IRQ_INDEX)
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index ef33ea002b0b..c902abd60339 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -190,6 +190,36 @@ struct vfio_group_status {
 
 /* --------------- IOCTLs for DEVICE file descriptors --------------- */
 
+/*
+ * VFIO_DEVICE_BIND_IOMMUFD - _IOR(VFIO_TYPE, VFIO_BASE + 19,
+ *				struct vfio_device_iommu_bind_data)
+ *
+ * Bind a vfio_device to the specified iommufd
+ *
+ * The user should provide a device cookie when calling this ioctl. The
+ * cookie is later used in iommufd for capability query, iotlb invalidation
+ * and I/O fault handling.
+ *
+ * User is not allowed to access the device before the binding operation
+ * is completed.
+ *
+ * Unbind is automatically conducted when device fd is closed.
+ *
+ * Input parameters:
+ *	- iommu_fd;
+ *	- dev_cookie;
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+struct vfio_device_iommu_bind_data {
+	__u32	argsz;
+	__u32	flags;
+	__s32	iommu_fd;
+	__u64	dev_cookie;
+};
+
+#define VFIO_DEVICE_BIND_IOMMUFD	_IO(VFIO_TYPE, VFIO_BASE + 19)
+
 /**
  * VFIO_DEVICE_GET_INFO - _IOR(VFIO_TYPE, VFIO_BASE + 7,
  *						struct vfio_device_info)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
