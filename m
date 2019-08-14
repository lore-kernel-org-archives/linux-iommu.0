Return-Path: <SRS0=gZYu=WK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032F6C32757
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 14:04:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C913B208C2
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 14:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="brBZ+XeP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C913B208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A3F45E76;
	Wed, 14 Aug 2019 14:03:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 07CEEE70
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 14:03:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8A228711
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 14:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=L1vfKJTJmmcyEyb0NSklvmfYo+Tqp26qCC9B9AM+osk=;
	b=brBZ+XePlXbr56qi5de4obB8Y4
	qgvSIzD2FaM0BJFHsclGrNe0DEGUuEDB2nFolpKlivBP5wgY94edU62/YrmVts1sK08iKcuSQJmzo
	m4gXMxCQ0kKDyBYZ48yZ8ZxGOs/qrzRu7vPXkgw5FbXKdwf+hywRh58shrTVpfEByx8erj5AXxlCG
	G4TUD24GjIuDLN08eqAwcNhIh/zMbEpzACFISWldfhFgWdKPBawrzPyAC5cGNBoe4Z0Mpj7o7E7M+
	susdLDRbs8sYK2eTsc+njSYyfQN7Bj5FyoywDa0rdR3K8mioKbwI0O2vx1+IhOzNOMlkB66G7jzgi
	BzfVEEfw==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
	id 1hxtsa-00013N-Rr; Wed, 14 Aug 2019 14:03:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: Michal Simek <monstr@monstr.eu>
Subject: [PATCH 2/2] microblaze: use the generic dma coherent remap allocator
Date: Wed, 14 Aug 2019 16:03:48 +0200
Message-Id: <20190814140348.3339-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814140348.3339-1-hch@lst.de>
References: <20190814140348.3339-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

This switches to using common code for the DMA allocations, including
potential use of the CMA allocator if configured.

Switching to the generic code enables DMA allocations from atomic
context, which is required by the DMA API documentation, and also
adds various other minor features drivers start relying upon.  It
also makes sure we have on tested code base for all architectures
that require uncached pte bits for coherent DMA allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/microblaze/Kconfig         |   1 +
 arch/microblaze/mm/consistent.c | 152 +-------------------------------
 2 files changed, 5 insertions(+), 148 deletions(-)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index a0d749c309f3..e477896fbae6 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -17,6 +17,7 @@ config MICROBLAZE
 	select TIMER_OF
 	select CLONE_BACKWARDS3
 	select COMMON_CLK
+	select DMA_DIRECT_REMAP if MMU
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CPU_DEVICES
diff --git a/arch/microblaze/mm/consistent.c b/arch/microblaze/mm/consistent.c
index 1a859e8b58c2..0e0f733eb846 100644
--- a/arch/microblaze/mm/consistent.c
+++ b/arch/microblaze/mm/consistent.c
@@ -4,43 +4,16 @@
  * Copyright (C) 2010 Michal Simek <monstr@monstr.eu>
  * Copyright (C) 2010 PetaLogix
  * Copyright (C) 2005 John Williams <jwilliams@itee.uq.edu.au>
- *
- * Based on PowerPC version derived from arch/arm/mm/consistent.c
- * Copyright (C) 2001 Dan Malek (dmalek@jlc.net)
- * Copyright (C) 2000 Russell King
  */
 
-#include <linux/export.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
 #include <linux/kernel.h>
-#include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/types.h>
-#include <linux/ptrace.h>
-#include <linux/mman.h>
 #include <linux/mm.h>
-#include <linux/swap.h>
-#include <linux/stddef.h>
-#include <linux/vmalloc.h>
 #include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/memblock.h>
-#include <linux/highmem.h>
-#include <linux/pci.h>
-#include <linux/interrupt.h>
-#include <linux/gfp.h>
 #include <linux/dma-noncoherent.h>
-
-#include <asm/pgalloc.h>
-#include <linux/io.h>
-#include <linux/hardirq.h>
-#include <linux/mmu_context.h>
-#include <asm/mmu.h>
-#include <linux/uaccess.h>
-#include <asm/pgtable.h>
 #include <asm/cpuinfo.h>
-#include <asm/tlbflush.h>
+#include <asm/cacheflush.h>
 
 void arch_dma_prep_coherent(struct page *page, size_t size)
 {
@@ -84,126 +57,9 @@ void *cached_kernel_address(void *ptr)
 	return (void *)(addr & ~UNCACHED_SHADOW_MASK);
 }
 #else /* CONFIG_MMU */
-void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
-		gfp_t gfp, unsigned long attrs)
-{
-	unsigned long order, vaddr;
-	void *ret;
-	unsigned int i, err = 0;
-	struct page *page, *end;
-	phys_addr_t pa;
-	struct vm_struct *area;
-	unsigned long va;
-
-	if (in_interrupt())
-		BUG();
-
-	/* Only allocate page size areas. */
-	size = PAGE_ALIGN(size);
-	order = get_order(size);
-
-	vaddr = __get_free_pages(gfp | __GFP_ZERO, order);
-	if (!vaddr)
-		return NULL;
-
-	/*
-	 * we need to ensure that there are no cachelines in use,
-	 * or worse dirty in this area.
-	 */
-	arch_dma_prep_coherent(virt_to_page((unsigned long)vaddr), size);
-
-	/* Allocate some common virtual space to map the new pages. */
-	area = get_vm_area(size, VM_ALLOC);
-	if (!area) {
-		free_pages(vaddr, order);
-		return NULL;
-	}
-	va = (unsigned long) area->addr;
-	ret = (void *)va;
-
-	/* This gives us the real physical address of the first page. */
-	*dma_handle = pa = __virt_to_phys(vaddr);
-
-	/*
-	 * free wasted pages.  We skip the first page since we know
-	 * that it will have count = 1 and won't require freeing.
-	 * We also mark the pages in use as reserved so that
-	 * remap_page_range works.
-	 */
-	page = virt_to_page(vaddr);
-	end = page + (1 << order);
-
-	split_page(page, order);
-
-	for (i = 0; i < size && err == 0; i += PAGE_SIZE) {
-		/* MS: This is the whole magic - use cache inhibit pages */
-		err = map_page(va + i, pa + i, _PAGE_KERNEL | _PAGE_NO_CACHE);
-
-		SetPageReserved(page);
-		page++;
-	}
-
-	/* Free the otherwise unused pages. */
-	while (page < end) {
-		__free_page(page);
-		page++;
-	}
-
-	if (err) {
-		free_pages(vaddr, order);
-		return NULL;
-	}
-
-	return ret;
-}
-
-static pte_t *consistent_virt_to_pte(void *vaddr)
-{
-	unsigned long addr = (unsigned long)vaddr;
-
-	return pte_offset_kernel(pmd_offset(pgd_offset_k(addr), addr), addr);
-}
-
-long arch_dma_coherent_to_pfn(struct device *dev, void *vaddr,
-		dma_addr_t dma_addr)
+static int __init atomic_pool_init(void)
 {
-	pte_t *ptep = consistent_virt_to_pte(vaddr);
-
-	if (pte_none(*ptep) || !pte_present(*ptep))
-		return 0;
-
-	return pte_pfn(*ptep);
-}
-
-/*
- * free page(s) as defined by the above mapping.
- */
-void arch_dma_free(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t dma_addr, unsigned long attrs)
-{
-	struct page *page;
-
-	if (in_interrupt())
-		BUG();
-
-	size = PAGE_ALIGN(size);
-
-	do {
-		pte_t *ptep = consistent_virt_to_pte(vaddr);
-		unsigned long pfn;
-
-		if (!pte_none(*ptep) && pte_present(*ptep)) {
-			pfn = pte_pfn(*ptep);
-			pte_clear(&init_mm, (unsigned int)vaddr, ptep);
-			if (pfn_valid(pfn)) {
-				page = pfn_to_page(pfn);
-				__free_reserved_page(page);
-			}
-		}
-		vaddr += PAGE_SIZE;
-	} while (size -= PAGE_SIZE);
-
-	/* flush tlb */
-	flush_tlb_all();
+	return dma_atomic_pool_init(GFP_KERNEL, pgprot_noncached(PAGE_KERNEL));
 }
+postcore_initcall(atomic_pool_init);
 #endif /* CONFIG_MMU */
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
