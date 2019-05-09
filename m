Return-Path: <SRS0=kikZ=TJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92BDC04AB3
	for <iommu@archiver.kernel.org>; Thu,  9 May 2019 07:20:50 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97AEA217D9
	for <iommu@archiver.kernel.org>; Thu,  9 May 2019 07:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FnXQrJHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97AEA217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5B5BDB4B;
	Thu,  9 May 2019 07:20:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7FA63AF7
	for <iommu@lists.linux-foundation.org>;
	Thu,  9 May 2019 07:20:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id ED90A1FB
	for <iommu@lists.linux-foundation.org>;
	Thu,  9 May 2019 07:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dHPcM7BToWSY7XBTx45AtDbkmyX1K9o4jR86GMXyrWY=;
	b=FnXQrJHUhhe9vAR/2fLP8tRF7
	Di7W3Iao30bbViXAWg8zQHkmSzSqDScbjfSyWwxECcCw/QIyiZ2VwyWxI6oote2HhxVGV6JvvYGHU
	DGHbILgpPHBNfr2K93OqJaInQAN63uEd4XSP1zlTyFkiwB4uqrFM/7rScwHdU3Eva4syMG5fYyrqH
	YwWI505e5A2W8UK8K/bl1DjHrWEBB/iyj4cNQosK59L20lc/p7jMnJud1Rebq7sDjeCcBrAjRhn8C
	6XGYuw28SADvfL7wQGN6ZiJktLnkjTXVCP09fYqwPkmFTS0hkcyLJ/57wajLhB3n/YBcWBpyBxkdP
	VCLWV4aXg==;
Received: from 089144210233.atnat0019.highway.a1.net ([89.144.210.233]
	helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hOdME-00067H-Jh; Thu, 09 May 2019 07:20:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Russell King <linux@armlinux.org.uk>
Subject: [PATCH] ARM: dma-mapping: don't use the atomic pool for
	DMA_ATTR_NO_KERNEL_MAPPING
Date: Thu,  9 May 2019 09:20:06 +0200
Message-Id: <20190509072006.727-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

DMA allocations with the DMA_ATTR_NO_KERNEL_MAPPING do not return a kernel
virtual address for use in driver, but are expected to be used entirely
for userspace mappings and/or device private memory.

Because of that we don't need to remap them as uncached, and thus don't need
the atomic pool for non-blocking allocations.  Note that using the
DMA allocator with DMA_ATTR_NO_KERNEL_MAPPING from non-blocking context
on a non-coherent device is actually broken without this patch as well, as
we feed the address passes to dma_free_attrs directly to the genpool
allocator, but for DMA_ATTR_NO_KERNEL_MAPPING allocations it actually
contains the address of the first page pointer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mm/dma-mapping.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index d029fa31624b..f74d824f8fc1 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -706,6 +706,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 			 gfp_t gfp, pgprot_t prot, bool is_coherent,
 			 unsigned long attrs, const void *caller)
 {
+	bool want_vaddr = !(attrs & DMA_ATTR_NO_KERNEL_MAPPING);
 	u64 mask = get_coherent_dma_mask(dev);
 	struct page *page = NULL;
 	void *addr;
@@ -717,7 +718,7 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 		.gfp = gfp,
 		.prot = prot,
 		.caller = caller,
-		.want_vaddr = ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) == 0),
+		.want_vaddr = want_vaddr,
 		.coherent_flag = is_coherent ? COHERENT : NORMAL,
 	};
 
@@ -755,14 +756,14 @@ static void *__dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	allowblock = gfpflags_allow_blocking(gfp);
 	cma = allowblock ? dev_get_cma_area(dev) : false;
 
-	if (cma)
+	if (!allowblock && !is_coherent && want_vaddr)
+		buf->allocator = &pool_allocator;
+	else if (cma)
 		buf->allocator = &cma_allocator;
 	else if (is_coherent)
 		buf->allocator = &simple_allocator;
-	else if (allowblock)
-		buf->allocator = &remap_allocator;
 	else
-		buf->allocator = &pool_allocator;
+		buf->allocator = &remap_allocator;
 
 	addr = buf->allocator->alloc(&args, &page);
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
