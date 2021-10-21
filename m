Return-Path: <SRS0=0R9D=PJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22ABC433EF
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 09:06:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6461360F56
	for <iommu@archiver.kernel.org>; Thu, 21 Oct 2021 09:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6461360F56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46B5460EAF;
	Thu, 21 Oct 2021 09:06:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bayHb2RXrAtH; Thu, 21 Oct 2021 09:06:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 222A460D7B;
	Thu, 21 Oct 2021 09:06:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08EA6C001C;
	Thu, 21 Oct 2021 09:06:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFCD7C0011
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 09:06:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ADA0E407DD
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 09:06:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TCK6JgBpKtsh for <iommu@lists.linux-foundation.org>;
 Thu, 21 Oct 2021 09:06:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1295B407D5
 for <iommu@lists.linux-foundation.org>; Thu, 21 Oct 2021 09:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=p+SiBLU3MAB7unZmpPpV/X5bNnRwkg4r4xzmLo/iMA0=; b=nvw2fvLOehlKLeL0TqHTSuF2iv
 zNYs0PviIo/Rx/DIM9m2LgQfpvLxiR4Q2K5P4sNm1QrjfDIJCP+RceQSl+NGjht7Zp02A8skwMFkB
 WzgSwTWcuEohhER8W8D08qT8oP3RAaLJhklw7hlDRdMPyQw3N1EHuO7FH3x7mMdnQjxIMq8tX9y5D
 BTsYPK7HDLROpPGVXTgMrMjpllq5jB4AiCaOrU+zAYdM8JCZ1WxhluB2PNIFJk3BSOF1NXXcRXSdB
 hfuoa+YB7Buk6W7F8ZNvw55+xwCSEsoL19Exx/LCqI/Sfelah17b3ORjIJuxxpOUO0K7Miqp/XmN+
 inH8dDnQ==;
Received: from [2001:4bb8:180:8777:7df0:a8d8:40cc:3310] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdU1r-006xvU-RR; Thu, 21 Oct 2021 09:06:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 04/10] dma-direct: clean up the remapping checks in
 dma_direct_alloc
Date: Thu, 21 Oct 2021 11:06:05 +0200
Message-Id: <20211021090611.488281-5-hch@lst.de>
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

Add a local variable to track if we want to remap the returned address
using vmap and use that to simplify the code flow.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 47 +++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 60cb75aa6778e..a6b6fe72af4d1 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -166,6 +166,7 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
 void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
+	bool remap = false;
 	struct page *page;
 	void *ret;
 
@@ -217,9 +218,23 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	if (!page)
 		return NULL;
 
-	if ((IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	     !dev_is_dma_coherent(dev)) ||
-	    (IS_ENABLED(CONFIG_DMA_REMAP) && PageHighMem(page))) {
+	if (!dev_is_dma_coherent(dev) && IS_ENABLED(CONFIG_DMA_DIRECT_REMAP)) {
+		remap = true;
+	} else if (PageHighMem(page)) {
+		/*
+		 * Depending on the cma= arguments and per-arch setup,
+		 * dma_alloc_contiguous could return highmem pages.
+		 * Without remapping there is no way to return them here, so
+		 * log an error and fail.
+		 */
+		if (!IS_ENABLED(CONFIG_DMA_REMAP)) {
+			dev_info(dev, "Rejecting highmem page from CMA.\n");
+			goto out_free_pages;
+		}
+		remap = true;
+	}
+
+	if (remap) {
 		/* remove any dirty cache lines on the kernel alias */
 		arch_dma_prep_coherent(page, size);
 
@@ -229,36 +244,22 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 				__builtin_return_address(0));
 		if (!ret)
 			goto out_free_pages;
-		if (dma_set_decrypted(dev, ret, size))
-			goto out_unmap_pages;
-		memset(ret, 0, size);
-		goto done;
-	}
-
-	if (PageHighMem(page)) {
-		/*
-		 * Depending on the cma= arguments and per-arch setup
-		 * dma_alloc_contiguous could return highmem pages.
-		 * Without remapping there is no way to return them here,
-		 * so log an error and fail.
-		 */
-		dev_info(dev, "Rejecting highmem page from CMA.\n");
-		goto out_free_pages;
+	} else {
+		ret = page_address(page);
 	}
 
-	ret = page_address(page);
 	if (dma_set_decrypted(dev, ret, size))
-		goto out_free_pages;
+		goto out_unmap_pages;
 	memset(ret, 0, size);
 
-	if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
-	    !dev_is_dma_coherent(dev)) {
+	if (!dev_is_dma_coherent(dev) && !remap &&
+	    IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED)) {
 		arch_dma_prep_coherent(page, size);
 		ret = arch_dma_set_uncached(ret, size);
 		if (IS_ERR(ret))
 			goto out_encrypt_pages;
 	}
-done:
+
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
 	return ret;
 
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
