Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A347201269
	for <iommu@lists.linux.dev>; Thu, 17 Jul 2025 06:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752734846; cv=none; b=b4W+HZGHiPpteuVCmCqgqPXcfzIzP/optxyg5v5kcgGCKIUamlHJELlsQuiMASi5n7M4gtSAZN+3DGx5hzLgL9QuXEP6iMKPhOQqVqX14jw18gxwjMaNha/lsOH2b0R/S/845lSrg+cr2QwKLAO6Z5U0v5qz46t/cywukpxEZ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752734846; c=relaxed/simple;
	bh=cedeX/JicN4K/QmOAd1yHh8y14ztJUkiMX6MurPYc+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gS+nE7B6YP1Q6cwQP0Dm5TSDPcWSqcFOGWg0p9t7B0mduCqdlK1MXKwWi0IlYfrQjXtScz135PkUher6ItFs14z+ymYIaimyDE2Gv860atOuxczcD09qMHNcywh08+664evEm+sIehBSkHPC+TG9/bsTkqlGwejGSKuXdfZne/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlC1iNbP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlC1iNbP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C64C4CEE3;
	Thu, 17 Jul 2025 06:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752734845;
	bh=cedeX/JicN4K/QmOAd1yHh8y14ztJUkiMX6MurPYc+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AlC1iNbPzshTuupJhuyQVKAJgRzC0OYK4DVluS6ImGWvjSreBKrfVq4XC4iNYbSZ7
	 1aabYkdxpDP/bSe/ks+g07Fzv0drJF79MzzPhfR7CwQZiCzfuzopEXmDpDlOxbpZTU
	 wOV2hvKNcIdlqV/W72MnCnEPiAnEMd/lMYdZkcw2VWnQDN5Nua/R8zn1mR3mtOMoqy
	 Ip+/qnVhy7ZkscrJd+KmdwNnQv1d1CuqbOzH/aCRX0GrnmEb2SZwFJDdejko1zi1q9
	 qLVhDcYLdn2avlwfI6Dn7kdNx5D5HliUv30A27dc5eUj0p027Y23LKrk6K/N0uPo2f
	 b79Gaa9OjSf1w==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	iommu@lists.linux.dev
Subject: [PATCH 1/2] dma-mapping: prepare dma_map_ops to conversion to physical address
Date: Thu, 17 Jul 2025 09:47:09 +0300
Message-ID: <1798a3351dcabccaf0749221e9e9b66585a7b2c6.1752734252.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752734252.git.leon@kernel.org>
References: <cover.1752734252.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Add new .map_phys() and .unmap_phys() callbacks to dma_map_ops as a
preparation to replace .map_page() and .unmap_page() respectively.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/dma-map-ops.h |  6 ++++++
 kernel/dma/mapping.c        | 24 ++++++++++++++++++++----
 kernel/dma/ops_helpers.c    | 14 +++++++++++---
 3 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 71f5b30254159..0048ec28ed43b 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -37,6 +37,12 @@ struct dma_map_ops {
 	void (*unmap_page)(struct device *dev, dma_addr_t dma_handle,
 			size_t size, enum dma_data_direction dir,
 			unsigned long attrs);
+	dma_addr_t (*map_phys)(struct device *dev, phys_addr_t phys,
+			size_t size, enum dma_data_direction dir,
+			unsigned long attrs);
+	void (*unmap_phys)(struct device *dev, dma_addr_t dma_handle,
+			size_t size, enum dma_data_direction dir,
+			unsigned long attrs);
 	/*
 	 * map_sg should return a negative error code on error. See
 	 * dma_map_sgtable() for a list of appropriate error codes
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 8d29ff76aa4db..e1586eb52ab34 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -173,9 +173,13 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 		size_t offset = offset_in_page(phys);
 		bool is_pfn_valid = true;
 
-		if (IS_ENABLED(CONFIG_DMA_API_DEBUG))
+		if (IS_ENABLED(CONFIG_DMA_API_DEBUG)) {
 			is_pfn_valid = pfn_valid(PHYS_PFN(phys));
 
+			/* We shouldn't have both functions */
+			WARN_ON_ONCE(ops->map_page && ops->map_phys);
+		}
+
 		if (unlikely(!is_pfn_valid))
 			return DMA_MAPPING_ERROR;
 
@@ -183,7 +187,11 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 		 * All platforms which implement .map_page() don't support
 		 * non-struct page backed addresses.
 		 */
-		addr = ops->map_page(dev, page, offset, size, dir, attrs);
+		if (ops->map_phys)
+			addr = ops->map_phys(dev, phys, size, dir, attrs);
+		if (ops->map_page)
+			addr = ops->map_page(dev, page, offset, size, dir,
+					     attrs);
 	}
 
 	kmsan_handle_dma(phys, size, dir);
@@ -213,8 +221,16 @@ void dma_unmap_phys(struct device *dev, dma_addr_t addr, size_t size,
 		dma_direct_unmap_phys(dev, addr, size, dir, attrs);
 	else if (use_dma_iommu(dev))
 		iommu_dma_unmap_phys(dev, addr, size, dir, attrs);
-	else
-		ops->unmap_page(dev, addr, size, dir, attrs);
+	else {
+		if (IS_ENABLED(CONFIG_DMA_API_DEBUG))
+			/* We shouldn't have both functions */
+			WARN_ON_ONCE(ops->unmap_page && ops->unmap_phys);
+
+		if (ops->unmap_phys)
+			ops->unmap_phys(dev, addr, size, dir, attrs);
+		if (ops->unmap_page)
+			ops->unmap_page(dev, addr, size, dir, attrs);
+	}
 	trace_dma_unmap_phys(dev, addr, size, dir, attrs);
 	debug_dma_unmap_phys(dev, addr, size, dir);
 }
diff --git a/kernel/dma/ops_helpers.c b/kernel/dma/ops_helpers.c
index 6f9d604d9d406..64daa1428c022 100644
--- a/kernel/dma/ops_helpers.c
+++ b/kernel/dma/ops_helpers.c
@@ -64,6 +64,7 @@ struct page *dma_common_alloc_pages(struct device *dev, size_t size,
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	struct page *page;
+	phys_addr_t phys;
 
 	page = dma_alloc_contiguous(dev, size, gfp);
 	if (!page)
@@ -71,10 +72,14 @@ struct page *dma_common_alloc_pages(struct device *dev, size_t size,
 	if (!page)
 		return NULL;
 
+	phys = page_to_phys(page);
 	if (use_dma_iommu(dev))
-		*dma_handle = iommu_dma_map_phys(dev, page_to_phys(page), size,
-						 dir, DMA_ATTR_SKIP_CPU_SYNC);
-	else
+		*dma_handle = iommu_dma_map_phys(dev, phys, size, dir,
+						 DMA_ATTR_SKIP_CPU_SYNC);
+	else if (ops->map_phys)
+		*dma_handle = ops->map_phys(dev, phys, size, dir,
+					    DMA_ATTR_SKIP_CPU_SYNC);
+	else if (ops->map_page)
 		*dma_handle = ops->map_page(dev, page, 0, size, dir,
 					    DMA_ATTR_SKIP_CPU_SYNC);
 	if (*dma_handle == DMA_MAPPING_ERROR) {
@@ -94,6 +99,9 @@ void dma_common_free_pages(struct device *dev, size_t size, struct page *page,
 	if (use_dma_iommu(dev))
 		iommu_dma_unmap_phys(dev, dma_handle, size, dir,
 				     DMA_ATTR_SKIP_CPU_SYNC);
+	else if (ops->unmap_phys)
+		ops->unmap_phys(dev, dma_handle, size, dir,
+				DMA_ATTR_SKIP_CPU_SYNC);
 	else if (ops->unmap_page)
 		ops->unmap_page(dev, dma_handle, size, dir,
 				DMA_ATTR_SKIP_CPU_SYNC);
-- 
2.50.1

