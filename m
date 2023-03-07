Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9C82577
	for <iommu@lists.linux.dev>; Tue,  7 Mar 2023 08:07:49 +0000 (UTC)
X-UUID: 2400960cbcbf11ed945fc101203acc17-20230307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Xcl0geET81WYNBRHKToCqUUKoHCvhorE98xJYXCbui4=;
	b=e7f+gbNQJEVMn52asKShIb4jvRrjO2mZpnHHYUVeFnk2JHfjv1FTc1M3nvNZSNxqvVMXvjz3CtRgdqk9lXwh2vgFwiSOuyVhfnXAa2QLdkpnJuW1pTOqgDyju1DTpREwsUZrHg7cankd0H3rU5JOTdO97wq41mWg3GNy6QRfA/4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:075c8cbe-3d27-40a9-87d4-d7320c5ef510,IP:0,U
	RL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:25b5999,CLOUDID:34d69327-564d-42d9-9875-7c868ee415ec,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 2400960cbcbf11ed945fc101203acc17-20230307
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 704658285; Tue, 07 Mar 2023 16:07:44 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 7 Mar 2023 16:07:42 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 7 Mar 2023 16:07:42 +0800
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
	<chengci.xu@mediatek.com>, <youlin.pei@mediatek.com>
Subject: [PATCH v8 7/7] iommu/mediatek: mt8188: Add iova_region_larb_msk
Date: Tue, 7 Mar 2023 16:05:55 +0800
Message-ID: <20230307080555.14399-8-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230307080555.14399-1-yong.wu@mediatek.com>
References: <20230307080555.14399-1-yong.wu@mediatek.com>
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

Note: larb19(21) as commented in that h above, it means larb19 while its SW
index is 21.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index c56f0f121be8..9ccdcf1aba2d 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1603,6 +1603,20 @@ static const struct mtk_iommu_plat_data mt8188_data_infra = {
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
@@ -1614,6 +1628,7 @@ static const struct mtk_iommu_plat_data mt8188_data_vdo = {
 	.banks_enable   = {true},
 	.iova_region    = mt8192_multi_dom,
 	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
+	.iova_region_larb_msk = mt8188_larb_region_msk,
 	.larbid_remap   = {{2}, {0}, {21}, {0}, {19}, {9, 10,
 			   11 /* 11a */, 25 /* 11c */},
 			   {13, 0, 29 /* 16b */, 30 /* 17b */, 0}, {5}},
@@ -1630,6 +1645,7 @@ static const struct mtk_iommu_plat_data mt8188_data_vpp = {
 	.banks_enable   = {true},
 	.iova_region    = mt8192_multi_dom,
 	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
+	.iova_region_larb_msk = mt8188_larb_region_msk,
 	.larbid_remap   = {{1}, {3}, {23}, {7}, {MTK_INVALID_LARBID},
 			   {12, 15, 24 /* 11b */}, {14, MTK_INVALID_LARBID,
 			   16 /* 16a */, 17 /* 17a */, MTK_INVALID_LARBID,
-- 
2.25.1

