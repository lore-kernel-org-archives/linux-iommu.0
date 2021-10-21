Return-Path: <SRS0=0R9D=PJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDD5C433F5
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 09:06:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B811F60F56
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 09:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B811F60F56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8B20840590;
	Thu, 21 Oct 2021 09:06:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pX18HX8pavJ8; Thu, 21 Oct 2021 09:06:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4A42F401D1;
	Thu, 21 Oct 2021 09:06:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30126C001C;
	Thu, 21 Oct 2021 09:06:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4B6AC0011
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 09:06:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 86672407CD
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 09:06:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wHPiRAzRE31A for <iommu@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:06:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0D845407C3
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 09:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=UcrxCktBYDGGVrUlmViHP5O38gx0nxV8RkOhIe2gL68=; b=X07XGlKgSwOw1lr85sGJm1mA8c
 By9QElvDhsqxmgdjLGQgmqL7eh4EgcxSevFSjFf2pJuz1cEh0L+/2Gk6Am8SYi7tpwFHf6IuKZ+tc
 f80gVLMQlbX0NHOjvCXz+hreZXrIUkO7NfASiy8x+/bnEdsMHXVB3dx1IN3j5Z///z8HmZ2DqewFH
 s0cDC12PSBKmObcmpHV3dmjdl1+zXDQ0vui1pE83LvkDdjQ++cSIFDGXPVasT76Y6IzLZSD2jyD0w
 J6Gw8EfjCwqaB/bvnk++Me5K2+MTpWqFTdfKKEhF8iEl3J62CR9iaxn4A//Jpl3cQZIEOkpjIYXMh
 roAHXxLw==;
Received: from [2001:4bb8:180:8777:7df0:a8d8:40cc:3310] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdU1u-006xwT-VK; Thu, 21 Oct 2021 09:06:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 05/10] dma-direct: factor out a helper for
 DMA_ATTR_NO_KERNEL_MAPPING allocations
Date: Thu, 21 Oct 2021 11:06:06 +0200
Message-Id: <20211021090611.488281-6-hch@lst.de>
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

Split the code for DMA_ATTR_NO_KERNEL_MAPPING allocations into a separate
helper to make dma_direct_alloc a little more readable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/direct.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index a6b6fe72af4d1..4ffdb524942a1 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -163,6 +163,24 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
 	return ret;
 }
 
+static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp)
+{
+	struct page *page;
+
+	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO);
+	if (!page)
+		return NULL;
+
+	/* remove any dirty cache lines on the kernel alias */
+	if (!PageHighMem(page))
+		arch_dma_prep_coherent(page, size);
+
+	/* return the page pointer as the opaque cookie */
+	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	return page;
+}
+
 void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
@@ -175,17 +193,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		gfp |= __GFP_NOWARN;
 
 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
-	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev)) {
-		page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO);
-		if (!page)
-			return NULL;
-		/* remove any dirty cache lines on the kernel alias */
-		if (!PageHighMem(page))
-			arch_dma_prep_coherent(page, size);
-		*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
-		/* return the page pointer as the opaque cookie */
-		return page;
-	}
+	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
+		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp);
 
 	if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
 	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
