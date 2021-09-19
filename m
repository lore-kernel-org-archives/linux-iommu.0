Return-Path: <SRS0=PYNz=OJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DE4C433EF
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:42:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2288561076
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2288561076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E90F1401B1;
	Sun, 19 Sep 2021 06:42:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M9hTDJTaUSP8; Sun, 19 Sep 2021 06:42:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 88C38400D1;
	Sun, 19 Sep 2021 06:42:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7016BC0011;
	Sun, 19 Sep 2021 06:42:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99C02C000D
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:42:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 954AE83842
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:42:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9KH9c5LXt2ne for <iommu@lists.linux-foundation.org>;
 Sun, 19 Sep 2021 06:42:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D8B4F837C0
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:42:38 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10111"; a="210081677"
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="210081677"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2021 23:42:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="510702025"
Received: from yiliu-dev.bj.intel.com (HELO iov-dual.bj.intel.com)
 ([10.238.156.135])
 by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2021 23:42:31 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, jgg@nvidia.com, hch@lst.de,
 jasowang@redhat.com, joro@8bytes.org
Subject: [RFC 10/20] iommu/iommufd: Add IOMMU_DEVICE_GET_INFO
Date: Sun, 19 Sep 2021 14:38:38 +0800
Message-Id: <20210919063848.1476776-11-yi.l.liu@intel.com>
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

After a device is bound to the iommufd, userspace can use this interface
to query the underlying iommu capability and format info for this device.
Based on this information the user then creates I/O address space in a
compatible format with the to-be-attached devices.

Device cookie which is registered at binding time is used to mark the
device which is being queried here.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd.c | 68 +++++++++++++++++++++++++++++++++
 include/uapi/linux/iommu.h      | 49 ++++++++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd.c b/drivers/iommu/iommufd/iommufd.c
index e16ca21e4534..641f199f2d41 100644
--- a/drivers/iommu/iommufd/iommufd.c
+++ b/drivers/iommu/iommufd/iommufd.c
@@ -117,6 +117,71 @@ static int iommufd_fops_release(struct inode *inode, struct file *filep)
 	return 0;
 }
 
+static struct device *
+iommu_find_device_from_cookie(struct iommufd_ctx *ictx, u64 dev_cookie)
+{
+	struct iommufd_device *idev;
+	struct device *dev = NULL;
+	unsigned long index;
+
+	mutex_lock(&ictx->lock);
+	xa_for_each(&ictx->device_xa, index, idev) {
+		if (idev->dev_cookie == dev_cookie) {
+			dev = idev->dev;
+			break;
+		}
+	}
+	mutex_unlock(&ictx->lock);
+
+	return dev;
+}
+
+static void iommu_device_build_info(struct device *dev,
+				    struct iommu_device_info *info)
+{
+	bool snoop;
+	u64 awidth, pgsizes;
+
+	if (!iommu_device_get_info(dev, IOMMU_DEV_INFO_FORCE_SNOOP, &snoop))
+		info->flags |= snoop ? IOMMU_DEVICE_INFO_ENFORCE_SNOOP : 0;
+
+	if (!iommu_device_get_info(dev, IOMMU_DEV_INFO_PAGE_SIZE, &pgsizes)) {
+		info->pgsize_bitmap = pgsizes;
+		info->flags |= IOMMU_DEVICE_INFO_PGSIZES;
+	}
+
+	if (!iommu_device_get_info(dev, IOMMU_DEV_INFO_ADDR_WIDTH, &awidth)) {
+		info->addr_width = awidth;
+		info->flags |= IOMMU_DEVICE_INFO_ADDR_WIDTH;
+	}
+}
+
+static int iommufd_get_device_info(struct iommufd_ctx *ictx,
+				   unsigned long arg)
+{
+	struct iommu_device_info info;
+	unsigned long minsz;
+	struct device *dev;
+
+	minsz = offsetofend(struct iommu_device_info, addr_width);
+
+	if (copy_from_user(&info, (void __user *)arg, minsz))
+		return -EFAULT;
+
+	if (info.argsz < minsz)
+		return -EINVAL;
+
+	info.flags = 0;
+
+	dev = iommu_find_device_from_cookie(ictx, info.dev_cookie);
+	if (!dev)
+		return -EINVAL;
+
+	iommu_device_build_info(dev, &info);
+
+	return copy_to_user((void __user *)arg, &info, minsz) ? -EFAULT : 0;
+}
+
 static long iommufd_fops_unl_ioctl(struct file *filep,
 				   unsigned int cmd, unsigned long arg)
 {
@@ -127,6 +192,9 @@ static long iommufd_fops_unl_ioctl(struct file *filep,
 		return ret;
 
 	switch (cmd) {
+	case IOMMU_DEVICE_GET_INFO:
+		ret = iommufd_get_device_info(ictx, arg);
+		break;
 	default:
 		pr_err_ratelimited("unsupported cmd %u\n", cmd);
 		break;
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index 59178fc229ca..76b71f9d6b34 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -7,6 +7,55 @@
 #define _UAPI_IOMMU_H
 
 #include <linux/types.h>
+#include <linux/ioctl.h>
+
+/* -------- IOCTLs for IOMMU file descriptor (/dev/iommu) -------- */
+
+#define IOMMU_TYPE	(';')
+#define IOMMU_BASE	100
+
+/*
+ * IOMMU_DEVICE_GET_INFO - _IOR(IOMMU_TYPE, IOMMU_BASE + 1,
+ *				struct iommu_device_info)
+ *
+ * Check IOMMU capabilities and format information on a bound device.
+ *
+ * The device is identified by device cookie (registered when binding
+ * this device).
+ *
+ * @argsz:	   user filled size of this data.
+ * @flags:	   tells userspace which capability info is available
+ * @dev_cookie:	   user assinged cookie.
+ * @pgsize_bitmap: Bitmap of supported page sizes. 1-setting of the
+ *		   bit in pgsize_bitmap[63:12] indicates a supported
+ *		   page size. Details as below table:
+ *
+ *		   +===============+============+
+ *		   |  Bit[index]   |  Page Size |
+ *		   +---------------+------------+
+ *		   |  12           |  4 KB      |
+ *		   +---------------+------------+
+ *		   |  13           |  8 KB      |
+ *		   +---------------+------------+
+ *		   |  14           |  16 KB     |
+ *		   +---------------+------------+
+ *		   ...
+ * @addr_width:    the address width of supported I/O address spaces.
+ *
+ * Availability: after device is bound to iommufd
+ */
+struct iommu_device_info {
+	__u32	argsz;
+	__u32	flags;
+#define IOMMU_DEVICE_INFO_ENFORCE_SNOOP	(1 << 0) /* IOMMU enforced snoop */
+#define IOMMU_DEVICE_INFO_PGSIZES	(1 << 1) /* supported page sizes */
+#define IOMMU_DEVICE_INFO_ADDR_WIDTH	(1 << 2) /* addr_wdith field valid */
+	__u64	dev_cookie;
+	__u64   pgsize_bitmap;
+	__u32	addr_width;
+};
+
+#define IOMMU_DEVICE_GET_INFO	_IO(IOMMU_TYPE, IOMMU_BASE + 1)
 
 #define IOMMU_FAULT_PERM_READ	(1 << 0) /* read */
 #define IOMMU_FAULT_PERM_WRITE	(1 << 1) /* write */
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
