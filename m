Return-Path: <SRS0=0R9D=PJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCA8C433F5
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 09:06:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6D2A610CB
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 09:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C6D2A610CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A5DB8405E2;
	Thu, 21 Oct 2021 09:06:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NE4-Sm8C_c6k; Thu, 21 Oct 2021 09:06:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4DE9E405E5;
	Thu, 21 Oct 2021 09:06:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B251C001C;
	Thu, 21 Oct 2021 09:06:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F8E4C0011
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 09:06:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0049460EB3
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 09:06:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rukfCc87xz2F for <iommu@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:06:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6F93C60EAC
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 09:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=JJBZ5oxINsBB2qtE4L5UUxGSdj/2PlX2eIqfKS/VI/4=; b=I3RQeW2MP2VbM3KQfI2RDrlITo
 e2/ZP96S58WeVMMAtY7Ngz1v9n1mokGN+rO5DF5j6TUN/llHHAbLpaCq0wwr9FJBUssoWGZDcBTzA
 71oRzn/h9V4KkH9vSKhCGQ6bay0IYzOi30wtzyKSxBNS/J3xfxTQX8UHpPbGoSWYY0qhPdbZP8atJ
 xKNBnVCH1XBtrxAcXz52qo/z5u+uRnssC/pTuPqenGtAZwCPLSJsH/S2EREy7cb+tR9NXdigzS30W
 9tPvYMS7AnaVoMongCKQ++1Ns+d77VfTrMdedWgEePUcCXZpBsZkJbcj3rNsdKdOHf3+sb3MuKPEF
 mxXOayQQ==;
Received: from [2001:4bb8:180:8777:7df0:a8d8:40cc:3310] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdU2C-006y0X-9N; Thu, 21 Oct 2021 09:06:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 10/10] dma-direct: add a dma_direct_use_pool helper
Date: Thu, 21 Oct 2021 11:06:11 +0200
Message-Id: <20211021090611.488281-11-hch@lst.de>
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

Add a helper to check if a potentially blocking operation should
dip into the atomic pools.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index f2ec40f5733fc..babf79c16c041 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -151,6 +151,15 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
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
@@ -229,8 +238,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		 * instead have to dip into the atomic pools.
 		 */
 		if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP)) {
-			if (!gfpflags_allow_blocking(gfp) &&
-			    !is_swiotlb_for_alloc(dev))
+			if (dma_direct_use_pool(dev, gfp))
 				return dma_direct_alloc_from_pool(dev, size,
 						dma_handle, gfp);
 			remap = true;
@@ -241,8 +249,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	 * Decrypting memory may block, so allocate the memory from the atomic
 	 * pools if we can't block.
 	 */
-	if (force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp) &&
-	    !is_swiotlb_for_alloc(dev))
+	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
 	/* we always manually zero the memory once we are done */
@@ -359,8 +366,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
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
