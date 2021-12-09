Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B04EC433EF
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 23:36:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EAA21605E7;
	Thu,  9 Dec 2021 23:36:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IIE-upwdASfd; Thu,  9 Dec 2021 23:36:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A621C605DA;
	Thu,  9 Dec 2021 23:36:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21DFBC006F;
	Thu,  9 Dec 2021 23:36:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78282C001E;
 Thu,  9 Dec 2021 23:04:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5F4236F9EF;
 Thu,  9 Dec 2021 23:04:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z0lyKPLUvJ6J; Thu,  9 Dec 2021 23:04:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com
 [66.111.4.221])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5C5436F9EB;
 Thu,  9 Dec 2021 23:04:40 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.nyi.internal (Postfix) with ESMTP id B5E7C580256;
 Thu,  9 Dec 2021 18:04:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Thu, 09 Dec 2021 18:04:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references:reply-to
 :mime-version:content-transfer-encoding; s=fm2; bh=f9pxJP6huj/jq
 chjLk4G5VAUmGYrnQ+YUykdx2M2vNA=; b=SiR0oAdyqiTOzSDOBwhKFdFsWvEGJ
 opw1nHooWbAt+GMTry1tkgoTP2MKMK8SyfAJoWpVGmSRXWVJF11/cmX159tBuhY3
 yWaV/nZsjUlS3aJfEIYNY4x/QMiAqARvmNX0oRCihO5A3PpMHbEGhkHZzjIvfXis
 mXW/YPkfcNuPwhWIHagrcXIW/L59lzgUKpyVmazwQZvQ/EXYzKwoQ9jy7FO8+ovF
 Se2QG+LOMoonkQFGVPpA/kCA2crdi4hDTEAhbCFp2+smcQ36X9HBbJneSZ0JbEEG
 BkSgXJzjtFzNgMCzgIfLzrVVV21suS8Bi+re55IT1spZPVt8fOe0WpjYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=f9pxJP6huj/jqchjLk4G5VAUmGYrnQ+YUykdx2M2vNA=; b=F4mKHmG5
 69NlwTkqs6g/DRPuRYl7kJ3oXoIucrXoFv0Es1i1n9gkfHcV16Qz0KKD3oAwDiVO
 NUz7dl4YO8omoel2dXEEfWFlm8zAmnB5/BxWy0mEP44cnAMbnnOd58ee+BtgBUTg
 AdXXrJ0+poUGDIMTQbgcAlYeSuKvBigwcEA/Zwvx2qYVqyqtM4SRNNehWWzbYCwG
 ud9w9GazpC5QN4H85cQiv+zeOPVY4IcCI1KoUYijZgobm4KDicvhqIXtLyRItAcM
 FmrUV8D++iniQjMRiHz5ShAYbOXWQCGEQHdFBIw9P/PscqDZ4BZcUZHIifYuS00O
 eX6E5DNZZRgPoQ==
X-ME-Sender: <xms:hYuyYWT7RDfRPg9mF7cFnVVIVIZeJsspLHnJXuRYtvUb9Z9Y26gIVw>
 <xme:hYuyYbz9YEI3rs3oNVFgd3YQrhrLzqIMDfgc2wjtvo6uOVvDLSRwfen-_kUZoHI2A
 UQw_cN8S2nSuDUM2g>
X-ME-Received: <xmr:hYuyYT1J808NrJiuCRZ-fNTcryBh27NvHP4_EF6y9-hZjqO6x2aKoYbpT8voHFmJU7I6wEW8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrkedugddtfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
 nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeekieeule
 dvtdetueejhedtgeehjeelvddttefgieeljeefgefhfedtuefffeelveenucffohhmrghi
 nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:hYuyYSBpgk26MEBandqg-jDMDDhRkOfpVUHtOJFlIf0IB_J07BnUZA>
 <xmx:hYuyYfhGvRDWUdZA_iqlEKVROFWj4CEuM2ZYT5qx8PL9wTMdQl4Ksw>
 <xmx:hYuyYeqj4CsyQRJ6SN3sHOEZOOS_n9hq6puSyxYZB-lLtHBdP6poXw>
 <xmx:hYuyYYbyISSybAkDt0WY0wXTZkx1RWkESRcGZzvD5KFdgOcw6kV7ww>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Dec 2021 18:04:37 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 1/7] mm: page_alloc: avoid merging non-fallbackable
 pageblocks with others.
Date: Thu,  9 Dec 2021 18:04:08 -0500
Message-Id: <20211209230414.2766515-2-zi.yan@sent.com>
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
index 58e744b78c2c..b925431b0123 100644
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
index edfd6c81af82..107a5f186d3b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1041,6 +1041,12 @@ buddy_merge_likely(unsigned long pfn, unsigned long buddy_pfn,
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
@@ -1116,14 +1122,15 @@ static inline void __free_one_page(struct page *page,
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
@@ -1131,8 +1138,8 @@ static inline void __free_one_page(struct page *page,
 			buddy_mt = get_pageblock_migratetype(buddy);
 
 			if (migratetype != buddy_mt
-					&& (is_migrate_isolate(migratetype) ||
-						is_migrate_isolate(buddy_mt)))
+					&& (!migratetype_has_fallback(migratetype) ||
+						!migratetype_has_fallback(buddy_mt)))
 				goto done_merging;
 		}
 		max_order = order + 1;
@@ -2483,6 +2490,7 @@ static int fallbacks[MIGRATE_TYPES][3] = {
 	[MIGRATE_UNMOVABLE]   = { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE,   MIGRATE_TYPES },
 	[MIGRATE_MOVABLE]     = { MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE, MIGRATE_TYPES },
 	[MIGRATE_RECLAIMABLE] = { MIGRATE_UNMOVABLE,   MIGRATE_MOVABLE,   MIGRATE_TYPES },
+	[MIGRATE_HIGHATOMIC] = { MIGRATE_TYPES }, /* Never used */
 #ifdef CONFIG_CMA
 	[MIGRATE_CMA]         = { MIGRATE_TYPES }, /* Never used */
 #endif
@@ -2794,8 +2802,8 @@ static void reserve_highatomic_pageblock(struct page *page, struct zone *zone,
 
 	/* Yoink! */
 	mt = get_pageblock_migratetype(page);
-	if (!is_migrate_highatomic(mt) && !is_migrate_isolate(mt)
-	    && !is_migrate_cma(mt)) {
+	/* Only reserve normal pageblock */
+	if (migratetype_has_fallback(mt)) {
 		zone->nr_reserved_highatomic += pageblock_nr_pages;
 		set_pageblock_migratetype(page, MIGRATE_HIGHATOMIC);
 		move_freepages_block(zone, page, MIGRATE_HIGHATOMIC, NULL);
@@ -3544,8 +3552,8 @@ int __isolate_free_page(struct page *page, unsigned int order)
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
2.33.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
