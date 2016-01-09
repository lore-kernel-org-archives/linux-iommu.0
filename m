From: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
Subject: [PATCH V2 4/4] intel-iommu: do batch iova free
Date: Fri, 8 Jan 2016 16:44:49 -0800
Message-ID: <0d08aca80fd2174df61c8dedefe1de52580eae46.1452297604.git.shli@fb.com>
References: <cover.1452297604.git.shli@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1452297604.git.shli-b10kYP2dOMg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Kernel-team-b10kYP2dOMg@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

iova free can be easily batched and remove the lock contention in unmap
path.

Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 17 ++++++++++++++++-
 drivers/iommu/iova.c        | 27 +++++++++++++++++++++++++++
 include/linux/iova.h        |  1 +
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b06a901..c1e0702 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3499,9 +3499,13 @@ static dma_addr_t intel_map_page(struct device *dev, struct page *page,
 				  dir, *dev->dma_mask);
 }
 
+#define MAX_FREE_IOVA 16
 static void flush_unmaps(void)
 {
 	int i, j;
+	unsigned long free_iovas[MAX_FREE_IOVA];
+	int iova_cnt;
+	struct iova_domain *free_iovad;
 
 	timer_on = 0;
 
@@ -3518,6 +3522,8 @@ static void flush_unmaps(void)
 		if (!cap_caching_mode(iommu->cap))
 			iommu->flush.flush_iotlb(iommu, 0, 0, 0,
 					 DMA_TLB_GLOBAL_FLUSH);
+		iova_cnt = 0;
+		free_iovad = NULL;
 		for (j = 0; j < deferred_flush[i].next; j++) {
 			unsigned long mask;
 			unsigned long iova_pfn = deferred_flush[i].iova_pfn[j];
@@ -3537,10 +3543,19 @@ static void flush_unmaps(void)
 					(uint64_t)iova_pfn << PAGE_SHIFT, mask);
 			}
 
-			free_iova(iovad, iova_pfn);
+			if (free_iovad && (free_iovad != iovad ||
+					   iova_cnt >= MAX_FREE_IOVA)) {
+				free_iova_array(free_iovad, free_iovas, iova_cnt);
+				iova_cnt = 0;
+			}
+
+			free_iovad = iovad;
+			free_iovas[iova_cnt++] = iova_pfn;
 			if (deferred_flush[i].freelist[j])
 				dma_free_pagelist(deferred_flush[i].freelist[j]);
 		}
+		if (iova_cnt)
+			free_iova_array(free_iovad, free_iovas, iova_cnt);
 		deferred_flush[i].next = 0;
 	}
 
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index bb8a328..a4959e2 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -453,6 +453,33 @@ free_iova(struct iova_domain *iovad, unsigned long pfn)
 EXPORT_SYMBOL_GPL(free_iova);
 
 /**
+ * free_iova_array - finds and frees iovas for pfn array
+ * @iovad: - iova domain in question.
+ * @pfns: - pfn array
+ * @size - array size
+ * This function free iovas of givien pfn array
+ */
+void
+free_iova_array(struct iova_domain *iovad, unsigned long *pfns, int size)
+{
+	unsigned long flags;
+	struct iova *iova;
+	int i;
+
+	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+	for (i = 0; i < size; i++) {
+		iova = __find_iova(iovad, pfns[i]);
+		if (iova) {
+			__cached_rbnode_delete_update(iovad, iova);
+			rb_erase(&iova->node, &iovad->rbroot);
+		}
+		free_iova_mem(iova);
+	}
+	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+}
+EXPORT_SYMBOL_GPL(free_iova_array);
+
+/**
  * put_iova_domain - destroys the iova doamin
  * @iovad: - iova domain in question.
  * All the iova's in that domain are destroyed.
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 1386a7b..5a11304 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -83,6 +83,7 @@ void iova_cache_put(void);
 struct iova *alloc_iova_mem(void);
 void free_iova_mem(struct iova *iova);
 void free_iova(struct iova_domain *iovad, unsigned long pfn);
+void free_iova_array(struct iova_domain *iovad, unsigned long *pfns, int size);
 void __free_iova(struct iova_domain *iovad, struct iova *iova);
 struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,
 	unsigned long limit_pfn,
-- 
2.4.6
