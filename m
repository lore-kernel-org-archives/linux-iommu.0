From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 3/5] dma: Introduce dma_max_mapping_size()
Date: Wed, 23 Jan 2019 17:30:47 +0100
Message-ID: <20190123163049.24863-4-joro@8bytes.org>
References: <20190123163049.24863-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190123163049.24863-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, jfehlig@suse.com, jon.grimm@amd.com, brijesh.singh@amd.com, joro@8bytes.org, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

The function returns the maximum size that can be mapped
using DMA-API functions. The patch also adds the
implementation for direct DMA and a new dma_map_ops pointer
so that other implementations can expose their limit.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 include/linux/dma-mapping.h | 16 ++++++++++++++++
 kernel/dma/direct.c         | 11 +++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f6ded992c183..a3ca8a71a704 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -130,6 +130,7 @@ struct dma_map_ops {
 			enum dma_data_direction direction);
 	int (*dma_supported)(struct device *dev, u64 mask);
 	u64 (*get_required_mask)(struct device *dev);
+	size_t (*max_mapping_size)(struct device *dev);
 };
 
 #define DMA_MAPPING_ERROR		(~(dma_addr_t)0)
@@ -257,6 +258,8 @@ static inline void dma_direct_sync_sg_for_cpu(struct device *dev,
 }
 #endif
 
+size_t dma_direct_max_mapping_size(struct device *dev);
+
 #ifdef CONFIG_HAS_DMA
 #include <asm/dma-mapping.h>
 
@@ -440,6 +443,19 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 	return 0;
 }
 
+static inline size_t dma_max_mapping_size(struct device *dev)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+	size_t size = SIZE_MAX;
+
+	if (dma_is_direct(ops))
+		size = dma_direct_max_mapping_size(dev);
+	else if (ops && ops->max_mapping_size)
+		size = ops->max_mapping_size(dev);
+
+	return size;
+}
+
 void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t flag, unsigned long attrs);
 void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 355d16acee6d..6310ad01f915 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -380,3 +380,14 @@ int dma_direct_supported(struct device *dev, u64 mask)
 	 */
 	return mask >= __phys_to_dma(dev, min_mask);
 }
+
+size_t dma_direct_max_mapping_size(struct device *dev)
+{
+	size_t size = SIZE_MAX;
+
+	/* If SWIOTLB is active, use its maximum mapping size */
+	if (is_swiotlb_active())
+		size = swiotlb_max_mapping_size(dev);
+
+	return size;
+}
-- 
2.17.1
