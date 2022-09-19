Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC372A48
	for <iommu@lists.linux.dev>; Mon, 19 Sep 2022 08:27:00 +0000 (UTC)
X-UUID: 96c411d72432459692d970eab2b3dd03-20220919
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=VhDv4Z6VehgIZewxcyssE9aEXtrZgrh+FUiksQcz7AA=;
	b=BnpUu0tkQKGg9WAycIgH+UNRfaUJt4DbS/9y86+CnxuiBz/qHCJN+hJVq3jJvi1kS7k9q8Mw9rR1uYvWqJ+af7gilp4aeRh392y90gWdVvLzNVRQoPBJtzsGkN6jfNIY1E5cM+eIatU/w/Xm7R7K6acT6Fd2qrhAN2GlO+1EpPI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:5f97bf32-0d41-4de6-97eb-3146645aa3d6,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:67f9d818-0314-4ae7-b2d1-7295be49255e,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 96c411d72432459692d970eab2b3dd03-20220919
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <chengci.xu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 941197890; Mon, 19 Sep 2022 16:26:54 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 19 Sep 2022 16:26:53 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 19 Sep 2022 16:26:52 +0800
From: Chengci.Xu <chengci.xu@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger
	<matthias.bgg@gmail.com>
CC: <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chengci.Xu
	<chengci.xu@mediatek.com>
Subject: [PATCH v3 3/3] iommu/mediatek: Add MT8188 IOMMU Support
Date: Mon, 19 Sep 2022 16:26:11 +0800
Message-ID: <20220919082611.19824-4-chengci.xu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220919082611.19824-1-chengci.xu@mediatek.com>
References: <20220919082611.19824-1-chengci.xu@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

MT8188 has 3 IOMMU, containing 2 MM IOMMUs, one is for vdo, the other
is for vpp. and 1 INFRA IOMMU.

Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 47 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 8b8a289bab2c..68c9be30db91 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -164,6 +164,7 @@ enum mtk_iommu_plat {
 	M4U_MT8173,
 	M4U_MT8183,
 	M4U_MT8186,
+	M4U_MT8188,
 	M4U_MT8192,
 	M4U_MT8195,
 };
@@ -1456,6 +1457,49 @@ static const struct mtk_iommu_plat_data mt8186_data_mm = {
 	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
 };
 
+static const struct mtk_iommu_plat_data mt8188_data_infra = {
+	.m4u_plat	  = M4U_MT8188,
+	.flags            = WR_THROT_EN | DCM_DISABLE | STD_AXI_MODE | PM_CLK_AO |
+			    MTK_IOMMU_TYPE_INFRA | IFA_IOMMU_PCIE_SUPPORT |
+			    CFG_IFA_MASTER_IN_ATF,
+	.inv_sel_reg      = REG_MMU_INV_SEL_GEN2,
+	.banks_num	  = 1,
+	.banks_enable     = {true},
+	.iova_region      = single_domain,
+	.iova_region_nr   = ARRAY_SIZE(single_domain),
+};
+
+static const struct mtk_iommu_plat_data mt8188_data_vdo = {
+	.m4u_plat	= M4U_MT8188,
+	.flags          = HAS_BCLK | HAS_SUB_COMM_3BITS | OUT_ORDER_WR_EN |
+			  WR_THROT_EN | IOVA_34_EN | SHARE_PGTABLE | MTK_IOMMU_TYPE_MM,
+	.hw_list        = &m4ulist,
+	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
+	.banks_num      = 1,
+	.banks_enable   = {true},
+	.iova_region	= mt8192_multi_dom,
+	.iova_region_nr	= ARRAY_SIZE(mt8192_multi_dom),
+	.larbid_remap   = {{2}, {0}, {21}, {0}, {19}, {9, 10,
+			   11 /* 11a */, 25 /* 11c */},
+			   {13, 0, 29 /* 16b */, 30 /* 17b */, 0}, {5}},
+};
+
+static const struct mtk_iommu_plat_data mt8188_data_vpp = {
+	.m4u_plat	= M4U_MT8188,
+	.flags          = HAS_BCLK | HAS_SUB_COMM_3BITS | OUT_ORDER_WR_EN |
+			  WR_THROT_EN | IOVA_34_EN | SHARE_PGTABLE | MTK_IOMMU_TYPE_MM,
+	.hw_list        = &m4ulist,
+	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
+	.banks_num      = 1,
+	.banks_enable   = {true},
+	.iova_region	= mt8192_multi_dom,
+	.iova_region_nr	= ARRAY_SIZE(mt8192_multi_dom),
+	.larbid_remap   = {{1}, {3}, {23}, {7}, {MTK_INVALID_LARBID},
+			   {12, 15, 24 /* 11b */}, {14, MTK_INVALID_LARBID,
+			   16 /* 16a */, 17 /* 17a */, MTK_INVALID_LARBID,
+			   27, 28 /* ccu0 */, MTK_INVALID_LARBID}, {4, 6}},
+};
+
 static const struct mtk_iommu_plat_data mt8192_data = {
 	.m4u_plat       = M4U_MT8192,
 	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN |
@@ -1523,6 +1567,9 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
 	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
 	{ .compatible = "mediatek,mt8186-iommu-mm",    .data = &mt8186_data_mm}, /* mm: m4u */
+	{ .compatible = "mediatek,mt8188-iommu-infra", .data = &mt8188_data_infra},
+	{ .compatible = "mediatek,mt8188-iommu-vdo", .data = &mt8188_data_vdo},
+	{ .compatible = "mediatek,mt8188-iommu-vpp", .data = &mt8188_data_vpp},
 	{ .compatible = "mediatek,mt8192-m4u", .data = &mt8192_data},
 	{ .compatible = "mediatek,mt8195-iommu-infra", .data = &mt8195_data_infra},
 	{ .compatible = "mediatek,mt8195-iommu-vdo",   .data = &mt8195_data_vdo},
-- 
2.25.1

