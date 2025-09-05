Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38591276058;
	Fri,  5 Sep 2025 05:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757051717; cv=none; b=HRU8I+6EOoCOmLcZI31k7sIq88ofOcVUZCdEECB8Lq/rHZbgwYwEMLuH+//CHXhM70GCQx/86U6GmmmD7RkFbtVtNHvLqimv/hX2KtnGDavau/aD1Imwvi329sU+bc0dJi/9qsft/Ov6Jl7qwcDJrB6Dm1Q1A/ejJx7w5TCpraY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757051717; c=relaxed/simple;
	bh=quEC19ZxgUeJXx79wcBvlvqngcPi9GwTCMd7RvLB2mA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UksaT1eCZl9SavkAxmMy1J1ycNdzurAS7DWm/VRVju2kmYS3aWXEdFuNS1hC0Jt7GunQbyls/kB9QeGCIEqbyXONB0pvVJzojaXbGRAYK+YM3xeTp0jWWBTrg5OkduHRcgPJjufp+Sk1yeDPJ/8jTjI801+pokLLgUgXN/p16bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPXLF8YQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPXLF8YQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D90C4CEF1;
	Fri,  5 Sep 2025 05:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757051715;
	bh=quEC19ZxgUeJXx79wcBvlvqngcPi9GwTCMd7RvLB2mA=;
	h=From:To:Cc:Subject:Date:From;
	b=sPXLF8YQh1QCUw91whzXh4gkLPpE257+B5rX7YB29qH8a9Gjy5aeAcKdhxFJqKJU6
	 HiiTM+EGyurRfDe8ZdgQ8qelXGmzz8W/dzIsgw1i/hSt8aGJNz06OMaTBpiUg2m4Yg
	 Vk1CzTTLPu03jWrk3Q8FxRPFxECvkl9e8Q0MQOG+R/m75ifod8RSxHLxyuX7VQD520
	 /9YH4oDEndOCzPVwA7iupOzHVF2T+TaffnI/xc/l+KeBF8+3C8h9JpaM9dTi1/oyyI
	 sinSD7LCEKfitE+nzIFnLYmdDOvKxS8o5qRrkrtwA06An2smkUpsyjrdSAkA/U3SFP
	 SKXjvQif1+Ibw==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-coco@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	will@kernel.org,
	maz@kernel.org,
	tglx@linutronix.de,
	robin.murphy@arm.com,
	suzuki.poulose@arm.com,
	akpm@linux-foundation.org,
	jgg@ziepe.ca,
	steven.price@arm.com,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [RFC PATCH] arm64: swiotlb: dma: its: Ensure shared buffers are properly aligned
Date: Fri,  5 Sep 2025 11:24:41 +0530
Message-ID: <20250905055441.950943-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running with private memory guests, the guest kernel must allocate
memory with specific constraints when sharing it with the hypervisor.

These shared memory buffers are also accessed by the host kernel, which
means they must be aligned to the host kernel's page size.

This patch introduces a new helper, arch_shared_mem_alignment(), which
can be used to enforce proper alignment of shared buffers.

The actual implementation of arch_shared_mem_alignment() is deferred
to a follow-up patch.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/mem_encrypt.h |  6 ++++++
 arch/arm64/mm/init.c                 |  4 +++-
 arch/arm64/mm/mem_encrypt.c          |  6 ++++++
 drivers/irqchip/irq-gic-v3-its.c     |  8 ++++++--
 include/linux/mem_encrypt.h          |  7 +++++++
 include/linux/swiotlb.h              |  7 ++++---
 kernel/dma/direct.c                  |  7 +++++++
 kernel/dma/pool.c                    |  1 +
 kernel/dma/swiotlb.c                 | 28 +++++++++++++++++-----------
 9 files changed, 57 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/mem_encrypt.h b/arch/arm64/include/asm/mem_encrypt.h
index d77c10cd5b79..aaaa1079ba30 100644
--- a/arch/arm64/include/asm/mem_encrypt.h
+++ b/arch/arm64/include/asm/mem_encrypt.h
@@ -17,6 +17,12 @@ int set_memory_encrypted(unsigned long addr, int numpages);
 int set_memory_decrypted(unsigned long addr, int numpages);
 bool force_dma_unencrypted(struct device *dev);
 
+#define arch_shared_mem_alignment arch_shared_mem_alignment
+static inline long arch_shared_mem_alignment(void)
+{
+	return PAGE_SIZE;
+}
+
 int realm_register_memory_enc_ops(void);
 
 /*
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index ea84a61ed508..389070e9ee65 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -337,12 +337,14 @@ void __init bootmem_init(void)
 
 void __init arch_mm_preinit(void)
 {
+	unsigned int swiotlb_align = PAGE_SIZE;
 	unsigned int flags = SWIOTLB_VERBOSE;
 	bool swiotlb = max_pfn > PFN_DOWN(arm64_dma_phys_limit);
 
 	if (is_realm_world()) {
 		swiotlb = true;
 		flags |= SWIOTLB_FORCE;
+		swiotlb_align = arch_shared_mem_alignment();
 	}
 
 	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) && !swiotlb) {
@@ -356,7 +358,7 @@ void __init arch_mm_preinit(void)
 		swiotlb = true;
 	}
 
-	swiotlb_init(swiotlb, flags);
+	swiotlb_init(swiotlb, swiotlb_align, flags);
 	swiotlb_update_mem_attributes();
 
 	/*
diff --git a/arch/arm64/mm/mem_encrypt.c b/arch/arm64/mm/mem_encrypt.c
index 645c099fd551..170ee4b61e50 100644
--- a/arch/arm64/mm/mem_encrypt.c
+++ b/arch/arm64/mm/mem_encrypt.c
@@ -46,6 +46,12 @@ int set_memory_decrypted(unsigned long addr, int numpages)
 	if (likely(!crypt_ops) || WARN_ON(!PAGE_ALIGNED(addr)))
 		return 0;
 
+	if (WARN_ON(!IS_ALIGNED(addr, arch_shared_mem_alignment())))
+		return 0;
+
+	if (WARN_ON(!IS_ALIGNED(numpages << PAGE_SHIFT, arch_shared_mem_alignment())))
+		return 0;
+
 	return crypt_ops->decrypt(addr, numpages);
 }
 EXPORT_SYMBOL_GPL(set_memory_decrypted);
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 467cb78435a9..e2142bbca13b 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -213,16 +213,20 @@ static gfp_t gfp_flags_quirk;
 static struct page *its_alloc_pages_node(int node, gfp_t gfp,
 					 unsigned int order)
 {
+	long new_order;
 	struct page *page;
 	int ret = 0;
 
-	page = alloc_pages_node(node, gfp | gfp_flags_quirk, order);
+	/* align things to hypervisor page size */
+	new_order = get_order(ALIGN((PAGE_SIZE << order), arch_shared_mem_alignment()));
+
+	page = alloc_pages_node(node, gfp | gfp_flags_quirk, new_order);
 
 	if (!page)
 		return NULL;
 
 	ret = set_memory_decrypted((unsigned long)page_address(page),
-				   1 << order);
+				   1 << new_order);
 	/*
 	 * If set_memory_decrypted() fails then we don't know what state the
 	 * page is in, so we can't free it. Instead we leak it.
diff --git a/include/linux/mem_encrypt.h b/include/linux/mem_encrypt.h
index 07584c5e36fb..c24563e7363a 100644
--- a/include/linux/mem_encrypt.h
+++ b/include/linux/mem_encrypt.h
@@ -54,6 +54,13 @@
 #define dma_addr_canonical(x)		(x)
 #endif
 
+#ifndef arch_shared_mem_alignment
+static inline long arch_shared_mem_alignment(void)
+{
+	return PAGE_SIZE;
+}
+#endif
+
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __MEM_ENCRYPT_H__ */
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index b27de03f2466..739edb380e54 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -36,8 +36,9 @@ struct scatterlist;
 #define IO_TLB_DEFAULT_SIZE (64UL<<20)
 
 unsigned long swiotlb_size_or_default(void);
-void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
-	int (*remap)(void *tlb, unsigned long nslabs));
+void __init swiotlb_init_remap(bool addressing_limit, unsigned int alignment,
+			       unsigned int flags,
+			       int (*remap)(void *tlb, unsigned long nslabs));
 int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	int (*remap)(void *tlb, unsigned long nslabs));
 extern void __init swiotlb_update_mem_attributes(void);
@@ -181,7 +182,7 @@ static inline bool is_swiotlb_force_bounce(struct device *dev)
 	return mem && mem->force_bounce;
 }
 
-void swiotlb_init(bool addressing_limited, unsigned int flags);
+void swiotlb_init(bool addressing_limited, unsigned int alignment, unsigned int flags);
 void __init swiotlb_exit(void);
 void swiotlb_dev_init(struct device *dev);
 size_t swiotlb_max_mapping_size(struct device *dev);
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 24c359d9c879..5db5baad5efa 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -255,6 +255,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	    dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
+	if (force_dma_unencrypted(dev))
+		/*  align to hypervisor size */
+		size = ALIGN(size, arch_shared_mem_alignment());
 	/* we always manually zero the memory once we are done */
 	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
 	if (!page)
@@ -364,6 +367,10 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
+	if (force_dma_unencrypted(dev))
+		/*  align to hypervisor size */
+		size = ALIGN(size, arch_shared_mem_alignment());
+
 	page = __dma_direct_alloc_pages(dev, size, gfp, false);
 	if (!page)
 		return NULL;
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 7b04f7575796..cf4c659b3db9 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -196,6 +196,7 @@ static int __init dma_atomic_pool_init(void)
 		unsigned long pages = totalram_pages() / (SZ_1G / SZ_128K);
 		pages = min_t(unsigned long, pages, MAX_ORDER_NR_PAGES);
 		atomic_pool_size = max_t(size_t, pages << PAGE_SHIFT, SZ_128K);
+		WARN_ON(!IS_ALIGNED(atomic_pool_size, arch_shared_mem_alignment()));
 	}
 	INIT_WORK(&atomic_pool_work, atomic_pool_work_fn);
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index abcf3fa63a56..a8f46d2ce058 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -316,21 +316,22 @@ static void add_mem_pool(struct io_tlb_mem *mem, struct io_tlb_pool *pool)
 }
 
 static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
-		unsigned int flags,
-		int (*remap)(void *tlb, unsigned long nslabs))
+				unsigned int alignment, unsigned int flags,
+				int (*remap)(void *tlb, unsigned long nslabs))
 {
-	size_t bytes = PAGE_ALIGN(nslabs << IO_TLB_SHIFT);
+	size_t bytes;
 	void *tlb;
 
+	bytes = ALIGN((nslabs << IO_TLB_SHIFT), alignment);
 	/*
 	 * By default allocate the bounce buffer memory from low memory, but
 	 * allow to pick a location everywhere for hypervisors with guest
 	 * memory encryption.
 	 */
 	if (flags & SWIOTLB_ANY)
-		tlb = memblock_alloc(bytes, PAGE_SIZE);
+		tlb = memblock_alloc(bytes, alignment);
 	else
-		tlb = memblock_alloc_low(bytes, PAGE_SIZE);
+		tlb = memblock_alloc_low(bytes, alignment);
 
 	if (!tlb) {
 		pr_warn("%s: Failed to allocate %zu bytes tlb structure\n",
@@ -339,7 +340,7 @@ static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
 	}
 
 	if (remap && remap(tlb, nslabs) < 0) {
-		memblock_free(tlb, PAGE_ALIGN(bytes));
+		memblock_free(tlb, bytes);
 		pr_warn("%s: Failed to remap %zu bytes\n", __func__, bytes);
 		return NULL;
 	}
@@ -351,8 +352,9 @@ static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
  * Statically reserve bounce buffer space and initialize bounce buffer data
  * structures for the software IO TLB used to implement the DMA API.
  */
-void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
-		int (*remap)(void *tlb, unsigned long nslabs))
+void __init swiotlb_init_remap(bool addressing_limit, unsigned int alignment,
+			       unsigned int flags,
+			       int (*remap)(void *tlb, unsigned long nslabs))
 {
 	struct io_tlb_pool *mem = &io_tlb_default_mem.defpool;
 	unsigned long nslabs;
@@ -382,7 +384,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 
 	nslabs = default_nslabs;
 	nareas = limit_nareas(default_nareas, nslabs);
-	while ((tlb = swiotlb_memblock_alloc(nslabs, flags, remap)) == NULL) {
+	while ((tlb = swiotlb_memblock_alloc(nslabs, alignment, flags, remap)) == NULL) {
 		if (nslabs <= IO_TLB_MIN_SLABS)
 			return;
 		nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
@@ -417,9 +419,9 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 		swiotlb_print_info();
 }
 
-void __init swiotlb_init(bool addressing_limit, unsigned int flags)
+void __init swiotlb_init(bool addressing_limit, unsigned int alignment, unsigned int flags)
 {
-	swiotlb_init_remap(addressing_limit, flags, NULL);
+	swiotlb_init_remap(addressing_limit, alignment, flags, NULL);
 }
 
 /*
@@ -464,6 +466,10 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	order = get_order(nslabs << IO_TLB_SHIFT);
 	nslabs = SLABS_PER_PAGE << order;
 
+	WARN_ON(!IS_ALIGNED(order << PAGE_SHIFT, arch_shared_mem_alignment()));
+	WARN_ON(!IS_ALIGNED(default_nslabs << IO_TLB_SHIFT, arch_shared_mem_alignment()));
+	WARN_ON(!IS_ALIGNED(IO_TLB_MIN_SLABS << IO_TLB_SHIFT, arch_shared_mem_alignment()));
+
 	while ((SLABS_PER_PAGE << order) > IO_TLB_MIN_SLABS) {
 		vstart = (void *)__get_free_pages(gfp_mask | __GFP_NOWARN,
 						  order);
-- 
2.43.0

