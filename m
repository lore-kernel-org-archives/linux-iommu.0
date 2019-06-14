Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D16C31E4C
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 14:45:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E38A2133D
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 14:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="goAYdDm6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E38A2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9B49F138A;
	Fri, 14 Jun 2019 14:45:22 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 15F451372
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 14:45:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7F408E5
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 14:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uwnDv1KhES3Re+AMwM82pmt+rEujP4N4t/Md4KoSM88=;
	b=goAYdDm609nD5VBcnMmPH4v15P
	kYpPS40DH9d8YqwKfLgZO/b3FSOZOgUzamHnQFqToxP9H/DyUbvT/dwC04XH4P2LRiWrRVieXp1n5
	JbZ9AupJ6l+ROXP8jJv5jVaSekslaf+Wl2a/PO6rwDnQtclWPO3SY5W6LLZXYe9wRp/1qZhY1W2Cz
	W4omLGDSRkZ85dQ0h9KHFiYDUreq6puCMLiGeqeZ8wHYpe7AoozVZnMRUEkW5owjwIYA4YRLwzi0s
	dGictznwZyHKAr3d2Ljl3S60RN72I89FmbWsVVLfqJqLaTZ06iRd1DI4tkRLl42MAjBngAdrkUHoD
	B3WIkXlw==;
Received: from 213-225-9-13.nat.highway.a1.net ([213.225.9.13] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
	id 1hbnRt-00069J-D9; Fri, 14 Jun 2019 14:45:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 7/7] arc: use the generic remapping allocator for coherent DMA
	allocations
Date: Fri, 14 Jun 2019 16:44:31 +0200
Message-Id: <20190614144431.21760-8-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614144431.21760-1-hch@lst.de>
References: <20190614144431.21760-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Jonas Bonn <jonas@southpole.se>, linux-xtensa@linux-xtensa.org,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>,
	linux-kernel@vger.kernel.org,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	iommu@lists.linux-foundation.org, openrisc@lists.librecores.org,
	Stafford Horne <shorne@gmail.com>, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
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

Replace the code that sets up uncached PTEs with the generic vmap based
remapping code.  It also provides an atomic pool for allocations from
non-blocking context, which we not properly supported by the existing
arc code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arc/Kconfig  |  2 ++
 arch/arc/mm/dma.c | 62 ++++++++---------------------------------------
 2 files changed, 12 insertions(+), 52 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 23e063df5d2c..cdad7d30ff1d 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -10,6 +10,7 @@ config ARC
 	def_bool y
 	select ARC_TIMERS
 	select ARCH_HAS_DMA_COHERENT_TO_PFN
+	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
@@ -19,6 +20,7 @@ config ARC
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select COMMON_CLK
+	select DMA_DIRECT_REMAP
 	select GENERIC_ATOMIC64 if !ISA_ARCV2 || !(ARC_HAS_LL64 && ARC_HAS_LLSC)
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_FIND_FIRST_BIT
diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index 9832928f896d..0fa850709fac 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -11,46 +11,15 @@
 #include <asm/cacheflush.h>
 
 /*
- * ARCH specific callbacks for generic noncoherent DMA ops (dma/noncoherent.c)
+ * ARCH specific callbacks for generic noncoherent DMA ops
  *  - hardware IOC not available (or "dma-coherent" not set for device in DT)
  *  - But still handle both coherent and non-coherent requests from caller
  *
  * For DMA coherent hardware (IOC) generic code suffices
  */
-void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
-		gfp_t gfp, unsigned long attrs)
-{
-	unsigned long order = get_order(size);
-	struct page *page;
-	phys_addr_t paddr;
-	void *kvaddr;
-
-	/*
-	 * __GFP_HIGHMEM flag is cleared by upper layer functions
-	 * (in include/linux/dma-mapping.h) so we should never get a
-	 * __GFP_HIGHMEM here.
-	 */
-	BUG_ON(gfp & __GFP_HIGHMEM);
-
-	page = alloc_pages(gfp | __GFP_ZERO, order);
-	if (!page)
-		return NULL;
-
-	/* This is linear addr (0x8000_0000 based) */
-	paddr = page_to_phys(page);
-
-	*dma_handle = paddr;
-
-	/*
-	 * A coherent buffer needs MMU mapping to enforce non-cachability.
-	 * kvaddr is kernel Virtual address (0x7000_0000 based).
-	 */
-	kvaddr = ioremap_nocache(paddr, size);
-	if (kvaddr == NULL) {
-		__free_pages(page, order);
-		return NULL;
-	}
 
+void arch_dma_prep_coherent(struct page *page, size_t size)
+{
 	/*
 	 * Evict any existing L1 and/or L2 lines for the backing page
 	 * in case it was used earlier as a normal "cached" page.
@@ -61,24 +30,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	 * Currently flush_cache_vmap nukes the L1 cache completely which
 	 * will be optimized as a separate commit
 	 */
-	dma_cache_wback_inv(paddr, size);
-	return kvaddr;
-}
-
-void arch_dma_free(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t dma_handle, unsigned long attrs)
-{
-	phys_addr_t paddr = dma_handle;
-	struct page *page = virt_to_page(paddr);
-
-	iounmap((void __force __iomem *)vaddr);
-	__free_pages(page, get_order(size));
-}
-
-long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
-		dma_addr_t dma_addr)
-{
-	return __phys_to_pfn(dma_addr);
+	dma_cache_wback_inv(page_to_phys(page), size);
 }
 
 /*
@@ -155,3 +107,9 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 	dev_info(dev, "use %sncoherent DMA ops\n",
 		 dev->dma_coherent ? "" : "non");
 }
+
+static int __init atomic_pool_init(void)
+{
+	return dma_atomic_pool_init(GFP_KERNEL, pgprot_noncached(PAGE_KERNEL));
+}
+postcore_initcall(atomic_pool_init);
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
