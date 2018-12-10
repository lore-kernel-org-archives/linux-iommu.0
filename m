From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v3 6/7] dma/debug: Remove dma_debug_resize_entries()
Date: Mon, 10 Dec 2018 14:00:32 +0000
Message-ID: <9b219f4d9e9e9598baec2b15f4337cc608f7501d.1544447601.git.robin.murphy@arm.com>
References: <cover.1544447601.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1544447601.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de
Cc: m.szyprowski@samsung.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com, john.garry@huawei.com
List-Id: iommu@lists.linux-foundation.org

With the only caller now gone, we can clean up this part of dma-debug's
exposed internals and make way to tweak the allocation behaviour.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v3: Add Christoph's review tag

 include/linux/dma-debug.h |  7 ------
 kernel/dma/debug.c        | 46 ---------------------------------------
 2 files changed, 53 deletions(-)

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
index 912c23f4c177..36a42874b05f 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -755,52 +755,6 @@ static void dma_entry_free(struct dma_debug_entry *entry)
 	spin_unlock_irqrestore(&free_entries_lock, flags);
 }
 
-int dma_debug_resize_entries(u32 num_entries)
-{
-	int i, delta, ret = 0;
-	unsigned long flags;
-	struct dma_debug_entry *entry;
-	LIST_HEAD(tmp);
-
-	spin_lock_irqsave(&free_entries_lock, flags);
-
-	if (nr_total_entries < num_entries) {
-		delta = num_entries - nr_total_entries;
-
-		spin_unlock_irqrestore(&free_entries_lock, flags);
-
-		for (i = 0; i < delta; i++) {
-			entry = kzalloc(sizeof(*entry), GFP_KERNEL);
-			if (!entry)
-				break;
-
-			list_add_tail(&entry->list, &tmp);
-		}
-
-		spin_lock_irqsave(&free_entries_lock, flags);
-
-		list_splice(&tmp, &free_entries);
-		nr_total_entries += i;
-		num_free_entries += i;
-	} else {
-		delta = nr_total_entries - num_entries;
-
-		for (i = 0; i < delta && !list_empty(&free_entries); i++) {
-			entry = __dma_entry_alloc();
-			kfree(entry);
-		}
-
-		nr_total_entries -= i;
-	}
-
-	if (nr_total_entries != num_entries)
-		ret = 1;
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
