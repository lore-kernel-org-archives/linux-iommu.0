From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/2] iommu/vt-d: Set intel_iommu_gfx_mapped correctly
Date: Thu,  2 May 2019 09:34:25 +0800
Message-ID: <20190502013426.16989-2-baolu.lu@linux.intel.com>
References: <20190502013426.16989-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190502013426.16989-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, Zhenyu Wang <zhenyuw@linux.intel.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

The intel_iommu_gfx_mapped flag is exported by the Intel
IOMMU driver to indicate whether an IOMMU is used for the
graphic device. In a virtualized IOMMU environment (e.g.
QEMU), an include-all IOMMU is used for graphic device.
This flag is found to be clear even the IOMMU is used.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Reported-by: Zhenyu Wang <zhenyuw@linux.intel.com>
Fixes: c0771df8d5297 ("intel-iommu: Export a flag indicating that the IOMMU is used for iGFX.")
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index e0c0febc6fa5..00ad00193883 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4068,9 +4068,7 @@ static void __init init_no_remapping_devices(void)
 
 		/* This IOMMU has *only* gfx devices. Either bypass it or
 		   set the gfx_mapped flag, as appropriate */
-		if (dmar_map_gfx) {
-			intel_iommu_gfx_mapped = 1;
-		} else {
+		if (!dmar_map_gfx) {
 			drhd->ignored = 1;
 			for_each_active_dev_scope(drhd->devices,
 						  drhd->devices_cnt, i, dev)
@@ -4909,6 +4907,9 @@ int __init intel_iommu_init(void)
 		goto out_free_reserved_range;
 	}
 
+	if (dmar_map_gfx)
+		intel_iommu_gfx_mapped = 1;
+
 	init_no_remapping_devices();
 
 	ret = init_dmars();
-- 
2.17.1
