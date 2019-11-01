Return-Path: <SRS0=gESx=YZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC75CA9ECF
	for <iommu@archiver.kernel.org>; Fri,  1 Nov 2019 22:02:32 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0CB72085B
	for <iommu@archiver.kernel.org>; Fri,  1 Nov 2019 22:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rsBkYlzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CB72085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A6EDCF22;
	Fri,  1 Nov 2019 22:02:32 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A9E60F1F
	for <iommu@lists.linux-foundation.org>;
	Fri,  1 Nov 2019 22:02:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C1EC7466
	for <iommu@lists.linux-foundation.org>;
	Fri,  1 Nov 2019 22:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oPXBfF0GT9S03U2z/7qbScQRkSSJt1xlvDrVapbayCY=;
	b=rsBkYlzvWRgINpamkgtvQhQqY5
	XlIuAtgnrHKsMTX78+b6k7NCTEMMRNlSbm/VknuW/wTb747isG6Sf2Pgk7TUiT632EP4kVPzdmtgc
	9XVjuMTtIkuhGFX2M4DFNiiD0fRaToMYnNGVmIN36eIScteCz7A1XDJ5prmeikNISXYniP+PODwOf
	HHMxs47EfcS6uV9i/gUyfm5qrD32RZ1uHkM3g7trv6Z4baPKHvaQn8ROE8MUTL16uhrwg+fHlKh0U
	Y5WYmXepYzdrgQ42DFBcBhFobLXEEsR2OfYQatDjJJYrWrtIsrBwtLCMM2VcnSigqJPJoAV2aFGia
	Nv0JJElQ==;
Received: from [199.255.44.128] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iQf00-0004Fp-6M; Fri, 01 Nov 2019 22:02:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Max Filippov <jcmvbkbc@gmail.com>, Chris Zankel <chris@zankel.net>,
	iommu@lists.linux-foundation.org
Subject: [PATCH 1/5] dma-direct: remove __dma_direct_free_pages
Date: Fri,  1 Nov 2019 15:02:09 -0700
Message-Id: <20191101220213.28949-2-hch@lst.de>
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

We can just call dma_free_contiguous directly instead of wrapping it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-direct.h |  1 -
 kernel/dma/direct.c        | 11 +++--------
 kernel/dma/remap.c         |  4 ++--
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index adf993a3bd58..dec3b3bb121d 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -68,6 +68,5 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs);
 struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs);
-void __dma_direct_free_pages(struct device *dev, size_t size, struct page *page);
 int dma_direct_supported(struct device *dev, u64 mask);
 #endif /* _LINUX_DMA_DIRECT_H */
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 8402b29c280f..a7a2739fb747 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -153,7 +153,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 		 * so log an error and fail.
 		 */
 		dev_info(dev, "Rejecting highmem page from CMA.\n");
-		__dma_direct_free_pages(dev, size, page);
+		dma_free_contiguous(dev, page, size);
 		return NULL;
 	}
 
@@ -175,11 +175,6 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	return ret;
 }
 
-void __dma_direct_free_pages(struct device *dev, size_t size, struct page *page)
-{
-	dma_free_contiguous(dev, page, size);
-}
-
 void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs)
 {
@@ -188,7 +183,7 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
 	    !force_dma_unencrypted(dev)) {
 		/* cpu_addr is a struct page cookie, not a kernel address */
-		__dma_direct_free_pages(dev, size, cpu_addr);
+		dma_free_contiguous(dev, cpu_addr, size);
 		return;
 	}
 
@@ -198,7 +193,7 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 	if (IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
 	    dma_alloc_need_uncached(dev, attrs))
 		cpu_addr = cached_kernel_address(cpu_addr);
-	__dma_direct_free_pages(dev, size, virt_to_page(cpu_addr));
+	dma_free_contiguous(dev, virt_to_page(cpu_addr), size);
 }
 
 void *dma_direct_alloc(struct device *dev, size_t size,
diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index c00b9258fa6a..fb1e50c2d48a 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -238,7 +238,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 			dma_pgprot(dev, PAGE_KERNEL, attrs),
 			__builtin_return_address(0));
 	if (!ret) {
-		__dma_direct_free_pages(dev, size, page);
+		dma_free_contiguous(dev, page, size);
 		return ret;
 	}
 
@@ -256,7 +256,7 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 		struct page *page = pfn_to_page(__phys_to_pfn(phys));
 
 		vunmap(vaddr);
-		__dma_direct_free_pages(dev, size, page);
+		dma_free_contiguous(dev, page, size);
 	}
 }
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
