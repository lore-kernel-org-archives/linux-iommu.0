From: Dongli Zhang <dongli.zhang@oracle.com>
Subject: [PATCH v3 2/3] swiotlb: add debugfs to track swiotlb buffer usage
Date: Fri, 18 Jan 2019 15:10:27 +0800
Message-ID: <1547795428-10595-2-git-send-email-dongli.zhang@oracle.com>
References: <1547795428-10595-1-git-send-email-dongli.zhang@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547795428-10595-1-git-send-email-dongli.zhang@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, joe.jin@oracle.com, dongli.zhang@oracle.com
List-Id: iommu@lists.linux-foundation.org

The device driver will not be able to do dma operations once swiotlb buffer
is full, either because the driver is using so many IO TLB blocks inflight,
or because there is memory leak issue in device driver. To export the
swiotlb buffer usage via debugfs would help the user estimate the size of
swiotlb buffer to pre-allocate or analyze device driver memory leak issue.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
Changed since v1:
  * init debugfs with late_initcall (suggested by Robin Murphy)
  * create debugfs entries with debugfs_create_ulong(suggested by Robin Murphy)

Changed since v2:
  * some #ifdef folding (suggested by Konrad Rzeszutek Wilk)

 kernel/dma/swiotlb.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 1d8b377..bedc9f9 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -34,6 +34,9 @@
 #include <linux/scatterlist.h>
 #include <linux/mem_encrypt.h>
 #include <linux/set_memory.h>
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+#endif
 
 #include <asm/io.h>
 #include <asm/dma.h>
@@ -73,6 +76,11 @@ phys_addr_t io_tlb_start, io_tlb_end;
 static unsigned long io_tlb_nslabs;
 
 /*
+ * The number of used IO TLB block
+ */
+static unsigned long io_tlb_used;
+
+/*
  * This is a free list describing the number of free entries available from
  * each index
  */
@@ -524,6 +532,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
 	return DMA_MAPPING_ERROR;
 found:
+	io_tlb_used += nslots;
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
 
 	/*
@@ -584,6 +593,8 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 		 */
 		for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE -1) && io_tlb_list[i]; i--)
 			io_tlb_list[i] = ++count;
+
+		io_tlb_used -= nslots;
 	}
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
 }
@@ -662,3 +673,36 @@ swiotlb_dma_supported(struct device *hwdev, u64 mask)
 {
 	return __phys_to_dma(hwdev, io_tlb_end - 1) <= mask;
 }
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
+				   d_swiotlb_usage, &io_tlb_used);
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
