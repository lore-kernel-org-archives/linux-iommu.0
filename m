Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9F0323E
	for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 12:28:54 +0000 (UTC)
X-UUID: 21de15206ae34c49a19b3adfc50485fc-20220714
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:011303bb-037e-4422-8b2c-f0599906ebe9,OB:10,L
	OB:10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,
	ACTION:release,TS:100
X-CID-INFO: VERSION:1.1.8,REQID:011303bb-037e-4422-8b2c-f0599906ebe9,OB:10,LOB
	:10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,
	ACTION:quarantine,TS:100
X-CID-META: VersionHash:0f94e32,CLOUDID:2b5d4d64-0b3f-4b2c-b3a6-ed5c044366a0,C
	OID:953eaa8bce81,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 21de15206ae34c49a19b3adfc50485fc-20220714
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
	(envelope-from <tinghan.shen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
	with ESMTP id 753444863; Thu, 14 Jul 2022 20:28:41 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 14 Jul 2022 20:28:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 14 Jul 2022 20:28:40 +0800
From: Tinghan Shen <tinghan.shen@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Rob Herring <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Lee Jones
	<lee.jones@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, "Tinghan
 Shen" <tinghan.shen@mediatek.com>, Chun-Jie Chen
	<chun-jie.chen@mediatek.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "MandyJH Liu"
	<mandyjh.liu@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
CC: <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2 10/19] arm64: dts: mt8195: Add vdosys and vppsys clock nodes
Date: Thu, 14 Jul 2022 20:28:28 +0800
Message-ID: <20220714122837.20094-11-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220714122837.20094-1-tinghan.shen@mediatek.com>
References: <20220714122837.20094-1-tinghan.shen@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Add display clock nodes.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 900aaa16f862..8d59a7da3271 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -983,6 +983,12 @@
 			#clock-cells = <1>;
 		};
 
+		vppsys0: clock-controller@14000000 {
+			compatible = "mediatek,mt8195-vppsys0";
+			reg = <0 0x14000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		wpesys: clock-controller@14e00000 {
 			compatible = "mediatek,mt8195-wpesys";
 			reg = <0 0x14e00000 0 0x1000>;
@@ -1001,6 +1007,12 @@
 			#clock-cells = <1>;
 		};
 
+		vppsys1: clock-controller@14f00000 {
+			compatible = "mediatek,mt8195-vppsys1";
+			reg = <0 0x14f00000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		imgsys: clock-controller@15000000 {
 			compatible = "mediatek,mt8195-imgsys";
 			reg = <0 0x15000000 0 0x1000>;
@@ -1108,5 +1120,17 @@
 			reg = <0 0x1b000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
+
+		vdosys0: syscon@1c01a000 {
+			compatible = "mediatek,mt8195-mmsys", "syscon";
+			reg = <0 0x1c01a000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
+		vdosys1: syscon@1c100000 {
+			compatible = "mediatek,mt8195-mmsys", "syscon";
+			reg = <0 0x1c100000 0 0x1000>;
+			#clock-cells = <1>;
+		};
 	};
 };
-- 
2.18.0

