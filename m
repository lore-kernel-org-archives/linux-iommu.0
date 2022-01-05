Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477E9C433EF
	for <iommu@archiver.kernel.org>; Wed,  5 Jan 2022 21:48:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF03F832C7;
	Wed,  5 Jan 2022 21:48:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QAoXUtF6bvgK; Wed,  5 Jan 2022 21:48:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AB436832B0;
	Wed,  5 Jan 2022 21:48:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 402F6C0073;
	Wed,  5 Jan 2022 21:48:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D888EC001E;
 Wed,  5 Jan 2022 21:48:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B86FE428F5;
 Wed,  5 Jan 2022 21:48:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sent.com header.b="S0iFzugi";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="LJN2Ozob"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kkFqB1ZxvS3q; Wed,  5 Jan 2022 21:48:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C24A1428F2;
 Wed,  5 Jan 2022 21:48:26 +0000 (UTC)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailnew.nyi.internal (Postfix) with ESMTP id 0152D580510;
 Wed,  5 Jan 2022 16:48:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 05 Jan 2022 16:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references:reply-to
 :mime-version:content-transfer-encoding; s=fm2; bh=ssIavQd0t027n
 j+SJdZ+R89EjFohei8nsJIZDjq+gAc=; b=S0iFzugiHfWc3pkd+CZdBT6nLqkU1
 O293WHqzAfo4z2NG7KeyjrOwbHMOOslgSqp/nzgDYhgtHbQy1TP5B107IQwfKrV8
 sEDHbFP1mzRmf/bsMkZZ7+2pcaq0OjVwXSzmeIevlmdj0dGB74IDIhFKz9IeN+9N
 iEOV2a9f3zb+Q4MA+mVXYAU6GfHusjfsdpI8K78PATIFGaq7Y/d6Mq7pnJoAcUYA
 9t/UBNDiCl8irKYbP4TG3sHTQN1b3IZRkuFRYdHXRZtYVMgM7MLwU70CNVDKvBw8
 beX2PYbUiLK11zp70mQu+GnKdoHILPBnmmksVpxTSZHVqyVMG6Jdp07+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=ssIavQd0t027nj+SJdZ+R89EjFohei8nsJIZDjq+gAc=; b=LJN2Ozob
 Zz3Qf1m9F8UnBOu76cytEY9asp+rvN52Rrd3ey/iblpRlyPSEJP8LwIE09PVGXL1
 HkPLjcnDoTYkde2g6ZdmiTjinrkRQchiWLtI0g86iG7g0bP3QS7t+ridmDGtdgrE
 C7k2cvCS03Lqd4KYR9k5z9ysNwlR1BFEwFeJoN4uFz3/XQ4C+/mXMtj2J/4nnRf3
 CGhK7Gqw5TiVw9sJW5LYNs2M+hd4v/dIjr9UmUd8Ofc85jh8ZMgWmMcJkeUwA361
 Mn8Zye4hve17YR89Pg0yBCRGikTbApdB58nmr7svo5XlODiH2tKtbvrz4pIM/xsp
 IfqqtAyzNHJAVA==
X-ME-Sender: <xms:JxLWYQbSKxIAWusdsMHZ_FG7eUghRU7XstJa5q08AhFFerrLgd8Qlw>
 <xme:JxLWYbbs1zTwsLBVFMzjzpz5WF_1SWSgdznOBsmDlbr7O_1OXQOQiENWTIPGdkq9n
 jqFaAUIMp0VjdNJWg>
X-ME-Received: <xmr:JxLWYa-lw4Fscui_UDsGBqRlOEPYosssifWw6MrwXLlh2eZGvWhYeIudyIyo2hzgJZjIafL_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudefjedgieekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
 rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepkeeiue
 elvddtteeujeehtdegheejledvtdetgfeileejfeeghfeftdeuffefleevnecuffhomhgr
 ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:JxLWYaoxYMvHsnXvpCaSL6KCABKiPtcGC1kCBtdgxQgM3hzbR9jG7A>
 <xmx:JxLWYbqlj3U3CRNn5_WhRG2yMjTJb1o4-qqFZ9Urr1coJUQeftfZYw>
 <xmx:JxLWYYRIbbG3nX84nApj3SGpItWPXibdLmG3XC4lE8WrdzYsVtc6GQ>
 <xmx:JxLWYZjsBQVwxOhfZolauoyF-SNlABtDCxJxm36gSI62B8WDkomczg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jan 2022 16:48:23 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 1/8] mm: page_alloc: avoid merging non-fallbackable
 pageblocks with others.
Date: Wed,  5 Jan 2022 16:47:49 -0500
Message-Id: <20220105214756.91065-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220105214756.91065-1-zi.yan@sent.com>
References: <20220105214756.91065-1-zi.yan@sent.com>
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

This is done in addition to MIGRATE_ISOLATE pageblock merge avoidance.
It prepares for the upcoming removal of the MAX_ORDER-1 alignment
requirement for CMA and alloc_contig_range().

MIGRARTE_HIGHATOMIC should not merge with other migratetypes like
MIGRATE_ISOLATE and MIGRARTE_CMA[1], so this commit prevents that too.
Also add MIGRARTE_HIGHATOMIC to fallbacks array for completeness.

[1] https://lore.kernel.org/linux-mm/20211130100853.GP3366@techsingularity.net/

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/mmzone.h |  6 ++++++
 mm/page_alloc.c        | 28 ++++++++++++++++++----------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index aed44e9b5d89..0aa549653e4e 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -83,6 +83,12 @@ static inline bool is_migrate_movable(int mt)
 	return is_migrate_cma(mt) || mt == MIGRATE_MOVABLE;
 }
 
+/* See fallbacks[MIGRATE_TYPES][3] in page_alloc.c */
+static inline bool migratetype_has_fallback(int mt)
+{
+	return mt < MIGRATE_PCPTYPES;
+}
+
 #define for_each_migratetype_order(order, type) \
 	for (order = 0; order < MAX_ORDER; order++) \
 		for (type = 0; type < MIGRATE_TYPES; type++)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8dd6399bafb5..5193c953dbf8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1042,6 +1042,12 @@ buddy_merge_likely(unsigned long pfn, unsigned long buddy_pfn,
 	return page_is_buddy(higher_page, higher_buddy, order + 1);
 }
 
+static inline bool has_non_fallback_pageblock(struct zone *zone)
+{
+	return has_isolate_pageblock(zone) || zone_cma_pages(zone) != 0 ||
+		zone->nr_reserved_highatomic != 0;
+}
+
 /*
  * Freeing function for a buddy system allocator.
  *
@@ -1117,14 +1123,15 @@ static inline void __free_one_page(struct page *page,
 	}
 	if (order < MAX_ORDER - 1) {
 		/* If we are here, it means order is >= pageblock_order.
-		 * We want to prevent merge between freepages on isolate
-		 * pageblock and normal pageblock. Without this, pageblock
-		 * isolation could cause incorrect freepage or CMA accounting.
+		 * We want to prevent merge between freepages on pageblock
+		 * without fallbacks and normal pageblock. Without this,
+		 * pageblock isolation could cause incorrect freepage or CMA
+		 * accounting or HIGHATOMIC accounting.
 		 *
 		 * We don't want to hit this code for the more frequent
 		 * low-order merging.
 		 */
-		if (unlikely(has_isolate_pageblock(zone))) {
+		if (unlikely(has_non_fallback_pageblock(zone))) {
 			int buddy_mt;
 
 			buddy_pfn = __find_buddy_pfn(pfn, order);
@@ -1132,8 +1139,8 @@ static inline void __free_one_page(struct page *page,
 			buddy_mt = get_pageblock_migratetype(buddy);
 
 			if (migratetype != buddy_mt
-					&& (is_migrate_isolate(migratetype) ||
-						is_migrate_isolate(buddy_mt)))
+					&& (!migratetype_has_fallback(migratetype) ||
+						!migratetype_has_fallback(buddy_mt)))
 				goto done_merging;
 		}
 		max_order = order + 1;
@@ -2484,6 +2491,7 @@ static int fallbacks[MIGRATE_TYPES][3] = {
 	[MIGRATE_UNMOVABLE]   = { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE,   MIGRATE_TYPES },
 	[MIGRATE_MOVABLE]     = { MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE, MIGRATE_TYPES },
 	[MIGRATE_RECLAIMABLE] = { MIGRATE_UNMOVABLE,   MIGRATE_MOVABLE,   MIGRATE_TYPES },
+	[MIGRATE_HIGHATOMIC] = { MIGRATE_TYPES }, /* Never used */
 #ifdef CONFIG_CMA
 	[MIGRATE_CMA]         = { MIGRATE_TYPES }, /* Never used */
 #endif
@@ -2795,8 +2803,8 @@ static void reserve_highatomic_pageblock(struct page *page, struct zone *zone,
 
 	/* Yoink! */
 	mt = get_pageblock_migratetype(page);
-	if (!is_migrate_highatomic(mt) && !is_migrate_isolate(mt)
-	    && !is_migrate_cma(mt)) {
+	/* Only reserve normal pageblock */
+	if (migratetype_has_fallback(mt)) {
 		zone->nr_reserved_highatomic += pageblock_nr_pages;
 		set_pageblock_migratetype(page, MIGRATE_HIGHATOMIC);
 		move_freepages_block(zone, page, MIGRATE_HIGHATOMIC, NULL);
@@ -3545,8 +3553,8 @@ int __isolate_free_page(struct page *page, unsigned int order)
 		struct page *endpage = page + (1 << order) - 1;
 		for (; page < endpage; page += pageblock_nr_pages) {
 			int mt = get_pageblock_migratetype(page);
-			if (!is_migrate_isolate(mt) && !is_migrate_cma(mt)
-			    && !is_migrate_highatomic(mt))
+			/* Only change normal pageblock */
+			if (migratetype_has_fallback(mt))
 				set_pageblock_migratetype(page,
 							  MIGRATE_MOVABLE);
 		}
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
