Return-Path: <SRS0=b4g5=KF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848BEC43462
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 14:22:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33CD2611BD
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 14:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33CD2611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80E5C40649;
	Mon, 10 May 2021 14:22:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NzZ_yRXWIM-j; Mon, 10 May 2021 14:22:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B27C40E6F;
	Mon, 10 May 2021 14:22:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60130C002D;
	Mon, 10 May 2021 14:22:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7DF5C0001
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 14:22:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8FBB140538
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 14:22:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q1htSItGJEYz for <iommu@lists.linux-foundation.org>;
 Mon, 10 May 2021 14:22:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E9213404F7
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 14:22:38 +0000 (UTC)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Ff39B4WTgz1BKvs;
 Mon, 10 May 2021 22:19:58 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 22:22:26 +0800
From: John Garry <john.garry@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
 <hch@lst.de>, <m.szyprowski@samsung.com>
Subject: [PATCH v2 07/15] iommu: Add iommu_realloc_dev_group()
Date: Mon, 10 May 2021 22:17:21 +0800
Message-ID: <1620656249-68890-8-git-send-email-john.garry@huawei.com>
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

Add a function to re-alloc IOMMU group default domain.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iommu.c | 12 ++++++++++++
 include/linux/iommu.h |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f7253a973ab9..bdb9aa47dfca 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3191,6 +3191,18 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	return ret;
 }
 
+int iommu_realloc_dev_group(struct device *dev)
+{
+	struct iommu_group *group;
+	int ret;
+
+	group = iommu_group_get(dev);
+	ret = iommu_change_dev_def_domain(group, dev, 0, true);
+	iommu_group_put(group);
+
+	return ret;
+}
+
 /*
  * Changing the default domain or any other IOMMU group attribute through sysfs
  * requires the users to unbind the drivers from the devices in the IOMMU group.
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e26abda94792..6e187746af0f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -482,6 +482,7 @@ bool iommu_get_dma_strict(struct iommu_domain *domain);
 
 extern int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
 			      unsigned long iova, int flags);
+extern int iommu_realloc_dev_group(struct device *dev);
 
 static inline void iommu_flush_iotlb_all(struct iommu_domain *domain)
 {
@@ -699,6 +700,11 @@ static inline size_t iommu_map_sg_atomic(struct iommu_domain *domain,
 	return 0;
 }
 
+static inline int iommu_realloc_dev_group(struct device *dev)
+{
+	return -ENODEV;
+}
+
 static inline void iommu_flush_iotlb_all(struct iommu_domain *domain)
 {
 }
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
