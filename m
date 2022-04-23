Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99985C433F5
	for <iommu@archiver.kernel.org>; Sat, 23 Apr 2022 17:25:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F8BB41739;
	Sat, 23 Apr 2022 17:25:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NYmDodHRWDz4; Sat, 23 Apr 2022 17:25:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BF20741602;
	Sat, 23 Apr 2022 17:25:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6757DC0039;
	Sat, 23 Apr 2022 17:25:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE1BBC002D
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 17:24:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CB22940195
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 17:24:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p_NJWZjogA-D for <iommu@lists.linux-foundation.org>;
 Sat, 23 Apr 2022 17:24:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3709A400E3
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 17:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=O8BkflHzt4Q2xdBNgokh+a21xrsHro11NNcWXRL8KqI=; b=LaoAwF92KT/in9LnnwNor46A/m
 SYcFhnBiYwYA/rXSwlKWs5v/u5y3sHmfGL5+9OCjkCdJGnv2s98r1P0zFmiCG93sbq9f4IiDiI50S
 0cqtZ0Z0hlfeX5Ur1DUNeUp9C+jX282uc4ctfmKiqSbMFykf+HtNa4uBDUEgoLFfNi5owE5GX8v90
 d2PkFNEvOaK31fBrqXKVhlQA7TN+lA1Kb78MGNnQdrSTHSzCLKx5pMYP88+U5W6A7O4aznJ8/9mMO
 o8VcM7I1YU1Mo/BrHYUWgWu5hPxWTX3iXJU3trkV5gu2T6wGOdi1W7qdKlYoVgq1sA9KNNcNGJDPQ
 7XdYHUwg==;
Received: from [2001:4bb8:18d:be1d:2a19:700d:8998:ac2a] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1niJVA-004jbl-U5; Sat, 23 Apr 2022 17:24:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] dma-direct: don't fail on highmem CMA pages in
 dma_direct_alloc_pages
Date: Sat, 23 Apr 2022 19:24:54 +0200
Message-Id: <20220423172454.1833421-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: robin.murphy@arm.com, Mark O'Neill <mao@tumblingdice.co.uk>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

When dma_direct_alloc_pages encounters a highmem page it just gives up
currently.  But what we really should do is to try memory using the
page allocator instead - without this platforms with a global highmem
CMA pool will fail all dma_alloc_pages allocations.

Fixes: efa70f2fdc84 ("dma-mapping: add a new dma_alloc_pages API")
Reported-by: Mark O'Neill <mao@tumblingdice.co.uk>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 9743c6ccce1a9..3e7f4aab740e4 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -115,7 +115,7 @@ static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size)
 }
 
 static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
-		gfp_t gfp)
+		gfp_t gfp, bool allow_highmem)
 {
 	int node = dev_to_node(dev);
 	struct page *page = NULL;
@@ -129,9 +129,12 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
 					   &phys_limit);
 	page = dma_alloc_contiguous(dev, size, gfp);
-	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
-		dma_free_contiguous(dev, page, size);
-		page = NULL;
+	if (page) {
+		if (!dma_coherent_ok(dev, page_to_phys(page), size) ||
+		    (!allow_highmem && PageHighMem(page))) {
+			dma_free_contiguous(dev, page, size);
+			page = NULL;
+		}
 	}
 again:
 	if (!page)
@@ -189,7 +192,7 @@ static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
 {
 	struct page *page;
 
-	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO);
+	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
 	if (!page)
 		return NULL;
 
@@ -262,7 +265,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
 	/* we always manually zero the memory once we are done */
-	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO);
+	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
 	if (!page)
 		return NULL;
 
@@ -370,19 +373,9 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
-	page = __dma_direct_alloc_pages(dev, size, gfp);
+	page = __dma_direct_alloc_pages(dev, size, gfp, false);
 	if (!page)
 		return NULL;
-	if (PageHighMem(page)) {
-		/*
-		 * Depending on the cma= arguments and per-arch setup
-		 * dma_alloc_contiguous could return highmem pages.
-		 * Without remapping there is no way to return them here,
-		 * so log an error and fail.
-		 */
-		dev_info(dev, "Rejecting highmem page from CMA.\n");
-		goto out_free_pages;
-	}
 
 	ret = page_address(page);
 	if (dma_set_decrypted(dev, ret, size))
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
