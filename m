From: Vaughan Cao <vaughan.cao@oracle.com>
Subject: [PATCH] remove duplicate checking code
Date: Fri, 16 May 2014 15:39:40 +0800
Message-ID: <1400225980-12797-1-git-send-email-vaughan.cao@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, vaughan.cao@oracle.com
List-Id: iommu@lists.linux-foundation.org

amd_iommu_rlookup_table[devid] != NULL is already guaranteed by check_device
called before, it's fine to attach device at this point.

Signed-off-by: Vaughan Cao <vaughan.cao@oracle.com>
---
 drivers/iommu/amd_iommu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index c949520..252851a 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3514,12 +3514,6 @@ int __init amd_iommu_init_passthrough(void)
 		dev_data = get_dev_data(&dev->dev);
 		dev_data->passthrough = true;
 
-		devid = get_device_id(&dev->dev);
-
-		iommu = amd_iommu_rlookup_table[devid];
-		if (!iommu)
-			continue;
-
 		attach_device(&dev->dev, pt_domain);
 	}
 
-- 
1.9.0
