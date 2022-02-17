Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA7FC433FE
	for <iommu@archiver.kernel.org>; Thu, 17 Feb 2022 11:38:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5167F60709;
	Thu, 17 Feb 2022 11:38:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 437pBNZuCnwd; Thu, 17 Feb 2022 11:38:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 37BEE606EB;
	Thu, 17 Feb 2022 11:38:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2128BC0021;
	Thu, 17 Feb 2022 11:38:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 304AAC000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Feb 2022 11:38:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1E84060709
 for <iommu@lists.linux-foundation.org>; Thu, 17 Feb 2022 11:38:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VwX_zgfpGMX9 for <iommu@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 11:38:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 023E0606EB
 for <iommu@lists.linux-foundation.org>; Thu, 17 Feb 2022 11:38:31 +0000 (UTC)
X-UUID: 2c338d9b6145499b9015c0b7c599b251-20220217
X-UUID: 2c338d9b6145499b9015c0b7c599b251-20220217
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1404140774; Thu, 17 Feb 2022 19:38:28 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Thu, 17 Feb 2022 19:38:26 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Feb 2022 19:38:25 +0800
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 "Matthias Brugger" <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v5 22/34] iommu/mediatek: Add mt8195 support
Date: Thu, 17 Feb 2022 19:34:41 +0800
Message-ID: <20220217113453.13658-23-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220217113453.13658-1-yong.wu@mediatek.com>
References: <20220217113453.13658-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
 linux-kernel@vger.kernel.org, libo.kang@mediatek.com,
 yen-chang.chen@mediatek.com, iommu@lists.linux-foundation.org,
 yf.wang@mediatek.com, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, mingyuan.ma@mediatek.com,
 linux-arm-kernel@lists.infradead.org, AngeloGioacchino
 Del Regno <angelogioacchino.delregno@collabora.com>
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

mt8195 has 3 IOMMU, containing 2 MM IOMMUs, one is for vdo, the other
is for vpp. and 1 INFRA IOMMU.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 43 +++++++++++++++++++++++++++++++++++++++
 drivers/iommu/mtk_iommu.h |  1 +
 2 files changed, 44 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 158185302d53..0370fd6f0eca 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1232,6 +1232,46 @@ static const struct mtk_iommu_plat_data mt8192_data = {
 			   {0, 14, 16}, {0, 13, 18, 17}},
 };
 
+static const struct mtk_iommu_plat_data mt8195_data_infra = {
+	.m4u_plat	  = M4U_MT8195,
+	.flags            = WR_THROT_EN | DCM_DISABLE | PM_CLK_AO |
+			    MTK_IOMMU_TYPE_INFRA | IFA_IOMMU_PCIE_SUPPORT,
+	.pericfg_comp_str = "mediatek,mt8195-pericfg_ao",
+	.inv_sel_reg      = REG_MMU_INV_SEL_GEN2,
+	.iova_region      = single_domain,
+	.iova_region_nr   = ARRAY_SIZE(single_domain),
+};
+
+static const struct mtk_iommu_plat_data mt8195_data_vdo = {
+	.m4u_plat	= M4U_MT8195,
+	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN |
+			  WR_THROT_EN | NOT_STD_AXI_MODE | IOVA_34_EN |
+			  SHARE_PGTABLE | MTK_IOMMU_TYPE_MM,
+	.hw_list        = &m4ulist,
+	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
+	.iova_region	= mt8192_multi_dom,
+	.iova_region_nr	= ARRAY_SIZE(mt8192_multi_dom),
+	.larbid_remap   = {{2, 0}, {21}, {24}, {7}, {19}, {9, 10, 11},
+			   {13, 17, 15/* 17b */, 25}, {5}},
+};
+
+static const struct mtk_iommu_plat_data mt8195_data_vpp = {
+	.m4u_plat	= M4U_MT8195,
+	.flags          = HAS_BCLK | HAS_SUB_COMM_3BITS | OUT_ORDER_WR_EN |
+			  WR_THROT_EN | NOT_STD_AXI_MODE | IOVA_34_EN |
+			  SHARE_PGTABLE | MTK_IOMMU_TYPE_MM,
+	.hw_list        = &m4ulist,
+	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
+	.iova_region	= mt8192_multi_dom,
+	.iova_region_nr	= ARRAY_SIZE(mt8192_multi_dom),
+	.larbid_remap   = {{1}, {3},
+			   {22, MTK_INVALID_LARBID, MTK_INVALID_LARBID, MTK_INVALID_LARBID, 23},
+			   {8}, {20}, {12},
+			   /* 16: 16a; 29: 16b; 30: CCUtop0; 31: CCUtop1 */
+			   {14, 16, 29, 26, 30, 31, 18},
+			   {4, MTK_INVALID_LARBID, MTK_INVALID_LARBID, MTK_INVALID_LARBID, 6}},
+};
+
 static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
 	{ .compatible = "mediatek,mt6779-m4u", .data = &mt6779_data},
@@ -1239,6 +1279,9 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
 	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
 	{ .compatible = "mediatek,mt8192-m4u", .data = &mt8192_data},
+	{ .compatible = "mediatek,mt8195-iommu-infra", .data = &mt8195_data_infra},
+	{ .compatible = "mediatek,mt8195-iommu-vdo",   .data = &mt8195_data_vdo},
+	{ .compatible = "mediatek,mt8195-iommu-vpp",   .data = &mt8195_data_vpp},
 	{}
 };
 
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 04e5e5e7fd62..9dba98bb12eb 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -46,6 +46,7 @@ enum mtk_iommu_plat {
 	M4U_MT8173,
 	M4U_MT8183,
 	M4U_MT8192,
+	M4U_MT8195,
 };
 
 struct mtk_iommu_iova_region;
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
