From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH] iommu/omap: Increase group ref in .device_group()
Date: Thu,  1 Mar 2018 19:22:08 +0800
Message-ID: <20180301112208.25284-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, Jeffy Chen <jeffy.chen@rock-chips.com>, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

Increase group refcounting in omap_iommu_device_group().

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/iommu/omap-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index e135ab830ebf..c33b7b104e72 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1536,7 +1536,7 @@ static struct iommu_group *omap_iommu_device_group(struct device *dev)
 	struct iommu_group *group = ERR_PTR(-EINVAL);
 
 	if (arch_data->iommu_dev)
-		group = arch_data->iommu_dev->group;
+		group = iommu_group_ref_get(arch_data->iommu_dev->group);
 
 	return group;
 }
-- 
2.11.0
