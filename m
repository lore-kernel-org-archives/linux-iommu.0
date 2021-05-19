Return-Path: <SRS0=NBt+=KO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F22FC433ED
	for <iommu@archiver.kernel.org>; Wed, 19 May 2021 09:44:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B22C560FE8
	for <iommu@archiver.kernel.org>; Wed, 19 May 2021 09:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22C560FE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF8DC402A5;
	Wed, 19 May 2021 09:44:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nrJPd3rBP9IM; Wed, 19 May 2021 09:44:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4F9240E6E;
	Wed, 19 May 2021 09:44:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF146C000E;
	Wed, 19 May 2021 09:44:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9392DC001C
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 09:44:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 767B740154
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 09:44:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3vAd__ihineT for <iommu@lists.linux-foundation.org>;
 Wed, 19 May 2021 09:44:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C956F4011B
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 09:44:27 +0000 (UTC)
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FlSY42yz2zpfb5;
 Wed, 19 May 2021 17:40:56 +0800 (CST)
Received: from dggema765-chm.china.huawei.com (10.1.198.207) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 17:44:17 +0800
Received: from DESKTOP-6NKE0BC.china.huawei.com (10.174.185.210) by
 dggema765-chm.china.huawei.com (10.1.198.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 19 May 2021 17:44:17 +0800
From: Kunkun Jiang <jiangkunkun@huawei.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Eric
 Auger" <eric.auger@redhat.com>, "moderated list:ARM SMMU DRIVERS"
 <linux-arm-kernel@lists.infradead.org>, "open list:IOMMU DRIVERS"
 <iommu@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v1 1/2] iommu/arm-smmu-v3: Align invalid range with leaf
 page size upwards when support RIL
Date: Wed, 19 May 2021 17:43:06 +0800
Message-ID: <20210519094307.3275-2-jiangkunkun@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
In-Reply-To: <20210519094307.3275-1-jiangkunkun@huawei.com>
References: <20210519094307.3275-1-jiangkunkun@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.185.210]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema765-chm.china.huawei.com (10.1.198.207)
X-CFilter-Loop: Reflected
Cc: wanghaibin.wang@huawei.com, Kunkun Jiang <jiangkunkun@huawei.com>
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

In the __arm_smmu_tlb_inv_range(), the fileds of TLBI CMD is
calculated based on the invalid range and the leaf page size,
when SMMU supports RIL. It will cause some errors when the
invalid range isn't aligned with the leaf page size.

1. The num_pages will be zero, if the invalid range is less
than b. Then it will enter an endless loop in
__arm_smmu_tlb_inv_range().
2. The actual invalid range will only be part of the invalid
range. If the invalid range is not an integral multiple of
the leaf page size.

To align invalid range with leaf page size upwards will solve
the two issues.

Reported-by: Nianyao Tang <tangnianyao@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 54b2f27b81d4..8a2cacbb1ef8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1703,7 +1703,9 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 
 	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
 		/* Get the leaf page size */
+		size_t leaf_pgsize;
 		tg = __ffs(smmu_domain->domain.pgsize_bitmap);
+		leaf_pgsize = 1 << tg;
 
 		/* Convert page size of 12,14,16 (log2) to 1,2,3 */
 		cmd->tlbi.tg = (tg - 10) / 2;
@@ -1711,6 +1713,8 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 		/* Determine what level the granule is at */
 		cmd->tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
 
+		/* Align size with the leaf page size upwards */
+		size = ALIGN(size, leaf_pgsize);
 		num_pages = size >> tg;
 	}
 
-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
