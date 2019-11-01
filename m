Return-Path: <SRS0=gESx=YZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666A8CA9ECF
	for <iommu@archiver.kernel.org>; Fri,  1 Nov 2019 22:02:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39BA82085B
	for <iommu@archiver.kernel.org>; Fri,  1 Nov 2019 22:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DlAzaOSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39BA82085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 21395F2A;
	Fri,  1 Nov 2019 22:02:46 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 502BCF1F
	for <iommu@lists.linux-foundation.org>;
	Fri,  1 Nov 2019 22:02:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B0F1C466
	for <iommu@lists.linux-foundation.org>;
	Fri,  1 Nov 2019 22:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qebaMi+U+2dL1OXsrXZXP/jQiq5ZSle7ujc2CzP81dc=;
	b=DlAzaOSVep934yvbCSrr5ycFkj
	QZUqW0UgYdzlCJfhG3fOqF6Vf3CbMB6aFe2b8/+WE4jLvRG2cg4oQKDzh1l+TMq/herhei6Zk2Xcl
	YEeaFm+rOb9lf8WMETar1Wn4Q+YPfkt2GQoXcJo79Jq3IfRv88DZ84gCZIaLaRgA5lm8d7Ail6W/G
	jDs+oXoN6wVpv8N32br94cvnZxkXCR/af5wo6AXjckdNyoR+K17YUjHE+bwjhW37/FMqyZanJcgQ/
	2fhhVVi2uImbU0ulj6NreMSYghDjrZ9qJP2COD/lrUGRInBVQGOeHx0FBF63OcO63fxy0qJwmdRer
	WQvpQU7w==;
Received: from [199.255.44.128] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iQf0G-0004Ha-1Y; Fri, 01 Nov 2019 22:02:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: Max Filippov <jcmvbkbc@gmail.com>, Chris Zankel <chris@zankel.net>,
	iommu@lists.linux-foundation.org
Subject: [PATCH 4/5] dma-mapping: merge the generic remapping helpers into
	dma-direct
Date: Fri,  1 Nov 2019 15:02:12 -0700
Message-Id: <20191101220213.28949-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191101220213.28949-1-hch@lst.de>
References: <20191101220213.28949-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-xtensa@linux-xtensa.org
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

Integrate the generic dma remapping implementation into the main flow.
This prepares for architectures like xtensa that use an uncached
segment for pages in the kernel mapping, but can also remap highmem
from CMA.  To simplify that implementation we now always deduct the
page from the physical address via the DMA address instead of the
virtual address.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 60 ++++++++++++++++++++++++++++++++++++---------
 kernel/dma/remap.c  | 49 ------------------------------------
 2 files changed, 48 insertions(+), 61 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index d8b612648a6b..e37e7ab6e2ee 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -12,6 +12,7 @@
 #include <linux/dma-contiguous.h>
 #include <linux/dma-noncoherent.h>
 #include <linux/pfn.h>
+#include <linux/vmalloc.h>
 #include <linux/set_memory.h>
 #include <linux/swiotlb.h>
 
@@ -137,6 +138,15 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	struct page *page;
 	void *ret;
 
+	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
+	    dma_alloc_need_uncached(dev, attrs) &&
+	    !gfpflags_allow_blocking(gfp)) {
+		ret = dma_alloc_from_pool(PAGE_ALIGN(size), &page, gfp);
+		if (!ret)
+			return NULL;
+		goto done;
+	}
+
 	page = __dma_direct_alloc_pages(dev, size, gfp, attrs);
 	if (!page)
 		return NULL;
@@ -146,9 +156,28 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 		/* remove any dirty cache lines on the kernel alias */
 		if (!PageHighMem(page))
 			arch_dma_prep_coherent(page, size);
-		*dma_handle = phys_to_dma(dev, page_to_phys(page));
 		/* return the page pointer as the opaque cookie */
-		return page;
+		ret = page;
+		goto done;
+	}
+
+	if ((IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
+	     dma_alloc_need_uncached(dev, attrs)) ||
+	    (IS_ENABLED(CONFIG_DMA_REMAP) && PageHighMem(page))) {
+		/* remove any dirty cache lines on the kernel alias */
+		arch_dma_prep_coherent(page, PAGE_ALIGN(size));
+
+		/* create a coherent mapping */
+		ret = dma_common_contiguous_remap(page, PAGE_ALIGN(size),
+				dma_pgprot(dev, PAGE_KERNEL, attrs),
+				__builtin_return_address(0));
+		if (!ret) {
+			dma_free_contiguous(dev, page, size);
+			return ret;
+		}
+
+		memset(ret, 0, size);
+		goto done;
 	}
 
 	if (PageHighMem(page)) {
@@ -164,12 +193,9 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	}
 
 	ret = page_address(page);
-	if (force_dma_unencrypted(dev)) {
+	if (force_dma_unencrypted(dev))
 		set_memory_decrypted((unsigned long)ret, 1 << get_order(size));
-		*dma_handle = __phys_to_dma(dev, page_to_phys(page));
-	} else {
-		*dma_handle = phys_to_dma(dev, page_to_phys(page));
-	}
+
 	memset(ret, 0, size);
 
 	if (IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
@@ -177,7 +203,11 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 		arch_dma_prep_coherent(page, size);
 		ret = uncached_kernel_address(ret);
 	}
-
+done:
+	if (force_dma_unencrypted(dev))
+		*dma_handle = __phys_to_dma(dev, page_to_phys(page));
+	else
+		*dma_handle = phys_to_dma(dev, page_to_phys(page));
 	return ret;
 }
 
@@ -193,19 +223,24 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 		return;
 	}
 
+	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
+	    dma_free_from_pool(cpu_addr, PAGE_ALIGN(size)))
+		return;
+
 	if (force_dma_unencrypted(dev))
 		set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
 
-	if (IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
-	    dma_alloc_need_uncached(dev, attrs))
-		cpu_addr = cached_kernel_address(cpu_addr);
-	dma_free_contiguous(dev, virt_to_page(cpu_addr), size);
+	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr))
+		vunmap(cpu_addr);
+
+	dma_free_contiguous(dev, dma_direct_to_page(dev, dma_addr), size);
 }
 
 void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	if (!IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
+	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
 	    dma_alloc_need_uncached(dev, attrs))
 		return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
 	return dma_direct_alloc_pages(dev, size, dma_handle, gfp, attrs);
@@ -215,6 +250,7 @@ void dma_direct_free(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
 {
 	if (!IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
+	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
 	    dma_alloc_need_uncached(dev, attrs))
 		arch_dma_free(dev, size, cpu_addr, dma_addr, attrs);
 	else
diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index 3c49499ee6b0..d47bd40fc0f5 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -210,53 +210,4 @@ bool dma_free_from_pool(void *start, size_t size)
 	gen_pool_free(atomic_pool, (unsigned long)start, size);
 	return true;
 }
-
-void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
-		gfp_t flags, unsigned long attrs)
-{
-	struct page *page = NULL;
-	void *ret;
-
-	size = PAGE_ALIGN(size);
-
-	if (!gfpflags_allow_blocking(flags)) {
-		ret = dma_alloc_from_pool(size, &page, flags);
-		if (!ret)
-			return NULL;
-		goto done;
-	}
-
-	page = __dma_direct_alloc_pages(dev, size, flags, attrs);
-	if (!page)
-		return NULL;
-
-	/* remove any dirty cache lines on the kernel alias */
-	arch_dma_prep_coherent(page, size);
-
-	/* create a coherent mapping */
-	ret = dma_common_contiguous_remap(page, size,
-			dma_pgprot(dev, PAGE_KERNEL, attrs),
-			__builtin_return_address(0));
-	if (!ret) {
-		dma_free_contiguous(dev, page, size);
-		return ret;
-	}
-
-	memset(ret, 0, size);
-done:
-	*dma_handle = phys_to_dma(dev, page_to_phys(page));
-	return ret;
-}
-
-void arch_dma_free(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t dma_handle, unsigned long attrs)
-{
-	if (!dma_free_from_pool(vaddr, PAGE_ALIGN(size))) {
-		phys_addr_t phys = dma_to_phys(dev, dma_handle);
-		struct page *page = pfn_to_page(__phys_to_pfn(phys));
-
-		vunmap(vaddr);
-		dma_free_contiguous(dev, page, size);
-	}
-}
 #endif /* CONFIG_DMA_DIRECT_REMAP */
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
