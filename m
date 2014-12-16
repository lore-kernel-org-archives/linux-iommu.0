From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 04/10] iommu/ipmmu-vmsa: Return proper error if devm_request_irq fails
Date: Tue, 16 Dec 2014 15:44:11 +0200
Message-ID: <1418737457-22042-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1418737457-22042-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1418737457-22042-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
List-Id: iommu@lists.linux-foundation.org

From: Axel Lin <axel.lin@ingics.com>

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/ipmmu-vmsa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9838d119045d..70bb5ba2aa51 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1187,7 +1187,7 @@ static int ipmmu_probe(struct platform_device *pdev)
 			       dev_name(&pdev->dev), mmu);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to request IRQ %d\n", irq);
-		return irq;
+		return ret;
 	}
 
 	ipmmu_device_reset(mmu);
-- 
2.0.4

