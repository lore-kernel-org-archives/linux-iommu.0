Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B85C43334
	for <iommu@archiver.kernel.org>; Tue,  7 Jun 2022 18:39:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E3DDF83E07;
	Tue,  7 Jun 2022 18:39:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BfDRqyDPLSNu; Tue,  7 Jun 2022 18:39:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C84D583E61;
	Tue,  7 Jun 2022 18:39:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0ED9C0032;
	Tue,  7 Jun 2022 18:39:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBE82C002D
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 18:39:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D793640570
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 18:39:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=cybernetics.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jwp9de4_p44q for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 18:39:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F25E1402B1
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 18:39:42 +0000 (UTC)
X-ASG-Debug-ID: 1654627180-1cf43917f33964e0001-DtgJuY
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with
 ESMTP id DY7NxP6F0bNdGTkt; Tue, 07 Jun 2022 14:39:40 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=cybernetics.com; s=mail; 
 bh=9dUzxpvwws15FcrE4ulKEcPQJF2dj8RsJsfXaNUjy8Y=;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
 Content-Language:Subject:MIME-Version:Date:Message-ID; b=Ou8kArJXBehA8GyTgqeQ
 adcuNOIrLO8fMzz0ojoRfoLJz+wpXSuttbZmibRiMkyO4zjv3Cc4jorMTfjLqzNGd4Ra5SNqwUzks
 CrBOzuZhKxfRzb7xZ87l9rErl5HNWx/eNoZqJ1E4btmP6cEUUNx+veehFLQCr6cAhEojgbXAZs=
Received: from [10.157.2.224] (HELO [192.168.200.1])
 by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
 with ESMTPS id 11859391; Tue, 07 Jun 2022 14:39:40 -0400
Message-ID: <7ba0de95-5f5b-e140-c4ee-ff34e70e2546@cybernetics.com>
Date: Tue, 7 Jun 2022 14:39:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [PATCH v6 01/11] dmapool: remove checks for dev == NULL
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH v6 01/11] dmapool: remove checks for dev == NULL
From: Tony Battersby <tonyb@cybernetics.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <340ff8ef-9ff5-7175-c234-4132bbdfc5f7@cybernetics.com>
In-Reply-To: <340ff8ef-9ff5-7175-c234-4132bbdfc5f7@cybernetics.com>
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1654627180
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 3594
Cc: Tony Lindgren <tony@atomide.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, iommu@lists.linux-foundation.org,
 Keith Busch <kbusch@kernel.org>, kernel-team@fb.com,
 Robin Murphy <robin.murphy@arm.com>
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

dmapool originally tried to support pools without a device because
dma_alloc_coherent() supports allocations without a device.  But nobody
ended up using dma pools without a device, and trying to do so will
result in an oops.  So remove the checks for pool->dev == NULL since they
are unneeded bloat.

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---
 mm/dmapool.c | 42 +++++++++++-------------------------------
 1 file changed, 11 insertions(+), 31 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index a7eb5d0eb2da..0f89de408cbe 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -275,7 +275,7 @@ void dma_pool_destroy(struct dma_pool *pool)
 	mutex_lock(&pools_reg_lock);
 	mutex_lock(&pools_lock);
 	list_del(&pool->pools);
-	if (pool->dev && list_empty(&pool->dev->dma_pools))
+	if (list_empty(&pool->dev->dma_pools))
 		empty = true;
 	mutex_unlock(&pools_lock);
 	if (empty)
@@ -284,12 +284,8 @@ void dma_pool_destroy(struct dma_pool *pool)
 
 	list_for_each_entry_safe(page, tmp, &pool->page_list, page_list) {
 		if (is_page_busy(page)) {
-			if (pool->dev)
-				dev_err(pool->dev, "%s %s, %p busy\n", __func__,
-					pool->name, page->vaddr);
-			else
-				pr_err("%s %s, %p busy\n", __func__,
-				       pool->name, page->vaddr);
+			dev_err(pool->dev, "%s %s, %p busy\n", __func__,
+				pool->name, page->vaddr);
 			/* leak the still-in-use consistent memory */
 			list_del(&page->page_list);
 			kfree(page);
@@ -351,12 +347,8 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 		for (i = sizeof(page->offset); i < pool->size; i++) {
 			if (data[i] == POOL_POISON_FREED)
 				continue;
-			if (pool->dev)
-				dev_err(pool->dev, "%s %s, %p (corrupted)\n",
-					__func__, pool->name, retval);
-			else
-				pr_err("%s %s, %p (corrupted)\n",
-					__func__, pool->name, retval);
+			dev_err(pool->dev, "%s %s, %p (corrupted)\n",
+				__func__, pool->name, retval);
 
 			/*
 			 * Dump the first 4 bytes even if they are not
@@ -411,12 +403,8 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
 	page = pool_find_page(pool, dma);
 	if (!page) {
 		spin_unlock_irqrestore(&pool->lock, flags);
-		if (pool->dev)
-			dev_err(pool->dev, "%s %s, %p/%pad (bad dma)\n",
-				__func__, pool->name, vaddr, &dma);
-		else
-			pr_err("%s %s, %p/%pad (bad dma)\n",
-			       __func__, pool->name, vaddr, &dma);
+		dev_err(pool->dev, "%s %s, %p/%pad (bad dma)\n",
+			__func__, pool->name, vaddr, &dma);
 		return;
 	}
 
@@ -426,12 +414,8 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
 #ifdef	DMAPOOL_DEBUG
 	if ((dma - page->dma) != offset) {
 		spin_unlock_irqrestore(&pool->lock, flags);
-		if (pool->dev)
-			dev_err(pool->dev, "%s %s, %p (bad vaddr)/%pad\n",
-				__func__, pool->name, vaddr, &dma);
-		else
-			pr_err("%s %s, %p (bad vaddr)/%pad\n",
-			       __func__, pool->name, vaddr, &dma);
+		dev_err(pool->dev, "%s %s, %p (bad vaddr)/%pad\n",
+			__func__, pool->name, vaddr, &dma);
 		return;
 	}
 	{
@@ -442,12 +426,8 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
 				continue;
 			}
 			spin_unlock_irqrestore(&pool->lock, flags);
-			if (pool->dev)
-				dev_err(pool->dev, "%s %s, dma %pad already free\n",
-					__func__, pool->name, &dma);
-			else
-				pr_err("%s %s, dma %pad already free\n",
-				       __func__, pool->name, &dma);
+			dev_err(pool->dev, "%s %s, dma %pad already free\n",
+				__func__, pool->name, &dma);
 			return;
 		}
 	}
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
