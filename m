Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE5323A0
	for <iommu@lists.linux.dev>; Wed, 15 Feb 2023 06:27:45 +0000 (UTC)
X-UUID: d8616ad4acf911eda06fc9ecc4dadd91-20230215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=E1eYIKz4FedKViyC8BBRJuxfo8KJJrAGDyq9yzdbtXw=;
	b=inB1nYFLXsP6xDTgqTnW6gaH+CAxuO/JApLwnycIE5N6jMJI3Zk2B+O1V6wmBAbZ1nyVX5k2NXl8Lj5HGEe9eSHFatWUfDMHkrSktg+0zmXsaC/ccTteQNbPfh/l70PIMM0eQBm86VPEyQ5baFTXYHI6IpT6QQCcgMOWIV7gKfg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:7bcd89a6-e738-484f-8541-5c83c798c7d4,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:885ddb2,CLOUDID:044d9f25-564d-42d9-9875-7c868ee415ec,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: d8616ad4acf911eda06fc9ecc4dadd91-20230215
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1290366785; Wed, 15 Feb 2023 14:27:39 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 15 Feb 2023 14:27:38 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 15 Feb 2023 14:27:37 +0800
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
Subject: [PATCH v4 08/11] iommu/mediatek: Add a gap for the iova regions
Date: Wed, 15 Feb 2023 14:25:41 +0800
Message-ID: <20230215062544.8677-9-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230215062544.8677-1-yong.wu@mediatek.com>
References: <20230215062544.8677-1-yong.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

As the removed property in the vcodec dt-binding, the property is:
dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;

The length is 0xfff0_0000 rather than 0x1_0000_0000, this means it
requires 1M as a gap. This is because the end address for some vcodec
HW is (address + size). If the size is 4G, the end address may be
0x2_0000_0000, and the width for vcodec register only is 32, then the
HW may get the ZERO address.

Currently the consumer's dma-ranges property doesn't work, IOMMU
has to consider this case. Add a bigger gap(8M) for all the regions
to avoid it.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
Hi AngeloGioacchino,
I define a new macro for this, I think it is a small change, thus keep
you R-b.
Thanks.
---
 drivers/iommu/mtk_iommu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index fbfc5e4e56a8..e0264d5f1c9a 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -332,8 +332,10 @@ static LIST_HEAD(m4ulist);	/* List all the M4U HWs */
 
 #define for_each_m4u(data, head)  list_for_each_entry(data, head, list)
 
+#define MTK_IOMMU_IOVA_SZ_4G		(SZ_4G - SZ_8M) /* 8M as gap */
+
 static const struct mtk_iommu_iova_region single_domain[] = {
-	{.iova_base = 0,		.size = SZ_4G},
+	{.iova_base = 0,		.size = MTK_IOMMU_IOVA_SZ_4G},
 };
 
 #define MT8192_MULTI_REGION_NR_MAX	6
@@ -342,11 +344,11 @@ static const struct mtk_iommu_iova_region single_domain[] = {
 				 MT8192_MULTI_REGION_NR_MAX : 1)
 
 static const struct mtk_iommu_iova_region mt8192_multi_dom[MT8192_MULTI_REGION_NR] = {
-	{ .iova_base = 0x0,		.size = SZ_4G},		/* 0 ~ 4G */
+	{ .iova_base = 0x0,		.size = MTK_IOMMU_IOVA_SZ_4G},	/* 0 ~ 4G,  */
 	#if IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT)
-	{ .iova_base = SZ_4G,		.size = SZ_4G},		/* 4G ~ 8G */
-	{ .iova_base = SZ_4G * 2,	.size = SZ_4G},		/* 8G ~ 12G */
-	{ .iova_base = SZ_4G * 3,	.size = SZ_4G},		/* 12G ~ 16G */
+	{ .iova_base = SZ_4G,		.size = MTK_IOMMU_IOVA_SZ_4G},	/* 4G ~ 8G */
+	{ .iova_base = SZ_4G * 2,	.size = MTK_IOMMU_IOVA_SZ_4G},	/* 8G ~ 12G */
+	{ .iova_base = SZ_4G * 3,	.size = MTK_IOMMU_IOVA_SZ_4G},	/* 12G ~ 16G */
 
 	{ .iova_base = 0x240000000ULL,	.size = 0x4000000},	/* CCU0 */
 	{ .iova_base = 0x244000000ULL,	.size = 0x4000000},	/* CCU1 */
-- 
2.18.0

