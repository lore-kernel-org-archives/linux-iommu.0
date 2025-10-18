Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7DF2C2345
	for <iommu@lists.linux.dev>; Sat, 18 Oct 2025 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760793998; cv=none; b=HwSL8QKX/JQIsQ5AWEBdw6J7IJzXR3qhtb6nSjvuFW9taBS0sSrt3LLgWI/11/paoKx7+cxvMhwodC8bwolkfzPPS3p39hv96z4cH7hLTS7WFTbIEjMcQr6bCVilt6BcBlu3b83luQjhv3tTwx/eDbDM43jpTqBwHEn14WsZ148=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760793998; c=relaxed/simple;
	bh=d3ZRTqq8oY4tvFs/w8o9hnTP0NNMkWZmCSeXgh7t2L0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B4iqBFEP69VMKF/bVGHFJfsEth3jrO8nhg3b5l3/SaMpdI6fJKOUTrBKJWFH3IYoIQjHIVdPxGJFR9nLHy2NbGeWxzGEeqR1K1xyaDvcG10aexCSyVjnhfBCBLyP7tpsJQBW6xm9mUKbFbktqVsCz8zOUMqsIBUKLCD3YCkV8sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=oHwWY3ym; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oHwWY3ym"
X-UUID: 101c9d8aac2611f0ae1e63ff8927bad3-20251018
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=04SPNdypq8BzPHyzJAmOyyaUpk+WGKWjOgL5LooRZ9Y=;
	b=oHwWY3ymaDttAFYCGg6MK4OfAFhoZCgRdu4ZUg9mfNH8VjSp8OPzolcy+qZ9AyoyXsmfA6Kks/9bU9V6kf0xiUPpbWYT7jGMxaRzwxolUdHtXtJzOtrDH/3QuOgElxgDfJ/uh347otk9JMx2pgll80bOHmMx+nifhPEEKVI99ZU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:fe72f3e7-9c4f-4c54-bddd-a335d852b058,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:0e335a86-2e17-44e4-a09c-1e463bf6bc47,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 101c9d8aac2611f0ae1e63ff8927bad3-20251018
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <zhengnan.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 406129697; Sat, 18 Oct 2025 21:26:32 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sat, 18 Oct 2025 21:26:28 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Sat, 18 Oct 2025 21:26:27 +0800
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
Subject: [PATCH v4 3/5] iommu/mediatek: mt8189: Add APU IOMMUs support
Date: Sat, 18 Oct 2025 21:26:12 +0800
Message-ID: <20251018132625.14428-4-zhengnan.chen@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20251018132625.14428-1-zhengnan.chen@mediatek.com>
References: <20251018132625.14428-1-zhengnan.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for mt8189 APU IOMMUs.

Signed-off-by: Zhengnan Chen <zhengnan.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 7af47c59b10b..aa4972aed91e 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -139,6 +139,7 @@
 /* 2 bits: iommu type */
 #define MTK_IOMMU_TYPE_MM		(0x0 << 13)
 #define MTK_IOMMU_TYPE_INFRA		(0x1 << 13)
+#define MTK_IOMMU_TYPE_APU		(0x2 << 13)
 #define MTK_IOMMU_TYPE_MASK		(0x3 << 13)
 /* PM and clock always on. e.g. infra iommu */
 #define PM_CLK_AO			BIT(15)
@@ -173,6 +174,7 @@ enum mtk_iommu_plat {
 	M4U_MT8183,
 	M4U_MT8186,
 	M4U_MT8188,
+	M4U_MT8189,
 	M4U_MT8192,
 	M4U_MT8195,
 	M4U_MT8365,
@@ -336,6 +338,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data, unsigned int ban
  */
 #define MTK_IOMMU_4GB_MODE_REMAP_BASE	 0x140000000UL
 
+static LIST_HEAD(apulist);	/* List the apu iommu HWs */
 static LIST_HEAD(m4ulist);	/* List all the M4U HWs */
 
 #define for_each_m4u(data, head)  list_for_each_entry(data, head, list)
@@ -351,6 +354,15 @@ static const struct mtk_iommu_iova_region single_domain[] = {
 #define MT8192_MULTI_REGION_NR	(IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT) ? \
 				 MT8192_MULTI_REGION_NR_MAX : 1)
 
+static const struct mtk_iommu_iova_region mt8189_multi_dom_apu[] = {
+	{ .iova_base = 0x200000ULL,	.size = SZ_512M},	/* APU SECURE */
+#if IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT)
+	{ .iova_base = SZ_1G,		.size = 0xc0000000},	/* APU CODE */
+	{ .iova_base = 0x70000000ULL,	.size = 0x12600000},	/* APU VLM */
+	{ .iova_base = SZ_4G,		.size = SZ_4G * 3},	/* APU VPU */
+#endif
+};
+
 static const struct mtk_iommu_iova_region mt8192_multi_dom[MT8192_MULTI_REGION_NR] = {
 	{ .iova_base = 0x0,		.size = MTK_IOMMU_IOVA_SZ_4G},	/* 0 ~ 4G,  */
 	#if IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT)
@@ -1725,6 +1737,27 @@ static const struct mtk_iommu_plat_data mt8188_data_vpp = {
 			   27, 28 /* ccu0 */, MTK_INVALID_LARBID}, {4, 6}},
 };
 
+static const unsigned int mt8189_apu_region_msk[][MTK_LARB_NR_MAX] = {
+	[0] = {[0] = BIT(2)},	/* Region0: fake larb 0 APU_SECURE */
+	[1] = {[0] = BIT(1)},	/* Region1: fake larb 0 APU_CODE */
+	[2] = {[0] = BIT(3)},	/* Region2: fake larb 0 APU_VLM */
+	[3] = {[0] = BIT(0)},	/* Region3: fake larb 0 APU_DATA */
+};
+
+static const struct mtk_iommu_plat_data mt8189_data_apu = {
+	.m4u_plat       = M4U_MT8189,
+	.flags          = IOVA_34_EN | DCM_DISABLE |
+			  MTK_IOMMU_TYPE_APU | PGTABLE_PA_35_EN,
+	.hw_list        = &apulist,
+	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
+	.banks_num	= 1,
+	.banks_enable	= {true},
+	.iova_region	= mt8189_multi_dom_apu,
+	.iova_region_nr	= ARRAY_SIZE(mt8189_multi_dom_apu),
+	.larbid_remap   = {{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}},
+	.iova_region_larb_msk = mt8189_apu_region_msk,
+};
+
 static const struct mtk_iommu_plat_data mt8192_data = {
 	.m4u_plat       = M4U_MT8192,
 	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN |
@@ -1826,6 +1859,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt8188-iommu-infra", .data = &mt8188_data_infra},
 	{ .compatible = "mediatek,mt8188-iommu-vdo",   .data = &mt8188_data_vdo},
 	{ .compatible = "mediatek,mt8188-iommu-vpp",   .data = &mt8188_data_vpp},
+	{ .compatible = "mediatek,mt8189-iommu-apu",   .data = &mt8189_data_apu},
 	{ .compatible = "mediatek,mt8192-m4u", .data = &mt8192_data},
 	{ .compatible = "mediatek,mt8195-iommu-infra", .data = &mt8195_data_infra},
 	{ .compatible = "mediatek,mt8195-iommu-vdo",   .data = &mt8195_data_vdo},
-- 
2.46.0

