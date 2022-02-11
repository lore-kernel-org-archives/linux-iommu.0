Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A032CC433EF
	for <iommu@archiver.kernel.org>; Fri, 11 Feb 2022 16:41:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 560A04164C;
	Fri, 11 Feb 2022 16:41:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V16ailjbRZK9; Fri, 11 Feb 2022 16:41:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2421B4091E;
	Fri, 11 Feb 2022 16:41:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFBC5C0072;
	Fri, 11 Feb 2022 16:41:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93EE2C000B;
 Fri, 11 Feb 2022 16:41:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 80C4561C2C;
 Fri, 11 Feb 2022 16:41:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sent.com header.b="zlqzeudl";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="glMY8862"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vdrckkJZIbFI; Fri, 11 Feb 2022 16:41:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com
 [66.111.4.221])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B63D460B6A;
 Fri, 11 Feb 2022 16:41:50 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.nyi.internal (Postfix) with ESMTP id DC08A58037A;
 Fri, 11 Feb 2022 11:41:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Fri, 11 Feb 2022 11:41:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
 :cc:content-transfer-encoding:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to
 :reply-to:sender:subject:subject:to:to; s=fm2; bh=New+plem0avY8e
 mMqwW+nHffrxO930geSXXz9NumNjU=; b=zlqzeudlmr9ByiQoXiXD4oWkPkQWrO
 9LeIZ5gkrbGwvDnTKD/QP5C7t0n60UprSyOc91UIp0QDNUGC/3yQQEqBXXxYPQHo
 ISZooymnxzQdfCRxb1cSPvkuA++2BhOfDjBnGnr6HfxxZjGFmymJKMpeCBwAJJx4
 Kdn2JXSIhmmG3UOv+Qr8TpZJ1iwPScWnQ4pqjPXgPSS5jLPDysklL2yiPX/5kegT
 N0v3yf7/Z7hTjjBH4xB5E3WvuLfQ/z/wvG4sKohcJCv3nPbLVIVN1gwBLXOmdHpg
 fs3ACxLgHy3notg1CzORsf99n6aUNQxFEtaUUKM7GycuXURNpPAN697w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=New+plem0avY8emMqwW+nHffrxO930geSXXz9NumNjU=; b=glMY8862
 ++fO/DiQl5ZcoUaX+3OrMgqO2GO7ce+m2y9vaERy5c20bmlc8TH+s4mIm7bau+jn
 jSQfTEV+8mBxlbrK/mnQe4uNCUYC4p35uLcjIiVDokPV9tHvIu4Ye4KhmqYt0Zd1
 /x49iWVgUZj+MmtBWMPAGHEqxXvd+5Z6CJnrEtC77JEDadDAgHCyQgLFljig4rD5
 DqMIcKJqEzXma0s5g25GvRIJb+kwjvY0owefkDGcJTmyahN+EsZToLLNW7BzbE7Z
 5yPcfnEsRT1G3Mj5rrTWVqFOHBPdNTyIluvVLCcaXsGCCD3gZZB+4VdSu45pxDPL
 bDEo/wpcNkunpg==
X-ME-Sender: <xms:zZEGYvQZk8gpyJ8Pj4MtnKrrV1cllmk7bA-shBiID7da2bQ5TfFOsg>
 <xme:zZEGYgxh2VzsSsDHtoWGS92KROwDZ6IOaP5yp-fIYliNcFFTLOv5w4rxgSEBJRqwP
 ZCDZDRd6w2oJHLnEQ>
X-ME-Received: <xmr:zZEGYk1yL6ya38syYLr1G1LjqLKWtYDTBZ7f511fQKctG2agJkuWDrwSlf3I7UuSfR3zQD5d>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieefgdeltdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcujggr
 nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeeuvd
 euudeuhfeghfehieeuvdetvdeugfeigeevteeuieeuhedtgeduheefleenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
 htrdgtohhm
X-ME-Proxy: <xmx:zZEGYvBExFrnqYPN1GAKuz3RfYVV016pydxo0I-qLICR1sqI2XXPJw>
 <xmx:zZEGYoi-BOVP3_n8Ys5qoDZIFjMyE5GUdJwZxKSWp7tJlEegBTEG5w>
 <xmx:zZEGYjrsedyBgPkS-8bdCK94Arbn9ZHrPjME_UrpWTWcOWYgILTTsg>
 <xmx:zZEGYo49QItq9tPnt2bioyW51iIaWPWLBspFiKS4UQyw7KC7EbNW1w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Feb 2022 11:41:49 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Subject: [PATCH v5 4/6] mm: cma: use pageblock_order as the single alignment
Date: Fri, 11 Feb 2022 11:41:33 -0500
Message-Id: <20220211164135.1803616-5-zi.yan@sent.com>
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

Now alloc_contig_range() works at pageblock granularity. Change CMA
allocation, which uses alloc_contig_range(), to use pageblock_order
alignment.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/mmzone.h  | 5 +----
 kernel/dma/contiguous.c | 2 +-
 mm/cma.c                | 6 ++----
 mm/page_alloc.c         | 4 ++--
 4 files changed, 6 insertions(+), 11 deletions(-)

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
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 3d63d91cba5c..ac35b14b0786 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -399,7 +399,7 @@ static const struct reserved_mem_ops rmem_cma_ops = {
 
 static int __init rmem_cma_setup(struct reserved_mem *rmem)
 {
-	phys_addr_t align = PAGE_SIZE << max(MAX_ORDER - 1, pageblock_order);
+	phys_addr_t align = PAGE_SIZE << pageblock_order;
 	phys_addr_t mask = align - 1;
 	unsigned long node = rmem->fdt_node;
 	bool default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
diff --git a/mm/cma.c b/mm/cma.c
index 766f1b82b532..b2e927fab7b5 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -187,8 +187,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 		return -EINVAL;
 
 	/* ensure minimal alignment required by mm core */
-	alignment = PAGE_SIZE <<
-			max_t(unsigned long, MAX_ORDER - 1, pageblock_order);
+	alignment = PAGE_SIZE << pageblock_order;
 
 	/* alignment should be aligned with order_per_bit */
 	if (!IS_ALIGNED(alignment >> PAGE_SHIFT, 1 << order_per_bit))
@@ -275,8 +274,7 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
 	 * migratetype page by page allocator's buddy algorithm. In the case,
 	 * you couldn't get a contiguous memory, which is not what we want.
 	 */
-	alignment = max(alignment,  (phys_addr_t)PAGE_SIZE <<
-			  max_t(unsigned long, MAX_ORDER - 1, pageblock_order));
+	alignment = max(alignment,  (phys_addr_t)PAGE_SIZE << pageblock_order);
 	if (fixed && base & (alignment - 1)) {
 		ret = -EINVAL;
 		pr_err("Region at %pa must be aligned to %pa bytes\n",
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7a4fa21aea5c..ac9432e63ce1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9214,8 +9214,8 @@ int isolate_single_pageblock(unsigned long boundary_pfn, gfp_t gfp_flags,
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
