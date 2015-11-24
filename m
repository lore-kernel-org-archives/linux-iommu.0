From: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
Subject: [PATCH 3/4] iommu: enable bitmap allocation for intel iommu
Date: Tue, 24 Nov 2015 13:54:09 -0800
Message-ID: <cefeeb37c1116eaf603a72a2213cfc023a301807.1448401089.git.shli@fb.com>
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

I can't test the bitmap allocation for dma-iommu, so just enable it for
intel iommu.

Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
---
 drivers/iommu/dma-iommu.c   | 2 +-
 drivers/iommu/intel-iommu.c | 6 +++---
 drivers/iommu/iova.c        | 4 ++--
 include/linux/iova.h        | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index a86291e..a42c2a8 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -119,7 +119,7 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base, u64 size
 		}
 		iovad->dma_32bit_pfn = end_pfn;
 	} else {
-		init_iova_domain(iovad, 1UL << order, base_pfn, end_pfn);
+		init_iova_domain(iovad, 1UL << order, base_pfn, end_pfn, true);
 	}
 	return 0;
 }
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6412297..d0ce3e4 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1808,7 +1808,7 @@ static int dmar_init_reserved_ranges(void)
 	int i;
 
 	init_iova_domain(&reserved_iova_list, VTD_PAGE_SIZE, IOVA_START_PFN,
-			DMA_32BIT_PFN);
+			DMA_32BIT_PFN, false);
 
 	lockdep_set_class(&reserved_iova_list.iova_rbtree_lock,
 		&reserved_rbtree_key);
@@ -1867,7 +1867,7 @@ static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
 	unsigned long sagaw;
 
 	init_iova_domain(&domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN,
-			DMA_32BIT_PFN);
+			DMA_32BIT_PFN, false);
 	domain_reserve_special_ranges(domain);
 
 	/* calculate AGAW */
@@ -4749,7 +4749,7 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
 	int adjust_width;
 
 	init_iova_domain(&domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN,
-			DMA_32BIT_PFN);
+			DMA_32BIT_PFN, false);
 	domain_reserve_special_ranges(domain);
 
 	/* calculate AGAW */
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 6d11caf..0d71be7 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -24,7 +24,7 @@
 
 void
 init_iova_domain(struct iova_domain *iovad, unsigned long granule,
-	unsigned long start_pfn, unsigned long pfn_32bit)
+	unsigned long start_pfn, unsigned long pfn_32bit, bool disable_bitmap)
 {
 	/*
 	 * IOVA granularity will normally be equal to the smallest
@@ -43,7 +43,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	iovad->dma_32bit_pfn = pfn_32bit;
 	percpu_ida_init(&iovad->bitmap, IOVA_BITMAP_SIZE / IOVA_BITMAP_UNIT);
 	iovad->bitmap_iova = NULL;
-	iovad->disable_bitmap = true;
+	iovad->disable_bitmap = disable_bitmap;
 }
 EXPORT_SYMBOL_GPL(init_iova_domain);
 
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 63a81ef..457f93b 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -95,7 +95,7 @@ struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
 	unsigned long pfn_hi);
 void copy_reserved_iova(struct iova_domain *from, struct iova_domain *to);
 void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
-	unsigned long start_pfn, unsigned long pfn_32bit);
+	unsigned long start_pfn, unsigned long pfn_32bit, bool disable_bitmap);
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
 void put_iova_domain(struct iova_domain *iovad);
 struct iova *split_and_remove_iova(struct iova_domain *iovad,
-- 
2.4.6
