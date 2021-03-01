Return-Path: <SRS0=Fdbd=H7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8F8C433DB
	for <iommu@archiver.kernel.org>; Mon,  1 Mar 2021 08:54:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D47E64DF5
	for <iommu@archiver.kernel.org>; Mon,  1 Mar 2021 08:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D47E64DF5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3776E6063F;
	Mon,  1 Mar 2021 08:54:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FdrMwf5oumOE; Mon,  1 Mar 2021 08:54:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01FB3605C9;
	Mon,  1 Mar 2021 08:54:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4864C000A;
	Mon,  1 Mar 2021 08:54:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00940C0001
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 08:54:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D59596063F
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 08:54:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4O1mSSj2Io93 for <iommu@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 08:54:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 293BF605C9
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 08:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=0YMbxEa6N5s2QU9ESiiWLGkb/6oBDFwOMT52+fJkZUE=; b=HSKv8Od4QBtXRXJSanG1u4PO9x
 OYRpBWMPz2nXT70Kq46B1tgAomgENrf0jl5ItJpdVj2v1gu7afijsHAFM181iYUchjH9S1Y7bvKkP
 4KGM94YtK3CUJTlEgDs5mjlt0JYDKHHobp9k9a2oStyvEvQfzl3IyJ5A4JUfzdz1ojtz9Nb4IGG/3
 gt90w2rj/iX8eFw9vbOAlF4dtvUgnkze6PnYZqNetBfivzgSmL+5eNnowzEPHb96Xi8Qz3QvNbwyM
 PhVcoyOASyYxNJTFJJMgj+2bVHOgGOt7G70L1pDEArYYhQaGPrDh/rVJCNGX0h2NUp440NVs/nGT8
 1CZrZN6g==;
Received: from [2001:4bb8:19b:e4b7:cdf9:733f:4874:8eb4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lGeIq-00FVGw-AN; Mon, 01 Mar 2021 08:53:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Tomasz Figa <tfiga@chromium.org>, Ricardo Ribalda <ribalda@chromium.org>,
 Sergey Senozhatsky <senozhatsky@google.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 iommu@lists.linux-foundation.org
Subject: [PATCH 2/6] dma-mapping: refactor dma_{alloc,free}_pages
Date: Mon,  1 Mar 2021 09:52:32 +0100
Message-Id: <20210301085236.947011-3-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210301085236.947011-1-hch@lst.de>
References: <20210301085236.947011-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-media@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
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

Factour out internal versions without the dma_debug calls in preparation
for callers that will need different dma_debug calls.

Note that this changes the dma_debug calls to get the not page aligned
size values, but as long as alloc and free agree on one variant we are
fine.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Tested-by: Ricardo Ribalda <ribalda@chromium.org>
---
 kernel/dma/mapping.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 9ce86c77651c6f..07f964ebcda15e 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -477,11 +477,10 @@ void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 }
 EXPORT_SYMBOL(dma_free_attrs);
 
-struct page *dma_alloc_pages(struct device *dev, size_t size,
+static struct page *__dma_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
-	struct page *page;
 
 	if (WARN_ON_ONCE(!dev->coherent_dma_mask))
 		return NULL;
@@ -490,31 +489,41 @@ struct page *dma_alloc_pages(struct device *dev, size_t size,
 
 	size = PAGE_ALIGN(size);
 	if (dma_alloc_direct(dev, ops))
-		page = dma_direct_alloc_pages(dev, size, dma_handle, dir, gfp);
-	else if (ops->alloc_pages)
-		page = ops->alloc_pages(dev, size, dma_handle, dir, gfp);
-	else
+		return dma_direct_alloc_pages(dev, size, dma_handle, dir, gfp);
+	if (!ops->alloc_pages)
 		return NULL;
+	return ops->alloc_pages(dev, size, dma_handle, dir, gfp);
+}
 
-	debug_dma_map_page(dev, page, 0, size, dir, *dma_handle);
+struct page *dma_alloc_pages(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
+{
+	struct page *page = __dma_alloc_pages(dev, size, dma_handle, dir, gfp);
 
+	if (page)
+		debug_dma_map_page(dev, page, 0, size, dir, *dma_handle);
 	return page;
 }
 EXPORT_SYMBOL_GPL(dma_alloc_pages);
 
-void dma_free_pages(struct device *dev, size_t size, struct page *page,
+static void __dma_free_pages(struct device *dev, size_t size, struct page *page,
 		dma_addr_t dma_handle, enum dma_data_direction dir)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	size = PAGE_ALIGN(size);
-	debug_dma_unmap_page(dev, dma_handle, size, dir);
-
 	if (dma_alloc_direct(dev, ops))
 		dma_direct_free_pages(dev, size, page, dma_handle, dir);
 	else if (ops->free_pages)
 		ops->free_pages(dev, size, page, dma_handle, dir);
 }
+
+void dma_free_pages(struct device *dev, size_t size, struct page *page,
+		dma_addr_t dma_handle, enum dma_data_direction dir)
+{
+	debug_dma_unmap_page(dev, dma_handle, size, dir);
+	__dma_free_pages(dev, size, page, dma_handle, dir);
+}
 EXPORT_SYMBOL_GPL(dma_free_pages);
 
 int dma_mmap_pages(struct device *dev, struct vm_area_struct *vma,
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
