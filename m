Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793067968;
	b=PnK9yOLEXrpJAtUNDaqNytc8aFo9B2X0ehNhhX1ozCffCB/TYw+NNmL1zO/XAgWa+9f1
	 OkTObJWfjyF0iGlqJP0Ydkcsmm9B/uhYgmrbBgSmgygBxwanzOeS2WUvLiJYTOXnjXLUe
	 hendakQUaCaW5tKomZqhMil8DnJTKijwLgY0wGJjrFMAR5PNWemrNbhty6GWsnvuYuh7t
	 nMVZPHcKdNe3wMMAyxpvpFHokMx9B/ipzI/EVZTBsLf43PXORUhSwqv9C65BQXD/1R/P2
	 CUiNN6Y9fH+Qsbgt7z3DExTIwM4/hE+NPwAvcvj2JArV+Uo8inIb27Lfdh7TI5tX82Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793067968;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=S4aYRbE302LQbqAQ+93TGzqSd2oH27nCsfs3eL4pUl8=;
	b=4irkUw8qM1844rKWqlMP+daDg6BoLYvoP6jNK4ifT5Icv2k9qRzeZ2cg/e+tPjHWY887
	 1Zm9TWY5lKrv3GTC5rvZMtRoB/pjpcNFkFTS/1uFJBQ6lRWjElXf86zJOFVu9woGatQh6
	 hR6lMWHVkZ+WvBMQlZIQtqFADCBSkX5Y9k7v4ZS1kMk19E8i5GfKelG5fjnookjs2Oq5B
	 GIbQcW2sbNwWsdFnv46u25MWSdXxCBFE3d7HZCqjy4AL62fE1o8+XEy0pDYTkp31OmLk9
	 dgDnjBA3uYyvJncF+sFEqDAFv0c7LOXr7Gn3qO3zHWjKEFU3/LNa9oBH0CE9rkrJ3jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fcJbUB8O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB0E606A328;
	Tue, 27 Oct 2026 02:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fcJbUB8O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4EB51F031E4;
	Tue, 27 Oct 2026 02:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793067968;
	bh=S4aYRbE302LQbqAQ+93TGzqSd2oH27nCsfs3eL4pUl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fcJbUB8OCHpwDQfJFBQp9zF5POdJVsJzBilRJWWXoobMSSnK78HpcIK7+8sKFbxB+
	 8iiztDmXjEFkZhZMacNnNkSFY3wKfXw3ZtMJUwlcfw9esB67qLBOBlL30nA24LRthm
	 J20/a0RYaFoaJXFBIH3PqPCCag0BL6aOiBnB8E1a5Aveau0v1j92n/QlwjpsxYvitz
	 tXzD6nScf5OgHCitD15+/5YA0mWybvWYiJKkq+D8K7r9jV6PmquqwxppUDITInLz6T
	 8Wq50WWdTlRmiXPOh4ZGm4AkP1GdZpINP1L+hF/XUby3axwDjdbJ6Vyx/Eaf9wsZe3
	 mIMuEfymzww/w==
From: Jakub Kicinski <kuba@kernel.org>
To: robin.murphy@arm.com,
	m.szyprowski@samsung.com
Cc: tglx@kernel.org,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	leon@kernel.org,
	mbloch@nvidia.com,
	iommu@lists.linux.dev,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC 02/11] dma-direct: pass the NUMA node to dma_direct_alloc()
Date: Mon, 26 Oct 2026 19:25:19 -0700
Message-ID: <20261027022528.633359-3-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027022528.633359-1-kuba@kernel.org>
References: <20261027022528.633359-1-kuba@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma_direct_alloc() allocates the pages on the node of the device.
Pass the node in explicitly, so that a node-aware coherent allocation
API can be layered on top.

Memory from the atomic pools, the global coherent pool, restricted
swiotlb pools and arch_dma_alloc() is not node-aware, the node is only
used for the page allocator and the per-numa CMA areas.

Callers pass dev_to_node() for now, no functional change.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/dma-direct.h    |  2 +-
 arch/x86/kernel/amd_gart_64.c |  3 ++-
 kernel/dma/direct.c           | 18 ++++++++++--------
 kernel/dma/mapping.c          |  3 ++-
 4 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index daa31a1adf7b..7e864b75be6b 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -158,7 +158,7 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
 
 u64 dma_direct_get_required_mask(struct device *dev);
 void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
-		gfp_t gfp, unsigned long attrs);
+		gfp_t gfp, unsigned long attrs, int node);
 void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs);
 struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index b5f1f031d45b..05f3d7da6df8 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -468,7 +468,8 @@ gart_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_addr,
 {
 	void *vaddr;
 
-	vaddr = dma_direct_alloc(dev, size, dma_addr, flag, attrs);
+	vaddr = dma_direct_alloc(dev, size, dma_addr, flag, attrs,
+				 dev_to_node(dev));
 	if (!vaddr ||
 	    !force_iommu || dev->coherent_dma_mask <= DMA_BIT_MASK(24))
 		return vaddr;
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 9787a45f46f1..81953adf872c 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -115,9 +115,8 @@ static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size,
 }
 
 static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
-		gfp_t gfp, bool allow_highmem)
+		gfp_t gfp, bool allow_highmem, int node)
 {
-	int node = dev_to_node(dev);
 	struct page *page;
 	u64 phys_limit;
 
@@ -180,11 +179,12 @@ static struct page *dma_direct_alloc_from_pool(struct device *dev, size_t size,
 }
 
 static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp)
+		dma_addr_t *dma_handle, gfp_t gfp, int node)
 {
 	struct page *page;
 
-	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
+	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true,
+					node);
 	if (!page)
 		return NULL;
 
@@ -200,7 +200,7 @@ static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
 }
 
 void *dma_direct_alloc(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs, int node)
 {
 	bool remap = false, set_uncached = false;
 	bool mark_mem_decrypt = false;
@@ -228,7 +228,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 
 	if (((attrs & (DMA_ATTR_NO_KERNEL_MAPPING | __DMA_ATTR_ALLOC_CC_SHARED)) ==
 	     DMA_ATTR_NO_KERNEL_MAPPING) && !is_swiotlb_for_alloc(dev))
-		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp);
+		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp,
+						   node);
 
 	if (!dev_is_dma_coherent(dev)) {
 		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_ALLOC) &&
@@ -286,7 +287,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	}
 
 	/* we always manually zero the memory once we are done */
-	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, allow_highmem);
+	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, allow_highmem,
+					node);
 	if (!page)
 		return NULL;
 
@@ -452,7 +454,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 		goto setup_page;
 	}
 
-	page = __dma_direct_alloc_pages(dev, size, gfp, false);
+	page = __dma_direct_alloc_pages(dev, size, gfp, false, dev_to_node(dev));
 	if (!page)
 		return NULL;
 
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index bf2651a70b7c..1c3a70025195 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -665,7 +665,8 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
 
 	if (dma_alloc_direct(dev, ops) || arch_dma_alloc_direct(dev)) {
-		cpu_addr = dma_direct_alloc(dev, size, dma_handle, flag, attrs);
+		cpu_addr = dma_direct_alloc(dev, size, dma_handle, flag, attrs,
+					    dev_to_node(dev));
 	} else if (use_dma_iommu(dev)) {
 		cpu_addr = iommu_dma_alloc(dev, size, dma_handle, flag, attrs);
 	} else if (ops->alloc) {
-- 
2.56.0

