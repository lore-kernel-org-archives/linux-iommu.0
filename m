From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 04/10] iommu/vt-d: Add dir_to_prot() helper
Date: Wed, 27 Mar 2019 14:35:00 +0800
Message-ID: <20190327063506.32564-5-baolu.lu@linux.intel.com>
References: <20190327063506.32564-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327063506.32564-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com, mika.westerberg@linux.intel.com, pengfei.xu@intel.com
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This consolidates the code with a helper.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 21 +++------------------
 include/linux/intel-iommu.h | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 19b1ff02025a..6e4e72cd16ca 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3676,15 +3676,8 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 	if (!iova_pfn)
 		goto error;
 
-	/*
-	 * Check if DMAR supports zero-length reads on write only
-	 * mappings..
-	 */
-	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL || \
-			!cap_zlr(iommu->cap))
-		prot |= DMA_PTE_READ;
-	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
-		prot |= DMA_PTE_WRITE;
+	prot = dir_to_prot(iommu, dir);
+
 	/*
 	 * paddr - (paddr + size) might be partial page, we should map the whole
 	 * page.  Note: if two part of one page are separately mapped, we
@@ -3899,15 +3892,7 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 		return 0;
 	}
 
-	/*
-	 * Check if DMAR supports zero-length reads on write only
-	 * mappings..
-	 */
-	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL || \
-			!cap_zlr(iommu->cap))
-		prot |= DMA_PTE_READ;
-	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
-		prot |= DMA_PTE_WRITE;
+	prot = dir_to_prot(iommu, dir);
 
 	start_vpfn = mm_to_dma_pfn(iova_pfn);
 
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 74afedfe193b..0fbefdf645a5 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -593,6 +593,26 @@ static inline void __iommu_flush_cache(
 		clflush_cache_range(addr, size);
 }
 
+static inline int dir_to_prot(struct intel_iommu *iommu,
+			      enum dma_data_direction dir)
+{
+	int prot = 0;
+
+	/*
+	 * Check if DMAR supports zero-length reads on write only
+	 * mappings..
+	 */
+	if (dir == DMA_TO_DEVICE ||
+	    dir == DMA_BIDIRECTIONAL ||
+	    !cap_zlr(iommu->cap))
+		prot |= DMA_PTE_READ;
+
+	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
+		prot |= DMA_PTE_WRITE;
+
+	return prot;
+}
+
 /*
  * 0: readable
  * 1: writable
-- 
2.17.1
