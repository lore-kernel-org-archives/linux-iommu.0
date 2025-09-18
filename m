Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABB4313D4B;
	Thu, 18 Sep 2025 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204613; cv=none; b=JAcvbNDavuVTtmTYx1q2JEPfIACKVxj+sXE3btjOTbEpGtrg28hrthvPt6gwxrkg6a6RcMKJ2fzB8MJUyyHrKQHHGNve+4htkcrqC0ocvQHuuJ66GCgIEW+fRtMRJaTW9BZvi/oQHMsQDtNpfk4Rhxn151wdys4G9gBSYaJnAzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204613; c=relaxed/simple;
	bh=EBwyVcXAx8ZG32+m2XXWq6jJ96SEAu9YsPWb4/XSEXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNtyYMhDReo3wFfexPAh+rkslsE3DRL+f0GxcvotwEzFNmhS9f19hJgAebjTAqZ0X7w5C3ymdf4i/D12m6UQ5Px3G4MKcq/c8A0opXnP+fVTVLlEYciyI+hPJwa0x7+hqaU2j2LjIoGf/s1PET4rfDVIKKOD7O5SK3u1Wb3jC/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g91qhJGx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g91qhJGx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A72C4CEE7;
	Thu, 18 Sep 2025 14:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758204613;
	bh=EBwyVcXAx8ZG32+m2XXWq6jJ96SEAu9YsPWb4/XSEXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g91qhJGxeoCacHMXVvMTz7RIXE3W5xSK+eWI3ZLQKEzqvjgAwd3KWhjzecEB9E9XW
	 Rog6AOcsA1/dXWOM5n73e63ivD27zsQZVe8Pd0yJtupjYQMR1BlhsemQeWHwRdWjHs
	 JU52tCUyMio20fbK9hzR2G+f4bLvtIhFNOhtpO7+0S9foMZCCJ6QioLxkx1s1F1nZ5
	 sqsdKXDyDwfs2QJPX9Ye4hYDNMVOMX+HVDKgXwQWdZ3DiDgAiH4+OI3r8YRkv/Szwm
	 pYMc+5LhUcjh+0xKf0SYlpfujhwDmXUrnf0YX8zhaTeFiJx+/JlbkjdZ6oTbI2n83v
	 2kL6eEufZWuLQ==
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
Subject: [PATCH v4 1/6] dma-mapping: prepare dma_map_ops to conversion to physical address
Date: Thu, 18 Sep 2025 17:09:24 +0300
Message-ID: <24d324344913170315f66cb43ac6692b3132a145.1758203802.git.leon@kernel.org>
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

Add new .map_phys() and .unmap_phys() callbacks to dma_map_ops as a
preparation to replace .map_page() and .unmap_page() respectively.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/dma-map-ops.h |  7 +++++++
 kernel/dma/mapping.c        |  4 ++++
 kernel/dma/ops_helpers.c    | 12 ++++++++++--
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 71f5b30254159..25603cb273769 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -37,6 +37,13 @@ struct dma_map_ops {
 	void (*unmap_page)(struct device *dev, dma_addr_t dma_handle,
 			size_t size, enum dma_data_direction dir,
 			unsigned long attrs);
+
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
index fe7472f13b106..4080aebe5debb 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -169,6 +169,8 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 		addr = dma_direct_map_phys(dev, phys, size, dir, attrs);
 	else if (use_dma_iommu(dev))
 		addr = iommu_dma_map_phys(dev, phys, size, dir, attrs);
+	else if (ops->map_phys)
+		addr = ops->map_phys(dev, phys, size, dir, attrs);
 	else if (is_mmio) {
 		if (!ops->map_resource)
 			return DMA_MAPPING_ERROR;
@@ -223,6 +225,8 @@ void dma_unmap_phys(struct device *dev, dma_addr_t addr, size_t size,
 		dma_direct_unmap_phys(dev, addr, size, dir, attrs);
 	else if (use_dma_iommu(dev))
 		iommu_dma_unmap_phys(dev, addr, size, dir, attrs);
+	else if (ops->unmap_phys)
+		ops->unmap_phys(dev, addr, size, dir, attrs);
 	else if (is_mmio) {
 		if (ops->unmap_resource)
 			ops->unmap_resource(dev, addr, size, dir, attrs);
diff --git a/kernel/dma/ops_helpers.c b/kernel/dma/ops_helpers.c
index 6f9d604d9d406..1eccbdbc99c1e 100644
--- a/kernel/dma/ops_helpers.c
+++ b/kernel/dma/ops_helpers.c
@@ -64,6 +64,7 @@ struct page *dma_common_alloc_pages(struct device *dev, size_t size,
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	struct page *page;
+	phys_addr_t phys;
 
 	page = dma_alloc_contiguous(dev, size, gfp);
 	if (!page)
@@ -71,9 +72,13 @@ struct page *dma_common_alloc_pages(struct device *dev, size_t size,
 	if (!page)
 		return NULL;
 
+	phys = page_to_phys(page);
 	if (use_dma_iommu(dev))
-		*dma_handle = iommu_dma_map_phys(dev, page_to_phys(page), size,
-						 dir, DMA_ATTR_SKIP_CPU_SYNC);
+		*dma_handle = iommu_dma_map_phys(dev, phys, size, dir,
+						 DMA_ATTR_SKIP_CPU_SYNC);
+	else if (ops->map_phys)
+		*dma_handle = ops->map_phys(dev, phys, size, dir,
+					    DMA_ATTR_SKIP_CPU_SYNC);
 	else
 		*dma_handle = ops->map_page(dev, page, 0, size, dir,
 					    DMA_ATTR_SKIP_CPU_SYNC);
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
2.51.0

