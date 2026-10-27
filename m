Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793067968;
	b=aU0s0RvD/nV5sg21ruoV5LYqx7j7UAbgofbevhJ7S3INcxdWBudRZOoF6hNflpLyFWhh
	 Xbk4SbudhzP+gkMf3aPeLpv5aQ81XgBCkgqxGiQbLvitwOWC7yfkPj8DCA7XJmNQsQHFL
	 HddPORlneXpC75pUdSaRsPu5YrNpQpoxFrjtqpLKJMNzmawlHmXWGGI5pInySUsVzZXDZ
	 /PSJrScJ8Y59YYnAfbAWf2fgsG6s/kJToVXJxBgQYi/dKwGbyUOP17u8mp5EFUPCQxJM1
	 0AlZVNcQNX/VFiuzm1BjKN4cJOvUwnzJ/x8C4UKS6GWm0zjqEDpzjripR9cYg9Mhzlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793067968;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xuZ4/lg/etQoE8kEsf9V4b1yZ+iMhAwdx828MV/Z+Ks=;
	b=XsHbuV3Lpy134+hVkwWLqE2sJbFZ0rPWSL+1Dng33N1QLuUl5cQ6ob5ddatqdU8bV4bx
	 N0YFTD//7W/nuFfIYc9oyaRDqbqMNntHvrviE0l3mUKvj3jJNMrqQCxyHW/mETza59O+P
	 6RLbRf1wiSwtfKzb4G+LUPvi4nn3/icCB7bPiBrBUCQYfsqNLVbu1LCQKllLGeoQNoQ5U
	 GK66wGh99n8zDaOgSyq6d+Vdp/CmhX1fEHyDSK/Y1KxUaJlTmZEM7PwGE/C9UvfPA59AA
	 vp+r6X19mxEUk/8RXL+vGSp8x9a0mjUDj8gMpH/dbKEhjs4TB9rzBoylnMez39jRmLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UZNmvSkL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59C7606A31B;
	Tue, 27 Oct 2026 02:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UZNmvSkL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EADA1F031E3;
	Tue, 27 Oct 2026 02:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793067967;
	bh=xuZ4/lg/etQoE8kEsf9V4b1yZ+iMhAwdx828MV/Z+Ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UZNmvSkL1JALNWOvvBfsJ83ATXOdCPKO7w7cC8N20xQDmU+VSRfGb9LVIyAFD8UNT
	 VWWOpgdKbidmH0166ooYMAmTnUTcYGjf2nq6K3OfRyxYCn1KsgVBAJYacIiktlC7h+
	 yTk54bpKH1lYo9XvSzPZKdopfzRNwn0mLAl3JeDJG1J1/VPSf8KIMaadZbEJBOuOfb
	 Q3hr7L/bwzoobVhRFmG7JJrufBxIAdH3V5vcuDjYa6ZPR2B64ODgO615+zAaghCQ2E
	 qnf8S8iw3qo0NqRjGRCaCKbCRL8C0OpY1DvoSe0BxMtp2nAH0TZpMTCLAsVvurBTLv
	 5kgyq9MamcLCg==
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
Subject: [RFC 01/11] dma-contiguous: pass the NUMA node to dma_alloc_contiguous()
Date: Mon, 26 Oct 2026 19:25:18 -0700
Message-ID: <20261027022528.633359-2-kuba@kernel.org>
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

dma_alloc_contiguous() picks the per-numa CMA area based on the node of
the device. Let the callers pass the node in, so that the DMA allocators
can be extended to place memory on a node other than the device's.

All callers pass dev_to_node() for now, no functional change.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/dma-map-ops.h |  5 +++--
 drivers/iommu/dma-iommu.c   |  2 +-
 kernel/dma/contiguous.c     | 12 +++++-------
 kernel/dma/direct.c         |  2 +-
 kernel/dma/ops_helpers.c    |  5 +++--
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 8fae2b7deb20..3f1e4cd3392e 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -102,7 +102,8 @@ struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
 				       unsigned int order, bool no_warn);
 bool dma_release_from_contiguous(struct device *dev, struct page *pages,
 				 int count);
-struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp);
+struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp,
+				  int nid);
 void dma_free_contiguous(struct device *dev, struct page *page, size_t size);
 
 void dma_contiguous_early_fixup(phys_addr_t base, unsigned long size);
@@ -136,7 +137,7 @@ static inline bool dma_release_from_contiguous(struct device *dev,
 }
 /* Use fallback alloc() and free() when CONFIG_DMA_CMA=n */
 static inline struct page *dma_alloc_contiguous(struct device *dev, size_t size,
-		gfp_t gfp)
+		gfp_t gfp, int nid)
 {
 	return NULL;
 }
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 68ee57800fef..bb82ba3be440 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1627,7 +1627,7 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
 	struct page *page = NULL;
 	void *cpu_addr;
 
-	page = dma_alloc_contiguous(dev, alloc_size, gfp);
+	page = dma_alloc_contiguous(dev, alloc_size, gfp, node);
 	if (!page)
 		page = alloc_pages_node(node, gfp, get_order(alloc_size));
 	if (!page)
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 66093460584e..b5944ffefca7 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -402,22 +402,20 @@ static struct page *cma_alloc_aligned(struct cma *cma, size_t size, gfp_t gfp)
  * @dev:   Pointer to device for which the allocation is performed.
  * @size:  Requested allocation size.
  * @gfp:   Allocation flags.
+ * @nid:   NUMA node to allocate the memory on.
  *
  * tries to use device specific contiguous memory area if available, or it
- * tries to use per-numa cma, if the allocation fails, it will fallback to
- * try default global one.
+ * tries to use per-numa cma of @nid, if the allocation fails, it will fallback
+ * to try default global one.
  *
  * Note that it bypass one-page size of allocations from the per-numa and
  * global area as the addresses within one page are always contiguous, so
  * there is no need to waste CMA pages for that kind; it also helps reduce
  * fragmentations.
  */
-struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
+struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp,
+				  int nid)
 {
-#ifdef CONFIG_DMA_NUMA_CMA
-	int nid = dev_to_node(dev);
-#endif
-
 	/* CMA can be used only in the context which permits sleeping */
 	if (!gfpflags_allow_blocking(gfp))
 		return NULL;
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index da665ca22d5c..9787a45f46f1 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -124,7 +124,7 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 	WARN_ON_ONCE(!PAGE_ALIGNED(size));
 
 	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
-	page = dma_alloc_contiguous(dev, size, gfp);
+	page = dma_alloc_contiguous(dev, size, gfp, node);
 	if (page) {
 		if (dma_coherent_ok(dev, page_to_phys(page), size) &&
 		    (allow_highmem || !PageHighMem(page)))
diff --git a/kernel/dma/ops_helpers.c b/kernel/dma/ops_helpers.c
index 6b5f9208d31c..28a3c958158b 100644
--- a/kernel/dma/ops_helpers.c
+++ b/kernel/dma/ops_helpers.c
@@ -63,12 +63,13 @@ struct page *dma_common_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
+	int nid = dev_to_node(dev);
 	struct page *page;
 	phys_addr_t phys;
 
-	page = dma_alloc_contiguous(dev, size, gfp);
+	page = dma_alloc_contiguous(dev, size, gfp, nid);
 	if (!page)
-		page = alloc_pages_node(dev_to_node(dev), gfp, get_order(size));
+		page = alloc_pages_node(nid, gfp, get_order(size));
 	if (!page)
 		return NULL;
 
-- 
2.56.0

