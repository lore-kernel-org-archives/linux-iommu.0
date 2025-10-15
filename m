Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742A33191C4
	for <iommu@lists.linux.dev>; Wed, 15 Oct 2025 12:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533040; cv=none; b=ACR858Ts/CBi9S1dX3/jWN/2zw5By+Fx7gi2mIkwLo7qjQwH2KbgGHOPJh1kRJy2zt+xGgmMWRruWUVUN8Pl/5wq3eFS2fnl4GE4d/6jIQQl6q4JvVyYBR40dxuh/ox8FLd2N6F3f4Mvigtld0cV0sVQOSnT8mxwXkwREpYFTrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533040; c=relaxed/simple;
	bh=t3e4rPFoI0I8mewZjtovKqY2KE1DnTifmJbgEHz8+Fs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gd1ba5GUWSDwiesRkWHZib2IKXCDcBJk/SNfx/uvQJWwyEkubYfanymxAL37GeSF3kXC8mbsqvu5SUQWMvR7sFj9M8Lys++gmkA/vLDFVVG2hgoXkd9JyRQXvrFogNKymOilNMkGKbv4iMCEShz8c7fXtUJ1PJr5nSrimBbh6VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=LqE2pllm; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LqE2pllm"
X-UUID: 763480cca9c611f0b33aeb1e7f16c2b6-20251015
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=OXEc955O1cg/NAX2mjyGeMZRRZzVJF2HlDf4IpQzb2Q=;
	b=LqE2pllmwHO8PANSXN+46N1B15nZN6WrgCz4p7EdjShUX51ughLk+WdfNCYg1uUBfvwKmpim/uP00uJpWmS+qtRKId4/p3a3ZxDrHuFtR9VlSIRPUiJoqdeNgVQ5uR5te7XhzVSFmEj9qzRpTD2n7jxRZVTjS9yxvKsyGJDumHM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:ef674451-993e-4a49-aa4a-f8f1b6f338ab,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:9b776b02-eaf8-4c8c-94de-0bc39887e077,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 763480cca9c611f0b33aeb1e7f16c2b6-20251015
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <zhengnan.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1341327443; Wed, 15 Oct 2025 20:57:10 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 15 Oct 2025 20:57:07 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Wed, 15 Oct 2025 20:57:07 +0800
From: Zhengnan Chen <zhengnan.chen@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Zhengnan Chen
	<zhengnan.chen@mediatek.com>
Subject: [PATCH v3 5/5] iommu/mediatek: mt8189: Add MM IOMMUs support
Date: Wed, 15 Oct 2025 20:55:17 +0800
Message-ID: <20251015125532.9041-6-zhengnan.chen@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20251015125532.9041-1-zhengnan.chen@mediatek.com>
References: <20251015125532.9041-1-zhengnan.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for mt8189 MM IOMMUs.

Signed-off-by: Zhengnan Chen <zhengnan.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 2eb62a073a58..64b641f43298 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1771,6 +1771,33 @@ static const struct mtk_iommu_plat_data mt8189_data_infra = {
 	.iova_region_nr	= ARRAY_SIZE(single_domain),
 };
 
+static const u32 mt8189_larb_region_msk[MT8192_MULTI_REGION_NR_MAX][MTK_LARB_NR_MAX] = {
+	[0] = {~0, ~0, ~0, [22] = BIT(0)},	/* Region0: all ports for larb0/1/2 */
+	[1] = {[3] = ~0, [4] = ~0},		/* Region1: all ports for larb4(3)/7(4) */
+	[2] = {[5] = ~0, [6] = ~0,		/* Region2: all ports for larb9(5)/11(6) */
+	       [7] = ~0, [8] = ~0,		/* Region2: all ports for larb13(7)/14(8) */
+	       [9] = ~0, [10] = ~0,		/* Region2: all ports for larb16(9)/17(10) */
+	       [11] = ~0, [12] = ~0,		/* Region2: all ports for larb19(11)/20(12) */
+	       [21] = ~0},			/* Region2: larb21 fake GCE larb */
+};
+
+static const struct mtk_iommu_plat_data mt8189_data_mm = {
+	.m4u_plat	= M4U_MT8189,
+	.flags		= HAS_BCLK | HAS_SUB_COMM_3BITS | OUT_ORDER_WR_EN |
+			  WR_THROT_EN | IOVA_34_EN | MTK_IOMMU_TYPE_MM |
+			  PGTABLE_PA_35_EN | DL_WITH_MULTI_LARB,
+	.hw_list	= &m4ulist,
+	.inv_sel_reg	= REG_MMU_INV_SEL_GEN2,
+	.banks_num	= 5,
+	.banks_enable	= {true, false, false, false, false},
+	.iova_region	= mt8192_multi_dom,
+	.iova_region_nr	= ARRAY_SIZE(mt8192_multi_dom),
+	.iova_region_larb_msk = mt8189_larb_region_msk,
+	.larbid_remap	= {{0}, {1}, {21/* GCE_D */, 21/* GCE_M */, 2},
+			   {19, 20, 9, 11}, {7}, {4},
+			   {13, 17}, {14, 16}},
+};
+
 static const struct mtk_iommu_plat_data mt8192_data = {
 	.m4u_plat       = M4U_MT8192,
 	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN |
@@ -1874,6 +1901,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt8188-iommu-vpp",   .data = &mt8188_data_vpp},
 	{ .compatible = "mediatek,mt8189-iommu-apu",   .data = &mt8189_data_apu},
 	{ .compatible = "mediatek,mt8189-iommu-infra", .data = &mt8189_data_infra},
+	{ .compatible = "mediatek,mt8189-iommu-mm",    .data = &mt8189_data_mm},
 	{ .compatible = "mediatek,mt8192-m4u", .data = &mt8192_data},
 	{ .compatible = "mediatek,mt8195-iommu-infra", .data = &mt8195_data_infra},
 	{ .compatible = "mediatek,mt8195-iommu-vdo",   .data = &mt8195_data_vdo},
-- 
2.46.0

