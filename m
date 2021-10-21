Return-Path: <SRS0=0R9D=PJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C674C433F5
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 09:06:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45F5C610CF
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 09:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 45F5C610CF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0FD20405E2;
	Thu, 21 Oct 2021 09:06:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PiDQlOAXliXz; Thu, 21 Oct 2021 09:06:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B5318401DE;
	Thu, 21 Oct 2021 09:06:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C926C001C;
	Thu, 21 Oct 2021 09:06:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21B70C0011
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 09:06:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BFEE083B71
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 09:06:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mfC28JP7Fx55 for <iommu@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:06:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4AE2083B3B
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 09:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=zUiL1AG5rg8VRX9SP7Zw7qqY8rxsTHKJz1OkI9SVAH4=; b=UggbrPOnaPKevdi/d9Xet9tHTd
 KrRGSiM5VXcvvYXVfgEwzlLZ22EcgDZoYLnGPUiBBw9zDh7cyJ3+Snhz9SElJFtbC0rIpqB+Wix4I
 hRB06umXCFZNkAcuxaC2UZTr+aBBlSgcBmmLmCUIGIBx2wz7eYQ8Z+BgnBOGJMSV4m9FS4Q/zyNJh
 nlOC8TCuEKhutWGE5Uf3juDR/9jkWxJ1vE9d3f7zRTwEwqohPAhSh7fEEKHLYf0bNy3ZzAvS4AL43
 ksOxqy8iL8ReCCzCyLEajTrmw/xCQ76vVMzGTA5nJSrMqDa8SJRzcnNC0BBETGAzKSZ09nsse3cBG
 stTS0Yrg==;
Received: from [2001:4bb8:180:8777:7df0:a8d8:40cc:3310] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdU21-006xy7-Ue; Thu, 21 Oct 2021 09:06:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 07/10] dma-direct: warn if there is no pool for force
 unencrypted allocations
Date: Thu, 21 Oct 2021 11:06:08 +0200
Message-Id: <20211021090611.488281-8-hch@lst.de>
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

Instead of blindly running into a blocking operation for a non-blocking gfp,
return NULL and spew an error.  Note that Kconfig prevents this for all
currently relevant platforms, and this is just a debug check.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index d66f37f34ba71..680fe10410645 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -154,6 +154,9 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
 	u64 phys_mask;
 	void *ret;
 
+	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_DMA_COHERENT_POOL)))
+		return NULL;
+
 	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
 					   &phys_mask);
 	page = dma_alloc_from_pool(dev, size, &ret, gfp, dma_coherent_ok);
@@ -234,8 +237,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	 * Decrypting memory may block, so allocate the memory from the atomic
 	 * pools if we can't block.
 	 */
-	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
-	    force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp) &&
+	if (force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp) &&
 	    !is_swiotlb_for_alloc(dev))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
@@ -353,8 +355,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	struct page *page;
 	void *ret;
 
-	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
-	    force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp) &&
+	if (force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp) &&
 	    !is_swiotlb_for_alloc(dev))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
