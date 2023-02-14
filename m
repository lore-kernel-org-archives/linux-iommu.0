Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E127E
	for <iommu@lists.linux.dev>; Tue, 14 Feb 2023 03:12:39 +0000 (UTC)
X-UUID: 6ab5877aac1511eda06fc9ecc4dadd91-20230214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6YwMpyviGTSbxvBRVJIYFE9YPlevofbZZf0V7oAR34o=;
	b=kKV5f4LsIehkYG+8euKRfAe6NnS668FEUh32yLA5bBudMsqOknWWD06zGh3sl5vCaDFZIgB6Re/YguPOiR1fKhxrVeeSGkelSlvclCaVlyW2iitEfxNC0bbNpzQ5oSZsGwPIAYukyxML+HWEMp26MULtQ7aDBStu+16FTvoMHvk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:6162fb71-5c45-46ca-bfc4-7d13e1f1ddc7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:c0aecc8e-8530-4eff-9f77-222cf6e2895b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 6ab5877aac1511eda06fc9ecc4dadd91-20230214
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 888487452; Tue, 14 Feb 2023 11:12:30 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 14 Feb 2023 11:12:28 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 14 Feb 2023 11:12:27 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Hans Verkuil
	<hverkuil@xs4all.nl>, <nfraprado@collabora.com>,
	<linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>, AngeloGioacchino Del
 Regno <angelogioacchino.delregno@collabora.com>, <mingyuan.ma@mediatek.com>,
	<yf.wang@mediatek.com>, <jianjiao.zeng@mediatek.com>, Yunfei Dong
	<yunfei.dong@mediatek.com>, kyrie wu
	<kyrie.wu@mediatek.corp-partner.google.com>, <chengci.xu@mediatek.com>,
	<youlin.pei@mediatek.com>, <anan.sun@mediatek.com>, Yong Wu
	<yong.wu@mediatek.com>
Subject: [PATCH v3 05/11] iommu/mediatek: mt8195: Add iova_region_larb_msk
Date: Tue, 14 Feb 2023 11:11:08 +0800
Message-ID: <20230214031114.926-6-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230214031114.926-1-yong.wu@mediatek.com>
References: <20230214031114.926-1-yong.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Add iova_region_larb_msk for mt8195. We separate the 16GB iova regions
by each device's larbid/portid.
Refer to include/dt-bindings/memory/mt8195-memory-port.h

Define a new macro MT8192_MULTI_REGION_MAX_NR to indicate
the index of mt8xxx_larb_region_msk and
"struct mtk_iommu_iova_region mt8192_multi_dom"
are the same.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 7e2cb3b8cac8..3d9986fb49a5 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -332,7 +332,12 @@ static const struct mtk_iommu_iova_region single_domain[] = {
 	{.iova_base = 0,		.size = SZ_4G},
 };
 
-static const struct mtk_iommu_iova_region mt8192_multi_dom[] = {
+#define MT8192_MULTI_REGION_MAX_NR	6
+
+#define MT8192_MULTI_REGION_NR	(IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT) ? \
+				 MT8192_MULTI_REGION_MAX_NR : 1)
+
+static const struct mtk_iommu_iova_region mt8192_multi_dom[MT8192_MULTI_REGION_NR] = {
 	{ .iova_base = 0x0,		.size = SZ_4G},		/* 0 ~ 4G */
 	#if IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT)
 	{ .iova_base = SZ_4G,		.size = SZ_4G},		/* 4G ~ 8G */
@@ -1562,6 +1567,21 @@ static const struct mtk_iommu_plat_data mt8195_data_infra = {
 	.iova_region_nr   = ARRAY_SIZE(single_domain),
 };
 
+static const unsigned int mt8195_larb_region_msk[MT8192_MULTI_REGION_MAX_NR][MTK_LARB_NR_MAX] = {
+	[0] = {~0, ~0, ~0, ~0},               /* Region0: all ports for larb0/1/2/3 */
+	[1] = {0, 0, 0, 0, 0, 0, 0, 0,
+	       0, 0, 0, 0, 0, 0, 0, 0,
+	       0, 0, 0, ~0, ~0, ~0, ~0, ~0,   /* Region1: larb19/20/21/22/23/24 */
+	       ~0},
+	[2] = {0, 0, 0, 0, ~0, ~0, ~0, ~0,    /* Region2: the other larbs. */
+	       ~0, ~0, ~0, ~0, ~0, ~0, ~0, ~0,
+	       ~0, ~0, 0, 0, 0, 0, 0, 0,
+	       0, ~0, ~0, ~0, ~0},
+	[3] = {0},
+	[4] = {[18] = BIT(0) | BIT(1)},       /* Only larb18 port0/1 */
+	[5] = {[18] = BIT(2) | BIT(3)},       /* Only larb18 port2/3 */
+};
+
 static const struct mtk_iommu_plat_data mt8195_data_vdo = {
 	.m4u_plat	= M4U_MT8195,
 	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN |
@@ -1572,6 +1592,7 @@ static const struct mtk_iommu_plat_data mt8195_data_vdo = {
 	.banks_enable   = {true},
 	.iova_region	= mt8192_multi_dom,
 	.iova_region_nr	= ARRAY_SIZE(mt8192_multi_dom),
+	.iova_region_larb_msk = mt8195_larb_region_msk,
 	.larbid_remap   = {{2, 0}, {21}, {24}, {7}, {19}, {9, 10, 11},
 			   {13, 17, 15/* 17b */, 25}, {5}},
 };
@@ -1586,6 +1607,7 @@ static const struct mtk_iommu_plat_data mt8195_data_vpp = {
 	.banks_enable   = {true},
 	.iova_region	= mt8192_multi_dom,
 	.iova_region_nr	= ARRAY_SIZE(mt8192_multi_dom),
+	.iova_region_larb_msk = mt8195_larb_region_msk,
 	.larbid_remap   = {{1}, {3},
 			   {22, MTK_INVALID_LARBID, MTK_INVALID_LARBID, MTK_INVALID_LARBID, 23},
 			   {8}, {20}, {12},
-- 
2.18.0

