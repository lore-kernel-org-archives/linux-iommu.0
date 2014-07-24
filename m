From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 1/3] iommu/ipmmu-vmsa: Cleanup failures of ARM mapping creation or attachment
Date: Thu, 24 Jul 2014 17:27:03 +0200
Message-ID: <1406215625-13982-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1406215625-13982-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1406215625-13982-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The ARM IOMMU mapping needs to be released when attaching the device
fails. Add arm_iommu_release_mapping() to the error code path. This is
safe to call with a NULL mapping, so no specific check is needed.

Cleanup is also missing when failing to create a mapping. Jump to the
error code path in that case instead of returning immediately.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/ipmmu-vmsa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 53cde08..7dc77a6 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1090,7 +1090,8 @@ static int ipmmu_add_device(struct device *dev)
 						   SZ_1G, SZ_2G);
 		if (IS_ERR(mapping)) {
 			dev_err(mmu->dev, "failed to create ARM IOMMU mapping\n");
-			return PTR_ERR(mapping);
+			ret = PTR_ERR(mapping);
+			goto error;
 		}
 
 		mmu->mapping = mapping;
@@ -1106,6 +1107,7 @@ static int ipmmu_add_device(struct device *dev)
 	return 0;
 
 error:
+	arm_iommu_release_mapping(mmu->mapping);
 	kfree(dev->archdata.iommu);
 	dev->archdata.iommu = NULL;
 	iommu_group_remove_device(dev);
-- 
1.8.5.5

