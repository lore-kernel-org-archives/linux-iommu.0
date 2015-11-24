From: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
Subject: [PATCH 2/4] iommu: add a bitmap based dma address allocator
Date: Tue, 24 Nov 2015 13:54:08 -0800
Message-ID: <4c0804c85404be81acfe81fcd402f1af484e9d5f.1448401089.git.shli@fb.com>
References: <cover.1448401089.git.shli@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1448401089.git.shli-b10kYP2dOMg@public.gmane.org>
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

iovad rbtree spinlock contention is very significant. In a workload with
netperf and 10Gb NIC, multithread workload shows 100% cpu utilization
(99% cpu time on the lock) and the total throughput is less than
1Gbps.

This patch introduces a bitmap based allocator. We allocate a big chunk
of DMA range and divide it into 8k chunks. Each bit in the bitmap
present the 8k chunk. For any allocation with size less than 8k, we
allocate 8k. The DMA address allocation then becomes an allocation one
bit from a bitmap. We use percpu bitmap to speed up the bit allocation
further.

With the bitmap allocation, the lock contention is completely avoided.
In the workload above, the throughput is around 9.28Gbps and cpu
utilization drops to 1%.

The only works for DMA less than 8k, but it's case with most heavy lock
contention. If DAC is enabled by default on the future, we can allocate
a bigger DMA range and bigger chunk size.

Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 23 +++++++----
 drivers/iommu/iova.c        | 93 +++++++++++++++++++++++++++++++++++++++------
 include/linux/iova.h        | 13 +++++++
 3 files changed, 109 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 5c57b9a..6412297 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3595,7 +3595,7 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr)
 {
 	struct dmar_domain *domain;
 	unsigned long start_pfn, last_pfn;
-	struct iova *iova;
+	struct iova *iova = NULL;
 	struct intel_iommu *iommu;
 	struct page *freelist;
 
@@ -3607,13 +3607,17 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr)
 
 	iommu = domain_get_iommu(domain);
 
-	iova = find_iova(&domain->iovad, IOVA_PFN(dev_addr));
-	if (WARN_ONCE(!iova, "Driver unmaps unmatched page at PFN %llx\n",
+	if (iova_pfn_in_bitmap(&domain->iovad, IOVA_PFN(dev_addr))) {
+		start_pfn = IOVA_PFN(dev_addr);
+		last_pfn = start_pfn + IOVA_BITMAP_UNIT - 1;
+	} else {
+		iova = find_iova(&domain->iovad, IOVA_PFN(dev_addr));
+		if (WARN_ONCE(!iova, "Driver unmaps unmatched page at PFN %llx\n",
 		      (unsigned long long)dev_addr))
-		return;
-
-	start_pfn = mm_to_dma_pfn(iova->pfn_lo);
-	last_pfn = mm_to_dma_pfn(iova->pfn_hi + 1) - 1;
+			return;
+		start_pfn = mm_to_dma_pfn(iova->pfn_lo);
+		last_pfn = mm_to_dma_pfn(iova->pfn_hi + 1) - 1;
+	}
 
 	pr_debug("Device %s unmapping: pfn %lx-%lx\n",
 		 dev_name(dev), start_pfn, last_pfn);
@@ -3624,7 +3628,10 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr)
 		iommu_flush_iotlb_psi(iommu, domain, start_pfn,
 				      last_pfn - start_pfn + 1, !freelist, 0);
 		/* free iova */
-		__free_iova(&domain->iovad, iova);
+		if (iova)
+			__free_iova(&domain->iovad, iova);
+		else
+			free_iova(&domain->iovad, start_pfn);
 		dma_free_pagelist(freelist);
 	} else {
 		add_unmap(domain, IOVA_PFN(dev_addr), last_pfn - start_pfn + 1,
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 2c5e197..6d11caf 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -15,6 +15,7 @@
  * Place - Suite 330, Boston, MA 02111-1307 USA.
  *
  * Author: Anil S Keshavamurthy <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
+ * Bitmap based allocation: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
  */
 
 #include <linux/iova.h>
@@ -40,6 +41,9 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 		start_pfn = 1;
 	iovad->start_pfn = start_pfn;
 	iovad->dma_32bit_pfn = pfn_32bit;
+	percpu_ida_init(&iovad->bitmap, IOVA_BITMAP_SIZE / IOVA_BITMAP_UNIT);
+	iovad->bitmap_iova = NULL;
+	iovad->disable_bitmap = true;
 }
 EXPORT_SYMBOL_GPL(init_iova_domain);
 
@@ -258,6 +262,54 @@ void iova_cache_put(void)
 }
 EXPORT_SYMBOL_GPL(iova_cache_put);
 
+static struct iova *__alloc_iova(struct iova_domain *iovad,
+	unsigned long size, unsigned long limit_pfn, bool size_aligned)
+{
+	struct iova *new_iova;
+	int ret;
+
+	new_iova = alloc_iova_mem();
+	if (!new_iova)
+		return NULL;
+
+	ret = __alloc_and_insert_iova_range(iovad, size, limit_pfn,
+			new_iova, size_aligned);
+
+	if (ret) {
+		free_iova_mem(new_iova);
+		return NULL;
+	}
+	return new_iova;
+}
+
+static int __init_iova_bitmap(struct iova_domain *iovad)
+{
+	struct iova *new_iova;
+	unsigned long flags;
+
+	new_iova = __alloc_iova(iovad, IOVA_BITMAP_SIZE,
+		iovad->dma_32bit_pfn, false);
+
+	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+	if (!new_iova) {
+		if (!iovad->bitmap_iova)
+			iovad->disable_bitmap = true;
+		spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+		return iovad->bitmap_iova ? 0 : -ENOMEM;
+	}
+
+	if (!iovad->bitmap_iova)
+		iovad->bitmap_iova = new_iova;
+	else {
+		__cached_rbnode_delete_update(iovad, new_iova);
+		rb_erase(&new_iova->node, &iovad->rbroot);
+	}
+	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+	if (iovad->bitmap_iova != new_iova)
+		free_iova_mem(new_iova);
+	return 0;
+}
+
 /**
  * alloc_iova - allocates an iova
  * @iovad: - iova domain in question
@@ -275,20 +327,23 @@ alloc_iova(struct iova_domain *iovad, unsigned long size,
 	bool size_aligned)
 {
 	struct iova *new_iova;
-	int ret;
-
-	new_iova = alloc_iova_mem();
+	int tag;
+
+	if (size <= IOVA_BITMAP_UNIT && !iovad->disable_bitmap) {
+		if (!(iovad->bitmap_iova) && __init_iova_bitmap(iovad))
+			goto fallback;
+		if (limit_pfn < iovad->bitmap_iova->pfn_hi)
+			goto fallback;
+		tag = percpu_ida_alloc(&iovad->bitmap, TASK_RUNNING);
+		if (tag < 0)
+			goto fallback;
+		return iovad->bitmap_iova->pfn_lo + tag * IOVA_BITMAP_UNIT;
+	}
+fallback:
+	new_iova = __alloc_iova(iovad, size, limit_pfn, size_aligned);
 	if (!new_iova)
 		return 0;
 
-	ret = __alloc_and_insert_iova_range(iovad, size, limit_pfn,
-			new_iova, size_aligned);
-
-	if (ret) {
-		free_iova_mem(new_iova);
-		return 0;
-	}
-
 	return new_iova->pfn_lo;
 }
 EXPORT_SYMBOL_GPL(alloc_iova);
@@ -345,6 +400,8 @@ __free_iova(struct iova_domain *iovad, struct iova *iova)
 {
 	unsigned long flags;
 
+	BUG_ON(iova_pfn_in_bitmap(iovad, iova->pfn_lo));
+
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
 	__cached_rbnode_delete_update(iovad, iova);
 	rb_erase(&iova->node, &iovad->rbroot);
@@ -363,8 +420,18 @@ EXPORT_SYMBOL_GPL(__free_iova);
 void
 free_iova(struct iova_domain *iovad, unsigned long pfn)
 {
-	struct iova *iova = find_iova(iovad, pfn);
+	struct iova *iova;
+
+	if (iova_pfn_in_bitmap(iovad, pfn)) {
+		int tag;
+
+		tag = (pfn - iovad->bitmap_iova->pfn_lo) >>
+			IOVA_BITMAP_UNIT_LOG;
+		percpu_ida_free(&iovad->bitmap, tag);
+		return;
+	}
 
+	iova = find_iova(iovad, pfn);
 	if (iova)
 		__free_iova(iovad, iova);
 }
@@ -381,6 +448,7 @@ void put_iova_domain(struct iova_domain *iovad)
 	unsigned long flags;
 
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+	iovad->bitmap_iova = NULL;
 	node = rb_first(&iovad->rbroot);
 	while (node) {
 		struct iova *iova = container_of(node, struct iova, node);
@@ -390,6 +458,7 @@ void put_iova_domain(struct iova_domain *iovad)
 		node = rb_first(&iovad->rbroot);
 	}
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+	percpu_ida_destroy(&iovad->bitmap);
 }
 EXPORT_SYMBOL_GPL(put_iova_domain);
 
diff --git a/include/linux/iova.h b/include/linux/iova.h
index cfe5ee9..63a81ef 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/rbtree.h>
 #include <linux/dma-mapping.h>
+#include <linux/percpu_ida.h>
 
 /* iova structure */
 struct iova {
@@ -23,6 +24,9 @@ struct iova {
 	unsigned long	pfn_lo; /* IOMMU dish out addr lo */
 };
 
+#define IOVA_BITMAP_UNIT ((8 * 1024) >> PAGE_SHIFT)
+#define IOVA_BITMAP_UNIT_LOG (ilog2(IOVA_BITMAP_UNIT))
+#define IOVA_BITMAP_SIZE ((1L * 1024 * 1024 * 1024) >> PAGE_SHIFT)
 /* holds all the iova translations for a domain */
 struct iova_domain {
 	spinlock_t	iova_rbtree_lock; /* Lock to protect update of rbtree */
@@ -31,6 +35,9 @@ struct iova_domain {
 	unsigned long	granule;	/* pfn granularity for this domain */
 	unsigned long	start_pfn;	/* Lower limit for this domain */
 	unsigned long	dma_32bit_pfn;
+	struct percpu_ida bitmap;
+	struct iova	*bitmap_iova;
+	bool		disable_bitmap;
 };
 
 static inline unsigned long iova_size(struct iova *iova)
@@ -68,6 +75,12 @@ static inline unsigned long iova_pfn(struct iova_domain *iovad, dma_addr_t iova)
 	return iova >> iova_shift(iovad);
 }
 
+static inline bool iova_pfn_in_bitmap(struct iova_domain *iovad, unsigned long pfn)
+{
+	return iovad->bitmap_iova && pfn >= iovad->bitmap_iova->pfn_lo &&
+	    pfn <= iovad->bitmap_iova->pfn_hi;
+}
+
 int iova_cache_get(void);
 void iova_cache_put(void);
 
-- 
2.4.6
