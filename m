Return-Path: <SRS0=0fjx=PH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F238FC433F5
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 12:29:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B437E61154
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 12:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B437E61154
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E8B660BC7;
	Tue, 19 Oct 2021 12:29:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P1TOw5luVAf4; Tue, 19 Oct 2021 12:29:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5B0C260B96;
	Tue, 19 Oct 2021 12:29:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A1B6C000F;
	Tue, 19 Oct 2021 12:29:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E410BC000D
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 12:29:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C6F7580ED9
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 12:29:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IxFVlQKSTkou for <iommu@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 12:29:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3FF3880F1C
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 12:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=D7VZX5hX+KRgQG0ex67/uaEF7z2AYmHSaWPEmLGGfbA=; b=VEMehaw8sftyPQaKt6xoqu/XeV
 R7EByxwm5DWl5gbIK+0Zudu2iPowogy4/nSiAqIIRiJgxSxRMrxLe2FA6tZaQ+CDy2PEqF8UmH+XQ
 XTFVqpdD63ERRhrfGUC+yNiuF8UsUS1OXrh8Iqr0vZahqZjGr3QNW899DuvqswwlDtpUYliXhEEPa
 eZxX5CYVrnbOzyPvi0rO4/T3DdNztVtxND4/RjcUBCuEQPGPRJcv3A9PoXNK/9PFYINNiCweRxkMT
 GkdqLbgGufnhlW7FDE6drjGIHULrulZ+3Q8EZ5F/NSAxirYWnxbFFijUMsAbXX0A39vl38okHqsgq
 ScWyAskg==;
Received: from [2001:4bb8:180:8777:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcoFD-001C5K-1V; Tue, 19 Oct 2021 12:29:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 3/4] dma-direct: clean up the remapping checks in
 dma_direct_alloc
Date: Tue, 19 Oct 2021 14:29:15 +0200
Message-Id: <20211019122916.2468032-4-hch@lst.de>
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

Add a local variable to track if we want to remap the returned address
using vmap and use that to simplify the code flow.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 6673f7aebf787..41498243d8444 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -166,6 +166,7 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
 void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
+	bool remap = false;
 	struct page *page;
 	void *ret;
 	int err;
@@ -218,9 +219,23 @@ void *dma_direct_alloc(struct device *dev, size_t size,
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
 
@@ -230,36 +245,23 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 				__builtin_return_address(0));
 		if (!ret)
 			goto out_free_pages;
-		err = dma_set_decrypted(dev, ret, size);
-		memset(ret, 0, size);
-		goto done;
+	} else {
+		ret = page_address(page);
 	}
 
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
-
-	ret = page_address(page);
 	err = dma_set_decrypted(dev, ret, size);
 	if (err)
 		goto out_free_pages;
 	memset(ret, 0, size);
 
-	if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
-	    !dev_is_dma_coherent(dev)) {
+	if (!remap && !dev_is_dma_coherent(dev) &&
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
