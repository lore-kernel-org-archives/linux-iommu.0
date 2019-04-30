Return-Path: <SRS0=Kg+4=TA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214C3C43219
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 10:55:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E76F921670
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 10:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UehJ7hT2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76F921670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3CA1EFD7;
	Tue, 30 Apr 2019 10:53:56 +0000 (UTC)
Received: from smtp2.linuxfoundation.org (smtp2.linux-foundation.org
	[172.17.192.36])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6C4F4F22
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 10:53:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp2.linuxfoundation.org (Postfix) with ESMTPS id 01F001DD62
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 10:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LRZ+a5sipG+x9hTb5HNeKDZbPa61HUwsC1kq+2SqZSg=;
	b=UehJ7hT2H3rFW7DaQXSRnopRQ3
	l06J4nPbqtIHk+RTJPw0TSD3JeU0MKBl94LzoZJcZ9RXFgzPG9OUFAd8jNKhRB3kGaeQInppBE8fR
	/PFYTUHY5yS3MLuWGy4zCdDxvxx1qidXFX6lWJgum+9vxs/Pg2dg7J3ouPJe5rL/rhuQg0oA5qlLA
	bzV4Yc0MtwxSJ8aYXoZbhTrrLzVxl/wRoFj04NRhw6W3QgoNxiHescvvNczGoYiMlS4wOVs3s+VlE
	GyFitgWRbrLqm/kGCua9O0G2QPYW2h+0/waowmWswYkYljAwjozEcSffr+Mme3MyTzYzqwHJmqWAt
	w3qoRXwA==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hLQNs-0007oL-Hg; Tue, 30 Apr 2019 10:53:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 14/25] iommu/dma: Refactor iommu_dma_alloc
Date: Tue, 30 Apr 2019 06:52:03 -0400
Message-Id: <20190430105214.24628-15-hch@lst.de>
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
Message-ID: <20190430105203.aTHFrim6vFXRtyryZbxJB-xXbpHXmT6n21ht-YVUGMc@z>

From: Robin Murphy <robin.murphy@arm.com>

Shuffle around the self-contained atomic and non-contiguous cases to
return early and get out of the way of the CMA case that we're about to
work on next.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
[hch: slight changes to the code flow]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 60 +++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f5c0e8cd3387..26f2d059873b 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -954,14 +954,19 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 {
 	bool coherent = dev_is_dma_coherent(dev);
 	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
+	pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
 	size_t iosize = size;
+	struct page *page;
 	void *addr;
 
 	size = PAGE_ALIGN(size);
 	gfp |= __GFP_ZERO;
 
+	if (gfpflags_allow_blocking(gfp) &&
+	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
+		return iommu_dma_alloc_remap(dev, iosize, handle, gfp, attrs);
+
 	if (!gfpflags_allow_blocking(gfp)) {
-		struct page *page;
 		/*
 		 * In atomic context we can't remap anything, so we'll only
 		 * get the virtually contiguous buffer we need by way of a
@@ -983,39 +988,34 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 				__free_pages(page, get_order(size));
 			else
 				dma_free_from_pool(addr, size);
-			addr = NULL;
-		}
-	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
-		struct page *page;
-
-		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
-					get_order(size), gfp & __GFP_NOWARN);
-		if (!page)
 			return NULL;
-
-		*handle = __iommu_dma_map(dev, page_to_phys(page), iosize, ioprot);
-		if (*handle == DMA_MAPPING_ERROR) {
-			dma_release_from_contiguous(dev, page,
-						    size >> PAGE_SHIFT);
-			return NULL;
-		}
-		addr = dma_common_contiguous_remap(page, size, VM_USERMAP,
-						   prot,
-						   __builtin_return_address(0));
-		if (addr) {
-			if (!coherent)
-				arch_dma_prep_coherent(page, iosize);
-			memset(addr, 0, size);
-		} else {
-			__iommu_dma_unmap(dev, *handle, iosize);
-			dma_release_from_contiguous(dev, page,
-						    size >> PAGE_SHIFT);
 		}
-	} else {
-		addr = iommu_dma_alloc_remap(dev, iosize, handle, gfp, attrs);
+		return addr;
 	}
+
+	page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
+					 get_order(size), gfp & __GFP_NOWARN);
+	if (!page)
+		return NULL;
+
+	*handle = __iommu_dma_map(dev, page_to_phys(page), iosize, ioprot);
+	if (*handle == DMA_MAPPING_ERROR)
+		goto out_free_pages;
+
+	addr = dma_common_contiguous_remap(page, size, VM_USERMAP, prot,
+			__builtin_return_address(0));
+	if (!addr)
+		goto out_unmap;
+
+	if (!coherent)
+		arch_dma_prep_coherent(page, iosize);
+	memset(addr, 0, size);
 	return addr;
+out_unmap:
+	__iommu_dma_unmap(dev, *handle, iosize);
+out_free_pages:
+	dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
+	return NULL;
 }
 
 static int __iommu_dma_mmap_pfn(struct vm_area_struct *vma,
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
