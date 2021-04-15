Return-Path: <SRS0=SOau=JM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89563C433B4
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 03:56:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F32C96101B
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 03:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32C96101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8630846CA;
	Thu, 15 Apr 2021 03:56:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VZmgKIHLIQWH; Thu, 15 Apr 2021 03:56:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id A68318468A;
	Thu, 15 Apr 2021 03:56:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BF04C000C;
	Thu, 15 Apr 2021 03:56:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A6CCC000A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 03:56:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 328A5404A9
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 03:56:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F0u7Azn3BbJs for <iommu@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 03:56:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D11C140358
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 03:56:21 +0000 (UTC)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FLQSS0dv0zB14R;
 Thu, 15 Apr 2021 11:54:00 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Thu, 15 Apr 2021 11:56:11 +0800
From: chenxiang <chenxiang66@hisilicon.com>
To: <robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>
Subject: [PATCH v2] iommu/iova: put free_iova_mem() outside of spinlock
 iova_rbtree_lock
Date: Thu, 15 Apr 2021 11:52:05 +0800
Message-ID: <1618458725-244583-1-git-send-email-chenxiang66@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linuxarm@openeuler.org,
 linuxarm@huawei.com
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

From: Xiang Chen <chenxiang66@hisilicon.com>

It is not necessary to put free_iova_mem() inside of spinlock/unlock
iova_rbtree_lock which only leads to more completion for the spinlock.
It has a small promote on the performance after the change. And also
rename private_free_iova() as remove_iova() because the function will not
free iova after that change.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
---
 drivers/iommu/iova.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index b7ecd5b..c10af23 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -412,12 +412,11 @@ private_find_iova(struct iova_domain *iovad, unsigned long pfn)
 	return NULL;
 }
 
-static void private_free_iova(struct iova_domain *iovad, struct iova *iova)
+static void remove_iova(struct iova_domain *iovad, struct iova *iova)
 {
 	assert_spin_locked(&iovad->iova_rbtree_lock);
 	__cached_rbnode_delete_update(iovad, iova);
 	rb_erase(&iova->node, &iovad->rbroot);
-	free_iova_mem(iova);
 }
 
 /**
@@ -452,8 +451,9 @@ __free_iova(struct iova_domain *iovad, struct iova *iova)
 	unsigned long flags;
 
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
-	private_free_iova(iovad, iova);
+	remove_iova(iovad, iova);
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+	free_iova_mem(iova);
 }
 EXPORT_SYMBOL_GPL(__free_iova);
 
@@ -473,9 +473,9 @@ free_iova(struct iova_domain *iovad, unsigned long pfn)
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
 	iova = private_find_iova(iovad, pfn);
 	if (iova)
-		private_free_iova(iovad, iova);
+		remove_iova(iovad, iova);
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
-
+	free_iova_mem(iova);
 }
 EXPORT_SYMBOL_GPL(free_iova);
 
@@ -825,7 +825,8 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
 		if (WARN_ON(!iova))
 			continue;
 
-		private_free_iova(iovad, iova);
+		remove_iova(iovad, iova);
+		free_iova_mem(iova);
 	}
 
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
-- 
2.8.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
