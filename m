From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] iommu/omap: remove DEBUG_SEQ_FOPS_RO()
Date: Thu, 22 Nov 2018 08:54:43 -0500
Message-ID: <20181122135443.25035-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: iommu@lists.linux-foundation.org

Because we already have the DEFINE_SHOW_ATTRIBUTE,there is no need
to define such a macro.So remove DEBUG_SEQ_FOPS_RO.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/iommu/omap-iommu-debug.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
index 50217548c3b8..4abc0ef522a8 100644
--- a/drivers/iommu/omap-iommu-debug.c
+++ b/drivers/iommu/omap-iommu-debug.c
@@ -159,7 +159,7 @@ static size_t omap_dump_tlb_entries(struct omap_iommu *obj, struct seq_file *s)
 	return 0;
 }
 
-static int debug_read_tlb(struct seq_file *s, void *data)
+static int tlb_show(struct seq_file *s, void *data)
 {
 	struct omap_iommu *obj = s->private;
 
@@ -210,7 +210,7 @@ static void dump_ioptable(struct seq_file *s)
 	spin_unlock(&obj->page_table_lock);
 }
 
-static int debug_read_pagetable(struct seq_file *s, void *data)
+static int pagetable_show(struct seq_file *s, void *data)
 {
 	struct omap_iommu *obj = s->private;
 
@@ -228,35 +228,22 @@ static int debug_read_pagetable(struct seq_file *s, void *data)
 	return 0;
 }
 
-#define DEBUG_SEQ_FOPS_RO(name)						       \
-	static int debug_open_##name(struct inode *inode, struct file *file)   \
-	{								       \
-		return single_open(file, debug_read_##name, inode->i_private); \
-	}								       \
-									       \
-	static const struct file_operations debug_##name##_fops = {	       \
-		.open		= debug_open_##name,			       \
-		.read		= seq_read,				       \
-		.llseek		= seq_lseek,				       \
-		.release	= single_release,			       \
-	}
-
 #define DEBUG_FOPS_RO(name)						\
-	static const struct file_operations debug_##name##_fops = {	\
+	static const struct file_operations name##_fops = {	        \
 		.open = simple_open,					\
 		.read = debug_read_##name,				\
 		.llseek = generic_file_llseek,				\
 	}
 
 DEBUG_FOPS_RO(regs);
-DEBUG_SEQ_FOPS_RO(tlb);
-DEBUG_SEQ_FOPS_RO(pagetable);
+DEFINE_SHOW_ATTRIBUTE(tlb);
+DEFINE_SHOW_ATTRIBUTE(pagetable);
 
 #define __DEBUG_ADD_FILE(attr, mode)					\
 	{								\
 		struct dentry *dent;					\
 		dent = debugfs_create_file(#attr, mode, obj->debug_dir,	\
-					   obj, &debug_##attr##_fops);	\
+					   obj, &attr##_fops);	        \
 		if (!dent)						\
 			goto err;					\
 	}
-- 
2.17.0
