Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE642E6125;
	Tue, 16 Sep 2025 07:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758007960; cv=none; b=egXSJBbzPWkMWlAXPxr4SzP03azrG/ZYFxf53F694Y8XR4Fpf3stZ/yD+xH3STFO26FzkHfIK9KHMkJjM5W9EXTOpj3OerJsfoUtPLfquy1zXj93Den1znktUNgwRU3XXANQ4lrT7Td0eiybMYSaKv2/7gz/+egMapF/fAcOJ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758007960; c=relaxed/simple;
	bh=kUYFBenADcxWEIkMcS5X6cr9mnZCRnsHRUZt71pILDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ph5Hsx7OMmlQkmh2o4CIV6DKMyu4Qj63io6GvcgjHjgm94nrJGYlYO6TVFJAdNUs30nlsV/caI4SfxRHZU20vsaWBTdFbGLD3MIRFLQElVsRkzAo/EuLgP55SMqN0q5n0MhJQkZT28BNgu16nVeICQtcWz31fpL6wHYqqNelgCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slkDelnU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slkDelnU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77D5C4CEEB;
	Tue, 16 Sep 2025 07:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758007960;
	bh=kUYFBenADcxWEIkMcS5X6cr9mnZCRnsHRUZt71pILDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=slkDelnUvu1wE1DNBRGuDkLKyC9fJzIbH4HwqeHaMZMTJUCcJeCozRfAwVYllPllC
	 O0/L5xJpkA9hHF7R4hDCj0RqxzRU+WUdn370WWgCQ8oW4FX01BoLV/d+4Yx3SZeJXS
	 j0oYZYHN7uVp4IYnczIjCbrkvkfUDESxBAII/mkPrGGH5embRxwO77HbHhybkY85qC
	 vOTuB7WnVaX0YTItdigV8lPkUyR807sue67pMqMQWLhCiHorAjt9dp4Jl/Wvtyw25E
	 LsB0zLd59TLPrflh8wHQwIDCHcN1oI8NDFz8MACAwmCznmjo/0tRZi8vjafxf6GKb+
	 LuYTSlH26EbHw==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v3 3/4] ARM: dma-mapping: Switch to physical address mapping callbacks
Date: Tue, 16 Sep 2025 10:32:06 +0300
Message-ID: <5f96e44b1fb5d92a6a5f25fc9148a733a1a53b9d.1758006942.git.leon@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758006942.git.leon@kernel.org>
References: <cover.1758006942.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Combine resource and page mappings routines to one function, which
handles both these flows at the same manner. This conversion allows
us to remove .map_resource/.unmap_resource callbacks completely.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 arch/arm/mm/dma-mapping.c | 98 +++++++++------------------------------
 1 file changed, 22 insertions(+), 76 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 88c2d68a69c9e..e0d65414b39e1 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -737,6 +737,9 @@ static int __dma_info_to_prot(enum dma_data_direction dir, unsigned long attrs)
 	if (attrs & DMA_ATTR_PRIVILEGED)
 		prot |= IOMMU_PRIV;
 
+	if (attrs & DMA_ATTR_MMIO)
+		prot |= IOMMU_MMIO;
+
 	switch (dir) {
 	case DMA_BIDIRECTIONAL:
 		return prot | IOMMU_READ | IOMMU_WRITE;
@@ -1356,25 +1359,27 @@ static void arm_iommu_sync_sg_for_device(struct device *dev,
 }
 
 /**
- * arm_iommu_map_page
+ * arm_iommu_map_phys
  * @dev: valid struct device pointer
- * @page: page that buffer resides in
- * @offset: offset into page for start of buffer
+ * @phys: physical address that buffer resides in
  * @size: size of buffer to map
  * @dir: DMA transfer direction
+ * @attrs: DMA mapping attributes
  *
  * IOMMU aware version of arm_dma_map_page()
  */
-static dma_addr_t arm_iommu_map_page(struct device *dev, struct page *page,
-	     unsigned long offset, size_t size, enum dma_data_direction dir,
-	     unsigned long attrs)
+static dma_addr_t arm_iommu_map_phys(struct device *dev, phys_addr_t phys,
+	     size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+	int len = PAGE_ALIGN(size + offset_in_page(phys));
+	phys_addr_t addr = phys_addr & PAGE_MASK;
 	dma_addr_t dma_addr;
-	int ret, prot, len = PAGE_ALIGN(size + offset);
+	int ret, prot;
 
-	if (!dev->dma_coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		__dma_page_cpu_to_dev(page, offset, size, dir);
+	if (!dev->dma_coherent &&
+	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
+		__dma_page_cpu_to_dev(phys_to_page(phys), offset, size, dir);
 
 	dma_addr = __alloc_iova(mapping, len);
 	if (dma_addr == DMA_MAPPING_ERROR)
@@ -1382,8 +1387,7 @@ static dma_addr_t arm_iommu_map_page(struct device *dev, struct page *page,
 
 	prot = __dma_info_to_prot(dir, attrs);
 
-	ret = iommu_map(mapping->domain, dma_addr, page_to_phys(page), len,
-			prot, GFP_KERNEL);
+	ret = iommu_map(mapping->domain, dma_addr, addr, len, prot, GFP_KERNEL);
 	if (ret < 0)
 		goto fail;
 
@@ -1399,10 +1403,11 @@ static dma_addr_t arm_iommu_map_page(struct device *dev, struct page *page,
  * @handle: DMA address of buffer
  * @size: size of buffer (same as passed to dma_map_page)
  * @dir: DMA transfer direction (same as passed to dma_map_page)
+ * @attrs: DMA mapping attributes
  *
- * IOMMU aware version of arm_dma_unmap_page()
+ * IOMMU aware version of arm_dma_unmap_phys()
  */
-static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
+static void arm_iommu_unmap_phys(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
@@ -1414,7 +1419,8 @@ static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
 	if (!iova)
 		return;
 
-	if (!dev->dma_coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
+	if (!dev->dma_coherent &&
+	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))) {
 		page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
 		__dma_page_dev_to_cpu(page, offset, size, dir);
 	}
@@ -1423,63 +1429,6 @@ static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
 	__free_iova(mapping, iova, len);
 }
 
-/**
- * arm_iommu_map_resource - map a device resource for DMA
- * @dev: valid struct device pointer
- * @phys_addr: physical address of resource
- * @size: size of resource to map
- * @dir: DMA transfer direction
- */
-static dma_addr_t arm_iommu_map_resource(struct device *dev,
-		phys_addr_t phys_addr, size_t size,
-		enum dma_data_direction dir, unsigned long attrs)
-{
-	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
-	dma_addr_t dma_addr;
-	int ret, prot;
-	phys_addr_t addr = phys_addr & PAGE_MASK;
-	unsigned int offset = phys_addr & ~PAGE_MASK;
-	size_t len = PAGE_ALIGN(size + offset);
-
-	dma_addr = __alloc_iova(mapping, len);
-	if (dma_addr == DMA_MAPPING_ERROR)
-		return dma_addr;
-
-	prot = __dma_info_to_prot(dir, attrs) | IOMMU_MMIO;
-
-	ret = iommu_map(mapping->domain, dma_addr, addr, len, prot, GFP_KERNEL);
-	if (ret < 0)
-		goto fail;
-
-	return dma_addr + offset;
-fail:
-	__free_iova(mapping, dma_addr, len);
-	return DMA_MAPPING_ERROR;
-}
-
-/**
- * arm_iommu_unmap_resource - unmap a device DMA resource
- * @dev: valid struct device pointer
- * @dma_handle: DMA address to resource
- * @size: size of resource to map
- * @dir: DMA transfer direction
- */
-static void arm_iommu_unmap_resource(struct device *dev, dma_addr_t dma_handle,
-		size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
-	dma_addr_t iova = dma_handle & PAGE_MASK;
-	unsigned int offset = dma_handle & ~PAGE_MASK;
-	size_t len = PAGE_ALIGN(size + offset);
-
-	if (!iova)
-		return;
-
-	iommu_unmap(mapping->domain, iova, len);
-	__free_iova(mapping, iova, len);
-}
-
 static void arm_iommu_sync_single_for_cpu(struct device *dev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir)
 {
@@ -1516,8 +1465,8 @@ static const struct dma_map_ops iommu_ops = {
 	.mmap		= arm_iommu_mmap_attrs,
 	.get_sgtable	= arm_iommu_get_sgtable,
 
-	.map_page		= arm_iommu_map_page,
-	.unmap_page		= arm_iommu_unmap_page,
+	.map_phys		= arm_iommu_map_phys,
+	.unmap_phys		= arm_iommu_unmap_phys,
 	.sync_single_for_cpu	= arm_iommu_sync_single_for_cpu,
 	.sync_single_for_device	= arm_iommu_sync_single_for_device,
 
@@ -1525,9 +1474,6 @@ static const struct dma_map_ops iommu_ops = {
 	.unmap_sg		= arm_iommu_unmap_sg,
 	.sync_sg_for_cpu	= arm_iommu_sync_sg_for_cpu,
 	.sync_sg_for_device	= arm_iommu_sync_sg_for_device,
-
-	.map_resource		= arm_iommu_map_resource,
-	.unmap_resource		= arm_iommu_unmap_resource,
 };
 
 /**
-- 
2.51.0

