Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B034E28F1
	for <iommu@lists.linux.dev>; Sun, 22 Sep 2024 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727014077; cv=none; b=CYpfdL04C5Hc4dAauSSvSNU9qHX+ZJemHt9TYjWQ2Y2HTxmlIBeV9+acQjjWNf62HCwf9Ix1AeyZBoaQTNyJ475XT9ZsdxR2bMR8SUTfIjZNBAUGuq+T0fEb2Ya3PT/oy+ELSc6BvZx5yuGdb2tX0wyPCk/+Ui21vY+PovDuvmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727014077; c=relaxed/simple;
	bh=D4lsXYmlXtVafr2+bF00vIFwv2/K53z+pHbpXvr+6Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEiIMaoXyhxzev2WEwqi28NlqyqONmJWjiJqspy/Puf2l1luNPC2nWRNZDDMJDgL/8Mt3VkO+ItZnet+aMnL6Z8r3MmHXMPlNP9SNq6yBQBuLVqmfGvXjGYOZpYjbfmDQ0K/bvbyX+yRqtRFTB4RXvdHO6q7jzjGi6YsPHBg2CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sw7M3MA3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sw7M3MA3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kFkco3vsboivjBe8YtkqQRuR0/5EyzW+YqMEqALWNlc=; b=sw7M3MA3fjRZjUyjp/Oq5e9jwq
	HFqqCQS2bm7zm62Idk8fmRmY6lsk2bllrkdUgK2SXXWA18V2fWAhpvfcv67CuCvxizkBGUHtRLw8k
	rZFz9TaNGVU+3EX1k3QQOZ0Tr5x6jZZxlKop7cVB/eUZ/3WYTrc4wuFSJfmakIt8URFcE6DT2ocMB
	5HOflQhHUnMpBnHuvM6/9X6xmJXcO8D5p8KGgQmbozoQXVDJAdyLdg/IipTjl1va+YjGNsSfO4qi6
	IScKmd/l9pNe0LRqZwOBK+BpPPv8fYWY7I+f83elnZR98Otl9Ba6+IpGPAcYJqPA5GlNb1qKP6cpL
	oJCyC2qg==;
Received: from 2a02-8389-2341-5b80-4a66-5554-3273-f061.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:4a66:5554:3273:f061] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1ssNFi-0000000FEtB-3sCW;
	Sun, 22 Sep 2024 14:07:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Xi Ruoyao <xry111@xry111.site>,
	Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 2/2] iommu/dma: remove most stubs in iommu-dma.h
Date: Sun, 22 Sep 2024 16:07:35 +0200
Message-ID: <20240922140743.1596763-3-hch@lst.de>
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

The direct calls from mapping.c all guarded by use_dma_iommu(), so don't
bother to provide stubs, but instead just expose the prototypes
unconditionally.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/iommu-dma.h | 108 +++-----------------------------------
 1 file changed, 8 insertions(+), 100 deletions(-)

diff --git a/include/linux/iommu-dma.h b/include/linux/iommu-dma.h
index 7bf145a52d6a1a..508beaa44c39e8 100644
--- a/include/linux/iommu-dma.h
+++ b/include/linux/iommu-dma.h
@@ -14,6 +14,13 @@ static inline bool use_dma_iommu(struct device *dev)
 {
 	return dev->dma_iommu;
 }
+#else
+static inline bool use_dma_iommu(struct device *dev)
+{
+	return false;
+}
+#endif /* CONFIG_IOMMU_DMA */
+
 dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, enum dma_data_direction dir,
 		unsigned long attrs);
@@ -58,104 +65,5 @@ void iommu_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl,
 		int nelems, enum dma_data_direction dir);
 void iommu_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
 		int nelems, enum dma_data_direction dir);
-#else
-static inline bool use_dma_iommu(struct device *dev)
-{
-	return false;
-}
-static inline dma_addr_t iommu_dma_map_page(struct device *dev,
-		struct page *page, unsigned long offset, size_t size,
-		enum dma_data_direction dir, unsigned long attrs)
-{
-	return DMA_MAPPING_ERROR;
-}
-static inline void iommu_dma_unmap_page(struct device *dev,
-		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-}
-static inline int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
-{
-	return -EINVAL;
-}
-static inline void iommu_dma_unmap_sg(struct device *dev,
-		struct scatterlist *sg, int nents, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-}
-static inline void *iommu_dma_alloc(struct device *dev, size_t size,
-		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
-{
-	return NULL;
-}
-static inline int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
-		void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		unsigned long attrs)
-{
-	return -EINVAL;
-}
-static inline int iommu_dma_get_sgtable(struct device *dev,
-		struct sg_table *sgt, void *cpu_addr, dma_addr_t dma_addr,
-		size_t size, unsigned long attrs)
-{
-	return -EINVAL;
-}
-static inline unsigned long iommu_dma_get_merge_boundary(struct device *dev)
-{
-	return 0;
-}
-static inline size_t iommu_dma_opt_mapping_size(void)
-{
-	return 0;
-}
-static inline size_t iommu_dma_max_mapping_size(struct device *dev)
-{
-	return 0;
-}
-static inline void iommu_dma_free(struct device *dev, size_t size,
-		void *cpu_addr, dma_addr_t handle, unsigned long attrs)
-{
-}
-static inline dma_addr_t iommu_dma_map_resource(struct device *dev,
-		phys_addr_t phys, size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-	return DMA_MAPPING_ERROR;
-}
-static inline void iommu_dma_unmap_resource(struct device *dev,
-		dma_addr_t handle, size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-}
-static inline struct sg_table *
-iommu_dma_alloc_noncontiguous(struct device *dev, size_t size,
-		enum dma_data_direction dir, gfp_t gfp, unsigned long attrs)
-{
-	return NULL;
-}
-static inline void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
-		struct sg_table *sgt, enum dma_data_direction dir)
-{
-}
-static inline void iommu_dma_sync_single_for_cpu(struct device *dev,
-		dma_addr_t dma_handle, size_t size,
-		enum dma_data_direction dir)
-{
-}
-static inline void iommu_dma_sync_single_for_device(struct device *dev,
-		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
-{
-}
-static inline void iommu_dma_sync_sg_for_cpu(struct device *dev,
-		struct scatterlist *sgl, int nelems,
-		enum dma_data_direction dir)
-{
-}
-static inline void iommu_dma_sync_sg_for_device(struct device *dev,
-		struct scatterlist *sgl, int nelems,
-		enum dma_data_direction dir)
-{
-}
-#endif /* CONFIG_IOMMU_DMA */
+
 #endif /* _LINUX_IOMMU_DMA_H */
-- 
2.45.2

