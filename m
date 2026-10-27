Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793067968;
	b=wicmuyAvFcdsFWKpKdnj3l3nBGKQGPb9EILnLDhOIxcyAroTvQJTF54sG+TjLSfq1Hc+
	 YJQseC/n6PcqQXHn6xbDNNqwLPdps4r7s93W/dPNfiWFTs7yffDANr2/rctpKX6JaXH/B
	 Vl4o8VB7L1qOoTwJdxtSKumW8mngqreaIc7m9JojZExsNebzaP3LTW3cRhn0Ku3ijRZhA
	 txc/5jt1xtsRQeuc5tRYaC4auf+HBJ8WC3FcqlULBZmibjizqYWRoPwxoSJtBVwcZZSUs
	 NXcsgBBrbn3ItIImh+QPda3KLKSsZ9eNzK/uB4TyFl/6kg0KEx5+u83AZQ4no3IHMIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793067968;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=T4eFAtsnAZqo6Mn8XRMqQdKmDgUTGfrTns9FScnFl/w=;
	b=bacx7kvUlg5L67xdsWuDmVe6+8hRM3U0AaJiOMy4chKWnFrvS2+9T1b0GmPbAZCWD/ge
	 +tn4CnQ4lgMWkhBacWi7ArBeBByo6sRq9kv87SuN+SUzTLdmu94vlUm3AgPbUbTRjJeDV
	 Qq7XkVUqYgLUuqv9syb87cnez2s6HB+jWTpq3u7IOYY44tE/ADqj9qqR/iJMiVtN2y/D5
	 ptG94ZbmsPN5t4rm1VjaompP36QBzqGhVHiw8IOwHcWuJiAcjrNwADX/zxf3jITsdcP1t
	 juM54ZPO7f2amnvpxi6RK8KVlVwgMYODFeHGEsMLXCsTJugQreWp/SCSrfgQDcr8Yqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E1pquA4w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B4B606A32C;
	Tue, 27 Oct 2026 02:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E1pquA4w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B671F01825;
	Tue, 27 Oct 2026 02:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793067968;
	bh=T4eFAtsnAZqo6Mn8XRMqQdKmDgUTGfrTns9FScnFl/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E1pquA4w+C+TzWv/psoom5gvtEB5Ky382OH71atQdhGu9xCPGS30jQkWcwroXNHOM
	 Y48lw6iSMMp+BScfklut/wQ+uTntjf24Bl35PdOTBglDqdpi9JoZKIlYnjnNPMpfFt
	 zFuvLC+xikWaTVnHOz4TIpXJTBpkjYHetFewHT9rvafd0EtCao+BGbyh7Z00LwBe2k
	 bg1VSeC9XKosVPLWKd6tcZG206qm7ZbPDGjjPWYfLSet5rzjBIj2VOr2ehSchzolJA
	 tkqejmaSCAXG3zzcO142+ibGDJ/BGvPVYBUMN1lGGzqpUUYnCnBmR+LtkqiH0U2L1G
	 3MYrf/a7RT9qg==
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
Subject: [RFC 03/11] iommu/dma: pass the NUMA node to iommu_dma_alloc()
Date: Mon, 26 Oct 2026 19:25:20 -0700
Message-ID: <20261027022528.633359-4-kuba@kernel.org>
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

iommu_dma_alloc() allocates the pages on the node of the device.
Pass the node in explicitly, so that a node-aware coherent allocation
API can be layered on top.

Memory from the atomic pools is not node-aware.
iommu_dma_alloc_noncontiguous() keeps using the device's node.

Callers pass dev_to_node() for now, no functional change.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/iommu-dma.h |  2 +-
 drivers/iommu/dma-iommu.c | 28 ++++++++++++++++------------
 kernel/dma/mapping.c      |  3 ++-
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/include/linux/iommu-dma.h b/include/linux/iommu-dma.h
index 060f6e23ab3c..067872f14629 100644
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
index bb82ba3be440..1dc2e235380a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -882,10 +882,10 @@ static void __iommu_dma_free_pages(struct page **pages, int count)
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
@@ -938,7 +938,8 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
  * but an IOMMU which supports smaller pages might not map the whole thing.
  */
 static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
-		size_t size, struct sg_table *sgt, gfp_t gfp, unsigned long attrs)
+		size_t size, struct sg_table *sgt, gfp_t gfp, unsigned long attrs,
+		int node)
 {
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
@@ -966,7 +967,7 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
 
 	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	pages = __iommu_dma_alloc_pages(dev, count, alloc_sizes >> PAGE_SHIFT,
-					gfp);
+					gfp, node);
 	if (!pages)
 		return NULL;
 
@@ -1012,14 +1013,15 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
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
@@ -1060,7 +1062,8 @@ struct sg_table *iommu_dma_alloc_noncontiguous(struct device *dev, size_t size,
 	if (!sh)
 		return NULL;
 
-	sh->pages = __iommu_dma_alloc_noncontiguous(dev, size, &sh->sgt, gfp, attrs);
+	sh->pages = __iommu_dma_alloc_noncontiguous(dev, size, &sh->sgt, gfp,
+						    attrs, dev_to_node(dev));
 	if (!sh->pages) {
 		kfree(sh);
 		return NULL;
@@ -1619,11 +1622,10 @@ void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
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
 
@@ -1656,7 +1658,7 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
 }
 
 void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
-		gfp_t gfp, unsigned long attrs)
+		gfp_t gfp, unsigned long attrs, int node)
 {
 	bool coherent = dev_is_dma_coherent(dev);
 	int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
@@ -1672,7 +1674,8 @@ void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 
 	if (gfpflags_allow_blocking(gfp) &&
 	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS)) {
-		return iommu_dma_alloc_remap(dev, size, handle, gfp, attrs);
+		return iommu_dma_alloc_remap(dev, size, handle, gfp, attrs,
+					     node);
 	}
 
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
@@ -1682,7 +1685,8 @@ void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
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
index 1c3a70025195..4ace4b68c9c2 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -668,7 +668,8 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		cpu_addr = dma_direct_alloc(dev, size, dma_handle, flag, attrs,
 					    dev_to_node(dev));
 	} else if (use_dma_iommu(dev)) {
-		cpu_addr = iommu_dma_alloc(dev, size, dma_handle, flag, attrs);
+		cpu_addr = iommu_dma_alloc(dev, size, dma_handle, flag, attrs,
+					   dev_to_node(dev));
 	} else if (ops->alloc) {
 		cpu_addr = ops->alloc(dev, size, dma_handle, flag, attrs);
 	} else {
-- 
2.56.0

