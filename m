Return-Path: <SRS0=Rhk0=P6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3207CC433F5
	for <iommu@archiver.kernel.org>; Thu, 11 Nov 2021 06:50:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE8F66135E
	for <iommu@archiver.kernel.org>; Thu, 11 Nov 2021 06:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EE8F66135E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB368404F7;
	Thu, 11 Nov 2021 06:50:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SS-yYX04WjEi; Thu, 11 Nov 2021 06:50:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B0F5D40500;
	Thu, 11 Nov 2021 06:50:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 901DFC0020;
	Thu, 11 Nov 2021 06:50:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A741C0039
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 06:50:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3718B404FB
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 06:50:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vvXyVdTm5kiq for <iommu@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 06:50:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8765F404F7
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 06:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=7WOe6ePH/B+9wbz1fCHXt/UcjMyJNqErfeguFTW5lTo=; b=eRkH6dBclCASthJ/efz8neIrlG
 37CbjoawOTitr/by446w70gUvsx3Ynm+j1stUh8lNeYAkm02Mff98i/o2ELgG1ecH2Dzv2LU5JqWX
 kiNJ6eTTBnB3tpHSvX8KnUEPlvAiIbRvRWNvfVXgyPEd3a6eoK7Ih2e246O7Kept/nASyJrzK3trY
 cHmsXaYS1jqpFifhf1aHy7gtJO9e58jwIZagSzu6SNhMZr5ogCNDJaJ5P/dWm28yQ1ebhoUTHAglX
 efdE03JX0k9tzn2EIbZZom8u/DgvO+JEUk66krzT1l5jSF+y+QC2M9wYQnd2lsApHOLVeg1src8HM
 q249rLsw==;
Received: from [2001:4bb8:19a:7ee7:dc25:8b64:278b:ff22] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ml3v0-002Vyz-IZ; Thu, 11 Nov 2021 06:50:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 11/11] dma-direct: add a dma_direct_use_pool helper
Date: Thu, 11 Nov 2021 07:50:27 +0100
Message-Id: <20211111065028.32761-12-hch@lst.de>
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

Add a helper to check if a potentially blocking operation should
dip into the atomic pools.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 kernel/dma/direct.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 924937c54e8ab..d0a317ed8f029 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -156,6 +156,15 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 	return page;
 }
 
+/*
+ * Check if a potentially blocking operations needs to dip into the atomic
+ * pools for the given device/gfp.
+ */
+static bool dma_direct_use_pool(struct device *dev, gfp_t gfp)
+{
+	return gfpflags_allow_blocking(gfp) && !is_swiotlb_for_alloc(dev);
+}
+
 static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp)
 {
@@ -235,8 +244,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		 */
 		remap = IS_ENABLED(CONFIG_DMA_DIRECT_REMAP);
 		if (remap) {
-			if (!gfpflags_allow_blocking(gfp) &&
-			    !is_swiotlb_for_alloc(dev))
+			if (dma_direct_use_pool(dev, gfp))
 				return dma_direct_alloc_from_pool(dev, size,
 						dma_handle, gfp);
 		} else {
@@ -250,8 +258,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	 * Decrypting memory may block, so allocate the memory from the atomic
 	 * pools if we can't block.
 	 */
-	if (force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp) &&
-	    !is_swiotlb_for_alloc(dev))
+	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
 	/* we always manually zero the memory once we are done */
@@ -360,8 +367,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	struct page *page;
 	void *ret;
 
-	if (force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp) &&
-	    !is_swiotlb_for_alloc(dev))
+	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
 	page = __dma_direct_alloc_pages(dev, size, gfp);
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
