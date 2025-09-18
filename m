Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567E5313299;
	Thu, 18 Sep 2025 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204609; cv=none; b=lrif59v1t6PbOXeKr94lF0p74GjfQ5BAHNoH0fFJyFwTYZN7T0BfbEN804yp3wK80Lh+XrQJvTsqUHm0wn6gXsL80Bw6tu0utMg87IwL6GHbDlsFG6TYdWoriPswPzDvyplD9mCIUk70RiOLMqkmF/mAeAw8tdSUqG1NqzVblLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204609; c=relaxed/simple;
	bh=7ctlDOwNiFgZVAZcPGLZSJOnlazVmdQdCYwzHXR5exA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUQMMV4ub8HPerw3XVleGMus0VIRD3ICfXa1zA2Ahh9P8cD1dGAoPWJ/Q7lr4k8UQeSS7UsgZkAzYqdpbrv5acZBw8bWGQXoUgYfKYcD6KsrZRQglvllh3ZTl9nd/ww4is8A2K2DFQ2idKT+Ic76LrrWi7JZT9FJ80zpfl9SnjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyqwu64B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyqwu64B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767C8C4CEE7;
	Thu, 18 Sep 2025 14:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758204609;
	bh=7ctlDOwNiFgZVAZcPGLZSJOnlazVmdQdCYwzHXR5exA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oyqwu64BZu6RjG9CnpKCr3myw4HDldvhOSfCWTkgNiDvrlE8uIAhIfcBCeVXmGVZ1
	 7umCbbQ1rkX/ipSoOD/4RSe4fc3dPqQlnTQQPXW5mgROoLKyXZGyhuVeRO8vVC4Bm4
	 Ya5UjyQSZykWjAs/mbE6JiW1lGgrnuInyF64+7D0FD+3db1GQBVAoxo7SV2P7U2vO/
	 XrBA0HfGqAPvG/9WZFcnNE3y7efxI0z4oHvfJRZDszI58XGdtYFbilpCXKZX1Q7ai2
	 +C+GLYL87J6QpD7PHzQDnkJX7tmCDP6r6jfMMWEd+mSevtuOibCVA8pXdo+pUAobaV
	 SyMXCEQEsZLOA==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	iommu@lists.linux.dev,
	Juergen Gross <jgross@suse.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Stefano Stabellini <sstabellini@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: [PATCH v4 3/6] ARM: dma-mapping: Reduce struct page exposure in arch_sync_dma*()
Date: Thu, 18 Sep 2025 17:09:26 +0300
Message-ID: <2f20069c2b616808c034ba4e75905820b94e0e22.1758203802.git.leon@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758203802.git.leon@kernel.org>
References: <cover.1758203802.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

As a preparation to changing from .map_page to use .map_phys DMA
callbacks, convert arch_sync_dma*() functions to use physical addresses
instead of struct page.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 arch/arm/mm/dma-mapping.c | 82 +++++++++++++++------------------------
 1 file changed, 31 insertions(+), 51 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 88c2d68a69c9e..449fe6bf525e5 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -624,16 +624,14 @@ static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 	kfree(buf);
 }
 
-static void dma_cache_maint_page(struct page *page, unsigned long offset,
-	size_t size, enum dma_data_direction dir,
+static void dma_cache_maint_page(phys_addr_t phys, size_t size,
+	enum dma_data_direction dir,
 	void (*op)(const void *, size_t, int))
 {
-	unsigned long pfn;
+	unsigned long offset = offset_in_page(phys);
+	unsigned long pfn = __phys_to_pfn(phys);
 	size_t left = size;
 
-	pfn = page_to_pfn(page) + offset / PAGE_SIZE;
-	offset %= PAGE_SIZE;
-
 	/*
 	 * A single sg entry may refer to multiple physically contiguous
 	 * pages.  But we still need to process highmem pages individually.
@@ -644,17 +642,18 @@ static void dma_cache_maint_page(struct page *page, unsigned long offset,
 		size_t len = left;
 		void *vaddr;
 
-		page = pfn_to_page(pfn);
-
-		if (PageHighMem(page)) {
+		phys = __pfn_to_phys(pfn);
+		if (PhysHighMem(phys)) {
 			if (len + offset > PAGE_SIZE)
 				len = PAGE_SIZE - offset;
 
 			if (cache_is_vipt_nonaliasing()) {
-				vaddr = kmap_atomic(page);
+				vaddr = kmap_atomic_pfn(pfn);
 				op(vaddr + offset, len, dir);
 				kunmap_atomic(vaddr);
 			} else {
+				struct page *page = phys_to_page(phys);
+
 				vaddr = kmap_high_get(page);
 				if (vaddr) {
 					op(vaddr + offset, len, dir);
@@ -662,7 +661,8 @@ static void dma_cache_maint_page(struct page *page, unsigned long offset,
 				}
 			}
 		} else {
-			vaddr = page_address(page) + offset;
+			phys += offset;
+			vaddr = phys_to_virt(phys);
 			op(vaddr, len, dir);
 		}
 		offset = 0;
@@ -676,14 +676,11 @@ static void dma_cache_maint_page(struct page *page, unsigned long offset,
  * Note: Drivers should NOT use this function directly.
  * Use the driver DMA support - see dma-mapping.h (dma_sync_*)
  */
-static void __dma_page_cpu_to_dev(struct page *page, unsigned long off,
-	size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
+			      enum dma_data_direction dir)
 {
-	phys_addr_t paddr;
-
-	dma_cache_maint_page(page, off, size, dir, dmac_map_area);
+	dma_cache_maint_page(paddr, size, dir, dmac_map_area);
 
-	paddr = page_to_phys(page) + off;
 	if (dir == DMA_FROM_DEVICE) {
 		outer_inv_range(paddr, paddr + size);
 	} else {
@@ -692,17 +689,15 @@ static void __dma_page_cpu_to_dev(struct page *page, unsigned long off,
 	/* FIXME: non-speculating: flush on bidirectional mappings? */
 }
 
-static void __dma_page_dev_to_cpu(struct page *page, unsigned long off,
-	size_t size, enum dma_data_direction dir)
+void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
+			   enum dma_data_direction dir)
 {
-	phys_addr_t paddr = page_to_phys(page) + off;
-
 	/* FIXME: non-speculating: not required */
 	/* in any case, don't bother invalidating if DMA to device */
 	if (dir != DMA_TO_DEVICE) {
 		outer_inv_range(paddr, paddr + size);
 
-		dma_cache_maint_page(page, off, size, dir, dmac_unmap_area);
+		dma_cache_maint_page(paddr, size, dir, dmac_unmap_area);
 	}
 
 	/*
@@ -1205,7 +1200,7 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
 		unsigned int len = PAGE_ALIGN(s->offset + s->length);
 
 		if (!dev->dma_coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-			__dma_page_cpu_to_dev(sg_page(s), s->offset, s->length, dir);
+			arch_sync_dma_for_device(sg_phys(s), s->length, dir);
 
 		prot = __dma_info_to_prot(dir, attrs);
 
@@ -1307,8 +1302,7 @@ static void arm_iommu_unmap_sg(struct device *dev,
 			__iommu_remove_mapping(dev, sg_dma_address(s),
 					       sg_dma_len(s));
 		if (!dev->dma_coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-			__dma_page_dev_to_cpu(sg_page(s), s->offset,
-					      s->length, dir);
+			arch_sync_dma_for_cpu(sg_phys(s), s->length, dir);
 	}
 }
 
@@ -1330,7 +1324,7 @@ static void arm_iommu_sync_sg_for_cpu(struct device *dev,
 		return;
 
 	for_each_sg(sg, s, nents, i)
-		__dma_page_dev_to_cpu(sg_page(s), s->offset, s->length, dir);
+		arch_sync_dma_for_cpu(sg_phys(s), s->length, dir);
 
 }
 
@@ -1352,7 +1346,7 @@ static void arm_iommu_sync_sg_for_device(struct device *dev,
 		return;
 
 	for_each_sg(sg, s, nents, i)
-		__dma_page_cpu_to_dev(sg_page(s), s->offset, s->length, dir);
+		arch_sync_dma_for_device(sg_phys(s), s->length, dir);
 }
 
 /**
@@ -1374,7 +1368,7 @@ static dma_addr_t arm_iommu_map_page(struct device *dev, struct page *page,
 	int ret, prot, len = PAGE_ALIGN(size + offset);
 
 	if (!dev->dma_coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		__dma_page_cpu_to_dev(page, offset, size, dir);
+		arch_sync_dma_for_device(page_to_phys(page), offset, size, dir);
 
 	dma_addr = __alloc_iova(mapping, len);
 	if (dma_addr == DMA_MAPPING_ERROR)
@@ -1407,7 +1401,6 @@ static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	dma_addr_t iova = handle & PAGE_MASK;
-	struct page *page;
 	int offset = handle & ~PAGE_MASK;
 	int len = PAGE_ALIGN(size + offset);
 
@@ -1415,8 +1408,9 @@ static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
 		return;
 
 	if (!dev->dma_coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
-		page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
-		__dma_page_dev_to_cpu(page, offset, size, dir);
+		phys_addr_t phys = iommu_iova_to_phys(mapping->domain, iova);
+
+		arch_sync_dma_for_cpu(phys + offset, size, dir);
 	}
 
 	iommu_unmap(mapping->domain, iova, len);
@@ -1485,14 +1479,14 @@ static void arm_iommu_sync_single_for_cpu(struct device *dev,
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	dma_addr_t iova = handle & PAGE_MASK;
-	struct page *page;
 	unsigned int offset = handle & ~PAGE_MASK;
+	phys_addr_t phys;
 
 	if (dev->dma_coherent || !iova)
 		return;
 
-	page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
-	__dma_page_dev_to_cpu(page, offset, size, dir);
+	phys = iommu_iova_to_phys(mapping->domain, iova);
+	arch_sync_dma_for_cpu(phys + offset, size, dir);
 }
 
 static void arm_iommu_sync_single_for_device(struct device *dev,
@@ -1500,14 +1494,14 @@ static void arm_iommu_sync_single_for_device(struct device *dev,
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	dma_addr_t iova = handle & PAGE_MASK;
-	struct page *page;
 	unsigned int offset = handle & ~PAGE_MASK;
+	phys_addr_t phys;
 
 	if (dev->dma_coherent || !iova)
 		return;
 
-	page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
-	__dma_page_cpu_to_dev(page, offset, size, dir);
+	phys = iommu_iova_to_phys(mapping->domain, iova);
+	arch_sync_dma_for_device(phys + offset, size, dir);
 }
 
 static const struct dma_map_ops iommu_ops = {
@@ -1794,20 +1788,6 @@ void arch_teardown_dma_ops(struct device *dev)
 	set_dma_ops(dev, NULL);
 }
 
-void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
-		enum dma_data_direction dir)
-{
-	__dma_page_cpu_to_dev(phys_to_page(paddr), paddr & (PAGE_SIZE - 1),
-			      size, dir);
-}
-
-void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
-		enum dma_data_direction dir)
-{
-	__dma_page_dev_to_cpu(phys_to_page(paddr), paddr & (PAGE_SIZE - 1),
-			      size, dir);
-}
-
 void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs)
 {
-- 
2.51.0

