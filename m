Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29BC28F94F
	for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 14:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744296020; cv=none; b=tQKRo/dYK9/UoX1upU/mQctkQzUoojOT1EqiyVRPN0+xEB/vTyBKKo8IE3m2s94Tb75HixC8kEu0QJRGOLMadXLHkZQ63Puqf/T31gcbvNnvCGXWFWPVP366+owE50lRAMi3lUlq52roJm+vD0h64MAPBu7Uq4VGwMJbnsloJJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744296020; c=relaxed/simple;
	bh=jSRPeeUZbUFnm5JrrBKlIB+n5RJQ2oyK+3O1pN6pJEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlHJoydmWx4abvU5o/XgTcq8vpoqTbVkpMgyRA2jIMOvD79nop3yul9+tpdTPm1/xVMLghLZ/GNXYRubNCiLlvvfa4wXKa3L/IZ+Msos00/P0uEs+OMxawcxDNm/jrx0PVOVylNw9nuff+I+9XqIkwArUbTBdpvMeeLCirPZJbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=k/gO+SYu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="k/gO+SYu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744296017;
	bh=jSRPeeUZbUFnm5JrrBKlIB+n5RJQ2oyK+3O1pN6pJEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k/gO+SYu3J9DkVlez6NwJPIYIZ8meW6VHagV0LOHYwrPbtD2H2w6xoYAwUahzh0c/
	 9p7uYPwPT65ZNb1IqP7FQ2SLLg0O/rMz9mDMFxbMRQsUmAWDPgmtDua79TL0TGArv8
	 vds+WpELTbRpJwE8CjPyFwcGa7PxZUCQQ/YCvfktymiJuo0sy+H23f/6HzLrXoQYUN
	 2kHhFnfLFkvEPMjMpBTpO7evGt7PRArwGXC1N06tRz5QpAlQthqzC5Z7mMwS4YwWGi
	 34H0MDBhzlOPXzUeRdW1MSu7f3HiXXpIeUjuuLSmDbwzguWOsTYhGd3yvehcWHRZdL
	 +8dsoZqRwlC7Q==
Received: from IcarusMOD.eternityproject.eu (fi-19-199-243.service.infuturo.it [151.19.199.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 00F9D17E0EB8;
	Thu, 10 Apr 2025 16:40:14 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: yong.wu@mediatek.com
Cc: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 2/2] iommu/mediatek: Add support for Dimensity 1200 MT6893 MM IOMMU
Date: Thu, 10 Apr 2025 16:40:08 +0200
Message-ID: <20250410144008.475888-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410144008.475888-1-angelogioacchino.delregno@collabora.com>
References: <20250410144008.475888-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the two MM IOMMUs found in the MediaTek Dimensity
1200 (MT6893) SoC, used for display, camera, imgsys and vpu.

Since the MT6893 SoC is almost fully compatible with MT8192, also
move the mt8192_larb_region_msk before the newly introduced mt6893
platform data, as the larb regions from mt8192 are fully reused.

Note that the only difference with MT8192 is that MT6893 needs the
SHARE_PGTABLE flag.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index df98d0c65f54..0a54c6521bf5 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1550,6 +1550,31 @@ static const struct mtk_iommu_plat_data mt6795_data = {
 	.larbid_remap = {{0}, {1}, {2}, {3}, {4}}, /* Linear mapping. */
 };
 
+static const unsigned int mt8192_larb_region_msk[MT8192_MULTI_REGION_NR_MAX][MTK_LARB_NR_MAX] = {
+	[0] = {~0, ~0},				/* Region0: larb0/1 */
+	[1] = {0, 0, 0, 0, ~0, ~0, 0, ~0},	/* Region1: larb4/5/7 */
+	[2] = {0, 0, ~0, 0, 0, 0, 0, 0,		/* Region2: larb2/9/11/13/14/16/17/18/19/20 */
+	       0, ~0, 0, ~0, 0, ~(u32)(BIT(9) | BIT(10)), ~(u32)(BIT(4) | BIT(5)), 0,
+	       ~0, ~0, ~0, ~0, ~0},
+	[3] = {0},
+	[4] = {[13] = BIT(9) | BIT(10)},	/* larb13 port9/10 */
+	[5] = {[14] = BIT(4) | BIT(5)},		/* larb14 port4/5 */
+};
+
+static const struct mtk_iommu_plat_data mt6893_data = {
+	.m4u_plat     = M4U_MT8192,
+	.flags        = HAS_BCLK | OUT_ORDER_WR_EN | HAS_SUB_COMM_2BITS |
+			WR_THROT_EN | IOVA_34_EN | SHARE_PGTABLE | MTK_IOMMU_TYPE_MM,
+	.inv_sel_reg  = REG_MMU_INV_SEL_GEN2,
+	.banks_num    = 1,
+	.banks_enable = {true},
+	.iova_region  = mt8192_multi_dom,
+	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
+	.iova_region_larb_msk = mt8192_larb_region_msk,
+	.larbid_remap    = {{0}, {1}, {4, 5}, {7}, {2}, {9, 11, 19, 20},
+			    {0, 14, 16}, {0, 13, 18, 17}},
+};
+
 static const struct mtk_iommu_plat_data mt8167_data = {
 	.m4u_plat     = M4U_MT8167,
 	.flags        = RESET_AXI | HAS_LEGACY_IVRP_PADDR | MTK_IOMMU_TYPE_MM,
@@ -1673,17 +1698,6 @@ static const struct mtk_iommu_plat_data mt8188_data_vpp = {
 			   27, 28 /* ccu0 */, MTK_INVALID_LARBID}, {4, 6}},
 };
 
-static const unsigned int mt8192_larb_region_msk[MT8192_MULTI_REGION_NR_MAX][MTK_LARB_NR_MAX] = {
-	[0] = {~0, ~0},				/* Region0: larb0/1 */
-	[1] = {0, 0, 0, 0, ~0, ~0, 0, ~0},	/* Region1: larb4/5/7 */
-	[2] = {0, 0, ~0, 0, 0, 0, 0, 0,		/* Region2: larb2/9/11/13/14/16/17/18/19/20 */
-	       0, ~0, 0, ~0, 0, ~(u32)(BIT(9) | BIT(10)), ~(u32)(BIT(4) | BIT(5)), 0,
-	       ~0, ~0, ~0, ~0, ~0},
-	[3] = {0},
-	[4] = {[13] = BIT(9) | BIT(10)},	/* larb13 port9/10 */
-	[5] = {[14] = BIT(4) | BIT(5)},		/* larb14 port4/5 */
-};
-
 static const struct mtk_iommu_plat_data mt8192_data = {
 	.m4u_plat       = M4U_MT8192,
 	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN |
@@ -1777,6 +1791,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
 	{ .compatible = "mediatek,mt6779-m4u", .data = &mt6779_data},
 	{ .compatible = "mediatek,mt6795-m4u", .data = &mt6795_data},
+	{ .compatible = "mediatek.mt6893-iommu-mm", .data = &mt6893_data},
 	{ .compatible = "mediatek,mt8167-m4u", .data = &mt8167_data},
 	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
 	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
-- 
2.49.0

