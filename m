From: Robin Murphy <robin.murphy@arm.com>
Subject: [RFC 4/4] dma-debug: Make leak-like behaviour apparent
Date: Mon,  3 Dec 2018 17:28:09 +0000
Message-ID: <7ec928f0bd92122f271c421e99aaeb593ccabdf5.1543856576.git.robin.murphy@arm.com>
References: <cover.1543856576.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1543856576.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de
Cc: m.szyprowski@samsung.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com, john.garry@huawei.com
List-Id: iommu@lists.linux-foundation.org

Now that we can dynamically allocate DMA debug entries to cope with
drivers maintaining excessively large numbers of live mappings, a driver
which *does* actually have a bug leaking mappings (and is not unloaded)
will no longer trigger the "DMA-API: debugging out of memory - disabling"
message until it gets to actual kernel OOM conditions, which means it
could go unnoticed for a while. To that end, let's inform the user each
time the pool has grown to a multiple of its initial size, which should
make it apparent that they either have a leak or might want to increase
the preallocation size.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Tagging this one as RFC since people might think it's silly.

 kernel/dma/debug.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 46cc075aec99..c4759dab0f8c 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -696,6 +696,17 @@ static struct dma_debug_entry *__dma_entry_alloc(void)
 	return entry;
 }
 
+void __dma_entry_alloc_check_leak(void)
+{
+	u32 tmp = nr_total_entries % nr_prealloc_entries;
+
+	/* Shout each time we tick over some multiple of the initial pool */
+	if (tmp < DMA_DEBUG_DYNAMIC_ENTRIES) {
+		pr_info("dma_debug_entry pool grown to %u00%% - possible mapping leak?\n",
+			(nr_total_entries / nr_prealloc_entries));
+	}
+}
+
 /* struct dma_entry allocator
  *
  * The next two functions implement the allocator for
@@ -716,8 +727,10 @@ static struct dma_debug_entry *dma_entry_alloc(void)
 		spin_unlock_irqrestore(&free_entries_lock, flags);
 
 		if (retry_count < DMA_DEBUG_DYNAMIC_RETRIES &&
-		    !prealloc_memory(DMA_DEBUG_DYNAMIC_ENTRIES))
+		    !prealloc_memory(DMA_DEBUG_DYNAMIC_ENTRIES)) {
+			__dma_entry_alloc_check_leak();
 			continue;
+		}
 
 		global_disable = true;
 		pr_err("debugging out of memory - disabling\n");
-- 
2.19.1.dirty
