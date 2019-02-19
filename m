From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v3 2/2] iommu/vt-d: Fix PRI/PASID dependency issue.
Date: Tue, 19 Feb 2019 11:04:52 -0800
Message-ID: <e08a4c3d02c4135ed53946d3a70a277dc2eb42bd.1550602470.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1550602470.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1550602470.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bhelgaas@google.com, joro@8bytes.org, dwmw2@infradead.org
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, ashok.raj@intel.com, jacob.jun.pan@intel.com, keith.busch@intel.com, Jacob Pan <jacob.jun.pan@linux.intel.com>, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

In Intel IOMMU, if the Page Request Queue (PRQ) is full, it will
automatically respond to the device with a success message as a keep
alive. And when sending the success message, IOMMU will include PASID in
the Response Message when the Page Request has a PASID in Request
Message and it does not check against the PRG Response PASID requirement
of the device before sending the response. Also, if the device receives
the PRG response with PASID when its not expecting it the device behavior
is undefined. So if PASID is enabled in the device, enable PRI only if
device expects PASID in PRG Response Message.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 78188bf7e90d..5b174c09b80d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1402,7 +1402,9 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 	if (info->pasid_supported && !pci_enable_pasid(pdev, info->pasid_supported & ~1))
 		info->pasid_enabled = 1;
 
-	if (info->pri_supported && !pci_reset_pri(pdev) && !pci_enable_pri(pdev, 32))
+	if (info->pri_supported &&
+	    (info->pasid_enabled ? pci_prg_resp_pasid_required(pdev) : 1)  &&
+	    !pci_reset_pri(pdev) && !pci_enable_pri(pdev, 32))
 		info->pri_enabled = 1;
 #endif
 	if (!pdev->untrusted && info->ats_supported &&
-- 
2.20.1
