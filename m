Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F68D313D49;
	Thu, 18 Sep 2025 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204622; cv=none; b=GIRI4JuXVEamcsFDh7Kd/Eme0ZICwFkTPZa+2MuKEOgxpLkp5SzFFecpv0gktQ6Ys9tUb0YwoglkaZga+yDmxqt3R5JeHqfKdijCy79whLIi++uA54gAVKfVUaqzWwcHlym6d1LUgw6qfZybURNnh/7/ujWa5Hz6aB2nImVcjjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204622; c=relaxed/simple;
	bh=+mItofUWbT/SzLs0Mrc6WXSkqZWGdUCuVYLGJSLcHDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pggQgsnmegsgmukJcKGicAyjzXtFU5qUeJztD8j+HgxM7LIY8EUEQf7V0QuGne7fMqIchCDeI7hmO2r7Y/KwOzeXWzxIoRv2j5H1CDHFawX1xvfHQkYUlLyLVrHpQcQ6ABJXo/vdcCLKMUu2hNIpBOWwTEIjd92Vr39LBcbgdyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9JsUocX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9JsUocX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEFAC4CEFB;
	Thu, 18 Sep 2025 14:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758204622;
	bh=+mItofUWbT/SzLs0Mrc6WXSkqZWGdUCuVYLGJSLcHDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V9JsUocXjcR/CRRuPUbMLUrynQTHxnyRZUck8xrjf9keCJjbsa1bH9eWOXAHqWeqU
	 juQIOVyIP8IsObWlS/GQ+c+Uprfg0vQs/uSvxRKuOSh8ip7nCbACSbb1d2V8B94szO
	 gm7otPQ0YarFehrESzgfR/EeZvdmrVvboJRbxtk+1PNZhXi9imBesuxF1A4Rpoq0ll
	 6I34Kw2ZKFhTFUM3h5ErNDcdSGH3nZ6uRpyw5T2To3AYoFeaBoieE+XTvKRGewbaJI
	 34bqm0hVT5cN07YS2CqWqEONmyD00OuGPY64KYjPokFIOiGj3K230Si2JLMvb8d/wc
	 XDjD3ji1pCB0g==
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
Subject: [PATCH v4 6/6] dma-mapping: remove unused mapping resource callbacks
Date: Thu, 18 Sep 2025 17:09:29 +0300
Message-ID: <c1a88f10a387eadf5c466cabf63bc905faddac81.1758203802.git.leon@kernel.org>
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

After ARM and XEN conversions to use physical addresses for the mapping,
there are no in-kernel users for map_resource/unmap_resource callbacks,
so remove them.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/dma-map-ops.h |  6 ------
 kernel/dma/mapping.c        | 16 ++++------------
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 25603cb273769..a2ec1566aa270 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -53,12 +53,6 @@ struct dma_map_ops {
 			enum dma_data_direction dir, unsigned long attrs);
 	void (*unmap_sg)(struct device *dev, struct scatterlist *sg, int nents,
 			enum dma_data_direction dir, unsigned long attrs);
-	dma_addr_t (*map_resource)(struct device *dev, phys_addr_t phys_addr,
-			size_t size, enum dma_data_direction dir,
-			unsigned long attrs);
-	void (*unmap_resource)(struct device *dev, dma_addr_t dma_handle,
-			size_t size, enum dma_data_direction dir,
-			unsigned long attrs);
 	void (*sync_single_for_cpu)(struct device *dev, dma_addr_t dma_handle,
 			size_t size, enum dma_data_direction dir);
 	void (*sync_single_for_device)(struct device *dev,
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 4080aebe5debb..32a85bfdf873a 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -157,7 +157,7 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	bool is_mmio = attrs & DMA_ATTR_MMIO;
-	dma_addr_t addr;
+	dma_addr_t addr = DMA_MAPPING_ERROR;
 
 	BUG_ON(!valid_dma_direction(dir));
 
@@ -171,18 +171,13 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 		addr = iommu_dma_map_phys(dev, phys, size, dir, attrs);
 	else if (ops->map_phys)
 		addr = ops->map_phys(dev, phys, size, dir, attrs);
-	else if (is_mmio) {
-		if (!ops->map_resource)
-			return DMA_MAPPING_ERROR;
-
-		addr = ops->map_resource(dev, phys, size, dir, attrs);
-	} else {
+	else if (!is_mmio && ops->map_page) {
 		struct page *page = phys_to_page(phys);
 		size_t offset = offset_in_page(phys);
 
 		/*
 		 * The dma_ops API contract for ops->map_page() requires
-		 * kmappable memory, while ops->map_resource() does not.
+		 * kmappable memory.
 		 */
 		addr = ops->map_page(dev, page, offset, size, dir, attrs);
 	}
@@ -227,10 +222,7 @@ void dma_unmap_phys(struct device *dev, dma_addr_t addr, size_t size,
 		iommu_dma_unmap_phys(dev, addr, size, dir, attrs);
 	else if (ops->unmap_phys)
 		ops->unmap_phys(dev, addr, size, dir, attrs);
-	else if (is_mmio) {
-		if (ops->unmap_resource)
-			ops->unmap_resource(dev, addr, size, dir, attrs);
-	} else
+	else
 		ops->unmap_page(dev, addr, size, dir, attrs);
 	trace_dma_unmap_phys(dev, addr, size, dir, attrs);
 	debug_dma_unmap_phys(dev, addr, size, dir);
-- 
2.51.0

