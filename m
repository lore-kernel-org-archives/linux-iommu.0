From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH] iommu/rockchip: Don't feed NULL res pointers to devres
Date: Mon, 21 Mar 2016 12:00:23 +0100
Message-ID: <1458558024-6922-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Joerg Roedel <joro@8bytes.org>, Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

If we do, devres prints a "invalid resource" string in the error
loglevel.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/iommu/rockchip-iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index a6f593a0a29e..0253ab35c33b 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1049,6 +1049,8 @@ static int rk_iommu_probe(struct platform_device *pdev)
 
 	for (i = 0; i < pdev->num_resources; i++) {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		if (!res)
+			continue;
 		iommu->bases[i] = devm_ioremap_resource(&pdev->dev, res);
 		if (IS_ERR(iommu->bases[i]))
 			continue;
-- 
2.5.0
