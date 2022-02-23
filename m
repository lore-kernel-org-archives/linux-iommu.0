Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB45C433F5
	for <iommu@archiver.kernel.org>; Wed, 23 Feb 2022 04:30:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D96B60F1D;
	Wed, 23 Feb 2022 04:30:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oyJ5u22H7JmO; Wed, 23 Feb 2022 04:30:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8FFAF60D6B;
	Wed, 23 Feb 2022 04:30:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61884C001A;
	Wed, 23 Feb 2022 04:30:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2343C0033;
 Wed, 23 Feb 2022 04:30:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9DFE0813A0;
 Wed, 23 Feb 2022 04:30:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sent.com header.b="mgKmEGpP";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="hVvjsDqe"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eCegb0uEDUAw; Wed, 23 Feb 2022 04:30:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3BE7F8139C;
 Wed, 23 Feb 2022 04:30:49 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailnew.nyi.internal (Postfix) with ESMTP id 4548A580131;
 Tue, 22 Feb 2022 23:30:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Tue, 22 Feb 2022 23:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
 :cc:content-transfer-encoding:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to
 :reply-to:sender:subject:subject:to:to; s=fm2; bh=/SgadF0hReFb2F
 8Je4WvdxMX/hAimLeeaZjST5covuA=; b=mgKmEGpPw2O9To4D0gKrJqyOFOFk+Z
 uFSCu/hSjLA/q8FyyspXGquO2dT4QK4b9aYbtcNoKyGRGYXkEu3kH9qCxMX5u4wG
 tSjYtZOfXzRVddorpcmttkpRuvM0kEYBZF/hUSKVoJWQHjTIU3p35HmvFDiydMuZ
 HpYMZ2GEXLd1F5OW2XfI0EvnZhfN3IGq5GmXTQe/NrNrJNW2UFFKLHL5ixCQyptf
 +6+ioh7xVlO1NCbF3eP4Axmz57tQ/GSC4iC6SDmY6g40tKutggSaieFZaQF+hnHH
 +KWy6zBNEtRgNOk7YK4QVDmeeSsGzfVmfEFamD+M5yL2SRFmcfXOQJMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=/SgadF0hReFb2F8Je4WvdxMX/hAimLeeaZjST5covuA=; b=hVvjsDqe
 /aVkzqvADn3MC8DG4jezDuDRQbplcwuWsexGtGsHyK3/iQwS35QwFa3RT5FnGNIM
 Gk/I4fvusDaVeDDeBEaVUdc3DWXnZHOaGCH9egXWz7aFVkYTH6C+WbJU0ZYsmTYg
 2gt4/Cmrr6UhLVsf9GJ+g99ay4mJtBh5+x2NCNoCSxyGgYUf68lDmyRFDLSLbWEL
 Q/Fmwtg4Nv1/2sOhWdOiINN783gyq5mbJntntGU1ievt8xtwfjrQCExHBcH5yeFA
 U3w/FIpv1uVFmphXf3P3ZSN8UENqsNfcQ4wTYDR2d6LIQ0OMyj8JuAR7jdrqQgOJ
 LETeQ4xgclJ5lA==
X-ME-Sender: <xms:eLgVYsPiOrh2XJNA3Ae7HvvJ9qBYGKSotR3AojQTaYyNBXzWnyWb4Q>
 <xme:eLgVYi_bh8Zc-qxbEc8nn-wbWUeqgA_15p4CPnLFv_cMjefwlH3o7gHUlfQ8i2_Q6
 2O4hcN9D7oxs-9fyg>
X-ME-Received: <xmr:eLgVYjTleF-zf_dDi-roT3k-82p0NOF3Dmwiw2sXC3J5mk5Nwoe7CrcBfogglHgrqIh7iP9s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeelgdejudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
 nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeeuvd
 euudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
 htrdgtohhm
X-ME-Proxy: <xmx:eLgVYku7Oe0DY7e2KDOrl3NzoRAXf-NvjxW2HpwT62YEmVcxT-LyKA>
 <xmx:eLgVYkflQc8nH4yJtX48bV93dWG1Pym4KtAQ21sAChKoW0Y4fnR8Gg>
 <xmx:eLgVYo0FZ-M4EXielS9TBbfxmCoboTKGkJjfnBAIFDrbiYbOHo2dSQ>
 <xmx:eLgVYnsIMZtNzxRCjU4a_cFqnGQKrEsWc2f93vk6H99bZzHrBwc2Lg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Feb 2022 23:30:47 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Subject: [PATCH v6 3/5] mm: make alloc_contig_range work at pageblock
 granularity
Date: Tue, 22 Feb 2022 23:30:35 -0500
Message-Id: <20220223043037.715205-4-zi.yan@sent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220223043037.715205-1-zi.yan@sent.com>
References: <20220223043037.715205-1-zi.yan@sent.com>
MIME-Version: 1.0
Cc: Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Oscar Salvador <osalvador@suse.de>,
 Robin Murphy <robin.murphy@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>, iommu@lists.linux-foundation.org,
 Mike Rapoport <rppt@kernel.org>, Eric Ren <renzhengeek@gmail.com>,
 virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>, Vlastimil Babka <vbabka@suse.cz>
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

Special handling is needed for free pages and in-use pages across the
boundaries of the range specified alloc_contig_range(). Because these
partially isolated pages causes free page accounting issues. The free
pages will be split and freed into separate migratetype lists; the
in-use pages will be migrated then the freed pages will be handled.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/page-isolation.h |   2 +-
 mm/internal.h                  |   6 ++
 mm/memory_hotplug.c            |   3 +-
 mm/page_alloc.c                | 112 ++++++++++++-----------
 mm/page_isolation.c            | 156 +++++++++++++++++++++++++++++++--
 5 files changed, 214 insertions(+), 65 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index eb4a208fe907..20ec9cad3882 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -52,7 +52,7 @@ int move_freepages_block(struct zone *zone, struct page *page,
  */
 int
 start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
-			 unsigned migratetype, int flags);
+			 unsigned migratetype, int flags, gfp_t gfp_flags);
 
 /*
  * Changes MIGRATE_ISOLATE to MIGRATE_MOVABLE.
diff --git a/mm/internal.h b/mm/internal.h
index 7ed98955c8f4..2626e38dd62c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -256,6 +256,9 @@ extern void *memmap_alloc(phys_addr_t size, phys_addr_t align,
 			  phys_addr_t min_addr,
 			  int nid, bool exact_nid);
 
+void split_free_page(struct page *free_page,
+				int order, unsigned long split_pfn_offset);
+
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 
 /*
@@ -319,6 +322,9 @@ isolate_freepages_range(struct compact_control *cc,
 int
 isolate_migratepages_range(struct compact_control *cc,
 			   unsigned long low_pfn, unsigned long end_pfn);
+
+int __alloc_contig_migrate_range(struct compact_control *cc,
+					unsigned long start, unsigned long end);
 #endif
 int find_suitable_fallback(struct free_area *area, unsigned int order,
 			int migratetype, bool only_stealable, bool *can_steal);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index aee69281dad6..bbd1ff39121f 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1833,7 +1833,8 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	/* set above range as isolated */
 	ret = start_isolate_page_range(start_pfn, end_pfn,
 				       MIGRATE_MOVABLE,
-				       MEMORY_OFFLINE | REPORT_FAILURE);
+				       MEMORY_OFFLINE | REPORT_FAILURE,
+				       GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL);
 	if (ret) {
 		reason = "failure to isolate range";
 		goto failed_removal_pcplists_disabled;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b900315657cf..038e044c5a80 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1139,6 +1139,43 @@ static inline void __free_one_page(struct page *page,
 		page_reporting_notify_free(order);
 }
 
+/**
+ * split_free_page() -- split a free page at split_pfn_offset
+ * @free_page:		the original free page
+ * @order:		the order of the page
+ * @split_pfn_offset:	split offset within the page
+ *
+ * It is used when the free page crosses two pageblocks with different migratetypes
+ * at split_pfn_offset within the page. The split free page will be put into
+ * separate migratetype lists afterwards. Otherwise, the function achieves
+ * nothing.
+ */
+void split_free_page(struct page *free_page,
+				int order, unsigned long split_pfn_offset)
+{
+	struct zone *zone = page_zone(free_page);
+	unsigned long free_page_pfn = page_to_pfn(free_page);
+	unsigned long pfn;
+	unsigned long flags;
+	int free_page_order;
+
+	spin_lock_irqsave(&zone->lock, flags);
+	del_page_from_free_list(free_page, zone, order);
+	for (pfn = free_page_pfn;
+	     pfn < free_page_pfn + (1UL << order);) {
+		int mt = get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
+
+		free_page_order = order_base_2(split_pfn_offset);
+		__free_one_page(pfn_to_page(pfn), pfn, zone, free_page_order,
+				mt, FPI_NONE);
+		pfn += 1UL << free_page_order;
+		split_pfn_offset -= (1UL << free_page_order);
+		/* we have done the first part, now switch to second part */
+		if (split_pfn_offset == 0)
+			split_pfn_offset = (1UL << order) - (pfn - free_page_pfn);
+	}
+	spin_unlock_irqrestore(&zone->lock, flags);
+}
 /*
  * A bad page could be due to a number of fields. Instead of multiple branches,
  * try and check multiple fields with one check. The caller must do a detailed
@@ -8971,7 +9008,7 @@ static inline void alloc_contig_dump_pages(struct list_head *page_list)
 #endif
 
 /* [start, end) must belong to a single zone. */
-static int __alloc_contig_migrate_range(struct compact_control *cc,
+int __alloc_contig_migrate_range(struct compact_control *cc,
 					unsigned long start, unsigned long end)
 {
 	/* This function is based on compact_zone() from compaction.c. */
@@ -9029,6 +9066,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 	return 0;
 }
 
+
 /**
  * alloc_contig_range() -- tries to allocate given range of pages
  * @start:	start PFN to allocate
@@ -9053,8 +9091,9 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 int alloc_contig_range(unsigned long start, unsigned long end,
 		       unsigned migratetype, gfp_t gfp_mask)
 {
-	unsigned long outer_start, outer_end;
-	unsigned int order;
+	unsigned long outer_end;
+	unsigned long alloc_start = ALIGN_DOWN(start, pageblock_nr_pages);
+	unsigned long alloc_end = ALIGN(end, pageblock_nr_pages);
 	int ret = 0;
 
 	struct compact_control cc = {
@@ -9073,14 +9112,11 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	 * What we do here is we mark all pageblocks in range as
 	 * MIGRATE_ISOLATE.  Because pageblock and max order pages may
 	 * have different sizes, and due to the way page allocator
-	 * work, we align the range to biggest of the two pages so
-	 * that page allocator won't try to merge buddies from
-	 * different pageblocks and change MIGRATE_ISOLATE to some
-	 * other migration type.
+	 * work, start_isolate_page_range() has special handlings for this.
 	 *
 	 * Once the pageblocks are marked as MIGRATE_ISOLATE, we
 	 * migrate the pages from an unaligned range (ie. pages that
-	 * we are interested in).  This will put all the pages in
+	 * we are interested in). This will put all the pages in
 	 * range back to page allocator as MIGRATE_ISOLATE.
 	 *
 	 * When this is done, we take the pages in range from page
@@ -9093,9 +9129,9 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	 * put back to page allocator so that buddy can use them.
 	 */
 
-	ret = start_isolate_page_range(start, end, migratetype, 0);
+	ret = start_isolate_page_range(start, end, migratetype, 0, gfp_mask);
 	if (ret)
-		return ret;
+		goto done;
 
 	drain_all_pages(cc.zone);
 
@@ -9114,68 +9150,28 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 		goto done;
 	ret = 0;
 
-	/*
-	 * Pages from [start, end) are within a MAX_ORDER_NR_PAGES
-	 * aligned blocks that are marked as MIGRATE_ISOLATE.  What's
-	 * more, all pages in [start, end) are free in page allocator.
-	 * What we are going to do is to allocate all pages from
-	 * [start, end) (that is remove them from page allocator).
-	 *
-	 * The only problem is that pages at the beginning and at the
-	 * end of interesting range may be not aligned with pages that
-	 * page allocator holds, ie. they can be part of higher order
-	 * pages.  Because of this, we reserve the bigger range and
-	 * once this is done free the pages we are not interested in.
-	 *
-	 * We don't have to hold zone->lock here because the pages are
-	 * isolated thus they won't get removed from buddy.
-	 */
-
-	order = 0;
-	outer_start = start;
-	while (!PageBuddy(pfn_to_page(outer_start))) {
-		if (++order >= MAX_ORDER) {
-			outer_start = start;
-			break;
-		}
-		outer_start &= ~0UL << order;
-	}
-
-	if (outer_start != start) {
-		order = buddy_order(pfn_to_page(outer_start));
-
-		/*
-		 * outer_start page could be small order buddy page and
-		 * it doesn't include start page. Adjust outer_start
-		 * in this case to report failed page properly
-		 * on tracepoint in test_pages_isolated()
-		 */
-		if (outer_start + (1UL << order) <= start)
-			outer_start = start;
-	}
-
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
+	undo_isolate_page_range(alloc_start,
+				alloc_end, migratetype);
 	return ret;
 }
 EXPORT_SYMBOL(alloc_contig_range);
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index e0afc3ee8cf9..9bc1a685d553 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -273,6 +273,129 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
 	return NULL;
 }
 
+/**
+ * isolate_single_pageblock() -- tries to isolate a pageblock that might be
+ * within a free or in-use page.
+ * @boundary_pfn:		pageblock-aligned pfn that a page might cross
+ * @gfp_flags:			GFP flags used for migrating pages
+ * @isolate_before:	isolate the pageblock before the boundary_pfn
+ *
+ * Free and in-use pages can be as big as MAX_ORDER-1 and contain more than one
+ * pageblock. When not all pageblocks within a page are isolated at the same
+ * time, free page accounting can go wrong. For example, in the case of
+ * MAX_ORDER-1 = pageblock_order + 1, a MAX_ORDER-1 page has two pagelbocks.
+ * [        MAX_ORDER-1          ]
+ * [  pageblock0  |  pageblock1  ]
+ * When either pageblock is isolated, if it is a free page, the page is not
+ * split into separate migratetype lists, which is supposed to; if it is an
+ * in-use page and freed later, __free_one_page() does not split the free page
+ * either. The function handles this by splitting the free page or migrating
+ * the in-use page then splitting the free page.
+ */
+static int isolate_single_pageblock(unsigned long boundary_pfn, gfp_t gfp_flags,
+			bool isolate_before)
+{
+	unsigned char saved_mt;
+	/*
+	 * scan at max(MAX_ORDER_NR_PAGES, pageblock_nr_pages) aligned range to
+	 * avoid isolate pageblocks belonging to a bigger free or in-use page
+	 */
+	unsigned long start_pfn = pfn_max_align_down(boundary_pfn);
+	unsigned long isolate_pageblock;
+	unsigned long pfn;
+
+	VM_BUG_ON(!IS_ALIGNED(boundary_pfn, pageblock_nr_pages));
+
+	if (isolate_before)
+		isolate_pageblock = boundary_pfn - pageblock_nr_pages;
+	else
+		isolate_pageblock = boundary_pfn;
+
+	saved_mt = get_pageblock_migratetype(pfn_to_page(isolate_pageblock));
+	set_pageblock_migratetype(pfn_to_page(isolate_pageblock), MIGRATE_ISOLATE);
+
+	for (pfn = start_pfn; pfn < boundary_pfn;) {
+		struct page *page = pfn_to_page(pfn);
+
+		/*
+		 * start_pfn is max(MAX_ORDER_NR_PAGES, pageblock_nr_pages)
+		 * aligned, if there is any free pages in [start_pfn, boundary_pfn),
+		 * its head page will always be in the range.
+		 */
+		if (PageBuddy(page)) {
+			int order = buddy_order(page);
+
+			if (pfn + (1UL << order) > boundary_pfn)
+				split_free_page(page, order, boundary_pfn - pfn);
+			pfn += (1UL << order);
+			continue;
+		}
+		/*
+		 * migrate compound pages then let the free page handling code
+		 * above do the rest. If migration is not enabled, just fail.
+		 */
+		if (PageHuge(page) || PageTransCompound(page)) {
+#if defined CONFIG_COMPACTION || defined CONFIG_CMA
+			unsigned long nr_pages = compound_nr(page);
+			int order = compound_order(page);
+			struct page *head = compound_head(page);
+			unsigned long head_pfn = page_to_pfn(head);
+			int ret;
+			struct compact_control cc = {
+				.nr_migratepages = 0,
+				.order = -1,
+				.zone = page_zone(pfn_to_page(head_pfn)),
+				.mode = MIGRATE_SYNC,
+				.ignore_skip_hint = true,
+				.no_set_skip_hint = true,
+				.gfp_mask = gfp_flags,
+				.alloc_contig = true,
+			};
+			INIT_LIST_HEAD(&cc.migratepages);
+
+			if (head_pfn + nr_pages < boundary_pfn) {
+				pfn += nr_pages;
+				continue;
+			}
+
+			ret = __alloc_contig_migrate_range(&cc, head_pfn,
+						head_pfn + nr_pages);
+
+			if (ret)
+				goto failed;
+			/*
+			 * reset pfn, let the free page handling code above
+			 * split the free page to the right migratetype list.
+			 *
+			 * head_pfn is not used here as a hugetlb page order
+			 * can be bigger than MAX_ORDER-1, but after it is
+			 * freed, the free page order is not. Use pfn within
+			 * the range to find the head of the free page and
+			 * reset order to 0 if a hugetlb page with
+			 * >MAX_ORDER-1 order is encountered.
+			 */
+			if (order > MAX_ORDER-1)
+				order = 0;
+			while (!PageBuddy(pfn_to_page(pfn))) {
+				order++;
+				pfn &= ~0UL << order;
+			}
+			continue;
+#else
+			goto failed;
+#endif
+		}
+
+		pfn++;
+	}
+	return 0;
+failed:
+	/* restore the original migratetype */
+	set_pageblock_migratetype(pfn_to_page(isolate_pageblock), saved_mt);
+	return -EBUSY;
+}
+
+
 /**
  * start_isolate_page_range() - make page-allocation-type of range of pages to
  * be MIGRATE_ISOLATE.
@@ -286,6 +409,8 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  *					 and PageOffline() pages.
  *			REPORT_FAILURE - report details about the failure to
  *			isolate the range
+ * @gfp_flags:		GFP flags used for migrating pages that sit across the
+ *			range boundaries.
  *
  * Making page-allocation-type to be MIGRATE_ISOLATE means free pages in
  * the range will never be allocated. Any free pages and pages freed in the
@@ -294,6 +419,10 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * pages in the range finally, the caller have to free all pages in the range.
  * test_page_isolated() can be used for test it.
  *
+ * The function first tries to isolate the pageblocks at the beginning and end
+ * of the range, since there might be pages across the range boundaries.
+ * Afterwards, it isolates the rest of the range.
+ *
  * There is no high level synchronization mechanism that prevents two threads
  * from trying to isolate overlapping ranges. If this happens, one thread
  * will notice pageblocks in the overlapping range already set to isolate.
@@ -314,21 +443,38 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * Return: 0 on success and -EBUSY if any part of range cannot be isolated.
  */
 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
-			     unsigned migratetype, int flags)
+			     unsigned migratetype, int flags, gfp_t gfp_flags)
 {
 	unsigned long pfn;
 	struct page *page;
+	/* isolation is done at page block granularity */
+	unsigned long isolate_start = ALIGN_DOWN(start_pfn, pageblock_nr_pages);
+	unsigned long isolate_end = ALIGN(end_pfn, pageblock_nr_pages);
+	int ret;
 
-	unsigned long isolate_start = pfn_max_align_down(start_pfn);
-	unsigned long isolate_end = pfn_max_align_up(end_pfn);
+	/* isolate [isolate_start, isolate_start + pageblock_nr_pages] pageblock */
+	ret = isolate_single_pageblock(isolate_start, gfp_flags, false);
+	if (ret)
+		return ret;
+
+	/* isolate [isolate_end - pageblock_nr_pages, isolate_end] pageblock */
+	ret = isolate_single_pageblock(isolate_end, gfp_flags, true);
+	if (ret) {
+		unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
+		return ret;
+	}
 
-	for (pfn = isolate_start;
-	     pfn < isolate_end;
+	/* skip isolated pageblocks at the beginning and end */
+	for (pfn = isolate_start + pageblock_nr_pages;
+	     pfn < isolate_end - pageblock_nr_pages;
 	     pfn += pageblock_nr_pages) {
 		page = __first_valid_page(pfn, pageblock_nr_pages);
 		if (page && set_migratetype_isolate(page, migratetype, flags,
 					start_pfn, end_pfn)) {
 			undo_isolate_page_range(isolate_start, pfn, migratetype);
+			unset_migratetype_isolate(
+				pfn_to_page(isolate_end - pageblock_nr_pages),
+				migratetype);
 			return -EBUSY;
 		}
 	}
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
