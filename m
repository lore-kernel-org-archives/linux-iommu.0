From: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 7/7] iommu/iova: fix iovad->dma_32bit_pfn as the last pfn of
	dma32
Date: Wed, 22 Mar 2017 14:27:47 +0800
Message-ID: <1490164067-12552-8-git-send-email-thunder.leizhen@huawei.com>
References: <1490164067-12552-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1490164067-12552-1-git-send-email-thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Sudeep Dutt <sudeep.dutt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ashutosh Dixit <ashutosh.dixit-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Zefan Li <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tianhong Ding <dingtianhong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

To make sure iovad->cached32_node and iovad->cached64_node can exactly
control dma32 and dma64 area. It also help us to remove the parameter
pfn_32bit of init_iova_domain.

Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c        |  7 ++-----
 drivers/iommu/dma-iommu.c        | 22 +++++-----------------
 drivers/iommu/intel-iommu.c      | 11 +++--------
 drivers/iommu/iova.c             |  4 ++--
 drivers/misc/mic/scif/scif_rma.c |  3 +--
 include/linux/iova.h             |  2 +-
 6 files changed, 14 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 98940d1..78c8b93 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -61,7 +61,6 @@
 /* IO virtual address start page frame number */
 #define IOVA_START_PFN		(1)
 #define IOVA_PFN(addr)		((addr) >> PAGE_SHIFT)
-#define DMA_32BIT_PFN		IOVA_PFN(DMA_BIT_MASK(32))
 
 /* Reserved IOVA ranges */
 #define MSI_RANGE_START		(0xfee00000)
@@ -1776,8 +1775,7 @@ static struct dma_ops_domain *dma_ops_domain_alloc(void)
 	if (!dma_dom->domain.pt_root)
 		goto free_dma_dom;
 
-	init_iova_domain(&dma_dom->iovad, PAGE_SIZE,
-			 IOVA_START_PFN, DMA_32BIT_PFN);
+	init_iova_domain(&dma_dom->iovad, PAGE_SIZE, IOVA_START_PFN);
 
 	/* Initialize reserved ranges */
 	copy_reserved_iova(&reserved_iova_ranges, &dma_dom->iovad);
@@ -2747,8 +2745,7 @@ static int init_reserved_iova_ranges(void)
 	struct pci_dev *pdev = NULL;
 	struct iova *val;
 
-	init_iova_domain(&reserved_iova_ranges, PAGE_SIZE,
-			 IOVA_START_PFN, DMA_32BIT_PFN);
+	init_iova_domain(&reserved_iova_ranges, PAGE_SIZE, IOVA_START_PFN);
 
 	lockdep_set_class(&reserved_iova_ranges.iova_rbtree_lock,
 			  &reserved_rbtree_key);
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 48d36ce..7064d32 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -223,18 +223,7 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 		/* ...then finally give it a kicking to make sure it fits */
 		base_pfn = max_t(unsigned long, base_pfn,
 				domain->geometry.aperture_start >> order);
-		end_pfn = min_t(unsigned long, end_pfn,
-				domain->geometry.aperture_end >> order);
 	}
-	/*
-	 * PCI devices may have larger DMA masks, but still prefer allocating
-	 * within a 32-bit mask to avoid DAC addressing. Such limitations don't
-	 * apply to the typical platform device, so for those we may as well
-	 * leave the cache limit at the top of their range to save an rb_last()
-	 * traversal on every allocation.
-	 */
-	if (pci)
-		end_pfn &= DMA_BIT_MASK(32) >> order;
 
 	/* start_pfn is always nonzero for an already-initialised domain */
 	if (iovad->start_pfn) {
@@ -243,16 +232,15 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 			pr_warn("Incompatible range for DMA domain\n");
 			return -EFAULT;
 		}
-		/*
-		 * If we have devices with different DMA masks, move the free
-		 * area cache limit down for the benefit of the smaller one.
-		 */
-		iovad->dma_32bit_pfn = min(end_pfn, iovad->dma_32bit_pfn);
 	} else {
-		init_iova_domain(iovad, 1UL << order, base_pfn, end_pfn);
+		init_iova_domain(iovad, 1UL << order, base_pfn);
 		if (pci)
 			iova_reserve_pci_windows(to_pci_dev(dev), iovad);
 	}
+
+	if (end_pfn < iovad->dma_32bit_pfn)
+		dev_dbg(dev, "ancient device or dma range missed some bits?");
+
 	return 0;
 }
 EXPORT_SYMBOL(iommu_dma_init_domain);
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 238ad34..de467c1 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -82,8 +82,6 @@
 #define IOVA_START_PFN		(1)
 
 #define IOVA_PFN(addr)		((addr) >> PAGE_SHIFT)
-#define DMA_32BIT_PFN		IOVA_PFN(DMA_BIT_MASK(32))
-#define DMA_64BIT_PFN		IOVA_PFN(DMA_BIT_MASK(64))
 
 /* page table handling */
 #define LEVEL_STRIDE		(9)
@@ -1869,8 +1867,7 @@ static int dmar_init_reserved_ranges(void)
 	struct iova *iova;
 	int i;
 
-	init_iova_domain(&reserved_iova_list, VTD_PAGE_SIZE, IOVA_START_PFN,
-			DMA_32BIT_PFN);
+	init_iova_domain(&reserved_iova_list, VTD_PAGE_SIZE, IOVA_START_PFN);
 
 	lockdep_set_class(&reserved_iova_list.iova_rbtree_lock,
 		&reserved_rbtree_key);
@@ -1928,8 +1925,7 @@ static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
 	int adjust_width, agaw;
 	unsigned long sagaw;
 
-	init_iova_domain(&domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN,
-			DMA_32BIT_PFN);
+	init_iova_domain(&domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN);
 	domain_reserve_special_ranges(domain);
 
 	/* calculate AGAW */
@@ -4965,8 +4961,7 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
 {
 	int adjust_width;
 
-	init_iova_domain(&domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN,
-			DMA_32BIT_PFN);
+	init_iova_domain(&domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN);
 	domain_reserve_special_ranges(domain);
 
 	/* calculate AGAW */
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 68754e4..43fd8e9 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -50,7 +50,7 @@ insert_iova_boundary(struct iova_domain *iovad)
 
 void
 init_iova_domain(struct iova_domain *iovad, unsigned long granule,
-	unsigned long start_pfn, unsigned long pfn_32bit)
+	unsigned long start_pfn)
 {
 	/*
 	 * IOVA granularity will normally be equal to the smallest
@@ -63,7 +63,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	iovad->rbroot = RB_ROOT;
 	iovad->granule = granule;
 	iovad->start_pfn = start_pfn;
-	iovad->dma_32bit_pfn = pfn_32bit;
+	iovad->dma_32bit_pfn = DMA_BIT_MASK(32) >> ilog2(granule);
 	init_iova_rcaches(iovad);
 
 	/*
diff --git a/drivers/misc/mic/scif/scif_rma.c b/drivers/misc/mic/scif/scif_rma.c
index 329727e..c824329 100644
--- a/drivers/misc/mic/scif/scif_rma.c
+++ b/drivers/misc/mic/scif/scif_rma.c
@@ -39,8 +39,7 @@ void scif_rma_ep_init(struct scif_endpt *ep)
 	struct scif_endpt_rma_info *rma = &ep->rma_info;
 
 	mutex_init(&rma->rma_lock);
-	init_iova_domain(&rma->iovad, PAGE_SIZE, SCIF_IOVA_START_PFN,
-			 SCIF_DMA_64BIT_PFN);
+	init_iova_domain(&rma->iovad, PAGE_SIZE, SCIF_IOVA_START_PFN);
 	spin_lock_init(&rma->tc_lock);
 	mutex_init(&rma->mmn_lock);
 	INIT_LIST_HEAD(&rma->reg_list);
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 844d723..6f037b2 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -101,7 +101,7 @@ struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
 	unsigned long pfn_hi);
 void copy_reserved_iova(struct iova_domain *from, struct iova_domain *to);
 void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
-	unsigned long start_pfn, unsigned long pfn_32bit);
+	unsigned long start_pfn);
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
 void put_iova_domain(struct iova_domain *iovad);
 struct iova *split_and_remove_iova(struct iova_domain *iovad,
-- 
2.5.0
