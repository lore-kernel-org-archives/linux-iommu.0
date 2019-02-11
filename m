From: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v2 2/2] iommu/vt-d: Enable ATS only if the device uses page aligned address.
Date: Mon, 11 Feb 2019 13:44:35 -0800
Message-ID: <457841852e067af6f02297b0d0bccbf66ed308b6.1549920354.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1549920354.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1549920354.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bhelgaas@google.com, joro@8bytes.org, dwmw2@infradead.org
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, ashok.raj@intel.com, jacob.jun.pan@intel.com, keith.busch@intel.com, Jacob Pan <jacob.jun.pan@linux.intel.com>, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

As per Intel vt-d specification, Rev 3.0 (section 7.5.1.1, title "Page
Request Descriptor"), Intel IOMMU page request descriptor only uses
bits[63:12] of the page address. Hence Intel IOMMU driver would only
permit devices that advertise they would only send page aligned requests
to participate in ATS service.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 1457f931218e..6a0b5270cd2e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1406,6 +1406,7 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 		info->pri_enabled = 1;
 #endif
 	if (!pdev->untrusted && info->ats_supported &&
+	    pci_ats_page_aligned(pdev) &&
 	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
 		info->ats_enabled = 1;
 		domain_update_iotlb(info->domain);
-- 
2.20.1
