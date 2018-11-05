From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/9] dma-direct: reject highmem pages from dma_alloc_from_contiguous
Date: Mon,  5 Nov 2018 13:19:24 +0100
Message-ID: <20181105121931.13481-3-hch@lst.de>
References: <20181105121931.13481-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181105121931.13481-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Robin Murphy <robin.murphy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

dma_alloc_from_contiguous can return highmem pages depending on the
setup, which a plain non-remapping DMA allocator can't handle.  Detect
this case and try the normal page allocator instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 680287779b0a..c49849bcced6 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -162,6 +162,18 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	if (!page)
 		return NULL;
 
+	if (PageHighMem(page)) {
+		/*
+		 * Depending on the cma= arguments and per-arch setup
+		 * dma_alloc_from_contiguous could return highmem pages.
+		 * Without remapping there is no way to return them here,
+		 * so log an error and fail.
+		 */
+		dev_info(dev, "Rejecting highmem page from CMA.\n");
+		__dma_direct_free_pages(dev, size, page);
+		return NULL;
+	}
+
 	ret = page_address(page);
 	if (force_dma_unencrypted()) {
 		set_memory_decrypted((unsigned long)ret, 1 << get_order(size));
-- 
2.19.1
