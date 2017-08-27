From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 03/12] frv: make dma_cache_sync a no-op
Date: Sun, 27 Aug 2017 18:10:23 +0200
Message-ID: <20170827161032.22772-4-hch@lst.de>
References: <20170827161032.22772-1-hch@lst.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20170827161032.22772-1-hch@lst.de>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

frv does not implement DMA_ATTR_NON_CONSISTENT allocations, so it doesn't
make any sense to do any work in dma_cache_sync given that it must be a
no-op when dma_alloc_attrs returns coherent memory.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/frv/include/asm/dma-mapping.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/frv/include/asm/dma-mapping.h b/arch/frv/include/asm/dma-mapping.h
index 354900917585..da0e5c9744c4 100644
--- a/arch/frv/include/asm/dma-mapping.h
+++ b/arch/frv/include/asm/dma-mapping.h
@@ -18,7 +18,6 @@ static inline
 void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 		    enum dma_data_direction direction)
 {
-	flush_write_buffers();
 }
 
 #endif  /* _ASM_DMA_MAPPING_H */
-- 
2.11.0

