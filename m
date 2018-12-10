From: Dongli Zhang <dongli.zhang-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 1/2] swiotlb: add debugfs to track swiotlb buffer usage
Date: Mon, 10 Dec 2018 08:37:57 +0800
Message-ID: <1544402278-8175-1-git-send-email-dongli.zhang@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, dongli.zhang-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, joe.jin-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The device driver will not be able to do dma operations once swiotlb buffer
is full, either because the driver is using so many IO TLB blocks inflight,
or because there is memory leak issue in device driver. To export the
swiotlb buffer usage via debugfs would help the user estimate the size of
swiotlb buffer to pre-allocate or analyze device driver memory leak issue.

Signed-off-by: Dongli Zhang <dongli.zhang-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
---
Changed since v1:
  * init debugfs with late_initcall (suggested by Robin Murphy)
  * create debugfs entries with debugfs_create_ulong(suggested by Robin Murphy)

 kernel/dma/swiotlb.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 045930e..3979c2c 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -35,6 +35,9 @@
 #include <linux/scatterlist.h>
 #include <linux/mem_encrypt.h>
 #include <linux/set_memory.h>
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+#endif
 
 #include <asm/io.h>
 #include <asm/dma.h>
@@ -73,6 +76,13 @@ static phys_addr_t io_tlb_start, io_tlb_end;
  */
 static unsigned long io_tlb_nslabs;
 
+#ifdef CONFIG_DEBUG_FS
+/*
+ * The number of used IO TLB block
+ */
+static unsigned long io_tlb_used;
+#endif
+
 /*
  * This is a free list describing the number of free entries available from
  * each index
@@ -528,6 +538,9 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
 	return SWIOTLB_MAP_ERROR;
 found:
+#ifdef CONFIG_DEBUG_FS
+	io_tlb_used += nslots;
+#endif
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
 
 	/*
@@ -588,6 +601,10 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 		 */
 		for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE -1) && io_tlb_list[i]; i--)
 			io_tlb_list[i] = ++count;
+
+#ifdef CONFIG_DEBUG_FS
+		io_tlb_used -= nslots;
+#endif
 	}
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
 }
@@ -883,3 +900,36 @@ const struct dma_map_ops swiotlb_dma_ops = {
 	.dma_supported		= dma_direct_supported,
 };
 EXPORT_SYMBOL(swiotlb_dma_ops);
+
+#ifdef CONFIG_DEBUG_FS
+
+static int __init swiotlb_create_debugfs(void)
+{
+	static struct dentry *d_swiotlb_usage;
+	struct dentry *ent;
+
+	d_swiotlb_usage = debugfs_create_dir("swiotlb", NULL);
+
+	if (!d_swiotlb_usage)
+		return -ENOMEM;
+
+	ent = debugfs_create_ulong("io_tlb_nslabs", 0400,
+				   d_swiotlb_usage, &io_tlb_nslabs);
+	if (!ent)
+		goto fail;
+
+	ent = debugfs_create_ulong("io_tlb_used", 0400,
+				    d_swiotlb_usage, &io_tlb_used);
+	if (!ent)
+		goto fail;
+
+	return 0;
+
+fail:
+	debugfs_remove_recursive(d_swiotlb_usage);
+	return -ENOMEM;
+}
+
+late_initcall(swiotlb_create_debugfs);
+
+#endif
-- 
2.7.4
