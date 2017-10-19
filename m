From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 3/3] iommu/vt-d: Clear pasid table entry when memory unbound
Date: Thu, 19 Oct 2017 08:39:16 +0800
Message-ID: <1508373556-5340-3-git-send-email-baolu.lu@linux.intel.com>
References: <1508373556-5340-1-git-send-email-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1508373556-5340-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, dwmw2@infradead.org
Cc: ashok.raj@intel.com, jacob.jun.pan@linux.intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

In intel_svm_unbind_mm(), pasid table entry must be cleared during
svm free. Otherwise, hardware may be set up with a wild pointer.

Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-svm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 43280ca..ed1cf7c 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -458,6 +458,8 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
 				kfree_rcu(sdev, rcu);
 
 				if (list_empty(&svm->devs)) {
+					svm->iommu->pasid_table[svm->pasid].val = 0;
+					wmb();
 
 					idr_remove(&svm->iommu->pasid_idr, svm->pasid);
 					if (svm->mm)
-- 
2.7.4
