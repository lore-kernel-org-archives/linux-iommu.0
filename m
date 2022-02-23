Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F03C433FE
	for <iommu@archiver.kernel.org>; Wed, 23 Feb 2022 04:30:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 702A660F1F;
	Wed, 23 Feb 2022 04:30:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YgodPZCO1xQi; Wed, 23 Feb 2022 04:30:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EC49E60F01;
	Wed, 23 Feb 2022 04:30:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3322C0077;
	Wed, 23 Feb 2022 04:30:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DAE9C0011;
 Wed, 23 Feb 2022 04:30:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5C68340912;
 Wed, 23 Feb 2022 04:30:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sent.com header.b="MaHS+Bxi";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="c9KPmEd9"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UHpnbONfIMP5; Wed, 23 Feb 2022 04:30:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4CE3D403B8;
 Wed, 23 Feb 2022 04:30:48 +0000 (UTC)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailnew.nyi.internal (Postfix) with ESMTP id 71845580128;
 Tue, 22 Feb 2022 23:30:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Tue, 22 Feb 2022 23:30:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
 :cc:content-transfer-encoding:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to
 :reply-to:sender:subject:subject:to:to; s=fm2; bh=6op2g5Pi/H1fvY
 7d4H27YwcHBzLcCooAQhUwAgYSlCo=; b=MaHS+BxiJaaAvAh5SusSfM5S1gLF78
 auPNkjQbEjeDqdNCMRy6U+Tg5zDlHUBCED2hSE1MHZTzLz6ndF6aw2Jsl4AUupNX
 /oG4q6Cd4CaBnRJ4s8j6YkN7X/QqFabEsHHare79s0rreKfMrsepvoMq1QicIYME
 gBVZ3GuKSV3h6lBGPH7FQ3qJMFl49sEcJ6Qq/dM+EwEna4SnRkpkdXJIUuoXlclw
 EzS4NorwlF3qRkxtfOEVQJEGCDeOT1qLw3Z8Ma3icNef3UsqkLP2fL0GZ+yLULUn
 rS+iOMtKvpsSmfVovd82jjLF5AMDWIBuZ5YMVBmAv8JmPlzMhofCYWuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=6op2g5Pi/H1fvY7d4H27YwcHBzLcCooAQhUwAgYSlCo=; b=c9KPmEd9
 SOkHcW49EdqxqLc8whma1Ke+K2ANiIy/L1rAMT8AaMhh+uLs0YPKVa/+LMtADjBz
 Ben7jgGRWln967nyfA+soQ7pDZBKCFbbY5qO9vASgH/SoMKwSqhCX+FC46Yd6nWw
 UMACguwy74FCoNYijTVdrXHOM2Q79VCB+Fim1xAB29lsIMS5xpFt1fWZ6QA313Xl
 mcgIzz7+st9K27K3fk1D/EdcbDXAXJzvGRe03ZsnurMf6bKqIWBZtk07gT7ThA4p
 pb5TrmoPJg/wbzd3ZwOhHtzawMZdZ0P3VBBKl3ZL4HlZcMl9hyLKzMMwM11ibT64
 xW0iq0JIlgA8Pw==
X-ME-Sender: <xms:d7gVYkSXfOOBb7jOKKSr7ZTD9UaCTC1x6iz21Tb_N5_vh6zJ8V7Iyg>
 <xme:d7gVYhycmX5wj0eFfYVy3htLeGrrrlFMJ-_BmR5EMPEwjGTkHJHwe6uPa-Tqcfcib
 a-GkqiPi7ijqFv4jQ>
X-ME-Received: <xmr:d7gVYh342BJDfMI1pafvy0vnvLwntymfnpRYbz12aQQzobomML7X2qAomCiwI_SNkCxfI4fP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeelgdejudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
 nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeeuvd
 euudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
 htrdgtohhm
X-ME-Proxy: <xmx:d7gVYoAe6xofHpnlo_QJpRGzL-MwX89kfi2Vq7y8nuOsj3221ai3QA>
 <xmx:d7gVYtjAxg3Poyy6iRCzwOORt6lffn3kj5M7heaJb_Tl2qRoA85RzQ>
 <xmx:d7gVYkrI6AaA8EStDJxGqo3CClcPETEnsNZNYMW2KfZRisLAtN4ojg>
 <xmx:d7gVYlzEJvTjn-iWlR3RvPMYQXmzyyNea301g1sP82NSgfj-3oB5iQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Feb 2022 23:30:46 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Subject: [PATCH v6 2/5] mm: page_isolation: check specified range for
 unmovable pages
Date: Tue, 22 Feb 2022 23:30:34 -0500
Message-Id: <20220223043037.715205-3-zi.yan@sent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220223043037.715205-1-zi.yan@sent.com>
References: <20220223043037.715205-1-zi.yan@sent.com>
MIME-Version: 1.0
Cc: Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Oscar Salvador <osalvador@suse.de>,
 Robin Murphy <robin.murphy@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Mike Rapoport <rppt@kernel.org>,
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
 include/linux/page-isolation.h | 10 ++++++++
 mm/page_alloc.c                | 13 +---------
 mm/page_isolation.c            | 47 +++++++++++++++++++++-------------
 3 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index e14eddf6741a..eb4a208fe907 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -15,6 +15,16 @@ static inline bool is_migrate_isolate(int migratetype)
 {
 	return migratetype == MIGRATE_ISOLATE;
 }
+static inline unsigned long pfn_max_align_down(unsigned long pfn)
+{
+	return ALIGN_DOWN(pfn, MAX_ORDER_NR_PAGES);
+}
+
+static inline unsigned long pfn_max_align_up(unsigned long pfn)
+{
+	return ALIGN(pfn, MAX_ORDER_NR_PAGES);
+}
+
 #else
 static inline bool has_isolate_pageblock(struct zone *zone)
 {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 228751019fd8..b900315657cf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8949,16 +8949,6 @@ void *__init alloc_large_system_hash(const char *tablename,
 }
 
 #ifdef CONFIG_CONTIG_ALLOC
-static unsigned long pfn_max_align_down(unsigned long pfn)
-{
-	return ALIGN_DOWN(pfn, MAX_ORDER_NR_PAGES);
-}
-
-static unsigned long pfn_max_align_up(unsigned long pfn)
-{
-	return ALIGN(pfn, MAX_ORDER_NR_PAGES);
-}
-
 #if defined(CONFIG_DYNAMIC_DEBUG) || \
 	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
 /* Usage: See admin-guide/dynamic-debug-howto.rst */
@@ -9103,8 +9093,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	 * put back to page allocator so that buddy can use them.
 	 */
 
-	ret = start_isolate_page_range(pfn_max_align_down(start),
-				       pfn_max_align_up(end), migratetype, 0);
+	ret = start_isolate_page_range(start, end, migratetype, 0);
 	if (ret)
 		return ret;
 
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index b34f1310aeaa..e0afc3ee8cf9 100644
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
@@ -156,7 +166,8 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	 * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
 	 * We just check MOVABLE pages.
 	 */
-	unmovable = has_unmovable_pages(zone, page, migratetype, isol_flags);
+	unmovable = has_unmovable_pages(zone, page, migratetype, isol_flags,
+				start_pfn, end_pfn);
 	if (!unmovable) {
 		unsigned long nr_pages;
 		int mt = get_pageblock_migratetype(page);
@@ -267,7 +278,6 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * be MIGRATE_ISOLATE.
  * @start_pfn:		The lower PFN of the range to be isolated.
  * @end_pfn:		The upper PFN of the range to be isolated.
- *			start_pfn/end_pfn must be aligned to pageblock_order.
  * @migratetype:	Migrate type to set in error recovery.
  * @flags:		The following flags are allowed (they can be combined in
  *			a bit mask)
@@ -309,15 +319,16 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 	unsigned long pfn;
 	struct page *page;
 
-	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
-	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
+	unsigned long isolate_start = pfn_max_align_down(start_pfn);
+	unsigned long isolate_end = pfn_max_align_up(end_pfn);
 
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
