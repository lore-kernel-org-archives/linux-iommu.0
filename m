Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668F9241CB2;
	Fri,  2 Jan 2026 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767369299; cv=none; b=q32N7UCQwS8VQvxkFm62UI3+qwGmP0qLFCTS63EgIFvMN7fdPNnUrrVKXHfCOx5XkAinvIptX0hTPy/VzEYcCNb3Gl9Xnowq3MWsQP+Tp5EA+uCJRSRCIQiWP+KxBzGmoAVStSIF7fq4AYABTNPAPXeD2yLXj5lXI1FUnv/pGco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767369299; c=relaxed/simple;
	bh=K3qmfGI3EXoOWLDpXNr56WIL6ogvPYO0XA4S1K9dUj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uI6/VTqdH/+aQe5JICiwyU8Xl7WhHKayuKSMkSnHUii1Qm2slRhMVk+7YgYDGZ3gFQMlIbr11cGhA4xgVfFlRbIlB1vC3AG8+a6UPUu2u244V4r4vEHaukeIBDxTB5PBega7SaHgZbKEz5NpFMlQwq98n0VjspSyibn5EtNeqNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6SGtbss; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6SGtbss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8B4C116B1;
	Fri,  2 Jan 2026 15:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767369299;
	bh=K3qmfGI3EXoOWLDpXNr56WIL6ogvPYO0XA4S1K9dUj8=;
	h=From:To:Cc:Subject:Date:From;
	b=J6SGtbssNaX+qj16R3as+UoUuJHhDzdTn2GziF+QOMnLqjHM00NsspFWB9V4Q3Xcs
	 w5IkPJSChBssRQqy1GkptDQEQ0pg9zRbN4FfaGkcKm5P34+EcLH+12st4KXA6Wt6Cj
	 KWqjkgvaTV9DdlKm/PNuSLYRzl3hg0fpv0Pb6kCFfc/vGGuydHIzMllQPxSQ4QR3QC
	 aRyqcjPFg1k761UYzg5wFDLG4Xlm82GPJnG+BcwcO/FxNfcrdSWcKT5DZWijv1HbJc
	 BekjQkaOkYvH3O3+Ob9+qjmV0C1xxFLJZNzJxCE66nyQK1xxQqYFNv+szEDmBz2TXO
	 MHSmwFUkRXklQ==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	steven.price@arm.com,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [PATCH] dma-direct: swiotlb: Skip encryption toggles for swiotlb allocations
Date: Fri,  2 Jan 2026 21:24:48 +0530
Message-ID: <20260102155448.2554240-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Swiotlb backing pages are already mapped decrypted via
swiotlb_update_mem_attributes(), so dma-direct does not need to call
set_memory_decrypted() during allocation or re-encrypt the memory on
free.

Handle swiotlb-backed buffers explicitly: obtain the DMA address and
zero the linear mapping for lowmem pages, and bypass the decrypt/encrypt
transitions when allocating/freeing from the swiotlb pool (detected via
swiotlb_find_pool()).

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c | 56 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index faf1e41afde8..c4ef4457bd74 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -104,15 +104,27 @@ static void __dma_direct_free_pages(struct device *dev, struct page *page,
 	dma_free_contiguous(dev, page, size);
 }
 
-static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size)
+static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size,
+					     dma_addr_t *dma_handle)
 {
-	struct page *page = swiotlb_alloc(dev, size);
+	void *lm_addr;
+	struct page *page;
+
+	page = swiotlb_alloc(dev, size);
+	if (!page)
+		return NULL;
 
-	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
+	if (!dma_coherent_ok(dev, page_to_phys(page), size)) {
 		swiotlb_free(dev, page, size);
 		return NULL;
 	}
+	/* If HighMem let caller take care of creating a mapping */
+	if (PageHighMem(page))
+		return page;
 
+	lm_addr = page_address(page);
+	memset(lm_addr, 0, size);
+	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
 	return page;
 }
 
@@ -125,9 +137,6 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 
 	WARN_ON_ONCE(!PAGE_ALIGNED(size));
 
-	if (is_swiotlb_for_alloc(dev))
-		return dma_direct_alloc_swiotlb(dev, size);
-
 	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
 	page = dma_alloc_contiguous(dev, size, gfp);
 	if (page) {
@@ -204,6 +213,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	bool remap = false, set_uncached = false;
+	bool mark_mem_decrypt = true;
 	bool allow_highmem = true;
 	struct page *page;
 	void *ret;
@@ -251,6 +261,14 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	    dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
+	if (is_swiotlb_for_alloc(dev)) {
+		page = dma_direct_alloc_swiotlb(dev, size, dma_handle);
+		if (page) {
+			mark_mem_decrypt = false;
+			goto setup_page;
+		}
+		return NULL;
+	}
 
 	if (force_dma_unencrypted(dev))
 		/*
@@ -266,6 +284,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	if (!page)
 		return NULL;
 
+setup_page:
 	/*
 	 * dma_alloc_contiguous can return highmem pages depending on a
 	 * combination the cma= arguments and per-arch setup.  These need to be
@@ -295,7 +314,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		ret = page_address(page);
 	}
 
-	if (force_dma_unencrypted(dev)) {
+	if (mark_mem_decrypt && force_dma_unencrypted(dev)) {
 		void *lm_addr;
 
 		lm_addr = page_address(page);
@@ -316,7 +335,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	return ret;
 
 out_encrypt_pages:
-	if (dma_set_encrypted(dev, page_address(page), size))
+	if (mark_mem_decrypt && dma_set_encrypted(dev, page_address(page), size))
 		return NULL;
 out_free_pages:
 	__dma_direct_free_pages(dev, page, size);
@@ -328,6 +347,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 void dma_direct_free(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
 {
+	bool mark_mem_encrypted = true;
 	unsigned int page_order = get_order(size);
 
 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
@@ -356,6 +376,9 @@ void dma_direct_free(struct device *dev, size_t size,
 	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
 		return;
 
+	if (swiotlb_find_pool(dev, dma_to_phys(dev, dma_addr)))
+		mark_mem_encrypted = false;
+
 	if (is_vmalloc_addr(cpu_addr)) {
 		vunmap(cpu_addr);
 	} else {
@@ -363,7 +386,7 @@ void dma_direct_free(struct device *dev, size_t size,
 			arch_dma_clear_uncached(cpu_addr, size);
 	}
 
-	if (force_dma_unencrypted(dev)) {
+	if (mark_mem_encrypted && force_dma_unencrypted(dev)) {
 		void *lm_addr;
 
 		lm_addr = phys_to_virt(dma_to_phys(dev, dma_addr));
@@ -385,6 +408,15 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
+	if (is_swiotlb_for_alloc(dev)) {
+		page = dma_direct_alloc_swiotlb(dev, size, dma_handle);
+		if (page && PageHighMem(page)) {
+			swiotlb_free(dev, page, size);
+			return NULL;
+		}
+		return page;
+	}
+
 	page = __dma_direct_alloc_pages(dev, size, gfp, false);
 	if (!page)
 		return NULL;
@@ -404,13 +436,17 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 		enum dma_data_direction dir)
 {
 	void *vaddr = page_address(page);
+	bool mark_mem_encrypted = true;
 
 	/* If cpu_addr is not from an atomic pool, dma_free_from_pool() fails */
 	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
 	    dma_free_from_pool(dev, vaddr, size))
 		return;
 
-	if (dma_set_encrypted(dev, vaddr, size))
+	if (swiotlb_find_pool(dev, page_to_phys(page)))
+		mark_mem_encrypted = false;
+
+	if (mark_mem_encrypted && dma_set_encrypted(dev, vaddr, size))
 		return;
 	__dma_direct_free_pages(dev, page, size);
 }
-- 
2.43.0

