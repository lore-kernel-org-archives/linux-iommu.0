From: Qian Cai <cai@gmx.us>
Subject: [PATCH] dma-debug: hns_enet_drv could use more DMA entries
Date: Thu, 29 Nov 2018 22:54:56 -0500
Message-ID: <20181130035456.1586-1-cai@gmx.us>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, iommu@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Qian Cai <cai@gmx.us>
List-Id: iommu@lists.linux-foundation.org

The amount of DMA mappings from Hisilicon HNS ethernet devices is huge,
so it could trigger "DMA-API: debugging out of memory - disabling".

hnae_get_handle [1]
  hnae_init_queue
    hnae_init_ring
      hnae_alloc_buffers [2]
        debug_dma_map_page
          dma_entry_alloc

[1] for (i = 0; i < handle->q_num; i++)
[2] for (i = 0; i < ring->desc_num; i++)

On this Huawei TaiShan 2280 aarch64 server, it has reached the limit
already,

4 (ports) x 16 (handles) x 1024 (rings) = 65536

Signed-off-by: Qian Cai <cai@gmx.us>
---
 kernel/dma/debug.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 231ca4628062..ae91689cc9ad 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -43,8 +43,13 @@
 
 /* allow architectures to override this if absolutely required */
 #ifndef PREALLOC_DMA_DEBUG_ENTRIES
+/* amount of DMA mappings on this driver is huge. */
+#ifdef	HNS_ENET
+#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 17)
+#else
 #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
 #endif
+#endif
 
 enum {
 	dma_debug_single,
-- 
2.17.2 (Apple Git-113)
