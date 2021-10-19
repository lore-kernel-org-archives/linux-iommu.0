Return-Path: <SRS0=0fjx=PH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B063BC433EF
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 12:29:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4017B61057
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 12:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4017B61057
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E736280ED9;
	Tue, 19 Oct 2021 12:29:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9639fHpWdnD7; Tue, 19 Oct 2021 12:29:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D4CAA80EF3;
	Tue, 19 Oct 2021 12:29:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AB4FC000F;
	Tue, 19 Oct 2021 12:29:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 435B8C000F
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 12:29:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3094C40480
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 12:29:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u39oMUiNO1e0 for <iommu@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 12:29:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B067E40457
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 12:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=fg9QmJUZnMTYSr9QDeUa/sO0jRx6G4dt8Fp/gL1XBEQ=; b=jLf1HNSKC9Dtf1+UsyYRr4jGyA
 kpIT4vBXe5A4nkO0PAgaGhpiz2CXrIpsiybN1ZYky22FBl05xRgxlKT8pvI2QGQeYBnEOZg2xa80a
 mzN82EMlD1RBYx12/tYCKVXVb7C8ZNusFIqftHYNS7AhNe6aObGmr7kWjcGQ0GA49jZr3+Kgch8yd
 daRJvxsSCQLqvb5CMY01oeU8aoLsZV4Y/cIbb/py5WwKALRodu9mEeYQmlhJuRsprt3Yenn0373Ci
 GEUYAT+7f2ZXexrW7RI9HFygRnYCP6/Z64PgC/wpveyc8cQu4az5GhiKY+zmlAdFBYCtM5YK5XTL3
 yn2rgf6A==;
Received: from [2001:4bb8:180:8777:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcoFA-001C40-CT; Tue, 19 Oct 2021 12:29:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 2/4] dma-direct: leak memory that can't be re-encrypted
Date: Tue, 19 Oct 2021 14:29:14 +0200
Message-Id: <20211019122916.2468032-3-hch@lst.de>
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

We must never unencryped memory go back into the general page pool.
So if we fail to set it back to encrypted when freeing DMA memory, leak
the memory insted and warn the user.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 96f02248e7fa2..6673f7aebf787 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -264,9 +264,11 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	return ret;
 
 out_encrypt_pages:
-	/* If memory cannot be re-encrypted, it must be leaked */
-	if (dma_set_encrypted(dev, page_address(page), size))
+	if (dma_set_encrypted(dev, page_address(page), size)) {
+		pr_warn_ratelimited(
+			"leaking DMA memory that can't be re-encrypted\n");
 		return NULL;
+	}
 out_free_pages:
 	__dma_direct_free_pages(dev, page, size);
 	return NULL;
@@ -305,7 +307,11 @@ void dma_direct_free(struct device *dev, size_t size,
 	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
 		return;
 
-	dma_set_encrypted(dev, cpu_addr, 1 << page_order);
+	if (dma_set_encrypted(dev, cpu_addr, 1 << page_order)) {
+		pr_warn_ratelimited(
+			"leaking DMA memory that can't be re-encrypted\n");
+		return;
+	}
 
 	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr))
 		vunmap(cpu_addr);
@@ -363,7 +369,10 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 	    dma_free_from_pool(dev, vaddr, size))
 		return;
 
-	dma_set_encrypted(dev, vaddr, 1 << page_order);
+	if (dma_set_encrypted(dev, vaddr, 1 << page_order)) {
+		pr_warn_ratelimited(
+			"leaking DMA memory that can't be re-encrypted\n");
+	}
 	__dma_direct_free_pages(dev, page, size);
 }
 
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
