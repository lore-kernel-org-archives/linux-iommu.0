From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 4/4] iommu/vt-d: Remove unnecessary parentheses
Date: Fri,  4 May 2018 13:08:19 +0800
Message-ID: <1525410499-18632-5-git-send-email-baolu.lu@linux.intel.com>
References: <1525410499-18632-1-git-send-email-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525410499-18632-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Remove unnecessary parentheses to comply with preferred coding
style.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index e8cd984..45f6e58 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -319,7 +319,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 	} else
 		pasid_max = 1 << 20;
 
-	if ((flags & SVM_FLAG_SUPERVISOR_MODE)) {
+	if (flags & SVM_FLAG_SUPERVISOR_MODE) {
 		if (!ecap_srs(iommu->ecap))
 			return -EINVAL;
 	} else if (pasid) {
-- 
2.7.4
