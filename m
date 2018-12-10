From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v6 03/12] iommu/vt-d: Move page table helpers into header
Date: Mon, 10 Dec 2018 09:58:57 +0800
Message-ID: <20181210015906.27929-4-baolu.lu@linux.intel.com>
References: <20181210015906.27929-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181210015906.27929-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

So that they could also be used in other source files.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Cc: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel-iommu.c | 43 -------------------------------------
 include/linux/intel-iommu.h | 43 +++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 73d7c15bf737..52cdb0e077f2 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -290,49 +290,6 @@ static inline void context_clear_entry(struct context_entry *context)
 	context->hi = 0;
 }
 
-/*
- * 0: readable
- * 1: writable
- * 2-6: reserved
- * 7: super page
- * 8-10: available
- * 11: snoop behavior
- * 12-63: Host physcial address
- */
-struct dma_pte {
-	u64 val;
-};
-
-static inline void dma_clear_pte(struct dma_pte *pte)
-{
-	pte->val = 0;
-}
-
-static inline u64 dma_pte_addr(struct dma_pte *pte)
-{
-#ifdef CONFIG_64BIT
-	return pte->val & VTD_PAGE_MASK;
-#else
-	/* Must have a full atomic 64-bit read */
-	return  __cmpxchg64(&pte->val, 0ULL, 0ULL) & VTD_PAGE_MASK;
-#endif
-}
-
-static inline bool dma_pte_present(struct dma_pte *pte)
-{
-	return (pte->val & 3) != 0;
-}
-
-static inline bool dma_pte_superpage(struct dma_pte *pte)
-{
-	return (pte->val & DMA_PTE_LARGE_PAGE);
-}
-
-static inline int first_pte_in_page(struct dma_pte *pte)
-{
-	return !((unsigned long)pte & ~VTD_PAGE_MASK);
-}
-
 /*
  * This domain is a statically identity mapping domain.
  *	1. This domain creats a static 1:1 mapping to all usable memory.
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 8c9b6063d275..b4da61385ebf 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -590,6 +590,49 @@ static inline void __iommu_flush_cache(
 		clflush_cache_range(addr, size);
 }
 
+/*
+ * 0: readable
+ * 1: writable
+ * 2-6: reserved
+ * 7: super page
+ * 8-10: available
+ * 11: snoop behavior
+ * 12-63: Host physcial address
+ */
+struct dma_pte {
+	u64 val;
+};
+
+static inline void dma_clear_pte(struct dma_pte *pte)
+{
+	pte->val = 0;
+}
+
+static inline u64 dma_pte_addr(struct dma_pte *pte)
+{
+#ifdef CONFIG_64BIT
+	return pte->val & VTD_PAGE_MASK;
+#else
+	/* Must have a full atomic 64-bit read */
+	return  __cmpxchg64(&pte->val, 0ULL, 0ULL) & VTD_PAGE_MASK;
+#endif
+}
+
+static inline bool dma_pte_present(struct dma_pte *pte)
+{
+	return (pte->val & 3) != 0;
+}
+
+static inline bool dma_pte_superpage(struct dma_pte *pte)
+{
+	return (pte->val & DMA_PTE_LARGE_PAGE);
+}
+
+static inline int first_pte_in_page(struct dma_pte *pte)
+{
+	return !((unsigned long)pte & ~VTD_PAGE_MASK);
+}
+
 extern struct dmar_drhd_unit * dmar_find_matched_drhd_unit(struct pci_dev *dev);
 extern int dmar_find_matched_atsr_unit(struct pci_dev *dev);
 
-- 
2.17.1
