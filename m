From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Flush IOTLB for untrusted device in time
Date: Fri, 12 Apr 2019 12:26:13 +0800
Message-ID: <20190412042613.20257-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
Cc: ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, mika.westerberg@linux.intel.com, pengfei.xu@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

By default, for performance consideration, Intel IOMMU
driver won't flush IOTLB immediately after a buffer is
unmapped. It schedules a thread and flushes IOTLB in a
batched mode. This isn't suitable for untrusted device
since it still can access the memory even if it isn't
supposed to do so.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Xu Pengfei <pengfei.xu@intel.com>
Tested-by: Mika Westerberg <mika.westerberg@intel.com>
---
 drivers/iommu/intel-iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index c137f0f2cf49..3d504b685dd8 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3732,10 +3732,14 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
 	unsigned long iova_pfn;
 	struct intel_iommu *iommu;
 	struct page *freelist;
+	struct pci_dev *pdev = NULL;
 
 	if (iommu_no_mapping(dev))
 		return;
 
+	if (dev_is_pci(dev))
+		pdev = to_pci_dev(dev);
+
 	domain = find_domain(dev);
 	BUG_ON(!domain);
 
@@ -3751,7 +3755,7 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
 
 	freelist = domain_unmap(domain, start_pfn, last_pfn);
 
-	if (intel_iommu_strict) {
+	if (intel_iommu_strict || (pdev && pdev->untrusted)) {
 		iommu_flush_iotlb_psi(iommu, domain, start_pfn,
 				      nrpages, !freelist, 0);
 		/* free iova */
-- 
2.17.1
