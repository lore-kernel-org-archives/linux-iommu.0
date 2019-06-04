Return-Path: <SRS0=MUIX=UD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3500DC282CE
	for <iommu@archiver.kernel.org>; Tue,  4 Jun 2019 06:55:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD9F24DB4
	for <iommu@archiver.kernel.org>; Tue,  4 Jun 2019 06:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QVjgP3Ut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD9F24DB4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8A6E5E0E;
	Tue,  4 Jun 2019 06:55:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7446CDDE
	for <iommu@lists.linux-foundation.org>;
	Tue,  4 Jun 2019 06:55:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A5E8719B
	for <iommu@lists.linux-foundation.org>;
	Tue,  4 Jun 2019 06:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wan4rbeY7cbGtXjCNpPv6QqnlnRBq+yu6GRnZJKpN4w=;
	b=QVjgP3Ut5uN1RLA2L2HZSgrbpo
	ki2bji0CcR+cbtIciJ9b5eOdvgWjhHFLw65t3e+uwOtD++ihzVNvqGPF0AyG4ur8pSHlUb6M4ebtp
	k4S3OpPx4ow75YhQz756J0ew6BChFrKJcWDSqFmagaXKplgdx2MLGivoDrCLV6uPMdY6AwM8Bq9lR
	XjupM3W73ZE5KsfDvP3/HKcbz3HhY5m94TlB5hUM8VQ56KA67MUCfZZP6gH7QZLQrrfHm+7syrBKf
	xdfHNSvpBlejwVFp1qEazE+OGRveWTdLV4Yk4w/VwUJ6TfbcOg1ZwM/9PbLhuGNhWJ6VbGSbapIqh
	nkp6Ii7g==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64]
	helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hY3Ll-0003V7-3j; Tue, 04 Jun 2019 06:55:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 2/3] dma-mapping: always use VM_DMA_COHERENT for generic DMA
	remap
Date: Tue,  4 Jun 2019 08:55:03 +0200
Message-Id: <20190604065504.25662-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604065504.25662-1-hch@lst.de>
References: <20190604065504.25662-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, linux-mm@kvack.org,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

Currently the generic dma remap allocator gets a vm_flags passed by
the caller that is a little confusing.  We just introduced a generic
vmalloc-level flag to identify the dma coherent allocations, so use
that everywhere and remove the now pointless argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mm/dma-mapping.c    | 37 +++++++-----------------------------
 arch/xtensa/kernel/pci-dma.c |  4 ++--
 drivers/iommu/dma-iommu.c    |  6 +++---
 include/linux/dma-mapping.h  |  6 ++----
 kernel/dma/remap.c           | 25 +++++++++++-------------
 5 files changed, 25 insertions(+), 53 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index e197b028e341..647fd25d2aba 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -356,19 +356,6 @@ static void *__alloc_remap_buffer(struct device *dev, size_t size, gfp_t gfp,
 				 pgprot_t prot, struct page **ret_page,
 				 const void *caller, bool want_vaddr);
 
-static void *
-__dma_alloc_remap(struct page *page, size_t size, gfp_t gfp, pgprot_t prot,
-	const void *caller)
-{
-	return dma_common_contiguous_remap(page, size, VM_DMA_COHERENT,
-			prot, caller);
-}
-
-static void __dma_free_remap(void *cpu_addr, size_t size)
-{
-	dma_common_free_remap(cpu_addr, size, VM_DMA_COHERENT);
-}
-
 #define DEFAULT_DMA_COHERENT_POOL_SIZE	SZ_256K
 static struct gen_pool *atomic_pool __ro_after_init;
 
@@ -525,7 +512,7 @@ static void *__alloc_remap_buffer(struct device *dev, size_t size, gfp_t gfp,
 	if (!want_vaddr)
 		goto out;
 
-	ptr = __dma_alloc_remap(page, size, gfp, prot, caller);
+	ptr = dma_common_contiguous_remap(page, size, gfp, prot, caller);
 	if (!ptr) {
 		__dma_free_buffer(page, size);
 		return NULL;
@@ -592,7 +579,8 @@ static void *__alloc_from_contiguous(struct device *dev, size_t size,
 		goto out;
 
 	if (PageHighMem(page)) {
-		ptr = __dma_alloc_remap(page, size, GFP_KERNEL, prot, caller);
+		ptr = dma_common_contiguous_remap(page, size, GFP_KERNEL, prot,
+				caller);
 		if (!ptr) {
 			dma_release_from_contiguous(dev, page, count);
 			return NULL;
@@ -612,7 +600,7 @@ static void __free_from_contiguous(struct device *dev, struct page *page,
 {
 	if (want_vaddr) {
 		if (PageHighMem(page))
-			__dma_free_remap(cpu_addr, size);
+			dma_common_free_remap(cpu_addr, size);
 		else
 			__dma_remap(page, size, PAGE_KERNEL);
 	}
@@ -704,7 +692,7 @@ static void *remap_allocator_alloc(struct arm_dma_alloc_args *args,
 static void remap_allocator_free(struct arm_dma_free_args *args)
 {
 	if (args->want_vaddr)
-		__dma_free_remap(args->cpu_addr, args->size);
+		dma_common_free_remap(args->cpu_addr, args->size);
 
 	__dma_free_buffer(args->page, args->size);
 }
@@ -1374,17 +1362,6 @@ static int __iommu_free_buffer(struct device *dev, struct page **pages,
 	return 0;
 }
 
-/*
- * Create a CPU mapping for a specified pages
- */
-static void *
-__iommu_alloc_remap(struct page **pages, size_t size, gfp_t gfp, pgprot_t prot,
-		    const void *caller)
-{
-	return dma_common_pages_remap(pages, size, VM_DMA_COHERENT, prot,
-			caller);
-}
-
 /*
  * Create a mapping in device IO address space for specified pages
  */
@@ -1541,7 +1518,7 @@ static void *__arm_iommu_alloc_attrs(struct device *dev, size_t size,
 	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING)
 		return pages;
 
-	addr = __iommu_alloc_remap(pages, size, gfp, prot,
+	addr = dma_common_pages_remap(pages, size, gfp, prot,
 				   __builtin_return_address(0));
 	if (!addr)
 		goto err_mapping;
@@ -1625,7 +1602,7 @@ void __arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
 	}
 
 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) == 0)
-		dma_common_free_remap(cpu_addr, size, VM_DMA_COHERENT);
+		dma_common_free_remap(cpu_addr, size);
 
 	__iommu_remove_mapping(dev, handle, size);
 	__iommu_free_buffer(dev, pages, size, attrs);
diff --git a/arch/xtensa/kernel/pci-dma.c b/arch/xtensa/kernel/pci-dma.c
index 9171bff76fc4..81c1def6b5a2 100644
--- a/arch/xtensa/kernel/pci-dma.c
+++ b/arch/xtensa/kernel/pci-dma.c
@@ -175,7 +175,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	if (PageHighMem(page)) {
 		void *p;
 
-		p = dma_common_contiguous_remap(page, size, VM_MAP,
+		p = dma_common_contiguous_remap(page, size,
 						pgprot_noncached(PAGE_KERNEL),
 						__builtin_return_address(0));
 		if (!p) {
@@ -202,7 +202,7 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 		page = virt_to_page(platform_vaddr_to_cached(vaddr));
 	} else {
 #ifdef CONFIG_MMU
-		dma_common_free_remap(vaddr, size, VM_MAP);
+		dma_common_free_remap(vaddr, size);
 #endif
 		page = pfn_to_page(PHYS_PFN(dma_to_phys(dev, dma_handle)));
 	}
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 0dee374fc64a..cea561897086 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -619,7 +619,7 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
 			< size)
 		goto out_free_sg;
 
-	vaddr = dma_common_pages_remap(pages, size, VM_USERMAP, prot,
+	vaddr = dma_common_pages_remap(pages, size, prot,
 			__builtin_return_address(0));
 	if (!vaddr)
 		goto out_unmap;
@@ -943,7 +943,7 @@ static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
 		pages = __iommu_dma_get_pages(cpu_addr);
 		if (!pages)
 			page = vmalloc_to_page(cpu_addr);
-		dma_common_free_remap(cpu_addr, alloc_size, VM_USERMAP);
+		dma_common_free_remap(cpu_addr, alloc_size);
 	} else {
 		/* Lowmem means a coherent atomic or CMA allocation */
 		page = virt_to_page(cpu_addr);
@@ -983,7 +983,7 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
 		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
 
 		cpu_addr = dma_common_contiguous_remap(page, alloc_size,
-				VM_USERMAP, prot, __builtin_return_address(0));
+				prot, __builtin_return_address(0));
 		if (!cpu_addr)
 			goto out_free_pages;
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 6309a721394b..ac320b7cacfd 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -616,13 +616,11 @@ extern int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 		unsigned long attrs);
 
 void *dma_common_contiguous_remap(struct page *page, size_t size,
-			unsigned long vm_flags,
 			pgprot_t prot, const void *caller);
 
 void *dma_common_pages_remap(struct page **pages, size_t size,
-			unsigned long vm_flags, pgprot_t prot,
-			const void *caller);
-void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags);
+			pgprot_t prot, const void *caller);
+void dma_common_free_remap(void *cpu_addr, size_t size);
 
 int __init dma_atomic_pool_init(gfp_t gfp, pgprot_t prot);
 bool dma_in_atomic_pool(void *start, size_t size);
diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index 7a723194ecbe..51958d21c810 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -12,12 +12,11 @@
 #include <linux/vmalloc.h>
 
 static struct vm_struct *__dma_common_pages_remap(struct page **pages,
-			size_t size, unsigned long vm_flags, pgprot_t prot,
-			const void *caller)
+			size_t size, pgprot_t prot, const void *caller)
 {
 	struct vm_struct *area;
 
-	area = get_vm_area_caller(size, vm_flags, caller);
+	area = get_vm_area_caller(size, VM_DMA_COHERENT, caller);
 	if (!area)
 		return NULL;
 
@@ -34,12 +33,11 @@ static struct vm_struct *__dma_common_pages_remap(struct page **pages,
  * Cannot be used in non-sleeping contexts
  */
 void *dma_common_pages_remap(struct page **pages, size_t size,
-			unsigned long vm_flags, pgprot_t prot,
-			const void *caller)
+			 pgprot_t prot, const void *caller)
 {
 	struct vm_struct *area;
 
-	area = __dma_common_pages_remap(pages, size, vm_flags, prot, caller);
+	area = __dma_common_pages_remap(pages, size, prot, caller);
 	if (!area)
 		return NULL;
 
@@ -53,7 +51,6 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
  * Cannot be used in non-sleeping contexts
  */
 void *dma_common_contiguous_remap(struct page *page, size_t size,
-			unsigned long vm_flags,
 			pgprot_t prot, const void *caller)
 {
 	int i;
@@ -67,7 +64,7 @@ void *dma_common_contiguous_remap(struct page *page, size_t size,
 	for (i = 0; i < (size >> PAGE_SHIFT); i++)
 		pages[i] = nth_page(page, i);
 
-	area = __dma_common_pages_remap(pages, size, vm_flags, prot, caller);
+	area = __dma_common_pages_remap(pages, size, prot, caller);
 
 	kfree(pages);
 
@@ -79,11 +76,11 @@ void *dma_common_contiguous_remap(struct page *page, size_t size,
 /*
  * Unmaps a range previously mapped by dma_common_*_remap
  */
-void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
+void dma_common_free_remap(void *cpu_addr, size_t size)
 {
 	struct vm_struct *area = find_vm_area(cpu_addr);
 
-	if (!area || (area->flags & vm_flags) != vm_flags) {
+	if (!area || area->flags != VM_DMA_COHERENT) {
 		WARN(1, "trying to free invalid coherent area: %p\n", cpu_addr);
 		return;
 	}
@@ -127,8 +124,8 @@ int __init dma_atomic_pool_init(gfp_t gfp, pgprot_t prot)
 	if (!atomic_pool)
 		goto free_page;
 
-	addr = dma_common_contiguous_remap(page, atomic_pool_size, VM_USERMAP,
-					   prot, __builtin_return_address(0));
+	addr = dma_common_contiguous_remap(page, atomic_pool_size, prot,
+					   __builtin_return_address(0));
 	if (!addr)
 		goto destroy_genpool;
 
@@ -143,7 +140,7 @@ int __init dma_atomic_pool_init(gfp_t gfp, pgprot_t prot)
 	return 0;
 
 remove_mapping:
-	dma_common_free_remap(addr, atomic_pool_size, VM_USERMAP);
+	dma_common_free_remap(addr, atomic_pool_size);
 destroy_genpool:
 	gen_pool_destroy(atomic_pool);
 	atomic_pool = NULL;
@@ -220,7 +217,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	}
 
 	/* create a coherent mapping */
-	ret = dma_common_contiguous_remap(page, size, VM_USERMAP,
+	ret = dma_common_contiguous_remap(page, size,
 			arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs),
 			__builtin_return_address(0));
 	if (!ret) {
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
