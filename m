From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 2/4] dma-debug: Refactor dma_debug_entry allocation
Date: Mon,  3 Dec 2018 17:28:07 +0000
Message-ID: <a827949d4fde7f8eca805e3b09c2eb7fb16d8bec.1543856576.git.robin.murphy@arm.com>
References: <cover.1543856576.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1543856576.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de
Cc: m.szyprowski@samsung.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com, john.garry@huawei.com
List-Id: iommu@lists.linux-foundation.org

Make prealloc_memory() a little more general and robust so that it
serves for runtime reallocations too. The first thing we can do with
that is clean up dma_debug_resize_entries() quite a bit.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 kernel/dma/debug.c | 95 +++++++++++++++++++---------------------------
 1 file changed, 40 insertions(+), 55 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 91b84140e4a5..de5db800dbfc 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -645,6 +645,39 @@ static void add_dma_entry(struct dma_debug_entry *entry)
 	 */
 }
 
+static int prealloc_memory(u32 num_entries)
+{
+	struct dma_debug_entry *entry, *next_entry;
+	unsigned long flags;
+	LIST_HEAD(tmp);
+	int i;
+
+	for (i = 0; i < num_entries; ++i) {
+		entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+		if (!entry)
+			goto out_err;
+
+		list_add_tail(&entry->list, &tmp);
+	}
+
+	spin_lock_irqsave(&free_entries_lock, flags);
+	list_splice(&tmp, &free_entries);
+	num_free_entries += num_entries;
+	nr_total_entries += num_entries;
+	spin_unlock_irqrestore(&free_entries_lock, flags);
+
+	return 0;
+
+out_err:
+
+	list_for_each_entry_safe(entry, next_entry, &tmp, list) {
+		list_del(&entry->list);
+		kfree(entry);
+	}
+
+	return -ENOMEM;
+}
+
 static struct dma_debug_entry *__dma_entry_alloc(void)
 {
 	struct dma_debug_entry *entry;
@@ -714,44 +747,25 @@ int dma_debug_resize_entries(u32 num_entries)
 	int i, delta, ret = 0;
 	unsigned long flags;
 	struct dma_debug_entry *entry;
-	LIST_HEAD(tmp);
-
-	spin_lock_irqsave(&free_entries_lock, flags);
 
 	if (nr_total_entries < num_entries) {
 		delta = num_entries - nr_total_entries;
 
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
+		ret = prealloc_memory(delta);
 	} else {
 		delta = nr_total_entries - num_entries;
 
+		spin_lock_irqsave(&free_entries_lock, flags);
 		for (i = 0; i < delta && !list_empty(&free_entries); i++) {
 			entry = __dma_entry_alloc();
 			kfree(entry);
 		}
+		spin_unlock_irqrestore(&free_entries_lock, flags);
 
 		nr_total_entries -= i;
+		if (nr_total_entries != num_entries)
+			ret = -EBUSY;
 	}
-
-	if (nr_total_entries != num_entries)
-		ret = 1;
-
-	spin_unlock_irqrestore(&free_entries_lock, flags);
-
 	return ret;
 }
 
@@ -763,36 +777,6 @@ int dma_debug_resize_entries(u32 num_entries)
  *   2. Preallocate a given number of dma_debug_entry structs
  */
 
-static int prealloc_memory(u32 num_entries)
-{
-	struct dma_debug_entry *entry, *next_entry;
-	int i;
-
-	for (i = 0; i < num_entries; ++i) {
-		entry = kzalloc(sizeof(*entry), GFP_KERNEL);
-		if (!entry)
-			goto out_err;
-
-		list_add_tail(&entry->list, &free_entries);
-	}
-
-	num_free_entries = num_entries;
-	min_free_entries = num_entries;
-
-	pr_info("preallocated %d debug entries\n", num_entries);
-
-	return 0;
-
-out_err:
-
-	list_for_each_entry_safe(entry, next_entry, &free_entries, list) {
-		list_del(&entry->list);
-		kfree(entry);
-	}
-
-	return -ENOMEM;
-}
-
 static ssize_t filter_read(struct file *file, char __user *user_buf,
 			   size_t count, loff_t *ppos)
 {
@@ -1038,7 +1022,8 @@ static int dma_debug_init(void)
 		return 0;
 	}
 
-	nr_total_entries = num_free_entries;
+	min_free_entries = num_free_entries;
+	pr_info("preallocated %d debug entries\n", nr_total_entries);
 
 	dma_debug_initialized = true;
 
-- 
2.19.1.dirty
