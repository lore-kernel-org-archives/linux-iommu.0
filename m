Return-Path: <SRS0=PYNz=OJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AFAC433F5
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:42:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8251F610CF
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8251F610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6484583B25;
	Sun, 19 Sep 2021 06:42:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6s6jia3tIcZL; Sun, 19 Sep 2021 06:42:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0834083AF0;
	Sun, 19 Sep 2021 06:42:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7A9FC0011;
	Sun, 19 Sep 2021 06:42:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C619C000D
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:42:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6761B400D1
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:42:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UJZ8jRtfPjcK for <iommu@lists.linux-foundation.org>;
 Sun, 19 Sep 2021 06:42:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 55E9640182
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:42:18 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10111"; a="222648611"
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="222648611"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2021 23:42:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="510701981"
Received: from yiliu-dev.bj.intel.com (HELO iov-dual.bj.intel.com)
 ([10.238.156.135])
 by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2021 23:42:11 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, jgg@nvidia.com, hch@lst.de,
 jasowang@redhat.com, joro@8bytes.org
Subject: [RFC 07/20] iommu/iommufd: Add iommufd_[un]bind_device()
Date: Sun, 19 Sep 2021 14:38:35 +0800
Message-Id: <20210919063848.1476776-8-yi.l.liu@intel.com>
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

Under the /dev/iommu model, iommufd provides the interface for I/O page
tables management such as dma map/unmap. However, it cannot work
independently since the device is still owned by the device-passthrough
frameworks (VFIO, vDPA, etc.) and vice versa. Device-passthrough frameworks
should build a connection between its device and the iommufd to delegate
the I/O page table management affairs to iommufd.

This patch introduces iommufd_[un]bind_device() helpers for the device-
passthrough framework to build such connection. The helper functions then
invoke iommu core (iommu_device_init/exit_user_dma()) to establish/exit
security context for the bound device. Each successfully bound device is
internally tracked by an iommufd_device object. This object is returned
to the caller for subsequent attaching operations on the device as well.

The caller should pass a user-provided cookie to mark the device in the
iommufd. Later this cookie will be used to represent the device in iommufd
uAPI, e.g. when querying device capabilities or handling per-device I/O
page faults. One alternative is to have iommufd allocate a device label
and return to the user. Either way works, but cookie is slightly preferred
per earlier discussion as it may allow the user to inject faults slightly
faster without ID->vRID lookup.

iommu_[un]bind_device() functions are only used for physical devices. Other
variants will be introduced in the future, e.g.:

-  iommu_[un]bind_device_pasid() for mdev/subdev which requires pasid granular
   DMA isolation;
-  iommu_[un]bind_sw_mdev() for sw mdev which relies on software measures
   instead of iommu to isolate DMA;

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd.c | 160 +++++++++++++++++++++++++++++++-
 include/linux/iommufd.h         |  38 ++++++++
 2 files changed, 196 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/iommufd.h

diff --git a/drivers/iommu/iommufd/iommufd.c b/drivers/iommu/iommufd/iommufd.c
index 710b7e62988b..e16ca21e4534 100644
--- a/drivers/iommu/iommufd/iommufd.c
+++ b/drivers/iommu/iommufd/iommufd.c
@@ -16,10 +16,30 @@
 #include <linux/miscdevice.h>
 #include <linux/mutex.h>
 #include <linux/iommu.h>
+#include <linux/iommufd.h>
+#include <linux/xarray.h>
+#include <asm-generic/bug.h>
 
 /* Per iommufd */
 struct iommufd_ctx {
 	refcount_t refs;
+	struct mutex lock;
+	struct xarray device_xa; /* xarray of bound devices */
+};
+
+/*
+ * A iommufd_device object represents the binding relationship
+ * between iommufd and device. It is created per a successful
+ * binding request from device driver. The bound device must be
+ * a physical device so far. Subdevice will be supported later
+ * (with additional PASID information). An user-assigned cookie
+ * is also recorded to mark the device in the /dev/iommu uAPI.
+ */
+struct iommufd_device {
+	unsigned int id;
+	struct iommufd_ctx *ictx;
+	struct device *dev; /* always be the physical device */
+	u64 dev_cookie;
 };
 
 static int iommufd_fops_open(struct inode *inode, struct file *filep)
@@ -32,15 +52,58 @@ static int iommufd_fops_open(struct inode *inode, struct file *filep)
 		return -ENOMEM;
 
 	refcount_set(&ictx->refs, 1);
+	mutex_init(&ictx->lock);
+	xa_init_flags(&ictx->device_xa, XA_FLAGS_ALLOC);
 	filep->private_data = ictx;
 
 	return ret;
 }
 
+static void iommufd_ctx_get(struct iommufd_ctx *ictx)
+{
+	refcount_inc(&ictx->refs);
+}
+
+static const struct file_operations iommufd_fops;
+
+/**
+ * iommufd_ctx_fdget - Acquires a reference to the internal iommufd context.
+ * @fd: [in] iommufd file descriptor.
+ *
+ * Returns a pointer to the iommufd context, otherwise NULL;
+ *
+ */
+static struct iommufd_ctx *iommufd_ctx_fdget(int fd)
+{
+	struct fd f = fdget(fd);
+	struct file *file = f.file;
+	struct iommufd_ctx *ictx;
+
+	if (!file)
+		return NULL;
+
+	if (file->f_op != &iommufd_fops)
+		return NULL;
+
+	ictx = file->private_data;
+	if (ictx)
+		iommufd_ctx_get(ictx);
+	fdput(f);
+	return ictx;
+}
+
+/**
+ * iommufd_ctx_put - Releases a reference to the internal iommufd context.
+ * @ictx: [in] Pointer to iommufd context.
+ *
+ */
 static void iommufd_ctx_put(struct iommufd_ctx *ictx)
 {
-	if (refcount_dec_and_test(&ictx->refs))
-		kfree(ictx);
+	if (!refcount_dec_and_test(&ictx->refs))
+		return;
+
+	WARN_ON(!xa_empty(&ictx->device_xa));
+	kfree(ictx);
 }
 
 static int iommufd_fops_release(struct inode *inode, struct file *filep)
@@ -86,6 +149,99 @@ static struct miscdevice iommu_misc_dev = {
 	.mode = 0666,
 };
 
+/**
+ * iommufd_bind_device - Bind a physical device marked by a device
+ *			 cookie to an iommu fd.
+ * @fd:		[in] iommufd file descriptor.
+ * @dev:	[in] Pointer to a physical device struct.
+ * @dev_cookie:	[in] A cookie to mark the device in /dev/iommu uAPI.
+ *
+ * A successful bind establishes a security context for the device
+ * and returns struct iommufd_device pointer. Otherwise returns
+ * error pointer.
+ *
+ */
+struct iommufd_device *iommufd_bind_device(int fd, struct device *dev,
+					   u64 dev_cookie)
+{
+	struct iommufd_ctx *ictx;
+	struct iommufd_device *idev;
+	unsigned long index;
+	unsigned int id;
+	int ret;
+
+	ictx = iommufd_ctx_fdget(fd);
+	if (!ictx)
+		return ERR_PTR(-EINVAL);
+
+	mutex_lock(&ictx->lock);
+
+	/* check duplicate registration */
+	xa_for_each(&ictx->device_xa, index, idev) {
+		if (idev->dev == dev || idev->dev_cookie == dev_cookie) {
+			idev = ERR_PTR(-EBUSY);
+			goto out_unlock;
+		}
+	}
+
+	idev = kzalloc(sizeof(*idev), GFP_KERNEL);
+	if (!idev) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
+	/* Establish the security context */
+	ret = iommu_device_init_user_dma(dev, (unsigned long)ictx);
+	if (ret)
+		goto out_free;
+
+	ret = xa_alloc(&ictx->device_xa, &id, idev,
+		       XA_LIMIT(IOMMUFD_DEVID_MIN, IOMMUFD_DEVID_MAX),
+		       GFP_KERNEL);
+	if (ret) {
+		idev = ERR_PTR(ret);
+		goto out_user_dma;
+	}
+
+	idev->ictx = ictx;
+	idev->dev = dev;
+	idev->dev_cookie = dev_cookie;
+	idev->id = id;
+	mutex_unlock(&ictx->lock);
+
+	return idev;
+out_user_dma:
+	iommu_device_exit_user_dma(idev->dev);
+out_free:
+	kfree(idev);
+out_unlock:
+	mutex_unlock(&ictx->lock);
+	iommufd_ctx_put(ictx);
+
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(iommufd_bind_device);
+
+/**
+ * iommufd_unbind_device - Unbind a physical device from iommufd
+ *
+ * @idev: [in] Pointer to the internal iommufd_device struct.
+ *
+ */
+void iommufd_unbind_device(struct iommufd_device *idev)
+{
+	struct iommufd_ctx *ictx = idev->ictx;
+
+	mutex_lock(&ictx->lock);
+	xa_erase(&ictx->device_xa, idev->id);
+	mutex_unlock(&ictx->lock);
+	/* Exit the security context */
+	iommu_device_exit_user_dma(idev->dev);
+	kfree(idev);
+	iommufd_ctx_put(ictx);
+}
+EXPORT_SYMBOL_GPL(iommufd_unbind_device);
+
 static int __init iommufd_init(void)
 {
 	int ret;
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
new file mode 100644
index 000000000000..1603a13937e9
--- /dev/null
+++ b/include/linux/iommufd.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * IOMMUFD API definition
+ *
+ * Copyright (C) 2021 Intel Corporation
+ *
+ * Author: Liu Yi L <yi.l.liu@intel.com>
+ */
+#ifndef __LINUX_IOMMUFD_H
+#define __LINUX_IOMMUFD_H
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/device.h>
+
+#define IOMMUFD_DEVID_MAX	((unsigned int)(0x7FFFFFFF))
+#define IOMMUFD_DEVID_MIN	0
+
+struct iommufd_device;
+
+#if IS_ENABLED(CONFIG_IOMMUFD)
+struct iommufd_device *
+iommufd_bind_device(int fd, struct device *dev, u64 dev_cookie);
+void iommufd_unbind_device(struct iommufd_device *idev);
+
+#else /* !CONFIG_IOMMUFD */
+static inline struct iommufd_device *
+iommufd_bind_device(int fd, struct device *dev, u64 dev_cookie)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline void iommufd_unbind_device(struct iommufd_device *idev)
+{
+}
+#endif /* CONFIG_IOMMUFD */
+#endif /* __LINUX_IOMMUFD_H */
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
