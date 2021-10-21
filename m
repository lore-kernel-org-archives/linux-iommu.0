Return-Path: <SRS0=0R9D=PJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4397BC433EF
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 09:06:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0265B60F56
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 09:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0265B60F56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D49EF60EAC;
	Thu, 21 Oct 2021 09:06:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vul2t7VGC3MU; Thu, 21 Oct 2021 09:06:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8786260EA6;
	Thu, 21 Oct 2021 09:06:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A89FC001C;
	Thu, 21 Oct 2021 09:06:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56A16C0011
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 09:06:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3842383B71
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 09:06:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sn9kHSeSXLIr for <iommu@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:06:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 768D183B59
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 09:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=NpzWl91iAnav/E2YcIxtE0rgF2ScEmkyj1jmpzMXvK8=; b=z1LJREhWP+/SAkkWw5jbADDMV8
 n1QdFeauvo4HeQ+GwhLpamzzqIyItozwlNgUSSjTxfWM5ZyNBwQ3u+7GNvPEJRe/exC/M4rs5tZTs
 tJC18pqvoSWQuScv/qjK+S39try+I9D4HZsx9czWmJfYIEc3tvjFRP4vONaEdzocRwsjA5NLFciQ0
 aoIbVv8QAnKN+XJO8NRyNLl57Fg/n90wlr0dWOpUbSXtJwEDAvVx8Mg4DBJUsT2UREVfNEQAwgiSX
 i5BLx3OmJ6I6U0Ndbf5KZ3x9reOnHpg1gZnzhmqfB7CMILhTFYrsxJU6pAQNFRS75W46ETQYHdajC
 KqQCyeAw==;
Received: from [2001:4bb8:180:8777:7df0:a8d8:40cc:3310] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdU1y-006xxB-BI; Thu, 21 Oct 2021 09:06:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 06/10] dma-direct: refactor the !coherent checks in
 dma_direct_alloc
Date: Thu, 21 Oct 2021 11:06:07 +0200
Message-Id: <20211021090611.488281-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021090611.488281-1-hch@lst.de>
References: <20211021090611.488281-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Robin Murphy <robin.murphy@arm.com>, David Rientjes <rientjes@google.com>
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

Add a big central !dev_is_dma_coherent(dev) block to deal with as much
as of the uncached allocation schemes and document the schemes a bit
better.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 58 ++++++++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 4ffdb524942a1..d66f37f34ba71 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -196,29 +196,46 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
 		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp);
 
-	if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
-	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	    !IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
-	    !dev_is_dma_coherent(dev) &&
-	    !is_swiotlb_for_alloc(dev))
-		return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
+	if (!dev_is_dma_coherent(dev)) {
+		/*
+		 * Fallback to the arch handler if it exists.  This should
+		 * eventually go away.
+		 */
+		if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
+		    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
+		    !IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
+		    !is_swiotlb_for_alloc(dev))
+			return arch_dma_alloc(dev, size, dma_handle, gfp,
+					      attrs);
 
-	if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
-	    !dev_is_dma_coherent(dev))
-		return dma_alloc_from_global_coherent(dev, size, dma_handle);
+		/*
+		 * If there is a global pool, always allocate from it for
+		 * non-coherent devices.
+		 */
+		if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL))
+			return dma_alloc_from_global_coherent(dev, size,
+					dma_handle);
+
+		/*
+		 * Otherwise remap if the architecture is asking for it.  But
+		 * given that remapping memory is a blocking operation we'll
+		 * instead have to dip into the atomic pools.
+		 */
+		if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP)) {
+			if (!gfpflags_allow_blocking(gfp) &&
+			    !is_swiotlb_for_alloc(dev))
+				return dma_direct_alloc_from_pool(dev, size,
+						dma_handle, gfp);
+			remap = true;
+		}
+	}
 
 	/*
-	 * Remapping or decrypting memory may block. If either is required and
-	 * we can't block, allocate the memory from the atomic pools.
-	 * If restricted DMA (i.e., is_swiotlb_for_alloc) is required, one must
-	 * set up another device coherent pool by shared-dma-pool and use
-	 * dma_alloc_from_dev_coherent instead.
+	 * Decrypting memory may block, so allocate the memory from the atomic
+	 * pools if we can't block.
 	 */
 	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
-	    !gfpflags_allow_blocking(gfp) &&
-	    (force_dma_unencrypted(dev) ||
-	     (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	      !dev_is_dma_coherent(dev))) &&
+	    force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp) &&
 	    !is_swiotlb_for_alloc(dev))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
@@ -226,10 +243,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO);
 	if (!page)
 		return NULL;
-
-	if (!dev_is_dma_coherent(dev) && IS_ENABLED(CONFIG_DMA_DIRECT_REMAP)) {
-		remap = true;
-	} else if (PageHighMem(page)) {
+	if (PageHighMem(page)) {
 		/*
 		 * Depending on the cma= arguments and per-arch setup,
 		 * dma_alloc_contiguous could return highmem pages.
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
