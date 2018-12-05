From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 7/8] dma/debug: Remove dma_debug_resize_entries()
Date: Wed,  5 Dec 2018 19:56:56 +0000
Message-ID: <229557ee9d279393473997caa825617b6d0b19e3.1544037783.git.robin.murphy@arm.com>
References: <cover.1544037783.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1544037783.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de
Cc: m.szyprowski@samsung.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com, john.garry@huawei.com
List-Id: iommu@lists.linux-foundation.org

With no callers left, we can clean up this part of dma-debug's exposed
internals, making way to tweak the allocation behaviour.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: New

 include/linux/dma-debug.h |  7 -------
 kernel/dma/debug.c        | 30 ------------------------------
 2 files changed, 37 deletions(-)

diff --git a/include/linux/dma-debug.h b/include/linux/dma-debug.h
index 30213adbb6b9..46e6131a72b6 100644
--- a/include/linux/dma-debug.h
+++ b/include/linux/dma-debug.h
@@ -30,8 +30,6 @@ struct bus_type;
 
 extern void dma_debug_add_bus(struct bus_type *bus);
 
-extern int dma_debug_resize_entries(u32 num_entries);
-
 extern void debug_dma_map_single(struct device *dev, const void *addr,
 				 unsigned long len);
 
@@ -101,11 +99,6 @@ static inline void dma_debug_add_bus(struct bus_type *bus)
 {
 }
 
-static inline int dma_debug_resize_entries(u32 num_entries)
-{
-	return 0;
-}
-
 static inline void debug_dma_map_single(struct device *dev, const void *addr,
 					unsigned long len)
 {
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index cd9a12bf6a3a..2202402afe9a 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -756,36 +756,6 @@ static void dma_entry_free(struct dma_debug_entry *entry)
 	spin_unlock_irqrestore(&free_entries_lock, flags);
 }
 
-int dma_debug_resize_entries(u32 num_entries)
-{
-	int i, delta, ret = 0;
-	unsigned long flags;
-	struct dma_debug_entry *entry;
-
-	spin_lock_irqsave(&free_entries_lock, flags);
-
-	if (nr_total_entries < num_entries) {
-		delta = num_entries - nr_total_entries;
-
-		ret = dma_debug_add_entries(delta, GFP_ATOMIC);
-	} else {
-		delta = nr_total_entries - num_entries;
-
-		for (i = 0; i < delta && !list_empty(&free_entries); i++) {
-			entry = __dma_entry_alloc();
-			kfree(entry);
-		}
-
-		nr_total_entries -= i;
-		if (nr_total_entries != num_entries)
-			ret = -EBUSY;
-	}
-
-	spin_unlock_irqrestore(&free_entries_lock, flags);
-
-	return ret;
-}
-
 /*
  * DMA-API debugging init code
  *
-- 
2.19.1.dirty
