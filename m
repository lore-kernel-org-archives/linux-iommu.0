Return-Path: <SRS0=NBt+=KO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9F8C433B4
	for <iommu@archiver.kernel.org>; Wed, 19 May 2021 09:44:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E388E611B0
	for <iommu@archiver.kernel.org>; Wed, 19 May 2021 09:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E388E611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B1B7060650;
	Wed, 19 May 2021 09:44:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YkgdU9fudJJz; Wed, 19 May 2021 09:44:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B5FB6061C;
	Wed, 19 May 2021 09:44:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86EC7C000E;
	Wed, 19 May 2021 09:44:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1DD9C0001
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 09:44:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 90AC2400FD
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 09:44:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RTtyhcYGBRLc for <iommu@lists.linux-foundation.org>;
 Wed, 19 May 2021 09:44:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C4E7B40154
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 09:44:25 +0000 (UTC)
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FlSYs1SQnz1BP0l;
 Wed, 19 May 2021 17:41:37 +0800 (CST)
Received: from dggema765-chm.china.huawei.com (10.1.198.207) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 17:44:23 +0800
Received: from DESKTOP-6NKE0BC.china.huawei.com (10.174.185.210) by
 dggema765-chm.china.huawei.com (10.1.198.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 19 May 2021 17:44:22 +0800
From: Kunkun Jiang <jiangkunkun@huawei.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Eric
 Auger" <eric.auger@redhat.com>, "moderated list:ARM SMMU DRIVERS"
 <linux-arm-kernel@lists.infradead.org>, "open list:IOMMU DRIVERS"
 <iommu@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v1 2/2] iommu/arm-smmu-v3: Standardize granule size when
 support RIL
Date: Wed, 19 May 2021 17:43:07 +0800
Message-ID: <20210519094307.3275-3-jiangkunkun@huawei.com>
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

In __arm_smmu_tlb_inv_range(), the field 'ttl' of TLB invalidation
command is caculated based on granule size when the SMMU supports
RIL. There are some scenarious we need to avoid, which are pointed
out in the SMMUv3 spec(page 143-144, Version D.a). Adding a check
to ensure that the granule size is supported by the SMMU before set
the 'ttl' value.

Reported-by: Nianyao Tang <tangnianyao@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8a2cacbb1ef8..77ff283ca329 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1711,6 +1711,11 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 		cmd->tlbi.tg = (tg - 10) / 2;
 
 		/* Determine what level the granule is at */
+		if (!(granule & smmu_domain->domain.pgsize_bitmap) ||
+		    (granule & (granule - 1))) {
+			granule = leaf_pgsize;
+			iova = ALIGN_DOWN(iova, leaf_pgsize);
+		}
 		cmd->tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
 
 		/* Align size with the leaf page size upwards */
-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
