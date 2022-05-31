Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36FFC433F5
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 18:23:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92E1360B38;
	Tue, 31 May 2022 18:23:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IoEQGS-uoxsI; Tue, 31 May 2022 18:23:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6F7B26128D;
	Tue, 31 May 2022 18:23:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4ABC3C0039;
	Tue, 31 May 2022 18:23:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB2B1C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 18:23:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B95006104D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 18:23:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7xHakUdWjMWe for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 18:23:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E140160B38
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 18:23:03 +0000 (UTC)
X-ASG-Debug-ID: 1654021382-1cf43917f334b0e0001-DtgJuY
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with
 ESMTP id rbOwRDxhxvyi8U8j; Tue, 31 May 2022 14:23:02 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=cybernetics.com; s=mail; 
 bh=DOnD3hVWfzzlQtOH7c2ljAgtJzaUt05vjMFxkgGY0NM=;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
 Content-Language:Subject:MIME-Version:Date:Message-ID; b=q/GVT243covpjwcmjMW5
 z4a6gNMYZabMfljvc8LnFzU6VBDffzO74DsNJcFVzgVVWgtszVkbPOdj7dQVe8BH9hQSlkbXhFiKm
 x/uNZmiZQcoW7bKGHC3BqfdQw5ypKnuPYBbR9W0R5xk2kzXdVLhFDQXi2vNknYGNjdMVKjqrCY=
Received: from [10.157.2.224] (HELO [192.168.200.1])
 by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
 with ESMTPS id 11829238; Tue, 31 May 2022 14:23:02 -0400
Message-ID: <f20c987d-8d07-04c8-3164-8d490d7ef615@cybernetics.com>
Date: Tue, 31 May 2022 14:23:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [PATCH 09/10] dmapool: improve scalability of dma_pool_alloc
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH 09/10] dmapool: improve scalability of dma_pool_alloc
From: Tony Battersby <tonyb@cybernetics.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
In-Reply-To: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1654021382
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 3568
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

dma_pool_alloc() scales poorly when allocating a large number of pages
because it does a linear scan of all previously-allocated pages before
allocating a new one.  Improve its scalability by maintaining a separate
list of pages that have free blocks ready to (re)allocate.  In big O
notation, this improves the algorithm from O(n^2) to O(n).

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---
 mm/dmapool.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 58c11dcaa4e4..b3dd2ace0d2a 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -17,6 +17,10 @@
  * least 'size' bytes.  Free blocks are tracked in an unsorted singly-linked
  * list of free blocks within the page.  Used blocks aren't tracked, but we
  * keep a count of how many are currently allocated from each page.
+ *
+ * The avail_page_list keeps track of pages that have one or more free blocks
+ * available to (re)allocate.  Pages are moved in and out of avail_page_list
+ * as their blocks are allocated and freed.
  */
 
 #include <linux/device.h>
@@ -42,6 +46,7 @@
 
 struct dma_pool {		/* the pool */
 	struct list_head page_list;
+	struct list_head avail_page_list;
 	spinlock_t lock;
 	unsigned int size;
 	struct device *dev;
@@ -54,6 +59,7 @@ struct dma_pool {		/* the pool */
 
 struct dma_page {		/* cacheable header for 'allocation' bytes */
 	struct list_head page_list;
+	struct list_head avail_page_link;
 	void *vaddr;
 	dma_addr_t dma;
 	unsigned int in_use;
@@ -164,6 +170,7 @@ struct dma_pool *dma_pool_create(const char *name, struct device *dev,
 	retval->dev = dev;
 
 	INIT_LIST_HEAD(&retval->page_list);
+	INIT_LIST_HEAD(&retval->avail_page_list);
 	spin_lock_init(&retval->lock);
 	retval->size = size;
 	retval->boundary = boundary;
@@ -270,6 +277,7 @@ static void pool_free_page(struct dma_pool *pool,
 	}
 
 	list_del(&page->page_list);
+	list_del(&page->avail_page_link);
 	kfree(page);
 }
 
@@ -330,10 +338,11 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 	might_alloc(mem_flags);
 
 	spin_lock_irqsave(&pool->lock, flags);
-	list_for_each_entry(page, &pool->page_list, page_list) {
-		if (page->offset < pool->allocation)
-			goto ready;
-	}
+	page = list_first_entry_or_null(&pool->avail_page_list,
+					struct dma_page,
+					avail_page_link);
+	if (page)
+		goto ready;
 
 	/* pool_alloc_page() might sleep, so temporarily drop &pool->lock */
 	spin_unlock_irqrestore(&pool->lock, flags);
@@ -345,10 +354,13 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 	spin_lock_irqsave(&pool->lock, flags);
 
 	list_add(&page->page_list, &pool->page_list);
+	list_add(&page->avail_page_link, &pool->avail_page_list);
  ready:
 	page->in_use++;
 	offset = page->offset;
 	page->offset = *(int *)(page->vaddr + offset);
+	if (page->offset >= pool->allocation)
+		list_del_init(&page->avail_page_link);
 	retval = offset + page->vaddr;
 	*handle = offset + page->dma;
 #ifdef	DMAPOOL_DEBUG
@@ -470,6 +482,13 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
 		memset(vaddr, 0, pool->size);
 #endif
 
+	/*
+	 * list_empty() on the page tests if the page is already linked into
+	 * avail_page_list to avoid adding it more than once.
+	 */
+	if (list_empty(&page->avail_page_link))
+		list_add(&page->avail_page_link, &pool->avail_page_list);
+
 	page->in_use--;
 	*(int *)vaddr = page->offset;
 	page->offset = offset;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
