Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297EA7E
	for <iommu@lists.linux.dev>; Wed, 24 Aug 2022 06:44:15 +0000 (UTC)
X-UUID: 36e6bd7e16d440afb6d574e1f50dfa30-20220824
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5lwqlHiauGYRIVT5qVChvSGt58pXRA8aEXxMTgoP3+s=;
	b=EyLFKzFY66LqKMxY2QHjA5VIXINYRrv4TfhqnEg7lOVKp0nTHKyum4d/oR+uaPrvofdvn04mskF+s9xn/V5n5a7VVqEsWRDlVYWNobCepGNizJp/8q3Zcc2fcys6+UV8rdXv+ySThJCVpkHcbixiT4ld222leL+VGQcAo2bGX/Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:f4ed213a-2780-421e-b10a-3cd15e38eccf,OB:0,L
	OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
	Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:cb1a72cf-20bd-4e5e-ace8-00692b7ab380,C
	OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
	,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 36e6bd7e16d440afb6d574e1f50dfa30-20220824
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1882199171; Wed, 24 Aug 2022 14:44:09 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 24 Aug 2022 14:44:08 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Wed, 24 Aug 2022 14:44:07 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<iommu@lists.linux-foundation.org>, <linux-mediatek@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Yong
 Wu <yong.wu@mediatek.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <mingyuan.ma@mediatek.com>,
	<yf.wang@mediatek.com>, <libo.kang@mediatek.com>, <chengci.xu@mediatek.com>,
	<youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
	<xueqi.zhang@mediatek.com>, Guenter Roeck <groeck@chromium.org>, Dan
 Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v4 5/6] iommu/mediatek: Improve safety for mediatek,smi property in larb nodes
Date: Wed, 24 Aug 2022 14:43:05 +0800
Message-ID: <20220824064306.21495-6-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220824064306.21495-1-yong.wu@mediatek.com>
References: <20220824064306.21495-1-yong.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

No functional change. Just improve safety from dts.

All the larbs that connect to one IOMMU must connect with the same
smi-common. This patch checks all the mediatek,smi property for each
larb, If their mediatek,smi are different, it will return fails.
Also avoid there is no available smi-larb nodes.

Suggested-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 53 +++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 21195ac060f1..ea387c762509 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1040,7 +1040,7 @@ static const struct component_master_ops mtk_iommu_com_ops = {
 static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **match,
 				  struct mtk_iommu_data *data)
 {
-	struct device_node *larbnode, *smicomm_node, *smi_subcomm_node;
+	struct device_node *larbnode, *frst_avail_smicomm_node = NULL;
 	struct platform_device *plarbdev, *pcommdev;
 	struct device_link *link;
 	int i, larb_nr, ret;
@@ -1052,6 +1052,7 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 		return -EINVAL;
 
 	for (i = 0; i < larb_nr; i++) {
+		struct device_node *smicomm_node, *smi_subcomm_node;
 		u32 id;
 
 		larbnode = of_parse_phandle(dev->of_node, "mediatek,larbs", i);
@@ -1092,29 +1093,49 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
 			goto err_larbdev_put;
 		}
 
+		/* Get smi-(sub)-common dev from the last larb. */
+		smi_subcomm_node = of_parse_phandle(larbnode, "mediatek,smi", 0);
+		if (!smi_subcomm_node) {
+			ret = -EINVAL;
+			goto err_larbdev_put;
+		}
+
+		/*
+		 * It may have two level smi-common. the node is smi-sub-common if it
+		 * has a new mediatek,smi property. otherwise it is smi-commmon.
+		 */
+		smicomm_node = of_parse_phandle(smi_subcomm_node, "mediatek,smi", 0);
+		if (smicomm_node)
+			of_node_put(smi_subcomm_node);
+		else
+			smicomm_node = smi_subcomm_node;
+
+		/*
+		 * All the larbs that connect to one IOMMU must connect with the same
+		 * smi-common.
+		 */
+		if (!frst_avail_smicomm_node) {
+			frst_avail_smicomm_node = smicomm_node;
+		} else if (frst_avail_smicomm_node != smicomm_node) {
+			dev_err(dev, "mediatek,smi property is not right @larb%d.", id);
+			of_node_put(smicomm_node);
+			ret = -EINVAL;
+			goto err_larbdev_put;
+		} else {
+			of_node_put(smicomm_node);
+		}
+
 		component_match_add(dev, match, component_compare_dev, &plarbdev->dev);
 		platform_device_put(plarbdev);
 	}
 
-	/* Get smi-(sub)-common dev from the last larb. */
-	smi_subcomm_node = of_parse_phandle(larbnode, "mediatek,smi", 0);
-	if (!smi_subcomm_node) {
+	if (!frst_avail_smicomm_node) {
 		ret = -EINVAL;
 		goto err_larbdev_put;
 	}
 
-	/*
-	 * It may have two level smi-common. the node is smi-sub-common if it
-	 * has a new mediatek,smi property. otherwise it is smi-commmon.
-	 */
-	smicomm_node = of_parse_phandle(smi_subcomm_node, "mediatek,smi", 0);
-	if (smicomm_node)
-		of_node_put(smi_subcomm_node);
-	else
-		smicomm_node = smi_subcomm_node;
-
-	pcommdev = of_find_device_by_node(smicomm_node);
-	of_node_put(smicomm_node);
+	pcommdev = of_find_device_by_node(frst_avail_smicomm_node);
+	of_node_put(frst_avail_smicomm_node);
 	if (!pcommdev) {
 		ret = -EINVAL;
 		goto err_larbdev_put;
-- 
2.18.0

