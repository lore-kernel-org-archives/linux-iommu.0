From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 3/4] iommu: make IOVA domain low limit flexible
Date: Mon, 12 Jan 2015 17:51:15 +0000
Message-ID: <b13ee3026a65ab0db5b63bc9cdc7b14521854bed.1420822848.git.robin.murphy@arm.com>
References: <cover.1420822848.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1420822848.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: will.deacon-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

To share the IOVA allocator with other architectures, it needs to
accommodate more general aperture restrictions; move the lower limit
from a compile-time constant to a runtime domain property to allow
IOVA domains with different requirements to co-exist.

Also reword the slightly unclear description of alloc_iova since we're
touching it anyway.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |  9 ++++++---
 drivers/iommu/iova.c        | 10 ++++++----
 include/linux/iova.h        |  7 +++----
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 5699653..275d056 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -71,6 +71,9 @@
 				__DOMAIN_MAX_PFN(gaw), (unsigned long)-1))
 #define DOMAIN_MAX_ADDR(gaw)	(((uint64_t)__DOMAIN_MAX_PFN(gaw)) << VTD_PAGE_SHIFT)
 
+/* IO virtual address start page frame number */
+#define IOVA_START_PFN		(1)
+
 #define IOVA_PFN(addr)		((addr) >> PAGE_SHIFT)
 #define DMA_32BIT_PFN		IOVA_PFN(DMA_BIT_MASK(32))
 #define DMA_64BIT_PFN		IOVA_PFN(DMA_BIT_MASK(64))
@@ -1632,7 +1635,7 @@ static int dmar_init_reserved_ranges(void)
 	struct iova *iova;
 	int i;
 
-	init_iova_domain(&reserved_iova_list, DMA_32BIT_PFN);
+	init_iova_domain(&reserved_iova_list, IOVA_START_PFN, DMA_32BIT_PFN);
 
 	lockdep_set_class(&reserved_iova_list.iova_rbtree_lock,
 		&reserved_rbtree_key);
@@ -1690,7 +1693,7 @@ static int domain_init(struct dmar_domain *domain, int guest_width)
 	int adjust_width, agaw;
 	unsigned long sagaw;
 
-	init_iova_domain(&domain->iovad, DMA_32BIT_PFN);
+	init_iova_domain(&domain->iovad, IOVA_START_PFN, DMA_32BIT_PFN);
 	domain_reserve_special_ranges(domain);
 
 	/* calculate AGAW */
@@ -4321,7 +4324,7 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
 {
 	int adjust_width;
 
-	init_iova_domain(&domain->iovad, DMA_32BIT_PFN);
+	init_iova_domain(&domain->iovad, IOVA_START_PFN, DMA_32BIT_PFN);
 	domain_reserve_special_ranges(domain);
 
 	/* calculate AGAW */
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 520b8c8..a3dbba8 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -55,11 +55,13 @@ void free_iova_mem(struct iova *iova)
 }
 
 void
-init_iova_domain(struct iova_domain *iovad, unsigned long pfn_32bit)
+init_iova_domain(struct iova_domain *iovad, unsigned long start_pfn,
+	unsigned long pfn_32bit)
 {
 	spin_lock_init(&iovad->iova_rbtree_lock);
 	iovad->rbroot = RB_ROOT;
 	iovad->cached32_node = NULL;
+	iovad->start_pfn = start_pfn;
 	iovad->dma_32bit_pfn = pfn_32bit;
 }
 
@@ -162,7 +164,7 @@ move_left:
 	if (!curr) {
 		if (size_aligned)
 			pad_size = iova_get_pad_size(size, limit_pfn);
-		if ((IOVA_START_PFN + size + pad_size) > limit_pfn) {
+		if ((iovad->start_pfn + size + pad_size) > limit_pfn) {
 			spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 			return -ENOMEM;
 		}
@@ -237,8 +239,8 @@ iova_insert_rbtree(struct rb_root *root, struct iova *iova)
  * @size: - size of page frames to allocate
  * @limit_pfn: - max limit address
  * @size_aligned: - set if size_aligned address range is required
- * This function allocates an iova in the range limit_pfn to IOVA_START_PFN
- * looking from limit_pfn instead from IOVA_START_PFN. If the size_aligned
+ * This function allocates an iova in the range iovad->start_pfn to limit_pfn,
+ * searching top-down from limit_pfn to iovad->start_pfn. If the size_aligned
  * flag is set then the allocated address iova->pfn_lo will be naturally
  * aligned on roundup_power_of_two(size).
  */
diff --git a/include/linux/iova.h b/include/linux/iova.h
index ad0507c..591b196 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -16,9 +16,6 @@
 #include <linux/rbtree.h>
 #include <linux/dma-mapping.h>
 
-/* IO virtual address start page frame number */
-#define IOVA_START_PFN		(1)
-
 /* iova structure */
 struct iova {
 	struct rb_node	node;
@@ -31,6 +28,7 @@ struct iova_domain {
 	spinlock_t	iova_rbtree_lock; /* Lock to protect update of rbtree */
 	struct rb_root	rbroot;		/* iova domain rbtree root */
 	struct rb_node	*cached32_node; /* Save last alloced node */
+	unsigned long	start_pfn;	/* Lower limit for this domain */
 	unsigned long	dma_32bit_pfn;
 };
 
@@ -52,7 +50,8 @@ struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,
 struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
 	unsigned long pfn_hi);
 void copy_reserved_iova(struct iova_domain *from, struct iova_domain *to);
-void init_iova_domain(struct iova_domain *iovad, unsigned long pfn_32bit);
+void init_iova_domain(struct iova_domain *iovad, unsigned long start_pfn,
+	unsigned long pfn_32bit);
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
 void put_iova_domain(struct iova_domain *iovad);
 struct iova *split_and_remove_iova(struct iova_domain *iovad,
-- 
1.9.1
