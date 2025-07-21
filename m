Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CD41E835B
	for <iommu@lists.linux.dev>; Mon, 21 Jul 2025 06:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753078812; cv=none; b=qsyxRub9NjbZNQzE6Xr3KaGUoGTAJcOg2yU0id3WSkC6M63uUNHvpyfu2XigXfQfEhQyrm6fPXRkuHw6mu6mqYp3l/kmBebLAG+R6ixpa5s+JNhHVVJCtjQQrAiwC4k0ZDjh2bXME2oUo7+wXmk9RL75am0xb41BXasheGWauC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753078812; c=relaxed/simple;
	bh=7js3OSSZn/BeRGPz+u8S4VAjGLIYKm/HN5eBTZ8MFAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdmIs18Q7yZXWvyGOoWOF5rIV6P+ZTgOYWvFme5mMj1EItIPZWs4esTNv223blernVYQzLS+WhqxSPkiShQV7CcciQLMsTd/Q2/mWhtiVKeowqXWodui4ifRQ8YVtRewwkPggr3VZtxByOjQVuo0/FlbsqNzcJTdjmwbiUXmY/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLz/RNa8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLz/RNa8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783F6C4CEED;
	Mon, 21 Jul 2025 06:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753078812;
	bh=7js3OSSZn/BeRGPz+u8S4VAjGLIYKm/HN5eBTZ8MFAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RLz/RNa8x72FezNSio8aytNLhtW3CU949RuigMEdw5iPahW+AZHi4L58nVkuupi34
	 BbXksAAyHqV8uHa7KLevu8c/ee3nI5I35F0shgHR4IfIl3e3WCvHsCPtEZ8kQkjGFL
	 CAnQzJSReOj/snukQVGHPmzK6w5ugGy1FoiEFuHO1Nc+4z0EmSBDeectlQS8daR3wO
	 xM3e041bsdscibcGn9gMOfXoBo8cE0KYQlrqmIKRD3YOybPWIk3JRoJbhL+ojrjl/O
	 O6goRenw/FtSzKAZgEUb7Zb3gqdg1/ECN4MEgtLFZnpQDO9OPK4CGAOXw3i/m8lfsv
	 gQeS91XjYDwhQ==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	iommu@lists.linux.dev
Subject: [PATCH v2 1/2] dma-mapping: prepare dma_map_ops to conversion to physical address
Date: Mon, 21 Jul 2025 09:19:45 +0300
Message-ID: <ad2de26c2aa8d4abcbe8e14b58e9c3cf831faecb.1753078569.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1753078569.git.leon@kernel.org>
References: <cover.1753078569.git.leon@kernel.org>
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
 kernel/dma/mapping.c        | 26 ++++++++++++++++++++++----
 kernel/dma/ops_helpers.c    | 17 ++++++++++++++---
 3 files changed, 42 insertions(+), 7 deletions(-)

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
index 8d29ff76aa4db..c2400bf6f67d1 100644
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
 
@@ -183,7 +187,13 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 		 * All platforms which implement .map_page() don't support
 		 * non-struct page backed addresses.
 		 */
-		addr = ops->map_page(dev, page, offset, size, dir, attrs);
+		if (ops->map_phys)
+			addr = ops->map_phys(dev, phys, size, dir, attrs);
+		else if (ops->map_page)
+			addr = ops->map_page(dev, page, offset, size, dir,
+					     attrs);
+		else
+			addr = DMA_MAPPING_ERROR;
 	}
 
 	kmsan_handle_dma(phys, size, dir);
@@ -213,8 +223,16 @@ void dma_unmap_phys(struct device *dev, dma_addr_t addr, size_t size,
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
+		else if (ops->unmap_page)
+			ops->unmap_page(dev, addr, size, dir, attrs);
+	}
 	trace_dma_unmap_phys(dev, addr, size, dir, attrs);
 	debug_dma_unmap_phys(dev, addr, size, dir);
 }
diff --git a/kernel/dma/ops_helpers.c b/kernel/dma/ops_helpers.c
index 6f9d604d9d406..84ce3a3ad7fd1 100644
--- a/kernel/dma/ops_helpers.c
+++ b/kernel/dma/ops_helpers.c
@@ -64,6 +64,7 @@ struct page *dma_common_alloc_pages(struct device *dev, size_t size,
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	struct page *page;
+	phys_addr_t phys;
 
 	page = dma_alloc_contiguous(dev, size, gfp);
 	if (!page)
@@ -71,12 +72,19 @@ struct page *dma_common_alloc_pages(struct device *dev, size_t size,
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
+	else
+		*dma_handle = DMA_MAPPING_ERROR;
+
 	if (*dma_handle == DMA_MAPPING_ERROR) {
 		dma_free_contiguous(dev, page, size);
 		return NULL;
@@ -94,6 +102,9 @@ void dma_common_free_pages(struct device *dev, size_t size, struct page *page,
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

