Return-Path: <SRS0=kOFq=SY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B322BC282CE
	for <iommu@archiver.kernel.org>; Mon, 22 Apr 2019 18:02:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8699621738
	for <iommu@archiver.kernel.org>; Mon, 22 Apr 2019 18:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JU/HhN5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8699621738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 44ABDD97;
	Mon, 22 Apr 2019 18:01:02 +0000 (UTC)
Received: from smtp2.linuxfoundation.org (smtp2.linux-foundation.org
	[172.17.192.36])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9D7DFD3D
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Apr 2019 18:01:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp2.linuxfoundation.org (Postfix) with ESMTPS id 3E3401DCEE
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Apr 2019 18:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OQgnQL8ZNGoEIawcra+UXoSaQUp201X+Fppo94xEHDA=;
	b=JU/HhN5IAdYsQY+k0heBYpXQBM
	GqAj0Z49IjUpzq7B6jvT6EyW05VPjZaQkouu1YxYoa/7qPqVlytqbncs4kaHQCv8DkVzESuaJZTVx
	+382a6/o7pGAeq/0BBnzBKFas7gb7JmSCNPyDZXfYNlddbpkyb1xPpI2bO0xPJORuYxhZhFNbdRfw
	TWhwgD9zRIyTX01Atw/PrphwWtT8p17g8D6hNosnc0oLycEHa33eTYjkFI+4RUect6k0MWW5fFElp
	qc6q0pwsQ5ioe81+iRe4dYFeKBFEjbzjH4Li/kSoX5Lqmjji/9EgjWyjcD1CuOsNRvKggVmppkoY7
	jmWhTChg==;
Received: from 213-225-37-80.nat.highway.a1.net ([213.225.37.80]
	helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hIdFM-0002I2-Nb; Mon, 22 Apr 2019 18:00:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 17/26] iommu/dma: Merge the CMA and alloc_pages allocation
	paths
Date: Mon, 22 Apr 2019 19:59:33 +0200
Message-Id: <20190422175942.18788-18-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190422175942.18788-1-hch@lst.de>
References: <20190422175942.18788-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190422175933.FKLVFIVoUP5EcDikhAGbZZITKYMb2Y5b0R26TNjv7rM@z>

Instead of having a separate code path for the non-blocking alloc_pages
and CMA allocations paths merge them into one.  There is a slight
behavior change here in that we try the page allocator if CMA fails.
This matches what dma-direct and other iommu drivers do and will be
needed to use the dma-iommu code on architectures without DMA remapping
later on.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 6f4febf5e1de..a1b8c232ad42 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -957,7 +957,7 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	bool coherent = dev_is_dma_coherent(dev);
 	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
 	size_t iosize = size;
-	struct page *page;
+	struct page *page = NULL;
 	void *addr;
 
 	size = PAGE_ALIGN(size);
@@ -967,35 +967,26 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
 		return iommu_dma_alloc_remap(dev, iosize, handle, gfp, attrs);
 
-	if (!gfpflags_allow_blocking(gfp)) {
-		/*
-		 * In atomic context we can't remap anything, so we'll only
-		 * get the virtually contiguous buffer we need by way of a
-		 * physically contiguous allocation.
-		 */
-		if (coherent) {
-			page = alloc_pages(gfp, get_order(size));
-			addr = page ? page_address(page) : NULL;
-		} else {
-			addr = dma_alloc_from_pool(size, &page, gfp);
-		}
+	if (!gfpflags_allow_blocking(gfp) && !coherent) {
+		addr = dma_alloc_from_pool(size, &page, gfp);
 		if (!addr)
 			return NULL;
 
 		*handle = __iommu_dma_map(dev, page_to_phys(page), iosize,
 					  ioprot);
 		if (*handle == DMA_MAPPING_ERROR) {
-			if (coherent)
-				__free_pages(page, get_order(size));
-			else
-				dma_free_from_pool(addr, size);
+			dma_free_from_pool(addr, size);
 			return NULL;
 		}
 		return addr;
 	}
 
-	page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
-					 get_order(size), gfp & __GFP_NOWARN);
+	if (gfpflags_allow_blocking(gfp))
+		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
+						 get_order(size),
+						 gfp & __GFP_NOWARN);
+	if (!page)
+		page = alloc_pages(gfp, get_order(size));
 	if (!page)
 		return NULL;
 
@@ -1021,7 +1012,8 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 out_unmap:
 	__iommu_dma_unmap(dev, *handle, iosize);
 out_free_pages:
-	dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
+	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
+		__free_pages(page, get_order(size));
 	return NULL;
 }
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
