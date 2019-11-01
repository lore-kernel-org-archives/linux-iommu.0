Return-Path: <SRS0=gESx=YZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8D0CA9ECF
	for <iommu@archiver.kernel.org>; Fri,  1 Nov 2019 22:02:41 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DF4B2085B
	for <iommu@archiver.kernel.org>; Fri,  1 Nov 2019 22:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lcGtymzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF4B2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EB08FF29;
	Fri,  1 Nov 2019 22:02:40 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 690ACF11
	for <iommu@lists.linux-foundation.org>;
	Fri,  1 Nov 2019 22:02:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5D34514D
	for <iommu@lists.linux-foundation.org>;
	Fri,  1 Nov 2019 22:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VHX0lBK4JWj4/5wEyIt7Atd1gyaPnwjo1FUgBvf1kWA=;
	b=lcGtymzS7KCkAV9enGQCkg+pB7
	/6x96SdTdKZyQgEUr51Orj4LrxCVSrTy1Ma5c6PAS+oYaNuIWNpTMpa3p7esYZtlmPBWmPIFwdYIG
	r7mFfE49Wm9KQl8CJi2tXOG5C8xr7shAcfHRE/NHaDJBXBahQvUKM9ucdmar/O+YQD0FjmOlTIkrw
	p2M25NXQlNj3FOVWxabEBxuuYOaHcGUCPo/VefY414j8C32GcuTEXt0pVQVgzsw0SmJ25og1c+lH5
	+Pv1nYnLaqVitb+pYNeL6FfA0GOdEzxEbol25BK/b12+qbfuus+JSD4eb7PUA9mGuoRbm3KzcIBbD
	TyRfxDQA==;
Received: from [199.255.44.128] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iQf0A-0004Gz-Md; Fri, 01 Nov 2019 22:02:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: Max Filippov <jcmvbkbc@gmail.com>, Chris Zankel <chris@zankel.net>,
	iommu@lists.linux-foundation.org
Subject: [PATCH 3/5] dma-direct: provide mmap and get_sgtable method overrides
Date: Fri,  1 Nov 2019 15:02:11 -0700
Message-Id: <20191101220213.28949-4-hch@lst.de>
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

For dma-direct we know that the DMA address is an encoding of the
physical address that we can trivially decode.  Use that fact to
provide implementations that do not need the arch_dma_coherent_to_pfn
architecture hook.  Note that we still can only support mmap of
non-coherent memory only if the architecture provides a way to set an
uncached bit in the page tables.  This must be true for architectures
that use the generic remap helpers, but other architectures can also
manually select it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arc/Kconfig                       |  1 -
 arch/arm/Kconfig                       |  1 -
 arch/arm/mm/dma-mapping.c              |  6 ---
 arch/arm64/Kconfig                     |  1 -
 arch/ia64/Kconfig                      |  2 +-
 arch/ia64/kernel/dma-mapping.c         |  6 ---
 arch/microblaze/Kconfig                |  1 -
 arch/mips/Kconfig                      |  4 +-
 arch/mips/mm/dma-noncoherent.c         |  6 ---
 arch/powerpc/platforms/Kconfig.cputype |  1 -
 include/linux/dma-direct.h             |  7 +++
 include/linux/dma-noncoherent.h        |  2 -
 kernel/dma/Kconfig                     | 12 ++++--
 kernel/dma/direct.c                    | 59 ++++++++++++++++++++++++++
 kernel/dma/mapping.c                   | 45 +++-----------------
 kernel/dma/remap.c                     |  6 ---
 16 files changed, 85 insertions(+), 75 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 8383155c8c82..4d7b671c8ff4 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -6,7 +6,6 @@
 config ARC
 	def_bool y
 	select ARC_TIMERS
-	select ARCH_HAS_DMA_COHERENT_TO_PFN
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SETUP_DMA_OPS
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8a50efb559f3..80e795aacd3a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -7,7 +7,6 @@ config ARM
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
-	select ARCH_HAS_DMA_COHERENT_TO_PFN if SWIOTLB
 	select ARCH_HAS_DMA_WRITE_COMBINE if !ARM_DMA_MEM_BUFFERABLE
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FORTIFY_SOURCE
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 7d042d5c43e3..f3cbeba7f9cb 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2346,12 +2346,6 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
 			      size, dir);
 }
 
-long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
-		dma_addr_t dma_addr)
-{
-	return dma_to_pfn(dev, dma_addr);
-}
-
 void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs)
 {
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3f047afb982c..57606307fe34 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -12,7 +12,6 @@ config ARM64
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
-	select ARCH_HAS_DMA_COHERENT_TO_PFN
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
 	select ARCH_HAS_FAST_MULTIPLIER
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 16714477eef4..bab7cd878464 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -33,7 +33,7 @@ config IA64
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_VIRT_CPU_ACCOUNTING
-	select ARCH_HAS_DMA_COHERENT_TO_PFN
+	select DMA_NONCOHERENT_MMAP
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select VIRT_TO_BUS
 	select GENERIC_IRQ_PROBE
diff --git a/arch/ia64/kernel/dma-mapping.c b/arch/ia64/kernel/dma-mapping.c
index 4a3262795890..09ef9ce9988d 100644
--- a/arch/ia64/kernel/dma-mapping.c
+++ b/arch/ia64/kernel/dma-mapping.c
@@ -19,9 +19,3 @@ void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
 {
 	dma_direct_free_pages(dev, size, cpu_addr, dma_addr, attrs);
 }
-
-long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
-		dma_addr_t dma_addr)
-{
-	return page_to_pfn(virt_to_page(cpu_addr));
-}
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index c9c4be822456..261c26df1c9f 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -4,7 +4,6 @@ config MICROBLAZE
 	select ARCH_32BIT_OFF_T
 	select ARCH_NO_SWAP
 	select ARCH_HAS_BINFMT_FLAT if !MMU
-	select ARCH_HAS_DMA_COHERENT_TO_PFN if MMU
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a0bd9bdb5f83..248d39b8a160 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1134,9 +1134,9 @@ config DMA_NONCOHERENT
 	select ARCH_HAS_DMA_WRITE_COMBINE
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_HAS_UNCACHED_SEGMENT
-	select NEED_DMA_MAP_STATE
-	select ARCH_HAS_DMA_COHERENT_TO_PFN
+	select DMA_NONCOHERENT_MMAP
 	select DMA_NONCOHERENT_CACHE_SYNC
+	select NEED_DMA_MAP_STATE
 
 config SYS_HAS_EARLY_PRINTK
 	bool
diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
index 1d4d57dd9acf..fcf6d3eaac66 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -59,12 +59,6 @@ void *cached_kernel_address(void *addr)
 	return __va(addr) - UNCAC_BASE;
 }
 
-long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
-		dma_addr_t dma_addr)
-{
-	return page_to_pfn(virt_to_page(cached_kernel_address(cpu_addr)));
-}
-
 static inline void dma_sync_virt(void *addr, size_t size,
 		enum dma_data_direction dir)
 {
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 12543e53fa96..303752f97c19 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -459,7 +459,6 @@ config NOT_COHERENT_CACHE
 	bool
 	depends on 4xx || PPC_8xx || E200 || PPC_MPC512x || \
 		GAMECUBE_COMMON || AMIGAONE
-	select ARCH_HAS_DMA_COHERENT_TO_PFN
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index ff3d5edc44b9..bcd953fb1f5a 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -68,5 +68,12 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs);
 struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 		gfp_t gfp, unsigned long attrs);
+int dma_direct_get_sgtable(struct device *dev, struct sg_table *sgt,
+		void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		unsigned long attrs);
+bool dma_direct_can_mmap(struct device *dev);
+int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
+		void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		unsigned long attrs);
 int dma_direct_supported(struct device *dev, u64 mask);
 #endif /* _LINUX_DMA_DIRECT_H */
diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
index dd3de6d88fc0..e30fca1f1b12 100644
--- a/include/linux/dma-noncoherent.h
+++ b/include/linux/dma-noncoherent.h
@@ -41,8 +41,6 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs);
 void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs);
-long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
-		dma_addr_t dma_addr);
 
 #ifdef CONFIG_MMU
 /*
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 73c5c2b8e824..4c103a24e380 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -51,9 +51,6 @@ config ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
 config ARCH_HAS_DMA_PREP_COHERENT
 	bool
 
-config ARCH_HAS_DMA_COHERENT_TO_PFN
-	bool
-
 config ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	bool
 
@@ -68,9 +65,18 @@ config SWIOTLB
 	bool
 	select NEED_DMA_MAP_STATE
 
+#
+# Should be selected if we can mmap non-coherent mappings to userspace.
+# The only thing that is really required is a way to set an uncached bit
+# in the pagetables
+#
+config DMA_NONCOHERENT_MMAP
+	bool
+
 config DMA_REMAP
 	depends on MMU
 	select GENERIC_ALLOCATOR
+	select DMA_NONCOHERENT_MMAP
 	bool
 
 config DMA_DIRECT_REMAP
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 724c282dd943..d8b612648a6b 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -43,6 +43,12 @@ static inline dma_addr_t phys_to_dma_direct(struct device *dev,
 	return phys_to_dma(dev, phys);
 }
 
+static inline struct page *dma_direct_to_page(struct device *dev,
+		dma_addr_t dma_addr)
+{
+	return pfn_to_page(__phys_to_pfn(dma_to_phys(dev, dma_addr)));
+}
+
 u64 dma_direct_get_required_mask(struct device *dev)
 {
 	u64 max_dma = phys_to_dma_direct(dev, (max_pfn - 1) << PAGE_SHIFT);
@@ -379,6 +385,59 @@ dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
 }
 EXPORT_SYMBOL(dma_direct_map_resource);
 
+int dma_direct_get_sgtable(struct device *dev, struct sg_table *sgt,
+		void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		unsigned long attrs)
+{
+	struct page *page = dma_direct_to_page(dev, dma_addr);
+	int ret;
+
+	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
+	if (!ret)
+		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
+	return ret;
+}
+
+#ifdef CONFIG_MMU
+bool dma_direct_can_mmap(struct device *dev)
+{
+	return dev_is_dma_coherent(dev) ||
+		IS_ENABLED(CONFIG_DMA_NONCOHERENT_MMAP);
+}
+
+int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
+		void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		unsigned long attrs)
+{
+	unsigned long user_count = vma_pages(vma);
+	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	unsigned long pfn = __phys_to_pfn(dma_to_phys(dev, dma_addr));
+	int ret = -ENXIO;
+
+	vma->vm_page_prot = dma_pgprot(dev, vma->vm_page_prot, attrs);
+
+	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
+		return ret;
+
+	if (vma->vm_pgoff >= count || user_count > count - vma->vm_pgoff)
+		return -ENXIO;
+	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
+			user_count << PAGE_SHIFT, vma->vm_page_prot);
+}
+#else /* CONFIG_MMU */
+bool dma_direct_can_mmap(struct device *dev)
+{
+	return false;
+}
+
+int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
+		void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		unsigned long attrs)
+{
+	return -ENXIO;
+}
+#endif /* CONFIG_MMU */
+
 /*
  * Because 32-bit DMA masks are so common we expect every architecture to be
  * able to satisfy them - either by not supporting more physical memory, or by
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index d9334f31a5af..12ff766ec1fa 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -112,24 +112,9 @@ int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
 		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		 unsigned long attrs)
 {
-	struct page *page;
+	struct page *page = virt_to_page(cpu_addr);
 	int ret;
 
-	if (!dev_is_dma_coherent(dev)) {
-		unsigned long pfn;
-
-		if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_COHERENT_TO_PFN))
-			return -ENXIO;
-
-		/* If the PFN is not valid, we do not have a struct page */
-		pfn = arch_dma_coherent_to_pfn(dev, cpu_addr, dma_addr);
-		if (!pfn_valid(pfn))
-			return -ENXIO;
-		page = pfn_to_page(pfn);
-	} else {
-		page = virt_to_page(cpu_addr);
-	}
-
 	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
 	if (!ret)
 		sg_set_page(sgt->sgl, page, PAGE_ALIGN(size), 0);
@@ -154,7 +139,7 @@ int dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	if (dma_is_direct(ops))
-		return dma_common_get_sgtable(dev, sgt, cpu_addr, dma_addr,
+		return dma_direct_get_sgtable(dev, sgt, cpu_addr, dma_addr,
 				size, attrs);
 	if (!ops->get_sgtable)
 		return -ENXIO;
@@ -192,7 +177,6 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 	unsigned long user_count = vma_pages(vma);
 	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long off = vma->vm_pgoff;
-	unsigned long pfn;
 	int ret = -ENXIO;
 
 	vma->vm_page_prot = dma_pgprot(dev, vma->vm_page_prot, attrs);
@@ -203,19 +187,8 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 	if (off >= count || user_count > count - off)
 		return -ENXIO;
 
-	if (!dev_is_dma_coherent(dev)) {
-		if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_COHERENT_TO_PFN))
-			return -ENXIO;
-
-		/* If the PFN is not valid, we do not have a struct page */
-		pfn = arch_dma_coherent_to_pfn(dev, cpu_addr, dma_addr);
-		if (!pfn_valid(pfn))
-			return -ENXIO;
-	} else {
-		pfn = page_to_pfn(virt_to_page(cpu_addr));
-	}
-
-	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
+	return remap_pfn_range(vma, vma->vm_start,
+			page_to_pfn(virt_to_page(cpu_addr)) + vma->vm_pgoff,
 			user_count << PAGE_SHIFT, vma->vm_page_prot);
 #else
 	return -ENXIO;
@@ -233,12 +206,8 @@ bool dma_can_mmap(struct device *dev)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
-	if (dma_is_direct(ops)) {
-		return IS_ENABLED(CONFIG_MMU) &&
-		       (dev_is_dma_coherent(dev) ||
-			IS_ENABLED(CONFIG_ARCH_HAS_DMA_COHERENT_TO_PFN));
-	}
-
+	if (dma_is_direct(ops))
+		return dma_direct_can_mmap(dev);
 	return ops->mmap != NULL;
 }
 EXPORT_SYMBOL_GPL(dma_can_mmap);
@@ -263,7 +232,7 @@ int dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	if (dma_is_direct(ops))
-		return dma_common_mmap(dev, vma, cpu_addr, dma_addr, size,
+		return dma_direct_mmap(dev, vma, cpu_addr, dma_addr, size,
 				attrs);
 	if (!ops->mmap)
 		return -ENXIO;
diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index 90d5ce77c189..3c49499ee6b0 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -259,10 +259,4 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 		dma_free_contiguous(dev, page, size);
 	}
 }
-
-long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
-		dma_addr_t dma_addr)
-{
-	return __phys_to_pfn(dma_to_phys(dev, dma_addr));
-}
 #endif /* CONFIG_DMA_DIRECT_REMAP */
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
