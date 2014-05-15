From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 02/10] iommu/ipmmu-vmsa: Cleanup failures of ARM mapping creation or attachment
Date: Thu, 15 May 2014 12:40:43 +0200
Message-ID: <1400150451-13469-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1400150451-13469-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1400150451-13469-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/ipmmu-vmsa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 49e00f7..49dbedd 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -917,7 +917,8 @@ static int ipmmu_add_device(struct device *dev)
 							SZ_1G, SZ_2G);
 		if (IS_ERR(mapping)) {
 			dev_err(mmu->dev, "failed to create ARM IOMMU mapping\n");
-			return PTR_ERR(mapping);
+			ret = PTR_ERR(mapping);
+			goto error;
 		}
 
 		mmu->mapping = mapping;
@@ -933,6 +934,7 @@ static int ipmmu_add_device(struct device *dev)
 	return 0;
 
 error:
+	arm_iommu_release_mapping(mmu->mapping);
 	kfree(dev->archdata.iommu);
 	dev->archdata.iommu = NULL;
 	iommu_group_remove_device(dev);
-- 
1.8.5.5

