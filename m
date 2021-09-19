Return-Path: <SRS0=PYNz=OJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966BFC433FE
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:41:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51DC761074
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 51DC761074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0C9F940182;
	Sun, 19 Sep 2021 06:41:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FmM_PomSD5Qx; Sun, 19 Sep 2021 06:41:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A28104018F;
	Sun, 19 Sep 2021 06:41:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72E39C0011;
	Sun, 19 Sep 2021 06:41:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5ECD5C000D
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:41:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5BE0A83842
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:41:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6cCcgkFWJ3hl for <iommu@lists.linux-foundation.org>;
 Sun, 19 Sep 2021 06:41:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 69D7A837AC
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:41:37 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10111"; a="223030121"
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="223030121"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2021 23:41:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="510701852"
Received: from yiliu-dev.bj.intel.com (HELO iov-dual.bj.intel.com)
 ([10.238.156.135])
 by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2021 23:41:29 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, jgg@nvidia.com, hch@lst.de,
 jasowang@redhat.com, joro@8bytes.org
Subject: [RFC 01/20] iommu/iommufd: Add /dev/iommu core
Date: Sun, 19 Sep 2021 14:38:29 +0800
Message-Id: <20210919063848.1476776-2-yi.l.liu@intel.com>
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

/dev/iommu aims to provide a unified interface for managing I/O address
spaces for devices assigned to userspace. This patch adds the initial
framework to create a /dev/iommu node. Each open of this node returns an
iommufd. And this fd is the handle for userspace to initiate its I/O
address space management.

One open:
- We call this feature as IOMMUFD in Kconfig in this RFC. However this
  name is not clear enough to indicate its purpose to user. Back to 2010
  vfio even introduced a /dev/uiommu [1] as the predecessor of its
  container concept. Is that a better name? Appreciate opinions here.

[1] https://lore.kernel.org/kvm/4c0eb470.1HMjondO00NIvFM6%25pugs@cisco.com/

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/Kconfig           |   1 +
 drivers/iommu/Makefile          |   1 +
 drivers/iommu/iommufd/Kconfig   |  11 ++++
 drivers/iommu/iommufd/Makefile  |   2 +
 drivers/iommu/iommufd/iommufd.c | 112 ++++++++++++++++++++++++++++++++
 5 files changed, 127 insertions(+)
 create mode 100644 drivers/iommu/iommufd/Kconfig
 create mode 100644 drivers/iommu/iommufd/Makefile
 create mode 100644 drivers/iommu/iommufd/iommufd.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 07b7c25cbed8..a83ce0acd09d 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -136,6 +136,7 @@ config MSM_IOMMU
 
 source "drivers/iommu/amd/Kconfig"
 source "drivers/iommu/intel/Kconfig"
+source "drivers/iommu/iommufd/Kconfig"
 
 config IRQ_REMAP
 	bool "Support for Interrupt Remapping"
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index c0fb0ba88143..719c799f23ad 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -29,3 +29,4 @@ obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
 obj-$(CONFIG_IOMMU_SVA_LIB) += iommu-sva-lib.o io-pgfault.o
 obj-$(CONFIG_SPRD_IOMMU) += sprd-iommu.o
+obj-$(CONFIG_IOMMUFD) += iommufd/
diff --git a/drivers/iommu/iommufd/Kconfig b/drivers/iommu/iommufd/Kconfig
new file mode 100644
index 000000000000..9fb7769a815d
--- /dev/null
+++ b/drivers/iommu/iommufd/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config IOMMUFD
+	tristate "I/O Address Space management framework for passthrough devices"
+	select IOMMU_API
+	default n
+	help
+	  provides unified I/O address space management framework for
+	  isolating untrusted DMAs via devices which are passed through
+	  to userspace drivers.
+
+	  If you don't know what to do here, say N.
diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
new file mode 100644
index 000000000000..54381a01d003
--- /dev/null
+++ b/drivers/iommu/iommufd/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_IOMMUFD) += iommufd.o
diff --git a/drivers/iommu/iommufd/iommufd.c b/drivers/iommu/iommufd/iommufd.c
new file mode 100644
index 000000000000..710b7e62988b
--- /dev/null
+++ b/drivers/iommu/iommufd/iommufd.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * I/O Address Space Management for passthrough devices
+ *
+ * Copyright (C) 2021 Intel Corporation
+ *
+ * Author: Liu Yi L <yi.l.liu@intel.com>
+ */
+
+#define pr_fmt(fmt)    "iommufd: " fmt
+
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/miscdevice.h>
+#include <linux/mutex.h>
+#include <linux/iommu.h>
+
+/* Per iommufd */
+struct iommufd_ctx {
+	refcount_t refs;
+};
+
+static int iommufd_fops_open(struct inode *inode, struct file *filep)
+{
+	struct iommufd_ctx *ictx;
+	int ret = 0;
+
+	ictx = kzalloc(sizeof(*ictx), GFP_KERNEL);
+	if (!ictx)
+		return -ENOMEM;
+
+	refcount_set(&ictx->refs, 1);
+	filep->private_data = ictx;
+
+	return ret;
+}
+
+static void iommufd_ctx_put(struct iommufd_ctx *ictx)
+{
+	if (refcount_dec_and_test(&ictx->refs))
+		kfree(ictx);
+}
+
+static int iommufd_fops_release(struct inode *inode, struct file *filep)
+{
+	struct iommufd_ctx *ictx = filep->private_data;
+
+	filep->private_data = NULL;
+
+	iommufd_ctx_put(ictx);
+
+	return 0;
+}
+
+static long iommufd_fops_unl_ioctl(struct file *filep,
+				   unsigned int cmd, unsigned long arg)
+{
+	struct iommufd_ctx *ictx = filep->private_data;
+	long ret = -EINVAL;
+
+	if (!ictx)
+		return ret;
+
+	switch (cmd) {
+	default:
+		pr_err_ratelimited("unsupported cmd %u\n", cmd);
+		break;
+	}
+	return ret;
+}
+
+static const struct file_operations iommufd_fops = {
+	.owner		= THIS_MODULE,
+	.open		= iommufd_fops_open,
+	.release	= iommufd_fops_release,
+	.unlocked_ioctl	= iommufd_fops_unl_ioctl,
+};
+
+static struct miscdevice iommu_misc_dev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "iommu",
+	.fops = &iommufd_fops,
+	.nodename = "iommu",
+	.mode = 0666,
+};
+
+static int __init iommufd_init(void)
+{
+	int ret;
+
+	ret = misc_register(&iommu_misc_dev);
+	if (ret) {
+		pr_err("failed to register misc device\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __exit iommufd_exit(void)
+{
+	misc_deregister(&iommu_misc_dev);
+}
+
+module_init(iommufd_init);
+module_exit(iommufd_exit);
+
+MODULE_AUTHOR("Liu Yi L <yi.l.liu@intel.com>");
+MODULE_DESCRIPTION("I/O Address Space Management for passthrough devices");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
