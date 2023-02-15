Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9496523A0
	for <iommu@lists.linux.dev>; Wed, 15 Feb 2023 06:28:14 +0000 (UTC)
X-UUID: eb163dd0acf911ed945fc101203acc17-20230215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=BZeA43XoOAkEaxyj8RL5V/54tyfKVdYzibdG9XTu4Dc=;
	b=ZGRurWujtxttC3b1CTsAS9D4DsEJM62Sy3VqQgk3ygjZsoP8wlF1343tj9S9yUA25oOMc/H8wy22OV5BhxlwNw3bbQq2wtvRjzXrkRzrs9/Y4DFjRDKEQgbTtAGj1KnYHGNhSYk1tTkKUm03v/S3fJqxWrWySqOf8KfuVj128Ho=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:d31faf85-5213-4142-b3c1-909529df2372,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:bf519f25-564d-42d9-9875-7c868ee415ec,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: eb163dd0acf911ed945fc101203acc17-20230215
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 107328126; Wed, 15 Feb 2023 14:28:10 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 15 Feb 2023 14:28:09 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 15 Feb 2023 14:28:08 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Hans Verkuil
	<hverkuil@xs4all.nl>, <nfraprado@collabora.com>,
	<linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>, "AngeloGioacchino
 Del Regno" <angelogioacchino.delregno@collabora.com>,
	<mingyuan.ma@mediatek.com>, <yf.wang@mediatek.com>,
	<jianjiao.zeng@mediatek.com>, Yunfei Dong <yunfei.dong@mediatek.com>, kyrie
 wu <kyrie.wu@mediatek.corp-partner.google.com>, <chengci.xu@mediatek.com>,
	<youlin.pei@mediatek.com>, <anan.sun@mediatek.com>, Yong Wu
	<yong.wu@mediatek.com>
Subject: [PATCH v4 11/11] arm64: dts: mt8186: Add dma-ranges for the parent "soc" node
Date: Wed, 15 Feb 2023 14:25:44 +0800
Message-ID: <20230215062544.8677-12-yong.wu@mediatek.com>
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

Prepare for the MM nodes whose dma-ranges(iova range) is 16GB.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index a0d3e1f731bd..251eace411c0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -324,6 +324,7 @@
 		#address-cells = <2>;
 		#size-cells = <2>;
 		compatible = "simple-bus";
+		dma-ranges = <0x0 0x0 0x0 0x0 0x4 0x0>;
 		ranges;
 
 		gic: interrupt-controller@c000000 {
-- 
2.18.0

