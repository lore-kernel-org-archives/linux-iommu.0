Return-Path: <SRS0=b4g5=KF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69FDC43461
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 14:22:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E503611BF
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 14:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E503611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7109C842CA;
	Mon, 10 May 2021 14:22:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hwC2nItAaRbH; Mon, 10 May 2021 14:22:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C54C842F1;
	Mon, 10 May 2021 14:22:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D926FC002E;
	Mon, 10 May 2021 14:22:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E830C0001
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 14:22:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8CA1040E70
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 14:22:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 28IQYePFigFa for <iommu@lists.linux-foundation.org>;
 Mon, 10 May 2021 14:22:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AD3A940649
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 14:22:40 +0000 (UTC)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Ff39B5PH8z1BKwK;
 Mon, 10 May 2021 22:19:58 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 22:22:27 +0800
From: John Garry <john.garry@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
 <hch@lst.de>, <m.szyprowski@samsung.com>
Subject: [PATCH v2 10/15] dma-iommu: Use init_iova_domain_ext() for IOVA
 domain init
Date: Mon, 10 May 2021 22:17:24 +0800
Message-ID: <1620656249-68890-11-git-send-email-john.garry@huawei.com>
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

Pass the max opt iova len to init the IOVA domain, if set.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/dma-iommu.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 4fb82c554ede..574d7a901fd2 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -358,6 +358,8 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	unsigned long order, base_pfn;
 	struct iova_domain *iovad;
+	size_t max_opt_dma_size;
+	unsigned long iova_len;
 
 	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
 		return -EINVAL;
@@ -391,7 +393,18 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 		return 0;
 	}
 
-	init_iova_domain(iovad, 1UL << order, base_pfn);
+	max_opt_dma_size = iommu_group_get_max_opt_dma_size(dev->iommu_group);
+
+	if (max_opt_dma_size) {
+		unsigned long shift = __ffs(1UL << order);
+
+		iova_len = max_opt_dma_size >> shift;
+		iova_len = roundup_pow_of_two(iova_len);
+	} else {
+		iova_len = 0;
+	}
+
+	init_iova_domain_ext(iovad, 1UL << order, base_pfn, iova_len);
 
 	if (!cookie->fq_domain && (!dev || !dev_is_untrusted(dev)) &&
 	    domain->ops->flush_iotlb_all && !iommu_get_dma_strict(domain)) {
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
