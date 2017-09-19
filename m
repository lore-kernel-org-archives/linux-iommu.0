From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v4 6/6] iommu/iova: Make dma_32bit_pfn implicit
Date: Tue, 19 Sep 2017 17:31:57 +0100
Message-ID: <7683c29df187f50a08299269a469380553336a4d.1505829018.git.robin.murphy@arm.com>
References: <cover.1505829018.git.robin.murphy@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1505829018.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, thunder.leizhen@huawei.com, nwatters@codeaurora.org, tomasz.nowicki@caviumnetworks.com, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@linux.ie>, Sudeep Dutt <sudeep.dutt@intel.com>, Ashutosh Dixit <ashutosh.dixit@intel.com>
List-Id: iommu@lists.linux-foundation.org

From: Zhen Lei <thunder.leizhen@huawei.com>

Now that the cached node optimisation can apply to all allocations, the
couple of users which were playing tricks with dma_32bit_pfn in order to
benefit from it can stop doing so. Conversely, there is also no need for
all the other users to explicitly calculate a 'real' 32-bit PFN, when
init_iova_domain() can happily do that itself from the page granularity.

CC: Thierry Reding <thierry.reding@gmail.com>
CC: Jonathan Hunter <jonathanh@nvidia.com>
CC: David Airlie <airlied@linux.ie>
CC: Sudeep Dutt <sudeep.dutt@intel.com>
CC: Ashutosh Dixit <ashutosh.dixit@intel.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Zhen Lei <thunder.leizhen@huawei.com>
Tested-by: Nate Watterson <nwatters@codeaurora.org>
[rm: use iova_shift(), rewrote commit message]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v4: No change

 drivers/gpu/drm/tegra/drm.c      |  3 +--
 drivers/gpu/host1x/dev.c         |  3 +--
 drivers/iommu/amd_iommu.c        |  7 ++-----
 drivers/iommu/dma-iommu.c        | 18 +-----------------
 drivers/iommu/intel-iommu.c      | 11 +++--------
 drivers/iommu/iova.c             |  4 ++--
 drivers/misc/mic/scif/scif_rma.c |  3 +--
 include/linux/iova.h             |  5 ++---
 8 files changed, 13 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 597d563d636a..b822e484b7e5 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -155,8 +155,7 @@ static int tegra_drm_load(struct drm_device *drm, unsigned long flags)
 
 		order = __ffs(tegra->domain->pgsize_bitmap);
 		init_iova_domain(&tegra->carveout.domain, 1UL << order,
-				 carveout_start >> order,
-				 carveout_end >> order);
+				 carveout_start >> order);
 
 		tegra->carveout.shift = iova_shift(&tegra->carveout.domain);
 		tegra->carveout.limit = carveout_end >> tegra->carveout.shift;
diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 7f22c5c37660..5267c62e8896 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -198,8 +198,7 @@ static int host1x_probe(struct platform_device *pdev)
 
 		order = __ffs(host->domain->pgsize_bitmap);
 		init_iova_domain(&host->iova, 1UL << order,
-				 geometry->aperture_start >> order,
-				 geometry->aperture_end >> order);
+				 geometry->aperture_start >> order);
 		host->iova_end = geometry->aperture_end;
 	}
 
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 51f8215877f5..647ab7691aee 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -63,7 +63,6 @@
 /* IO virtual address start page frame number */
 #define IOVA_START_PFN		(1)
 #define IOVA_PFN(addr)		((addr) >> PAGE_SHIFT)
-#define DMA_32BIT_PFN		IOVA_PFN(DMA_BIT_MASK(32))
 
 /* Reserved IOVA ranges */
 #define MSI_RANGE_START		(0xfee00000)
@@ -1788,8 +1787,7 @@ static struct dma_ops_domain *dma_ops_domain_alloc(void)
 	if (!dma_dom->domain.pt_root)
 		goto free_dma_dom;
 
-	init_iova_domain(&dma_dom->iovad, PAGE_SIZE,
-			 IOVA_START_PFN, DMA_32BIT_PFN);
+	init_iova_domain(&dma_dom->iovad, PAGE_SIZE, IOVA_START_PFN);
 
 	if (init_iova_flush_queue(&dma_dom->iovad, iova_domain_flush_tlb, NULL))
 		goto free_dma_dom;
@@ -2696,8 +2694,7 @@ static int init_reserved_iova_ranges(void)
 	struct pci_dev *pdev = NULL;
 	struct iova *val;
 
-	init_iova_domain(&reserved_iova_ranges, PAGE_SIZE,
-			 IOVA_START_PFN, DMA_32BIT_PFN);
+	init_iova_domain(&reserved_iova_ranges, PAGE_SIZE, IOVA_START_PFN);
 
 	lockdep_set_class(&reserved_iova_ranges.iova_rbtree_lock,
 			  &reserved_rbtree_key);
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9d1cebe7f6cb..191be9c80a8a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -292,18 +292,7 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
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
-	if (dev && dev_is_pci(dev))
-		end_pfn &= DMA_BIT_MASK(32) >> order;
 
 	/* start_pfn is always nonzero for an already-initialised domain */
 	if (iovad->start_pfn) {
@@ -312,16 +301,11 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 			pr_warn("Incompatible range for DMA domain\n");
 			return -EFAULT;
 		}
-		/*
-		 * If we have devices with different DMA masks, move the free
-		 * area cache limit down for the benefit of the smaller one.
-		 */
-		iovad->dma_32bit_pfn = min(end_pfn + 1, iovad->dma_32bit_pfn);
 
 		return 0;
 	}
 
-	init_iova_domain(iovad, 1UL << order, base_pfn, end_pfn);
+	init_iova_domain(iovad, 1UL << order, base_pfn);
 	if (!dev)
 		return 0;
 
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6784a05dd6b2..ebb48353dd39 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -82,8 +82,6 @@
 #define IOVA_START_PFN		(1)
 
 #define IOVA_PFN(addr)		((addr) >> PAGE_SHIFT)
-#define DMA_32BIT_PFN		IOVA_PFN(DMA_BIT_MASK(32))
-#define DMA_64BIT_PFN		IOVA_PFN(DMA_BIT_MASK(64))
 
 /* page table handling */
 #define LEVEL_STRIDE		(9)
@@ -1878,8 +1876,7 @@ static int dmar_init_reserved_ranges(void)
 	struct iova *iova;
 	int i;
 
-	init_iova_domain(&reserved_iova_list, VTD_PAGE_SIZE, IOVA_START_PFN,
-			DMA_32BIT_PFN);
+	init_iova_domain(&reserved_iova_list, VTD_PAGE_SIZE, IOVA_START_PFN);
 
 	lockdep_set_class(&reserved_iova_list.iova_rbtree_lock,
 		&reserved_rbtree_key);
@@ -1938,8 +1935,7 @@ static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
 	unsigned long sagaw;
 	int err;
 
-	init_iova_domain(&domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN,
-			DMA_32BIT_PFN);
+	init_iova_domain(&domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN);
 
 	err = init_iova_flush_queue(&domain->iovad,
 				    iommu_flush_iova, iova_entry_free);
@@ -4897,8 +4893,7 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
 {
 	int adjust_width;
 
-	init_iova_domain(&domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN,
-			DMA_32BIT_PFN);
+	init_iova_domain(&domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN);
 	domain_reserve_special_ranges(domain);
 
 	/* calculate AGAW */
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index a125a5786dbf..dbe26067250e 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -40,7 +40,7 @@ static void fq_flush_timeout(unsigned long data);
 
 void
 init_iova_domain(struct iova_domain *iovad, unsigned long granule,
-	unsigned long start_pfn, unsigned long pfn_32bit)
+	unsigned long start_pfn)
 {
 	/*
 	 * IOVA granularity will normally be equal to the smallest
@@ -55,7 +55,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	iovad->cached32_node = NULL;
 	iovad->granule = granule;
 	iovad->start_pfn = start_pfn;
-	iovad->dma_32bit_pfn = pfn_32bit + 1;
+	iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
 	iovad->flush_cb = NULL;
 	iovad->fq = NULL;
 	iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
diff --git a/drivers/misc/mic/scif/scif_rma.c b/drivers/misc/mic/scif/scif_rma.c
index 329727e00e97..c824329f7012 100644
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
index 5eaedf77b152..c696ee81054e 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -155,7 +155,7 @@ struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
 	unsigned long pfn_hi);
 void copy_reserved_iova(struct iova_domain *from, struct iova_domain *to);
 void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
-	unsigned long start_pfn, unsigned long pfn_32bit);
+	unsigned long start_pfn);
 int init_iova_flush_queue(struct iova_domain *iovad,
 			  iova_flush_cb flush_cb, iova_entry_dtor entry_dtor);
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
@@ -231,8 +231,7 @@ static inline void copy_reserved_iova(struct iova_domain *from,
 
 static inline void init_iova_domain(struct iova_domain *iovad,
 				    unsigned long granule,
-				    unsigned long start_pfn,
-				    unsigned long pfn_32bit)
+				    unsigned long start_pfn)
 {
 }
 
-- 
2.13.4.dirty
