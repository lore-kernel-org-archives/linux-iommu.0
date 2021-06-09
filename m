Return-Path: <SRS0=g+Up=LD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E15BC47095
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 08:33:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B089761285
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 08:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B089761285
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60C5F40471;
	Wed,  9 Jun 2021 08:33:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZEWmvUpfu0Up; Wed,  9 Jun 2021 08:33:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F07E0402BC;
	Wed,  9 Jun 2021 08:33:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5B77C000D;
	Wed,  9 Jun 2021 08:33:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20B2EC000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 08:33:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E565F402AF
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 08:33:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RJRQA_8ZGy5w for <iommu@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 08:33:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D53AB400D4
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 08:33:08 +0000 (UTC)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G0KxT4QSNzWtMs;
 Wed,  9 Jun 2021 16:28:13 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 16:33:05 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 16:33:04 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>, "Lu
 Baolu" <baolu.lu@linux.intel.com>, Yong Wu <yong.wu@mediatek.com>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 "Chen-Yu Tsai" <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 iommu <iommu@lists.linux-foundation.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, linux-mediatek
 <linux-mediatek@lists.infradead.org>, linux-sunxi
 <linux-sunxi@lists.linux.dev>
Subject: [PATCH v3 1/2] iommu/iova: Fix spelling mistakes
Date: Wed, 9 Jun 2021 16:32:50 +0800
Message-ID: <20210609083251.13827-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210609083251.13827-1-thunder.leizhen@huawei.com>
References: <20210609083251.13827-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
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

Fix some spelling mistakes in comments found by "codespell":
detroyed ==> destroyed
defered ==> deferred
entrie ==> entry
alloced ==> allocated
regularily ==> regularly

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/iova.c |  2 +-
 include/linux/iova.h | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index b6cf5f16123b..cce4571548c4 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -594,7 +594,7 @@ static void fq_destroy_all_entries(struct iova_domain *iovad)
 	int cpu;
 
 	/*
-	 * This code runs when the iova_domain is being detroyed, so don't
+	 * This code runs when the iova_domain is being destroyed, so don't
 	 * bother to free iovas, just call the entry_dtor on all remaining
 	 * entries.
 	 */
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 71d8a2de6635..16f671b04a37 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -49,12 +49,12 @@ typedef void (* iova_entry_dtor)(unsigned long data);
 /* Timeout (in ms) after which entries are flushed from the Flush-Queue */
 #define IOVA_FQ_TIMEOUT	10
 
-/* Flush Queue entry for defered flushing */
+/* Flush Queue entry for deferred flushing */
 struct iova_fq_entry {
 	unsigned long iova_pfn;
 	unsigned long pages;
 	unsigned long data;
-	u64 counter; /* Flush counter when this entrie was added */
+	u64 counter; /* Flush counter when this entry was added */
 };
 
 /* Per-CPU Flush Queue structure */
@@ -68,8 +68,8 @@ struct iova_fq {
 struct iova_domain {
 	spinlock_t	iova_rbtree_lock; /* Lock to protect update of rbtree */
 	struct rb_root	rbroot;		/* iova domain rbtree root */
-	struct rb_node	*cached_node;	/* Save last alloced node */
-	struct rb_node	*cached32_node; /* Save last 32-bit alloced node */
+	struct rb_node	*cached_node;	/* Save last allocated node */
+	struct rb_node	*cached32_node; /* Save last 32-bit allocated node */
 	unsigned long	granule;	/* pfn granularity for this domain */
 	unsigned long	start_pfn;	/* Lower limit for this domain */
 	unsigned long	dma_32bit_pfn;
@@ -91,7 +91,7 @@ struct iova_domain {
 	iova_entry_dtor entry_dtor;	/* IOMMU driver specific destructor for
 					   iova entry */
 
-	struct timer_list fq_timer;		/* Timer to regularily empty the
+	struct timer_list fq_timer;		/* Timer to regularly empty the
 						   flush-queues */
 	atomic_t fq_timer_on;			/* 1 when timer is active, 0
 						   when not */
-- 
2.25.1


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
