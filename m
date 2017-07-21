From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 4/4] iommu/iova: Make dma_32bit_pfn implicit
Date: Fri, 21 Jul 2017 12:42:01 +0100
Message-ID: <1335357886db139a51f7d0bd0728067d0d77de8d.1500636791.git.robin.murphy@arm.com>
References: <cover.1500636791.git.robin.murphy@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1500636791.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dwmw2@infradead.org, thunder.leizhen@huawei.com, lorenzo.pieralisi@arm.com, ard.biesheuvel@linaro.org, Jonathan.Cameron@huawei.com, nwatters@codeaurora.org, ray.jui@broadcom.com, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@linux.ie>, Sudeep Dutt <sudeep.dutt@intel.com>, Ashutosh Dixit <ashutosh.dixit@intel.com>
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
[rm: use iova_shift(), rewrote commit message]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Avoid iova_pfn() overflow with 32-bit dma_addr_t

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
index 518f4b69ea53..81e9ae1ee90b 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -150,8 +150,7 @@ static int tegra_drm_load(struct drm_device *drm, unsigned long flags)
 
 		order = __ffs(tegra->domain->pgsize_bitmap);
 		init_iova_domain(&tegra->carveout.domain, 1UL << order,
-				 carveout_start >> order,
-				 carveout_end >> order);
+				 carveout_start >> order);
 
 		tegra->carveout.shift = iova_shift(&tegra->carveout.domain);
 		tegra->carveout.limit = carveout_end >> tegra->carveout.shift;
diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 2c58a390123a..57c8eed0ed71 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -193,8 +193,7 @@ static int host1x_probe(struct platform_device *pdev)
 
 		order = __ffs(host->domain->pgsize_bitmap);
 		init_iova_domain(&host->iova, 1UL << order,
-				 geometry->aperture_start >> order,
-				 geometry->aperture_end >> order);
+				 geometry->aperture_start >> order);
 		host->iova_end = geometry->aperture_end;
 	}
 
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 688e77576e5a..a12e3e12014a 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -63,7 +63,6 @@
 /* IO virtual address start page frame number */
 #define IOVA_START_PFN		(1)
 #define IOVA_PFN(addr)		((addr) >> PAGE_SHIFT)
-#define DMA_32BIT_PFN		IOVA_PFN(DMA_BIT_MASK(32))
 
 /* Reserved IOVA ranges */
 #define MSI_RANGE_START		(0xfee00000)
@@ -2010,8 +2009,7 @@ static struct dma_ops_domain *dma_ops_domain_alloc(void)
 	if (!dma_dom->domain.pt_root)
 		goto free_dma_dom;
 
-	init_iova_domain(&dma_dom->iovad, PAGE_SIZE,
-			 IOVA_START_PFN, DMA_32BIT_PFN);
+	init_iova_domain(&dma_dom->iovad, PAGE_SIZE, IOVA_START_PFN);
 
 	/* Initialize reserved ranges */
 	copy_reserved_iova(&reserved_iova_ranges, &dma_dom->iovad);
@@ -2912,8 +2910,7 @@ static int init_reserved_iova_ranges(void)
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
index 687f18f65cea..afa3b4e765e7 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -82,8 +82,6 @@
 #define IOVA_START_PFN		(1)
 
 #define IOVA_PFN(addr)		((addr) >> PAGE_SHIFT)
-#define DMA_32BIT_PFN		IOVA_PFN(DMA_BIT_MASK(32))
-#define DMA_64BIT_PFN		IOVA_PFN(DMA_BIT_MASK(64))
 
 /* page table handling */
 #define LEVEL_STRIDE		(9)
@@ -1874,8 +1872,7 @@ static int dmar_init_reserved_ranges(void)
 	struct iova *iova;
 	int i;
 
-	init_iova_domain(&reserved_iova_list, VTD_PAGE_SIZE, IOVA_START_PFN,
-			DMA_32BIT_PFN);
+	init_iova_domain(&reserved_iova_list, VTD_PAGE_SIZE, IOVA_START_PFN);
 
 	lockdep_set_class(&reserved_iova_list.iova_rbtree_lock,
 		&reserved_rbtree_key);
@@ -1933,8 +1930,7 @@ static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
 	int adjust_width, agaw;
 	unsigned long sagaw;
 
-	init_iova_domain(&domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN,
-			DMA_32BIT_PFN);
+	init_iova_domain(&domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN);
 	domain_reserve_special_ranges(domain);
 
 	/* calculate AGAW */
@@ -4989,8 +4985,7 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width)
 {
 	int adjust_width;
 
-	init_iova_domain(&domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN,
-			DMA_32BIT_PFN);
+	init_iova_domain(&domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN);
 	domain_reserve_special_ranges(domain);
 
 	/* calculate AGAW */
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index f5809a2ee6c2..f88acadeebfe 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -35,7 +35,7 @@ static void free_iova_rcaches(struct iova_domain *iovad);
 
 void
 init_iova_domain(struct iova_domain *iovad, unsigned long granule,
-	unsigned long start_pfn, unsigned long pfn_32bit)
+	unsigned long start_pfn)
 {
 	/*
 	 * IOVA granularity will normally be equal to the smallest
@@ -50,7 +50,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	iovad->cached32_node = NULL;
 	iovad->granule = granule;
 	iovad->start_pfn = start_pfn;
-	iovad->dma_32bit_pfn = pfn_32bit + 1;
+	iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
 	init_iova_rcaches(iovad);
 }
 EXPORT_SYMBOL_GPL(init_iova_domain);
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
index 0bb8df43b393..58c2a365c45f 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -102,7 +102,7 @@ struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
 	unsigned long pfn_hi);
 void copy_reserved_iova(struct iova_domain *from, struct iova_domain *to);
 void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
-	unsigned long start_pfn, unsigned long pfn_32bit);
+	unsigned long start_pfn);
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
 void put_iova_domain(struct iova_domain *iovad);
 struct iova *split_and_remove_iova(struct iova_domain *iovad,
@@ -170,8 +170,7 @@ static inline void copy_reserved_iova(struct iova_domain *from,
 
 static inline void init_iova_domain(struct iova_domain *iovad,
 				    unsigned long granule,
-				    unsigned long start_pfn,
-				    unsigned long pfn_32bit)
+				    unsigned long start_pfn)
 {
 }
 
-- 
2.12.2.dirty
