Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C676F2580
	for <iommu@lists.linux.dev>; Wed, 31 Aug 2022 12:55:52 +0000 (UTC)
X-UUID: 13bb24ff2ddc43019db701bb03846a5f-20220831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=O9O5SL25Jo8yWfIEbsOMlI1Tr0gZPHM40p9kdVbdobU=;
	b=TCIt8BFWTdXskcJARJPviMxBjGR8jYxaxza+4BOig/28F7bx8nlviS+pEiAcUVOIKQQO8KHffYz53H+rH/DhThJDzJEmK57veuMgSC2YgJYiM1cB/QeUECySRY1R2vKUqLNq5rgdTWD3JcTdFUx4f2N3DOjSabIiMVeB64+X9tY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:f6b0a62e-fd2e-4de7-b962-51a7c730afc1,OB:0,L
	OB:10,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Relea
	se_Ham,ACTION:release,TS:90
X-CID-INFO: VERSION:1.1.10,REQID:f6b0a62e-fd2e-4de7-b962-51a7c730afc1,OB:0,LOB
	:10,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS
	981B3D,ACTION:quarantine,TS:90
X-CID-META: VersionHash:84eae18,CLOUDID:20a5b120-1c20-48a5-82a0-25f9c331906d,C
	OID:8936a3059d85,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 13bb24ff2ddc43019db701bb03846a5f-20220831
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
	(envelope-from <chengci.xu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
	with ESMTP id 350805441; Wed, 31 Aug 2022 20:55:47 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 31 Aug 2022 20:55:45 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Wed, 31 Aug 2022 20:55:45 +0800
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
Subject: [PATCH v2 3/3] iommu/mediatek: Add MT8188 IOMMU Support
Date: Wed, 31 Aug 2022 20:55:02 +0800
Message-ID: <20220831125502.7818-4-chengci.xu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831125502.7818-1-chengci.xu@mediatek.com>
References: <20220831125502.7818-1-chengci.xu@mediatek.com>
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
 drivers/iommu/mtk_iommu.c | 48 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 6fe780783ec8..98c2eae5229e 100644
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
@@ -1479,6 +1480,50 @@ static const struct mtk_iommu_plat_data mt8186_data_mm = {
 	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
 };
 
+static const struct mtk_iommu_plat_data mt8188_data_infra = {
+	.m4u_plat	  = M4U_MT8188,
+	.flags            = WR_THROT_EN | DCM_DISABLE | STD_AXI_MODE | PM_CLK_AO |
+			    MTK_IOMMU_TYPE_INFRA | IFA_IOMMU_PCIE_SUPPORT |
+			    CFG_IFA_MASTER_IN_ATF,
+	.pericfg_comp_str = "mediatek,mt8188-pericfg_ao",
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
@@ -1546,6 +1591,9 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
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

