Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA76C433F5
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 18:23:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F10558406A;
	Tue, 31 May 2022 18:23:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zyXKGsPJBMec; Tue, 31 May 2022 18:23:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A954783FED;
	Tue, 31 May 2022 18:23:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84EF5C0039;
	Tue, 31 May 2022 18:23:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2380C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 18:23:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DCD4C403B3
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 18:23:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=cybernetics.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 24e5eOfvlZCX for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 18:23:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E125540104
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 18:23:45 +0000 (UTC)
X-ASG-Debug-ID: 1654021424-1cf43917f334b100001-DtgJuY
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with
 ESMTP id DaFkvBiBCRTezthM; Tue, 31 May 2022 14:23:44 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=cybernetics.com; s=mail; 
 bh=R86aZY51t2u2IQYQVHsV2xLBx7C5x16DOE0BI7kIaD0=;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
 Content-Language:Subject:MIME-Version:Date:Message-ID; b=PIl/mfpVeGR7pK26lLIL
 gnhce3+ZeKiFpemaNrrs1l5X4DngDsIEVNLKfAhTglIjzl+cvY33UqCrmlUzwPOmaRCet3xUvt5OC
 PVWsBnrBRmW5aGCHNFC18P+06bzg2BtKSMlsWVXFKrE3OktjOIg9MRYf3K1G/daJJx45TKOB7w=
Received: from [10.157.2.224] (HELO [192.168.200.1])
 by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
 with ESMTPS id 11829239; Tue, 31 May 2022 14:23:44 -0400
Message-ID: <801335ba-00f3-12ae-59e0-119d7d8fd8cd@cybernetics.com>
Date: Tue, 31 May 2022 14:23:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [PATCH 10/10] dmapool: improve scalability of dma_pool_free
Content-Language: en-US
X-ASG-Orig-Subj: [PATCH 10/10] dmapool: improve scalability of dma_pool_free
From: Tony Battersby <tonyb@cybernetics.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
In-Reply-To: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1654021424
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 7804
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

dma_pool_free() scales poorly when the pool contains many pages because
pool_find_page() does a linear scan of all allocated pages.  Improve its
scalability by replacing the linear scan with a red-black tree lookup.
In big O notation, this improves the algorithm from O(n^2) to O(n * log n).

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
---
 mm/dmapool.c | 128 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 100 insertions(+), 28 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index b3dd2ace0d2a..24535483f781 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -12,11 +12,12 @@
  * Many older drivers still have their own code to do this.
  *
  * The current design of this allocator is fairly simple.  The pool is
- * represented by the 'struct dma_pool' which keeps a doubly-linked list of
- * allocated pages.  Each page in the page_list is split into blocks of at
- * least 'size' bytes.  Free blocks are tracked in an unsorted singly-linked
- * list of free blocks within the page.  Used blocks aren't tracked, but we
- * keep a count of how many are currently allocated from each page.
+ * represented by the 'struct dma_pool' which keeps a red-black tree of all
+ * allocated pages, keyed by DMA address for fast lookup when freeing.
+ * Each page in the page_tree is split into blocks of at least 'size' bytes.
+ * Free blocks are tracked in an unsorted singly-linked list of free blocks
+ * within the page.  Used blocks aren't tracked, but we keep a count of how
+ * many are currently allocated from each page.
  *
  * The avail_page_list keeps track of pages that have one or more free blocks
  * available to (re)allocate.  Pages are moved in and out of avail_page_list
@@ -36,6 +37,7 @@
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/spinlock.h>
+#include <linux/rbtree.h>
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/wait.h>
@@ -45,7 +47,7 @@
 #endif
 
 struct dma_pool {		/* the pool */
-	struct list_head page_list;
+	struct rb_root page_tree;
 	struct list_head avail_page_list;
 	spinlock_t lock;
 	unsigned int size;
@@ -58,7 +60,7 @@ struct dma_pool {		/* the pool */
 };
 
 struct dma_page {		/* cacheable header for 'allocation' bytes */
-	struct list_head page_list;
+	struct rb_node page_node;
 	struct list_head avail_page_link;
 	void *vaddr;
 	dma_addr_t dma;
@@ -69,6 +71,11 @@ struct dma_page {		/* cacheable header for 'allocation' bytes */
 static DEFINE_MUTEX(pools_lock);
 static DEFINE_MUTEX(pools_reg_lock);
 
+static inline struct dma_page *rb_to_dma_page(struct rb_node *node)
+{
+	return rb_entry(node, struct dma_page, page_node);
+}
+
 static ssize_t pools_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	unsigned temp;
@@ -76,6 +83,7 @@ static ssize_t pools_show(struct device *dev, struct device_attribute *attr, cha
 	char *next;
 	struct dma_page *page;
 	struct dma_pool *pool;
+	struct rb_node *node;
 
 	next = buf;
 	size = PAGE_SIZE;
@@ -90,7 +98,10 @@ static ssize_t pools_show(struct device *dev, struct device_attribute *attr, cha
 		size_t blocks = 0;
 
 		spin_lock_irq(&pool->lock);
-		list_for_each_entry(page, &pool->page_list, page_list) {
+		for (node = rb_first(&pool->page_tree);
+		     node;
+		     node = rb_next(node)) {
+			page = rb_to_dma_page(node);
 			pages++;
 			blocks += page->in_use;
 		}
@@ -169,7 +180,7 @@ struct dma_pool *dma_pool_create(const char *name, struct device *dev,
 
 	retval->dev = dev;
 
-	INIT_LIST_HEAD(&retval->page_list);
+	retval->page_tree = RB_ROOT;
 	INIT_LIST_HEAD(&retval->avail_page_list);
 	spin_lock_init(&retval->lock);
 	retval->size = size;
@@ -213,6 +224,63 @@ struct dma_pool *dma_pool_create(const char *name, struct device *dev,
 }
 EXPORT_SYMBOL(dma_pool_create);
 
+/*
+ * Find the dma_page that manages the given DMA address.
+ */
+static struct dma_page *pool_find_page(struct dma_pool *pool, dma_addr_t dma)
+{
+	struct rb_node *node = pool->page_tree.rb_node;
+
+	while (node) {
+		struct dma_page *page = rb_to_dma_page(node);
+
+		if (dma < page->dma)
+			node = node->rb_left;
+		else if ((dma - page->dma) >= pool->allocation)
+			node = node->rb_right;
+		else
+			return page;
+	}
+	return NULL;
+}
+
+/*
+ * Insert a dma_page into the page_tree.
+ */
+static int pool_insert_page(struct dma_pool *pool, struct dma_page *new_page)
+{
+	dma_addr_t dma = new_page->dma;
+	struct rb_node **node = &(pool->page_tree.rb_node), *parent = NULL;
+
+	while (*node) {
+		struct dma_page *this_page = rb_to_dma_page(*node);
+
+		parent = *node;
+		if (dma < this_page->dma)
+			node = &((*node)->rb_left);
+		else if (likely((dma - this_page->dma) >= pool->allocation))
+			node = &((*node)->rb_right);
+		else {
+			/*
+			 * A page that overlaps the new DMA range is already
+			 * present in the tree.  This should not happen.
+			 */
+			WARN(1,
+			     "%s: %s: DMA address overlap: old %pad new %pad len %u\n",
+			     dev_name(pool->dev),
+			     pool->name, &this_page->dma, &dma,
+			     pool->allocation);
+			return -1;
+		}
+	}
+
+	/* Add new node and rebalance tree. */
+	rb_link_node(&new_page->page_node, parent, node);
+	rb_insert_color(&new_page->page_node, &pool->page_tree);
+
+	return 0;
+}
+
 static void pool_initialise_page(struct dma_pool *pool, struct dma_page *page)
 {
 	unsigned int offset = 0;
@@ -276,8 +344,16 @@ static void pool_free_page(struct dma_pool *pool,
 		dma_free_coherent(pool->dev, pool->allocation, vaddr, dma);
 	}
 
-	list_del(&page->page_list);
 	list_del(&page->avail_page_link);
+
+	/*
+	 * If the pool is being destroyed, it is not safe to modify the
+	 * page_tree while iterating over it, and it is also unnecessary since
+	 * the whole tree will be discarded anyway.
+	 */
+	if (!destroying_pool)
+		rb_erase(&page->page_node, &pool->page_tree);
+
 	kfree(page);
 }
 
@@ -291,7 +367,7 @@ static void pool_free_page(struct dma_pool *pool,
  */
 void dma_pool_destroy(struct dma_pool *pool)
 {
-	struct dma_page *page;
+	struct dma_page *page, *tmp;
 	bool empty = false;
 
 	if (unlikely(!pool))
@@ -307,9 +383,10 @@ void dma_pool_destroy(struct dma_pool *pool)
 		device_remove_file(pool->dev, &dev_attr_pools);
 	mutex_unlock(&pools_reg_lock);
 
-	while ((page = list_first_entry_or_null(&pool->page_list,
-						struct dma_page,
-						page_list))) {
+	rbtree_postorder_for_each_entry_safe(page,
+					     tmp,
+					     &pool->page_tree,
+					     page_node) {
 		pool_free_page(pool, page, true);
 	}
 
@@ -353,7 +430,15 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 
 	spin_lock_irqsave(&pool->lock, flags);
 
-	list_add(&page->page_list, &pool->page_list);
+	if (unlikely(pool_insert_page(pool, page))) {
+		/*
+		 * This should not happen, so something must have gone horribly
+		 * wrong.  Instead of crashing, intentionally leak the memory
+		 * and make for the exit.
+		 */
+		spin_unlock_irqrestore(&pool->lock, flags);
+		return NULL;
+	}
 	list_add(&page->avail_page_link, &pool->avail_page_list);
  ready:
 	page->in_use++;
@@ -395,19 +480,6 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 }
 EXPORT_SYMBOL(dma_pool_alloc);
 
-static struct dma_page *pool_find_page(struct dma_pool *pool, dma_addr_t dma)
-{
-	struct dma_page *page;
-
-	list_for_each_entry(page, &pool->page_list, page_list) {
-		if (dma < page->dma)
-			continue;
-		if ((dma - page->dma) < pool->allocation)
-			return page;
-	}
-	return NULL;
-}
-
 /**
  * dma_pool_free - put block back into dma pool
  * @pool: the dma pool holding the block
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
