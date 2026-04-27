Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F8534A78E;
	Mon, 27 Apr 2026 05:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777269340; cv=none; b=d3Nc5lDegI5XwHO0QTqhIgQVgfM+Gyh13IuXsv+DYikD7rrOX8kGqs26skB//UKN3s3KM3gSywQKtBlOFJSuggqiiQzwig7LtGe7VIrszeSqYpxftgfUXH0McPOqjw3f2p1UCsAc0CGMnNbfj43rF66wl1lK9ECK01BBYl1kP3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777269340; c=relaxed/simple;
	bh=X5hXBurlFkJkRj3x/rHbEzlZm9OzCzuGnGzQMmdH0y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BgjVwFosoWL+WffSrV4PbbQxuSHXmAV84mNTfGGvkpyT5VH7K8vb5b3lNPKl0W6WbM/+vlJuDqZgxyM2mHOxq2vdQLSlu8L+f4RCsabf/ERqYZHWTkhfBzcGBOq84vqh1YC6CDW711/yVFMHSYP4b1I1rPFwARYFp8qK94J1FbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzmYl2uC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzmYl2uC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E5CC2BCB4;
	Mon, 27 Apr 2026 05:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777269340;
	bh=X5hXBurlFkJkRj3x/rHbEzlZm9OzCzuGnGzQMmdH0y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JzmYl2uCikmBjuafeflE8Qu7R20TMdAUfqRT+yQYWxPntskOnZOEvaVIR/vwYsaG5
	 ooCUi9vGBsyIiqdKWTidSqVPIJ4+aUtxHLJqa904qCMwGLt52/ZNNFuWPA+O1dLaWT
	 1+haHgz2s0dNdIQrCDez0Nk9FCRSXpp4QW8h9xFova4BDrG+Bn+0Z6qoiLT859nF9r
	 otE9bO0j6mRMdfbQVZkeVYOzcOazfrB2YT5Jgk717sbEFpqeip9/cCN77JJpS7rZ1W
	 HSdcXiju9HGop7tF0rzrX9pBKryOwI3TLTrDvTLSAEssQ6mHYJ1ft3J44zq3xIHV2j
	 BmZ9bx4gYteOQ==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH v3 3/9] dma-pool: track decrypted atomic pools and select them via attrs
Date: Mon, 27 Apr 2026 11:25:03 +0530
Message-ID: <20260427055509.898190-4-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427055509.898190-1-aneesh.kumar@kernel.org>
References: <20260427055509.898190-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach the atomic DMA pool code to distinguish between encrypted and
decrypted pools, and make pool allocation select the matching pool based
on DMA attributes.

Introduce a dma_gen_pool wrapper that records whether a pool is
decrypted, initialize that state when the atomic pools are created, and
use it when expanding and resizing the pools.  Update dma_alloc_from_pool()
to take attrs and skip pools whose encrypted/decrypted state does not
match DMA_ATTR_CC_SHARED.  Update dma_free_from_pool() accordingly.

Also pass DMA_ATTR_CC_SHARED from the swiotlb atomic allocation path
so decrypted swiotlb allocations are taken from the correct atomic pool.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/dma-iommu.c   |   2 +-
 include/linux/dma-map-ops.h |   2 +-
 kernel/dma/direct.c         |  11 ++-
 kernel/dma/pool.c           | 154 +++++++++++++++++++++++-------------
 kernel/dma/swiotlb.c        |   2 +
 5 files changed, 109 insertions(+), 62 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 54d96e847f16..c2595bee3d41 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1673,7 +1673,7 @@ void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
 	    !gfpflags_allow_blocking(gfp) && !coherent)
 		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
-					       gfp, NULL);
+					   gfp, attrs, NULL);
 	else
 		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
 	if (!cpu_addr)
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 6a1832a73cad..696b2c3a2305 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -212,7 +212,7 @@ void *dma_common_pages_remap(struct page **pages, size_t size, pgprot_t prot,
 void dma_common_free_remap(void *cpu_addr, size_t size);
 
 struct page *dma_alloc_from_pool(struct device *dev, size_t size,
-		void **cpu_addr, gfp_t flags,
+		void **cpu_addr, gfp_t flags, unsigned long attrs,
 		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t));
 bool dma_free_from_pool(struct device *dev, void *start, size_t size);
 
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 0c2e1f8436ce..707d410b3669 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -162,7 +162,7 @@ static bool dma_direct_use_pool(struct device *dev, gfp_t gfp)
 }
 
 static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp)
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	struct page *page;
 	u64 phys_limit;
@@ -172,7 +172,8 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
 		return NULL;
 
 	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
-	page = dma_alloc_from_pool(dev, size, &ret, gfp, dma_coherent_ok);
+	page = dma_alloc_from_pool(dev, size, &ret, gfp, attrs,
+				  dma_coherent_ok);
 	if (!page)
 		return NULL;
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
@@ -261,7 +262,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	 */
 	if ((remap || (attrs & DMA_ATTR_CC_SHARED)) &&
 	    dma_direct_use_pool(dev, gfp))
-		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
+		return dma_direct_alloc_from_pool(dev, size, dma_handle,
+					  gfp, attrs);
 
 	if (is_swiotlb_for_alloc(dev)) {
 		page = dma_direct_alloc_swiotlb(dev, size);
@@ -397,7 +399,8 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 		attrs |= DMA_ATTR_CC_SHARED;
 
 	if ((attrs & DMA_ATTR_CC_SHARED) && dma_direct_use_pool(dev, gfp))
-		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
+		return dma_direct_alloc_from_pool(dev, size, dma_handle,
+					  gfp, attrs);
 
 	if (is_swiotlb_for_alloc(dev)) {
 		page = dma_direct_alloc_swiotlb(dev, size);
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 2b2fbb709242..e41e19701e50 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -12,12 +12,18 @@
 #include <linux/set_memory.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
+#include <linux/cc_platform.h>
 
-static struct gen_pool *atomic_pool_dma __ro_after_init;
+struct dma_gen_pool {
+	bool decrypted;
+	struct gen_pool *pool;
+};
+
+static struct dma_gen_pool atomic_pool_dma __ro_after_init;
 static unsigned long pool_size_dma;
-static struct gen_pool *atomic_pool_dma32 __ro_after_init;
+static struct dma_gen_pool atomic_pool_dma32 __ro_after_init;
 static unsigned long pool_size_dma32;
-static struct gen_pool *atomic_pool_kernel __ro_after_init;
+static struct dma_gen_pool atomic_pool_kernel __ro_after_init;
 static unsigned long pool_size_kernel;
 
 /* Size can be defined by the coherent_pool command line */
@@ -76,7 +82,7 @@ static bool cma_in_zone(gfp_t gfp)
 	return true;
 }
 
-static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
+static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
 			      gfp_t gfp)
 {
 	unsigned int order;
@@ -113,11 +119,14 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
 	 * shrink so no re-encryption occurs in dma_direct_free().
 	 */
-	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
+	if (dma_pool->decrypted) {
+		ret = set_memory_decrypted((unsigned long)page_to_virt(page),
 				   1 << order);
-	if (ret)
-		goto remove_mapping;
-	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
+		if (ret)
+			goto remove_mapping;
+	}
+
+	ret = gen_pool_add_virt(dma_pool->pool, (unsigned long)addr, page_to_phys(page),
 				pool_size, NUMA_NO_NODE);
 	if (ret)
 		goto encrypt_mapping;
@@ -126,11 +135,13 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 	return 0;
 
 encrypt_mapping:
-	ret = set_memory_encrypted((unsigned long)page_to_virt(page),
-				   1 << order);
-	if (WARN_ON_ONCE(ret)) {
-		/* Decrypt succeeded but encrypt failed, purposely leak */
-		goto out;
+	if (dma_pool->decrypted) {
+		ret = set_memory_encrypted((unsigned long)page_to_virt(page),
+					   1 << order);
+		if (WARN_ON_ONCE(ret)) {
+			/* Decrypt succeeded but encrypt failed, purposely leak */
+			goto out;
+		}
 	}
 remove_mapping:
 #ifdef CONFIG_DMA_DIRECT_REMAP
@@ -142,46 +153,51 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 	return ret;
 }
 
-static void atomic_pool_resize(struct gen_pool *pool, gfp_t gfp)
+static void atomic_pool_resize(struct dma_gen_pool *dma_pool, gfp_t gfp)
 {
-	if (pool && gen_pool_avail(pool) < atomic_pool_size)
-		atomic_pool_expand(pool, gen_pool_size(pool), gfp);
+	if (dma_pool->pool && gen_pool_avail(dma_pool->pool) < atomic_pool_size)
+		atomic_pool_expand(dma_pool, gen_pool_size(dma_pool->pool), gfp);
 }
 
 static void atomic_pool_work_fn(struct work_struct *work)
 {
 	if (IS_ENABLED(CONFIG_ZONE_DMA))
-		atomic_pool_resize(atomic_pool_dma,
+		atomic_pool_resize(&atomic_pool_dma,
 				   GFP_KERNEL | GFP_DMA);
 	if (IS_ENABLED(CONFIG_ZONE_DMA32))
-		atomic_pool_resize(atomic_pool_dma32,
+		atomic_pool_resize(&atomic_pool_dma32,
 				   GFP_KERNEL | GFP_DMA32);
-	atomic_pool_resize(atomic_pool_kernel, GFP_KERNEL);
+	atomic_pool_resize(&atomic_pool_kernel, GFP_KERNEL);
 }
 
-static __init struct gen_pool *__dma_atomic_pool_init(size_t pool_size,
-						      gfp_t gfp)
+static __init struct dma_gen_pool *__dma_atomic_pool_init(struct dma_gen_pool *dma_pool,
+		size_t pool_size, gfp_t gfp)
 {
-	struct gen_pool *pool;
 	int ret;
 
-	pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
-	if (!pool)
+	dma_pool->pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
+	if (!dma_pool->pool)
 		return NULL;
 
-	gen_pool_set_algo(pool, gen_pool_first_fit_order_align, NULL);
+	gen_pool_set_algo(dma_pool->pool, gen_pool_first_fit_order_align, NULL);
+
+	/* if platform is using memory encryption atomic pools are by default decrypted. */
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+		dma_pool->decrypted = true;
+	else
+		dma_pool->decrypted = false;
 
-	ret = atomic_pool_expand(pool, pool_size, gfp);
+	ret = atomic_pool_expand(dma_pool, pool_size, gfp);
 	if (ret) {
-		gen_pool_destroy(pool);
+		gen_pool_destroy(dma_pool->pool);
 		pr_err("DMA: failed to allocate %zu KiB %pGg pool for atomic allocation\n",
 		       pool_size >> 10, &gfp);
 		return NULL;
 	}
 
 	pr_info("DMA: preallocated %zu KiB %pGg pool for atomic allocations\n",
-		gen_pool_size(pool) >> 10, &gfp);
-	return pool;
+		gen_pool_size(dma_pool->pool) >> 10, &gfp);
+	return dma_pool;
 }
 
 #ifdef CONFIG_ZONE_DMA32
@@ -207,21 +223,22 @@ static int __init dma_atomic_pool_init(void)
 
 	/* All memory might be in the DMA zone(s) to begin with */
 	if (has_managed_zone(ZONE_NORMAL)) {
-		atomic_pool_kernel = __dma_atomic_pool_init(atomic_pool_size,
-						    GFP_KERNEL);
-		if (!atomic_pool_kernel)
+		__dma_atomic_pool_init(&atomic_pool_kernel, atomic_pool_size, GFP_KERNEL);
+		if (!atomic_pool_kernel.pool)
 			ret = -ENOMEM;
 	}
+
 	if (has_managed_dma()) {
-		atomic_pool_dma = __dma_atomic_pool_init(atomic_pool_size,
-						GFP_KERNEL | GFP_DMA);
-		if (!atomic_pool_dma)
+		__dma_atomic_pool_init(&atomic_pool_dma, atomic_pool_size,
+				       GFP_KERNEL | GFP_DMA);
+		if (!atomic_pool_dma.pool)
 			ret = -ENOMEM;
 	}
+
 	if (has_managed_dma32) {
-		atomic_pool_dma32 = __dma_atomic_pool_init(atomic_pool_size,
-						GFP_KERNEL | GFP_DMA32);
-		if (!atomic_pool_dma32)
+		__dma_atomic_pool_init(&atomic_pool_dma32, atomic_pool_size,
+				       GFP_KERNEL | GFP_DMA32);
+		if (!atomic_pool_dma32.pool)
 			ret = -ENOMEM;
 	}
 
@@ -230,19 +247,38 @@ static int __init dma_atomic_pool_init(void)
 }
 postcore_initcall(dma_atomic_pool_init);
 
-static inline struct gen_pool *dma_guess_pool(struct gen_pool *prev, gfp_t gfp)
+static inline struct dma_gen_pool *dma_guess_pool(struct dma_gen_pool *prev, gfp_t gfp)
 {
 	if (prev == NULL) {
-		if (gfp & GFP_DMA)
-			return atomic_pool_dma ?: atomic_pool_dma32 ?: atomic_pool_kernel;
-		if (gfp & GFP_DMA32)
-			return atomic_pool_dma32 ?: atomic_pool_dma ?: atomic_pool_kernel;
-		return atomic_pool_kernel ?: atomic_pool_dma32 ?: atomic_pool_dma;
+		if (gfp & GFP_DMA) {
+			if (atomic_pool_dma.pool)
+				return &atomic_pool_dma;
+			if (atomic_pool_dma32.pool)
+				return &atomic_pool_dma32;
+			return &atomic_pool_kernel;
+		}
+
+		if (gfp & GFP_DMA32) {
+			if (atomic_pool_dma32.pool)
+				return &atomic_pool_dma32;
+			if (atomic_pool_dma.pool)
+				return &atomic_pool_dma;
+			return &atomic_pool_kernel;
+		}
+		if (atomic_pool_kernel.pool)
+			return &atomic_pool_kernel;
+		if (atomic_pool_dma32.pool)
+			return &atomic_pool_dma32;
+		if (atomic_pool_dma.pool)
+			return &atomic_pool_dma;
 	}
-	if (prev == atomic_pool_kernel)
-		return atomic_pool_dma32 ? atomic_pool_dma32 : atomic_pool_dma;
-	if (prev == atomic_pool_dma32)
-		return atomic_pool_dma;
+	if (prev == &atomic_pool_kernel) {
+		if (atomic_pool_dma32.pool)
+			return &atomic_pool_dma32;
+		return &atomic_pool_dma;
+	}
+	if (prev == &atomic_pool_dma32)
+		return &atomic_pool_dma;
 	return NULL;
 }
 
@@ -272,16 +308,20 @@ static struct page *__dma_alloc_from_pool(struct device *dev, size_t size,
 }
 
 struct page *dma_alloc_from_pool(struct device *dev, size_t size,
-		void **cpu_addr, gfp_t gfp,
+		void **cpu_addr, gfp_t gfp, unsigned long attrs,
 		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t))
 {
-	struct gen_pool *pool = NULL;
+	struct dma_gen_pool *dma_pool = NULL;
 	struct page *page;
 	bool pool_found = false;
 
-	while ((pool = dma_guess_pool(pool, gfp))) {
+	while ((dma_pool = dma_guess_pool(dma_pool, gfp))) {
+
+		if (dma_pool->decrypted != !!(attrs & DMA_ATTR_CC_SHARED))
+			continue;
+
 		pool_found = true;
-		page = __dma_alloc_from_pool(dev, size, pool, cpu_addr,
+		page = __dma_alloc_from_pool(dev, size, dma_pool->pool, cpu_addr,
 					     phys_addr_ok);
 		if (page)
 			return page;
@@ -296,12 +336,14 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
 
 bool dma_free_from_pool(struct device *dev, void *start, size_t size)
 {
-	struct gen_pool *pool = NULL;
+	struct dma_gen_pool *dma_pool = NULL;
 
-	while ((pool = dma_guess_pool(pool, 0))) {
-		if (!gen_pool_has_addr(pool, (unsigned long)start, size))
+	while ((dma_pool = dma_guess_pool(dma_pool, 0))) {
+
+		if (!gen_pool_has_addr(dma_pool->pool, (unsigned long)start, size))
 			continue;
-		gen_pool_free(pool, (unsigned long)start, size);
+
+		gen_pool_free(dma_pool->pool, (unsigned long)start, size);
 		return true;
 	}
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 1abd3e6146f4..b215b274a873 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -623,7 +623,9 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
 		if (!IS_ENABLED(CONFIG_DMA_COHERENT_POOL))
 			return NULL;
 
+		/* considered decrypted by default */
 		return dma_alloc_from_pool(dev, bytes, &vaddr, gfp,
+					   DMA_ATTR_CC_SHARED,
 					   dma_coherent_ok);
 	}
 
-- 
2.43.0

