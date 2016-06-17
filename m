From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu/vt-d: Enable QI on all IOMMUs before setting root entry
Date: Fri, 17 Jun 2016 11:41:31 +0200
Message-ID: <1466156491-593-1-git-send-email-joro@8bytes.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

This seems to be required on some X58 chipsets on systems
with more than one IOMMU. QI does not work until it is
enabled on all IOMMUs in the system.

Reported-by: Dheeraj CVR <cvr.dheeraj@gmail.com>
Tested-by: Dheeraj CVR <cvr.dheeraj@gmail.com>
Fixes: 5f0a7f7614a9 ('iommu/vt-d: Make root entry visible for hardware right after allocation')
Cc: stable@vger.kernel.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel-iommu.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a644d0c..1070094 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3222,11 +3222,6 @@ static int __init init_dmars(void)
 			}
 		}
 
-		iommu_flush_write_buffer(iommu);
-		iommu_set_root_entry(iommu);
-		iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
-		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
-
 		if (!ecap_pass_through(iommu->ecap))
 			hw_pass_through = 0;
 #ifdef CONFIG_INTEL_IOMMU_SVM
@@ -3235,6 +3230,18 @@ static int __init init_dmars(void)
 #endif
 	}
 
+	/*
+	 * Now that qi is enabled on all iommus, set the root entry and flush
+	 * caches. This is required on some Intel X58 chipsets, otherwise the
+	 * flush_context function will loop forever and the boot hangs.
+	 */
+	for_each_active_iommu(iommu, drhd) {
+		iommu_flush_write_buffer(iommu);
+		iommu_set_root_entry(iommu);
+		iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
+		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
+	}
+
 	if (iommu_pass_through)
 		iommu_identity_mapping |= IDENTMAP_ALL;
 
-- 
2.6.6
