Return-Path: <SRS0=aUVl=TX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A98C04AAC
	for <iommu@archiver.kernel.org>; Thu, 23 May 2019 07:02:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13B062133D
	for <iommu@archiver.kernel.org>; Thu, 23 May 2019 07:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q1owRvkP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B062133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7A13FD09;
	Thu, 23 May 2019 07:01:24 +0000 (UTC)
Received: from smtp2.linuxfoundation.org (smtp2.linux-foundation.org
	[172.17.192.36])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9618AB9E
	for <iommu@lists.linux-foundation.org>;
	Thu, 23 May 2019 07:01:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp2.linuxfoundation.org (Postfix) with ESMTPS id F04C81DE21
	for <iommu@lists.linux-foundation.org>;
	Thu, 23 May 2019 07:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FGE58kH/XUscylCU9/wTgoeNjs0yJHOoDCKQntGa5t0=;
	b=q1owRvkP/Da7+8pkOMPUo143Z5
	la6UEsIrq752HYtEJr9vFDNFAMceZ5zCb2WznJn2ryXHDEFkYnEpJxBNYL7dnVaqtHVYtK8WpvRCJ
	/pidOOQhOMrcXry64Fi3CmeAIXjK8m3wUEjA8px9df672h9g7PL8tiPQu2sx4g8PzUqII7bO+HGXF
	yiokm6TvFCBg5r0m50zZNhrKOmVhvz9MaSO+Y6whnsI7DgkSheJqudc4ckethPhh/rzURMlPlvfzO
	OhCQ4zF0bHeg+alWuXbAp/I50EwCMwtCN9ZI4ci7TCle7lExowFPOrITZ1qDGea6Do7R5KndbT0b7
	7dvhxxOw==;
Received: from 213-225-10-46.nat.highway.a1.net ([213.225.10.46]
	helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hThj5-0005nU-GH; Thu, 23 May 2019 07:01:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 17/23] iommu/dma: Refactor iommu_dma_alloc, part 2
Date: Thu, 23 May 2019 09:00:22 +0200
Message-Id: <20190523070028.7435-18-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523070028.7435-1-hch@lst.de>
References: <20190523070028.7435-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Tom Murphy <tmurphy@arista.com>, Catalin Marinas <catalin.marinas@arm.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

All the logic in iommu_dma_alloc that deals with page allocation from
the CMA or page allocators can be split into a self-contained helper,
and we can than map the result of that or the atomic pool allocation
with the iommu later.  This also allows reusing __iommu_dma_free to
tear down the allocations and MMU mappings when the IOMMU mapping
fails.

Based on a patch from Robin Murphy.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 65 +++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9ac76d286df1..9f0aa80f2bdd 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -972,35 +972,14 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 	__iommu_dma_free(dev, size, cpu_addr);
 }
 
-static void *iommu_dma_alloc(struct device *dev, size_t size,
-		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
+static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
+		struct page **pagep, gfp_t gfp, unsigned long attrs)
 {
 	bool coherent = dev_is_dma_coherent(dev);
-	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
 	size_t alloc_size = PAGE_ALIGN(size);
 	struct page *page = NULL;
 	void *cpu_addr;
 
-	gfp |= __GFP_ZERO;
-
-	if (gfpflags_allow_blocking(gfp) &&
-	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
-		return iommu_dma_alloc_remap(dev, size, handle, gfp, attrs);
-
-	if (!gfpflags_allow_blocking(gfp) && !coherent) {
-		cpu_addr = dma_alloc_from_pool(alloc_size, &page, gfp);
-		if (!cpu_addr)
-			return NULL;
-
-		*handle = __iommu_dma_map(dev, page_to_phys(page), size,
-					  ioprot);
-		if (*handle == DMA_MAPPING_ERROR) {
-			dma_free_from_pool(cpu_addr, alloc_size);
-			return NULL;
-		}
-		return cpu_addr;
-	}
-
 	if (gfpflags_allow_blocking(gfp))
 		page = dma_alloc_from_contiguous(dev, alloc_size >> PAGE_SHIFT,
 						 get_order(alloc_size),
@@ -1010,33 +989,59 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	if (!page)
 		return NULL;
 
-	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot);
-	if (*handle == DMA_MAPPING_ERROR)
-		goto out_free_pages;
-
 	if (!coherent || PageHighMem(page)) {
 		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
 
 		cpu_addr = dma_common_contiguous_remap(page, alloc_size,
 				VM_USERMAP, prot, __builtin_return_address(0));
 		if (!cpu_addr)
-			goto out_unmap;
+			goto out_free_pages;
 
 		if (!coherent)
 			arch_dma_prep_coherent(page, size);
 	} else {
 		cpu_addr = page_address(page);
 	}
+
+	*pagep = page;
 	memset(cpu_addr, 0, alloc_size);
 	return cpu_addr;
-out_unmap:
-	__iommu_dma_unmap(dev, *handle, size);
 out_free_pages:
 	if (!dma_release_from_contiguous(dev, page, alloc_size >> PAGE_SHIFT))
 		__free_pages(page, get_order(alloc_size));
 	return NULL;
 }
 
+static void *iommu_dma_alloc(struct device *dev, size_t size,
+		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
+{
+	bool coherent = dev_is_dma_coherent(dev);
+	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
+	struct page *page = NULL;
+	void *cpu_addr;
+
+	gfp |= __GFP_ZERO;
+
+	if (gfpflags_allow_blocking(gfp) &&
+	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
+		return iommu_dma_alloc_remap(dev, size, handle, gfp, attrs);
+
+	if (!gfpflags_allow_blocking(gfp) && !coherent)
+		cpu_addr = dma_alloc_from_pool(PAGE_ALIGN(size), &page, gfp);
+	else
+		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
+	if (!cpu_addr)
+		return NULL;
+
+	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot);
+	if (*handle == DMA_MAPPING_ERROR) {
+		__iommu_dma_free(dev, size, cpu_addr);
+		return NULL;
+	}
+
+	return cpu_addr;
+}
+
 static int __iommu_dma_mmap_pfn(struct vm_area_struct *vma,
 			      unsigned long pfn, size_t size)
 {
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
