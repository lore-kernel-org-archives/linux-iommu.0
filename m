Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3B5182B8
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 17:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B11C4339B;
	Thu, 18 May 2023 17:34:58 +0000 (UTC)
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
Subject: [PATCH v4 13/15] iommu/dma: Force bouncing if the size is not cacheline-aligned
Date: Thu, 18 May 2023 18:34:01 +0100
Message-Id: <20230518173403.1150549-14-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518173403.1150549-1-catalin.marinas@arm.com>
References: <20230518173403.1150549-1-catalin.marinas@arm.com>
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
 drivers/iommu/dma-iommu.c   | 25 ++++++++++++++++++++-----
 include/linux/scatterlist.h | 25 +++++++++++++++++++++++--
 2 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7a9f0b0bddbd..ab1c1681c06e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -956,7 +956,7 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	if (dev_use_swiotlb(dev))
+	if (dev_use_swiotlb(dev) || sg_is_dma_bounced(sgl))
 		for_each_sg(sgl, sg, nelems, i)
 			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
 						      sg->length, dir);
@@ -972,7 +972,7 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	if (dev_use_swiotlb(dev))
+	if (dev_use_swiotlb(dev) || sg_is_dma_bounced(sgl))
 		for_each_sg(sgl, sg, nelems, i)
 			iommu_dma_sync_single_for_device(dev,
 							 sg_dma_address(sg),
@@ -998,7 +998,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	 * If both the physical buffer start address and size are
 	 * page aligned, we don't need to use a bounce page.
 	 */
-	if (dev_use_swiotlb(dev) && iova_offset(iovad, phys | size)) {
+	if ((dev_use_swiotlb(dev) && iova_offset(iovad, phys | size)) ||
+	    dma_kmalloc_needs_bounce(dev, size, dir)) {
 		void *padding_start;
 		size_t padding_size, aligned_size;
 
@@ -1210,7 +1211,21 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 			goto out;
 	}
 
-	if (dev_use_swiotlb(dev))
+	/*
+	 * If kmalloc() buffers are not DMA-safe for this device and
+	 * direction, check the individual lengths in the sg list. If one of
+	 * the buffers is deemed unsafe, follow the iommu_dma_map_sg_swiotlb()
+	 * path for potential bouncing.
+	 */
+	if (!dma_kmalloc_safe(dev, dir)) {
+		for_each_sg(sg, s, nents, i)
+			if (!dma_kmalloc_size_aligned(s->length)) {
+				sg_dma_mark_bounced(sg);
+				break;
+			}
+	}
+
+	if (dev_use_swiotlb(dev) || sg_is_dma_bounced(sg))
 		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
 
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
@@ -1315,7 +1330,7 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	struct scatterlist *tmp;
 	int i;
 
-	if (dev_use_swiotlb(dev)) {
+	if (dev_use_swiotlb(dev) || sg_is_dma_bounced(sg)) {
 		iommu_dma_unmap_sg_swiotlb(dev, sg, nents, dir, attrs);
 		return;
 	}
diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 87aaf8b5cdb4..9306880cae1c 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
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
  * CONFIG_PCI_P2PDMA depends on CONFIG_64BIT which means there is 4 bytes
  * in struct scatterlist (assuming also CONFIG_NEED_SG_DMA_LENGTH is set).
@@ -256,8 +279,6 @@ static inline void sg_unmark_end(struct scatterlist *sg)
  */
 #ifdef CONFIG_PCI_P2PDMA
 
-#define SG_DMA_BUS_ADDRESS (1 << 0)
-
 /**
  * sg_dma_is_bus address - Return whether a given segment was marked
  *			   as a bus address
