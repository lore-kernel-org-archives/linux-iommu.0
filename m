Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52581C433F5
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 10:19:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1045F611EB;
	Wed, 18 May 2022 10:19:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tiheONscPFHv; Wed, 18 May 2022 10:19:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EECA9611E0;
	Wed, 18 May 2022 10:19:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D78C0C0032;
	Wed, 18 May 2022 10:19:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9C06C0082
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 10:18:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A6E8983FAD
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 10:18:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uMrf6dceBxrZ for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 10:18:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0EA7783FA6
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 10:18:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id BE2931F447BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1652869137;
 bh=zFkZi1otInHhCJhlsxh3M6ORDfmM8tcKsLwrRUm2a7M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=J6qPTWHEDHCSNB6+4W3n02+ZWZTr1V3bX7yY9M0nYuwOO0egcECGzvfU8Isp6xxXh
 AgyEL4a4d5Sw5F2QFsmamRqyHLiFK3mf0cNNEGQpkAvKtmk+s7WcU9mNQ28bdVICdu
 +kJSk2C+nUvNyzBKfPW0IrIn68e3A4s75bLNts1q9aUzJHBTmyHyYEcd89DjFjRlLv
 CE5uHGajMeGSjFG/cXnCYh3vOuGWq5BjnafchRAQyiVNQEPl2huLSE3dLN+KDKoBay
 L/CiiTTL3B5dXs/3rv0FMxmPI1YnrnGH74Duj4TCP5K97I9Nu/XttM+yeqesondr1D
 4EkjI2O1YhFJA==
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: yong.wu@mediatek.com
Subject: [PATCH v2 2/2] iommu: mtk_iommu: Add support for MT6795 Helio X10 M4Us
Date: Wed, 18 May 2022 12:18:49 +0200
Message-Id: <20220518101849.46804-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220518101849.46804-1-angelogioacchino.delregno@collabora.com>
References: <20220518101849.46804-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, martin.botka@somainline.org,
 paul.bouchara@somainline.org, konrad.dybcio@somainline.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 ~postmarketos/upstreaming@lists.sr.ht, krzysztof.kozlowski+dt@linaro.org,
 matthias.bgg@gmail.com, marijn.suijten@somainline.org,
 phone-devel@vger.kernel.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Add support for the M4Us found in the MT6795 Helio X10 SoC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 090cf6e15f85..97ff30ed2d0f 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -159,6 +159,7 @@
 enum mtk_iommu_plat {
 	M4U_MT2712,
 	M4U_MT6779,
+	M4U_MT6795,
 	M4U_MT8167,
 	M4U_MT8173,
 	M4U_MT8183,
@@ -954,7 +955,8 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data, unsigned int ban
 	 * Global control settings are in bank0. May re-init these global registers
 	 * since no sure if there is bank0 consumers.
 	 */
-	if (data->plat_data->m4u_plat == M4U_MT8173) {
+	if (data->plat_data->m4u_plat == M4U_MT6795 ||
+	    data->plat_data->m4u_plat == M4U_MT8173) {
 		regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
 			 F_MMU_TF_PROT_TO_PROGRAM_ADDR_MT8173;
 	} else {
@@ -1422,6 +1424,18 @@ static const struct mtk_iommu_plat_data mt6779_data = {
 	.larbid_remap  = {{0}, {1}, {2}, {3}, {5}, {7, 8}, {10}, {9}},
 };
 
+static const struct mtk_iommu_plat_data mt6795_data = {
+	.m4u_plat     = M4U_MT6795,
+	.flags	      = HAS_4GB_MODE | HAS_BCLK | RESET_AXI |
+			HAS_LEGACY_IVRP_PADDR | MTK_IOMMU_TYPE_MM,
+	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
+	.banks_num    = 1,
+	.banks_enable = {true},
+	.iova_region  = single_domain,
+	.iova_region_nr = ARRAY_SIZE(single_domain),
+	.larbid_remap = {{0}, {1}, {2}, {3}, {4}}, /* Linear mapping. */
+};
+
 static const struct mtk_iommu_plat_data mt8167_data = {
 	.m4u_plat     = M4U_MT8167,
 	.flags        = RESET_AXI | HAS_LEGACY_IVRP_PADDR | MTK_IOMMU_TYPE_MM,
@@ -1533,6 +1547,7 @@ static const struct mtk_iommu_plat_data mt8195_data_vpp = {
 static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
 	{ .compatible = "mediatek,mt6779-m4u", .data = &mt6779_data},
+	{ .compatible = "mediatek,mt6795-m4u", .data = &mt6795_data},
 	{ .compatible = "mediatek,mt8167-m4u", .data = &mt8167_data},
 	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
 	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
