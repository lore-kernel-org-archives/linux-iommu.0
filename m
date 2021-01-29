Return-Path: <SRS0=1cKf=HA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FA8C433E0
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 09:22:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CDDC64E16
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 09:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDDC64E16
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7CDF12044E;
	Fri, 29 Jan 2021 09:21:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JzYVem8G+Tck; Fri, 29 Jan 2021 09:21:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3A43A20018;
	Fri, 29 Jan 2021 09:21:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1EA1CC0FA8;
	Fri, 29 Jan 2021 09:21:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05459C08A1
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 09:21:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E817086A37
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 09:21:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uinHR7Th082d for <iommu@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 09:21:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E450D86A36
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 09:21:52 +0000 (UTC)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DRsJc5S3fzjDYV;
 Fri, 29 Jan 2021 17:20:48 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.176.220) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Fri, 29 Jan 2021 17:21:42 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel" <joro@8bytes.org>, iommu <iommu@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] Revert "iommu/iova: Retry from last rb tree node if iova
 search fails"
Date: Fri, 29 Jan 2021 17:21:20 +0800
Message-ID: <20210129092120.1482-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Cc: Vijayanand Jitta <vjitta@codeaurora.org>
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

This reverts commit 4e89dce725213d3d0b0475211b500eda4ef4bf2f.

We find that this patch has a great impact on performance. According to
our test: the iops decreases from 1655.6K to 893.5K, about half.

Hardware: 1 SAS expander with 12 SAS SSD
Command:  Only the main parameters are listed.
          fio bs=4k rw=read iodepth=128 cpus_allowed=0-127

Fixes: 4e89dce72521 ("iommu/iova: Retry from last rb tree node if iova search fails")
Tested-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/iova.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index d20b8b333d30d17..f840c7207efbced 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -185,9 +185,8 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	struct rb_node *curr, *prev;
 	struct iova *curr_iova;
 	unsigned long flags;
-	unsigned long new_pfn, retry_pfn;
+	unsigned long new_pfn;
 	unsigned long align_mask = ~0UL;
-	unsigned long high_pfn = limit_pfn, low_pfn = iovad->start_pfn;
 
 	if (size_aligned)
 		align_mask <<= fls_long(size - 1);
@@ -200,25 +199,15 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 
 	curr = __get_cached_rbnode(iovad, limit_pfn);
 	curr_iova = rb_entry(curr, struct iova, node);
-	retry_pfn = curr_iova->pfn_hi + 1;
-
-retry:
 	do {
-		high_pfn = min(high_pfn, curr_iova->pfn_lo);
-		new_pfn = (high_pfn - size) & align_mask;
+		limit_pfn = min(limit_pfn, curr_iova->pfn_lo);
+		new_pfn = (limit_pfn - size) & align_mask;
 		prev = curr;
 		curr = rb_prev(curr);
 		curr_iova = rb_entry(curr, struct iova, node);
-	} while (curr && new_pfn <= curr_iova->pfn_hi && new_pfn >= low_pfn);
-
-	if (high_pfn < size || new_pfn < low_pfn) {
-		if (low_pfn == iovad->start_pfn && retry_pfn < limit_pfn) {
-			high_pfn = limit_pfn;
-			low_pfn = retry_pfn;
-			curr = &iovad->anchor.node;
-			curr_iova = rb_entry(curr, struct iova, node);
-			goto retry;
-		}
+	} while (curr && new_pfn <= curr_iova->pfn_hi);
+
+	if (limit_pfn < size || new_pfn < iovad->start_pfn) {
 		iovad->max32_alloc_size = size;
 		goto iova32_full;
 	}
-- 
1.8.3


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
