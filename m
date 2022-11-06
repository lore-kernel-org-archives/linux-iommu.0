Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5025ABA25
	for <iommu@lists.linux.dev>; Sun,  6 Nov 2022 22:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49473C4347C;
	Sun,  6 Nov 2022 22:01:58 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>,
	Isaac Manjarres <isaacmanjarres@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Alasdair Kergon <agk@redhat.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>,
	Mark Brown <broonie@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-mm@kvack.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 03/13] iommu/dma: Force bouncing of the size is not cacheline-aligned
Date: Sun,  6 Nov 2022 22:01:33 +0000
Message-Id: <20221106220143.2129263-4-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221106220143.2129263-1-catalin.marinas@arm.com>
References: <20221106220143.2129263-1-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly to the direct DMA, bounce small allocations as they may have
originated from a kmalloc() cache not safe for DMA. Unlike the direct
DMA, iommu_dma_map_sg() cannot call iommu_dma_map_sg_swiotlb() for all
non-coherent devices as this would break some cases where the iova is
expected to be contiguous (dmabuf). Instead, scan the scatterlist for
any small sizes and only go the swiotlb path if any element of the list
needs bouncing (note that iommu_dma_map_page() would still only bounce
those buffers which are not DMA-aligned).

To avoid scanning the scatterlist on the 'sync' operations, introduce a
SG_DMA_BOUNCED flag set during the iommu_dma_map_sg() call (suggested by
Robin Murphy).

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>
---

Not entirely sure about this approach but here it is. And it needs
better testing.

 drivers/iommu/dma-iommu.c   | 12 ++++++++----
 include/linux/dma-map-ops.h | 23 +++++++++++++++++++++++
 include/linux/scatterlist.h | 27 ++++++++++++++++++++++++---
 3 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9297b741f5e8..8c80dffe0337 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -948,7 +948,7 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	if (dev_use_swiotlb(dev))
+	if (dev_use_swiotlb(dev) || sg_is_dma_bounced(sgl))
 		for_each_sg(sgl, sg, nelems, i)
 			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
 						      sg->length, dir);
@@ -964,7 +964,7 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	if (dev_use_swiotlb(dev))
+	if (dev_use_swiotlb(dev) || sg_is_dma_bounced(sgl))
 		for_each_sg(sgl, sg, nelems, i)
 			iommu_dma_sync_single_for_device(dev,
 							 sg_dma_address(sg),
@@ -990,7 +990,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	 * If both the physical buffer start address and size are
 	 * page aligned, we don't need to use a bounce page.
 	 */
-	if (dev_use_swiotlb(dev) && iova_offset(iovad, phys | size)) {
+	if ((dev_use_swiotlb(dev) && iova_offset(iovad, phys | size)) ||
+	    dma_kmalloc_needs_bounce(dev, size, dir)) {
 		void *padding_start;
 		size_t padding_size, aligned_size;
 
@@ -1202,7 +1203,10 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 			goto out;
 	}
 
-	if (dev_use_swiotlb(dev))
+	if (dma_sg_kmalloc_needs_bounce(dev, sg, nents, dir))
+		sg_dma_mark_bounced(sg);
+
+	if (dev_use_swiotlb(dev) || sg_is_dma_bounced(sg))
 		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
 
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 785f7aa90f57..e747a46261d4 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -302,6 +302,29 @@ static inline bool dma_kmalloc_needs_bounce(struct device *dev, size_t size,
 	return true;
 }
 
+/*
+ * Return true if any of the scatterlist elements needs bouncing due to
+ * potentially originating from a small kmalloc() cache.
+ */
+static inline bool dma_sg_kmalloc_needs_bounce(struct device *dev,
+					       struct scatterlist *sg, int nents,
+					       enum dma_data_direction dir)
+{
+	struct scatterlist *s;
+	int i;
+
+	if (!IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) ||
+	    dir == DMA_TO_DEVICE || dev_is_dma_coherent(dev))
+		return false;
+
+	for_each_sg(sg, s, nents, i) {
+		if (dma_kmalloc_needs_bounce(dev, s->length, dir))
+			return true;
+	}
+
+	return false;
+}
+
 void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs);
 void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 375a5e90d86a..f16cf040fe2c 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -16,7 +16,7 @@ struct scatterlist {
 #ifdef CONFIG_NEED_SG_DMA_LENGTH
 	unsigned int	dma_length;
 #endif
-#ifdef CONFIG_PCI_P2PDMA
+#if defined(CONFIG_PCI_P2PDMA) || defined(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC)
 	unsigned int    dma_flags;
 #endif
 };
@@ -248,6 +248,29 @@ static inline void sg_unmark_end(struct scatterlist *sg)
 	sg->page_link &= ~SG_END;
 }
 
+#define SG_DMA_BUS_ADDRESS	(1 << 0)
+#define SG_DMA_BOUNCED		(1 << 1)
+
+#ifdef CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC
+static inline bool sg_is_dma_bounced(struct scatterlist *sg)
+{
+	return sg->dma_flags & SG_DMA_BOUNCED;
+}
+
+static inline void sg_dma_mark_bounced(struct scatterlist *sg)
+{
+	sg->dma_flags |= SG_DMA_BOUNCED;
+}
+#else
+static inline bool sg_is_dma_bounced(struct scatterlist *sg)
+{
+	return false;
+}
+static inline void sg_dma_mark_bounced(struct scatterlist *sg)
+{
+}
+#endif
+
 /*
  * CONFGI_PCI_P2PDMA depends on CONFIG_64BIT which means there is 4 bytes
  * in struct scatterlist (assuming also CONFIG_NEED_SG_DMA_LENGTH is set).
@@ -256,8 +279,6 @@ static inline void sg_unmark_end(struct scatterlist *sg)
  */
 #ifdef CONFIG_PCI_P2PDMA
 
-#define SG_DMA_BUS_ADDRESS (1 << 0)
-
 /**
  * sg_dma_is_bus address - Return whether a given segment was marked
  *			   as a bus address
