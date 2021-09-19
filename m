Return-Path: <SRS0=PYNz=OJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCA9C433F5
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:42:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2375D61074
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2375D61074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 034AD83B25;
	Sun, 19 Sep 2021 06:42:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hiQ81aXtcahk; Sun, 19 Sep 2021 06:42:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E01BA837AC;
	Sun, 19 Sep 2021 06:42:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA567C0011;
	Sun, 19 Sep 2021 06:42:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F345C000D
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:42:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 41D0F40500
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:42:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7UhTLkEJW66D for <iommu@lists.linux-foundation.org>;
 Sun, 19 Sep 2021 06:42:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B298A404E7
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:42:51 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10111"; a="245397278"
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="245397278"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2021 23:42:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="510702058"
Received: from yiliu-dev.bj.intel.com (HELO iov-dual.bj.intel.com)
 ([10.238.156.135])
 by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2021 23:42:44 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, jgg@nvidia.com, hch@lst.de,
 jasowang@redhat.com, joro@8bytes.org
Subject: [RFC 12/20] iommu/iommufd: Add IOMMU_CHECK_EXTENSION
Date: Sun, 19 Sep 2021 14:38:40 +0800
Message-Id: <20210919063848.1476776-13-yi.l.liu@intel.com>
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

As aforementioned, userspace should check extension for what formats
can be specified when allocating an IOASID. This patch adds such
interface for userspace. In this RFC, iommufd reports EXT_MAP_TYPE1V2
support and no no-snoop support yet.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd.c |  7 +++++++
 include/uapi/linux/iommu.h      | 27 +++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd.c b/drivers/iommu/iommufd/iommufd.c
index 4839f128b24a..e45d76359e34 100644
--- a/drivers/iommu/iommufd/iommufd.c
+++ b/drivers/iommu/iommufd/iommufd.c
@@ -306,6 +306,13 @@ static long iommufd_fops_unl_ioctl(struct file *filep,
 		return ret;
 
 	switch (cmd) {
+	case IOMMU_CHECK_EXTENSION:
+		switch (arg) {
+		case EXT_MAP_TYPE1V2:
+			return 1;
+		default:
+			return 0;
+		}
 	case IOMMU_DEVICE_GET_INFO:
 		ret = iommufd_get_device_info(ictx, arg);
 		break;
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index 5cbd300eb0ee..49731be71213 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -14,6 +14,33 @@
 #define IOMMU_TYPE	(';')
 #define IOMMU_BASE	100
 
+/*
+ * IOMMU_CHECK_EXTENSION - _IO(IOMMU_TYPE, IOMMU_BASE + 0)
+ *
+ * Check whether an uAPI extension is supported.
+ *
+ * It's unlikely that all planned capabilities in IOMMU fd will be ready
+ * in one breath. User should check which uAPI extension is supported
+ * according to its intended usage.
+ *
+ * A rough list of possible extensions may include:
+ *
+ *	- EXT_MAP_TYPE1V2 for vfio type1v2 map semantics;
+ *	- EXT_DMA_NO_SNOOP for no-snoop DMA support;
+ *	- EXT_MAP_NEWTYPE for an enhanced map semantics;
+ *	- EXT_MULTIDEV_GROUP for 1:N iommu group;
+ *	- EXT_IOASID_NESTING for what the name stands;
+ *	- EXT_USER_PAGE_TABLE for user managed page table;
+ *	- EXT_USER_PASID_TABLE for user managed PASID table;
+ *	- EXT_DIRTY_TRACKING for tracking pages dirtied by DMA;
+ *	- ...
+ *
+ * Return: 0 if not supported, 1 if supported.
+ */
+#define EXT_MAP_TYPE1V2		1
+#define EXT_DMA_NO_SNOOP	2
+#define IOMMU_CHECK_EXTENSION	_IO(IOMMU_TYPE, IOMMU_BASE + 0)
+
 /*
  * IOMMU_DEVICE_GET_INFO - _IOR(IOMMU_TYPE, IOMMU_BASE + 1,
  *				struct iommu_device_info)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
