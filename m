Return-Path: <SRS0=0fjx=PH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AF7C433FE
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 12:29:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34C1F61154
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 12:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 34C1F61154
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05C2780EC7;
	Tue, 19 Oct 2021 12:29:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lO9s0xc-fUEL; Tue, 19 Oct 2021 12:29:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CDBCC80ED6;
	Tue, 19 Oct 2021 12:29:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59499C0025;
	Tue, 19 Oct 2021 12:29:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 246B8C000D
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 12:29:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2232780E41
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 12:29:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JPwcu_Il8slU for <iommu@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 12:29:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8901480E3F
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 12:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=UYQ8o+z284fDR2Q8H0p/uwhf+cVrFz6FMNbYsvTrlwU=; b=1oQ+8cko2HwgNTZRYj8mSFXYZK
 1zweD4lGA/HiFp8VWPfc9ETXXuNShlaFFm42eTUOPwySnZMDEYYm456ZnDJBI5569+JTel/bI77ud
 4qmwLmeJQ3Z/kU/C7uQm2v9GyRH2bJKQzXHMXCGkL370r9zhIAua21skbFCjOITi5qoHk2vbHhhGN
 YpFtImk54Wq1lQqa+ZsqvrZO26XgU57vyH6N6w5eFTzdm+/xcIV9VcCLFGvcEU8JcvlG+AN2IHypd
 yl3+ZtqgrGIWIPr+ME7hhTJSOwJzcMhkJtmjiykVtLdmMyQILxRWPzUV2qML2WDcuCjVmVUfA2h/F
 JN2xcZLA==;
Received: from [2001:4bb8:180:8777:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcoF7-001C30-LU; Tue, 19 Oct 2021 12:29:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 1/4] dma-direct: factor out dma_set_{de,en}crypted helpers
Date: Tue, 19 Oct 2021 14:29:13 +0200
Message-Id: <20211019122916.2468032-2-hch@lst.de>
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

Factor out helpers the make dealing with memory encryption a little less
cumbersome.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 55 +++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 4c6c5e0635e34..96f02248e7fa2 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -75,6 +75,20 @@ static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 		min_not_zero(dev->coherent_dma_mask, dev->bus_dma_limit);
 }
 
+static int dma_set_decrypted(struct device *dev, void *vaddr, size_t size)
+{
+	if (!force_dma_unencrypted(dev))
+		return 0;
+	return set_memory_decrypted((unsigned long)vaddr, 1 << get_order(size));
+}
+
+static int dma_set_encrypted(struct device *dev, void *vaddr, size_t size)
+{
+	if (!force_dma_unencrypted(dev))
+		return 0;
+	return set_memory_encrypted((unsigned long)vaddr, 1 << get_order(size));
+}
+
 static void __dma_direct_free_pages(struct device *dev, struct page *page,
 				    size_t size)
 {
@@ -216,12 +230,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 				__builtin_return_address(0));
 		if (!ret)
 			goto out_free_pages;
-		if (force_dma_unencrypted(dev)) {
-			err = set_memory_decrypted((unsigned long)ret,
-						   1 << get_order(size));
-			if (err)
-				goto out_free_pages;
-		}
+		err = dma_set_decrypted(dev, ret, size);
 		memset(ret, 0, size);
 		goto done;
 	}
@@ -238,13 +247,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	}
 
 	ret = page_address(page);
-	if (force_dma_unencrypted(dev)) {
-		err = set_memory_decrypted((unsigned long)ret,
-					   1 << get_order(size));
-		if (err)
-			goto out_free_pages;
-	}
-
+	err = dma_set_decrypted(dev, ret, size);
+	if (err)
+		goto out_free_pages;
 	memset(ret, 0, size);
 
 	if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
@@ -259,13 +264,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	return ret;
 
 out_encrypt_pages:
-	if (force_dma_unencrypted(dev)) {
-		err = set_memory_encrypted((unsigned long)page_address(page),
-					   1 << get_order(size));
-		/* If memory cannot be re-encrypted, it must be leaked */
-		if (err)
-			return NULL;
-	}
+	/* If memory cannot be re-encrypted, it must be leaked */
+	if (dma_set_encrypted(dev, page_address(page), size))
+		return NULL;
 out_free_pages:
 	__dma_direct_free_pages(dev, page, size);
 	return NULL;
@@ -304,8 +305,7 @@ void dma_direct_free(struct device *dev, size_t size,
 	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
 		return;
 
-	if (force_dma_unencrypted(dev))
-		set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
+	dma_set_encrypted(dev, cpu_addr, 1 << page_order);
 
 	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr))
 		vunmap(cpu_addr);
@@ -341,11 +341,8 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	}
 
 	ret = page_address(page);
-	if (force_dma_unencrypted(dev)) {
-		if (set_memory_decrypted((unsigned long)ret,
-				1 << get_order(size)))
-			goto out_free_pages;
-	}
+	if (dma_set_decrypted(dev, ret, size))
+		goto out_free_pages;
 	memset(ret, 0, size);
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
 	return page;
@@ -366,9 +363,7 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 	    dma_free_from_pool(dev, vaddr, size))
 		return;
 
-	if (force_dma_unencrypted(dev))
-		set_memory_encrypted((unsigned long)vaddr, 1 << page_order);
-
+	dma_set_encrypted(dev, vaddr, 1 << page_order);
 	__dma_direct_free_pages(dev, page, size);
 }
 
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
