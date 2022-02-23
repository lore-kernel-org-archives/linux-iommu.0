Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664C4C433EF
	for <iommu@archiver.kernel.org>; Wed, 23 Feb 2022 04:30:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C624813A3;
	Wed, 23 Feb 2022 04:30:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q_BjNW9kwMqw; Wed, 23 Feb 2022 04:30:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DDA838139C;
	Wed, 23 Feb 2022 04:30:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91443C001A;
	Wed, 23 Feb 2022 04:30:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B90B5C0011;
 Wed, 23 Feb 2022 04:30:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9307B4092F;
 Wed, 23 Feb 2022 04:30:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sent.com header.b="loroW7MK";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="R4aMF6ON"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MaBW2vzpyHCr; Wed, 23 Feb 2022 04:30:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DDF5740912;
 Wed, 23 Feb 2022 04:30:49 +0000 (UTC)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailnew.nyi.internal (Postfix) with ESMTP id 18511580137;
 Tue, 22 Feb 2022 23:30:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Tue, 22 Feb 2022 23:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
 :cc:content-transfer-encoding:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to
 :reply-to:sender:subject:subject:to:to; s=fm2; bh=AfFDHj1c96/TKE
 7TOTCl/a+qq6hQy8alpItolvHSm/8=; b=loroW7MKBg/4JLVLHXMyTJwf0my9rK
 OvhbebnI3I0jYeSfHnVR+xWdKDDBgGTlKqG0ToyousjhFJo3aQyDGAgwFpa0NmO4
 4+u8bxfOr1eqGhzLVk82L+OOPDLWPPvZ5u/6sSlD6lhytqtrj3nFYIC4lChVtThC
 Be+gvrI76BJ+YyeUnIC0siPLBduxPUOoS/8jXW4pVIqj7S8ZhRfrG2dufqWn438o
 4rscDaib/zQuGVnCBFY0HPWu2K3latDoS8Ac+jHOcKfQixpOGtyX5cJ8SCY1MAV8
 mbw2U3jUeEdpGG9PTYLo7YM9YgBrfeSI1NSduMNvezDxLc/9aNihcTJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=AfFDHj1c96/TKE7TOTCl/a+qq6hQy8alpItolvHSm/8=; b=R4aMF6ON
 Vlc3etrYS96dvAL/WToZ49N9W1jJAY2pT6fGZd29fPfEfl5V563F3yvHeaLG1NzU
 XpKdMwYwekuZ9YO9T04qHKAqkiCa4Qk38LSAJsyPCANdLuVR+XtMzKXzPn2IyW+9
 ks16ehPM/gMyFNZev4ECkRw2YLv65yRsOOMPRTA8mG9osBjHux7BM8lP0gT+D5TO
 yIup2BWS6C7T4FeLXP9JubZ9sJ2AUyuZmbyA5qpyXyfBpgwXPVHkI30Rp0wjelni
 I2aiI8lJZVivXdPp3n8EC9ROkuHPTwCn2N3h9smi9OhJkZja0kQ8MEKv6u0dqRvh
 n4OTv8XWikHaXA==
X-ME-Sender: <xms:eLgVYkAi33MZLe2zHyto2r5Ay-v3h9OSANLpOR3uwopGSdUEu5ZJ6A>
 <xme:eLgVYmgxvSkIeZnnH0c1XbCkTOovx-NZ3RWYfzWWRnGFmnMhevZLl3XMTJENyRWlf
 81AWT6HSpjtKdqm6g>
X-ME-Received: <xmr:eLgVYnnRMXM5CxmfFmcDwBcROzt2VOdu_M0XcYytR-B0t-B5VPQJyTkzhe9RMHwvY_dgGFLs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeelgdejudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
 nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeeuvd
 euudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhushht
 vghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
 htrdgtohhm
X-ME-Proxy: <xmx:eLgVYqxS2Bz3WA58WJTxKvt_-GBI_I-y7jD8oHKDQf5QtesCl5Qyqg>
 <xmx:eLgVYpR_NT2MUYN0ToUtzkSr9X1a4YdewihXq9nLDX3BHQAwoO4sdw>
 <xmx:eLgVYlbmvJWin1DPrSFP6XooqawzUwpLPunehXu5tQmag_YTlQC38w>
 <xmx:ebgVYiiC5VXsXmfwDM8dpIFZDNHzX8eLI8U3fo3xcB49iggVaMZTrw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Feb 2022 23:30:48 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Subject: [PATCH v6 4/5] mm: cma: use pageblock_order as the single alignment
Date: Tue, 22 Feb 2022 23:30:36 -0500
Message-Id: <20220223043037.715205-5-zi.yan@sent.com>
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

Now alloc_contig_range() works at pageblock granularity. Change CMA
allocation, which uses alloc_contig_range(), to use pageblock_order
alignment.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/cma.h    | 4 ++--
 include/linux/mmzone.h | 5 +----
 mm/page_alloc.c        | 4 ++--
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 90fd742fd1ef..22fa94231dfe 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -21,11 +21,11 @@
 #define CMA_MAX_NAME 64
 
 /*
- * TODO: once the buddy -- especially pageblock merging and alloc_contig_range()
+ *  the buddy -- especially pageblock merging and alloc_contig_range()
  * -- can deal with only some pageblocks of a higher-order page being
  *  MIGRATE_CMA, we can use pageblock_nr_pages.
  */
-#define CMA_MIN_ALIGNMENT_PAGES MAX_ORDER_NR_PAGES
+#define CMA_MIN_ALIGNMENT_PAGES pageblock_nr_pages
 #define CMA_MIN_ALIGNMENT_BYTES (PAGE_SIZE * CMA_MIN_ALIGNMENT_PAGES)
 
 struct cma;
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 3fff6deca2c0..da38c8436493 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -54,10 +54,7 @@ enum migratetype {
 	 *
 	 * The way to use it is to change migratetype of a range of
 	 * pageblocks to MIGRATE_CMA which can be done by
-	 * __free_pageblock_cma() function.  What is important though
-	 * is that a range of pageblocks must be aligned to
-	 * MAX_ORDER_NR_PAGES should biggest page be bigger than
-	 * a single pageblock.
+	 * __free_pageblock_cma() function.
 	 */
 	MIGRATE_CMA,
 #endif
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 038e044c5a80..90281e33e20a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9077,8 +9077,8 @@ int __alloc_contig_migrate_range(struct compact_control *cc,
  *			be either of the two.
  * @gfp_mask:	GFP mask to use during compaction
  *
- * The PFN range does not have to be pageblock or MAX_ORDER_NR_PAGES
- * aligned.  The PFN range must belong to a single zone.
+ * The PFN range does not have to be pageblock aligned. The PFN range must
+ * belong to a single zone.
  *
  * The first thing this routine does is attempt to MIGRATE_ISOLATE all
  * pageblocks in the range.  Once isolated, the pageblocks should not
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
