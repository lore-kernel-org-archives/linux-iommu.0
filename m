From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v3 3/7] dma-debug: Dynamically expand the dma_debug_entry pool
Date: Mon, 10 Dec 2018 14:00:29 +0000
Message-ID: <048517d818d7b9a898e5c9e9ab14bbeed4b34911.1544447601.git.robin.murphy@arm.com>
References: <cover.1544447601.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1544447601.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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

Certain drivers such as large multi-queue network adapters can use pools
of mapped DMA buffers larger than the default dma_debug_entry pool of
65536 entries, with the result that merely probing such a device can
cause DMA debug to disable itself during boot unless explicitly given an
appropriate "dma_debug_entries=..." option.

Developers trying to debug some other driver on such a system may not be
immediately aware of this, and at worst it can hide bugs if they fail to
realise that dma-debug has already disabled itself unexpectedly by the
time their code of interest gets to run. Even once they do realise, it
can be a bit of a pain to emprirically determine a suitable number of
preallocated entries to configure, short of massively over-allocating.

There's really no need for such a static limit, though, since we can
quite easily expand the pool at runtime in those rare cases that the
preallocated entries are insufficient, which is arguably the least
surprising and most useful behaviour. To that end, refactor the
prealloc_memory() logic a little bit to generalise it for runtime
reallocations as well.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v3: Drop refactoring of dma_debug_resize_entries(), misc. cosmetic tweaks

 Documentation/DMA-API.txt | 11 +++---
 kernel/dma/debug.c        | 79 ++++++++++++++++++++-------------------
 2 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index 6bdb095393b0..0fcb7561af1e 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -717,8 +717,8 @@ dma-api/num_errors		The number in this file shows how many
 dma-api/min_free_entries	This read-only file can be read to get the
 				minimum number of free dma_debug_entries the
 				allocator has ever seen. If this value goes
-				down to zero the code will disable itself
-				because it is not longer reliable.
+				down to zero the code will attempt to increase
+				nr_total_entries to compensate.
 
 dma-api/num_free_entries	The current number of free dma_debug_entries
 				in the allocator.
@@ -745,10 +745,9 @@ driver filter at boot time. The debug code will only print errors for that
 driver afterwards. This filter can be disabled or changed later using debugfs.
 
 When the code disables itself at runtime this is most likely because it ran
-out of dma_debug_entries. These entries are preallocated at boot. The number
-of preallocated entries is defined per architecture. If it is too low for you
-boot with 'dma_debug_entries=<your_desired_number>' to overwrite the
-architectural default.
+out of dma_debug_entries and was unable to allocate more on-demand. 65536
+entries are preallocated at boot - if this is too low for you boot with
+'dma_debug_entries=<your_desired_number>' to overwrite the default.
 
 ::
 
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 29486eb9d1dc..ef7c90b7a346 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -47,6 +47,8 @@
 #ifndef PREALLOC_DMA_DEBUG_ENTRIES
 #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
 #endif
+/* If the pool runs out, add this many new entries at once */
+#define DMA_DEBUG_DYNAMIC_ENTRIES 256
 
 enum {
 	dma_debug_single,
@@ -646,6 +648,34 @@ static void add_dma_entry(struct dma_debug_entry *entry)
 	 */
 }
 
+static int dma_debug_create_entries(u32 num_entries, gfp_t gfp)
+{
+	struct dma_debug_entry *entry, *next_entry;
+	int i;
+
+	for (i = 0; i < num_entries; ++i) {
+		entry = kzalloc(sizeof(*entry), gfp);
+		if (!entry)
+			goto out_err;
+
+		list_add_tail(&entry->list, &free_entries);
+	}
+
+	num_free_entries += num_entries;
+	nr_total_entries += num_entries;
+
+	return 0;
+
+out_err:
+
+	list_for_each_entry_safe(entry, next_entry, &free_entries, list) {
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
@@ -672,12 +702,14 @@ static struct dma_debug_entry *dma_entry_alloc(void)
 	unsigned long flags;
 
 	spin_lock_irqsave(&free_entries_lock, flags);
-
-	if (list_empty(&free_entries)) {
-		global_disable = true;
-		spin_unlock_irqrestore(&free_entries_lock, flags);
-		pr_err("debugging out of memory - disabling\n");
-		return NULL;
+	if (num_free_entries == 0) {
+		if (dma_debug_create_entries(DMA_DEBUG_DYNAMIC_ENTRIES,
+					     GFP_ATOMIC)) {
+			global_disable = true;
+			spin_unlock_irqrestore(&free_entries_lock, flags);
+			pr_err("debugging out of memory - disabling\n");
+			return NULL;
+		}
 	}
 
 	entry = __dma_entry_alloc();
@@ -764,36 +796,6 @@ int dma_debug_resize_entries(u32 num_entries)
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
@@ -1038,14 +1040,15 @@ static int dma_debug_init(void)
 		return 0;
 	}
 
-	if (prealloc_memory(nr_prealloc_entries) != 0) {
+	if (dma_debug_create_entries(nr_prealloc_entries, GFP_KERNEL) != 0) {
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
