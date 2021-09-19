Return-Path: <SRS0=PYNz=OJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D13C433EF
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:43:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0117760F51
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0117760F51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D23AB404FB;
	Sun, 19 Sep 2021 06:43:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RwJn-ML4Do7P; Sun, 19 Sep 2021 06:43:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 86A4E404E7;
	Sun, 19 Sep 2021 06:43:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 642FCC0011;
	Sun, 19 Sep 2021 06:43:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2BEFC000D
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:43:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9160040182
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:43:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bG3cVbiVWV8y for <iommu@lists.linux-foundation.org>;
 Sun, 19 Sep 2021 06:43:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 93029400D1
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:43:12 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10111"; a="284011118"
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="284011118"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2021 23:43:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="510702110"
Received: from yiliu-dev.bj.intel.com (HELO iov-dual.bj.intel.com)
 ([10.238.156.135])
 by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2021 23:43:05 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, jgg@nvidia.com, hch@lst.de,
 jasowang@redhat.com, joro@8bytes.org
Subject: [RFC 15/20] vfio/pci: Add VFIO_DEVICE_[DE]ATTACH_IOASID
Date: Sun, 19 Sep 2021 14:38:43 +0800
Message-Id: <20210919063848.1476776-16-yi.l.liu@intel.com>
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

This patch adds interface for userspace to attach device to specified
IOASID.

Note:
One device can only be attached to one IOASID in this version. This is
on par with what vfio provides today. In the future this restriction can
be relaxed when multiple I/O address spaces are supported per device

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/vfio/pci/vfio_pci.c         | 82 +++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_private.h |  1 +
 include/linux/iommufd.h             |  1 +
 include/uapi/linux/vfio.h           | 26 +++++++++
 4 files changed, 110 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 20006bb66430..5b1fda333122 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -557,6 +557,11 @@ static void vfio_pci_release(struct vfio_device *core_vdev)
 		if (vdev->videv) {
 			struct vfio_iommufd_device *videv = vdev->videv;
 
+			if (videv->ioasid != IOMMUFD_INVALID_IOASID) {
+				iommufd_device_detach_ioasid(videv->idev,
+							     videv->ioasid);
+				videv->ioasid = IOMMUFD_INVALID_IOASID;
+			}
 			vdev->videv = NULL;
 			iommufd_unbind_device(videv->idev);
 			kfree(videv);
@@ -839,6 +844,7 @@ static long vfio_pci_ioctl(struct vfio_device *core_vdev,
 		}
 		videv->idev = idev;
 		videv->iommu_fd = bind_data.iommu_fd;
+		videv->ioasid = IOMMUFD_INVALID_IOASID;
 		/*
 		 * A security context has been established. Unblock
 		 * user access.
@@ -848,6 +854,82 @@ static long vfio_pci_ioctl(struct vfio_device *core_vdev,
 		vdev->videv = videv;
 		mutex_unlock(&vdev->videv_lock);
 
+		return 0;
+	} else if (cmd == VFIO_DEVICE_ATTACH_IOASID) {
+		struct vfio_device_attach_ioasid attach;
+		unsigned long minsz;
+		struct vfio_iommufd_device *videv;
+		int ret = 0;
+
+		/* not allowed if the device is opened in legacy interface */
+		if (vfio_device_in_container(core_vdev))
+			return -ENOTTY;
+
+		minsz = offsetofend(struct vfio_device_attach_ioasid, ioasid);
+		if (copy_from_user(&attach, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (attach.argsz < minsz || attach.flags ||
+		    attach.iommu_fd < 0 || attach.ioasid < 0)
+			return -EINVAL;
+
+		mutex_lock(&vdev->videv_lock);
+
+		videv = vdev->videv;
+		if (!videv || videv->iommu_fd != attach.iommu_fd) {
+			mutex_unlock(&vdev->videv_lock);
+			return -EINVAL;
+		}
+
+		/* Currently only allows one IOASID attach */
+		if (videv->ioasid != IOMMUFD_INVALID_IOASID) {
+			mutex_unlock(&vdev->videv_lock);
+			return -EBUSY;
+		}
+
+		ret = __pci_iommufd_device_attach_ioasid(vdev->pdev,
+							 videv->idev,
+							 attach.ioasid);
+		if (!ret)
+			videv->ioasid = attach.ioasid;
+		mutex_unlock(&vdev->videv_lock);
+
+		return ret;
+	} else if (cmd == VFIO_DEVICE_DETACH_IOASID) {
+		struct vfio_device_attach_ioasid attach;
+		unsigned long minsz;
+		struct vfio_iommufd_device *videv;
+
+		/* not allowed if the device is opened in legacy interface */
+		if (vfio_device_in_container(core_vdev))
+			return -ENOTTY;
+
+		minsz = offsetofend(struct vfio_device_attach_ioasid, ioasid);
+		if (copy_from_user(&attach, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (attach.argsz < minsz || attach.flags ||
+		    attach.iommu_fd < 0 || attach.ioasid < 0)
+			return -EINVAL;
+
+		mutex_lock(&vdev->videv_lock);
+
+		videv = vdev->videv;
+		if (!videv || videv->iommu_fd != attach.iommu_fd) {
+			mutex_unlock(&vdev->videv_lock);
+			return -EINVAL;
+		}
+
+		if (videv->ioasid == IOMMUFD_INVALID_IOASID ||
+		    videv->ioasid != attach.ioasid) {
+			mutex_unlock(&vdev->videv_lock);
+			return -EINVAL;
+		}
+
+		videv->ioasid = IOMMUFD_INVALID_IOASID;
+		iommufd_device_detach_ioasid(videv->idev, attach.ioasid);
+		mutex_unlock(&vdev->videv_lock);
+
 		return 0;
 	} else if (cmd == VFIO_DEVICE_GET_INFO) {
 		struct vfio_device_info info;
diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
index bd784accac35..daa0f08ac835 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -103,6 +103,7 @@ struct vfio_pci_mmap_vma {
 struct vfio_iommufd_device {
 	struct iommufd_device *idev;
 	int iommu_fd;
+	int ioasid;
 };
 
 struct vfio_pci_device {
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 01a4fe934143..36d8d2fd22bb 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -17,6 +17,7 @@
 
 #define IOMMUFD_IOASID_MAX	((unsigned int)(0x7FFFFFFF))
 #define IOMMUFD_IOASID_MIN	0
+#define IOMMUFD_INVALID_IOASID	-1
 
 #define IOMMUFD_DEVID_MAX	((unsigned int)(0x7FFFFFFF))
 #define IOMMUFD_DEVID_MIN	0
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index c902abd60339..61493ab03038 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -220,6 +220,32 @@ struct vfio_device_iommu_bind_data {
 
 #define VFIO_DEVICE_BIND_IOMMUFD	_IO(VFIO_TYPE, VFIO_BASE + 19)
 
+/*
+ * VFIO_DEVICE_ATTACH_IOASID - _IOW(VFIO_TYPE, VFIO_BASE + 21,
+ *				struct vfio_device_attach_ioasid)
+ *
+ * Attach a vfio device to the specified IOASID
+ *
+ * Multiple vfio devices can be attached to the same IOASID. One device can
+ * be attached to only one ioasid at this point.
+ *
+ * @argsz:	user filled size of this data.
+ * @flags:	reserved for future extension.
+ * @iommu_fd:	iommufd where the ioasid comes from.
+ * @ioasid:	target I/O address space.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+struct vfio_device_attach_ioasid {
+	__u32	argsz;
+	__u32	flags;
+	__s32	iommu_fd;
+	__s32	ioasid;
+};
+
+#define VFIO_DEVICE_ATTACH_IOASID	_IO(VFIO_TYPE, VFIO_BASE + 20)
+#define VFIO_DEVICE_DETACH_IOASID	_IO(VFIO_TYPE, VFIO_BASE + 21)
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
