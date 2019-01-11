From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/3] videobuf2: replace a layering violation with dma_map_resource
Date: Fri, 11 Jan 2019 19:17:31 +0100
Message-ID: <20190111181731.11782-4-hch@lst.de>
References: <20190111181731.11782-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190111181731.11782-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Pawel Osciak <pawel@osciak.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Russell King <linux@armlinux.org.uk>, Mauro Carvalho Chehab <mchehab@kernel.org>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

vb2_dc_get_userptr pokes into arm direct mapping details to get the
resemblance of a dma address for a a physical address that does is
not backed by a page struct.  Not only is this not portable to other
architectures with dma direct mapping offsets, but also not to uses
of IOMMUs of any kind.  Switch to the proper dma_map_resource /
dma_unmap_resource interface instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 .../common/videobuf2/videobuf2-dma-contig.c   | 41 ++++---------------
 1 file changed, 9 insertions(+), 32 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
index aff0ab7bf83d..82389aead6ed 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
@@ -439,42 +439,14 @@ static void vb2_dc_put_userptr(void *buf_priv)
 				set_page_dirty_lock(pages[i]);
 		sg_free_table(sgt);
 		kfree(sgt);
+	} else {
+		dma_unmap_resource(buf->dev, buf->dma_addr, buf->size,
+				   buf->dma_dir, 0);
 	}
 	vb2_destroy_framevec(buf->vec);
 	kfree(buf);
 }
 
-/*
- * For some kind of reserved memory there might be no struct page available,
- * so all that can be done to support such 'pages' is to try to convert
- * pfn to dma address or at the last resort just assume that
- * dma address == physical address (like it has been assumed in earlier version
- * of videobuf2-dma-contig
- */
-
-#ifdef __arch_pfn_to_dma
-static inline dma_addr_t vb2_dc_pfn_to_dma(struct device *dev, unsigned long pfn)
-{
-	return (dma_addr_t)__arch_pfn_to_dma(dev, pfn);
-}
-#elif defined(__pfn_to_bus)
-static inline dma_addr_t vb2_dc_pfn_to_dma(struct device *dev, unsigned long pfn)
-{
-	return (dma_addr_t)__pfn_to_bus(pfn);
-}
-#elif defined(__pfn_to_phys)
-static inline dma_addr_t vb2_dc_pfn_to_dma(struct device *dev, unsigned long pfn)
-{
-	return (dma_addr_t)__pfn_to_phys(pfn);
-}
-#else
-static inline dma_addr_t vb2_dc_pfn_to_dma(struct device *dev, unsigned long pfn)
-{
-	/* really, we cannot do anything better at this point */
-	return (dma_addr_t)(pfn) << PAGE_SHIFT;
-}
-#endif
-
 static void *vb2_dc_get_userptr(struct device *dev, unsigned long vaddr,
 	unsigned long size, enum dma_data_direction dma_dir)
 {
@@ -528,7 +500,12 @@ static void *vb2_dc_get_userptr(struct device *dev, unsigned long vaddr,
 		for (i = 1; i < n_pages; i++)
 			if (nums[i-1] + 1 != nums[i])
 				goto fail_pfnvec;
-		buf->dma_addr = vb2_dc_pfn_to_dma(buf->dev, nums[0]);
+		buf->dma_addr = dma_map_resource(buf->dev,
+				__pfn_to_phys(nums[0]), size, buf->dma_dir, 0);
+		if (dma_mapping_error(buf->dev, buf->dma_addr)) {
+			ret = -ENOMEM;
+			goto fail_pfnvec;
+		}
 		goto out;
 	}
 
-- 
2.20.1
