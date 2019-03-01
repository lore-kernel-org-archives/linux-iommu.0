From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 3/4] iommu/vt-d: Fix NULL pointer reference in intel_svm_bind_mm()
Date: Fri,  1 Mar 2019 11:23:12 +0800
Message-ID: <20190301032313.9311-4-baolu.lu@linux.intel.com>
References: <20190301032313.9311-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190301032313.9311-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Intel IOMMU could be turned off with intel_iommu=off. If Intel
IOMMU is off,  the intel_iommu struct will not be initialized.
When device drivers call intel_svm_bind_mm(), the NULL pointer
reference will happen there.

Add dmar_disabled check to avoid NULL pointer reference.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reported-by: Dave Jiang <dave.jiang@intel.com>
Fixes: 2f26e0a9c9860 ("iommu/vt-d: Add basic SVM PASID support")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index c79540deaf00..3a4b09ae8561 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -234,7 +234,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 	int pasid_max;
 	int ret;
 
-	if (!iommu)
+	if (!iommu || dmar_disabled)
 		return -EINVAL;
 
 	if (dev_is_pci(dev)) {
-- 
2.17.1
