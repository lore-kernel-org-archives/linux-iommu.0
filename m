Return-Path: <SRS0=Kg+4=TA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13185C43219
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 10:55:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6BC821670
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 10:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hnqbneXs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BC821670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C2EFBFE0;
	Tue, 30 Apr 2019 10:53:56 +0000 (UTC)
Received: from smtp2.linuxfoundation.org (smtp2.linux-foundation.org
	[172.17.192.36])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D6382F22
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 10:53:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp2.linuxfoundation.org (Postfix) with ESMTPS id 756631DD62
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 10:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vKM3qJXB2gT/q0HRmYJWahACepm3CuJGdRaER2v/8Rs=;
	b=hnqbneXsr42lW+1oElB+n/O490
	l+7WOvGSi8BRHoYTRkm+Bij0E3d/7LfTCLRjq1XpX9u26sYRQs71lInnjGnsdLBaTDOUR9eRj7K0a
	Fhpjqz4txYD0aGb/dBxAkAOS6TnnveYRupNAZa6gnVcvnRNdieIyST3F1JkFWJauOA25e42yBKPlS
	bmOkfS8aHpOwcFkmC1K0W1kRY1bYNMBU0yUPHGV7ehh6rAgmst8Exb4TIMfA4Ew6vIWMkaZmDgzO7
	WJikybXVIgMGHCrBWnTvvSsLuMicSurVFoNNtich5j8OZNfHxrsab4iAE/ZGEBZI2QPJn+yQtuWpI
	Uiwead1w==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hLQNv-0007sn-KK; Tue, 30 Apr 2019 10:53:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 16/25] iommu/dma: Merge the CMA and alloc_pages allocation
	paths
Date: Tue, 30 Apr 2019 06:52:05 -0400
Message-Id: <20190430105214.24628-17-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430105214.24628-1-hch@lst.de>
References: <20190430105214.24628-1-hch@lst.de>
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
Message-ID: <20190430105205.vXReSV92O86EdOMbgHeqCYxzHdo8rePG-KbRVCyzOPc@z>

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
index ccdd655bc03a..99dd82d8ae21 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -955,7 +955,7 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	bool coherent = dev_is_dma_coherent(dev);
 	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
 	size_t iosize = size;
-	struct page *page;
+	struct page *page = NULL;
 	void *addr;
 
 	size = PAGE_ALIGN(size);
@@ -965,35 +965,26 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
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
 
@@ -1019,7 +1010,8 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
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
