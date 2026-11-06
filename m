Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990692;
	b=Ujg7XTTH4JFFS5szy78sF9Eeu+jGT+gFI5kc3Fv/nT1f+Dgv9+TfAtJFuT6mnIXjzt65
	 YW3txeVsvXJUnQI0RrTyI9QmoBlvDrtIYo3keZ+wV0wpynFmgbWXgH0kn+/EtqAfDfz5W
	 I4bJ6aUCvLZWDFxqkGUnhSSbwxA3hTxXmsOROhRZC0WwiplhbGDaKs1LJGRWLWQsGfLys
	 BlbZbMWOnawb6uRJX00tEuOzY3Yz80HGT/+xJMqQO0zPm11WmIizIBsbXJQRQadvoOKeC
	 MhDcFO159pJyUVrBFvtzLh2WiAZywvznxjgfd35torac7CHqWj1bpL+4b3xPLogW5pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990692;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Nc2OvHqLLh27h+gzgJd0GnRqElP9jnY8ftxbnsln3X0=;
	b=SX8PCq3QToELzfTE2OJkLc6yrKomU+AZ5KhxN+UqsrJC4YdLJAkb3adv0Xgslzoba0Gu
	 EV+vrzNyZWywfeRL4Hw49C1RbbmUOaKa+pS57JhDKfx8UnL8wyw36HkNcV8NunMfwFmH+
	 KkeOWzzWV46K9P2DAxgIsjOo25vN5qCecqQHy4fr2fBqpb3rbyJelEKXcQsNzWvh4+xtH
	 ujIz+vKvsyVNDB4pdQ/if5TyhKdjIJm6RIh+YMnkLU0uE6bfxWlmxzy1ThCSdssuU56ns
	 IV8L3cecEqR1+yajxnZuS7PYBmV2q5g+0iapusocW+LGGsoYdJNRXNaMgnJACNI3d0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cqzgpb5u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DCF606A335;
	Fri,  6 Nov 2026 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cqzgpb5u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077941F008A7;
	Fri,  6 Nov 2026 18:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793990691;
	bh=Nc2OvHqLLh27h+gzgJd0GnRqElP9jnY8ftxbnsln3X0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cqzgpb5uc19NT60V3JKr9KHXLIJiIFpaO/YPFxtm44nIDb1FxC0yhxv/Y+QZ7ei5M
	 JSmX9pX/eBWWDZWCWydSxop/6t7UvqjY2DHZ8ECD6MiMsEqNaoQgFm3qbTUMU9rz7w
	 SWA69aa3pUyCf3N2OG1ImpeFiyHTN0yq2K2Vr9Ep+tOsDdMGzeKwQ6S2JaXYwKNuIz
	 q8xNV2MO4Oo/plY5bv4CvffO2mfpjfXnmt9EX7sKnNhXe2ki5rG8PeDaGY3B2zR98w
	 KKPPtYJJwl23uDLhFrhAJpkKT79wKM8nsOHabDcsvR0mFQ5lRBgrwRyhho5i7xQRW+
	 5+LgC7GHujdMA==
From: Jakub Kicinski <kuba@kernel.org>
To: robin.murphy@arm.com,
	m.szyprowski@samsung.com
Cc: netdev@vger.kernel.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH 04/11] dma-contiguous: pass the NUMA node to dma_alloc_contiguous()
Date: Fri,  6 Nov 2026 10:44:26 -0800
Message-ID: <20261106184433.761422-5-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106184433.761422-1-kuba@kernel.org>
References: <20261106184433.761422-1-kuba@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

dma_alloc_contiguous() picks the per-numa CMA area based on the node of
the device. Let the callers pass the node in, so that dma-direct and
iommu-dma honor the node requested via dma_alloc_attrs_node() for CMA
allocations, too. dma_common_alloc_pages() keeps using the device's node.

Unlike the page allocator, CMA does not fall back to the areas of other
nodes, only to the global CMA area. The allocation may fail even though
the CMA area of the device's node still has free space. Document this.

This completes the wiring of the node, so also document which
allocations don't take it into account.

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v1:
 - move after the dma-direct and iommu-dma patches (Robin)
 - docs: document that CMA does not fall back to other nodes' areas (Björn)
 - docs: document which allocations ignore the node
rfc: https://lore.kernel.org/20261027022528.633359-2-kuba@kernel.org
---
 Documentation/core-api/dma-api.rst |  5 ++++-
 include/linux/dma-map-ops.h        |  5 +++--
 drivers/iommu/dma-iommu.c          |  2 +-
 kernel/dma/contiguous.c            | 12 +++++-------
 kernel/dma/direct.c                |  2 +-
 kernel/dma/mapping.c               |  7 +++++++
 kernel/dma/ops_helpers.c           |  5 +++--
 7 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
index f44cc770a472..e6fe24e936ee 100644
--- a/Documentation/core-api/dma-api.rst
+++ b/Documentation/core-api/dma-api.rst
@@ -69,7 +69,10 @@ frequently by both the device and a CPU on a different node, for example
 descriptor rings serviced by that CPU.
 
 Like with kmalloc_node() the node is only a preference, the page allocator
-may fall back to other nodes if the given node is out of memory.
+may fall back to other nodes if the given node is out of memory. Note that
+contiguous memory allocator (CMA) does not: only the CMA area of the given
+node and the global CMA area are tried. The allocation may fail even though
+the CMA area of another node, e.g. that of the device, still has free space.
 
 ::
 
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index afaf2c12189b..6014ec433b03 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -102,7 +102,8 @@ struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
 				       unsigned int order, bool no_warn);
 bool dma_release_from_contiguous(struct device *dev, struct page *pages,
 				 int count);
-struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp);
+struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp,
+				  int nid);
 void dma_free_contiguous(struct device *dev, struct page *page, size_t size);
 
 void dma_contiguous_early_fixup(phys_addr_t base, unsigned long size);
@@ -136,7 +137,7 @@ static inline bool dma_release_from_contiguous(struct device *dev,
 }
 /* Use fallback alloc() and free() when CONFIG_DMA_CMA=n */
 static inline struct page *dma_alloc_contiguous(struct device *dev, size_t size,
-		gfp_t gfp)
+		gfp_t gfp, int nid)
 {
 	return NULL;
 }
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 3e3a1a987a23..b66e83cfbc5f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1648,7 +1648,7 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
 	struct page *page = NULL;
 	void *cpu_addr;
 
-	page = dma_alloc_contiguous(dev, alloc_size, gfp);
+	page = dma_alloc_contiguous(dev, alloc_size, gfp, node);
 	if (!page) {
 		cpu_addr = alloc_pages_exact_nid(node, alloc_size, gfp);
 		if (!cpu_addr)
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 90937dc7c627..e30ec6a08af0 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -402,22 +402,20 @@ static struct page *cma_alloc_aligned(struct cma *cma, size_t size, gfp_t gfp)
  * @dev:   Pointer to device for which the allocation is performed.
  * @size:  Requested allocation size.
  * @gfp:   Allocation flags.
+ * @nid:   NUMA node to allocate the memory on.
  *
  * tries to use device specific contiguous memory area if available, or it
- * tries to use per-numa cma, if the allocation fails, it will fallback to
- * try default global one.
+ * tries to use per-numa cma of @nid, if the allocation fails, it will fallback
+ * to try default global one.
  *
  * Note that it bypass one-page size of allocations from the per-numa and
  * global area as the addresses within one page are always contiguous, so
  * there is no need to waste CMA pages for that kind; it also helps reduce
  * fragmentations.
  */
-struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
+struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp,
+				  int nid)
 {
-#ifdef CONFIG_DMA_NUMA_CMA
-	int nid = dev_to_node(dev);
-#endif
-
 	/* CMA can be used only in the context which permits sleeping */
 	if (!gfpflags_allow_blocking(gfp))
 		return NULL;
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index a9d24d8bc77c..37c49e84dea6 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -124,7 +124,7 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 	WARN_ON_ONCE(!PAGE_ALIGNED(size));
 
 	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
-	page = dma_alloc_contiguous(dev, size, gfp);
+	page = dma_alloc_contiguous(dev, size, gfp, node);
 	if (page) {
 		if (dma_coherent_ok(dev, page_to_phys(page), size) &&
 		    (allow_highmem || !PageHighMem(page)))
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index f98d4dec8649..b3d0811b1d82 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -642,6 +642,13 @@ EXPORT_SYMBOL_GPL(dma_get_required_mask);
  * Same as dma_alloc_attrs() but places the memory on @node rather than on the
  * node of @dev. Like with kmalloc_node() the node is only a preference,
  * the page allocator may fall back to other nodes if @node is out of memory.
+ * The contiguous memory allocator (CMA) does not: only the CMA area of @node
+ * and the global CMA area are tried. The allocation may fail even though the
+ * CMA area of another node, e.g. that of @dev, still has free space.
+ *
+ * Allocations served from per-device or global coherent pools, per-device CMA
+ * areas, restricted or atomic pools, arch_dma_alloc() or dma_map_ops
+ * implementations do not take @node into account.
  *
  * Return: the CPU address of the allocation, or NULL on failure.
  */
diff --git a/kernel/dma/ops_helpers.c b/kernel/dma/ops_helpers.c
index 5cdf3f60cf47..2bff02c53fb6 100644
--- a/kernel/dma/ops_helpers.c
+++ b/kernel/dma/ops_helpers.c
@@ -63,12 +63,13 @@ struct page *dma_common_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
+	int nid = dev_to_node(dev);
 	struct page *page;
 	phys_addr_t phys;
 
-	page = dma_alloc_contiguous(dev, size, gfp);
+	page = dma_alloc_contiguous(dev, size, gfp, nid);
 	if (!page) {
-		void *va = alloc_pages_exact_nid(dev_to_node(dev), size, gfp);
+		void *va = alloc_pages_exact_nid(nid, size, gfp);
 
 		if (!va)
 			return NULL;
-- 
2.56.0

