Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990689;
	b=lYyI6m3MyJRbAP3+06hPg3wSPC53yIBfec30l/pH9r/GwdR8aAeFiB5h8WIFAs7Mq7Bw
	 qQgjJuxpx3uqyywTliUOXFG9diEjxTQA6YN3CFZ3eYYHGj6yM9x/lwqiAxjnCTKDDY4p6
	 pPnqeySRY2o5n6px9Tn4kx15nzGOA5TCT6pwTwlPCiedeExL/7PAt0Rg1xDy4Rc4kXgzf
	 Yi6feeTV6fCqY8lSnJuI40qN8SxYFIQ0FTSnZAzCkaKSH9lxmjOq5UGnDrYY4JJDuR1xn
	 dLRy7NqmdCGmUjJuc6IdcuIr8rXbDB47cNXjXKoq80Bbzl6ceALy1BC9EFq6ZBMwysg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990689;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=F2K3jXXcd5AYm/Leb7NUP8HikREyHVqfW3Lc/ZcLK6o=;
	b=lJoBN4f2ZpjbjOPEZv7P/gx+kAArhaHkWFpJkO346+j29Xbs3gRW6uM1XKpqtdSHV//A
	 4DFNLN5h4eobfK1+sfxDjx77TPsgBl9bIIRWtwhSLGRld2YGWqqw7eAZRYTzsrviH7+SA
	 Vk6cgCZ5mrRQJf9szm8ZhktNjGQFI8N7nmkA50bTWC8/qOFMFhPfBuo5vw4S8Y9LdSlNs
	 CQQ26Y/PZtH1CQ4raTBxa5zaRNybar3Y3naH/Lt4avtZmX3b/WwEtSrloksvmLk8ap0bk
	 9Vox+0ThPwAuL2n2/HFKKTqGMTFTJXhGrd7sqm/GZOF0Bmb6tuTpN+vqpDRzlNAXpIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G5RGf3DP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C0B606A33F;
	Fri,  6 Nov 2026 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G5RGf3DP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BB11F0089F;
	Fri,  6 Nov 2026 18:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793990688;
	bh=F2K3jXXcd5AYm/Leb7NUP8HikREyHVqfW3Lc/ZcLK6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G5RGf3DPDLy5uuVkUkM1FNSbSehM+8Izk1DCNUt0H5lcEkkTfYrrzYNwRX5rZn5Fq
	 Nhuqr90WZricyCWgZqhciCQV3Jr7lOL24FMAS0ly3Os0VRn31G0uKvnahOBOBObNlS
	 tQM4rD7lV3Tx6/NAi3ai8LZmWZM8DRE1Ei1rBzJ3gJ5Zd1XXLAVUZd8vswwOuf5iCt
	 jkD+M0UQtK/coyQ2mHjRlqxqcuuoWElxrRJAe+W+W+XS8yd35H4B2AcaEZsqlNBoV3
	 DppzRi1B7vwWo7SBItemKorBIubm83SQDsEzP6/PJgSPtrwdAkcnE96iZrE6n2MLO/
	 nJns9zT1+YFNQ==
From: Jakub Kicinski <kuba@kernel.org>
To: robin.murphy@arm.com,
	m.szyprowski@samsung.com
Cc: netdev@vger.kernel.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH 02/11] dma-direct: add dma_direct_alloc_node()
Date: Fri,  6 Nov 2026 10:44:24 -0800
Message-ID: <20261106184433.761422-3-kuba@kernel.org>
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

dma_direct_alloc() allocates the pages on the node of the device.
Add dma_direct_alloc_node() which takes the node as an argument,
and pass it the node requested via dma_alloc_attrs_node().

dma_direct_alloc() stays as a wrapper passing dev_to_node(),
swiotlb-xen uses it as its dma_map_ops->alloc on non-x86 platforms.

Memory from the atomic pools, the global coherent pool, restricted
swiotlb pools and arch_dma_alloc() is not node-aware, the node is only
used for the page allocator. The per-numa CMA area is still picked
based on the node of the device, a following patch takes care of that.

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Björn Töpel <bjorn@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v1:
 - add dma_direct_alloc_node() and keep dma_direct_alloc() as a wrapper,
   swiotlb-xen uses it as its ->alloc (fixes the build on arm/arm64)
 - pass the node from dma_alloc_attrs_node() directly, the API patch now
   comes first
 - docs: note that the page allocator may fall back to other nodes
rfc: https://lore.kernel.org/20261027022528.633359-3-kuba@kernel.org
---
 Documentation/core-api/dma-api.rst |  3 ++-
 include/linux/dma-direct.h         | 11 +++++++++--
 kernel/dma/direct.c                | 20 +++++++++++---------
 kernel/dma/mapping.c               |  6 ++++--
 4 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
index 5d079507ffa1..f44cc770a472 100644
--- a/Documentation/core-api/dma-api.rst
+++ b/Documentation/core-api/dma-api.rst
@@ -68,7 +68,8 @@ rather than on the node of the device. This is useful for memory accessed
 frequently by both the device and a CPU on a different node, for example
 descriptor rings serviced by that CPU.
 
-Like with kmalloc_node() the node is only a preference.
+Like with kmalloc_node() the node is only a preference, the page allocator
+may fall back to other nodes if the given node is out of memory.
 
 ::
 
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index daa31a1adf7b..b822e96c351e 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -157,8 +157,8 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
 }
 
 u64 dma_direct_get_required_mask(struct device *dev);
-void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
-		gfp_t gfp, unsigned long attrs);
+void *dma_direct_alloc_node(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs, int node);
 void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs);
 struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
@@ -168,4 +168,11 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 		enum dma_data_direction dir);
 int dma_direct_supported(struct device *dev, u64 mask);
 
+static inline void *dma_direct_alloc(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+{
+	return dma_direct_alloc_node(dev, size, dma_handle, gfp, attrs,
+				     dev_to_node(dev));
+}
+
 #endif /* _LINUX_DMA_DIRECT_H */
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 25e9a86835fd..a9d24d8bc77c 100644
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
 	void *va;
@@ -198,11 +197,12 @@ static bool dma_direct_use_no_mapping(struct device *dev, unsigned long attrs)
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
 
@@ -217,8 +217,8 @@ static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
 	return page;
 }
 
-void *dma_direct_alloc(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+void *dma_direct_alloc_node(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs, int node)
 {
 	bool remap = false, set_uncached = false;
 	bool mark_mem_decrypt = false;
@@ -245,7 +245,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		gfp |= __GFP_NOWARN;
 
 	if (dma_direct_use_no_mapping(dev, attrs))
-		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp);
+		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp,
+						   node);
 
 	if (!dev_is_dma_coherent(dev)) {
 		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_ALLOC) &&
@@ -303,7 +304,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	}
 
 	/* we always manually zero the memory once we are done */
-	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, allow_highmem);
+	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, allow_highmem,
+					node);
 	if (!page)
 		return NULL;
 
@@ -468,7 +470,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 		goto setup_page;
 	}
 
-	page = __dma_direct_alloc_pages(dev, size, gfp, false);
+	page = __dma_direct_alloc_pages(dev, size, gfp, false, dev_to_node(dev));
 	if (!page)
 		return NULL;
 
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 1b1cd3bc4a40..6e2847f55622 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -640,7 +640,8 @@ EXPORT_SYMBOL_GPL(dma_get_required_mask);
  * @node: NUMA node to allocate the memory on, NUMA_NO_NODE for no preference
  *
  * Same as dma_alloc_attrs() but places the memory on @node rather than on the
- * node of @dev. Like with kmalloc_node() the node is only a preference.
+ * node of @dev. Like with kmalloc_node() the node is only a preference,
+ * the page allocator may fall back to other nodes if @node is out of memory.
  *
  * Return: the CPU address of the allocation, or NULL on failure.
  */
@@ -679,7 +680,8 @@ void *dma_alloc_attrs_node(struct device *dev, size_t size,
 	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
 
 	if (dma_alloc_direct(dev, ops) || arch_dma_alloc_direct(dev)) {
-		cpu_addr = dma_direct_alloc(dev, size, dma_handle, flag, attrs);
+		cpu_addr = dma_direct_alloc_node(dev, size, dma_handle, flag,
+						 attrs, node);
 	} else if (use_dma_iommu(dev)) {
 		cpu_addr = iommu_dma_alloc(dev, size, dma_handle, flag, attrs);
 	} else if (ops->alloc) {
-- 
2.56.0

