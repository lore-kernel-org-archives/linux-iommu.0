Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9920C4332F
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 23:36:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CBDB80C6A;
	Thu,  9 Dec 2021 23:36:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HvmXDnpJ8A3L; Thu,  9 Dec 2021 23:36:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AAD8C80C68;
	Thu,  9 Dec 2021 23:36:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE162C006E;
	Thu,  9 Dec 2021 23:36:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 762C2C0012;
 Thu,  9 Dec 2021 23:04:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 631F442635;
 Thu,  9 Dec 2021 23:04:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sent.com header.b="vkmJpXnC";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="oDj/PPWi"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JwpdYNr0kQbB; Thu,  9 Dec 2021 23:04:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com
 [66.111.4.221])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2B17D42622;
 Thu,  9 Dec 2021 23:04:41 +0000 (UTC)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailnew.nyi.internal (Postfix) with ESMTP id 4FFEC58025E;
 Thu,  9 Dec 2021 18:04:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 09 Dec 2021 18:04:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references:reply-to
 :mime-version:content-transfer-encoding; s=fm2; bh=2s2DRFCWo6SJF
 dg2WL/KkkfiW4T/Z/OJbwdjocA6xrw=; b=vkmJpXnCf/WYOZLob1cmUKqPEQnql
 TAGXNhH/A8TLl24AyGbNBZve34nQFnkTVUvHf7QFcnIlG4r7mGoshZi3w2tcOu+Q
 9059RYX9uvMWah0MpXh6W9+QeNoAiq0rZOo/9/KRJkBkqkj45rJpzrlsDfGjyZPJ
 9aYPrguNfM7T9SV/bX8iJebMz5XxN+yn0VLb5CNnY93AgcsN9qL49k4C7U984IX4
 hhPp9YgU6Y8JgcZtTd6+KZbJiQf5/o8S1M/6sBWTjzxnveuVrTYQCZgFwyt2fo8N
 coPI+6JPT2Fp427yluN4cOOLzJXhyOaMgUs6Bt5AASHHG6t6807lcB+4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=2s2DRFCWo6SJFdg2WL/KkkfiW4T/Z/OJbwdjocA6xrw=; b=oDj/PPWi
 goi2C10Sr8rHKrLfBl/gXc2ccO/WAbm6gknAc4VEgDN8DeAF31JETt+CVO7LlnlO
 PfT1nwLzlc5E7DVUjaAf3EALSriWa7U6J9v/z6pYk0NZ351PSauP45pAl1e081jY
 +mRHG9gjs561z3Fvj1zv5pnP0UWTpDl8WhY6GWuE8JOjNPTqYLl9qcSNmc7bTgYQ
 qQ1PdYBnX5RxfaBkNea0838agImx3wEn6eTGhfLL8EJgxj2UhzcRGjpMyquxcy58
 LXs7BDepfWDPPFmhVJd+Y5p85xjrG2Jo07q9pnhy0StrkV8h7GEEe2xtmhdO26ym
 NSyYfMZD0NwFSg==
X-ME-Sender: <xms:iIuyYa-pBqjOzioyfq68JiUsVDmDU3Zbmj2nVvo-AjL9yo-pRpNVdQ>
 <xme:iIuyYauVk_63-sx2uOBa3f1m0Z2Y6XdRgb0gi4c66OgpV4MhEObT1fhbXTCGG0A6i
 Evi6oKGBjDOOQ7CQQ>
X-ME-Received: <xmr:iIuyYQC0Ujg6ZyZprWmRwCTmsREiJ8JhxNXVS9hdfuIPcROU01yHDGRQuICVyW3woMkGJRb2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrkedugddtgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
 nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeeuvd
 euudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
 htrdgtohhm
X-ME-Proxy: <xmx:iIuyYScQ0n3PpvKxTptaBYQW3XxtEWndMuwJQ6klsoi6uFpngboXeQ>
 <xmx:iIuyYfOuKz-9ZNSDxR8hy2GDV7g9AW21hE_57CjlMjqSliK86MAuVQ>
 <xmx:iIuyYclrsqdepmF2poCh7-Gj64xLhotDT4jBV29BjxugNrjOzDVREw>
 <xmx:iIuyYTlJu_LWWrWkiq0OOD1bhjJE58s4_qDOiIo4EKU26pYh41HfEQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Dec 2021 18:04:39 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 4/7] mm: make alloc_contig_range work at pageblock
 granularity
Date: Thu,  9 Dec 2021 18:04:11 -0500
Message-Id: <20211209230414.2766515-5-zi.yan@sent.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211209230414.2766515-1-zi.yan@sent.com>
References: <20211209230414.2766515-1-zi.yan@sent.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 09 Dec 2021 23:36:06 +0000
Cc: Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Eric Ren <renzhengeek@gmail.com>, virtualization@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 Vlastimil Babka <vbabka@suse.cz>
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
Reply-To: Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Zi Yan <ziy@nvidia.com>

alloc_contig_range() worked at MAX_ORDER-1 granularity to avoid merging
pageblocks with different migratetypes. It might unnecessarily convert
extra pageblocks at the beginning and at the end of the range. Change
alloc_contig_range() to work at pageblock granularity.

It is done by restoring pageblock types and split >pageblock_order free
pages after isolating at MAX_ORDER-1 granularity and migrating pages
away at pageblock granularity. The reason for this process is that
during isolation, some pages, either free or in-use, might have >pageblock
sizes and isolating part of them can cause free accounting issues.
Restoring the migratetypes of the pageblocks not in the interesting
range later is much easier.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/page_alloc.c | 169 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 149 insertions(+), 20 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 107a5f186d3b..5ffbeb1b7512 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8981,8 +8981,8 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 #ifdef CONFIG_CONTIG_ALLOC
 static unsigned long pfn_max_align_down(unsigned long pfn)
 {
-	return pfn & ~(max_t(unsigned long, MAX_ORDER_NR_PAGES,
-			     pageblock_nr_pages) - 1);
+	return ALIGN_DOWN(pfn, max_t(unsigned long, MAX_ORDER_NR_PAGES,
+				     pageblock_nr_pages));
 }
 
 static unsigned long pfn_max_align_up(unsigned long pfn)
@@ -9071,6 +9071,52 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 	return 0;
 }
 
+static inline int save_migratetypes(unsigned char *migratetypes,
+				unsigned long start_pfn, unsigned long end_pfn)
+{
+	unsigned long pfn = start_pfn;
+	int num = 0;
+
+	while (pfn < end_pfn) {
+		migratetypes[num] = get_pageblock_migratetype(pfn_to_page(pfn));
+		num++;
+		pfn += pageblock_nr_pages;
+	}
+	return num;
+}
+
+static inline int restore_migratetypes(unsigned char *migratetypes,
+				unsigned long start_pfn, unsigned long end_pfn)
+{
+	unsigned long pfn = start_pfn;
+	int num = 0;
+
+	while (pfn < end_pfn) {
+		set_pageblock_migratetype(pfn_to_page(pfn), migratetypes[num]);
+		num++;
+		pfn += pageblock_nr_pages;
+	}
+	return num;
+}
+
+static inline void split_free_page_into_pageblocks(struct page *free_page,
+				int order, struct zone *zone)
+{
+	unsigned long pfn;
+
+	spin_lock(&zone->lock);
+	del_page_from_free_list(free_page, zone, order);
+	for (pfn = page_to_pfn(free_page);
+	     pfn < page_to_pfn(free_page) + (1UL << order);
+	     pfn += pageblock_nr_pages) {
+		int mt = get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
+
+		__free_one_page(pfn_to_page(pfn), pfn, zone, pageblock_order,
+				mt, FPI_NONE);
+	}
+	spin_unlock(&zone->lock);
+}
+
 /**
  * alloc_contig_range() -- tries to allocate given range of pages
  * @start:	start PFN to allocate
@@ -9096,8 +9142,15 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 		       unsigned migratetype, gfp_t gfp_mask)
 {
 	unsigned long outer_start, outer_end;
+	unsigned long isolate_start = pfn_max_align_down(start);
+	unsigned long isolate_end = pfn_max_align_up(end);
+	unsigned long alloc_start = ALIGN_DOWN(start, pageblock_nr_pages);
+	unsigned long alloc_end = ALIGN(end, pageblock_nr_pages);
+	unsigned long num_pageblock_to_save;
 	unsigned int order;
 	int ret = 0;
+	unsigned char *saved_mt;
+	int num;
 
 	struct compact_control cc = {
 		.nr_migratepages = 0,
@@ -9111,11 +9164,30 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	};
 	INIT_LIST_HEAD(&cc.migratepages);
 
+	/*
+	 * TODO: make MIGRATE_ISOLATE a standalone bit to avoid overwriting
+	 * the exiting migratetype. Then, we will not need the save and restore
+	 * process here.
+	 */
+
+	/* Save the migratepages of the pageblocks before start and after end */
+	num_pageblock_to_save = (alloc_start - isolate_start) / pageblock_nr_pages
+				+ (isolate_end - alloc_end) / pageblock_nr_pages;
+	saved_mt =
+		kmalloc_array(num_pageblock_to_save,
+			      sizeof(unsigned char), GFP_KERNEL);
+	if (!saved_mt)
+		return -ENOMEM;
+
+	num = save_migratetypes(saved_mt, isolate_start, alloc_start);
+
+	num = save_migratetypes(&saved_mt[num], alloc_end, isolate_end);
+
 	/*
 	 * What we do here is we mark all pageblocks in range as
 	 * MIGRATE_ISOLATE.  Because pageblock and max order pages may
 	 * have different sizes, and due to the way page allocator
-	 * work, we align the range to biggest of the two pages so
+	 * work, we align the isolation range to biggest of the two so
 	 * that page allocator won't try to merge buddies from
 	 * different pageblocks and change MIGRATE_ISOLATE to some
 	 * other migration type.
@@ -9125,6 +9197,20 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	 * we are interested in).  This will put all the pages in
 	 * range back to page allocator as MIGRATE_ISOLATE.
 	 *
+	 * Afterwards, we restore the migratetypes of the pageblocks not
+	 * in range, split free pages spanning outside the range,
+	 * and put split free pages (at pageblock_order) to the right
+	 * migratetype list.
+	 *
+	 * NOTE: the above approach is used because it can cause free
+	 * page accounting issues during isolation, if a page, either
+	 * free or in-use, contains multiple pageblocks and we only
+	 * isolate a subset of them. For example, if only the second
+	 * pageblock is isolated from a page with 2 pageblocks, after
+	 * the page is free, it will be put in the first pageblock
+	 * migratetype list instead of having 2 pageblocks in two
+	 * separate migratetype lists.
+	 *
 	 * When this is done, we take the pages in range from page
 	 * allocator removing them from the buddy system.  This way
 	 * page allocator will never consider using them.
@@ -9135,10 +9221,9 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	 * put back to page allocator so that buddy can use them.
 	 */
 
-	ret = start_isolate_page_range(pfn_max_align_down(start),
-				       pfn_max_align_up(end), migratetype, 0);
+	ret = start_isolate_page_range(isolate_start, isolate_end, migratetype, 0);
 	if (ret)
-		return ret;
+		goto done;
 
 	drain_all_pages(cc.zone);
 
@@ -9174,6 +9259,19 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	 * isolated thus they won't get removed from buddy.
 	 */
 
+	/*
+	 * Restore migratetypes of pageblocks outside [start, end)
+	 * TODO: remove it when MIGRATE_ISOLATE becomes a standalone bit
+	 */
+
+	num = restore_migratetypes(saved_mt, isolate_start, alloc_start);
+
+	num = restore_migratetypes(&saved_mt[num], alloc_end, isolate_end);
+
+	/*
+	 * Split free page spanning [isolate_start, alloc_start) and put the
+	 * pageblocks in the right migratetype lists.
+	 */
 	order = 0;
 	outer_start = start;
 	while (!PageBuddy(pfn_to_page(outer_start))) {
@@ -9188,37 +9286,68 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 		order = buddy_order(pfn_to_page(outer_start));
 
 		/*
-		 * outer_start page could be small order buddy page and
-		 * it doesn't include start page. Adjust outer_start
-		 * in this case to report failed page properly
-		 * on tracepoint in test_pages_isolated()
+		 * split the free page has start page and put the pageblocks
+		 * in the right migratetype list
 		 */
-		if (outer_start + (1UL << order) <= start)
-			outer_start = start;
+		if (outer_start + (1UL << order) > start) {
+			struct page *free_page = pfn_to_page(outer_start);
+
+			split_free_page_into_pageblocks(free_page, order, cc.zone);
+		}
+	}
+
+	/*
+	 * Split free page spanning [alloc_end, isolate_end) and put the
+	 * pageblocks in the right migratetype list
+	 */
+	order = 0;
+	outer_end = end;
+	while (!PageBuddy(pfn_to_page(outer_end))) {
+		if (++order >= MAX_ORDER) {
+			outer_end = end;
+			break;
+		}
+		outer_end &= ~0UL << order;
+	}
+
+	if (outer_end != end) {
+		order = buddy_order(pfn_to_page(outer_end));
+
+		/*
+		 * split the free page has start page and put the pageblocks
+		 * in the right migratetype list
+		 */
+		VM_BUG_ON(outer_end + (1UL << order) <= end);
+		{
+			struct page *free_page = pfn_to_page(outer_end);
+
+			split_free_page_into_pageblocks(free_page, order, cc.zone);
+		}
 	}
 
 	/* Make sure the range is really isolated. */
-	if (test_pages_isolated(outer_start, end, 0)) {
+	if (test_pages_isolated(alloc_start, alloc_end, 0)) {
 		ret = -EBUSY;
 		goto done;
 	}
 
 	/* Grab isolated pages from freelists. */
-	outer_end = isolate_freepages_range(&cc, outer_start, end);
+	outer_end = isolate_freepages_range(&cc, alloc_start, alloc_end);
 	if (!outer_end) {
 		ret = -EBUSY;
 		goto done;
 	}
 
 	/* Free head and tail (if any) */
-	if (start != outer_start)
-		free_contig_range(outer_start, start - outer_start);
-	if (end != outer_end)
-		free_contig_range(end, outer_end - end);
+	if (start != alloc_start)
+		free_contig_range(alloc_start, start - alloc_start);
+	if (end != alloc_end)
+		free_contig_range(end, alloc_end - end);
 
 done:
-	undo_isolate_page_range(pfn_max_align_down(start),
-				pfn_max_align_up(end), migratetype);
+	kfree(saved_mt);
+	undo_isolate_page_range(alloc_start,
+				alloc_end, migratetype);
 	return ret;
 }
 EXPORT_SYMBOL(alloc_contig_range);
-- 
2.33.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
