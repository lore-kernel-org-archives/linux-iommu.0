From: Qian Cai <cai@gmx.us>
Subject: [PATCH v2] dma-debug: Kconfig for PREALLOC_DMA_DEBUG_ENTRIES
Date: Fri, 30 Nov 2018 16:48:03 -0500
Message-ID: <20181130214803.3119-1-cai@gmx.us>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, john.garry@huawei.com, linuxarm@huawei.com, iommu@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Qian Cai <cai@gmx.us>
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

Also, "#define HNS_DSAF_MAX_DESC_CNT 1024"

On this Huawei TaiShan 2280 aarch64 server, it has reached the limit
already,

4 (NICs) x 16 (queues) x 1024 (port descption numbers) = 65536

Added a Kconfig entry for PREALLOC_DMA_DEBUG_ENTRIES, so make it easier
for users to deal with special cases like this.

Signed-off-by: Qian Cai <cai@gmx.us>
---

Changes since v1:
* Increased the default value if has HNS_ENET suggested by Robin.

 kernel/dma/debug.c |  9 ++-------
 lib/Kconfig.debug  | 10 ++++++++++
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 231ca4628062..3752fb23f72f 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -41,11 +41,6 @@
 #define HASH_FN_SHIFT   13
 #define HASH_FN_MASK    (HASH_SIZE - 1)
 
-/* allow architectures to override this if absolutely required */
-#ifndef PREALLOC_DMA_DEBUG_ENTRIES
-#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
-#endif
-
 enum {
 	dma_debug_single,
 	dma_debug_page,
@@ -132,7 +127,7 @@ static u32 min_free_entries;
 static u32 nr_total_entries;
 
 /* number of preallocated entries requested by kernel cmdline */
-static u32 nr_prealloc_entries = PREALLOC_DMA_DEBUG_ENTRIES;
+static u32 nr_prealloc_entries = CONFIG_PREALLOC_DMA_DEBUG_ENTRIES;
 
 /* debugfs dentry's for the stuff above */
 static struct dentry *dma_debug_dent        __read_mostly;
@@ -1063,7 +1058,7 @@ static __init int dma_debug_entries_cmdline(char *str)
 	if (!str)
 		return -EINVAL;
 	if (!get_option(&str, &nr_prealloc_entries))
-		nr_prealloc_entries = PREALLOC_DMA_DEBUG_ENTRIES;
+		nr_prealloc_entries = CONFIG_PREALLOC_DMA_DEBUG_ENTRIES;
 	return 0;
 }
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1af29b8224fd..9f85a7a13647 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1659,6 +1659,16 @@ config DMA_API_DEBUG
 
 	  If unsure, say N.
 
+config PREALLOC_DMA_DEBUG_ENTRIES
+	int "Preallocated DMA-API debugging entries"
+	depends on DMA_API_DEBUG
+	default 131072 if HNS_ENET
+	default 65536
+	help
+	  The number of preallocated entries for DMA-API debugging code. One
+	  entry is required per DMA-API allocation. Increase this if the DMA-API
+	  debugging code disables itself because the default is too low.
+
 config DMA_API_DEBUG_SG
 	bool "Debug DMA scatter-gather usage"
 	default y
-- 
2.17.2 (Apple Git-113)
