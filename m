Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A1AC43334
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 05:40:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4870360E88;
	Fri,  1 Jul 2022 05:40:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4870360E88
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R996pucXiXpN; Fri,  1 Jul 2022 05:40:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 299676080B;
	Fri,  1 Jul 2022 05:40:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 299676080B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05785C002D;
	Fri,  1 Jul 2022 05:40:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 283C1C0011
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 05:40:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0244983F9F
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 05:40:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0244983F9F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yNFGgHV_FAwI for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 05:40:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F179983F9D
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F179983F9D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 05:40:39 +0000 (UTC)
X-UUID: 4937f43bb9724050aea693bd2b691635-20220701
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7, REQID:9bee874b-6e77-4d75-aa88-882cbaf73fff, OB:0,
 LO
 B:10,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
 CTION:release,TS:90
X-CID-INFO: VERSION:1.1.7, REQID:9bee874b-6e77-4d75-aa88-882cbaf73fff, OB:0,
 LOB:
 10,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
 CTION:quarantine,TS:90
X-CID-META: VersionHash:87442a2, CLOUDID:35822163-0b3f-4b2c-b3a6-ed5c044366a0,
 C
 OID:0292a48f776b,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
 RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 4937f43bb9724050aea693bd2b691635-20220701
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1512186341; Fri, 01 Jul 2022 13:40:35 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Fri, 1 Jul 2022 13:40:34 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 1 Jul 2022 13:40:32 +0800
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Will Deacon <will@kernel.org>
Subject: [PATCH v3 4/7] iommu/mediatek: Add error path for loop of mm_dts_parse
Date: Fri, 1 Jul 2022 13:39:39 +0800
Message-ID: <20220701053942.3266-5-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220701053942.3266-1-yong.wu@mediatek.com>
References: <20220701053942.3266-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: anan.sun@mediatek.com, chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
 iommu@lists.linux.dev, libo.kang@mediatek.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, yf.wang@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Guenter Roeck <groeck@chromium.org>, Dan Carpenter <dan.carpenter@oracle.com>,
 mingyuan.ma@mediatek.com,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Yong Wu via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yong Wu <yong.wu@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The mtk_iommu_mm_dts_parse will parse the smi larbs nodes. if the i+1
larb is parsed fail, we should put_device for the 0..i larbs.

There are two places need to comment:
1) The larbid may be not linear mapping, we should loop whole
   the array in the error path.
2) I move this line position: "data->larb_imu[id].dev = &plarbdev->dev;"
   That means set data->larb_imu[id].dev before the error path.
   then we don't need "platform_device_put(plarbdev)" again while
   probe_defer case. All depend on "put_device" in the error path in error
   cases.

Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with the MM TYPE")
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 42 ++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 3da8c6252c2c..aa0973bafde1 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1057,8 +1057,10 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 		u32 id;
 
 		larbnode = of_parse_phandle(dev->of_node, "mediatek,larbs", i);
-		if (!larbnode)
-			return -EINVAL;
+		if (!larbnode) {
+			ret = -EINVAL;
+			goto err_larbdev_put;
+		}
 
 		if (!of_device_is_available(larbnode)) {
 			of_node_put(larbnode);
@@ -1071,14 +1073,16 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 
 		plarbdev = of_find_device_by_node(larbnode);
 		of_node_put(larbnode);
-		if (!plarbdev)
-			return -ENODEV;
+		if (!plarbdev) {
+			ret = -ENODEV;
+			goto err_larbdev_put;
+		}
+		data->larb_imu[id].dev = &plarbdev->dev;
 
 		if (!plarbdev->dev.driver) {
-			platform_device_put(plarbdev);
-			return -EPROBE_DEFER;
+			ret = -EPROBE_DEFER;
+			goto err_larbdev_put;
 		}
-		data->larb_imu[id].dev = &plarbdev->dev;
 
 		component_match_add(dev, match, component_compare_dev, &plarbdev->dev);
 		platform_device_put(plarbdev);
@@ -1086,8 +1090,10 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 
 	/* Get smi-(sub)-common dev from the last larb. */
 	smi_subcomm_node = of_parse_phandle(larbnode, "mediatek,smi", 0);
-	if (!smi_subcomm_node)
-		return -EINVAL;
+	if (!smi_subcomm_node) {
+		ret = -EINVAL;
+		goto err_larbdev_put;
+	}
 
 	/*
 	 * It may have two level smi-common. the node is smi-sub-common if it
@@ -1101,8 +1107,10 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 
 	pcommdev = of_find_device_by_node(smicomm_node);
 	of_node_put(smicomm_node);
-	if (!pcommdev)
-		return -EINVAL;
+	if (!pcommdev) {
+		ret = -EINVAL;
+		goto err_larbdev_put;
+	}
 	data->smicomm_dev = &pcommdev->dev;
 
 	link = device_link_add(data->smicomm_dev, dev,
@@ -1110,9 +1118,19 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 	platform_device_put(pcommdev);
 	if (!link) {
 		dev_err(dev, "Unable to link %s.\n", dev_name(data->smicomm_dev));
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_larbdev_put;
 	}
 	return 0;
+
+err_larbdev_put:
+	/* id may be not linear mapping, loop whole the array */
+	for (i = 0; i < MTK_LARB_NR_MAX; i++) {
+		if (!data->larb_imu[i].dev)
+			continue;
+		put_device(data->larb_imu[i].dev);
+	}
+	return ret;
 }
 
 static int mtk_iommu_probe(struct platform_device *pdev)
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
