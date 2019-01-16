From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] dma-debug: add dumping facility via debugfs
Date: Wed, 16 Jan 2019 13:44:25 +0000
Message-ID: <1547646265-9414-1-git-send-email-clabbe@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
List-Id: iommu@lists.linux-foundation.org

While debugging a DMA mapping leak, I needed to access
debug_dma_dump_mappings() but easily from user space.

This patch adds a /sys/kernel/debug/dma-api/dump file which contain all
current DMA mapping.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 kernel/dma/debug.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 23cf5361bcf1..9253382f5729 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -144,6 +144,7 @@ static struct dentry *num_free_entries_dent __read_mostly;
 static struct dentry *min_free_entries_dent __read_mostly;
 static struct dentry *nr_total_entries_dent __read_mostly;
 static struct dentry *filter_dent           __read_mostly;
+static struct dentry *dump_dent             __read_mostly;
 
 /* per-driver filter related state */
 
@@ -840,6 +841,47 @@ static const struct file_operations filter_fops = {
 	.llseek = default_llseek,
 };
 
+static int dump_read(struct seq_file *seq, void *v)
+{
+	int idx;
+
+	for (idx = 0; idx < HASH_SIZE; idx++) {
+		struct hash_bucket *bucket = &dma_entry_hash[idx];
+		struct dma_debug_entry *entry;
+		unsigned long flags;
+
+		spin_lock_irqsave(&bucket->lock, flags);
+
+		list_for_each_entry(entry, &bucket->list, list) {
+			seq_printf(seq,
+				   "%s %s %s idx %d P=%llx N=%lx D=%llx L=%llx %s %s\n",
+				   dev_name(entry->dev),
+				   dev_driver_string(entry->dev),
+				   type2name[entry->type], idx,
+				   phys_addr(entry), entry->pfn,
+				   entry->dev_addr, entry->size,
+				   dir2name[entry->direction],
+				   maperr2str[entry->map_err_type]);
+		}
+
+		spin_unlock_irqrestore(&bucket->lock, flags);
+	}
+	return 0;
+}
+
+static int dump_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, dump_read, inode->i_private);
+}
+
+static const struct file_operations dump_fops = {
+	.owner = THIS_MODULE,
+	.open = dump_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
 static int dma_debug_fs_init(void)
 {
 	dma_debug_dent = debugfs_create_dir("dma-api", NULL);
@@ -894,6 +936,11 @@ static int dma_debug_fs_init(void)
 	if (!filter_dent)
 		goto out_err;
 
+	dump_dent = debugfs_create_file("dump", 0444,
+					dma_debug_dent, NULL, &dump_fops);
+	if (!dump_dent)
+		goto out_err;
+
 	return 0;
 
 out_err:
-- 
2.19.2
