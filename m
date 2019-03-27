From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 02/10] iommu/vt-d: Add helpers for domain mapping/unmapping
Date: Wed, 27 Mar 2019 14:34:58 +0800
Message-ID: <20190327063506.32564-3-baolu.lu@linux.intel.com>
References: <20190327063506.32564-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327063506.32564-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com, mika.westerberg@linux.intel.com, pengfei.xu@intel.com
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This adds two helpers to map or unmap a physically
contiguous memory region in the page table of an
iommu domain.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Xu Pengfei <pengfei.xu@intel.com>
Tested-by: Mika Westerberg <mika.westerberg@intel.com>
---
 drivers/iommu/intel-iommu.c | 35 +++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h |  5 +++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index c137f0f2cf49..19b1ff02025a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5851,3 +5851,38 @@ static void __init check_tylersburg_isoch(void)
 	pr_warn("Recommended TLB entries for ISOCH unit is 16; your BIOS set %d\n",
 	       vtisochctrl);
 }
+
+/*
+ * Map a physically contiguous memory region in the dma page table
+ * of an iommu domain.
+ */
+int
+domain_iomap_range(struct dmar_domain *domain, unsigned long addr,
+		   phys_addr_t paddr, size_t size, int prot)
+{
+	return domain_mapping(domain,
+			      mm_to_dma_pfn(IOVA_PFN(addr)),
+			      NULL,
+			      mm_to_dma_pfn(IOVA_PFN(paddr)),
+			      aligned_nrpages(addr, size),
+			      prot);
+}
+
+/*
+ * Unmap a physically contiguous memory region in the dma page table
+ * of an iommu domain. Return the free page list that should be freed
+ * after iotlb flush. We can't free these pages here since it possibly
+ * is still used by iotlb cache for a DMA translation.
+ */
+struct page *
+domain_iounmap_range(struct dmar_domain *domain, unsigned long addr,
+		     size_t size)
+{
+	unsigned long nrpages, start_pfn, last_pfn;
+
+	nrpages = aligned_nrpages(addr, size);
+	start_pfn = mm_to_dma_pfn(IOVA_PFN(addr));
+	last_pfn = start_pfn + nrpages - 1;
+
+	return domain_unmap(domain, start_pfn, last_pfn);
+}
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 6925a18a5ca3..74afedfe193b 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -663,6 +663,11 @@ int for_each_device_domain(int (*fn)(struct device_domain_info *info,
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev);
 
+int domain_iomap_range(struct dmar_domain *domain, unsigned long addr,
+		       phys_addr_t paddr, size_t size, int prot);
+struct page *domain_iounmap_range(struct dmar_domain *domain,
+				  unsigned long addr, size_t size);
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 int intel_svm_init(struct intel_iommu *iommu);
 extern int intel_svm_enable_prq(struct intel_iommu *iommu);
-- 
2.17.1
