Return-Path: <SRS0=0fjx=PH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A48C433F5
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 12:29:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 208F361378
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 12:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 208F361378
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DF713403A8;
	Tue, 19 Oct 2021 12:29:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uA5p5jv49_ev; Tue, 19 Oct 2021 12:29:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 886A740500;
	Tue, 19 Oct 2021 12:29:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6421AC000F;
	Tue, 19 Oct 2021 12:29:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6D7EC000D
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 12:29:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A723D403A8
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 12:29:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rnWYKTyTZuGZ for <iommu@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 12:29:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F160040500
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 12:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=cduG1gs6wS6s9qRxFJpbYm3uUZVY10jfCD3ULzR1drw=; b=VrIZR+NC8HXN2mCXNR8G+YQ99P
 S4ka2IdaG/cYBz68LOX/6m2gYQXAAW5nQyqxpgfbwot/tlFdcXgrMph27DVABhjV9WeXpYiYkRyoy
 k1twJHIUofcpfAr8qPGZBRT3OP3QhHQHVfmJIkZr3CqoDb0noVf/h92Pa6bVlDppjVhJ+HpGsNw6b
 4Uq9vVDeMk5Y+lNawvDWoZ8pCi/Wt70KvTOXOrv7MqoiICpqNa/S/fW5Umj8mj2k+V/yjWCDtdJ34
 WorVsB7PrAnEh7uHSO+YxKxp/anTzWgrvC4Jma2vA8wP2FI89qUYsTy8wFvFwbRA9UTwI0Bkt0Y0I
 2rw5RJtA==;
Received: from [2001:4bb8:180:8777:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcoFF-001C6C-LV; Tue, 19 Oct 2021 12:29:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 4/4] dma-direct: factor out a helper for
 DMA_ATTR_NO_KERNEL_MAPPING allocations
Date: Tue, 19 Oct 2021 14:29:16 +0200
Message-Id: <20211019122916.2468032-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019122916.2468032-1-hch@lst.de>
References: <20211019122916.2468032-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Robin Murphy <robin.murphy@arm.com>, id Rientjes <rientjes@google.com>
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
---
 kernel/dma/direct.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 41498243d8444..21728c5f0ccd7 100644
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
@@ -176,17 +194,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
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
