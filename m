Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877F5A937;
	Sun, 21 Dec 2025 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766333402; cv=none; b=g8hHcoRc8TQXKkEptzcupFFTOMRYbxFO59EdG8RyVQh5p0XXJskiPUx7KO+BkDTL/RgFVSY4t+jnxgGc5SZIyNj/ffXB/Wm/FePqzVhvrp7qethBlxl4UAvSEMBShiSOcQqLWqAXvuuy3tjooXFy8vP7gTZkJWf6phXRokb0b5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766333402; c=relaxed/simple;
	bh=Z0/RYBzaD9NfGKRqAhni5lZKvUT/L/m083n44BxqWtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vedl9oapb0M6DR6qPlKagnhLqNTGcr/2P4CCfZsBi2Y4DyQStwNwRoy62EG3+chbhajkGnFTokHFPKhb55PJiT0JfYIcOuA7IiG7ugJPhp4cjBAKGVHpS690xMMJCTHNs6OIJ7xUFOCi4Sbt+3DfJI5e+5W9NkebDY3EKJKIDeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bk8/unCX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bk8/unCX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAB8C4CEFB;
	Sun, 21 Dec 2025 16:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766333402;
	bh=Z0/RYBzaD9NfGKRqAhni5lZKvUT/L/m083n44BxqWtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bk8/unCXrdBsPM4h9/y9tTfc++JoROMfpQZsZjLIvWkjfxHY5AJW8P9/YD42KTe4c
	 qh/CLcta4tKZ1tp11vbcUmmF+KGibp/IafjkraWWBjJJKj0AWCudPwEDbXsW4Whkmo
	 9F/BV2YpHMPj7eJGQd1VOiNpDDky+yO118tFFNWEDgRDwwKfv0stee+e88W8yuarrv
	 CnuLjLue3f4bUMw+fQtenAu9p1VkAyozhRsrCB5YIi9VSnurrbXqMpzAPaojHCojtD
	 Xo+rk/ZZT8bKrCXbgj62V5DPbb7Hygjo0eHpuPw0w7eBbFzuRL05hzJAn+LE46x0QV
	 jj+P/Rslvp/xQ==
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
Subject: [PATCH v2 1/4] swiotlb: dma: its: Enforce host page-size alignment for shared buffers
Date: Sun, 21 Dec 2025 21:39:17 +0530
Message-ID: <20251221160920.297689-2-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251221160920.297689-1-aneesh.kumar@kernel.org>
References: <20251221160920.297689-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When running private-memory guests, the guest kernel must apply
additional constraints when allocating buffers that are shared with the
hypervisor.

These shared buffers are also accessed by the host kernel and therefore
must be aligned to the host’s page size.

On non-secure hosts, set_guest_memory_attributes() tracks memory at the
host PAGE_SIZE granularity. This creates a mismatch when the guest
applies attributes at 4K boundaries while the host uses 64K pages. In
such cases, the call returns -EINVAL, preventing the conversion of
memory regions from private to shared.

Architectures such as Arm can tolerate realm physical address space PFNs
being mapped as shared memory, as incorrect accesses are detected and
reported as GPC faults. However, relying on this mechanism is unsafe and
can still lead to kernel crashes.

This is particularly likely when guest_memfd allocations are mmapped and
accessed from userspace. Once exposed to userspace, we cannot guarantee
that applications will only access the intended 4K shared region rather
than the full 64K page mapped into their address space. Such userspace
addresses may also be passed back into the kernel and accessed via the
linear map, resulting in a GPC fault and a kernel crash.

With CCA, although Stage-2 mappings managed by the RMM still operate at
a 4K granularity, shared pages must nonetheless be aligned to the
host-managed page size to avoid the issues described above.

Introduce a new helper, mem_encryp_align(), to allow callers to enforce
the required alignment for shared buffers.

The architecture-specific implementation of mem_encrypt_align() will be
provided in a follow-up patch.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/mem_encrypt.h |  6 ++++++
 arch/arm64/mm/mem_encrypt.c          |  6 ++++++
 drivers/irqchip/irq-gic-v3-its.c     |  7 ++++---
 include/linux/mem_encrypt.h          |  7 +++++++
 kernel/dma/contiguous.c              | 10 ++++++++++
 kernel/dma/direct.c                  |  6 ++++++
 kernel/dma/pool.c                    |  6 ++++--
 kernel/dma/swiotlb.c                 | 18 ++++++++++++------
 8 files changed, 55 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/mem_encrypt.h b/arch/arm64/include/asm/mem_encrypt.h
index d77c10cd5b79..b7ac143b81ce 100644
--- a/arch/arm64/include/asm/mem_encrypt.h
+++ b/arch/arm64/include/asm/mem_encrypt.h
@@ -17,6 +17,12 @@ int set_memory_encrypted(unsigned long addr, int numpages);
 int set_memory_decrypted(unsigned long addr, int numpages);
 bool force_dma_unencrypted(struct device *dev);
 
+#define mem_encrypt_align mem_encrypt_align
+static inline size_t mem_encrypt_align(size_t size)
+{
+	return size;
+}
+
 int realm_register_memory_enc_ops(void);
 
 /*
diff --git a/arch/arm64/mm/mem_encrypt.c b/arch/arm64/mm/mem_encrypt.c
index 645c099fd551..deb364eadd47 100644
--- a/arch/arm64/mm/mem_encrypt.c
+++ b/arch/arm64/mm/mem_encrypt.c
@@ -46,6 +46,12 @@ int set_memory_decrypted(unsigned long addr, int numpages)
 	if (likely(!crypt_ops) || WARN_ON(!PAGE_ALIGNED(addr)))
 		return 0;
 
+	if (WARN_ON(!IS_ALIGNED(addr, mem_encrypt_align(PAGE_SIZE))))
+		return 0;
+
+	if (WARN_ON(!IS_ALIGNED(numpages << PAGE_SHIFT, mem_encrypt_align(PAGE_SIZE))))
+		return 0;
+
 	return crypt_ops->decrypt(addr, numpages);
 }
 EXPORT_SYMBOL_GPL(set_memory_decrypted);
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 467cb78435a9..ffb8ef3a1eb3 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -213,16 +213,17 @@ static gfp_t gfp_flags_quirk;
 static struct page *its_alloc_pages_node(int node, gfp_t gfp,
 					 unsigned int order)
 {
+	unsigned int new_order;
 	struct page *page;
 	int ret = 0;
 
-	page = alloc_pages_node(node, gfp | gfp_flags_quirk, order);
-
+	new_order = get_order(mem_encrypt_align((PAGE_SIZE << order)));
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
index 07584c5e36fb..a0b9f6fe5d1a 100644
--- a/include/linux/mem_encrypt.h
+++ b/include/linux/mem_encrypt.h
@@ -54,6 +54,13 @@
 #define dma_addr_canonical(x)		(x)
 #endif
 
+#ifndef mem_encrypt_align
+static inline size_t mem_encrypt_align(size_t size)
+{
+	return size;
+}
+#endif
+
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __MEM_ENCRYPT_H__ */
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index d9b9dcba6ff7..35f738c9eee2 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -45,6 +45,7 @@
 #include <linux/dma-map-ops.h>
 #include <linux/cma.h>
 #include <linux/nospec.h>
+#include <linux/dma-direct.h>
 
 #ifdef CONFIG_CMA_SIZE_MBYTES
 #define CMA_SIZE_MBYTES CONFIG_CMA_SIZE_MBYTES
@@ -356,6 +357,15 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 	int nid = dev_to_node(dev);
 #endif
 
+	/*
+	 * for untrusted device, we require the dma buffers to be aligned to
+	 * the size of allocation. if we can't do that with cma allocation, fail
+	 * cma allocation early.
+	 */
+	if (force_dma_unencrypted(dev))
+		if (get_order(size) > CONFIG_CMA_ALIGNMENT)
+			return NULL;
+
 	/* CMA can be used only in the context which permits sleeping */
 	if (!gfpflags_allow_blocking(gfp))
 		return NULL;
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 1f9ee9759426..3448d877c7c6 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -250,6 +250,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	    dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
+	if (force_dma_unencrypted(dev))
+		size = mem_encrypt_align(size);
+
 	/* we always manually zero the memory once we are done */
 	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
 	if (!page)
@@ -359,6 +362,9 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
+	if (force_dma_unencrypted(dev))
+		size = mem_encrypt_align(size);
+
 	page = __dma_direct_alloc_pages(dev, size, gfp, false);
 	if (!page)
 		return NULL;
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index ee45dee33d49..86615e088240 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -80,12 +80,13 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 			      gfp_t gfp)
 {
 	unsigned int order;
+	unsigned int min_encrypt_order = get_order(mem_encrypt_align(PAGE_SIZE));
 	struct page *page = NULL;
 	void *addr;
 	int ret = -ENOMEM;
 
 	/* Cannot allocate larger than MAX_PAGE_ORDER */
-	order = min(get_order(pool_size), MAX_PAGE_ORDER);
+	order = min(get_order(mem_encrypt_align(pool_size)), MAX_PAGE_ORDER);
 
 	do {
 		pool_size = 1 << (PAGE_SHIFT + order);
@@ -94,7 +95,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 							 order, false);
 		if (!page)
 			page = alloc_pages(gfp, order);
-	} while (!page && order-- > 0);
+	} while (!page && order-- > min_encrypt_order);
 	if (!page)
 		goto out;
 
@@ -196,6 +197,7 @@ static int __init dma_atomic_pool_init(void)
 		unsigned long pages = totalram_pages() / (SZ_1G / SZ_128K);
 		pages = min_t(unsigned long, pages, MAX_ORDER_NR_PAGES);
 		atomic_pool_size = max_t(size_t, pages << PAGE_SHIFT, SZ_128K);
+		WARN_ON(!IS_ALIGNED(atomic_pool_size, mem_encrypt_align(PAGE_SIZE)));
 	}
 	INIT_WORK(&atomic_pool_work, atomic_pool_work_fn);
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 0d37da3d95b6..db53dc7bff6a 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -319,8 +319,8 @@ static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
 		unsigned int flags,
 		int (*remap)(void *tlb, unsigned long nslabs))
 {
-	size_t bytes = PAGE_ALIGN(nslabs << IO_TLB_SHIFT);
 	void *tlb;
+	size_t bytes = mem_encrypt_align(nslabs << IO_TLB_SHIFT);
 
 	/*
 	 * By default allocate the bounce buffer memory from low memory, but
@@ -328,9 +328,9 @@ static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
 	 * memory encryption.
 	 */
 	if (flags & SWIOTLB_ANY)
-		tlb = memblock_alloc(bytes, PAGE_SIZE);
+		tlb = memblock_alloc(bytes, mem_encrypt_align(PAGE_SIZE));
 	else
-		tlb = memblock_alloc_low(bytes, PAGE_SIZE);
+		tlb = memblock_alloc_low(bytes, mem_encrypt_align(PAGE_SIZE));
 
 	if (!tlb) {
 		pr_warn("%s: Failed to allocate %zu bytes tlb structure\n",
@@ -339,7 +339,7 @@ static void __init *swiotlb_memblock_alloc(unsigned long nslabs,
 	}
 
 	if (remap && remap(tlb, nslabs) < 0) {
-		memblock_free(tlb, PAGE_ALIGN(bytes));
+		memblock_free(tlb, bytes);
 		pr_warn("%s: Failed to remap %zu bytes\n", __func__, bytes);
 		return NULL;
 	}
@@ -461,15 +461,21 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 		swiotlb_adjust_nareas(num_possible_cpus());
 
 retry:
-	order = get_order(nslabs << IO_TLB_SHIFT);
+	order = get_order(mem_encrypt_align(nslabs << IO_TLB_SHIFT));
 	nslabs = SLABS_PER_PAGE << order;
 
+	WARN_ON(!IS_ALIGNED(order << PAGE_SHIFT, mem_encrypt_align(PAGE_SIZE)));
+	WARN_ON(!IS_ALIGNED(default_nslabs << IO_TLB_SHIFT, mem_encrypt_align(PAGE_SIZE)));
+	WARN_ON(!IS_ALIGNED(IO_TLB_MIN_SLABS << IO_TLB_SHIFT, mem_encrypt_align(PAGE_SIZE)));
+
 	while ((SLABS_PER_PAGE << order) > IO_TLB_MIN_SLABS) {
 		vstart = (void *)__get_free_pages(gfp_mask | __GFP_NOWARN,
 						  order);
 		if (vstart)
 			break;
 		order--;
+		if (order < get_order(mem_encrypt_align(PAGE_SIZE)))
+			break;
 		nslabs = SLABS_PER_PAGE << order;
 		retried = true;
 	}
@@ -573,7 +579,7 @@ void __init swiotlb_exit(void)
  */
 static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes, u64 phys_limit)
 {
-	unsigned int order = get_order(bytes);
+	unsigned int order = get_order(mem_encrypt_align(bytes));
 	struct page *page;
 	phys_addr_t paddr;
 	void *vaddr;
-- 
2.43.0

