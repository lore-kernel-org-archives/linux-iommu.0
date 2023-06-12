Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02451DDD8
	for <iommu@lists.linux.dev>; Mon, 12 Jun 2023 15:33:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F8DC433D2;
	Mon, 12 Jun 2023 15:33:05 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
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
	Jonathan Cameron <jic23@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 14/17] dma-mapping: Force bouncing if the kmalloc() size is not cache-line-aligned
Date: Mon, 12 Jun 2023 16:31:58 +0100
Message-Id: <20230612153201.554742-15-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612153201.554742-1-catalin.marinas@arm.com>
References: <20230612153201.554742-1-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For direct DMA, if the size is small enough to have originated from a
kmalloc() cache below ARCH_DMA_MINALIGN, check its alignment against
dma_get_cache_alignment() and bounce if necessary. For larger sizes, it
is the responsibility of the DMA API caller to ensure proper alignment.

At this point, the kmalloc() caches are properly aligned but this will
change in a subsequent patch.

Architectures can opt in by selecting DMA_BOUNCE_UNALIGNED_KMALLOC.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 include/linux/dma-map-ops.h | 61 +++++++++++++++++++++++++++++++++++++
 kernel/dma/Kconfig          |  4 +++
 kernel/dma/direct.h         |  3 +-
 3 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 31f114f486c4..9bf19b5bf755 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -8,6 +8,7 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/pgtable.h>
+#include <linux/slab.h>
 
 struct cma;
 
@@ -277,6 +278,66 @@ static inline bool dev_is_dma_coherent(struct device *dev)
 }
 #endif /* CONFIG_ARCH_HAS_DMA_COHERENCE_H */
 
+/*
+ * Check whether potential kmalloc() buffers are safe for non-coherent DMA.
+ */
+static inline bool dma_kmalloc_safe(struct device *dev,
+				    enum dma_data_direction dir)
+{
+	/*
+	 * If DMA bouncing of kmalloc() buffers is disabled, the kmalloc()
+	 * caches have already been aligned to a DMA-safe size.
+	 */
+	if (!IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC))
+		return true;
+
+	/*
+	 * kmalloc() buffers are DMA-safe irrespective of size if the device
+	 * is coherent or the direction is DMA_TO_DEVICE (non-desctructive
+	 * cache maintenance and benign cache line evictions).
+	 */
+	if (dev_is_dma_coherent(dev) || dir == DMA_TO_DEVICE)
+		return true;
+
+	return false;
+}
+
+/*
+ * Check whether the given size, assuming it is for a kmalloc()'ed buffer, is
+ * sufficiently aligned for non-coherent DMA.
+ */
+static inline bool dma_kmalloc_size_aligned(size_t size)
+{
+	/*
+	 * Larger kmalloc() sizes are guaranteed to be aligned to
+	 * ARCH_DMA_MINALIGN.
+	 */
+	if (size >= 2 * ARCH_DMA_MINALIGN ||
+	    IS_ALIGNED(kmalloc_size_roundup(size), dma_get_cache_alignment()))
+		return true;
+
+	return false;
+}
+
+/*
+ * Check whether the given object size may have originated from a kmalloc()
+ * buffer with a slab alignment below the DMA-safe alignment and needs
+ * bouncing for non-coherent DMA. The pointer alignment is not considered and
+ * in-structure DMA-safe offsets are the responsibility of the caller. Such
+ * code should use the static ARCH_DMA_MINALIGN for compiler annotations.
+ *
+ * The heuristics can have false positives, bouncing unnecessarily, though the
+ * buffers would be small. False negatives are theoretically possible if, for
+ * example, multiple small kmalloc() buffers are coalesced into a larger
+ * buffer that passes the alignment check. There are no such known constructs
+ * in the kernel.
+ */
+static inline bool dma_kmalloc_needs_bounce(struct device *dev, size_t size,
+					    enum dma_data_direction dir)
+{
+	return !dma_kmalloc_safe(dev, dir) && !dma_kmalloc_size_aligned(size);
+}
+
 void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs);
 void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index acc6f231259c..abea1823fe21 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -90,6 +90,10 @@ config SWIOTLB
 	bool
 	select NEED_DMA_MAP_STATE
 
+config DMA_BOUNCE_UNALIGNED_KMALLOC
+	bool
+	depends on SWIOTLB
+
 config DMA_RESTRICTED_POOL
 	bool "DMA Restricted Pool"
 	depends on OF && OF_RESERVED_MEM && SWIOTLB
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index e38ffc5e6bdd..97ec892ea0b5 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -94,7 +94,8 @@ static inline dma_addr_t dma_direct_map_page(struct device *dev,
 		return swiotlb_map(dev, phys, size, dir, attrs);
 	}
 
-	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
+	if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
+	    dma_kmalloc_needs_bounce(dev, size, dir)) {
 		if (is_pci_p2pdma_page(page))
 			return DMA_MAPPING_ERROR;
 		if (is_swiotlb_active(dev))
