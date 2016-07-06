From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu/amd: Fix unity mapping initialization race
Date: Wed,  6 Jul 2016 18:00:22 +0200
Message-ID: <1467820838-5059-1-git-send-email-joro@8bytes.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

There is a race condition in the AMD IOMMU init code that
causes requested unity mappings to be blocked by the IOMMU
for a short period of time. This results on boot failures
and IO_PAGE_FAULTs on some machines.

Fix this by making sure the unity mappings are installed
before all other DMA is blocked.

Fixes: aafd8ba0ca74 ('iommu/amd: Implement add_device and remove_device')
Cc: stable@vger.kernel.org # v4.2+
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu_init.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index d091def..59741ea 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1568,13 +1568,23 @@ static int __init amd_iommu_init_pci(void)
 			break;
 	}
 
+	/*
+	 * Order is important here to make sure any unity map requirements are
+	 * fulfilled. The unity mappings are created and written to the device
+	 * table during the amd_iommu_init_api() call.
+	 *
+	 * After that we call init_device_table_dma() to make sure any
+	 * uninitialized DTE will block DMA, and in the end we flush the caches
+	 * of all IOMMUs to make sure the changes to the device table are
+	 * active.
+	 */
+	ret = amd_iommu_init_api();
+
 	init_device_table_dma();
 
 	for_each_iommu(iommu)
 		iommu_flush_all_caches(iommu);
 
-	ret = amd_iommu_init_api();
-
 	if (!ret)
 		print_iommu_info();
 
-- 
2.6.6
