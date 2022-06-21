Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F85C433EF
	for <iommu@archiver.kernel.org>; Tue, 21 Jun 2022 14:48:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6582860DA5;
	Tue, 21 Jun 2022 14:48:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6582860DA5
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mAtz7G9I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 30JVKOhmeDnx; Tue, 21 Jun 2022 14:48:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 882FB60D87;
	Tue, 21 Jun 2022 14:48:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 882FB60D87
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3EC90C0039;
	Tue, 21 Jun 2022 14:48:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF047C002D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 14:48:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A216D83F69
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 14:48:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A216D83F69
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=mAtz7G9I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2CbscIoJMMs4 for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 14:48:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 680B383F67
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 680B383F67
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 14:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655822892; x=1687358892;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=94P/M6zY35Hbp1ad0YH4YbldOnp70bxJt+frPbZ+6yw=;
 b=mAtz7G9IXC8CinJKaWwF6A/QzaVMZSufMda/SWGM/XGxixEcdfJzmr2g
 la28YNkhiN1eGMRo+v83qgpdEQF+9aES+UjnwRHp4NNcevn9i7zfWp9Ls
 LmnLdm8WUcom27TQSLaLKZnqZV23EU1WAxwE0mL0jzUaCIwixkEog5XlV
 9I6iyZzfazdmHiLiaA7DBzj/6p9sY++3At7XFyQWQy1KYmD7oPacRAKJk
 yWmY28iamFo/8f7UR8pa4ILA1J7jjZjaocoUejSff9DN83s07LBZg4p3X
 yzl+UIafeFpils63OZXgOmwP5qk0blL/29ZVZRt3F/MAeW3FG3LhHdBoW g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="280867073"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; d="scan'208";a="280867073"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2022 07:48:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; d="scan'208";a="643659224"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga008.fm.intel.com with ESMTP; 21 Jun 2022 07:48:08 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v9 02/11] iommu: Add max_pasids field in struct dev_iommu
Date: Tue, 21 Jun 2022 22:43:44 +0800
Message-Id: <20220621144353.17547-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220621144353.17547-1-baolu.lu@linux.intel.com>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>
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

Use this field to save the number of PASIDs that a device is able to
consume. It is a generic attribute of a device and lifting it into the
per-device dev_iommu struct could help to avoid the boilerplate code
in various IOMMU drivers.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h |  2 ++
 drivers/iommu/iommu.c | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 03fbb1b71536..d50afb2c9a09 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -364,6 +364,7 @@ struct iommu_fault_param {
  * @fwspec:	 IOMMU fwspec data
  * @iommu_dev:	 IOMMU device this device is linked to
  * @priv:	 IOMMU Driver private data
+ * @max_pasids:  number of PASIDs device can consume
  *
  * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
  *	struct iommu_group	*iommu_group;
@@ -375,6 +376,7 @@ struct dev_iommu {
 	struct iommu_fwspec		*fwspec;
 	struct iommu_device		*iommu_dev;
 	void				*priv;
+	u32				max_pasids;
 };
 
 int iommu_device_register(struct iommu_device *iommu,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 847ad47a2dfd..6b731568efff 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -20,6 +20,7 @@
 #include <linux/idr.h>
 #include <linux/err.h>
 #include <linux/pci.h>
+#include <linux/pci-ats.h>
 #include <linux/bitops.h>
 #include <linux/property.h>
 #include <linux/fsl/mc.h>
@@ -218,6 +219,24 @@ static void dev_iommu_free(struct device *dev)
 	kfree(param);
 }
 
+static u32 dev_iommu_get_max_pasids(struct device *dev)
+{
+	u32 max_pasids = 0, bits = 0;
+	int ret;
+
+	if (dev_is_pci(dev)) {
+		ret = pci_max_pasids(to_pci_dev(dev));
+		if (ret > 0)
+			max_pasids = ret;
+	} else {
+		ret = device_property_read_u32(dev, "pasid-num-bits", &bits);
+		if (!ret)
+			max_pasids = 1UL << bits;
+	}
+
+	return min_t(u32, max_pasids, dev->iommu->iommu_dev->max_pasids);
+}
+
 static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
@@ -243,6 +262,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	}
 
 	dev->iommu->iommu_dev = iommu_dev;
+	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
 
 	group = iommu_group_get_for_dev(dev);
 	if (IS_ERR(group)) {
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
