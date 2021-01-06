Return-Path: <SRS0=DPil=GJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A6FC433DB
	for <iommu@archiver.kernel.org>; Wed,  6 Jan 2021 13:39:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B5D02311A
	for <iommu@archiver.kernel.org>; Wed,  6 Jan 2021 13:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5D02311A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E85A6868FF;
	Wed,  6 Jan 2021 13:39:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bdrwj5AFxJ0b; Wed,  6 Jan 2021 13:39:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BAEC785CEC;
	Wed,  6 Jan 2021 13:39:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9EADCC0893;
	Wed,  6 Jan 2021 13:39:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF300C013A
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jan 2021 13:39:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8E8302305A
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jan 2021 13:39:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rK3tbfbrFcEN for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 13:39:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by silver.osuosl.org (Postfix) with ESMTPS id F32B12079C
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jan 2021 13:39:16 +0000 (UTC)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4D9r6F4yWzz7Pnt;
 Wed,  6 Jan 2021 21:38:13 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 6 Jan 2021 21:39:02 +0800
From: John Garry <john.garry@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>
Subject: [PATCH v2 2/6] iova: Delete copy_reserved_iova()
Date: Wed, 6 Jan 2021 21:35:07 +0800
Message-ID: <1609940111-28563-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1609940111-28563-1-git-send-email-john.garry@huawei.com>
References: <1609940111-28563-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org
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

Since commit c588072bba6b ("iommu/vt-d: Convert intel iommu driver to the
iommu ops"), function copy_reserved_iova() is not referenced, so delete
it.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iova.c | 30 ------------------------------
 include/linux/iova.h |  6 ------
 2 files changed, 36 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 0a758ec2a1c4..04f0a3ae1c63 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -710,36 +710,6 @@ reserve_iova(struct iova_domain *iovad,
 }
 EXPORT_SYMBOL_GPL(reserve_iova);
 
-/**
- * copy_reserved_iova - copies the reserved between domains
- * @from: - source doamin from where to copy
- * @to: - destination domin where to copy
- * This function copies reserved iova's from one doamin to
- * other.
- */
-void
-copy_reserved_iova(struct iova_domain *from, struct iova_domain *to)
-{
-	unsigned long flags;
-	struct rb_node *node;
-
-	spin_lock_irqsave(&from->iova_rbtree_lock, flags);
-	for (node = rb_first(&from->rbroot); node; node = rb_next(node)) {
-		struct iova *iova = rb_entry(node, struct iova, node);
-		struct iova *new_iova;
-
-		if (iova->pfn_lo == IOVA_ANCHOR)
-			continue;
-
-		new_iova = reserve_iova(to, iova->pfn_lo, iova->pfn_hi);
-		if (!new_iova)
-			pr_err("Reserve iova range %lx@%lx failed\n",
-			       iova->pfn_lo, iova->pfn_lo);
-	}
-	spin_unlock_irqrestore(&from->iova_rbtree_lock, flags);
-}
-EXPORT_SYMBOL_GPL(copy_reserved_iova);
-
 /*
  * Magazine caches for IOVA ranges.  For an introduction to magazines,
  * see the USENIX 2001 paper "Magazines and Vmem: Extending the Slab
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 2b76e0be1c5b..c834c01c0a5b 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -150,7 +150,6 @@ unsigned long alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 			      unsigned long limit_pfn, bool flush_rcache);
 struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
 	unsigned long pfn_hi);
-void copy_reserved_iova(struct iova_domain *from, struct iova_domain *to);
 void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	unsigned long start_pfn);
 int init_iova_flush_queue(struct iova_domain *iovad,
@@ -211,11 +210,6 @@ static inline struct iova *reserve_iova(struct iova_domain *iovad,
 	return NULL;
 }
 
-static inline void copy_reserved_iova(struct iova_domain *from,
-				      struct iova_domain *to)
-{
-}
-
 static inline void init_iova_domain(struct iova_domain *iovad,
 				    unsigned long granule,
 				    unsigned long start_pfn)
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
