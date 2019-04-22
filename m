Return-Path: <SRS0=kOFq=SY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E505EC282CE
	for <iommu@archiver.kernel.org>; Mon, 22 Apr 2019 18:02:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43E620B1F
	for <iommu@archiver.kernel.org>; Mon, 22 Apr 2019 18:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Duwcx4sr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43E620B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A00FFD8B;
	Mon, 22 Apr 2019 18:01:06 +0000 (UTC)
Received: from smtp2.linuxfoundation.org (smtp2.linux-foundation.org
	[172.17.192.36])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 66CFED3D
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Apr 2019 18:01:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp2.linuxfoundation.org (Postfix) with ESMTPS id BA71B1DCEE
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Apr 2019 18:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uzgSnQXP6vcf7CnS63KV/WlaoJYHrG3AbQZAfPX3/hM=;
	b=Duwcx4srF+A/o9UeUqyXlmohsg
	bWufyQ9ceJdjqf8HLvyfLwFFxsTxITfZI9YbHWw5tPpyF7MNiAc/4LjpwP30N5ab8vF1XHYusmiz9
	qK1BFj5kP2e64aZE44h0ZNDdB/yf+t8JTwfb9RM/OnfabcrDJv2aQDPMkMVQXltLcfO8vv/Nokt7W
	65mgyYO4xeDM0/AfCopz6RORlEFadQxIEa2hPomAyODhVv9JH+sQ6r7LcX0wek8u4AtVCOk7WnjIo
	4YWDtalyhvslWYnJ6sHixju1/XDn6C5PP6RFK0I/IxW78IfVMap2FuLlC3EZtpuqw4w92EkWEAZF0
	txwf0jvw==;
Received: from 213-225-37-80.nat.highway.a1.net ([213.225.37.80]
	helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hIdFR-0002S5-Rn; Mon, 22 Apr 2019 18:00:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 19/26] iommu/dma: Cleanup variable naming in iommu_dma_alloc
Date: Mon, 22 Apr 2019 19:59:35 +0200
Message-Id: <20190422175942.18788-20-hch@lst.de>
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
Message-ID: <20190422175935.xdCjljgC_gbw6P2N6hYGycUMB5MZQY8lhldLjEsf3F4@z>

From: Robin Murphy <robin.murphy@arm.com>

Most importantly clear up the size / iosize confusion.  Also rename addr
to cpu_addr to match the surrounding code and make the intention a little
more clear.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
[hch: split from a larger patch]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 45 +++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 95a12e975994..9b269f0792f3 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -960,64 +960,63 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 {
 	bool coherent = dev_is_dma_coherent(dev);
 	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
-	size_t iosize = size;
+	size_t alloc_size = PAGE_ALIGN(size);
 	struct page *page = NULL;
-	void *addr;
+	void *cpu_addr;
 
-	size = PAGE_ALIGN(size);
 	gfp |= __GFP_ZERO;
 
 	if (gfpflags_allow_blocking(gfp) &&
 	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
-		return iommu_dma_alloc_remap(dev, iosize, handle, gfp, attrs);
+		return iommu_dma_alloc_remap(dev, size, handle, gfp, attrs);
 
 	if (!gfpflags_allow_blocking(gfp) && !coherent) {
-		addr = dma_alloc_from_pool(size, &page, gfp);
-		if (!addr)
+		cpu_addr = dma_alloc_from_pool(alloc_size, &page, gfp);
+		if (!cpu_addr)
 			return NULL;
 
-		*handle = __iommu_dma_map(dev, page_to_phys(page), iosize,
+		*handle = __iommu_dma_map(dev, page_to_phys(page), size,
 					  ioprot);
 		if (*handle == DMA_MAPPING_ERROR) {
-			dma_free_from_pool(addr, size);
+			dma_free_from_pool(cpu_addr, alloc_size);
 			return NULL;
 		}
-		return addr;
+		return cpu_addr;
 	}
 
 	if (gfpflags_allow_blocking(gfp))
-		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
-						 get_order(size),
+		page = dma_alloc_from_contiguous(dev, alloc_size >> PAGE_SHIFT,
+						 get_order(alloc_size),
 						 gfp & __GFP_NOWARN);
 	if (!page)
-		page = alloc_pages(gfp, get_order(size));
+		page = alloc_pages(gfp, get_order(alloc_size));
 	if (!page)
 		return NULL;
 
-	*handle = __iommu_dma_map(dev, page_to_phys(page), iosize, ioprot);
+	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot);
 	if (*handle == DMA_MAPPING_ERROR)
 		goto out_free_pages;
 
 	if (!coherent || PageHighMem(page)) {
 		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
 
-		addr = dma_common_contiguous_remap(page, size, VM_USERMAP, prot,
-				__builtin_return_address(0));
-		if (!addr)
+		cpu_addr = dma_common_contiguous_remap(page, alloc_size,
+				VM_USERMAP, prot, __builtin_return_address(0));
+		if (!cpu_addr)
 			goto out_unmap;
 
 		if (!coherent)
-			arch_dma_prep_coherent(page, iosize);
+			arch_dma_prep_coherent(page, size);
 	} else {
-		addr = page_address(page);
+		cpu_addr = page_address(page);
 	}
-	memset(addr, 0, size);
-	return addr;
+	memset(cpu_addr, 0, alloc_size);
+	return cpu_addr;
 out_unmap:
-	__iommu_dma_unmap(dev, *handle, iosize);
+	__iommu_dma_unmap(dev, *handle, size);
 out_free_pages:
-	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
-		__free_pages(page, get_order(size));
+	if (!dma_release_from_contiguous(dev, page, alloc_size >> PAGE_SHIFT))
+		__free_pages(page, get_order(alloc_size));
 	return NULL;
 }
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
