Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287A0C433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Jun 2022 18:46:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC2A9418D3;
	Tue,  7 Jun 2022 18:46:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ClnaYRSpbBTh; Tue,  7 Jun 2022 18:46:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 684F341634;
	Tue,  7 Jun 2022 18:46:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41A8EC0032;
	Tue,  7 Jun 2022 18:46:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5EEF4C002D
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 18:46:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 596A560D66
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 18:46:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=cybernetics.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XNwInP7kh75n for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 18:46:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 792E460B73
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 18:46:17 +0000 (UTC)
X-ASG-Debug-ID: 1654627544-1cf43917f3396710001-DtgJuY
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with
 ESMTP id u3h3PzNcv3GISwVG; Tue, 07 Jun 2022 14:45:44 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=cybernetics.com; s=mail; 
 bh=fJQpcCRHMP3bElV7sUkA+QTTFc8Tk97S5Mqvw1QDnTQ=;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
 Content-Language:Subject:MIME-Version:Date:Message-ID; b=ghina6onuUS2ov/P3hH9
 L5dEdD+6sGEHGT4vP9jtWoQ5eCxd6dCBxtPoExAZw2K5opBuq2H/Z4oCWx5J1HX8r2nziqL09VDv3
 7e7fCgDlngbrr1wSqKCea76X8QbWpcNpautqqHUnpKW3+01/yk5/iaywpvmAI7fEdg/W5S6oPo=
Received: from [10.157.2.224] (HELO [192.168.200.1])
 by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
 with ESMTPS id 11859468; Tue, 07 Jun 2022 14:45:44 -0400
Message-ID: <11b7e3cd-c929-654c-1f45-1abe9a6f6a98@cybernetics.com>
Date: Tue, 7 Jun 2022 14:45:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [PATCH v6 09/11] dmapool: cleanup dma_pool_destroy
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH v6 09/11] dmapool: cleanup dma_pool_destroy
From: Tony Battersby <tonyb@cybernetics.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <340ff8ef-9ff5-7175-c234-4132bbdfc5f7@cybernetics.com>
In-Reply-To: <340ff8ef-9ff5-7175-c234-4132bbdfc5f7@cybernetics.com>
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1654627544
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 2336
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

pool_free_page() is called only from dma_pool_destroy(), so inline it
and make it less generic since we know that the pool is being destroyed.

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---

Changes since v5:
Take the opposite approach and inline pool_free_page() into
dma_pool_destroy() instead of moving the is_page_busy() check into
pool_free_page().

 mm/dmapool.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index c7ec38cb4631..4e075feb038f 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -241,18 +241,6 @@ static inline bool is_page_busy(struct dma_page *page)
 	return page->in_use != 0;
 }
 
-static void pool_free_page(struct dma_pool *pool, struct dma_page *page)
-{
-	dma_addr_t dma = page->dma;
-
-#ifdef	DMAPOOL_DEBUG
-	memset(page->vaddr, POOL_POISON_FREED, pool->allocation);
-#endif
-	dma_free_coherent(pool->dev, pool->allocation, page->vaddr, dma);
-	list_del(&page->page_list);
-	kfree(page);
-}
-
 /**
  * dma_pool_destroy - destroys a pool of dma memory blocks.
  * @pool: dma pool that will be destroyed
@@ -280,14 +268,22 @@ void dma_pool_destroy(struct dma_pool *pool)
 	mutex_unlock(&pools_reg_lock);
 
 	list_for_each_entry_safe(page, tmp, &pool->page_list, page_list) {
+		void *vaddr = page->vaddr;
+
 		if (is_page_busy(page)) {
 			dev_err(pool->dev, "%s %s, %p busy\n", __func__,
-				pool->name, page->vaddr);
+				pool->name, vaddr);
 			/* leak the still-in-use consistent memory */
-			list_del(&page->page_list);
-			kfree(page);
-		} else
-			pool_free_page(pool, page);
+		} else {
+#ifdef	DMAPOOL_DEBUG
+			memset(vaddr, POOL_POISON_FREED, pool->allocation);
+#endif
+			dma_free_coherent(pool->dev,
+					  pool->allocation,
+					  vaddr,
+					  page->dma);
+		}
+		kfree(page);
 	}
 
 	kfree(pool);
@@ -459,8 +455,7 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
 	*(int *)vaddr = page->offset;
 	page->offset = offset;
 	/*
-	 * Resist a temptation to do
-	 *    if (!is_page_busy(page)) pool_free_page(pool, page);
+	 * Resist a temptation to free unused pages immediately.
 	 * Better have a few empty pages hang around.
 	 */
 	spin_unlock_irqrestore(&pool->lock, flags);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
