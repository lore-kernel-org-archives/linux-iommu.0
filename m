From: Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH 2/4] iommu/vt-d: Avoid calling virt_to_phys() on null pointer
Date: Tue,  8 Aug 2017 13:29:28 -0700
Message-ID: <1502224170-5344-3-git-send-email-ashok.raj@intel.com>
References: <1502224170-5344-1-git-send-email-ashok.raj@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502224170-5344-1-git-send-email-ashok.raj@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
Cc: Ashok Raj <ashok.raj@intel.com>, Huang Ying <ying.huang@intel.com>, Dave Hansen <dave.hansen@intel.com>, iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>, Jacob Pan <jacob.jun.pan@intel.com>
List-Id: iommu@lists.linux-foundation.org

New kernels with debug show panic() from __phys_addr() checks. Avoid
calling virt_to_phys()  when pasid_state_tbl pointer is null

To: Joerg Roedel <joro@8bytes.org>
To: linux-kernel@vger.kernel.org>
Cc: iommu@lists.linux-foundation.org
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Jacob Pan <jacob.jun.pan@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/intel-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 687f18f..5c6118d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5341,7 +5341,8 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sd
 	sdev->sid = PCI_DEVID(info->bus, info->devfn);
 
 	if (!(ctx_lo & CONTEXT_PASIDE)) {
-		context[1].hi = (u64)virt_to_phys(iommu->pasid_state_table);
+		if (iommu->pasid_state_table)
+			context[1].hi = (u64)virt_to_phys(iommu->pasid_state_table);
 		context[1].lo = (u64)virt_to_phys(iommu->pasid_table) |
 			intel_iommu_get_pts(iommu);
 
-- 
2.7.4
