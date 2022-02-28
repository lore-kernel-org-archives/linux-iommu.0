Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161FEC433F5
	for <iommu@archiver.kernel.org>; Mon, 28 Feb 2022 12:22:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B07E44090B;
	Mon, 28 Feb 2022 12:22:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5P9I_kG_nAtO; Mon, 28 Feb 2022 12:22:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 638B0408CA;
	Mon, 28 Feb 2022 12:22:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47B71C0033;
	Mon, 28 Feb 2022 12:22:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6067BC001A
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 12:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4D7E940275
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 12:22:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WVR9f9FQdouS for <iommu@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 12:22:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B2A2240012
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 12:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=xpRzNym3LsY5nRIvzwNRw6/4XtU7jP5KpqP7Ea6YLTg=; b=eNyDByh6x+wTCv1YMV7eZKFGmp
 Ys9ClGvGIGVBZQ1cG37XqyXPQFqP5VApuetxl7RPlc2rDvDeEnNIHc9W03bSQoilInoWRmaG9DSYF
 /xVO0UdVykk269zwwmAccjLO2SvfY+U5IpXwtABFmX77e0g3IelSu6ON4juiHSZP0URdPH0FPgFhP
 G/eyNDcvz2XpuXnCt8Cjqe9H+QXly5Uqpg+/7q9xnzgUAR/h/a/fvKwC9NgOJuaxtUqaT9vPtgboB
 +Mgih1OAKjjihsH3Fkv3DcR2DekTfqFFIYCfOiZt4mF9VhQ0izWqryO6Clunyv2lJSkpnM+CAjCKM
 5rxGxHoA==;
Received: from [2.53.163.181] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nOf2j-00C9v3-N5; Mon, 28 Feb 2022 12:22:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2] dma-mapping: remove CONFIG_DMA_REMAP
Date: Mon, 28 Feb 2022 14:22:18 +0200
Message-Id: <20220228122218.853094-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: will@kernel.org, x86@kernel.org, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CONFIG_DMA_REMAP is used to build a few helpers around the core
vmalloc code, and to use them in case there is a highmem page in
dma-direct, and to make dma coherent allocations be able to use
non-contiguous pages allocations for DMA allocations in the dma-iommu
layer.

Right now it needs to be explicitly selected by architectures, and
is only done so by architectures that require remapping to deal
with devices that are not DMA coherent.  Make it unconditional for
builds with CONFIG_MMU as it is very little extra code, but makes
it much more likely that large DMA allocations succeed on x86.

This fixes hot plugging a NVMe thunderbolt SSD for me, which tries
to allocate a 1MB buffer that is otherwise hard to obtain due to
memory fragmentation on a heavily used laptop.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---

Changes since v1:
 - drop a not required CONFIG_MMU check

 arch/arm/Kconfig          |  2 +-
 arch/xtensa/Kconfig       |  2 +-
 drivers/iommu/dma-iommu.c | 14 +++++---------
 kernel/dma/Kconfig        |  7 +------
 kernel/dma/Makefile       |  2 +-
 kernel/dma/direct.c       | 18 +++++++-----------
 6 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4c97cb40eebb6..83fb277e50759 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -47,7 +47,7 @@ config ARM
 	select DMA_DECLARE_COHERENT
 	select DMA_GLOBAL_POOL if !MMU
 	select DMA_OPS
-	select DMA_REMAP if MMU
+	select DMA_NONCOHERENT_MMAP if MMU
 	select EDAC_SUPPORT
 	select EDAC_ATOMIC_SCRUB
 	select GENERIC_ALLOCATOR
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 8ac599aa6d994..76438ee313d16 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -17,7 +17,7 @@ config XTENSA
 	select BUILDTIME_TABLE_SORT
 	select CLONE_BACKWARDS
 	select COMMON_CLK
-	select DMA_REMAP if MMU
+	select DMA_NONCOHERENT_MMAP if MMU
 	select GENERIC_ATOMIC64
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PCI_IOMAP
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d85d54f2b5496..cebced7ddf390 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -852,7 +852,6 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
 	return NULL;
 }
 
-#ifdef CONFIG_DMA_REMAP
 static struct sg_table *iommu_dma_alloc_noncontiguous(struct device *dev,
 		size_t size, enum dma_data_direction dir, gfp_t gfp,
 		unsigned long attrs)
@@ -882,7 +881,6 @@ static void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
 	sg_free_table(&sh->sgt);
 	kfree(sh);
 }
-#endif /* CONFIG_DMA_REMAP */
 
 static void iommu_dma_sync_single_for_cpu(struct device *dev,
 		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
@@ -1276,7 +1274,7 @@ static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
 	    dma_free_from_pool(dev, cpu_addr, alloc_size))
 		return;
 
-	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
+	if (is_vmalloc_addr(cpu_addr)) {
 		/*
 		 * If it the address is remapped, then it's either non-coherent
 		 * or highmem CMA, or an iommu_dma_alloc_remap() construction.
@@ -1318,7 +1316,7 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
 	if (!page)
 		return NULL;
 
-	if (IS_ENABLED(CONFIG_DMA_REMAP) && (!coherent || PageHighMem(page))) {
+	if (!coherent || PageHighMem(page)) {
 		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
 
 		cpu_addr = dma_common_contiguous_remap(page, alloc_size,
@@ -1350,7 +1348,7 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 
 	gfp |= __GFP_ZERO;
 
-	if (IS_ENABLED(CONFIG_DMA_REMAP) && gfpflags_allow_blocking(gfp) &&
+	if (gfpflags_allow_blocking(gfp) &&
 	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS)) {
 		return iommu_dma_alloc_remap(dev, size, handle, gfp,
 				dma_pgprot(dev, PAGE_KERNEL, attrs), attrs);
@@ -1391,7 +1389,7 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	if (off >= nr_pages || vma_pages(vma) > nr_pages - off)
 		return -ENXIO;
 
-	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
+	if (is_vmalloc_addr(cpu_addr)) {
 		struct page **pages = dma_common_find_pages(cpu_addr);
 
 		if (pages)
@@ -1413,7 +1411,7 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 	struct page *page;
 	int ret;
 
-	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
+	if (is_vmalloc_addr(cpu_addr)) {
 		struct page **pages = dma_common_find_pages(cpu_addr);
 
 		if (pages) {
@@ -1445,10 +1443,8 @@ static const struct dma_map_ops iommu_dma_ops = {
 	.free			= iommu_dma_free,
 	.alloc_pages		= dma_common_alloc_pages,
 	.free_pages		= dma_common_free_pages,
-#ifdef CONFIG_DMA_REMAP
 	.alloc_noncontiguous	= iommu_dma_alloc_noncontiguous,
 	.free_noncontiguous	= iommu_dma_free_noncontiguous,
-#endif
 	.mmap			= iommu_dma_mmap,
 	.get_sgtable		= iommu_dma_get_sgtable,
 	.map_page		= iommu_dma_map_page,
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 1b02179758cbc..56866aaa2ae1a 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -110,15 +110,10 @@ config DMA_GLOBAL_POOL
 	select DMA_DECLARE_COHERENT
 	bool
 
-config DMA_REMAP
-	bool
-	depends on MMU
-	select DMA_NONCOHERENT_MMAP
-
 config DMA_DIRECT_REMAP
 	bool
-	select DMA_REMAP
 	select DMA_COHERENT_POOL
+	select DMA_NONCOHERENT_MMAP
 
 config DMA_CMA
 	bool "DMA Contiguous Memory Allocator"
diff --git a/kernel/dma/Makefile b/kernel/dma/Makefile
index 0dd65ec1d234b..21926e46ef4fb 100644
--- a/kernel/dma/Makefile
+++ b/kernel/dma/Makefile
@@ -8,5 +8,5 @@ obj-$(CONFIG_DMA_DECLARE_COHERENT)	+= coherent.o
 obj-$(CONFIG_DMA_API_DEBUG)		+= debug.o
 obj-$(CONFIG_SWIOTLB)			+= swiotlb.o
 obj-$(CONFIG_DMA_COHERENT_POOL)		+= pool.o
-obj-$(CONFIG_DMA_REMAP)			+= remap.o
+obj-$(CONFIG_MMU)			+= remap.o
 obj-$(CONFIG_DMA_MAP_BENCHMARK)		+= map_benchmark.o
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 50f48e9e45987..35a1d29d6a2e9 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -265,17 +265,13 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO);
 	if (!page)
 		return NULL;
+
+	/*
+	 * dma_alloc_contiguous can return highmem pages depending on a
+	 * combination the cma= arguments and per-arch setup.  These need to be
+	 * remapped to return a kernel virtual address.
+	 */
 	if (PageHighMem(page)) {
-		/*
-		 * Depending on the cma= arguments and per-arch setup,
-		 * dma_alloc_contiguous could return highmem pages.
-		 * Without remapping there is no way to return them here, so
-		 * log an error and fail.
-		 */
-		if (!IS_ENABLED(CONFIG_DMA_REMAP)) {
-			dev_info(dev, "Rejecting highmem page from CMA.\n");
-			goto out_free_pages;
-		}
 		remap = true;
 		set_uncached = false;
 	}
@@ -349,7 +345,7 @@ void dma_direct_free(struct device *dev, size_t size,
 	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
 		return;
 
-	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
+	if (is_vmalloc_addr(cpu_addr)) {
 		vunmap(cpu_addr);
 	} else {
 		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
