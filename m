Return-Path: <SRS0=GORt=TB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731ADC43219
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 13:14:23 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4991221670
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 13:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4991221670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F3C1E2718;
	Wed,  1 May 2019 13:14:22 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 49DE7270A
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 13:13:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 61F8D189
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 13:13:57 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 6CF0168AFE; Wed,  1 May 2019 15:13:39 +0200 (CEST)
Date: Wed, 1 May 2019 15:13:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Paul Burton <paul.burton@mips.com>
Subject: [PATCH 5/7 v2] MIPS: use the generic uncached segment support in
	dma-direct
Message-ID: <20190501131339.GA890@lst.de>
References: <20190430110032.25301-1-hch@lst.de>
	<20190430110032.25301-6-hch@lst.de>
	<20190430201041.536amvinrcvd2wua@pburton-laptop>
	<20190430202947.GA30262@lst.de>
	<20190430211105.ielntedm46uqamca@pburton-laptop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190430211105.ielntedm46uqamca@pburton-laptop>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Michal Simek <monstr@monstr.eu>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	James Hogan <jhogan@kernel.org>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	Ley Foon Tan <lftan@altera.com>, Christoph Hellwig <hch@lst.de>
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
Message-ID: <20190501131339.tuG3xJ3dhKxB-uNwsAEwnQId7aoGG9PCqf98KyMVRZc@z>

Stop providing our arch alloc/free hooks and just expose the segment
offset instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/Kconfig              |  1 +
 arch/mips/include/asm/page.h   |  3 ---
 arch/mips/jazz/jazzdma.c       |  6 ------
 arch/mips/mm/dma-noncoherent.c | 26 +++++++++-----------------
 4 files changed, 10 insertions(+), 26 deletions(-)

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
index f9549d2fbea3..ed56c6fa7be2 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -44,33 +44,25 @@ static inline bool cpu_needs_post_dma_flush(struct device *dev)
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
+	dma_cache_wback_inv((unsigned long)page_address(page), size);
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
