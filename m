Return-Path: <SRS0=Rhk0=P6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DF7C433FE
	for <iommu@archiver.kernel.org>; Thu, 11 Nov 2021 06:50:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7C6761037
	for <iommu@archiver.kernel.org>; Thu, 11 Nov 2021 06:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B7C6761037
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84912404DF;
	Thu, 11 Nov 2021 06:50:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MMgeSAPKzwrq; Thu, 11 Nov 2021 06:50:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6804E404EA;
	Thu, 11 Nov 2021 06:50:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4628BC0020;
	Thu, 11 Nov 2021 06:50:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97907C0020
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 06:50:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D32A7400C9
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 06:50:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1pWWDWfxHB5Q for <iommu@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 06:50:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 049F9400FB
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 06:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=1WOvyqEQIYPJu8OHmBDb4GQnNqqjABzGe1DFQzws+Ig=; b=X0tmSUWgTYLpDf3Ad7Y/XgybNP
 XhjDToP2PDAK4xYQYNSBdYoZ4LeaU351MCcWWfWklhO9n6WhJ9MmUC7KTBbu2hWOlGKOAhXObG7tb
 kwA/Y6WOY7va6qdeHmqBucCDXYgU79nXcDIXnsTnkJcYUjOoxeQiBsn8g94U25chJOjON1XyWMHES
 EsAWvAyBbD7ouV5HQalYbEIQC3F9re8UNVIUKMV8Zm90yBIe6r6jHfFFh2uxjd++ThnRHfE5Rr1Cl
 Njtc40MXJ9F5Yi/v84NyS25k4/9iqYVSL1hiHUe5pfcN9X+C1REl28jImp5UIA1YLN4p4OPgdnRHW
 2TRAkHAA==;
Received: from [2001:4bb8:19a:7ee7:dc25:8b64:278b:ff22] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ml3uq-002Vx8-4N; Thu, 11 Nov 2021 06:50:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 03/11] dma-direct: always leak memory that can't be
 re-encrypted
Date: Thu, 11 Nov 2021 07:50:19 +0100
Message-Id: <20211111065028.32761-4-hch@lst.de>
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

We must never unencryped memory go back into the general page pool.
So if we fail to set it back to encrypted when freeing DMA memory, leak
the memory insted and warn the user.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 996ba4edb2fa3..d7a489be48470 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -84,9 +84,14 @@ static int dma_set_decrypted(struct device *dev, void *vaddr, size_t size)
 
 static int dma_set_encrypted(struct device *dev, void *vaddr, size_t size)
 {
+	int ret;
+
 	if (!force_dma_unencrypted(dev))
 		return 0;
-	return set_memory_encrypted((unsigned long)vaddr, 1 << get_order(size));
+	ret = set_memory_encrypted((unsigned long)vaddr, 1 << get_order(size));
+	if (ret)
+		pr_warn_ratelimited("leaking DMA memory that can't be re-encrypted\n");
+	return ret;
 }
 
 static void __dma_direct_free_pages(struct device *dev, struct page *page,
@@ -261,7 +266,6 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	return ret;
 
 out_encrypt_pages:
-	/* If memory cannot be re-encrypted, it must be leaked */
 	if (dma_set_encrypted(dev, page_address(page), size))
 		return NULL;
 out_free_pages:
@@ -307,7 +311,8 @@ void dma_direct_free(struct device *dev, size_t size,
 	} else {
 		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
 			arch_dma_clear_uncached(cpu_addr, size);
-		dma_set_encrypted(dev, cpu_addr, 1 << page_order);
+		if (dma_set_encrypted(dev, cpu_addr, 1 << page_order))
+			return;
 	}
 
 	__dma_direct_free_pages(dev, dma_direct_to_page(dev, dma_addr), size);
@@ -361,7 +366,8 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 	    dma_free_from_pool(dev, vaddr, size))
 		return;
 
-	dma_set_encrypted(dev, vaddr, 1 << page_order);
+	if (dma_set_encrypted(dev, vaddr, 1 << page_order))
+		return;
 	__dma_direct_free_pages(dev, page, size);
 }
 
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
