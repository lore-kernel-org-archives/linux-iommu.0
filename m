From: Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>
Subject: [PATCH 1/1] iommu/iova: Make rcache flush optional on IOVA allocation failure
Date: Mon, 18 Sep 2017 12:56:54 +0200
Message-ID: <1505732214-9052-2-git-send-email-tomasz.nowicki@caviumnetworks.com>
References: <1505732214-9052-1-git-send-email-tomasz.nowicki@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1505732214-9052-1-git-send-email-tomasz.nowicki@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, robin.murphy@arm.com, will.deacon@arm.com
Cc: lorenzo.pieralisi@arm.com, Jayachandran.Nair@cavium.com, Ganapatrao.Kulkarni@cavium.com, ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>, Tomasz Nowicki <Tomasz.Nowicki@caviumnetworks.com>
List-Id: iommu@lists.linux-foundation.org

Since IOVA allocation failure is not unusual case we need to flush
CPUs' rcache in hope we will succeed in next round.

However, it is useful to decide whether we need rcache flush step because
of two reasons:
- Not scalability. On large system with ~100 CPUs iterating and flushing
  rcache for each CPU becomes serious bottleneck so we may want to deffer it.
- free_cpu_cached_iovas() does not care about max PFN we are interested in.
  Thus we may flush our rcaches and still get no new IOVA like in the
  commonly used scenario:

    if (dma_limit > DMA_BIT_MASK(32) && dev_is_pci(dev))
        iova = alloc_iova_fast(iovad, iova_len, DMA_BIT_MASK(32) >> shift);

    if (!iova)
        iova = alloc_iova_fast(iovad, iova_len, dma_limit >> shift);

   1. First alloc_iova_fast() call is limited to DMA_BIT_MASK(32) to get
      PCI devices a SAC address
   2. alloc_iova() fails due to full 32-bit space
   3. rcaches contain PFNs out of 32-bit space so free_cpu_cached_iovas()
      throws entries away for nothing and alloc_iova() fails again
   4. Next alloc_iova_fast() call cannot take advantage of rcache since we
      have just defeated caches. In this case we pick the slowest option
      to proceed.

This patch reworks flushed_rcache local flag to be additional function
argument instead and control rcache flush step. Also, it updates all users
to do the flush as the last chance.

Signed-off-by: Tomasz Nowicki <Tomasz.Nowicki@caviumnetworks.com>
---
 drivers/iommu/amd_iommu.c   | 5 +++--
 drivers/iommu/dma-iommu.c   | 6 ++++--
 drivers/iommu/intel-iommu.c | 5 +++--
 drivers/iommu/iova.c        | 7 +++----
 include/linux/iova.h        | 5 +++--
 5 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 8d2ec60..ce68986 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1604,10 +1604,11 @@ static unsigned long dma_ops_alloc_iova(struct device *dev,
 
 	if (dma_mask > DMA_BIT_MASK(32))
 		pfn = alloc_iova_fast(&dma_dom->iovad, pages,
-				      IOVA_PFN(DMA_BIT_MASK(32)));
+				      IOVA_PFN(DMA_BIT_MASK(32)), false);
 
 	if (!pfn)
-		pfn = alloc_iova_fast(&dma_dom->iovad, pages, IOVA_PFN(dma_mask));
+		pfn = alloc_iova_fast(&dma_dom->iovad, pages,
+				      IOVA_PFN(dma_mask), true);
 
 	return (pfn << PAGE_SHIFT);
 }
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 191be9c..25914d3 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -370,10 +370,12 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 
 	/* Try to get PCI devices a SAC address */
 	if (dma_limit > DMA_BIT_MASK(32) && dev_is_pci(dev))
-		iova = alloc_iova_fast(iovad, iova_len, DMA_BIT_MASK(32) >> shift);
+		iova = alloc_iova_fast(iovad, iova_len,
+				       DMA_BIT_MASK(32) >> shift, false);
 
 	if (!iova)
-		iova = alloc_iova_fast(iovad, iova_len, dma_limit >> shift);
+		iova = alloc_iova_fast(iovad, iova_len, dma_limit >> shift,
+				       true);
 
 	return (dma_addr_t)iova << shift;
 }
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 05c0c3a..75c8320 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3460,11 +3460,12 @@ static unsigned long intel_alloc_iova(struct device *dev,
 		 * from higher range
 		 */
 		iova_pfn = alloc_iova_fast(&domain->iovad, nrpages,
-					   IOVA_PFN(DMA_BIT_MASK(32)));
+					   IOVA_PFN(DMA_BIT_MASK(32)), false);
 		if (iova_pfn)
 			return iova_pfn;
 	}
-	iova_pfn = alloc_iova_fast(&domain->iovad, nrpages, IOVA_PFN(dma_mask));
+	iova_pfn = alloc_iova_fast(&domain->iovad, nrpages,
+				   IOVA_PFN(dma_mask), true);
 	if (unlikely(!iova_pfn)) {
 		pr_err("Allocating %ld-page iova for %s failed",
 		       nrpages, dev_name(dev));
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index f88acad..1a18b14 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -358,9 +358,8 @@ EXPORT_SYMBOL_GPL(free_iova);
 */
 unsigned long
 alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
-		unsigned long limit_pfn)
+		unsigned long limit_pfn, bool flush_rcache)
 {
-	bool flushed_rcache = false;
 	unsigned long iova_pfn;
 	struct iova *new_iova;
 
@@ -373,11 +372,11 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 	if (!new_iova) {
 		unsigned int cpu;
 
-		if (flushed_rcache)
+		if (!flush_rcache)
 			return 0;
 
 		/* Try replenishing IOVAs by flushing rcache. */
-		flushed_rcache = true;
+		flush_rcache = false;
 		for_each_online_cpu(cpu)
 			free_cpu_cached_iovas(cpu, iovad);
 		goto retry;
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 58c2a36..8fdcb66 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -97,7 +97,7 @@ struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,
 void free_iova_fast(struct iova_domain *iovad, unsigned long pfn,
 		    unsigned long size);
 unsigned long alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
-			      unsigned long limit_pfn);
+			      unsigned long limit_pfn, bool flush_rcache);
 struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
 	unsigned long pfn_hi);
 void copy_reserved_iova(struct iova_domain *from, struct iova_domain *to);
@@ -151,7 +151,8 @@ static inline void free_iova_fast(struct iova_domain *iovad,
 
 static inline unsigned long alloc_iova_fast(struct iova_domain *iovad,
 					    unsigned long size,
-					    unsigned long limit_pfn)
+					    unsigned long limit_pfn,
+					    bool flush_rcache)
 {
 	return 0;
 }
-- 
2.7.4
