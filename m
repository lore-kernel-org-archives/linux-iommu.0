Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2250DC433F5
	for <iommu@archiver.kernel.org>; Thu, 17 Feb 2022 11:36:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6F3841808;
	Thu, 17 Feb 2022 11:36:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KqV2vRg06HJy; Thu, 17 Feb 2022 11:36:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A6616417F9;
	Thu, 17 Feb 2022 11:36:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BD58C0021;
	Thu, 17 Feb 2022 11:36:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00DA9C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Feb 2022 11:36:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D5C3A6F6D5
 for <iommu@lists.linux-foundation.org>; Thu, 17 Feb 2022 11:36:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2_qbBS916k9z for <iommu@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 11:36:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E4E9F6F6C9
 for <iommu@lists.linux-foundation.org>; Thu, 17 Feb 2022 11:36:50 +0000 (UTC)
X-UUID: 581605e0d72a4b9a9311175d78bb031d-20220217
X-UUID: 581605e0d72a4b9a9311175d78bb031d-20220217
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 164362; Thu, 17 Feb 2022 19:36:47 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Thu, 17 Feb 2022 19:36:46 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Feb 2022 19:36:45 +0800
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 "Matthias Brugger" <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v5 11/34] iommu/mediatek: Add a flag NON_STD_AXI
Date: Thu, 17 Feb 2022 19:34:30 +0800
Message-ID: <20220217113453.13658-12-yong.wu@mediatek.com>
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

Add a new flag NON_STD_AXI, All the previous SoC support this flag.
Prepare for adding infra and apu iommu which don't support this.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 3418b5782830..ce593f77649f 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -122,6 +122,7 @@
 #define IOVA_34_EN			BIT(8)
 #define SHARE_PGTABLE			BIT(9) /* 2 HW share pgtable */
 #define DCM_DISABLE			BIT(10)
+#define NOT_STD_AXI_MODE		BIT(11)
 
 #define MTK_IOMMU_HAS_FLAG(pdata, _x) \
 		((((pdata)->flags) & (_x)) == (_x))
@@ -783,7 +784,8 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 		regval = 0;
 	} else {
 		regval = readl_relaxed(data->base + REG_MMU_MISC_CTRL);
-		regval &= ~F_MMU_STANDARD_AXI_MODE_MASK;
+		if (MTK_IOMMU_HAS_FLAG(data->plat_data, NOT_STD_AXI_MODE))
+			regval &= ~F_MMU_STANDARD_AXI_MODE_MASK;
 		if (MTK_IOMMU_HAS_FLAG(data->plat_data, OUT_ORDER_WR_EN))
 			regval &= ~F_MMU_IN_ORDER_WR_EN_MASK;
 	}
@@ -1056,7 +1058,8 @@ static const struct dev_pm_ops mtk_iommu_pm_ops = {
 
 static const struct mtk_iommu_plat_data mt2712_data = {
 	.m4u_plat     = M4U_MT2712,
-	.flags        = HAS_4GB_MODE | HAS_BCLK | HAS_VLD_PA_RNG | SHARE_PGTABLE,
+	.flags        = HAS_4GB_MODE | HAS_BCLK | HAS_VLD_PA_RNG | SHARE_PGTABLE |
+			NOT_STD_AXI_MODE,
 	.hw_list      = &m4ulist,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
 	.iova_region  = single_domain,
@@ -1066,7 +1069,8 @@ static const struct mtk_iommu_plat_data mt2712_data = {
 
 static const struct mtk_iommu_plat_data mt6779_data = {
 	.m4u_plat      = M4U_MT6779,
-	.flags         = HAS_SUB_COMM | OUT_ORDER_WR_EN | WR_THROT_EN,
+	.flags         = HAS_SUB_COMM | OUT_ORDER_WR_EN | WR_THROT_EN |
+			 NOT_STD_AXI_MODE,
 	.inv_sel_reg   = REG_MMU_INV_SEL_GEN2,
 	.iova_region   = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
@@ -1075,7 +1079,7 @@ static const struct mtk_iommu_plat_data mt6779_data = {
 
 static const struct mtk_iommu_plat_data mt8167_data = {
 	.m4u_plat     = M4U_MT8167,
-	.flags        = RESET_AXI | HAS_LEGACY_IVRP_PADDR,
+	.flags        = RESET_AXI | HAS_LEGACY_IVRP_PADDR | NOT_STD_AXI_MODE,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
@@ -1085,7 +1089,7 @@ static const struct mtk_iommu_plat_data mt8167_data = {
 static const struct mtk_iommu_plat_data mt8173_data = {
 	.m4u_plat     = M4U_MT8173,
 	.flags	      = HAS_4GB_MODE | HAS_BCLK | RESET_AXI |
-			HAS_LEGACY_IVRP_PADDR,
+			HAS_LEGACY_IVRP_PADDR | NOT_STD_AXI_MODE,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
@@ -1104,7 +1108,7 @@ static const struct mtk_iommu_plat_data mt8183_data = {
 static const struct mtk_iommu_plat_data mt8192_data = {
 	.m4u_plat       = M4U_MT8192,
 	.flags          = HAS_BCLK | HAS_SUB_COMM | OUT_ORDER_WR_EN |
-			  WR_THROT_EN | IOVA_34_EN,
+			  WR_THROT_EN | IOVA_34_EN | NOT_STD_AXI_MODE,
 	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
 	.iova_region    = mt8192_multi_dom,
 	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
