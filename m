From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 2/8] iommu/vt-d: Implement apply_resv_region iommu ops entry
Date: Mon, 29 Apr 2019 10:09:19 +0800
Message-ID: <20190429020925.18136-3-baolu.lu@linux.intel.com>
References: <20190429020925.18136-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190429020925.18136-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
Cc: ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, jamessewart@arista.com, tmurphy@arista.com, dima@arista.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: James Sewart <jamessewart@arista.com>

Used by iommu.c before creating identity mappings for reserved
ranges to ensure dma-ops won't ever remap these ranges.

Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/iommu/intel-iommu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index e0c0febc6fa5..af025955f1bc 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5568,6 +5568,19 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 	return ret;
 }
 
+static void intel_iommu_apply_resv_region(struct device *dev,
+					  struct iommu_domain *domain,
+					  struct iommu_resv_region *region)
+{
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	unsigned long start, end;
+
+	start = IOVA_PFN(region->start);
+	end   = IOVA_PFN(region->start + region->length - 1);
+
+	WARN_ON_ONCE(!reserve_iova(&dmar_domain->iovad, start, end));
+}
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
 {
@@ -5733,6 +5746,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.remove_device		= intel_iommu_remove_device,
 	.get_resv_regions	= intel_iommu_get_resv_regions,
 	.put_resv_regions	= intel_iommu_put_resv_regions,
+	.apply_resv_region	= intel_iommu_apply_resv_region,
 	.device_group		= pci_device_group,
 	.dev_has_feat		= intel_iommu_dev_has_feat,
 	.dev_feat_enabled	= intel_iommu_dev_feat_enabled,
-- 
2.17.1
