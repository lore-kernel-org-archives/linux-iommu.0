Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0970528F1
	for <iommu@lists.linux.dev>; Sun, 22 Sep 2024 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727014074; cv=none; b=r0t/R1dQz7j0mc/Bml9CbSbI2JIOisXHbyq+1Rm4PUgMrUSF/xfD4n4kznLfdpVJrdEVtdJSkmGgcIa57ACqJmcNftTpRFWgIToPZAuKxZKV1s1K5OnffM4VTA/HV/++JABebe0gMffSJWs5ilU7MwnTqjO78jKxHdrOX5N5DjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727014074; c=relaxed/simple;
	bh=oKn7YnT3hLGwPgSzDADpjpIrhv+JMZjEe2+6TAWZ5tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SY0K7K/TlFW1qi58GXhJRlOBXF16uoDq1L+5BWmoSmZSy18FEnQwWCbnIVgcwPnYcEw/zc9BCNeLsdCvBQmKjrKaqcf8hs2bQI7DOOWmJF4GMMsN+OpPYYSFpcxDVh/AgTQ57XvyNd3f4SXz0b6WzZL6P+Kz/0F7gbXR+jmmUUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QJmv+Cx1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QJmv+Cx1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=atH0nXsa5T5JfNkdiVGljuYMwk6Q3dhhjGBY5HXQk+s=; b=QJmv+Cx1ENXKTdDqoZ316yVe+a
	uaQLapwc9s/f9nvzgvvcR7iTzbX4bLUu4Y5wLyXhPVvTcaj9l/V69SytLZ82ZPsTlx/pcWC4eGetd
	zaHv6SkpS6CW/7QwNUEQtGyvTu1z+gxcI90grdnyuOxK0oiFNrJ1NcJwPJDPdrVZe1S5AI+ZOiqUA
	iXeGVpfOfqiAZP3LZmi/IsB3/Tb5aadZkN3bEY8ni7YgKnpXeMTSvCkq/U6ndkZomqYWoT311fjF4
	HMGQp/siSjQRvazxZd0Sa9YCbKFfnpYGFkx2/Sc9YOVYSU4JBtlTiDL3g+j3d2JhCe1o7YbWzMJwq
	9hfZBqyA==;
Received: from 2a02-8389-2341-5b80-4a66-5554-3273-f061.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:4a66:5554:3273:f061] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1ssNFg-0000000FEsp-07ue;
	Sun, 22 Sep 2024 14:07:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Xi Ruoyao <xry111@xry111.site>,
	Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 1/2] dma-mapping: fix vmap and mmap of noncontiougs allocations
Date: Sun, 22 Sep 2024 16:07:34 +0200
Message-ID: <20240922140743.1596763-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240922140743.1596763-1-hch@lst.de>
References: <20240922140743.1596763-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Commit b5c58b2fdc42 ("dma-mapping: direct calls for dma-iommu") switched
to use direct calls to dma-iommu, but missed the dma_vmap_noncontiguous,
dma_vunmap_noncontiguous and dma_mmap_noncontiguous behavior keyed off the
presence of the alloc_noncontiguous method.

Fix this by removing the now unused alloc_noncontiguous and
free_noncontiguous methods and moving the vmapping and mmaping of the
noncontiguous allocations into the iommu code, as it is the only provider
of actually noncontiguous allocations.

Fixes: b5c58b2fdc42 ("dma-mapping: direct calls for dma-iommu")
Reported-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Xi Ruoyao <xry111@xry111.site>
---
 drivers/iommu/dma-iommu.c   | 33 +++++++++++++++++++++++++++++++++
 include/linux/dma-map-ops.h | 19 -------------------
 include/linux/iommu-dma.h   |  6 ++++++
 kernel/dma/mapping.c        | 37 ++++++++++---------------------------
 4 files changed, 49 insertions(+), 46 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 3672d619bcb691..2a9fa0c8cc00fe 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1038,6 +1038,21 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
 	return NULL;
 }
 
+/*
+ * This is the actual return value from the iommu_dma_alloc_noncontiguous.
+ *
+ * The users of the DMA API should only care about the sg_table, but to make
+ * the DMA-API internal vmaping and freeing easier we stash away the page
+ * array as well (except for the fallback case).  This can go away any time,
+ * e.g. when a vmap-variant that takes a scatterlist comes along.
+ */
+struct dma_sgt_handle {
+	struct sg_table sgt;
+	struct page **pages;
+};
+#define sgt_handle(sgt) \
+	container_of((sgt), struct dma_sgt_handle, sgt)
+
 struct sg_table *iommu_dma_alloc_noncontiguous(struct device *dev, size_t size,
 	       enum dma_data_direction dir, gfp_t gfp, unsigned long attrs)
 {
@@ -1066,6 +1081,24 @@ void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
 	kfree(sh);
 }
 
+void *iommu_dma_vmap_noncontiguous(struct device *dev, size_t size,
+		struct sg_table *sgt)
+{
+	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+
+	return vmap(sgt_handle(sgt)->pages, count, VM_MAP, PAGE_KERNEL);
+}
+
+int iommu_dma_mmap_noncontiguous(struct device *dev, struct vm_area_struct *vma,
+		size_t size, struct sg_table *sgt)
+{
+	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+
+	if (vma->vm_pgoff >= count || vma_pages(vma) > count - vma->vm_pgoff)
+		return -ENXIO;
+	return vm_map_pages(vma, sgt_handle(sgt)->pages, count);
+}
+
 void iommu_dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
 		size_t size, enum dma_data_direction dir)
 {
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 9668ddf3696e71..b7773201414c27 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -24,11 +24,6 @@ struct dma_map_ops {
 			gfp_t gfp);
 	void (*free_pages)(struct device *dev, size_t size, struct page *vaddr,
 			dma_addr_t dma_handle, enum dma_data_direction dir);
-	struct sg_table *(*alloc_noncontiguous)(struct device *dev, size_t size,
-			enum dma_data_direction dir, gfp_t gfp,
-			unsigned long attrs);
-	void (*free_noncontiguous)(struct device *dev, size_t size,
-			struct sg_table *sgt, enum dma_data_direction dir);
 	int (*mmap)(struct device *, struct vm_area_struct *,
 			void *, dma_addr_t, size_t, unsigned long attrs);
 
@@ -206,20 +201,6 @@ static inline int dma_mmap_from_global_coherent(struct vm_area_struct *vma,
 }
 #endif /* CONFIG_DMA_GLOBAL_POOL */
 
-/*
- * This is the actual return value from the ->alloc_noncontiguous method.
- * The users of the DMA API should only care about the sg_table, but to make
- * the DMA-API internal vmaping and freeing easier we stash away the page
- * array as well (except for the fallback case).  This can go away any time,
- * e.g. when a vmap-variant that takes a scatterlist comes along.
- */
-struct dma_sgt_handle {
-	struct sg_table sgt;
-	struct page **pages;
-};
-#define sgt_handle(sgt) \
-	container_of((sgt), struct dma_sgt_handle, sgt)
-
 int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs);
diff --git a/include/linux/iommu-dma.h b/include/linux/iommu-dma.h
index 1bb55ca1ab79d7..7bf145a52d6a1a 100644
--- a/include/linux/iommu-dma.h
+++ b/include/linux/iommu-dma.h
@@ -44,6 +44,12 @@ struct sg_table *iommu_dma_alloc_noncontiguous(struct device *dev, size_t size,
 		enum dma_data_direction dir, gfp_t gfp, unsigned long attrs);
 void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
 		struct sg_table *sgt, enum dma_data_direction dir);
+void *iommu_dma_vmap_noncontiguous(struct device *dev, size_t size,
+		struct sg_table *sgt);
+#define iommu_dma_vunmap_noncontiguous(dev, vaddr) \
+	vunmap(vaddr);
+int iommu_dma_mmap_noncontiguous(struct device *dev, struct vm_area_struct *vma,
+		size_t size, struct sg_table *sgt);
 void iommu_dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
 		size_t size, enum dma_data_direction dir);
 void iommu_dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index b839683da0baf0..7911c754d9f42a 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -750,7 +750,6 @@ static struct sg_table *alloc_single_sgt(struct device *dev, size_t size,
 struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
 		enum dma_data_direction dir, gfp_t gfp, unsigned long attrs)
 {
-	const struct dma_map_ops *ops = get_dma_ops(dev);
 	struct sg_table *sgt;
 
 	if (WARN_ON_ONCE(attrs & ~DMA_ATTR_ALLOC_SINGLE_PAGES))
@@ -758,9 +757,7 @@ struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
 	if (WARN_ON_ONCE(gfp & __GFP_COMP))
 		return NULL;
 
-	if (ops && ops->alloc_noncontiguous)
-		sgt = ops->alloc_noncontiguous(dev, size, dir, gfp, attrs);
-	else if (use_dma_iommu(dev))
+	if (use_dma_iommu(dev))
 		sgt = iommu_dma_alloc_noncontiguous(dev, size, dir, gfp, attrs);
 	else
 		sgt = alloc_single_sgt(dev, size, dir, gfp);
@@ -786,13 +783,10 @@ static void free_single_sgt(struct device *dev, size_t size,
 void dma_free_noncontiguous(struct device *dev, size_t size,
 		struct sg_table *sgt, enum dma_data_direction dir)
 {
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-
 	trace_dma_unmap_sg(dev, sgt->sgl, sgt->orig_nents, dir, 0);
 	debug_dma_unmap_sg(dev, sgt->sgl, sgt->orig_nents, dir);
-	if (ops && ops->free_noncontiguous)
-		ops->free_noncontiguous(dev, size, sgt, dir);
-	else if (use_dma_iommu(dev))
+
+	if (use_dma_iommu(dev))
 		iommu_dma_free_noncontiguous(dev, size, sgt, dir);
 	else
 		free_single_sgt(dev, size, sgt, dir);
@@ -802,37 +796,26 @@ EXPORT_SYMBOL_GPL(dma_free_noncontiguous);
 void *dma_vmap_noncontiguous(struct device *dev, size_t size,
 		struct sg_table *sgt)
 {
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 
-	if (ops && ops->alloc_noncontiguous)
-		return vmap(sgt_handle(sgt)->pages, count, VM_MAP, PAGE_KERNEL);
+	if (use_dma_iommu(dev))
+		return iommu_dma_vmap_noncontiguous(dev, size, sgt);
+
 	return page_address(sg_page(sgt->sgl));
 }
 EXPORT_SYMBOL_GPL(dma_vmap_noncontiguous);
 
 void dma_vunmap_noncontiguous(struct device *dev, void *vaddr)
 {
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-
-	if (ops && ops->alloc_noncontiguous)
-		vunmap(vaddr);
+	if (use_dma_iommu(dev))
+		iommu_dma_vunmap_noncontiguous(dev, vaddr);
 }
 EXPORT_SYMBOL_GPL(dma_vunmap_noncontiguous);
 
 int dma_mmap_noncontiguous(struct device *dev, struct vm_area_struct *vma,
 		size_t size, struct sg_table *sgt)
 {
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-
-	if (ops && ops->alloc_noncontiguous) {
-		unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-
-		if (vma->vm_pgoff >= count ||
-		    vma_pages(vma) > count - vma->vm_pgoff)
-			return -ENXIO;
-		return vm_map_pages(vma, sgt_handle(sgt)->pages, count);
-	}
+	if (use_dma_iommu(dev))
+		return iommu_dma_mmap_noncontiguous(dev, vma, size, sgt);
 	return dma_mmap_pages(dev, vma, size, sg_page(sgt->sgl));
 }
 EXPORT_SYMBOL_GPL(dma_mmap_noncontiguous);
-- 
2.45.2

