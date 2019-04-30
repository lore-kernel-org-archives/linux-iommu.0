Return-Path: <SRS0=Kg+4=TA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11205C43219
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 11:11:11 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D44E22080C
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 11:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iBVOZENf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44E22080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 21A24F0B;
	Tue, 30 Apr 2019 11:11:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1690AF1C
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 11:10:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AA26D5F4
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 11:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jd+pE32YSyQqKfn/xGQJyQwBhLpZ3+sMQJockuGQITI=;
	b=iBVOZENf8H1BEtF/SzySkJlluW
	CxEq9k1QjHKnVdC+UJL5MEdSXvYDCy6j1y+QtYyDe8jYPSy0/hAZ8Tv08Cu4t60YnW3sBIVFq5tiP
	SiIoor7Cyl9WGfMwJPO1YsBuM0Qppwpzk8hiMwXEK94Xw0oYqco2jTqVJgjqGg70japsw5LUuEkqj
	wUJ6b4rkZcoYNSQAzzscmWKlh3wfSN83TWpdKnVXtbMCV1RdObGgZN9jhYXIBW3mF6hhbiN/5OH6T
	hKn5PiVe5L+aYWdOfPQ6K005GhAId9wLKpzhrrbIa2wAoORdI2VpYFG63IlanHe8tYoY7admdQNDL
	VVB9REpg==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hLQVk-0000Hq-TM; Tue, 30 Apr 2019 11:01:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
	James Hogan <jhogan@kernel.org>, Ley Foon Tan <lftan@altera.com>,
	Michal Simek <monstr@monstr.eu>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 6/7] nios2: use the generic uncached segment support in
	dma-direct
Date: Tue, 30 Apr 2019 07:00:31 -0400
Message-Id: <20190430110032.25301-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430110032.25301-1-hch@lst.de>
References: <20190430110032.25301-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, linux-mips@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
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
Message-ID: <20190430110031.fJ7gmK5KCSpQ1tH-Mgi7PuDe-bWjNulBLlCc1h5Xi3I@z>

Stop providing our own arch alloc/free hooks and just expose the segment
offset and use the generic dma-direct allocator.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/nios2/Kconfig            |  1 +
 arch/nios2/include/asm/page.h |  6 ------
 arch/nios2/mm/dma-mapping.c   | 34 +++++++++++++++-------------------
 3 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 4ef15a61b7bc..c87af5c77d24 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -4,6 +4,7 @@ config NIOS2
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_HAS_UNCACHED_SEGMENT
 	select ARCH_NO_SWAP
 	select TIMER_OF
 	select GENERIC_ATOMIC64
diff --git a/arch/nios2/include/asm/page.h b/arch/nios2/include/asm/page.h
index f1fbdc47bdaf..79fcac61f6ef 100644
--- a/arch/nios2/include/asm/page.h
+++ b/arch/nios2/include/asm/page.h
@@ -101,12 +101,6 @@ static inline bool pfn_valid(unsigned long pfn)
 # define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
-# define UNCAC_ADDR(addr)	\
-	((void *)((unsigned)(addr) | CONFIG_NIOS2_IO_REGION_BASE))
-# define CAC_ADDR(addr)		\
-	((void *)(((unsigned)(addr) & ~CONFIG_NIOS2_IO_REGION_BASE) |	\
-		CONFIG_NIOS2_KERNEL_REGION_BASE))
-
 #include <asm-generic/memory_model.h>
 
 #include <asm-generic/getorder.h>
diff --git a/arch/nios2/mm/dma-mapping.c b/arch/nios2/mm/dma-mapping.c
index 4af9e5b5ba1c..9cb238664584 100644
--- a/arch/nios2/mm/dma-mapping.c
+++ b/arch/nios2/mm/dma-mapping.c
@@ -60,32 +60,28 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
 	}
 }
 
-void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
-		gfp_t gfp, unsigned long attrs)
+void arch_dma_prep_coherent(struct page *page, size_t size)
 {
-	void *ret;
+	unsigned long start = (unsigned long)page_address(page);
 
-	/* optimized page clearing */
-	gfp |= __GFP_ZERO;
+	flush_dcache_range(start, start + size);
+}
 
-	if (dev == NULL || (dev->coherent_dma_mask < 0xffffffff))
-		gfp |= GFP_DMA;
+void *uncached_kernel_address(void *ptr)
+{
+	unsigned long addr = (unsigned long)ptr;
 
-	ret = (void *) __get_free_pages(gfp, get_order(size));
-	if (ret != NULL) {
-		*dma_handle = virt_to_phys(ret);
-		flush_dcache_range((unsigned long) ret,
-			(unsigned long) ret + size);
-		ret = UNCAC_ADDR(ret);
-	}
+	addr |= CONFIG_NIOS2_IO_REGION_BASE;
 
-	return ret;
+	return (void *)ptr;
 }
 
-void arch_dma_free(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t dma_handle, unsigned long attrs)
+void *cached_kernel_address(void *ptr)
 {
-	unsigned long addr = (unsigned long) CAC_ADDR((unsigned long) vaddr);
+	unsigned long addr = (unsigned long)ptr;
+
+	addr &= ~CONFIG_NIOS2_IO_REGION_BASE;
+	addr |= CONFIG_NIOS2_KERNEL_REGION_BASE;
 
-	free_pages(addr, get_order(size));
+	return (void *)ptr;
 }
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
