From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 3/8] dma-debug: Refactor dma_debug_entry allocation
Date: Wed,  5 Dec 2018 19:56:52 +0000
Message-ID: <d868e775492e417f446d6d162f5f792bd41ee7bc.1544037783.git.robin.murphy@arm.com>
References: <cover.1544037783.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1544037783.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: hch-jcswGhMUV9g@public.gmane.org
Cc: cai-0UDz38MK/Mo@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Make the prealloc_memory() logic a little more general and robust so
that it serves for runtime reallocations too. The first thing we can
do with that is clean up dma_debug_resize_entries() a bit.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v2: Give it a better name, simplify the locking mess

 kernel/dma/debug.c | 87 +++++++++++++++++++---------------------------
 1 file changed, 36 insertions(+), 51 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 29486eb9d1dc..1b0858d7edfd 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -646,6 +646,36 @@ static void add_dma_entry(struct dma_debug_entry *entry)
 	 */
 }
 
+static int dma_debug_add_entries(u32 num_entries, gfp_t gfp)
+{
+	struct dma_debug_entry *entry, *next_entry;
+	LIST_HEAD(tmp);
+	int i;
+
+	for (i = 0; i < num_entries; ++i) {
+		entry = kzalloc(sizeof(*entry), gfp);
+		if (!entry)
+			goto out_err;
+
+		list_add_tail(&entry->list, &tmp);
+	}
+
+	list_splice(&tmp, &free_entries);
+	num_free_entries += num_entries;
+	nr_total_entries += num_entries;
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
@@ -715,28 +745,13 @@ int dma_debug_resize_entries(u32 num_entries)
 	int i, delta, ret = 0;
 	unsigned long flags;
 	struct dma_debug_entry *entry;
-	LIST_HEAD(tmp);
 
 	spin_lock_irqsave(&free_entries_lock, flags);
 
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
+		ret = dma_debug_add_entries(delta, GFP_ATOMIC);
 	} else {
 		delta = nr_total_entries - num_entries;
 
@@ -746,11 +761,10 @@ int dma_debug_resize_entries(u32 num_entries)
 		}
 
 		nr_total_entries -= i;
+		if (nr_total_entries != num_entries)
+			ret = -EBUSY;
 	}
 
-	if (nr_total_entries != num_entries)
-		ret = 1;
-
 	spin_unlock_irqrestore(&free_entries_lock, flags);
 
 	return ret;
@@ -764,36 +778,6 @@ int dma_debug_resize_entries(u32 num_entries)
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
@@ -1038,14 +1022,15 @@ static int dma_debug_init(void)
 		return 0;
 	}
 
-	if (prealloc_memory(nr_prealloc_entries) != 0) {
+	if (dma_debug_add_entries(nr_prealloc_entries, GFP_KERNEL) != 0) {
 		pr_err("debugging out of memory error - disabled\n");
 		global_disable = true;
 
 		return 0;
 	}
 
-	nr_total_entries = num_free_entries;
+	min_free_entries = num_free_entries;
+	pr_info("preallocated %d debug entries\n", nr_total_entries);
 
 	dma_debug_initialized = true;
 
-- 
2.19.1.dirty
