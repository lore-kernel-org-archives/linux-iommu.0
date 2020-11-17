Return-Path: <SRS0=JfyE=EX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD900C2D0E4
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 10:30:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2706322202
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 10:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2706322202
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9B78285AA1;
	Tue, 17 Nov 2020 10:30:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OfaCKAL61bgA; Tue, 17 Nov 2020 10:30:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7463382DDE;
	Tue, 17 Nov 2020 10:30:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 511BBC0891;
	Tue, 17 Nov 2020 10:30:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEF00C07FF
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 10:30:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DCFF98669E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 10:30:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BoT3hWX-7Wgh for <iommu@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 10:30:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BCD048669A
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 10:30:02 +0000 (UTC)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Cb2Hw47zYzhbh4;
 Tue, 17 Nov 2020 18:29:48 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 17 Nov 2020 18:29:52 +0800
From: John Garry <john.garry@huawei.com>
To: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
Subject: [RESEND PATCH v3 3/4] iommu/iova: Flush CPU rcache for when a depot
 fills
Date: Tue, 17 Nov 2020 18:25:33 +0800
Message-ID: <1605608734-84416-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1605608734-84416-1-git-send-email-john.garry@huawei.com>
References: <1605608734-84416-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Cc: linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, xiyou.wangcong@gmail.com
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

Leizhen reported some time ago that IOVA performance may degrade over time
[0], but unfortunately his solution to fix this problem was not given
attention.

To summarize, the issue is that as time goes by, the CPU rcache and depot
rcache continue to grow. As such, IOVA RB tree access time also continues
to grow.

At a certain point, a depot may become full, and also some CPU rcaches may
also be full when inserting another IOVA is attempted. For this scenario,
currently the "loaded" CPU rcache is freed and a new one is created. This
freeing means that many IOVAs in the RB tree need to be freed, which
makes IO throughput performance fall off a cliff in some storage scenarios:

Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6314MB/0KB/0KB /s] [1616K/0/0 iops]
Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [5669MB/0KB/0KB /s] [1451K/0/0 iops]
Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6031MB/0KB/0KB /s] [1544K/0/0 iops]
Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6673MB/0KB/0KB /s] [1708K/0/0 iops]
Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6705MB/0KB/0KB /s] [1717K/0/0 iops]
Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6031MB/0KB/0KB /s] [1544K/0/0 iops]
Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6761MB/0KB/0KB /s] [1731K/0/0 iops]
Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6705MB/0KB/0KB /s] [1717K/0/0 iops]
Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6685MB/0KB/0KB /s] [1711K/0/0 iops]
Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6178MB/0KB/0KB /s] [1582K/0/0 iops]
Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6731MB/0KB/0KB /s] [1723K/0/0 iops]
Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [2387MB/0KB/0KB /s] [611K/0/0 iops]
Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [2689MB/0KB/0KB /s] [688K/0/0 iops]
Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [2278MB/0KB/0KB /s] [583K/0/0 iops]
Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [1288MB/0KB/0KB /s] [330K/0/0 iops]
Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [1632MB/0KB/0KB /s] [418K/0/0 iops]
Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [1765MB/0KB/0KB /s] [452K/0/0 iops]

And continue in this fashion, without recovering. Note that in this
example it was required to wait 16 hours for this to occur. Also note that
IO throughput also becomes gradually becomes more unstable leading up to
this point.

This problem is only seen for non-strict mode. For strict mode, the rcaches
stay quite compact.

As a solution to this issue, judge that the IOVA caches have grown too big
when cached magazines need to be free, and just flush all the CPUs rcaches
instead.

The depot rcaches, however, are not flushed, as they can be used to
immediately replenish active CPUs.

In future, some IOVA compaction could be implemented to solve the
instabilty issue, which I figure could be quite complex to implement.

[0] https://lore.kernel.org/linux-iommu/20190815121104.29140-3-thunder.leizhen@huawei.com/

Analyzed-by: Zhen Lei <thunder.leizhen@huawei.com>
Reported-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iova.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 1f3f0f8b12e0..386005055aca 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -901,7 +901,6 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
 				 struct iova_rcache *rcache,
 				 unsigned long iova_pfn)
 {
-	struct iova_magazine *mag_to_free = NULL;
 	struct iova_cpu_rcache *cpu_rcache;
 	bool can_insert = false;
 	unsigned long flags;
@@ -923,13 +922,12 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
 				if (cpu_rcache->loaded)
 					rcache->depot[rcache->depot_size++] =
 							cpu_rcache->loaded;
-			} else {
-				mag_to_free = cpu_rcache->loaded;
+				can_insert = true;
+				cpu_rcache->loaded = new_mag;
 			}
 			spin_unlock(&rcache->lock);
-
-			cpu_rcache->loaded = new_mag;
-			can_insert = true;
+			if (!can_insert)
+				iova_magazine_free(new_mag);
 		}
 	}
 
@@ -938,10 +936,8 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
 
 	spin_unlock_irqrestore(&cpu_rcache->lock, flags);
 
-	if (mag_to_free) {
-		iova_magazine_free_pfns(mag_to_free, iovad);
-		iova_magazine_free(mag_to_free);
-	}
+	if (!can_insert)
+		free_all_cpu_cached_iovas(iovad);
 
 	return can_insert;
 }
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
