Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9954DC43217
	for <iommu@archiver.kernel.org>; Wed, 19 Jan 2022 19:06:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4786260EB8;
	Wed, 19 Jan 2022 19:06:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lj8-etMqGsde; Wed, 19 Jan 2022 19:06:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 03EE260BA0;
	Wed, 19 Jan 2022 19:06:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3A88C0039;
	Wed, 19 Jan 2022 19:06:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60CDCC0039;
 Wed, 19 Jan 2022 19:06:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 415C14056E;
 Wed, 19 Jan 2022 19:06:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sent.com header.b="uIf7nzNs";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="RbfMHHvF"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hw-Vnesejg1t; Wed, 19 Jan 2022 19:06:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1FBBD40260;
 Wed, 19 Jan 2022 19:06:40 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailnew.nyi.internal (Postfix) with ESMTP id 6AA0D580726;
 Wed, 19 Jan 2022 14:06:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Wed, 19 Jan 2022 14:06:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references:reply-to
 :mime-version:content-transfer-encoding; s=fm2; bh=Hn66oL30Zi6g6
 GLNLl2f2H2PZx9SgKqzr8HZm/YIRtU=; b=uIf7nzNsXkkqBiG0M/gSgF3jCPAuF
 KIrJjg0Dg8MPqEZti0o9bsBj8h5ZmSqDQTCtYQcMV/cPXN9dYZ9rEBweIIO1sQHT
 KlOvJMLMZsH3rfWtly/Udsqcop+hcQ+qLO+Hv/nGDQXR7BcdZO1Npq3tDpF7b940
 a+XAYRQQ0p2ZiXFiR9cOoMJlKydnMQLyOz4Wx0S2eSsRbaY5TNbhMY2Dn7Ii3NWb
 SwuvnUyIMmoOgFh2PPNXqBO9vRwHhuprCku472rSK5a+bYUrnURQkqvZiMcdnqG+
 d71fDs3oB6oBewhGcnisUMFzD14bE+b+lCh8YhSqDUZz5Rn+RETAghdtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=Hn66oL30Zi6g6GLNLl2f2H2PZx9SgKqzr8HZm/YIRtU=; b=RbfMHHvF
 /wKHEWVf45vWaEWXG5ACqe+JdA0V0yVh/+Wz4L30I7Q/tiCddeE6EEgP6upOuXtf
 iKHFKVEileiSmbAo40Ym73zu3hhoedGMpOBbZhaFk8LZiSRq5DAEZjOjuRn2yyIW
 t59sn7P0HdvBnTnlK9rwgav56mLNAXFdHD5fKQXB0orLQTNl1Dr3nJFD8ZG2aZHJ
 ARQBFcCj2OlieAcEi6pD2dknf3w6jfl4Zo0PeTHZO2pRrsAW5Mg9GDFvaNhIk7k3
 RAQ1ZHIor1hzJMx9nsMiSgXYJ4RcvfsTefQ9+RTt0anVGR2LGk+wrFN7tEXf14S+
 tCCQhf1mncRK7g==
X-ME-Sender: <xms:PWHoYe5eeoxI47xIoYWUEKusZjTmmWKJOHTGRhyj8J4Ld2EYn4tsaQ>
 <xme:PWHoYX5bwvAvTgjZWhMXz7K2Jz36kCT-1koC_1ueRncf1B_3hAgRVGbuSxdA_K0CZ
 ilShUVljFMj1fHZgg>
X-ME-Received: <xmr:PWHoYdeAfLRfAsc6gn2b3NjEKUCYASqU5HZeyprDSYhULs9BZLm_zpmwBICWsu6btdU8VR9U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeigdeivdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
 nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeeuvd
 euudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
 htrdgtohhm
X-ME-Proxy: <xmx:PWHoYbJx2zEV4dncR3jjk8tBWuKEKPJUPrOP1lCVP98OgGRXHKUwPQ>
 <xmx:PWHoYSIZ8cpwtl4cZTBpfEX__CPrQZgJUaG1ZV4IbSGh7d7XaC1Uxg>
 <xmx:PWHoYczbei3u-jifgY1EEaooelisGREhdQgZWyolJYBZeI3O-PmPSg>
 <xmx:PWHoYUAMBeOVwIEogAEmzWIbx_1UPqfGRbRpvokKq_R_gBKWpwkrxQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jan 2022 14:06:36 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Subject: [PATCH v4 3/7] mm: page_isolation: check specified range for
 unmovable pages
Date: Wed, 19 Jan 2022 14:06:19 -0500
Message-Id: <20220119190623.1029355-4-zi.yan@sent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220119190623.1029355-1-zi.yan@sent.com>
References: <20220119190623.1029355-1-zi.yan@sent.com>
MIME-Version: 1.0
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

Enable set_migratetype_isolate() to check specified sub-range for
unmovable pages during isolation. Page isolation is done
at max(MAX_ORDER_NR_PAEGS, pageblock_nr_pages) granularity, but not all
pages within that granularity are intended to be isolated. For example,
alloc_contig_range(), which uses page isolation, allows ranges without
alignment. This commit makes unmovable page check only look for
interesting pages, so that page isolation can succeed for any
non-overlapping ranges.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/page-isolation.h |  1 +
 mm/memory_hotplug.c            | 12 +++++++-
 mm/page_alloc.c                |  2 +-
 mm/page_isolation.c            | 53 +++++++++++++++++++++-------------
 4 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index e14eddf6741a..a4d2687ed4e6 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -42,6 +42,7 @@ int move_freepages_block(struct zone *zone, struct page *page,
  */
 int
 start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
+			 unsigned long isolate_start, unsigned long isolate_end,
 			 unsigned migratetype, int flags);
 
 /*
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0139b77c51d5..5db84c3fa882 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1901,8 +1901,18 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	zone_pcp_disable(zone);
 	lru_cache_disable();
 
-	/* set above range as isolated */
+	/*
+	 * set above range as isolated
+	 *
+	 * start_pfn and end_pfn are the same as isolate_start and isolate_end,
+	 * because start_pfn and end_pfn are already PAGES_PER_SECTION
+	 * (>= MAX_ORDER_NR_PAGES) aligned; if start_pfn is
+	 * pageblock_nr_pages aligned in memmap_on_memory case, there is no
+	 * need to isolate pages before start_pfn, since they are used by
+	 * memmap thus not user visible.
+	 */
 	ret = start_isolate_page_range(start_pfn, end_pfn,
+				       start_pfn, end_pfn,
 				       MIGRATE_MOVABLE,
 				       MEMORY_OFFLINE | REPORT_FAILURE);
 	if (ret) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1d812268c2a9..812cf557b20f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9016,7 +9016,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	 * put back to page allocator so that buddy can use them.
 	 */
 
-	ret = start_isolate_page_range(pfn_max_align_down(start),
+	ret = start_isolate_page_range(start, end, pfn_max_align_down(start),
 				       pfn_max_align_up(end), migratetype, 0);
 	if (ret)
 		return ret;
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 6c841274bf46..d17ad9a7d4bf 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -16,7 +16,8 @@
 #include <trace/events/page_isolation.h>
 
 /*
- * This function checks whether pageblock includes unmovable pages or not.
+ * This function checks whether pageblock within [start_pfn, end_pfn) includes
+ * unmovable pages or not.
  *
  * PageLRU check without isolation or lru_lock could race so that
  * MIGRATE_MOVABLE block might include unmovable pages. And __PageMovable
@@ -29,11 +30,14 @@
  *
  */
 static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
-				 int migratetype, int flags)
+				 int migratetype, int flags,
+				 unsigned long start_pfn, unsigned long end_pfn)
 {
-	unsigned long iter = 0;
-	unsigned long pfn = page_to_pfn(page);
-	unsigned long offset = pfn % pageblock_nr_pages;
+	unsigned long first_pfn = max(page_to_pfn(page), start_pfn);
+	unsigned long pfn = first_pfn;
+	unsigned long last_pfn = min(ALIGN(pfn + 1, pageblock_nr_pages), end_pfn);
+
+	page = pfn_to_page(pfn);
 
 	if (is_migrate_cma_page(page)) {
 		/*
@@ -47,8 +51,8 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 		return page;
 	}
 
-	for (; iter < pageblock_nr_pages - offset; iter++) {
-		page = pfn_to_page(pfn + iter);
+	for (pfn = first_pfn; pfn < last_pfn; pfn++) {
+		page = pfn_to_page(pfn);
 
 		/*
 		 * Both, bootmem allocations and memory holes are marked
@@ -85,7 +89,7 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 			}
 
 			skip_pages = compound_nr(head) - (page - head);
-			iter += skip_pages - 1;
+			pfn += skip_pages - 1;
 			continue;
 		}
 
@@ -97,7 +101,7 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 		 */
 		if (!page_ref_count(page)) {
 			if (PageBuddy(page))
-				iter += (1 << buddy_order(page)) - 1;
+				pfn += (1 << buddy_order(page)) - 1;
 			continue;
 		}
 
@@ -134,7 +138,13 @@ static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 	return NULL;
 }
 
-static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags)
+/*
+ * This function set pageblock migratetype to isolate if no unmovable page is
+ * present in [start_pfn, end_pfn). The pageblock must be within
+ * [start_pfn, end_pfn).
+ */
+static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags,
+			unsigned long start_pfn, unsigned long end_pfn)
 {
 	struct zone *zone = page_zone(page);
 	struct page *unmovable;
@@ -156,7 +166,7 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	 * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
 	 * We just check MOVABLE pages.
 	 */
-	unmovable = has_unmovable_pages(zone, page, migratetype, isol_flags);
+	unmovable = has_unmovable_pages(zone, page, migratetype, isol_flags, start_pfn, end_pfn);
 	if (!unmovable) {
 		unsigned long nr_pages;
 		int mt = get_pageblock_migratetype(page);
@@ -265,8 +275,12 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
 /**
  * start_isolate_page_range() - make page-allocation-type of range of pages to
  * be MIGRATE_ISOLATE.
- * @start_pfn:		The lower PFN of the range to be isolated.
- * @end_pfn:		The upper PFN of the range to be isolated.
+ * @start_pfn:		The lower PFN of the range to be checked for
+ *			possibility of isolation.
+ * @end_pfn:		The upper PFN of the range to be checked for
+ *			possibility of isolation.
+ * @isolate_start:		The lower PFN of the range to be isolated.
+ * @isolate_end:		The upper PFN of the range to be isolated.
  *			start_pfn/end_pfn must be aligned to pageblock_order.
  * @migratetype:	Migrate type to set in error recovery.
  * @flags:		The following flags are allowed (they can be combined in
@@ -304,20 +318,19 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * Return: 0 on success and -EBUSY if any part of range cannot be isolated.
  */
 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
+			     unsigned long isolate_start, unsigned long isolate_end,
 			     unsigned migratetype, int flags)
 {
 	unsigned long pfn;
 	struct page *page;
 
-	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
-	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
-
-	for (pfn = start_pfn;
-	     pfn < end_pfn;
+	for (pfn = isolate_start;
+	     pfn < isolate_end;
 	     pfn += pageblock_nr_pages) {
 		page = __first_valid_page(pfn, pageblock_nr_pages);
-		if (page && set_migratetype_isolate(page, migratetype, flags)) {
-			undo_isolate_page_range(start_pfn, pfn, migratetype);
+		if (page && set_migratetype_isolate(page, migratetype, flags,
+					start_pfn, end_pfn)) {
+			undo_isolate_page_range(isolate_start, pfn, migratetype);
 			return -EBUSY;
 		}
 	}
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
