From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v1 2/2] iommu/vt-d: Enable PASID only if device expects PASID in PRG response.
Date: Thu,  7 Feb 2019 10:37:59 -0800
Message-ID: <5fbcaf70a3686a1355fa81da03157e1e6c9dbf9e.1549479043.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1549479043.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1549479043.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bhelgaas@google.com, joro@8bytes.org, dwmw2@infradead.org
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, ashok.raj@intel.com, jacob.jun.pan@intel.com, keith.busch@intel.com, Jacob Pan <jacob.jun.pan@linux.intel.com>, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

In Intel IOMMU, if the Page Request Queue (PRQ) is full, it will
automatically respond to the device with a success message as a keep
alive. And when sending the success message, IOMMU will include PASID in
the response message when the page request has a PASID in request
message and It does not check against the PRG response PASID requirement
of the device before sending the response. Also, If the device receives the
PRG response with PASID when its not expecting it then the device behavior
is undefined. So enable PASID support only if device expects PASID in PRG
response message.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 1457f931218e..887847f08746 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1399,7 +1399,8 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 	   undefined. So always enable PASID support on devices which
 	   have it, even if we can't yet know if we're ever going to
 	   use it. */
-	if (info->pasid_supported && !pci_enable_pasid(pdev, info->pasid_supported & ~1))
+	if (info->pasid_supported && pci_pggrp_rsp_need_pasid(pdev) &&
+	    !pci_enable_pasid(pdev, info->pasid_supported & ~1))
 		info->pasid_enabled = 1;
 
 	if (info->pri_supported && !pci_reset_pri(pdev) && !pci_enable_pri(pdev, 32))
-- 
2.20.1
