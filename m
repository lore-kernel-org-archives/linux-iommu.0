Return-Path: <SRS0=qXOr=FH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82365C433FE
	for <iommu@archiver.kernel.org>; Thu,  3 Dec 2020 18:39:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03117208A9
	for <iommu@archiver.kernel.org>; Thu,  3 Dec 2020 18:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03117208A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 693A486169;
	Thu,  3 Dec 2020 18:39:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NP2OiP5vr_p8; Thu,  3 Dec 2020 18:39:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CF57F86968;
	Thu,  3 Dec 2020 18:39:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2381C1DA2;
	Thu,  3 Dec 2020 18:39:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34F70C0FA8
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 18:39:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 264D8870FE
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 18:39:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z8jlYLOZ8QML for <iommu@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 18:39:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5107987111
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 18:39:13 +0000 (UTC)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cn4NW41DczkkwX;
 Fri,  4 Dec 2020 02:38:35 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Dec 2020 02:39:01 +0800
From: John Garry <john.garry@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>
Subject: [PATCH 1/3] iommu: Delete split_and_remove_iova()
Date: Fri, 4 Dec 2020 02:34:50 +0800
Message-ID: <1607020492-189471-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1607020492-189471-1-git-send-email-john.garry@huawei.com>
References: <1607020492-189471-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Cc: 0x7f454c46@gmail.com, linux-kernel@vger.kernel.org, linuxarm@huawei.com,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com
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

Function split_and_remove_iova() has not been referenced since commit
e70b081c6f37 ("iommu/vt-d: Remove IOVA handling code from the non-dma_ops
path"), so delete it.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iova.c | 41 -----------------------------------------
 include/linux/iova.h | 10 ----------
 2 files changed, 51 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index ea04a88c673d..4803bd83447d 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -738,47 +738,6 @@ copy_reserved_iova(struct iova_domain *from, struct iova_domain *to)
 }
 EXPORT_SYMBOL_GPL(copy_reserved_iova);
 
-struct iova *
-split_and_remove_iova(struct iova_domain *iovad, struct iova *iova,
-		      unsigned long pfn_lo, unsigned long pfn_hi)
-{
-	unsigned long flags;
-	struct iova *prev = NULL, *next = NULL;
-
-	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
-	if (iova->pfn_lo < pfn_lo) {
-		prev = alloc_and_init_iova(iova->pfn_lo, pfn_lo - 1);
-		if (prev == NULL)
-			goto error;
-	}
-	if (iova->pfn_hi > pfn_hi) {
-		next = alloc_and_init_iova(pfn_hi + 1, iova->pfn_hi);
-		if (next == NULL)
-			goto error;
-	}
-
-	__cached_rbnode_delete_update(iovad, iova);
-	rb_erase(&iova->node, &iovad->rbroot);
-
-	if (prev) {
-		iova_insert_rbtree(&iovad->rbroot, prev, NULL);
-		iova->pfn_lo = pfn_lo;
-	}
-	if (next) {
-		iova_insert_rbtree(&iovad->rbroot, next, NULL);
-		iova->pfn_hi = pfn_hi;
-	}
-	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
-
-	return iova;
-
-error:
-	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
-	if (prev)
-		free_iova_mem(prev);
-	return NULL;
-}
-
 /*
  * Magazine caches for IOVA ranges.  For an introduction to magazines,
  * see the USENIX 2001 paper "Magazines and Vmem: Extending the Slab
diff --git a/include/linux/iova.h b/include/linux/iova.h
index a0637abffee8..a77add571c50 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -160,8 +160,6 @@ int init_iova_flush_queue(struct iova_domain *iovad,
 			  iova_flush_cb flush_cb, iova_entry_dtor entry_dtor);
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
 void put_iova_domain(struct iova_domain *iovad);
-struct iova *split_and_remove_iova(struct iova_domain *iovad,
-	struct iova *iova, unsigned long pfn_lo, unsigned long pfn_hi);
 void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
 #else
 static inline int iova_cache_get(void)
@@ -258,14 +256,6 @@ static inline void put_iova_domain(struct iova_domain *iovad)
 {
 }
 
-static inline struct iova *split_and_remove_iova(struct iova_domain *iovad,
-						 struct iova *iova,
-						 unsigned long pfn_lo,
-						 unsigned long pfn_hi)
-{
-	return NULL;
-}
-
 static inline void free_cpu_cached_iovas(unsigned int cpu,
 					 struct iova_domain *iovad)
 {
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
