Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F6510FA
	for <iommu@lists.linux.dev>; Tue, 20 Sep 2022 06:38:28 +0000 (UTC)
X-UUID: 7c66e3c42c9c4b77a69465e575daecad-20220920
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=zgj5CYWKZgJbAqXHgzBhGuk8A4h8FTDoZLTDoeqVF3E=;
	b=i1vn1op1fN7oLLhEMN02ecoik5s0N2p9w7BGi1P6NFKNGpxTjvZt8RV/kY8VvYy+1fw1zn1w41V/GBfBq0xYxVHJqAn7GZTvwIliFDZL8A/7vcJa5rDuWvte71CG0bf0vfMbbROTTnmoPfZQVyLOVM/e/MTL+a71ynsRqBuCuFY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:93b74ec1-49e5-4970-b96a-27e080c897c5,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:70
X-CID-INFO: VERSION:1.1.11,REQID:93b74ec1-49e5-4970-b96a-27e080c897c5,IP:0,URL
	:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
	ON:quarantine,TS:70
X-CID-META: VersionHash:39a5ff1,CLOUDID:15743e5e-5ed4-4e28-8b00-66ed9f042fbd,B
	ulkID:220919172525OOGGNNFJ,BulkQuantity:66,Recheck:0,SF:28|17|19|48|823|82
	4,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:41,QS:nil,BEC:nil,COL
	:0
X-UUID: 7c66e3c42c9c4b77a69465e575daecad-20220920
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
	with ESMTP id 1071668000; Tue, 20 Sep 2022 14:38:23 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 20 Sep 2022 14:38:21 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Sep 2022 14:38:20 +0800
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
Subject: [PATCH v6 4/6] iommu/mediatek: Validate number of phandles associated with "mediatek,larbs"
Date: Tue, 20 Sep 2022 14:37:31 +0800
Message-ID: <20220920063733.21770-5-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220920063733.21770-1-yong.wu@mediatek.com>
References: <20220920063733.21770-1-yong.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Guenter Roeck <groeck@chromium.org>

Fix the smatch warnings:
drivers/iommu/mtk_iommu.c:878 mtk_iommu_mm_dts_parse() error: uninitialized
symbol 'larbnode'.

If someone abuse the dtsi node(Don't follow the definition of dt-binding),
for example "mediatek,larbs" is provided as boolean property, "larb_nr"
will be zero and cause abnormal.

To fix this problem and improve the code safety, add some checking
for the invalid input from dtsi, e.g. checking the larb_nr/larbid valid
range, and avoid "mediatek,larb-id" property conflicts in the smi-larb
nodes.

Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with the MM TYPE")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 97b721006a47..01b31b09bd8d 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1048,6 +1048,8 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 	larb_nr = of_count_phandle_with_args(dev->of_node, "mediatek,larbs", NULL);
 	if (larb_nr < 0)
 		return larb_nr;
+	if (larb_nr == 0 || larb_nr > MTK_LARB_NR_MAX)
+		return -EINVAL;
 
 	for (i = 0; i < larb_nr; i++) {
 		u32 id;
@@ -1066,6 +1068,11 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 		ret = of_property_read_u32(larbnode, "mediatek,larb-id", &id);
 		if (ret)/* The id is consecutive if there is no this property */
 			id = i;
+		if (id >= MTK_LARB_NR_MAX) {
+			of_node_put(larbnode);
+			ret = -EINVAL;
+			goto err_larbdev_put;
+		}
 
 		plarbdev = of_find_device_by_node(larbnode);
 		of_node_put(larbnode);
@@ -1073,6 +1080,11 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 			ret = -ENODEV;
 			goto err_larbdev_put;
 		}
+		if (data->larb_imu[id].dev) {
+			platform_device_put(plarbdev);
+			ret = -EEXIST;
+			goto err_larbdev_put;
+		}
 		data->larb_imu[id].dev = &plarbdev->dev;
 
 		if (!plarbdev->dev.driver) {
-- 
2.18.0

