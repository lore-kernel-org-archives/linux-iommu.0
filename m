Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122F0BA25
	for <iommu@lists.linux.dev>; Sun,  6 Nov 2022 22:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37993C433B5;
	Sun,  6 Nov 2022 22:01:54 +0000 (UTC)
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
Subject: [PATCH v3 02/13] dma-mapping: Force bouncing if the kmalloc() size is not cacheline-aligned
Date: Sun,  6 Nov 2022 22:01:32 +0000
Message-Id: <20221106220143.2129263-3-catalin.marinas@arm.com>
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

For direct DMA, if the size is small enough to have originated from a
kmalloc() cache below ARCH_DMA_MINALIGN, check its alignment against
cache_line_size() and bounce if necessary. For larger sizes, it is the
responsibility of the DMA API caller to ensure proper alignment.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>
---
 include/linux/dma-map-ops.h | 27 +++++++++++++++++++++++++++
 kernel/dma/direct.h         |  3 ++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index d678afeb8a13..785f7aa90f57 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -8,6 +8,7 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/pgtable.h>
+#include <linux/slab.h>
 
 struct cma;
 
@@ -275,6 +276,32 @@ static inline bool dev_is_dma_coherent(struct device *dev)
 }
 #endif /* CONFIG_ARCH_HAS_DMA_COHERENCE_H */
 
+/*
+ * Check whether the given size, assuming it is for a kmalloc()'ed object, is
+ * safe for non-coherent DMA or needs bouncing.
+ */
+static inline bool dma_kmalloc_needs_bounce(struct device *dev, size_t size,
+					    enum dma_data_direction dir)
+{
+	/*
+	 * No need for bouncing if coherent DMA or the direction is
+	 * DMA_TO_DEVICE.
+	 */
+	if (!IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) ||
+	    dir == DMA_TO_DEVICE || dev_is_dma_coherent(dev))
+		return false;
+
+	/*
+	 * Larger kmalloc() sizes are guaranteed to be aligned to
+	 * ARCH_DMA_MINALIGN.
+	 */
+	if (size >= 2 * ARCH_DMA_MINALIGN ||
+	    IS_ALIGNED(kmalloc_size_roundup(size), dma_get_cache_alignment()))
+		return false;
+
+	return true;
+}
+
 void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs);
 void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
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
