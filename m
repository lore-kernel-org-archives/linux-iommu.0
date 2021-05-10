Return-Path: <SRS0=b4g5=KF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80030C43603
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 14:22:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34A7361494
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 14:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A7361494
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B54EE40634;
	Mon, 10 May 2021 14:22:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ql8JOh02TeTC; Mon, 10 May 2021 14:22:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3379140E73;
	Mon, 10 May 2021 14:22:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3F26C0024;
	Mon, 10 May 2021 14:22:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4DC3C0031
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 14:22:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 725A860BE2
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 14:22:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nUfi_Io967tH for <iommu@lists.linux-foundation.org>;
 Mon, 10 May 2021 14:22:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 210DA605DE
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 14:22:39 +0000 (UTC)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Ff39B4pCWz1BKvy;
 Mon, 10 May 2021 22:19:58 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 22:22:28 +0800
From: John Garry <john.garry@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
 <hch@lst.de>, <m.szyprowski@samsung.com>
Subject: [PATCH v2 12/15] iommu: Add iommu_set_dev_dma_opt_size()
Date: Mon, 10 May 2021 22:17:26 +0800
Message-ID: <1620656249-68890-13-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1620656249-68890-1-git-send-email-john.garry@huawei.com>
References: <1620656249-68890-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Cc: linux-scsi@vger.kernel.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, sai.praneeth.prakhya@intel.com,
 iommu@lists.linux-foundation.org
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

Add a function which allows the max optimised IOMMU DMA size to be set.

When set successfully, return -EPROBE_DEFER to inform the caller that the
device driver needs to be reprobed to take effect.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iommu.c | 47 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h |  7 +++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index bdb9aa47dfca..263d78e26c48 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3058,6 +3058,53 @@ u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 }
 EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
 
+int iommu_set_dev_dma_opt_size(struct device *dev, size_t size)
+{
+	struct iommu_group *group = iommu_group_get(dev);
+	struct group_device *grp_dev;
+	struct device *_dev;
+	int ret, group_count;
+
+	if (!group)
+		return 0;
+
+	mutex_lock(&group->mutex);
+
+	/*
+	 * If already set, then ignore. We may have been set via sysfs, so
+	 * honour that.
+	 */
+	if (group->max_opt_dma_size) {
+		ret = 0;
+		goto out;
+	}
+
+	group_count = iommu_group_device_count(group);
+	if (group_count != 1) {
+		dev_err_ratelimited(dev, "Cannot change DMA opt size: Group has more than one device group_count=%d\n",
+				    group_count);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Since group has only one device */
+	grp_dev = list_first_entry(&group->devices, struct group_device, list);
+	_dev = grp_dev->dev;
+
+	if (_dev != dev) {
+		dev_err_ratelimited(dev, "Cannot set DMA max opt size - device has changed\n");
+		ret = -EBUSY;
+		goto out;
+	}
+
+	group->max_opt_dma_size = size;
+	ret = -EPROBE_DEFER;
+out:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+	return ret;
+}
+
 /*
  * Changes the default domain of an iommu group that has *only* one device
  *
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 6e187746af0f..36871e8ae636 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -428,6 +428,7 @@ extern void iommu_get_resv_regions(struct device *dev, struct list_head *list);
 extern void iommu_put_resv_regions(struct device *dev, struct list_head *list);
 extern void generic_iommu_put_resv_regions(struct device *dev,
 					   struct list_head *list);
+extern int iommu_set_dev_dma_opt_size(struct device *dev, size_t size);
 extern void iommu_set_default_passthrough(bool cmd_line);
 extern void iommu_set_default_translated(bool cmd_line);
 extern bool iommu_default_passthrough(void);
@@ -740,6 +741,12 @@ static inline int iommu_get_group_resv_regions(struct iommu_group *group,
 	return -ENODEV;
 }
 
+static inline int iommu_set_dev_dma_opt_size(struct device *dev,
+						 size_t size)
+{
+	return -ENODEV;
+}
+
 static inline void iommu_set_default_passthrough(bool cmd_line)
 {
 }
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
