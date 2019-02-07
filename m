From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v1 1/1] iommu/vt-d: Enable PRI only if the device enables PASID.
Date: Thu,  7 Feb 2019 10:44:19 -0800
Message-ID: <142748f6a00153f9926fe2a9dc30cf3cd89164cd.1549408090.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, dwmw2@infradead.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Intel IOMMU Page Request Services (PRS) only works with devices which
supports/uses PASID. So enable PRI only if the device also enables
PASID support. For more details, Please check the implementation of PRQ
handler(prq_event_thread()) in intel-svm driver.

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 1457f931218e..ef1a646e0993 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1402,7 +1402,8 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 	if (info->pasid_supported && !pci_enable_pasid(pdev, info->pasid_supported & ~1))
 		info->pasid_enabled = 1;
 
-	if (info->pri_supported && !pci_reset_pri(pdev) && !pci_enable_pri(pdev, 32))
+	if (info->pri_supported && info->pasid_enabled &&
+	    !pci_reset_pri(pdev) && !pci_enable_pri(pdev, 32))
 		info->pri_enabled = 1;
 #endif
 	if (!pdev->untrusted && info->ats_supported &&
-- 
2.20.1
