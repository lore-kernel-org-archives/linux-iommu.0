Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347D5C433F5
	for <iommu@archiver.kernel.org>; Wed,  5 Jan 2022 21:48:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC8EA6FBD3;
	Wed,  5 Jan 2022 21:48:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XcuK0oIka0Iv; Wed,  5 Jan 2022 21:48:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4B5D96FBCA;
	Wed,  5 Jan 2022 21:48:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBF9FC0072;
	Wed,  5 Jan 2022 21:48:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C6BFC001E;
 Wed,  5 Jan 2022 21:48:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F01396FBC3;
 Wed,  5 Jan 2022 21:48:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LSYHHSg2mSgD; Wed,  5 Jan 2022 21:48:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BD8986FB95;
 Wed,  5 Jan 2022 21:48:27 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id ECF0E580561;
 Wed,  5 Jan 2022 16:48:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 05 Jan 2022 16:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references:reply-to
 :mime-version:content-transfer-encoding; s=fm2; bh=i5PR4FWm5EakP
 MkM2WD3s3D7Gp7BwGYZgyto5AB1H+A=; b=jGom0jRZSFHXrg1CS6RUip8HsmYj0
 3PheJTpvIcw5TEN3ohqR/Ma28+eS3iu6zlhcTP7cpjlNbSRIE7YjpML56aHPrvIA
 +4GCENqlIs1mrOA8cTTe6ODjaj/IIYn3v8Qtnh4HttRhILcr/pd8ruEjGU4hNGLV
 1/U3mzoPK1PlgfFENaYnLxCYwzg0lcObzxYKbQIClfbgKOIq4/g7ESkYp4G16GaS
 SkUw4/Cd2XElHlNC+nSdsqJ6mfysMNjUhgm69pVRho2izlvpuUSfRQA2u3WNXQdi
 /OMBHAnq7TMG7/Anti0xBbKSe8Qv5J0Q0JemZrb5BY048UH5QAAWRht0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=i5PR4FWm5EakPMkM2WD3s3D7Gp7BwGYZgyto5AB1H+A=; b=SO02xALW
 XLfRTAl0GBWZ21+X0VJGIktyQxLwkvOh1ddauSqlMPL0vAt1wDSerfK+IGkyIKzq
 quhPthzVNMPD+LyBukxDsTP89RoxSq3jwYOKrLqBdShkg5IdkzsDrloNQLCcPSHA
 35JMuHFblanwxMyV6jrcK1PHNQI5NU9br75DPp971SoUx/EyUuh14KUtFmg0PYj6
 szv/SLRDYtYTeDwj7DdjY5ErT9qlO8lrryqEQCOQYj8oMiUBsKPEqpAOahGpIoHm
 zSDFrgc/nfTo5K45SbfshUEKCsL4hLo/lSqJ3n8MsUibeourM4SwPREC65DN/96f
 2WqsXmvVvF9HUg==
X-ME-Sender: <xms:KhLWYSpj6x5nBkE68re68OwL3j37lag2EAyowxRoI4Lmfl60nt-kbQ>
 <xme:KhLWYQoR_8MWTGNKel2lNOXQZ4MEukT3tG6PTiTcz4uY3x_auD4JrcaHLZJuYlfSC
 pFtKzkjp5uLSkJ-SA>
X-ME-Received: <xmr:KhLWYXOVgfWwxFdvWfF96vAimZ1NbGvvX2U8uwTxk25Hpb0BaCke4zZwskkXkowsDNyqAFJc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudefjedgieekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghiucgj
 rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepieejue
 dvueduuefhgefhheeiuedvtedvuefgieegveetueeiueehtdegudehfeelnecuvehluhhs
 thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
 hnthdrtghomh
X-ME-Proxy: <xmx:KhLWYR5gWblxfqEOHQHmeqm7Pk1tG-0IAb18i-LCKfgHhFyjrcBI8w>
 <xmx:KhLWYR6lVBPqe2BN07Rb-SbdpKZuqC9FilGEdGlCBDlGhJRjjVZg9A>
 <xmx:KhLWYRje8QPp0PSHpCB4XK2fqu6vShfn2DzGe_ium3yaD6moXQlxXw>
 <xmx:KhLWYZydFgNoPX96UAxqOmfB6HJJWhSavlcNiZflMTEg2II6l7ycZw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jan 2022 16:48:26 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 5/8] mm: page_isolation: check specified range for
 unmovable pages during isolation.
Date: Wed,  5 Jan 2022 16:47:53 -0500
Message-Id: <20220105214756.91065-6-zi.yan@sent.com>
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

Enable set_migratetype_isolate() to check specified sub-range for
unmovable pages during isolation. Page isolation is done
at max(MAX_ORDER_NR_PAEGS, pageblock_nr_pages) granularity, but not all
pages within that granularity are intended to be isolated. For example,
alloc_contig_range(), which uses page isolation, allows ranges without
alignment. This commit makes unmovable page check only look for
interesting pages, so that page isolation can succeed for any
non-overlapping ranges.

has_unmovable_pages() is moved to mm/page_isolation.c since it is only
used by page isolation.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/page-isolation.h |   3 +-
 mm/memory_hotplug.c            |  12 ++-
 mm/page_alloc.c                | 122 +--------------------------
 mm/page_isolation.c            | 148 +++++++++++++++++++++++++++++++--
 4 files changed, 153 insertions(+), 132 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 572458016331..a4d2687ed4e6 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -33,8 +33,6 @@ static inline bool is_migrate_isolate(int migratetype)
 #define MEMORY_OFFLINE	0x1
 #define REPORT_FAILURE	0x2
 
-struct page *has_unmovable_pages(struct zone *zone, struct page *page,
-				 int migratetype, int flags);
 void set_pageblock_migratetype(struct page *page, int migratetype);
 int move_freepages_block(struct zone *zone, struct page *page,
 				int migratetype, int *num_movable);
@@ -44,6 +42,7 @@ int move_freepages_block(struct zone *zone, struct page *page,
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
index e1c09ae54e31..faee7637740a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8864,125 +8864,6 @@ void *__init alloc_large_system_hash(const char *tablename,
 	return table;
 }
 
-/*
- * This function checks whether pageblock includes unmovable pages or not.
- *
- * PageLRU check without isolation or lru_lock could race so that
- * MIGRATE_MOVABLE block might include unmovable pages. And __PageMovable
- * check without lock_page also may miss some movable non-lru pages at
- * race condition. So you can't expect this function should be exact.
- *
- * Returns a page without holding a reference. If the caller wants to
- * dereference that page (e.g., dumping), it has to make sure that it
- * cannot get removed (e.g., via memory unplug) concurrently.
- *
- */
-struct page *has_unmovable_pages(struct zone *zone, struct page *page,
-				 int migratetype, int flags)
-{
-	unsigned long iter = 0;
-	unsigned long pfn = page_to_pfn(page);
-	unsigned long offset = pfn % pageblock_nr_pages;
-
-	if (is_migrate_cma_page(page)) {
-		/*
-		 * CMA allocations (alloc_contig_range) really need to mark
-		 * isolate CMA pageblocks even when they are not movable in fact
-		 * so consider them movable here.
-		 */
-		if (is_migrate_cma(migratetype))
-			return NULL;
-
-		return page;
-	}
-
-	for (; iter < pageblock_nr_pages - offset; iter++) {
-		page = pfn_to_page(pfn + iter);
-
-		/*
-		 * Both, bootmem allocations and memory holes are marked
-		 * PG_reserved and are unmovable. We can even have unmovable
-		 * allocations inside ZONE_MOVABLE, for example when
-		 * specifying "movablecore".
-		 */
-		if (PageReserved(page))
-			return page;
-
-		/*
-		 * If the zone is movable and we have ruled out all reserved
-		 * pages then it should be reasonably safe to assume the rest
-		 * is movable.
-		 */
-		if (zone_idx(zone) == ZONE_MOVABLE)
-			continue;
-
-		/*
-		 * Hugepages are not in LRU lists, but they're movable.
-		 * THPs are on the LRU, but need to be counted as #small pages.
-		 * We need not scan over tail pages because we don't
-		 * handle each tail page individually in migration.
-		 */
-		if (PageHuge(page) || PageTransCompound(page)) {
-			struct page *head = compound_head(page);
-			unsigned int skip_pages;
-
-			if (PageHuge(page)) {
-				if (!hugepage_migration_supported(page_hstate(head)))
-					return page;
-			} else if (!PageLRU(head) && !__PageMovable(head)) {
-				return page;
-			}
-
-			skip_pages = compound_nr(head) - (page - head);
-			iter += skip_pages - 1;
-			continue;
-		}
-
-		/*
-		 * We can't use page_count without pin a page
-		 * because another CPU can free compound page.
-		 * This check already skips compound tails of THP
-		 * because their page->_refcount is zero at all time.
-		 */
-		if (!page_ref_count(page)) {
-			if (PageBuddy(page))
-				iter += (1 << buddy_order(page)) - 1;
-			continue;
-		}
-
-		/*
-		 * The HWPoisoned page may be not in buddy system, and
-		 * page_count() is not 0.
-		 */
-		if ((flags & MEMORY_OFFLINE) && PageHWPoison(page))
-			continue;
-
-		/*
-		 * We treat all PageOffline() pages as movable when offlining
-		 * to give drivers a chance to decrement their reference count
-		 * in MEM_GOING_OFFLINE in order to indicate that these pages
-		 * can be offlined as there are no direct references anymore.
-		 * For actually unmovable PageOffline() where the driver does
-		 * not support this, we will fail later when trying to actually
-		 * move these pages that still have a reference count > 0.
-		 * (false negatives in this function only)
-		 */
-		if ((flags & MEMORY_OFFLINE) && PageOffline(page))
-			continue;
-
-		if (__PageMovable(page) || PageLRU(page))
-			continue;
-
-		/*
-		 * If there are RECLAIMABLE pages, we need to check
-		 * it.  But now, memory offline itself doesn't call
-		 * shrink_node_slabs() and it still to be fixed.
-		 */
-		return page;
-	}
-	return NULL;
-}
-
 #ifdef CONFIG_CONTIG_ALLOC
 static unsigned long pfn_max_align_down(unsigned long pfn)
 {
@@ -9226,7 +9107,8 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	 * put back to page allocator so that buddy can use them.
 	 */
 
-	ret = start_isolate_page_range(isolate_start, isolate_end, migratetype, 0);
+	ret = start_isolate_page_range(start, end, isolate_start, isolate_end,
+				       migratetype, 0);
 	if (ret)
 		goto done;
 
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 6a0ddda6b3c5..7a7991460eb9 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -15,12 +15,143 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/page_isolation.h>
 
-static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags)
+/*
+ * This function checks whether pageblock within [start_pfn, end_pfn) includes
+ * unmovable pages or not.
+ *
+ * PageLRU check without isolation or lru_lock could race so that
+ * MIGRATE_MOVABLE block might include unmovable pages. And __PageMovable
+ * check without lock_page also may miss some movable non-lru pages at
+ * race condition. So you can't expect this function should be exact.
+ *
+ * Returns a page without holding a reference. If the caller wants to
+ * dereference that page (e.g., dumping), it has to make sure that it
+ * cannot get removed (e.g., via memory unplug) concurrently.
+ *
+ */
+static struct page *has_unmovable_pages(struct zone *zone, struct page *page,
+				 int migratetype, int flags,
+				 unsigned long start_pfn, unsigned long end_pfn)
+{
+	unsigned long first_pfn = max(page_to_pfn(page), start_pfn);
+	unsigned long pfn = first_pfn;
+	unsigned long last_pfn = min(ALIGN(pfn + 1, pageblock_nr_pages), end_pfn);
+
+	page = pfn_to_page(pfn);
+
+	if (is_migrate_cma_page(page)) {
+		/*
+		 * CMA allocations (alloc_contig_range) really need to mark
+		 * isolate CMA pageblocks even when they are not movable in fact
+		 * so consider them movable here.
+		 */
+		if (is_migrate_cma(migratetype))
+			return NULL;
+
+		return page;
+	}
+
+	for (pfn = first_pfn; pfn < last_pfn; pfn++) {
+		page = pfn_to_page(pfn);
+
+		/*
+		 * Both, bootmem allocations and memory holes are marked
+		 * PG_reserved and are unmovable. We can even have unmovable
+		 * allocations inside ZONE_MOVABLE, for example when
+		 * specifying "movablecore".
+		 */
+		if (PageReserved(page))
+			return page;
+
+		/*
+		 * If the zone is movable and we have ruled out all reserved
+		 * pages then it should be reasonably safe to assume the rest
+		 * is movable.
+		 */
+		if (zone_idx(zone) == ZONE_MOVABLE)
+			continue;
+
+		/*
+		 * Hugepages are not in LRU lists, but they're movable.
+		 * THPs are on the LRU, but need to be counted as #small pages.
+		 * We need not scan over tail pages because we don't
+		 * handle each tail page individually in migration.
+		 */
+		if (PageHuge(page) || PageTransCompound(page)) {
+			struct page *head = compound_head(page);
+			unsigned int skip_pages;
+
+			if (PageHuge(page)) {
+				if (!hugepage_migration_supported(page_hstate(head)))
+					return page;
+			} else if (!PageLRU(head) && !__PageMovable(head)) {
+				return page;
+			}
+
+			skip_pages = compound_nr(head) - (page - head);
+			pfn += skip_pages - 1;
+			continue;
+		}
+
+		/*
+		 * We can't use page_count without pin a page
+		 * because another CPU can free compound page.
+		 * This check already skips compound tails of THP
+		 * because their page->_refcount is zero at all time.
+		 */
+		if (!page_ref_count(page)) {
+			if (PageBuddy(page))
+				pfn += (1 << buddy_order(page)) - 1;
+			continue;
+		}
+
+		/*
+		 * The HWPoisoned page may be not in buddy system, and
+		 * page_count() is not 0.
+		 */
+		if ((flags & MEMORY_OFFLINE) && PageHWPoison(page))
+			continue;
+
+		/*
+		 * We treat all PageOffline() pages as movable when offlining
+		 * to give drivers a chance to decrement their reference count
+		 * in MEM_GOING_OFFLINE in order to indicate that these pages
+		 * can be offlined as there are no direct references anymore.
+		 * For actually unmovable PageOffline() where the driver does
+		 * not support this, we will fail later when trying to actually
+		 * move these pages that still have a reference count > 0.
+		 * (false negatives in this function only)
+		 */
+		if ((flags & MEMORY_OFFLINE) && PageOffline(page))
+			continue;
+
+		if (__PageMovable(page) || PageLRU(page))
+			continue;
+
+		/*
+		 * If there are RECLAIMABLE pages, we need to check
+		 * it.  But now, memory offline itself doesn't call
+		 * shrink_node_slabs() and it still to be fixed.
+		 */
+		return page;
+	}
+	return NULL;
+}
+
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
 	unsigned long flags;
 
+	VM_BUG_ON(page_to_pfn(page) < start_pfn || page_to_pfn(page) >= end_pfn);
+
 	spin_lock_irqsave(&zone->lock, flags);
 
 	/*
@@ -37,7 +168,7 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	 * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
 	 * We just check MOVABLE pages.
 	 */
-	unmovable = has_unmovable_pages(zone, page, migratetype, isol_flags);
+	unmovable = has_unmovable_pages(zone, page, migratetype, isol_flags, start_pfn, end_pfn);
 	if (!unmovable) {
 		unsigned long nr_pages;
 		int mt = get_pageblock_migratetype(page);
@@ -185,20 +316,19 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
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
