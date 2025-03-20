Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07FF207DE2
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742456226; cv=none; b=mkgcMsHGIaNmZfUw72Q9PLAWFCz5VIOmRqTT5g1BI1QPdCuyHSyBLy6iqyBcvU53zMUO711iGdFsgrwhR87jCtn6saAnGrlygW2E7K4E+SloSq1lgZ7V8hJLJJ5yE/Y6v7sgHoVHplt9Sy7q2IGIbFKomUehJWeKLhWgFz6f9tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742456226; c=relaxed/simple;
	bh=nLsOANJT/aINhdclRfW3Wt3Q2lipBv6ixoIBIFt/J6w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hqs/Goa6fuQg4ANaPJdB79uSg+ihde+kE5admhruHI/U0VikRsEmmnobamREYRDQkUamBXupw8ftr5bYStXfJVoo4DbXPHDgX0dosAQJrlEPZUD0v4AGZd5RXl/mA3e75e9ZH6VWkMgSru9lD1coso6eoqjC1Q0VE+Ag7o5lAdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Gei0cDqU; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Gei0cDqU"
X-UUID: 1b6ea9d6055e11f08eb9c36241bbb6fb-20250320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=RZ2JcBvio+ntIgdmdYECbx7+bIzD61zrEsYhBVvtdO4=;
	b=Gei0cDqUa+PAORV4DDXIdEHKtOSxHuTbrCk/TtXAzQ8QrPmb82KR/7wZ/8U9XKnfu9PQPX7JvP75a93D/4QDNi4E56xMS7sPVS0CbwN3vAWbiKbQd0laeqs+gcV1gFuR9CahWAnwmfSYo0MGZRer0btahf156ayov+R9j9xVu9c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:c5f7bf32-1eee-41f1-9781-dd1d0799f524,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:1fae9c8c-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1b6ea9d6055e11f08eb9c36241bbb6fb-20250320
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <xueqi.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1275332326; Thu, 20 Mar 2025 15:36:59 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 20 Mar 2025 15:36:57 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 20 Mar 2025 15:36:57 +0800
From: Xueqi Zhang <xueqi.zhang@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Wendy-st Lin <wendy-st.lin@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<iommu@lists.linux.dev>, Xueqi Zhang <xueqi.zhang@mediatek.com>
Subject: [PATCH 3/3] memory: mtk-smi: mt8196: Add smi support
Date: Thu, 20 Mar 2025 15:36:18 +0800
Message-ID: <20250320073625.25225-4-xueqi.zhang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250320073625.25225-1-xueqi.zhang@mediatek.com>
References: <20250320073625.25225-1-xueqi.zhang@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for MT8196 SMI common and SMI LARB.
Since the MT8196 SMI connects with SMMU, rather than MTK_IOMMU,
it doesn't componet_add with mtk_iommu. Add a flag
MTK_SMI_FLAG_CONNECT_SMMUV3 for this.

Signed-off-by: Xueqi Zhang <xueqi.zhang@mediatek.com>
---
 drivers/memory/mtk-smi.c | 134 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index b9affa3c3185..bd68df23e40b 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -92,6 +92,7 @@
 #define MTK_SMI_FLAG_SW_FLAG		BIT(1)
 #define MTK_SMI_FLAG_SLEEP_CTL		BIT(2)
 #define MTK_SMI_FLAG_CFG_PORT_SEC_CTL	BIT(3)
+#define MTK_SMI_FLAG_CONNECT_SMMUV3	BIT(4)
 #define MTK_SMI_CAPS(flags, _x)		(!!((flags) & (_x)))
 
 struct mtk_smi_reg_pair {
@@ -275,6 +276,9 @@ static int mtk_smi_larb_config_port_gen2_general(struct device *dev)
 		}
 	}
 
+	if (MTK_SMI_CAPS(larb->larb_gen->flags_general, MTK_SMI_FLAG_CONNECT_SMMUV3))
+		return 0;
+
 	for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
 		reg = readl_relaxed(larb->base + SMI_LARB_NONSEC_CON(i));
 		reg |= F_MMU_EN;
@@ -410,6 +414,101 @@ static const u8 mtk_smi_larb_mt8195_ostd[][SMI_LARB_PORT_NR_MAX] = {
 	[28] = {0x1a, 0x0e, 0x0a, 0x0a, 0x0c, 0x0e, 0x10,},
 };
 
+static const u8 mtk_smi_larb_mt8196_ostd[][SMI_LARB_PORT_NR_MAX] = {
+	[0] = {0x4, 0x4, 0x40, 0x40, 0x1, 0x1, 0x2, 0x2, 0x4, 0x4,
+	       0x1, 0x1, 0x1,},
+	[1] = {0x4, 0x4, 0x40, 0x40, 0x32, 0x1, 0x2, 0x2, 0x2, 0x4,
+	       0x4, 0x2, 0x1, 0x1, 0x1, 0x1,},
+	[2] = {0x1, 0x1, 0x1, 0x1, 0x9, 0xb, 0x2a, 0x1, 0x1, 0x1,
+	       0x1, 0x1, 0x1, 0x1, 0x3, 0x1c, 0x1, 0x1,},
+	[3] = {0x2, 0x2, 0x2, 0x2, 0x1a, 0x20, 0x2a, 0x2, 0x1, 0x1,
+	       0x1, 0x1, 0x1, 0x2, 0x8, 0x1c, 0x1, 0x1,},
+	[4] = {0x40, 0x10, 0x10, 0x1, 0x4, 0x10, 0x8, 0x8,},
+	[5] = {0x10, 0x8, 0x40, 0x1e, 0x8, 0x8, 0x4, 0x1,},
+	[6] = {0x40, 0x12, 0x1,},
+	[7] = {0x20, 0x6, 0x6, 0x1, 0x1, 0x24, 0x2b, 0x7, 0x4, 0x1,
+	       0x1, 0xf, 0x3, 0x5, 0x8, 0x8, 0x3, 0x8, 0x5, 0x23,
+	       0x24, 0x4, 0x2, 0xb, 0x10, 0x17, 0x4, 0x8, 0x5, 0x1,
+	       0x1, 0x6,},
+	[8] = {0x20, 0x6, 0x6, 0x1, 0x1, 0x24, 0x2b, 0x7, 0x4, 0x1,
+	       0x1, 0xf, 0x3, 0x5, 0x8, 0x8, 0x3, 0x8, 0x5, 0x23,
+	       0x24, 0x4, 0x2, 0xb, 0x10, 0x17, 0x4, 0x8, 0x5, 0x1,
+	       0x1, 0x6,},
+	[9] = {0x2b, 0x8, 0x9, 0x31, 0x10, 0x26, 0x15, 0x13, 0x7, 0x4,
+	       0x1, 0x1, 0x7, 0xa, 0xb, 0x6, 0x1, 0x1, 0x1, 0x1,
+	       0x1, 0x1, 0xf, 0x9, 0x6, 0x3,},
+	[10] = {0x2b, 0x8, 0x20, 0x1d, 0x19, 0xf, 0x1, 0x3,},
+	[11] = {0x8, 0x16, 0x16, 0x24, 0x1, 0x1, 0x1, 0x3, 0x32, 0x1,
+		0x8, 0x10, 0x16, 0x2, 0x38,},
+	[12] = {0xa, 0xa, 0x1,},
+	[13] = {0x2, 0x20, 0x14, 0x1, 0x1, 0x2, 0x2,},
+	[14] = {0x2, 0x20, 0x14, 0x1, 0x2, 0x2,},
+	[15] = {0x2b, 0x7, 0x31, 0xa, 0x10, 0x10, 0x2b, 0x29, 0x7, 0x1,},
+	[16] = {0x4, 0x4, 0x12, 0x8, 0x8, 0x16, 0x8, 0x6, 0xe, 0x6,
+		0x1e, 0x18, 0x16, 0xe, 0x8, 0xe, 0x8, 0x2, 0x2,},
+	[17] = {0x18, 0x18, 0x8, 0x8, 0xc, 0x4, 0x2,},
+	[18] = {0xb, 0x1, 0x10, 0x1, 0x2,},
+	[19] = {0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x4, 0x2, 0x1, 0x1,
+		0x4, 0x2, 0x1,},
+	[20] = {0x2, 0x2, 0x2, 0x40, 0x40, 0x40, 0x1, 0x2, 0x2, 0x2,
+		0x4, 0x4, 0x4, 0x1, 0x1,},
+	[21] = {0x2, 0x2, 0x2, 0x40, 0x40, 0x40, 0x1, 0x32, 0x32, 0x32,
+		0x2, 0x2, 0x2, 0x4, 0x4, 0x4, 0x2, 0x1,},
+	[22] = {0x8, 0x16, 0x16, 0x24, 0x1, 0x1, 0x1, 0x3, 0x32, 0x1,
+		0x8, 0x10, 0x16, 0x2, 0x38,},
+	[23] = {0x8, 0x16, 0x16, 0x24, 0x1, 0x1, 0x1, 0x3, 0x32, 0x1,
+		0x8, 0x10, 0x16, 0x2, 0x38,},
+	[24] = {0x20, 0x6, 0x6, 0x1, 0x1, 0x24, 0x2b, 0x7, 0x4, 0x1,
+		0x1, 0xf, 0x3, 0x5, 0x8, 0x8, 0x3, 0x8, 0x5, 0x23,
+		0x24, 0x4, 0x2, 0xb, 0x10, 0x17, 0x4, 0x8, 0x5, 0x1,
+		0x1, 0x6,},
+	[25] = {0x2, 0xc, 0x2, 0xc, 0x6, 0x6, 0x3, 0x3, 0x3, 0x1,
+		0x1, 0x2, 0x2,},
+	[26] = {0x2, 0xc, 0x2, 0xc, 0x6, 0x6, 0x3, 0x3, 0x3, 0x1,
+		0x1, 0x2, 0x2,},
+	[27] = {0x6, 0x2, 0xe, 0x6, 0x2, 0x14, 0x14, 0x4, 0x6,},
+	[28] = {0x2b, 0x8, 0x31, 0x10, 0x26, 0x15, 0x1, 0x10,},
+	[29] = {0x2, 0x2, 0x2, 0x2, 0x10, 0xe, 0x6, 0x6, 0x1, 0x1,
+		0x2, 0x2, 0x2, 0x2,},
+	[30] = {0x2, 0x2, 0x2, 0x2,},
+	[31] = {},
+	[32] = {0x1, 0x1, 0x1, 0x1, 0x2, 0x2, 0x32, 0x32, 0x1, 0x2,},
+	[33] = {0xa, 0x1, 0x1, 0x1, 0xa, 0xa, 0xa, 0x1, 0x26, 0x32,
+		0x32, 0x32, 0x32, 0x32, 0x2, 0x1,},
+	[34] = {0x4, 0x4, 0x40, 0x40, 0x1, 0x1, 0x2, 0x2, 0x4, 0x4,
+		0x1, 0x1, 0x1,},
+	[35] = {0x4, 0x4, 0x40, 0x40, 0x32, 0x1, 0x2, 0x2, 0x2, 0x4,
+		0x4, 0x2, 0x1, 0x1, 0x1, 0x1,},
+	[36] = {0x2, 0x2, 0x2, 0x40, 0x40, 0x40, 0x1, 0x2, 0x2, 0x2,
+		0x4, 0x4, 0x4, 0x1, 0x1,},
+	[37] = {0x2, 0x2, 0x2, 0x40, 0x40, 0x40, 0x1, 0x32, 0x32, 0x32,
+		0x2, 0x2, 0x2, 0x4, 0x4, 0x4, 0x2, 0x1,},
+	[38] = {0x29, 0x40, 0x40, 0x7, 0x4, 0x40, 0x4, 0x18, 0x1, 0x1,
+		0x1, 0x7, 0x4,},
+	[39] = {0x16, 0x4, 0x4, 0x8, 0x4, 0x6, 0x6, 0x13, 0x11, 0x20,
+		0x11, 0x1, 0x1, 0x1, 0x9, 0x8, 0x4, 0x6, 0x6,},
+	[40] = {0x9, 0x7, 0x7, 0xb, 0xf, 0x1d, 0x13, 0x6, 0x1, 0x1,
+		0x1, 0x6, 0x9, 0x7, 0xe, 0x3,},
+	[41] = {0x40, 0x8, 0x1, 0x1, 0x2, 0x1, 0x1, 0x1, 0x1, 0x1,
+		0x8, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1,
+		0x1, 0x8, 0x8, 0x8, 0x8, 0x8, 0x1, 0x1, 0x1, 0x1,
+		0x1, 0x1,},
+	[42] = {0x1, 0x8, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1,
+		0x8, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1,
+		0x1, 0x8, 0x8, 0x8, 0x8, 0x8, 0x1, 0x1, 0x1, 0x1,
+		0x1, 0x1,},
+	[43] = {0x4, 0x4, 0x12, 0x8, 0x8, 0x16, 0x8, 0x6, 0xe, 0x6,
+		0x1e, 0x18, 0x16, 0xe, 0x8, 0xe, 0x8, 0x1, 0x1,},
+	[44] = {0x4, 0x4, 0x12, 0x8, 0x8, 0x16, 0x8, 0x6, 0xe, 0x6,
+		0x1e, 0x18, 0x16, 0xe, 0x8, 0xe, 0x8, 0x1, 0x1,},
+	[45] = {0x18, 0x18, 0x8, 0x8, 0xc, 0x4, 0x1,},
+	[46] = {0x18, 0x18, 0x8, 0x8, 0xc, 0x4, 0x1,},
+	[47] = {0x1, 0x8, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1,
+		0x8, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1, 0x1,
+		0x1, 0x8, 0x8, 0x8, 0x8, 0x8, 0x1, 0x1, 0x1, 0x1,
+		0x1, 0x1,},
+};
+
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt2701 = {
 	.port_in_larb = {
 		LARB0_PORT_OFFSET, LARB1_PORT_OFFSET,
@@ -470,6 +569,13 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt8195 = {
 	.ostd		            = mtk_smi_larb_mt8195_ostd,
 };
 
+static const struct mtk_smi_larb_gen mtk_smi_larb_mt8196 = {
+	.config_port                = mtk_smi_larb_config_port_gen2_general,
+	.flags_general	            = MTK_SMI_FLAG_THRT_UPDATE | MTK_SMI_FLAG_SW_FLAG |
+				      MTK_SMI_FLAG_SLEEP_CTL | MTK_SMI_FLAG_CONNECT_SMMUV3,
+	.ostd		            = mtk_smi_larb_mt8196_ostd,
+};
+
 static const struct of_device_id mtk_smi_larb_of_ids[] = {
 	{.compatible = "mediatek,mt2701-smi-larb", .data = &mtk_smi_larb_mt2701},
 	{.compatible = "mediatek,mt2712-smi-larb", .data = &mtk_smi_larb_mt2712},
@@ -482,6 +588,7 @@ static const struct of_device_id mtk_smi_larb_of_ids[] = {
 	{.compatible = "mediatek,mt8188-smi-larb", .data = &mtk_smi_larb_mt8188},
 	{.compatible = "mediatek,mt8192-smi-larb", .data = &mtk_smi_larb_mt8192},
 	{.compatible = "mediatek,mt8195-smi-larb", .data = &mtk_smi_larb_mt8195},
+	{.compatible = "mediatek,mt8196-smi-larb", .data = &mtk_smi_larb_mt8196},
 	{}
 };
 MODULE_DEVICE_TABLE(of, mtk_smi_larb_of_ids);
@@ -569,6 +676,7 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 {
 	struct mtk_smi_larb *larb;
 	struct device *dev = &pdev->dev;
+	bool connect_with_smmuv3;
 	int ret;
 
 	larb = devm_kzalloc(dev, sizeof(*larb), GFP_KERNEL);
@@ -580,6 +688,13 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	if (IS_ERR(larb->base))
 		return PTR_ERR(larb->base);
 
+	connect_with_smmuv3 = MTK_SMI_CAPS(larb->larb_gen->flags_general,
+					   MTK_SMI_FLAG_CONNECT_SMMUV3);
+	if (connect_with_smmuv3 && !IS_ENABLED(CONFIG_ARM_SMMU_V3)) {
+		dev_err(dev, " SMMU property conflict.\n");
+		return -EINVAL;
+	}
+
 	ret = mtk_smi_dts_clk_init(dev, &larb->smi, mtk_smi_larb_clks,
 				   MTK_SMI_LARB_REQ_CLK_NR, MTK_SMI_LARB_OPT_CLK_NR);
 	if (ret)
@@ -593,6 +708,10 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 	platform_set_drvdata(pdev, larb);
+
+	if (!connect_with_smmuv3)
+		return 0;
+
 	ret = component_add(dev, &mtk_smi_larb_component_ops);
 	if (ret)
 		goto err_pm_disable;
@@ -610,7 +729,8 @@ static void mtk_smi_larb_remove(struct platform_device *pdev)
 
 	device_link_remove(&pdev->dev, larb->smi_common_dev);
 	pm_runtime_disable(&pdev->dev);
-	component_del(&pdev->dev, &mtk_smi_larb_component_ops);
+	if (!MTK_SMI_CAPS(larb->larb_gen->flags_general, MTK_SMI_FLAG_CONNECT_SMMUV3))
+		component_del(&pdev->dev, &mtk_smi_larb_component_ops);
 }
 
 static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
@@ -750,6 +870,16 @@ static const struct mtk_smi_common_plat mtk_smi_sub_common_mt8195 = {
 	.has_gals = true,
 };
 
+static const struct mtk_smi_common_plat mtk_smi_common_mt8196 = {
+	.type     = MTK_SMI_GEN2,
+	.skip_rpm = true,
+};
+
+static const struct mtk_smi_common_plat mtk_smi_sub_common_mt8196 = {
+	.type     = MTK_SMI_GEN2_SUB_COMM,
+	.skip_rpm = true,
+};
+
 static const struct mtk_smi_common_plat mtk_smi_common_mt8365 = {
 	.type     = MTK_SMI_GEN2,
 	.bus_sel  = F_MMU1_LARB(2) | F_MMU1_LARB(4),
@@ -770,6 +900,8 @@ static const struct of_device_id mtk_smi_common_of_ids[] = {
 	{.compatible = "mediatek,mt8195-smi-common-vdo", .data = &mtk_smi_common_mt8195_vdo},
 	{.compatible = "mediatek,mt8195-smi-common-vpp", .data = &mtk_smi_common_mt8195_vpp},
 	{.compatible = "mediatek,mt8195-smi-sub-common", .data = &mtk_smi_sub_common_mt8195},
+	{.compatible = "mediatek,mt8196-smi-common", .data = &mtk_smi_common_gen2},
+	{.compatible = "mediatek,mt8196-smi-sub-common", .data = &mtk_smi_sub_common_mt8196},
 	{.compatible = "mediatek,mt8365-smi-common", .data = &mtk_smi_common_mt8365},
 	{}
 };
-- 
2.46.0

