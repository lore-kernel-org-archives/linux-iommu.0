Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709FC139C
	for <iommu@lists.linux.dev>; Tue, 18 Oct 2022 02:43:25 +0000 (UTC)
X-UUID: d5acd4af86e84a64b4566d7f4736bd2e-20221018
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jwVUbslhKg59sz0HgwmYe44pWQN1yyoqiDnapSp3f4k=;
	b=PFokEMHnC6tUfI1eOa8Y6KCVTMaq0CR9yZupS+32a8yfZ/9eOZn8ZXOpsjMSc1VRYnkgCn/eQ4aIqqUyvE5yq39UJtEPWBEfhm34Zu6DMtg++Vk9/ZBXCJVseYHpxkyTQWnOhVZNi1C0y07oPQ6yKFQtsl7TxyPEKmBLvr7nbYs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:c2be3c29-36ed-43c1-888b-32c1e7752fad,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:90
X-CID-INFO: VERSION:1.1.11,REQID:c2be3c29-36ed-43c1-888b-32c1e7752fad,IP:0,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
	N:quarantine,TS:90
X-CID-META: VersionHash:39a5ff1,CLOUDID:596e93ee-314c-4293-acb8-ca4299dd021f,B
	ulkID:221018104320P1ZWC64K,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
	il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: d5acd4af86e84a64b4566d7f4736bd2e-20221018
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1574200757; Tue, 18 Oct 2022 10:43:18 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 18 Oct 2022 10:43:17 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 18 Oct 2022 10:43:16 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-mediatek@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Yong Wu <yong.wu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<mingyuan.ma@mediatek.com>, <yf.wang@mediatek.com>, <libo.kang@mediatek.com>,
	<chengci.xu@mediatek.com>, <youlin.pei@mediatek.com>,
	<anan.sun@mediatek.com>, <xueqi.zhang@mediatek.com>, Guenter Roeck
	<groeck@chromium.org>, Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v7 1/6] iommu/mediatek: Add platform_device_put for recovering the device refcnt
Date: Tue, 18 Oct 2022 10:42:53 +0800
Message-ID: <20221018024258.19073-2-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221018024258.19073-1-yong.wu@mediatek.com>
References: <20221018024258.19073-1-yong.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Add platform_device_put to match with of_find_device_by_node.

Meanwhile, I add a new variable "pcommdev" which is for smi common device.
Otherwise, "platform_device_put(plarbdev)" for smi-common dev may be not
readable. And add a checking for whether pcommdev is NULL.

Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with the MM TYPE")
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 5a4e00e4bbbc..3189b585725f 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1043,7 +1043,7 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 				  struct mtk_iommu_data *data)
 {
 	struct device_node *larbnode, *smicomm_node, *smi_subcomm_node;
-	struct platform_device *plarbdev;
+	struct platform_device *plarbdev, *pcommdev;
 	struct device_link *link;
 	int i, larb_nr, ret;
 
@@ -1074,12 +1074,14 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 		}
 		if (!plarbdev->dev.driver) {
 			of_node_put(larbnode);
+			platform_device_put(plarbdev);
 			return -EPROBE_DEFER;
 		}
 		data->larb_imu[id].dev = &plarbdev->dev;
 
 		component_match_add_release(dev, match, component_release_of,
 					    component_compare_of, larbnode);
+		platform_device_put(plarbdev);
 	}
 
 	/* Get smi-(sub)-common dev from the last larb. */
@@ -1097,12 +1099,15 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 	else
 		smicomm_node = smi_subcomm_node;
 
-	plarbdev = of_find_device_by_node(smicomm_node);
+	pcommdev = of_find_device_by_node(smicomm_node);
 	of_node_put(smicomm_node);
-	data->smicomm_dev = &plarbdev->dev;
+	if (!pcommdev)
+		return -ENODEV;
+	data->smicomm_dev = &pcommdev->dev;
 
 	link = device_link_add(data->smicomm_dev, dev,
 			       DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
+	platform_device_put(pcommdev);
 	if (!link) {
 		dev_err(dev, "Unable to link %s.\n", dev_name(data->smicomm_dev));
 		return -EINVAL;
-- 
2.18.0

