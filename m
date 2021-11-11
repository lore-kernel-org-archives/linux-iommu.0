Return-Path: <SRS0=Rhk0=P6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9B7C4332F
	for <iommu@archiver.kernel.org>; Thu, 11 Nov 2021 06:50:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21B5661269
	for <iommu@archiver.kernel.org>; Thu, 11 Nov 2021 06:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 21B5661269
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34A7560B14;
	Thu, 11 Nov 2021 06:50:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p3_Nn425Ln2U; Thu, 11 Nov 2021 06:50:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0B9F360B0F;
	Thu, 11 Nov 2021 06:50:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB9DFC0036;
	Thu, 11 Nov 2021 06:50:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A21DC003C
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 06:50:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 246D881A33
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 06:50:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aBx180_kJEVG for <iommu@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 06:50:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6713C81A0D
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 06:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=haBuFuwrjV4edODOQFGCEcPRaZ3DiSObrSPQ8bp7Yes=; b=feQpuTzoizrRn/Vtt5ctIbvZsf
 m3qZRBFkAzYhHk3MLm2bI4rTvFGyAUzT9hcBW1bd+pBTmzpwdoXBmfqktLBp6IHvA9CiQYqXB8k52
 VV3gta+ZOrXPdu9UEgM4PnTLYE+zJaVBNU+OE5uBhKHLL2kyYsYT66iZwsanesgSA5x+tnj4lINFw
 YgXBo1UVhsp0PlmRYbtfdaxB5yHUlYNU2iT9Qdh8omozIF55EM6xlZmynoKAQW5pFxuRnRhwzbIc9
 R5IkwkHTwRINY7+fLSzi8HxbJ+Z9VrGwvDDzkDkVLKmBLrhjp/t6Lu8BHSrSjnFUKXAJl7CJ0aHrs
 f+YMiJKQ==;
Received: from [2001:4bb8:19a:7ee7:dc25:8b64:278b:ff22] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ml3ur-002VxP-C6; Thu, 11 Nov 2021 06:50:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 04/11] dma-direct: clean up the remapping checks in
 dma_direct_alloc
Date: Thu, 11 Nov 2021 07:50:20 +0100
Message-Id: <20211111065028.32761-5-hch@lst.de>
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

Add two local variables to track if we want to remap the returned
address using vmap or call dma_set_uncached and use that to simplify
the code flow.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 48 ++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index d7a489be48470..3d1718dc077e9 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -171,6 +171,7 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
 void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
+	bool remap = false, set_uncached = false;
 	struct page *page;
 	void *ret;
 
@@ -222,9 +223,25 @@ void *dma_direct_alloc(struct device *dev, size_t size,
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
+	} else if (!dev_is_dma_coherent(dev) &&
+		   IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED))
+		set_uncached = true;
+
+	if (remap) {
 		/* remove any dirty cache lines on the kernel alias */
 		arch_dma_prep_coherent(page, size);
 
@@ -234,34 +251,21 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 				__builtin_return_address(0));
 		if (!ret)
 			goto out_free_pages;
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
+		if (dma_set_decrypted(dev, ret, size))
+			goto out_free_pages;
 	}
 
-	ret = page_address(page);
-	if (dma_set_decrypted(dev, ret, size))
-		goto out_free_pages;
 	memset(ret, 0, size);
 
-	if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
-	    !dev_is_dma_coherent(dev)) {
+	if (set_uncached) {
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
