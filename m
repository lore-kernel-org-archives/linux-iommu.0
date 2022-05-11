Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA0BC433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 06:50:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B60782D45;
	Wed, 11 May 2022 06:50:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7sjKrLTgMWOO; Wed, 11 May 2022 06:50:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E425782422;
	Wed, 11 May 2022 06:50:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BCA33C0032;
	Wed, 11 May 2022 06:50:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11211C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 06:50:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DE3EB82D45
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 06:50:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ghv7U00C9cZ7 for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 06:50:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2D80182422
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 06:50:00 +0000 (UTC)
X-UUID: 314b861995304686a98d95f0eb5368d3-20220511
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4, REQID:4ab09c1c-dde3-41b9-9418-33fd4cc97169, OB:0,
 LO
 B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
 TION:release,TS:-20
X-CID-META: VersionHash:faefae9, CLOUDID:2d8e0fe6-38f2-431d-8de7-bf8fac490b0a,
 C
 OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 314b861995304686a98d95f0eb5368d3-20220511
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 896768295; Wed, 11 May 2022 14:49:54 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 11 May 2022 14:49:53 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 May 2022 14:49:52 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 May 2022 14:49:51 +0800
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Matthias
 Brugger" <matthias.bgg@gmail.com>
Subject: [PATCH 2/4] iommu/mediatek: Add error path for loop of mm_dts_parse
Date: Wed, 11 May 2022 14:49:18 +0800
Message-ID: <20220511064920.18455-3-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220511064920.18455-1-yong.wu@mediatek.com>
References: <20220511064920.18455-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: anan.sun@mediatek.com, chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
 linux-kernel@vger.kernel.org, libo.kang@mediatek.com, yf.wang@mediatek.com,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Guenter Roeck <groeck@chromium.org>, Dan
 Carpenter <dan.carpenter@oracle.com>, mingyuan.ma@mediatek.com,
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
larb is parsed fail(return -EINVAL), we should of_node_put for the 0..i
larbs.

Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with the MM TYPE")
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 0f6ec4a4d9d4..523bf59264e1 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1065,12 +1065,12 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 
 		plarbdev = of_find_device_by_node(larbnode);
 		if (!plarbdev) {
-			of_node_put(larbnode);
-			return -ENODEV;
+			ret = -ENODEV;
+			goto err_larbnode_put;
 		}
 		if (!plarbdev->dev.driver) {
-			of_node_put(larbnode);
-			return -EPROBE_DEFER;
+			ret = -EPROBE_DEFER;
+			goto err_larbnode_put;
 		}
 		data->larb_imu[id].dev = &plarbdev->dev;
 
@@ -1101,9 +1101,20 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 			       DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
 	if (!link) {
 		dev_err(dev, "Unable to link %s.\n", dev_name(data->smicomm_dev));
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_larbnode_put;
 	}
 	return 0;
+
+err_larbnode_put:
+	while (i--) {
+		larbnode = of_parse_phandle(dev->of_node, "mediatek,larbs", i);
+		if (larbnode && of_device_is_available(larbnode)) {
+			of_node_put(larbnode);
+			of_node_put(larbnode);
+		}
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
