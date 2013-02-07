From: Shuah Khan <shuah.khan@hp.com>
Subject: [PATCH] amd_iommu: IO_PAGE_FAULTs on unity mapped regions during
 amd_iommu_init()
Date: Wed, 06 Feb 2013 19:45:28 -0700
Message-ID: <1360205128.2615.14.camel@lorien2>
Reply-To: shuah.khan@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, stable <stable@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, shuahkhan@gmail.com
List-Id: iommu@lists.linux-foundation.org

When dma_ops are initialized the unity mappings are created. The
init_device_table_dma() function makes sure DMA from all devices is
blocked by default. This opens a short window in time where DMA to
unity mapped regions is blocked by the IOMMU. Make sure this does not
happen by initializing the device table after dma_ops.

Signed-off-by: Shuah Khan <shuah.khan@hp.com>
CC: stable@vger.kernel.org 3.4
---
 drivers/iommu/amd_iommu_init.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index ef0ae93..b573f80 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1572,8 +1572,6 @@ int __init amd_iommu_init_hardware(void)
 	if (amd_iommu_pd_alloc_bitmap == NULL)
 		goto free;
 
-	/* init the device table */
-	init_device_table();
 
 	/*
 	 * let all alias entries point to itself
@@ -1655,6 +1653,7 @@ out:
  */
 static int __init amd_iommu_init(void)
 {
+	struct amd_iommu *iommu;
 	int ret = 0;
 
 	ret = amd_iommu_init_hardware();
@@ -1673,6 +1672,12 @@ static int __init amd_iommu_init(void)
 	if (ret)
 		goto free;
 
+	/* init the device table */
+	init_device_table();
+
+	for_each_iommu(iommu)
+		iommu_flush_all_caches(iommu);
+
 	amd_iommu_init_api();
 
 	x86_platform.iommu_shutdown = disable_iommus;
-- 
1.7.9.5
