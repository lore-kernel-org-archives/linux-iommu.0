Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F17C31E4B
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 10:21:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A96EE20665
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 10:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hvFLuMu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96EE20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 32333113F;
	Fri, 14 Jun 2019 10:21:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 688A8113B
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 10:21:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 15484174
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 10:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=j0Cd9GGOgMoKm5X2hxzw/y200bYZ2yfLqG0iku08Mew=;
	b=hvFLuMu9hhbct610IILHoKzB6h
	9xiBbW+itujDPTCkxN5lYpQl/q9AHF1Abvj2/AI5HlhercaNwDkiYVsy4lM6cK4IuXQXobmADVMKf
	Kezq7bSu5LgidPiEPlBBH9gjFFAbjqMHsmtWoowXgWyA9zrwIRU3GbyD/di96btH+rtlmYlCo0oga
	98fxzdgw2I21AU9m8XuBwCPwLxNaHatTx0NTbkXJZjUkBtX9Bng11Ut70MnLLSimz35aTVrO49frG
	klCtnWbDmiofeuA40edY4sl9LWW4wndXGxqOOFg/Tng7wIbWy12ydD/3MHGkPeRh8yZtuorJL25mI
	JN7mKCBg==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
	id 1hbjKt-0005NQ-RE; Fri, 14 Jun 2019 10:21:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH 1/2] m68k: use the generic dma coherent remap allocator
Date: Fri, 14 Jun 2019 12:21:25 +0200
Message-Id: <20190614102126.8402-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614102126.8402-1-hch@lst.de>
References: <20190614102126.8402-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-m68k@lists.linux-m68k.org, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
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

This switche to using common code for the DMA allocations, including
potential use of the CMA allocator if configure.  Also add a
comment where the existing behavior seems to be lacking.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m68k/Kconfig      |  2 ++
 arch/m68k/kernel/dma.c | 59 ++++++++----------------------------------
 2 files changed, 13 insertions(+), 48 deletions(-)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 218e037ef901..2571a8fba4b0 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -3,10 +3,12 @@ config M68K
 	bool
 	default y
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_DMA_MMAP_PGPROT if MMU && !COLDFIRE
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
 	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
 	select ARCH_NO_PREEMPT if !COLDFIRE
+	select DMA_DIRECT_REMAP if MMU && !COLDFIRE
 	select HAVE_IDE
 	select HAVE_AOUT if MMU
 	select HAVE_DEBUG_BUGVERBOSE
diff --git a/arch/m68k/kernel/dma.c b/arch/m68k/kernel/dma.c
index b4aa853051bd..9c6a350a16d8 100644
--- a/arch/m68k/kernel/dma.c
+++ b/arch/m68k/kernel/dma.c
@@ -18,57 +18,20 @@
 #include <asm/pgalloc.h>
 
 #if defined(CONFIG_MMU) && !defined(CONFIG_COLDFIRE)
-
-void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
-		gfp_t flag, unsigned long attrs)
+pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
+		unsigned long attrs)
 {
-	struct page *page, **map;
-	pgprot_t pgprot;
-	void *addr;
-	int i, order;
-
-	pr_debug("dma_alloc_coherent: %d,%x\n", size, flag);
-
-	size = PAGE_ALIGN(size);
-	order = get_order(size);
-
-	page = alloc_pages(flag | __GFP_ZERO, order);
-	if (!page)
-		return NULL;
-
-	*handle = page_to_phys(page);
-	map = kmalloc(sizeof(struct page *) << order, flag & ~__GFP_DMA);
-	if (!map) {
-		__free_pages(page, order);
-		return NULL;
+	/*
+	 * XXX: this doesn't seem to handle the sun3 MMU at all.
+	 */
+	if (CPU_IS_040_OR_060) {
+		pgprot_val(prot) &= ~_PAGE_CACHE040;
+		pgprot_val(prot) |= _PAGE_GLOBAL040 | _PAGE_NOCACHE_S;
+	} else {
+		pgprot_val(prot) |= _PAGE_NOCACHE030;
 	}
-	split_page(page, order);
-
-	order = 1 << order;
-	size >>= PAGE_SHIFT;
-	map[0] = page;
-	for (i = 1; i < size; i++)
-		map[i] = page + i;
-	for (; i < order; i++)
-		__free_page(page + i);
-	pgprot = __pgprot(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_DIRTY);
-	if (CPU_IS_040_OR_060)
-		pgprot_val(pgprot) |= _PAGE_GLOBAL040 | _PAGE_NOCACHE_S;
-	else
-		pgprot_val(pgprot) |= _PAGE_NOCACHE030;
-	addr = vmap(map, size, VM_MAP, pgprot);
-	kfree(map);
-
-	return addr;
+	return prot;
 }
-
-void arch_dma_free(struct device *dev, size_t size, void *addr,
-		dma_addr_t handle, unsigned long attrs)
-{
-	pr_debug("dma_free_coherent: %p, %x\n", addr, handle);
-	vfree(addr);
-}
-
 #else
 
 #include <asm/cacheflush.h>
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
