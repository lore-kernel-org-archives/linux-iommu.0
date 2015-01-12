From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 4/4] iommu: make IOVA domain page size explicit
Date: Mon, 12 Jan 2015 17:51:16 +0000
Message-ID: <b7956fb2f2a867009d154598f54c4faf00c6592a.1420822848.git.robin.murphy@arm.com>
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

Systems may contain heterogeneous IOMMUs supporting differing minimum
page sizes, which may also not be common with the CPU page size.
Thus it is practical to have an explicit notion of IOVA granularity
to simplify handling of mapping and allocation constraints.

As an initial step, move the IOVA page granularity from an implicit
compile-time constant to a per-domain property so we can make use
of it in IOVA domain context at runtime. To keep the abstraction tidy,
extend the little API of inline iova_* helpers to parallel some of the
equivalent PAGE_* macros.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |  9 ++++++---
 drivers/iommu/iova.c        | 12 ++++++++++--
 include/linux/iova.h        | 35 +++++++++++++++++++++++++++++++++--
 3 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 275d056..a0f5817 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1635,7 +1635,8 @@ static int dmar_init_reserved_ranges(void)
 	struct iova *iova;
 	int i;
 
-	init_iova_domain(&reserved_iova_list, IOVA_START_PFN, DMA_32BIT_PFN);
+	init_iova_domain(&reserved_iova_list, VTD_PAGE_SIZE, IOVA_START_PFN,
+			DMA_32BIT_PFN);
 
 	lockdep_set_class(&reserved_iova_list.iova_rbtree_lock,
 		&reserved_rbtree_key);
@@ -1693,7 +1694,8 @@ static int domain_init(struct dmar_domain *domain, int guest_width)
 	int adjust_width, agaw;
 	unsigned long sagaw;
 
-	init_iova_domain(&domain->iovad, IOVA_START_PFN, DMA_32BIT_PFN);
+	init_iova_domain(&domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN,
+			DMA_32BIT_PFN);
 	domain_reserve_special_ranges(domain);
 
 	/* calculate AGAW */
@@ -4324,7 +4326,8 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
 {
 	int adjust_width;
 
-	init_iova_domain(&domain->iovad, IOVA_START_PFN, DMA_32BIT_PFN);
+	init_iova_domain(&domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN,
+			DMA_32BIT_PFN);
 	domain_reserve_special_ranges(domain);
 
 	/* calculate AGAW */
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index a3dbba8..9dd8208 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -55,12 +55,20 @@ void free_iova_mem(struct iova *iova)
 }
 
 void
-init_iova_domain(struct iova_domain *iovad, unsigned long start_pfn,
-	unsigned long pfn_32bit)
+init_iova_domain(struct iova_domain *iovad, unsigned long granule,
+	unsigned long start_pfn, unsigned long pfn_32bit)
 {
+	/*
+	 * IOVA granularity will normally be equal to the smallest
+	 * supported IOMMU page size; both *must* be capable of
+	 * representing individual CPU pages exactly.
+	 */
+	BUG_ON((granule > PAGE_SIZE) || !is_power_of_2(granule));
+
 	spin_lock_init(&iovad->iova_rbtree_lock);
 	iovad->rbroot = RB_ROOT;
 	iovad->cached32_node = NULL;
+	iovad->granule = granule;
 	iovad->start_pfn = start_pfn;
 	iovad->dma_32bit_pfn = pfn_32bit;
 }
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 591b196..3920a19 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -28,6 +28,7 @@ struct iova_domain {
 	spinlock_t	iova_rbtree_lock; /* Lock to protect update of rbtree */
 	struct rb_root	rbroot;		/* iova domain rbtree root */
 	struct rb_node	*cached32_node; /* Save last alloced node */
+	unsigned long	granule;	/* pfn granularity for this domain */
 	unsigned long	start_pfn;	/* Lower limit for this domain */
 	unsigned long	dma_32bit_pfn;
 };
@@ -37,6 +38,36 @@ static inline unsigned long iova_size(struct iova *iova)
 	return iova->pfn_hi - iova->pfn_lo + 1;
 }
 
+static inline unsigned long iova_shift(struct iova_domain *iovad)
+{
+	return __ffs(iovad->granule);
+}
+
+static inline unsigned long iova_mask(struct iova_domain *iovad)
+{
+	return iovad->granule - 1;
+}
+
+static inline size_t iova_offset(struct iova_domain *iovad, dma_addr_t iova)
+{
+	return iova & iova_mask(iovad);
+}
+
+static inline size_t iova_align(struct iova_domain *iovad, size_t size)
+{
+	return ALIGN(size, iovad->granule);
+}
+
+static inline dma_addr_t iova_dma_addr(struct iova_domain *iovad, struct iova *iova)
+{
+	return (dma_addr_t)iova->pfn_lo << iova_shift(iovad);
+}
+
+static inline unsigned long iova_pfn(struct iova_domain *iovad, dma_addr_t iova)
+{
+	return iova >> iova_shift(iovad);
+}
+
 int iommu_iova_cache_init(void);
 void iommu_iova_cache_destroy(void);
 
@@ -50,8 +81,8 @@ struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,
 struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
 	unsigned long pfn_hi);
 void copy_reserved_iova(struct iova_domain *from, struct iova_domain *to);
-void init_iova_domain(struct iova_domain *iovad, unsigned long start_pfn,
-	unsigned long pfn_32bit);
+void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
+	unsigned long start_pfn, unsigned long pfn_32bit);
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
 void put_iova_domain(struct iova_domain *iovad);
 struct iova *split_and_remove_iova(struct iova_domain *iovad,
-- 
1.9.1
