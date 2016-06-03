From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH v2 3/3] iommu: convert DT component matching to
 component_match_add_release()
Date: Fri, 03 Jun 2016 15:21:30 +0100
Message-ID: <E1b8pyc-0005OV-7X@rmk-PC.armlinux.org.uk>
References: <20160603141548.GC1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20160603141548.GC1041@n2100.armlinux.org.uk>
Content-Disposition: inline
Sender: linux-arm-msm-owner@vger.kernel.org
To: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org
Cc: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

Convert DT component matching to use component_match_add_release().

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/iommu/mtk_iommu.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index c3043d8754e3..71cf62af4e24 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -24,6 +24,7 @@
 #include <linux/iopoll.h>
 #include <linux/list.h>
 #include <linux/of_address.h>
+#include <linux/of_component.h>
 #include <linux/of_iommu.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
@@ -552,11 +553,6 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 	return 0;
 }
 
-static int compare_of(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
 static int mtk_iommu_bind(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
@@ -630,17 +626,19 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 			continue;
 
 		plarbdev = of_find_device_by_node(larbnode);
-		of_node_put(larbnode);
 		if (!plarbdev) {
 			plarbdev = of_platform_device_create(
 						larbnode, NULL,
 						platform_bus_type.dev_root);
-			if (!plarbdev)
+			if (!plarbdev) {
+				of_node_put(larbnode);
 				return -EPROBE_DEFER;
+			}
 		}
 		data->smi_imu.larb_imu[i].dev = &plarbdev->dev;
 
-		component_match_add(dev, &match, compare_of, larbnode);
+		component_match_add_of(dev, &match, larbnode);
+		of_node_put(larbnode);
 	}
 
 	platform_set_drvdata(pdev, data);
-- 
2.1.0
