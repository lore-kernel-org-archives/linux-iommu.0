Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A819BC433F5
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 18:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D0C36104D;
	Tue, 31 May 2022 18:22:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uVKS78F3OsVq; Tue, 31 May 2022 18:22:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 22CBB60B38;
	Tue, 31 May 2022 18:22:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1AFCC0039;
	Tue, 31 May 2022 18:22:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A43BC002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 18:22:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6726582D0C
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 18:22:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=cybernetics.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V2fGB11dpG6U for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 18:22:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ADB5882A56
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 18:22:22 +0000 (UTC)
X-ASG-Debug-ID: 1654021341-1cf43917f334b0c0001-DtgJuY
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with
 ESMTP id ZzsyGX4QF38BVlyE; Tue, 31 May 2022 14:22:21 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=cybernetics.com; s=mail; 
 bh=eQIejJQOI/tAoaluQWJF6F3pwzd0w/dyu0/0oFwF/ME=;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
 Content-Language:Subject:MIME-Version:Date:Message-ID; b=F5jnWTUFSe+/KQ5AraCn
 x2M3sgS5D7KBF0kTbxgh7aTkSikU4O+wLG1/eYe2hQgBrdXZpcZLc+QHWFzhFiJ92GFCKNWUEd5+3
 oUhgNCdJEQ4T0fqGo8bOwBceIA6Bh8pHjcMOaKZj21/jCvAUBq7twmACoj8fHfQ7+QWinqXjTs=
Received: from [10.157.2.224] (HELO [192.168.200.1])
 by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
 with ESMTPS id 11829234; Tue, 31 May 2022 14:22:21 -0400
Message-ID: <30fd23ae-7035-5ce3-5643-89a5956f1e79@cybernetics.com>
Date: Tue, 31 May 2022 14:22:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [PATCH 08/10] dmapool: cleanup dma_pool_destroy
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH 08/10] dmapool: cleanup dma_pool_destroy
From: Tony Battersby <tonyb@cybernetics.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
In-Reply-To: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1654021341
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 2711
X-Barracuda-BRTS-Status: 1
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

Remove a small amount of code duplication between dma_pool_destroy() and
pool_free_page() in preparation for adding more code without having to
duplicate it.  No functional changes.

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---
 mm/dmapool.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 8749a9d7927e..58c11dcaa4e4 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -250,14 +250,25 @@ static inline bool is_page_busy(struct dma_page *page)
 	return page->in_use != 0;
 }
 
-static void pool_free_page(struct dma_pool *pool, struct dma_page *page)
+static void pool_free_page(struct dma_pool *pool,
+			   struct dma_page *page,
+			   bool destroying_pool)
 {
+	void *vaddr = page->vaddr;
 	dma_addr_t dma = page->dma;
 
+	if (destroying_pool && is_page_busy(page)) {
+		dev_err(pool->dev,
+			"dma_pool_destroy %s, %p busy\n",
+			pool->name, vaddr);
+		/* leak the still-in-use consistent memory */
+	} else {
 #ifdef	DMAPOOL_DEBUG
-	memset(page->vaddr, POOL_POISON_FREED, pool->allocation);
+		memset(vaddr, POOL_POISON_FREED, pool->allocation);
 #endif
-	dma_free_coherent(pool->dev, pool->allocation, page->vaddr, dma);
+		dma_free_coherent(pool->dev, pool->allocation, vaddr, dma);
+	}
+
 	list_del(&page->page_list);
 	kfree(page);
 }
@@ -272,7 +283,7 @@ static void pool_free_page(struct dma_pool *pool, struct dma_page *page)
  */
 void dma_pool_destroy(struct dma_pool *pool)
 {
-	struct dma_page *page, *tmp;
+	struct dma_page *page;
 	bool empty = false;
 
 	if (unlikely(!pool))
@@ -288,15 +299,10 @@ void dma_pool_destroy(struct dma_pool *pool)
 		device_remove_file(pool->dev, &dev_attr_pools);
 	mutex_unlock(&pools_reg_lock);
 
-	list_for_each_entry_safe(page, tmp, &pool->page_list, page_list) {
-		if (is_page_busy(page)) {
-			dev_err(pool->dev, "%s %s, %p busy\n", __func__,
-				pool->name, page->vaddr);
-			/* leak the still-in-use consistent memory */
-			list_del(&page->page_list);
-			kfree(page);
-		} else
-			pool_free_page(pool, page);
+	while ((page = list_first_entry_or_null(&pool->page_list,
+						struct dma_page,
+						page_list))) {
+		pool_free_page(pool, page, true);
 	}
 
 	kfree(pool);
@@ -469,7 +475,7 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
 	page->offset = offset;
 	/*
 	 * Resist a temptation to do
-	 *    if (!is_page_busy(page)) pool_free_page(pool, page);
+	 *    if (!is_page_busy(page)) pool_free_page(pool, page, false);
 	 * Better have a few empty pages hang around.
 	 */
 	spin_unlock_irqrestore(&pool->lock, flags);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
