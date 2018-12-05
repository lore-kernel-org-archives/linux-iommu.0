From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] dma-mapping: fix lack of DMA address assignment in generic
 remap allocator
Date: Wed, 05 Dec 2018 11:14:01 +0100
Message-ID: <20181205101401.3561-1-m.szyprowski@samsung.com>
References: <20181204142304.GC2618@lst.de>
        <CGME20181205101414eucas1p2fdde1c06ad6352293980b94b86b022f9@eucas1p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20181204142304.GC2618@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Commit bfd56cd60521 ("dma-mapping: support highmem in the generic remap
allocator") replaced dma_direct_alloc_pages() with __dma_direct_alloc_pages(),
which doesn't set dma_handle and zero allocated memory. Fix it by doing this
directly in the caller function.

Fixes: bfd56cd60521 ("dma-mapping: support highmem in the generic remap allocator")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 kernel/dma/remap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index 68a64e3ff6a1..8a44317cfc1a 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -223,8 +223,14 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	ret = dma_common_contiguous_remap(page, size, VM_USERMAP,
 			arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs),
 			__builtin_return_address(0));
-	if (!ret)
+	if (!ret) {
 		__dma_direct_free_pages(dev, size, page);
+		return ret;
+	}
+
+	*dma_handle = phys_to_dma(dev, page_to_phys(page));
+	memset(ret, 0, size);
+
 	return ret;
 }
 
-- 
2.17.1
