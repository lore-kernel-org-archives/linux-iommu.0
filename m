Return-Path: <SRS0=gESx=YZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922EBCA9ECF
	for <iommu@archiver.kernel.org>; Fri,  1 Nov 2019 22:02:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63B522085B
	for <iommu@archiver.kernel.org>; Fri,  1 Nov 2019 22:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q/IwMHni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B522085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4B505F25;
	Fri,  1 Nov 2019 22:02:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A25CAF22
	for <iommu@lists.linux-foundation.org>;
	Fri,  1 Nov 2019 22:02:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0732E14D
	for <iommu@lists.linux-foundation.org>;
	Fri,  1 Nov 2019 22:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JnE6G3AN5zHaA64VgyVmRKlHUI+9cuDPw161Jkx+RLo=;
	b=Q/IwMHniaFAjSyaGDuKVafUCd+
	Aqyo8Q8OvmTmMibGS5SV3jayKqVAmsMG+21qRRUTtzh0CdpRNRodjdLutgiV6dDzrkyl8XaZ51sS7
	C4swYl983bioT5c3JjgZfJSbrqSlWAlTrkU6Up8Ag6tlOwCP9XWc4ql0lQCN/g6G7aToz3HEg9Ekh
	yeRmGd5e0yeF12+QL4F5YEXc0C8C0gTta3Glx7/EE/auUEzuNA3RQFVQse7s5kttR5Uw4MdUsI4Ee
	RFtHFaNXAKtdQldAXE5CLCgaZDCIpn2uXH/ih31mI5tQXvKFM/NHIxDFg0/RqqXyfqA5fcVHH/Wl+
	wfQr1rLw==;
Received: from [199.255.44.128] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iQf0L-0004Hz-9h; Fri, 01 Nov 2019 22:02:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: Max Filippov <jcmvbkbc@gmail.com>, Chris Zankel <chris@zankel.net>,
	iommu@lists.linux-foundation.org
Subject: [PATCH 5/5] xtensa: use the generic uncached segment support
Date: Fri,  1 Nov 2019 15:02:13 -0700
Message-Id: <20191101220213.28949-6-hch@lst.de>
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

Switch xtensa over to use the generic uncached support, and thus the
generic implementations of dma_alloc_* and dma_alloc_*, which also
gains support for mmaping DMA memory.  The non-working nommu DMA
support has been disabled, but could be re-enabled easily if platforms
that actually have an uncached segment show up.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/xtensa/Kconfig                |   6 +-
 arch/xtensa/include/asm/platform.h |  27 -------
 arch/xtensa/kernel/Makefile        |   3 +-
 arch/xtensa/kernel/pci-dma.c       | 121 +++--------------------------
 4 files changed, 18 insertions(+), 139 deletions(-)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index a8e7beb6b7b5..c95a34702242 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -3,8 +3,10 @@ config XTENSA
 	def_bool y
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_BINFMT_FLAT if !MMU
-	select ARCH_HAS_SYNC_DMA_FOR_CPU
-	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_HAS_DMA_PREP_COHERENT if MMU
+	select ARCH_HAS_SYNC_DMA_FOR_CPU if MMU
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if MMU
+	select ARCH_HAS_UNCACHED_SEGMENT if MMU
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
 	select ARCH_WANT_FRAME_POINTERS
diff --git a/arch/xtensa/include/asm/platform.h b/arch/xtensa/include/asm/platform.h
index 913826dfa838..f2c48522c5a1 100644
--- a/arch/xtensa/include/asm/platform.h
+++ b/arch/xtensa/include/asm/platform.h
@@ -65,31 +65,4 @@ extern void platform_calibrate_ccount (void);
  */
 void cpu_reset(void) __attribute__((noreturn));
 
-/*
- * Memory caching is platform-dependent in noMMU xtensa configurations.
- * The following set of functions should be implemented in platform code
- * in order to enable coherent DMA memory operations when CONFIG_MMU is not
- * enabled. Default implementations do nothing and issue a warning.
- */
-
-/*
- * Check whether p points to a cached memory.
- */
-bool platform_vaddr_cached(const void *p);
-
-/*
- * Check whether p points to an uncached memory.
- */
-bool platform_vaddr_uncached(const void *p);
-
-/*
- * Return pointer to an uncached view of the cached sddress p.
- */
-void *platform_vaddr_to_uncached(void *p);
-
-/*
- * Return pointer to a cached view of the uncached sddress p.
- */
-void *platform_vaddr_to_cached(void *p);
-
 #endif	/* _XTENSA_PLATFORM_H */
diff --git a/arch/xtensa/kernel/Makefile b/arch/xtensa/kernel/Makefile
index 6f629027ac7d..d4082c6a121b 100644
--- a/arch/xtensa/kernel/Makefile
+++ b/arch/xtensa/kernel/Makefile
@@ -5,10 +5,11 @@
 
 extra-y := head.o vmlinux.lds
 
-obj-y := align.o coprocessor.o entry.o irq.o pci-dma.o platform.o process.o \
+obj-y := align.o coprocessor.o entry.o irq.o platform.o process.o \
 	 ptrace.o setup.o signal.o stacktrace.o syscall.o time.o traps.o \
 	 vectors.o
 
+obj-$(CONFIG_MMU) += pci-dma.o
 obj-$(CONFIG_PCI) += pci.o
 obj-$(CONFIG_MODULES) += xtensa_ksyms.o module.o
 obj-$(CONFIG_FUNCTION_TRACER) += mcount.o
diff --git a/arch/xtensa/kernel/pci-dma.c b/arch/xtensa/kernel/pci-dma.c
index 154979d62b73..1c82e21de4f6 100644
--- a/arch/xtensa/kernel/pci-dma.c
+++ b/arch/xtensa/kernel/pci-dma.c
@@ -81,122 +81,25 @@ void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
 	}
 }
 
-#ifdef CONFIG_MMU
-bool platform_vaddr_cached(const void *p)
-{
-	unsigned long addr = (unsigned long)p;
-
-	return addr >= XCHAL_KSEG_CACHED_VADDR &&
-	       addr - XCHAL_KSEG_CACHED_VADDR < XCHAL_KSEG_SIZE;
-}
-
-bool platform_vaddr_uncached(const void *p)
-{
-	unsigned long addr = (unsigned long)p;
-
-	return addr >= XCHAL_KSEG_BYPASS_VADDR &&
-	       addr - XCHAL_KSEG_BYPASS_VADDR < XCHAL_KSEG_SIZE;
-}
-
-void *platform_vaddr_to_uncached(void *p)
-{
-	return p + XCHAL_KSEG_BYPASS_VADDR - XCHAL_KSEG_CACHED_VADDR;
-}
-
-void *platform_vaddr_to_cached(void *p)
-{
-	return p + XCHAL_KSEG_CACHED_VADDR - XCHAL_KSEG_BYPASS_VADDR;
-}
-#else
-bool __attribute__((weak)) platform_vaddr_cached(const void *p)
-{
-	WARN_ONCE(1, "Default %s implementation is used\n", __func__);
-	return true;
-}
-
-bool __attribute__((weak)) platform_vaddr_uncached(const void *p)
-{
-	WARN_ONCE(1, "Default %s implementation is used\n", __func__);
-	return false;
-}
-
-void __attribute__((weak)) *platform_vaddr_to_uncached(void *p)
+void arch_dma_prep_coherent(struct page *page, size_t size)
 {
-	WARN_ONCE(1, "Default %s implementation is used\n", __func__);
-	return p;
-}
-
-void __attribute__((weak)) *platform_vaddr_to_cached(void *p)
-{
-	WARN_ONCE(1, "Default %s implementation is used\n", __func__);
-	return p;
+	__invalidate_dcache_range((unsigned long)page_address(page), size);
 }
-#endif
 
 /*
- * Note: We assume that the full memory space is always mapped to 'kseg'
- *	 Otherwise we have to use page attributes (not implemented).
+ * Memory caching is platform-dependent in noMMU xtensa configurations.
+ * The following two functions should be implemented in platform code
+ * in order to enable coherent DMA memory operations when CONFIG_MMU is not
+ * enabled.
  */
-
-void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
-		gfp_t flag, unsigned long attrs)
-{
-	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	struct page *page = NULL;
-
-	/* ignore region speicifiers */
-
-	flag &= ~(__GFP_DMA | __GFP_HIGHMEM);
-
-	if (dev == NULL || (dev->coherent_dma_mask < 0xffffffff))
-		flag |= GFP_DMA;
-
-	if (gfpflags_allow_blocking(flag))
-		page = dma_alloc_from_contiguous(dev, count, get_order(size),
-						 flag & __GFP_NOWARN);
-
-	if (!page)
-		page = alloc_pages(flag | __GFP_ZERO, get_order(size));
-
-	if (!page)
-		return NULL;
-
-	*handle = phys_to_dma(dev, page_to_phys(page));
-
 #ifdef CONFIG_MMU
-	if (PageHighMem(page)) {
-		void *p;
-
-		p = dma_common_contiguous_remap(page, size,
-						pgprot_noncached(PAGE_KERNEL),
-						__builtin_return_address(0));
-		if (!p) {
-			if (!dma_release_from_contiguous(dev, page, count))
-				__free_pages(page, get_order(size));
-		}
-		return p;
-	}
-#endif
-	BUG_ON(!platform_vaddr_cached(page_address(page)));
-	__invalidate_dcache_range((unsigned long)page_address(page), size);
-	return platform_vaddr_to_uncached(page_address(page));
+void *uncached_kernel_address(void *p)
+{
+	return p + XCHAL_KSEG_BYPASS_VADDR - XCHAL_KSEG_CACHED_VADDR;
 }
 
-void arch_dma_free(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t dma_handle, unsigned long attrs)
+void *cached_kernel_address(void *p)
 {
-	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	struct page *page;
-
-	if (platform_vaddr_uncached(vaddr)) {
-		page = virt_to_page(platform_vaddr_to_cached(vaddr));
-	} else {
-#ifdef CONFIG_MMU
-		dma_common_free_remap(vaddr, size);
-#endif
-		page = pfn_to_page(PHYS_PFN(dma_to_phys(dev, dma_handle)));
-	}
-
-	if (!dma_release_from_contiguous(dev, page, count))
-		__free_pages(page, get_order(size));
+	return p + XCHAL_KSEG_CACHED_VADDR - XCHAL_KSEG_BYPASS_VADDR;
 }
+#endif /* CONFIG_MMU */
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
