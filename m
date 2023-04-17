Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EC01848
	for <iommu@lists.linux.dev>; Mon, 17 Apr 2023 07:37:43 +0000 (UTC)
X-UUID: b9db8a30dcf211edb6b9f13eb10bd0fe-20230417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=DQv2qOPx5dYPZdNgHn6YjWMVC72EGZL4V7OLMRx5WoA=;
	b=l0yYBaQkBpdjhIZhwTXm1UfCbO80DkHRKg+oPYZF7/Iszmfx4U0t/YxIJEBKdICqIjo4JVHtbnijGPwUDS/2ygr6fPU6YxgW5V57+MXX3BF7Q1FbpwtUe0m/qBcA1QP/ZnLQ20VNQgcqSF/99W5V+O19jPBV1PGjnCjwhgt2mXE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:328d42d7-baf5-4b12-8e9b-6949e008d987,IP:0,U
	RL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:75
X-CID-INFO: VERSION:1.1.22,REQID:328d42d7-baf5-4b12-8e9b-6949e008d987,IP:0,URL
	:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
	ON:quarantine,TS:75
X-CID-META: VersionHash:120426c,CLOUDID:404133eb-db6f-41fe-8b83-13fe7ed1ef52,B
	ulkID:230417153738YML1T4G9,BulkQuantity:0,Recheck:0,SF:17|19|48|38|29|28,T
	C:nil,Content:1,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: b9db8a30dcf211edb6b9f13eb10bd0fe-20230417
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1793255066; Mon, 17 Apr 2023 15:37:37 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 17 Apr 2023 15:37:36 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 17 Apr 2023 15:37:35 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Rob Herring
	<robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
CC: Robin Murphy <robin.murphy@arm.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Yong Wu <yong.wu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <mingyuan.ma@mediatek.com>,
	<yf.wang@mediatek.com>, <jianjiao.zeng@mediatek.com>,
	<chengci.xu@mediatek.com>
Subject: [PATCH v10 6/7] iommu/mediatek: mt8188: Add iova_region_larb_msk
Date: Mon, 17 Apr 2023 15:36:05 +0800
Message-ID: <20230417073606.25729-7-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417073606.25729-1-yong.wu@mediatek.com>
References: <20230417073606.25729-1-yong.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Add iova_region_larb_msk for mt8188. We separate the 16GB iova regions
by each device's larbid/portid.
Refer to include/dt-bindings/memory/mediatek,mt8188-memory-port.h

As commented in the code, larb19(21) means it's larb19 while its SW index
is 21.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index fa46c4309f35..876624f807d6 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1599,6 +1599,20 @@ static const struct mtk_iommu_plat_data mt8188_data_infra = {
 	.iova_region_nr   = ARRAY_SIZE(single_domain),
 };
 
+static const u32 mt8188_larb_region_msk[MT8192_MULTI_REGION_NR_MAX][MTK_LARB_NR_MAX] = {
+	[0] = {~0, ~0, ~0, ~0},               /* Region0: all ports for larb0/1/2/3 */
+	[1] = {0, 0, 0, 0, 0, 0, 0, 0,
+	       0, 0, 0, 0, 0, 0, 0, 0,
+	       0, 0, 0, 0, 0, ~0, ~0, ~0},    /* Region1: larb19(21)/21(22)/23 */
+	[2] = {0, 0, 0, 0, ~0, ~0, ~0, ~0,    /* Region2: the other larbs. */
+	       ~0, ~0, ~0, ~0, ~0, ~0, ~0, ~0,
+	       ~0, ~0, ~0, ~0, ~0, 0, 0, 0,
+	       0, ~0},
+	[3] = {0},
+	[4] = {[24] = BIT(0) | BIT(1)},       /* Only larb27(24) port0/1 */
+	[5] = {[24] = BIT(2) | BIT(3)},       /* Only larb27(24) port2/3 */
+};
+
 static const struct mtk_iommu_plat_data mt8188_data_vdo = {
 	.m4u_plat       = M4U_MT8188,
 	.flags          = HAS_BCLK | HAS_SUB_COMM_3BITS | OUT_ORDER_WR_EN |
@@ -1610,6 +1624,7 @@ static const struct mtk_iommu_plat_data mt8188_data_vdo = {
 	.banks_enable   = {true},
 	.iova_region    = mt8192_multi_dom,
 	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
+	.iova_region_larb_msk = mt8188_larb_region_msk,
 	.larbid_remap   = {{2}, {0}, {21}, {0}, {19}, {9, 10,
 			   11 /* 11a */, 25 /* 11c */},
 			   {13, 0, 29 /* 16b */, 30 /* 17b */, 0}, {5}},
@@ -1626,6 +1641,7 @@ static const struct mtk_iommu_plat_data mt8188_data_vpp = {
 	.banks_enable   = {true},
 	.iova_region    = mt8192_multi_dom,
 	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
+	.iova_region_larb_msk = mt8188_larb_region_msk,
 	.larbid_remap   = {{1}, {3}, {23}, {7}, {MTK_INVALID_LARBID},
 			   {12, 15, 24 /* 11b */}, {14, MTK_INVALID_LARBID,
 			   16 /* 16a */, 17 /* 17a */, MTK_INVALID_LARBID,
-- 
2.25.1

