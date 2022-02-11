Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D06C433F5
	for <iommu@archiver.kernel.org>; Fri, 11 Feb 2022 16:41:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC7E5416E5;
	Fri, 11 Feb 2022 16:41:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G0uGe3W-e0Lf; Fri, 11 Feb 2022 16:41:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7D4234091E;
	Fri, 11 Feb 2022 16:41:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 581BEC001A;
	Fri, 11 Feb 2022 16:41:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF305C001A;
 Fri, 11 Feb 2022 16:41:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A613D83487;
 Fri, 11 Feb 2022 16:41:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sent.com header.b="RX+guAPK";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="iVnxPXU0"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 11RuqBy70dir; Fri, 11 Feb 2022 16:41:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com
 [66.111.4.221])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D1EC883422;
 Fri, 11 Feb 2022 16:41:49 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 261C6580376;
 Fri, 11 Feb 2022 11:41:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Fri, 11 Feb 2022 11:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
 :cc:content-transfer-encoding:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to
 :reply-to:sender:subject:subject:to:to; s=fm2; bh=TkAiSDDqHj52sQ
 QpS3No7LU7FQn/P0B4WvW+CLbRBDY=; b=RX+guAPK53EbPT+OY+vpQb5TtsbFIU
 ZmLWgYD4H5jvi4GUeeMVGCAXfvGXwg2nNX4Wt64mYQt7bCj+YaXETqx7X3oqQa3R
 cV1dCprYGVOsBqZMjStHt1ylDGBNvQi43FQudL9mMf+J5hJY9HQu/pvBZNLPmMiG
 5JW9Jd5ygnP+H3CMuKvKQ6RWbjoFqVPuKKFvBSedVZv8cQUKFgb+2PrvEPm/69zG
 6Ar9HRuN1uBPLZnkfesb2VBreuz1g4oPCGjvhHX5AEXByp1VCCtLz890TAxxEwYF
 1KebR2zyQny0/sL5+iqC5IVH/MLM6QfspFhpHW9mo14tgoT6LRqEdejA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=TkAiSDDqHj52sQQpS3No7LU7FQn/P0B4WvW+CLbRBDY=; b=iVnxPXU0
 4v3uW6oEWaQ9G8CXU0jDyjtvDCPA/AJd+gLIWBITBQHC4vbFywDecuKk+WV9wQZv
 NzJLwsY5cI0vo2nn8MHHjwc7WD/dBKOCcbDUwMgqhGp3wjJfKNuYBpNR97+nnE5k
 fWeN0IdGilm0mTbkKFVwnI7HXeHMDbml4C0Z311M485Iko5YOYLCIHuem23Klc3W
 Q4M9ZukWGFOKJQFDg5DXRqfTsLSiqSIXbPPZTdlo8CVEkGkFafSO6UfAK/yskgz1
 1vmyc7T/thVED+4T03i06hluA/ZsbnuwtWbjpM5PSf3zCTpTaUspeSnaHKPKIIFF
 jwIUezBJJ2Y30w==
X-ME-Sender: <xms:ypEGYmIuDKK2k51RzRGWGKTVDX38PrJY-DL7AEtzB4LKniWCofkM-A>
 <xme:ypEGYuLnKfeGf7pJfv2YmZHEV63MUyYUAxK4dR53b2RNGG9T-KJWc5wuTvSpkFmiI
 mzZiJLHgTy7_USb4w>
X-ME-Received: <xmr:ypEGYmsf5Zpdb5HMDRfqGLQQKIMJYuelq9SnHTibV2knJjPVm34yBsG3z3Sh55R7Dns3elGD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieefgdeltdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
 nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeeuvd
 euudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
 htrdgtohhm
X-ME-Proxy: <xmx:ypEGYrbuT9Oa34-nNeugxpS8mvpjVdx2zsUjkgEqmQFKSGYRjIF9VA>
 <xmx:ypEGYtbri-nnGIuNfYMNbkYlVxfRRagxOipZYc3C0T5MYFEchyjc0A>
 <xmx:ypEGYnBKpKRwK6xw6LLWbQHSWmGbQ6TUOiEZqjmQYHICI_5QbPSvLQ>
 <xmx:zJEGYjyZr-KrSuAbClDp6SGTTgE184bIZFPjtfPMPNPamoUoIG9cdw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Feb 2022 11:41:46 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Subject: [PATCH v5 2/6] mm: page_isolation: check specified range for
 unmovable pages
Date: Fri, 11 Feb 2022 11:41:31 -0500
Message-Id: <20220211164135.1803616-3-zi.yan@sent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220211164135.1803616-1-zi.yan@sent.com>
References: <20220211164135.1803616-1-zi.yan@sent.com>
MIME-Version: 1.0
Cc: Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Oscar Salvador <osalvador@suse.de>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
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
 include/linux/page-isolation.h | 12 +++++++++
 mm/page_alloc.c                | 15 +----------
 mm/page_isolation.c            | 46 +++++++++++++++++++++-------------
 3 files changed, 41 insertions(+), 32 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index e14eddf6741a..4ef7be6def83 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -15,6 +15,18 @@ static inline bool is_migrate_isolate(int migratetype)
 {
 	return migratetype == MIGRATE_ISOLATE;
 }
+static inline unsigned long pfn_max_align_down(unsigned long pfn)
+{
+	return ALIGN_DOWN(pfn, max_t(unsigned long, MAX_ORDER_NR_PAGES,
+				     pageblock_nr_pages));
+}
+
+static inline unsigned long pfn_max_align_up(unsigned long pfn)
+{
+	return ALIGN(pfn, max_t(unsigned long, MAX_ORDER_NR_PAGES,
+				pageblock_nr_pages));
+}
+
 #else
 static inline bool has_isolate_pageblock(struct zone *zone)
 {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e2c6a67fc386..62ef78f3d771 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8963,18 +8963,6 @@ void *__init alloc_large_system_hash(const char *tablename,
 }
 
 #ifdef CONFIG_CONTIG_ALLOC
-static unsigned long pfn_max_align_down(unsigned long pfn)
-{
-	return pfn & ~(max_t(unsigned long, MAX_ORDER_NR_PAGES,
-			     pageblock_nr_pages) - 1);
-}
-
-static unsigned long pfn_max_align_up(unsigned long pfn)
-{
-	return ALIGN(pfn, max_t(unsigned long, MAX_ORDER_NR_PAGES,
-				pageblock_nr_pages));
-}
-
 #if defined(CONFIG_DYNAMIC_DEBUG) || \
 	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
 /* Usage: See admin-guide/dynamic-debug-howto.rst */
@@ -9119,8 +9107,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	 * put back to page allocator so that buddy can use them.
 	 */
 
-	ret = start_isolate_page_range(pfn_max_align_down(start),
-				       pfn_max_align_up(end), migratetype, 0);
+	ret = start_isolate_page_range(start, end, migratetype, 0);
 	if (ret)
 		return ret;
 
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index b34f1310aeaa..64d093ab83ec 100644
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
@@ -267,7 +277,6 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * be MIGRATE_ISOLATE.
  * @start_pfn:		The lower PFN of the range to be isolated.
  * @end_pfn:		The upper PFN of the range to be isolated.
- *			start_pfn/end_pfn must be aligned to pageblock_order.
  * @migratetype:	Migrate type to set in error recovery.
  * @flags:		The following flags are allowed (they can be combined in
  *			a bit mask)
@@ -309,15 +318,16 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
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
