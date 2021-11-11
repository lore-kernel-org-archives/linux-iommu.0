Return-Path: <SRS0=Rhk0=P6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBD5C43219
	for <iommu@archiver.kernel.org>; Thu, 11 Nov 2021 06:50:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCCDA61269
	for <iommu@archiver.kernel.org>; Thu, 11 Nov 2021 06:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DCCDA61269
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B807A400FB;
	Thu, 11 Nov 2021 06:50:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rmTq8EUEJ7ht; Thu, 11 Nov 2021 06:50:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 347E740389;
	Thu, 11 Nov 2021 06:50:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E5EEC0020;
	Thu, 11 Nov 2021 06:50:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72C69C0037
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 06:50:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4FE2781A58
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 06:50:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9zekthKrHQEZ for <iommu@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 06:50:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A7ED081A3B
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 06:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=qMo+bjAzeWFxsfQshBen4Uepjri4P1fEfty46+VlKuU=; b=R/Cdc7jDX22S/7itMseKL1Rg2C
 SQM3Ie+Ze8wemWjV/WQJNdLj0lM+puBV8JbXwsqr7ug5v+jh3GIWZqIJ2FZ2c1h/8VJM5FEWA4iqR
 nqqfNp+QMAlUJEQ2BxnVGMiBoQyu/WObDFsHtOYhfDkETemrD5zAql0PvoPTeEX2gLlBoBOqdiF/P
 VP2CEMFqRB4H167pGrUCz1o3l1ykQy4r9anbwKAdIdhitfESC+iD6lIXQ8PgxI0m4OBcqiBd+7O5o
 4Mmoe0IJcVrhSXe/gFTYEUxhuiDgBQ9JH2JWrSL6droBgTPEbZ7+RyzLtncvhOnpL6gdD050U/yV/
 kxLIYm5g==;
Received: from [2001:4bb8:19a:7ee7:dc25:8b64:278b:ff22] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ml3us-002VxY-Jq; Thu, 11 Nov 2021 06:50:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 05/11] dma-direct: factor out a helper for
 DMA_ATTR_NO_KERNEL_MAPPING allocations
Date: Thu, 11 Nov 2021 07:50:21 +0100
Message-Id: <20211111065028.32761-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211111065028.32761-1-hch@lst.de>
References: <20211111065028.32761-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/direct.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 3d1718dc077e9..01104660ec439 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -168,6 +168,24 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
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
@@ -180,17 +198,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
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
