Return-Path: <SRS0=Kg+4=TA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971D0C43219
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 11:10:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65EFF2080C
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 11:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kg+YAeYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65EFF2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9165DF31;
	Tue, 30 Apr 2019 11:10:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4B63ADF2
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 11:10:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D176F5F4
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 11:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RUwvDT5z16aEV4S7EjwzZCVyjczT+2ls77WPVK4wW6k=;
	b=Kg+YAeYW0/J0T3b81wRmkJNjzT
	mvq35u48KkaXCH9uyk9jC9ZR6VuAuvZBAki6UF1sI09/pc+a1QlNHm20JsjOxIBmLwYyoaKjRhvlY
	9qczTRHE1cyMSfP+0oCSDrNtL9kFXpBWnRCkGaeOvaPVmwWtPyQx/9vZedlyijXIK782xwcc8uUNL
	lU+PdSIxkCA3JW4jfErasH3PFu2myahHhq8tdGdt7t1+GSoYtljfL8uXcY5cm0GCHta8HfhuOMthY
	VZBQJQdUXCQ85U8krlvaQNhcPVUy7sbfmS6GZ9W9N3EPNgYSkcUUele4yOls+CFTqqXPFRNKGQh/V
	xxfuXUlQ==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hLQVi-0000HU-Qc; Tue, 30 Apr 2019 11:01:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
	James Hogan <jhogan@kernel.org>, Ley Foon Tan <lftan@altera.com>,
	Michal Simek <monstr@monstr.eu>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 5/7] MIPS: use the generic uncached segment support in
	dma-direct
Date: Tue, 30 Apr 2019 07:00:30 -0400
Message-Id: <20190430110032.25301-6-hch@lst.de>
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
Message-ID: <20190430110030.j-IWlI0kiOXqSCz_J28Ibo3wbz8SU80DqUsH9DETXrI@z>

Stop providing our arch alloc/free hooks and just expose the segment
offset instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/Kconfig              |  1 +
 arch/mips/include/asm/page.h   |  3 ---
 arch/mips/jazz/jazzdma.c       |  6 ------
 arch/mips/mm/dma-noncoherent.c | 27 ++++++++++-----------------
 4 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 4a5f5b0ee9a9..cde4b490f3c7 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -9,6 +9,7 @@ config MIPS
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_UNCACHED_SEGMENT
 	select ARCH_SUPPORTS_UPROBES
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index 6b31c93b5eaa..23e0f1386e04 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -258,9 +258,6 @@ extern int __virt_addr_valid(const volatile void *kaddr);
 	 ((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0) | \
 	 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
-#define UNCAC_ADDR(addr)	(UNCAC_BASE + __pa(addr))
-#define CAC_ADDR(addr)		((unsigned long)__va((addr) - UNCAC_BASE))
-
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
 
diff --git a/arch/mips/jazz/jazzdma.c b/arch/mips/jazz/jazzdma.c
index bedb5047aff3..1804dc9d8136 100644
--- a/arch/mips/jazz/jazzdma.c
+++ b/arch/mips/jazz/jazzdma.c
@@ -575,10 +575,6 @@ static void *jazz_dma_alloc(struct device *dev, size_t size,
 		return NULL;
 	}
 
-	if (!(attrs & DMA_ATTR_NON_CONSISTENT)) {
-		dma_cache_wback_inv((unsigned long)ret, size);
-		ret = (void *)UNCAC_ADDR(ret);
-	}
 	return ret;
 }
 
@@ -586,8 +582,6 @@ static void jazz_dma_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_handle, unsigned long attrs)
 {
 	vdma_free(dma_handle);
-	if (!(attrs & DMA_ATTR_NON_CONSISTENT))
-		vaddr = (void *)CAC_ADDR((unsigned long)vaddr);
 	dma_direct_free_pages(dev, size, vaddr, dma_handle, attrs);
 }
 
diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
index f9549d2fbea3..f739f42c9d3c 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -44,33 +44,26 @@ static inline bool cpu_needs_post_dma_flush(struct device *dev)
 	}
 }
 
-void *arch_dma_alloc(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+void arch_dma_prep_coherent(struct page *page, size_t size)
 {
-	void *ret;
-
-	ret = dma_direct_alloc_pages(dev, size, dma_handle, gfp, attrs);
-	if (ret && !(attrs & DMA_ATTR_NON_CONSISTENT)) {
-		dma_cache_wback_inv((unsigned long) ret, size);
-		ret = (void *)UNCAC_ADDR(ret);
-	}
+	if (!PageHighMem(page))
+		dma_cache_wback_inv((unsigned long)page_address(page), size);
+}
 
-	return ret;
+void *uncached_kernel_address(void *addr)
+{
+	return (void *)(__pa(addr) + UNCAC_BASE);
 }
 
-void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
-		dma_addr_t dma_addr, unsigned long attrs)
+void *cached_kernel_address(void *addr)
 {
-	if (!(attrs & DMA_ATTR_NON_CONSISTENT))
-		cpu_addr = (void *)CAC_ADDR((unsigned long)cpu_addr);
-	dma_direct_free_pages(dev, size, cpu_addr, dma_addr, attrs);
+	return __va(addr) - UNCAC_BASE;
 }
 
 long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
 		dma_addr_t dma_addr)
 {
-	unsigned long addr = CAC_ADDR((unsigned long)cpu_addr);
-	return page_to_pfn(virt_to_page((void *)addr));
+	return page_to_pfn(virt_to_page(cached_kernel_address(cpu_addr)));
 }
 
 pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
