Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990690;
	b=UBTYY8oxPCX1jtJgHlMykORN9oy02hrQymQFDs1++/fOrake89HRJtAzGBa+XQ7gmMIm
	 9HjG3a6ADJuLP/r3aKK6Dgp87ShVFWhSPe9UavORhnJK6kXNjvRantNmz9Fv3q0mcw8IY
	 Z1AahCAdhA8q3sxS/FEHDFH5YYvsPHFKEk2Vd7qPvLXMheUx7ehVpSd9U82b9E7HCahVR
	 ZeNCdPzrJM2aUC4pLZYh/OEeVTusLmMQrg4PSOtF/YcSWI0B2WjQN/xehd59AkXLYF0VY
	 QDH1utJQXPSKz2hylY41Tf5qzEVchJNv2zk1aa/DWtm3xO+o5y0BsL56PGdK0pOQzjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990690;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3oYbhAK+eKSOg53p6mVFeSQFwkjFWWYL7ona4iL/pZU=;
	b=X1FgzFy38zq3X8rDdbjsJfF8837DEOEjnNSvg1KmuHOBKASQp61AZ2XpLiG/PcbFGSVm
	 S5+PsutGeH86LeKa8jPo+7E8PXVvYhPMmibKiPUiDKX34ifbEuNIWdfuHnFLDTVlv6Rpb
	 445WfcitVUqU63dTEQy5wx9V5dxX4BZ21cu+GXIMuhYbqPC1dayCNO+KKNDi2wPll7YXN
	 feDIqZRu6W69+9D8rFn7WmP5bjrFoZQBO5yI8Lwi/cgc/ygg0QB+puMGAvPdnIW2w3iQK
	 Ji8bRAPEdIfyho3Hs8jQ8VMctzqBc07WLM333k54iAzpc275NeMzk3mvss4HA+Fq7pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QcEYA/Ym";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FAB606D80B;
	Fri,  6 Nov 2026 18:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QcEYA/Ym
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88FC1F008A1;
	Fri,  6 Nov 2026 18:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793990689;
	bh=3oYbhAK+eKSOg53p6mVFeSQFwkjFWWYL7ona4iL/pZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QcEYA/YmtkioQRzRtTW9sUXPMKXKItlksLy5ZBR55DlM/RubXafpobrDrppXvcamw
	 MOtqdTrcd9SihJx3YWusD3M4MOYXxwKOdsdO9xgqO/3AREnEiLfBwF5GbHHw4inu+d
	 UWdPUEzLwZW2++yR3lfHWgIlrO5Jr5/ozt5jI42VNDJTu4TT8AWD4emCfCXFa2alic
	 vTUv19Ay+3oLblHWmbcZx1Xxxn/L+G8FCnG3nQ4UMo/JEYmnh+Gvb5om9LLM+Y1W6X
	 Y5dJQt/Ne1Y4fYLbYhgcL9OTVx+tXtcHq9HJVBKCOkUHqzyyKozhyioOnhNOOsCXnx
	 dWtKcJ1/6W4Yw==
From: Jakub Kicinski <kuba@kernel.org>
To: robin.murphy@arm.com,
	m.szyprowski@samsung.com
Cc: netdev@vger.kernel.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH 03/11] iommu/dma: pass the NUMA node to iommu_dma_alloc()
Date: Fri,  6 Nov 2026 10:44:25 -0800
Message-ID: <20261106184433.761422-4-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106184433.761422-1-kuba@kernel.org>
References: <20261106184433.761422-1-kuba@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

iommu_dma_alloc() allocates the pages on the node of the device.
Pass in the node requested via dma_alloc_attrs_node() instead.

Memory from the atomic pools is not node-aware. Like in dma-direct
the per-numa CMA area is still picked based on the node of the device.
iommu_dma_alloc_noncontiguous() keeps using the device's node.

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v1:
 - pass the node from dma_alloc_attrs_node() rather than dev_to_node(),
   the API patch now comes first
rfc: https://lore.kernel.org/20261027022528.633359-4-kuba@kernel.org
---
 include/linux/iommu-dma.h |  2 +-
 drivers/iommu/dma-iommu.c | 28 ++++++++++++++++------------
 kernel/dma/mapping.c      |  3 ++-
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/include/linux/iommu-dma.h b/include/linux/iommu-dma.h
index fae5d50e4f27..29a690b1a593 100644
--- a/include/linux/iommu-dma.h
+++ b/include/linux/iommu-dma.h
@@ -31,7 +31,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 		enum dma_data_direction dir, unsigned long attrs);
 void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
-		gfp_t gfp, unsigned long attrs);
+		gfp_t gfp, unsigned long attrs, int node);
 int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs);
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 78742aeba932..3e3a1a987a23 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -883,10 +883,10 @@ static void __iommu_dma_free_pages(struct page **pages, int count)
 }
 
 static struct page **__iommu_dma_alloc_pages(struct device *dev,
-		unsigned int count, unsigned long order_mask, gfp_t gfp)
+		unsigned int count, unsigned long order_mask, gfp_t gfp, int nid)
 {
 	struct page **pages;
-	unsigned int i = 0, nid = dev_to_node(dev);
+	unsigned int i = 0;
 
 	order_mask &= GENMASK(MAX_PAGE_ORDER, 0);
 	if (!order_mask)
@@ -939,7 +939,8 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
  * but an IOMMU which supports smaller pages might not map the whole thing.
  */
 static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
-		size_t size, struct sg_table *sgt, gfp_t gfp, unsigned long attrs)
+		size_t size, struct sg_table *sgt, gfp_t gfp, unsigned long attrs,
+		int node)
 {
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
@@ -967,7 +968,7 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
 
 	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	pages = __iommu_dma_alloc_pages(dev, count, alloc_sizes >> PAGE_SHIFT,
-					gfp);
+					gfp, node);
 	if (!pages)
 		return NULL;
 
@@ -1013,14 +1014,15 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
 }
 
 static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs, int node)
 {
 	struct page **pages;
 	struct sg_table sgt;
 	void *vaddr;
 	pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
 
-	pages = __iommu_dma_alloc_noncontiguous(dev, size, &sgt, gfp, attrs);
+	pages = __iommu_dma_alloc_noncontiguous(dev, size, &sgt, gfp, attrs,
+						node);
 	if (!pages)
 		return NULL;
 	*dma_handle = sgt.sgl->dma_address;
@@ -1061,7 +1063,8 @@ struct sg_table *iommu_dma_alloc_noncontiguous(struct device *dev, size_t size,
 	if (!sh)
 		return NULL;
 
-	sh->pages = __iommu_dma_alloc_noncontiguous(dev, size, &sh->sgt, gfp, attrs);
+	sh->pages = __iommu_dma_alloc_noncontiguous(dev, size, &sh->sgt, gfp,
+						    attrs, dev_to_node(dev));
 	if (!sh->pages) {
 		kfree(sh);
 		return NULL;
@@ -1638,11 +1641,10 @@ void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 }
 
 static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
-		struct page **pagep, gfp_t gfp, unsigned long attrs)
+		struct page **pagep, gfp_t gfp, unsigned long attrs, int node)
 {
 	bool coherent = dev_is_dma_coherent(dev);
 	size_t alloc_size = PAGE_ALIGN(size);
-	int node = dev_to_node(dev);
 	struct page *page = NULL;
 	void *cpu_addr;
 
@@ -1677,7 +1679,7 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
 }
 
 void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
-		gfp_t gfp, unsigned long attrs)
+		gfp_t gfp, unsigned long attrs, int node)
 {
 	bool coherent = dev_is_dma_coherent(dev);
 	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
@@ -1693,7 +1695,8 @@ void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 
 	if (gfpflags_allow_blocking(gfp) &&
 	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS)) {
-		return iommu_dma_alloc_remap(dev, size, handle, gfp, attrs);
+		return iommu_dma_alloc_remap(dev, size, handle, gfp, attrs,
+					     node);
 	}
 
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
@@ -1703,7 +1706,8 @@ void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 		if (!page)
 			return NULL;
 	} else {
-		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
+		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs,
+						 node);
 		if (!cpu_addr)
 			return NULL;
 	}
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 6e2847f55622..f98d4dec8649 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -683,7 +683,8 @@ void *dma_alloc_attrs_node(struct device *dev, size_t size,
 		cpu_addr = dma_direct_alloc_node(dev, size, dma_handle, flag,
 						 attrs, node);
 	} else if (use_dma_iommu(dev)) {
-		cpu_addr = iommu_dma_alloc(dev, size, dma_handle, flag, attrs);
+		cpu_addr = iommu_dma_alloc(dev, size, dma_handle, flag, attrs,
+					   node);
 	} else if (ops->alloc) {
 		cpu_addr = ops->alloc(dev, size, dma_handle, flag, attrs);
 	} else {
-- 
2.56.0

