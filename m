From: Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH] iommu/mediatek: fix leaked of_node references
Date: Wed, 17 Apr 2019 10:41:19 +0800
Message-ID: <1555468879-34684-1-git-send-email-wen.yang99@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>, Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

The call to of_parse_phandle returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

581 static int mtk_iommu_probe(struct platform_device *pdev)
582 {
    ...
626         for (i = 0; i < larb_nr; i++) {
627                 struct device_node *larbnode;
    ...
631                 larbnode = of_parse_phandle(...);
632                 if (!larbnode)
633                         return -EINVAL;
634
635                 if (!of_device_is_available(larbnode))
636                         continue;             ---> leaked here
637
    ...
643                 if (!plarbdev)
644                         return -EPROBE_DEFER; ---> leaked here
    ...
647                 component_match_add_release(dev, &match, release_of,
648                                             compare_of, larbnode);
                                   ---> release_of will call of_node_put
649         }
    ...
650

Detected by coccinelle with the following warnings:
./drivers/iommu/mtk_iommu.c:644:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 631, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/iommu/mtk_iommu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index de3e022..b66d11b 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -632,16 +632,20 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 		if (!larbnode)
 			return -EINVAL;
 
-		if (!of_device_is_available(larbnode))
+		if (!of_device_is_available(larbnode)) {
+			of_node_put(larbnode);
 			continue;
+		}
 
 		ret = of_property_read_u32(larbnode, "mediatek,larb-id", &id);
 		if (ret)/* The id is consecutive if there is no this property */
 			id = i;
 
 		plarbdev = of_find_device_by_node(larbnode);
-		if (!plarbdev)
+		if (!plarbdev) {
+			of_node_put(larbnode);
 			return -EPROBE_DEFER;
+		}
 		data->smi_imu.larb_imu[id].dev = &plarbdev->dev;
 
 		component_match_add_release(dev, &match, release_of,
-- 
2.9.5
