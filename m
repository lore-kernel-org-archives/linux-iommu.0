From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 2/3] iommu/shmobile: Don't ignore the ipmmu_iommu_init() return value
Date: Thu,  3 Apr 2014 01:49:21 +0200
Message-ID: <1396482562-1851-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1396482562-1851-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1396482562-1851-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The function can fail, don't ignore its error value.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/shmobile-ipmmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/shmobile-ipmmu.c b/drivers/iommu/shmobile-ipmmu.c
index e3bc2e1..6ba6110 100644
--- a/drivers/iommu/shmobile-ipmmu.c
+++ b/drivers/iommu/shmobile-ipmmu.c
@@ -117,8 +117,7 @@ static int ipmmu_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ipmmu);
 	ipmmu_reg_write(ipmmu, IMCTR1, 0x0); /* disable TLB */
 	ipmmu_reg_write(ipmmu, IMCTR2, 0x0); /* disable PMB */
-	ipmmu_iommu_init(ipmmu);
-	return 0;
+	return ipmmu_iommu_init(ipmmu);
 }
 
 static struct platform_driver ipmmu_driver = {
-- 
1.8.3.2

