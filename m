Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBC5C433FE
	for <iommu@archiver.kernel.org>; Wed, 19 Jan 2022 19:06:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3921380C67;
	Wed, 19 Jan 2022 19:06:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T14HAMEii6Sp; Wed, 19 Jan 2022 19:06:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C062380C52;
	Wed, 19 Jan 2022 19:06:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59284C0039;
	Wed, 19 Jan 2022 19:06:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34E48C002F;
 Wed, 19 Jan 2022 19:06:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CEADA4159F;
 Wed, 19 Jan 2022 19:06:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sent.com header.b="pR8fSDwb";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="KnSJwE88"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qrj5VPr6NnQA; Wed, 19 Jan 2022 19:06:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D35F541594;
 Wed, 19 Jan 2022 19:06:39 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 057355806B8;
 Wed, 19 Jan 2022 14:06:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Wed, 19 Jan 2022 14:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references:reply-to
 :mime-version:content-transfer-encoding; s=fm2; bh=kGtmOv43gwxP+
 UrqqToKaIeWhe55nyzJ26XM081ht/o=; b=pR8fSDwb1tom9FXFNCKfHmdgbCuou
 e8ojq7E1qnAGz2bVqi2nqAG6E/frrQu1kLNmsAMSpZhTDxu1oH5d8LtYC1XOlTGy
 fAwwfoRMDF/jpk+iCIv/8hEVAoJoq2ypghxoxz2y5ie5rXFs/uzt4d1zhh7QGSdN
 Fz3HRr8O15SG1Huwtnl5WWmE2tkWb+2S/iFuaR3Lo9CLENvlUKq+GGkYdxp6xR11
 R5Jonprnf9TfVPhp1IDJ3KDQ9r/CUBehj/+lljZQ/6Gl4Py3S0Fp5vMkFtepaLPz
 gl1k1GRg9mnDo7UVcKymSdJp8jp/CCUkANGGotRRjn6/K6rpZXp0S7pyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=kGtmOv43gwxP+UrqqToKaIeWhe55nyzJ26XM081ht/o=; b=KnSJwE88
 NxfaG8VY+dc36U/RojAYjdAD1BGJm7jf4ppQ6ezozYCE436Yiq8EOsKyguh73YQN
 6XZiRobN/b3RqLmTNxCH3NuXvJbXohkRKD3LlnlJGsBlYIxjuKf54AwRD0aMaqRn
 8VcVK8fbNlR07a89cakGO+oK3q04Htz8kro1FL3Ck8h3+DNnbRrYIMx5P0JufLCU
 H0AA/Edk4DQhO0ubVcIZGRTReayrmtutO1iXEcb+R5pGnj0yplHUBmYbQewYX3rX
 rzLQuVrpionLY0p0Wk8coVQjyZXFzvxYH2euXpQxOeRhlvW0BglaP33f9t9WOExx
 hXODMmRwv/NyZQ==
X-ME-Sender: <xms:PWHoYaM73SogHMpxNSxZl-KvuJfKnqAuEEB5oqMHrmGKyXYqexthWA>
 <xme:PWHoYY_yAKAgM7VaVWiztbBamPuCxzExNOILnj8nPSztBZLyfOuE8kpjDCqsKHIX5
 dyyPxR8le6bAIoCEQ>
X-ME-Received: <xmr:PWHoYRQZiI9p084WFC0HnaAIUZ3-EF3toMH61PTZj-5mhBWe8GZTJqWSioLl3E7P_22mexO2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeigdeivdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
 nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeeuvd
 euudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
 htrdgtohhm
X-ME-Proxy: <xmx:PWHoYasRzh7ExqZ-4wwLkNKtIs7TU9inqG0T0tFGqv1TNmFhTUqTyA>
 <xmx:PWHoYSfshBHx3ynXcqJOkrmsHQGxT6JojD62Qy-ntl5BVJHydK7D6w>
 <xmx:PWHoYe0ynuijp-QZdnLwtgMA1AeCY_929vCYOSiPa1g6QDE4lm7GAw>
 <xmx:PmHoYY2oFuP4Sn_jE4hQh2TX8hG1y7L1V7ePFZ_Tr4oGNNoLOem-DA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jan 2022 14:06:37 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Subject: [PATCH v4 4/7] mm: make alloc_contig_range work at pageblock
 granularity
Date: Wed, 19 Jan 2022 14:06:20 -0500
Message-Id: <20220119190623.1029355-5-zi.yan@sent.com>
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
 mm/page_alloc.c | 175 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 155 insertions(+), 20 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 812cf557b20f..6ed506234efa 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8862,8 +8862,8 @@ void *__init alloc_large_system_hash(const char *tablename,
 #ifdef CONFIG_CONTIG_ALLOC
 static unsigned long pfn_max_align_down(unsigned long pfn)
 {
-	return pfn & ~(max_t(unsigned long, MAX_ORDER_NR_PAGES,
-			     pageblock_nr_pages) - 1);
+	return ALIGN_DOWN(pfn, max_t(unsigned long, MAX_ORDER_NR_PAGES,
+				     pageblock_nr_pages));
 }
 
 static unsigned long pfn_max_align_up(unsigned long pfn)
@@ -8952,6 +8952,52 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
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
@@ -8977,8 +9023,15 @@ int alloc_contig_range(unsigned long start, unsigned long end,
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
@@ -8992,11 +9045,30 @@ int alloc_contig_range(unsigned long start, unsigned long end,
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
@@ -9006,6 +9078,20 @@ int alloc_contig_range(unsigned long start, unsigned long end,
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
@@ -9016,10 +9102,10 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	 * put back to page allocator so that buddy can use them.
 	 */
 
-	ret = start_isolate_page_range(start, end, pfn_max_align_down(start),
-				       pfn_max_align_up(end), migratetype, 0);
+	ret = start_isolate_page_range(start, end, isolate_start, isolate_end,
+				migratetype, 0);
 	if (ret)
-		return ret;
+		goto done;
 
 	drain_all_pages(cc.zone);
 
@@ -9055,6 +9141,19 @@ int alloc_contig_range(unsigned long start, unsigned long end,
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
@@ -9069,37 +9168,73 @@ int alloc_contig_range(unsigned long start, unsigned long end,
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
+	for (outer_end = alloc_end; outer_end < isolate_end;) {
+		unsigned long begin_pfn = outer_end;
+
+		order = 0;
+		while (!PageBuddy(pfn_to_page(outer_end))) {
+			if (++order >= MAX_ORDER) {
+				outer_end = begin_pfn;
+				break;
+			}
+			outer_end &= ~0UL << order;
+		}
+
+		if (outer_end != begin_pfn) {
+			order = buddy_order(pfn_to_page(outer_end));
+
+			/*
+			 * split the free page has start page and put the pageblocks
+			 * in the right migratetype list
+			 */
+			VM_BUG_ON(outer_end + (1UL << order) <= begin_pfn);
+			{
+				struct page *free_page = pfn_to_page(outer_end);
+
+				split_free_page_into_pageblocks(free_page, order, cc.zone);
+			}
+			outer_end += 1UL << order;
+		} else
+			outer_end = begin_pfn + 1;
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
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
