From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/4] iommu/vt-d: Disable ATS support on untrusted devices
Date: Fri,  1 Mar 2019 11:23:10 +0800
Message-ID: <20190301032313.9311-2-baolu.lu@linux.intel.com>
References: <20190301032313.9311-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190301032313.9311-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Commit fb58fdcd295b9 ("iommu/vt-d: Do not enable ATS for untrusted
devices") disables ATS support on the devices which have been marked
as untrusted. Unfortunately this is not enough to fix the DMA attack
vulnerabiltiies because IOMMU driver allows translated requests as
long as a device advertises the ATS capability. Hence a malicious
peripheral device could use this to bypass IOMMU.

This disables the ATS support on untrusted devices by clearing the
internal per-device ATS mark. As the result, IOMMU driver will block
any translated requests from any device marked as untrusted.

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Fixes: fb58fdcd295b9 ("iommu/vt-d: Do not enable ATS for untrusted devices")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f8f6d46c60f4..abdd165a829c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2484,7 +2484,8 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	if (dev && dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(info->dev);
 
-		if (!pci_ats_disabled() &&
+		if (!pdev->untrusted &&
+		    !pci_ats_disabled() &&
 		    ecap_dev_iotlb_support(iommu->ecap) &&
 		    pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ATS) &&
 		    dmar_find_matched_atsr_unit(pdev))
-- 
2.17.1
