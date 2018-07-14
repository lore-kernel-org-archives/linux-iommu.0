From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 7/9] iommu/vt-d: Allocate and free pasid table
Date: Sat, 14 Jul 2018 15:47:00 +0800
Message-ID: <1531554422-6874-8-git-send-email-baolu.lu@linux.intel.com>
References: <1531554422-6874-1-git-send-email-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531554422-6874-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This patch allocates a PASID table for a PCI device at the time
when the dmar dev_info is attached to dev->archdata.iommu, and
free it in the opposite case.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/intel-iommu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a930918..baad27a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2508,6 +2508,15 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	list_add(&info->global, &device_domain_list);
 	if (dev)
 		dev->archdata.iommu = info;
+
+	if (dev && dev_is_pci(dev) && info->pasid_supported) {
+		ret = intel_pasid_alloc_table(dev);
+		if (ret) {
+			__dmar_remove_one_dev_info(info);
+			spin_unlock_irqrestore(&device_domain_lock, flags);
+			return NULL;
+		}
+	}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 	if (dev && domain_context_mapping(domain, dev)) {
@@ -4873,6 +4882,7 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 	if (info->dev) {
 		iommu_disable_dev_iotlb(info);
 		domain_context_clear(iommu, info->dev);
+		intel_pasid_free_table(info->dev);
 	}
 
 	unlink_domain_info(info);
-- 
2.7.4
