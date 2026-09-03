Received: from mta1.migadu.com (out-251.mta1.migadu.com [95.215.58.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B99D78C9C
	for <iommu@lists.linux.dev>; Thu,  3 Sep 2026 01:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788398970; cv=none; b=nF8OT3Yq6O43pQ1RXzlzNU0MgcVzzwNdj6mdGq2BLEzuB1I2oROfBuF+cyw6Sj23aeE/enstBGTFHOZudzmq9ZFlXZEyYxd1PW+Rya3Y5rX5VJpmQrYFgJydgfxivsfPHKFuwOsMBK7u40WVRR5gu8fZIfsMePt3hC3TOYXnWeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788398970; c=relaxed/simple;
	bh=biYsCQdlpI1jiJazmEVMkrZxW/wkfpV5LjcpXes0HIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uEKCBCbTfK4dNDUAXJr0TSpXJ1SsEgNCebn1DgYah6y/1ix/b602DsCT/4Sc+xndT85xYKWTrQC4Dg9Vg9SP6Dk+g2jDX0MigYv3Y9QO2s2nW4cakqqYPY83J00fHcgdp8fy1G1cMaGA+hwlsuldsvASwE4zz7mMKToAGdkEjGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DP4/cesi; arc=none smtp.client-ip=95.215.58.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DP4/cesi"
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=biYsCQdlpI1jiJazmEVMkrZxW/wkfpV5LjcpXes0HIc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788398965; v=1; x=1789003765;
 b=DP4/cesi19OdPFl7IZNTLN1DuWAY0mTraf3Y0vn5LG8eMRHQKWPyoHGYtYO3C1HN78H3vfB6
 drxouMi4S1sZzUlcppo9BbYEGceH8caIdZsde2TOE6Z0dwjsEAFedVCRTtMTUuqmqdD+LGbaJFq
 if1SbpDGPJ6AJLD2K6l6ypR0=
X-Envelope-To: iommu@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 0070fac8265920a4;
	Thu, 03 Sep 2026 01:29:25 +0000
X-Mizu-Trace-ID: 0070fac8265920a4
X-Migadu-Flow: FLOW_OUT
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Qingfang Deng <qingfang.deng@linux.dev>
Subject: [PATCH v2] dma-mapping: use exact allocation for DMA pages
Date: Thu,  3 Sep 2026 09:29:13 +0800
Message-ID: <20260903012914.312305-1-qingfang.deng@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DMA page allocation fallbacks use alloc_pages_node() with get_order(size),
wasting the unused tail for non-power-of-two requests.

Use alloc_pages_exact_nid() and free_pages_exact() so that a buddy
fallback retains only requested pages.

Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
v2: drop __meminit to fix section mismatch

v1:
https://lore.kernel.org/linux-iommu/20260901085348.53140-1-qingfang.deng@linux.dev/
---
 drivers/iommu/dma-iommu.c   | 10 ++++++----
 include/linux/dma-map-ops.h |  2 +-
 include/linux/gfp.h         |  2 +-
 kernel/dma/contiguous.c     |  6 +++---
 kernel/dma/direct.c         |  8 +++++---
 kernel/dma/ops_helpers.c    | 11 +++++++----
 mm/page_alloc.c             |  2 +-
 7 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 58c624513cd4..8f262c83802c 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1628,10 +1628,12 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
 	void *cpu_addr;
 
 	page = dma_alloc_contiguous(dev, alloc_size, gfp);
-	if (!page)
-		page = alloc_pages_node(node, gfp, get_order(alloc_size));
-	if (!page)
-		return NULL;
+	if (!page) {
+		cpu_addr = alloc_pages_exact_nid(node, alloc_size, gfp);
+		if (!cpu_addr)
+			return NULL;
+		page = virt_to_page(cpu_addr);
+	}
 
 	if (!coherent || PageHighMem(page)) {
 		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 8fae2b7deb20..3ef3003713a6 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -143,7 +143,7 @@ static inline struct page *dma_alloc_contiguous(struct device *dev, size_t size,
 static inline void dma_free_contiguous(struct device *dev, struct page *page,
 		size_t size)
 {
-	__free_pages(page, get_order(size));
+	free_pages_exact(page_address(page), size);
 }
 #endif /* CONFIG_DMA_CMA*/
 
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 872bc53f32ec..aa4601805f21 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -329,7 +329,7 @@ void *alloc_pages_exact_noprof(size_t size, gfp_t gfp_mask) __alloc_size(1);
 
 void free_pages_exact(void *virt, size_t size);
 
-__meminit void *alloc_pages_exact_nid_noprof(int nid, size_t size, gfp_t gfp_mask) __alloc_size(2);
+void *alloc_pages_exact_nid_noprof(int nid, size_t size, gfp_t gfp_mask) __alloc_size(2);
 #define alloc_pages_exact_nid(...)					\
 	alloc_hooks(alloc_pages_exact_nid_noprof(__VA_ARGS__))
 
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 66093460584e..90937dc7c627 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -451,8 +451,8 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
  *
  * This function releases memory allocated by dma_alloc_contiguous(). As the
  * cma_release returns false when provided pages do not belong to contiguous
- * area and true otherwise, this function then does a fallback __free_pages()
- * upon a false-return.
+ * area and true otherwise, this function then does a fallback
+ * free_pages_exact() upon a false-return.
  */
 void dma_free_contiguous(struct device *dev, struct page *page, size_t size)
 {
@@ -476,7 +476,7 @@ void dma_free_contiguous(struct device *dev, struct page *page, size_t size)
 	}
 
 	/* not in any cma, free from buddy */
-	__free_pages(page, get_order(size));
+	free_pages_exact(page_address(page), size);
 }
 
 /*
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index da665ca22d5c..ea64453d7370 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -120,6 +120,7 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 	int node = dev_to_node(dev);
 	struct page *page;
 	u64 phys_limit;
+	void *va;
 
 	WARN_ON_ONCE(!PAGE_ALIGNED(size));
 
@@ -133,9 +134,9 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 		dma_free_contiguous(dev, page, size);
 	}
 
-	while ((page = alloc_pages_node(node, gfp, get_order(size)))
-	       && !dma_coherent_ok(dev, page_to_phys(page), size)) {
-		__free_pages(page, get_order(size));
+	while ((va = alloc_pages_exact_nid(node, size, gfp)) &&
+	       !dma_coherent_ok(dev, virt_to_phys(va), size)) {
+		free_pages_exact(va, size);
 
 		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
 		    phys_limit < DMA_BIT_MASK(64) &&
@@ -146,6 +147,7 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 		else
 			return NULL;
 	}
+	page = va ? virt_to_page(va) : NULL;
 
 	return page;
 }
diff --git a/kernel/dma/ops_helpers.c b/kernel/dma/ops_helpers.c
index 6b5f9208d31c..5cdf3f60cf47 100644
--- a/kernel/dma/ops_helpers.c
+++ b/kernel/dma/ops_helpers.c
@@ -67,10 +67,13 @@ struct page *dma_common_alloc_pages(struct device *dev, size_t size,
 	phys_addr_t phys;
 
 	page = dma_alloc_contiguous(dev, size, gfp);
-	if (!page)
-		page = alloc_pages_node(dev_to_node(dev), gfp, get_order(size));
-	if (!page)
-		return NULL;
+	if (!page) {
+		void *va = alloc_pages_exact_nid(dev_to_node(dev), size, gfp);
+
+		if (!va)
+			return NULL;
+		page = virt_to_page(va);
+	}
 
 	phys = page_to_phys(page);
 	if (use_dma_iommu(dev))
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c4dc61ec663e..d3a135dfcdd3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5637,7 +5637,7 @@ EXPORT_SYMBOL(alloc_pages_exact_noprof);
  *
  * Return: pointer to the allocated area or %NULL in case of error.
  */
-void * __meminit alloc_pages_exact_nid_noprof(int nid, size_t size, gfp_t gfp_mask)
+void *alloc_pages_exact_nid_noprof(int nid, size_t size, gfp_t gfp_mask)
 {
 	unsigned int order = get_order(size);
 	struct page *p;
-- 
2.43.0

