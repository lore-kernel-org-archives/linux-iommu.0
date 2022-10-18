Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F23C1852
	for <iommu@lists.linux.dev>; Tue, 18 Oct 2022 02:43:47 +0000 (UTC)
X-UUID: 0342d1e47c5142f393f18d683981a361-20221018
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=KNetZl/o2JnPeD3E+CZiSVznpIXZE73PG4SwXrc1kJQ=;
	b=gw07ymVeq2l7OIDajuf1tEFx9DSA+F7GWo5Ah+ghNPDLOzFDvkaa9b0KKa8phHMf+UV6iUMgsN6J2Ho9dubC3xWk/+SqYzGPMMirg5TLYpLWFhDWVa4eePzK+L3hT3oVWampBkQtgZHcQ0tRyNvyNt3BQgT1D+uni/FJZci0ZbM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:ecf00dfc-66a4-4593-9543-3e95ce17ba79,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:70
X-CID-INFO: VERSION:1.1.11,REQID:ecf00dfc-66a4-4593-9543-3e95ce17ba79,IP:0,URL
	:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
	ON:quarantine,TS:70
X-CID-META: VersionHash:39a5ff1,CLOUDID:f7ef18a4-ebb2-41a8-a87c-97702aaf2e20,B
	ulkID:221018104344NXHIJVHW,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
	il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 0342d1e47c5142f393f18d683981a361-20221018
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
	with ESMTP id 1367881281; Tue, 18 Oct 2022 10:43:42 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 18 Oct 2022 10:43:41 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 18 Oct 2022 10:43:40 +0800
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
Subject: [PATCH v7 4/6] iommu/mediatek: Validate number of phandles associated with "mediatek,larbs"
Date: Tue, 18 Oct 2022 10:42:56 +0800
Message-ID: <20221018024258.19073-5-yong.wu@mediatek.com>
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
index 912322494bc0..9cbff48f03c0 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1050,6 +1050,8 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 	larb_nr = of_count_phandle_with_args(dev->of_node, "mediatek,larbs", NULL);
 	if (larb_nr < 0)
 		return larb_nr;
+	if (larb_nr == 0 || larb_nr > MTK_LARB_NR_MAX)
+		return -EINVAL;
 
 	for (i = 0; i < larb_nr; i++) {
 		u32 id;
@@ -1068,6 +1070,11 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
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
@@ -1075,6 +1082,11 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
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

