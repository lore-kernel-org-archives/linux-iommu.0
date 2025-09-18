Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B039313D49;
	Thu, 18 Sep 2025 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204618; cv=none; b=mN7+DOnPA0Oy1vfaE1nL6rWZkfD+Oo9QtpBxUTKK+sQvggkIrMZgpJBgWVlN8qdapJOBNTTG3TWeESbSFL52fT4YcHy94aVLTwTKw5VgQOVr+mXrc19HcNaRzJ4Kt1xySKTCx4TqsPoUUixHPR3ULFDX0Frg1PjBdhcAIgJPbf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204618; c=relaxed/simple;
	bh=m3D6g8FDHOZH6474XMcPOpnGaU1UwHseRqgAFUOfdrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9lAVIUWHNxERasTtegfSnTr/PLSKc/W+9hx2Ghfrc+8+cc3ohu+AelUlo8uTrJa0ZsepGh2e++qrxyZcYhKai4lTvPyg+qz3IEQZj5uYL/rRRgcQqh5YbP+62NqM+f+Dy+tX8P+KlDT/kixO4/jey24Th/vOAojWxYFMqizsVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsgW3cFp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsgW3cFp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D2CC4CEE7;
	Thu, 18 Sep 2025 14:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758204617;
	bh=m3D6g8FDHOZH6474XMcPOpnGaU1UwHseRqgAFUOfdrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LsgW3cFpYtCJcNpT12ghofulEYz5SE3I1+MEc+VZwiV2aowmuN6OaLrwwHtaY3r62
	 Un7zmoh5+VozkXySig2p0YiWfk7Loy24bLch1JLoDULUJlZ0+s1bosOrGr6Qzps9G4
	 bTciv3Y9YjxxtlFXDXQOA/OUJnji3JaqIfapiByz1FAfMeEl6gUdz3r0CsibDAXsSL
	 hBODJnZhl/XMFnr2oqiyEBEmThANZ2dqKjUTgYaQXdmtJvFNokS+KVbOb2zKA5lM33
	 faKpQN6yt9V/166f9jvRgOthV1TZoTwvTEz1KV3BkmMtdElPbfE7H1ZPamvbmLHuL+
	 Z5qCSgG53oUHA==
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
Subject: [PATCH v4 5/6] xen: swiotlb: Switch to physical address mapping callbacks
Date: Thu, 18 Sep 2025 17:09:28 +0300
Message-ID: <997c0122a24c355b4d7ee353902041a7617f4c9e.1758203802.git.leon@kernel.org>
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

Combine resource and page mappings routines to one function
and remove .map_resource/.unmap_resource callbacks completely.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/xen/swiotlb-xen.c | 63 ++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 34 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index dd7747a2de879..48936179c940b 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -200,17 +200,32 @@ xen_swiotlb_free_coherent(struct device *dev, size_t size, void *vaddr,
  * physical address to use is returned.
  *
  * Once the device is given the dma address, the device owns this memory until
- * either xen_swiotlb_unmap_page or xen_swiotlb_dma_sync_single is performed.
+ * either xen_swiotlb_unmap_phys or xen_swiotlb_dma_sync_single is performed.
  */
-static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
-				unsigned long offset, size_t size,
-				enum dma_data_direction dir,
+static dma_addr_t xen_swiotlb_map_phys(struct device *dev, phys_addr_t phys,
+				size_t size, enum dma_data_direction dir,
 				unsigned long attrs)
 {
-	phys_addr_t map, phys = page_to_phys(page) + offset;
-	dma_addr_t dev_addr = xen_phys_to_dma(dev, phys);
+	dma_addr_t dev_addr;
+	phys_addr_t map;
 
 	BUG_ON(dir == DMA_NONE);
+
+	if (attrs & DMA_ATTR_MMIO) {
+		if (unlikely(!dma_capable(dev, phys, size, false))) {
+			dev_err_once(
+				dev,
+				"DMA addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
+				&dma_addr, size, *dev->dma_mask,
+				dev->bus_dma_limit);
+			WARN_ON_ONCE(1);
+			return DMA_MAPPING_ERROR;
+		}
+		return phys;
+	}
+
+	dev_addr = xen_phys_to_dma(dev, phys);
+
 	/*
 	 * If the address happens to be in the device's DMA window,
 	 * we can safely return the device addr and not worry about bounce
@@ -257,13 +272,13 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 
 /*
  * Unmap a single streaming mode DMA translation.  The dma_addr and size must
- * match what was provided for in a previous xen_swiotlb_map_page call.  All
+ * match what was provided for in a previous xen_swiotlb_map_phys call.  All
  * other usages are undefined.
  *
  * After this call, reads by the cpu to the buffer are guaranteed to see
  * whatever the device wrote there.
  */
-static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
+static void xen_swiotlb_unmap_phys(struct device *hwdev, dma_addr_t dev_addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	phys_addr_t paddr = xen_dma_to_phys(hwdev, dev_addr);
@@ -325,7 +340,7 @@ xen_swiotlb_sync_single_for_device(struct device *dev, dma_addr_t dma_addr,
 
 /*
  * Unmap a set of streaming mode DMA translations.  Again, cpu read rules
- * concerning calls here are the same as for swiotlb_unmap_page() above.
+ * concerning calls here are the same as for swiotlb_unmap_phys() above.
  */
 static void
 xen_swiotlb_unmap_sg(struct device *hwdev, struct scatterlist *sgl, int nelems,
@@ -337,7 +352,7 @@ xen_swiotlb_unmap_sg(struct device *hwdev, struct scatterlist *sgl, int nelems,
 	BUG_ON(dir == DMA_NONE);
 
 	for_each_sg(sgl, sg, nelems, i)
-		xen_swiotlb_unmap_page(hwdev, sg->dma_address, sg_dma_len(sg),
+		xen_swiotlb_unmap_phys(hwdev, sg->dma_address, sg_dma_len(sg),
 				dir, attrs);
 
 }
@@ -352,8 +367,8 @@ xen_swiotlb_map_sg(struct device *dev, struct scatterlist *sgl, int nelems,
 	BUG_ON(dir == DMA_NONE);
 
 	for_each_sg(sgl, sg, nelems, i) {
-		sg->dma_address = xen_swiotlb_map_page(dev, sg_page(sg),
-				sg->offset, sg->length, dir, attrs);
+		sg->dma_address = xen_swiotlb_map_phys(dev, sg_phys(sg),
+				sg->length, dir, attrs);
 		if (sg->dma_address == DMA_MAPPING_ERROR)
 			goto out_unmap;
 		sg_dma_len(sg) = sg->length;
@@ -392,25 +407,6 @@ xen_swiotlb_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
 	}
 }
 
-static dma_addr_t xen_swiotlb_direct_map_resource(struct device *dev,
-						  phys_addr_t paddr,
-						  size_t size,
-						  enum dma_data_direction dir,
-						  unsigned long attrs)
-{
-	dma_addr_t dma_addr = paddr;
-
-	if (unlikely(!dma_capable(dev, dma_addr, size, false))) {
-		dev_err_once(dev,
-			     "DMA addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
-			     &dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
-		WARN_ON_ONCE(1);
-		return DMA_MAPPING_ERROR;
-	}
-
-	return dma_addr;
-}
-
 /*
  * Return whether the given device DMA address mask can be supported
  * properly.  For example, if your device can only drive the low 24-bits
@@ -437,13 +433,12 @@ const struct dma_map_ops xen_swiotlb_dma_ops = {
 	.sync_sg_for_device = xen_swiotlb_sync_sg_for_device,
 	.map_sg = xen_swiotlb_map_sg,
 	.unmap_sg = xen_swiotlb_unmap_sg,
-	.map_page = xen_swiotlb_map_page,
-	.unmap_page = xen_swiotlb_unmap_page,
+	.map_phys = xen_swiotlb_map_phys,
+	.unmap_phys = xen_swiotlb_unmap_phys,
 	.dma_supported = xen_swiotlb_dma_supported,
 	.mmap = dma_common_mmap,
 	.get_sgtable = dma_common_get_sgtable,
 	.alloc_pages_op = dma_common_alloc_pages,
 	.free_pages = dma_common_free_pages,
 	.max_mapping_size = swiotlb_max_mapping_size,
-	.map_resource = xen_swiotlb_direct_map_resource,
 };
-- 
2.51.0

