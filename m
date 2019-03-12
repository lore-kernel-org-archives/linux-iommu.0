From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v1 5/9] iommu/vt-d: Add bounce buffer API for dma sync
Date: Tue, 12 Mar 2019 14:00:01 +0800
Message-ID: <20190312060005.12189-6-baolu.lu@linux.intel.com>
References: <20190312060005.12189-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312060005.12189-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com, mika.westerberg@linux.intel.com, pengfei.xu@intel.com
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This adds the APIs for bounce buffer specified dma sync
ops.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Xu Pengfei <pengfei.xu@intel.com>
Tested-by: Mika Westerberg <mika.westerberg@intel.com>
---
 drivers/iommu/intel-pgtable.c | 112 ++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h   |   6 ++
 2 files changed, 118 insertions(+)

diff --git a/drivers/iommu/intel-pgtable.c b/drivers/iommu/intel-pgtable.c
index e8317982c5ab..d175045fe236 100644
--- a/drivers/iommu/intel-pgtable.c
+++ b/drivers/iommu/intel-pgtable.c
@@ -331,6 +331,100 @@ static const struct addr_walk walk_bounce_unmap = {
 	.high = bounce_unmap_high,
 };
 
+static int
+bounce_sync_iova_pfn(struct dmar_domain *domain, dma_addr_t addr,
+		     size_t size, struct bounce_param *param,
+		     enum dma_data_direction dir)
+{
+	struct bounce_cookie *cookie;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bounce_lock, flags);
+	cookie = idr_find(&domain->bounce_idr, addr >> PAGE_SHIFT);
+	spin_unlock_irqrestore(&bounce_lock, flags);
+	if (!cookie)
+		return 0;
+
+	return bounce_sync(cookie->original_phys, cookie->bounce_phys,
+			   size, dir);
+}
+
+static int
+bounce_sync_for_device_low(struct dmar_domain *domain, dma_addr_t addr,
+			   phys_addr_t paddr, size_t size,
+			   struct bounce_param *param)
+{
+	if (param->dir == DMA_BIDIRECTIONAL || param->dir == DMA_TO_DEVICE)
+		return bounce_sync_iova_pfn(domain, addr, size,
+					    param, DMA_TO_DEVICE);
+
+	return 0;
+}
+
+static int
+bounce_sync_for_device_middle(struct dmar_domain *domain, dma_addr_t addr,
+			      phys_addr_t paddr, size_t size,
+			      struct bounce_param *param)
+{
+	return 0;
+}
+
+static int
+bounce_sync_for_device_high(struct dmar_domain *domain, dma_addr_t addr,
+			    phys_addr_t paddr, size_t size,
+			    struct bounce_param *param)
+{
+	if (param->dir == DMA_BIDIRECTIONAL || param->dir == DMA_TO_DEVICE)
+		return bounce_sync_iova_pfn(domain, addr, size,
+					    param, DMA_TO_DEVICE);
+
+	return 0;
+}
+
+const struct addr_walk walk_bounce_sync_for_device = {
+	.low = bounce_sync_for_device_low,
+	.middle = bounce_sync_for_device_middle,
+	.high = bounce_sync_for_device_high,
+};
+
+static int
+bounce_sync_for_cpu_low(struct dmar_domain *domain, dma_addr_t addr,
+			phys_addr_t paddr, size_t size,
+			struct bounce_param *param)
+{
+	if (param->dir == DMA_BIDIRECTIONAL || param->dir == DMA_FROM_DEVICE)
+		return bounce_sync_iova_pfn(domain, addr, size,
+					    param, DMA_FROM_DEVICE);
+
+	return 0;
+}
+
+static int
+bounce_sync_for_cpu_middle(struct dmar_domain *domain, dma_addr_t addr,
+			   phys_addr_t paddr, size_t size,
+			   struct bounce_param *param)
+{
+	return 0;
+}
+
+static int
+bounce_sync_for_cpu_high(struct dmar_domain *domain, dma_addr_t addr,
+			 phys_addr_t paddr, size_t size,
+			 struct bounce_param *param)
+{
+	if (param->dir == DMA_BIDIRECTIONAL || param->dir == DMA_FROM_DEVICE)
+		return bounce_sync_iova_pfn(domain, addr, size,
+					    param, DMA_FROM_DEVICE);
+
+	return 0;
+}
+
+const struct addr_walk walk_bounce_sync_for_cpu = {
+	.low = bounce_sync_for_cpu_low,
+	.middle = bounce_sync_for_cpu_middle,
+	.high = bounce_sync_for_cpu_high,
+};
+
 static int
 domain_walk_addr_range(const struct addr_walk *walk,
 		       struct dmar_domain *domain,
@@ -404,3 +498,21 @@ domain_bounce_unmap(struct dmar_domain *domain, dma_addr_t addr,
 	return domain_walk_addr_range(&walk_bounce_unmap, domain,
 				      addr, paddr, size, param);
 }
+
+int
+domain_bounce_sync_for_device(struct dmar_domain *domain, dma_addr_t addr,
+			      phys_addr_t paddr, size_t size,
+			      struct bounce_param *param)
+{
+	return domain_walk_addr_range(&walk_bounce_sync_for_device, domain,
+				      addr, paddr, size, param);
+}
+
+int
+domain_bounce_sync_for_cpu(struct dmar_domain *domain, dma_addr_t addr,
+			   phys_addr_t paddr, size_t size,
+			   struct bounce_param *param)
+{
+	return domain_walk_addr_range(&walk_bounce_sync_for_cpu, domain,
+				      addr, paddr, size, param);
+}
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 8b5ba91ab606..f4f313df7249 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -681,6 +681,12 @@ int domain_bounce_map(struct dmar_domain *domain, dma_addr_t addr,
 int domain_bounce_unmap(struct dmar_domain *domain, dma_addr_t addr,
 			phys_addr_t paddr, size_t size,
 			struct bounce_param *param);
+int domain_bounce_sync_for_device(struct dmar_domain *domain, dma_addr_t addr,
+				  phys_addr_t paddr, size_t size,
+				  struct bounce_param *param);
+int domain_bounce_sync_for_cpu(struct dmar_domain *domain, dma_addr_t addr,
+			       phys_addr_t paddr, size_t size,
+			       struct bounce_param *param);
 #ifdef CONFIG_INTEL_IOMMU_SVM
 int intel_svm_init(struct intel_iommu *iommu);
 extern int intel_svm_enable_prq(struct intel_iommu *iommu);
-- 
2.17.1
