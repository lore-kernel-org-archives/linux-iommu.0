Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9D63D79
	for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 12:28:55 +0000 (UTC)
X-UUID: 813b17fc417f48e2a60303c5604a9124-20220714
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:bcb21d38-35d0-4b36-aa84-fad0b587d184,OB:30,L
	OB:20,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,
	ACTION:release,TS:100
X-CID-INFO: VERSION:1.1.8,REQID:bcb21d38-35d0-4b36-aa84-fad0b587d184,OB:30,LOB
	:20,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,
	ACTION:quarantine,TS:100
X-CID-META: VersionHash:0f94e32,CLOUDID:4c5d4d64-0b3f-4b2c-b3a6-ed5c044366a0,C
	OID:efa0f5914d39,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 813b17fc417f48e2a60303c5604a9124-20220714
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <tinghan.shen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1427646156; Thu, 14 Jul 2022 20:28:43 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 14 Jul 2022 20:28:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 14 Jul 2022 20:28:41 +0800
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
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jason-JH.Lin
	<jason-jh.lin@mediatek.com>
Subject: [PATCH v2 18/19] arm64: dts: mt8195: Add gce node
Date: Thu, 14 Jul 2022 20:28:36 +0800
Message-ID: <20220714122837.20094-19-tinghan.shen@mediatek.com>
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

From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>

Add gce node and gce alias to mt8195 device tree.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index e685110144ef..73dcc877b8b6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -6,6 +6,7 @@
 
 /dts-v1/;
 #include <dt-bindings/clock/mt8195-clk.h>
+#include <dt-bindings/gce/mt8195-gce.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/memory/mt8195-memory-port.h>
@@ -19,6 +20,11 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		gce0 = &gce0;
+		gce1 = &gce1;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -738,6 +744,22 @@
 			#iommu-cells = <1>;
 		};
 
+		gce0: mailbox@10320000 {
+			compatible = "mediatek,mt8195-gce";
+			reg = <0 0x10320000 0 0x4000>;
+			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH 0>;
+			#mbox-cells = <2>;
+			clocks = <&infracfg_ao CLK_INFRA_AO_GCE>;
+		};
+
+		gce1: mailbox@10330000 {
+			compatible = "mediatek,mt8195-gce";
+			reg = <0 0x10330000 0 0x4000>;
+			interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH 0>;
+			#mbox-cells = <2>;
+			clocks = <&infracfg_ao CLK_INFRA_AO_GCE2>;
+		};
+
 		scp: scp@10500000 {
 			compatible = "mediatek,mt8195-scp";
 			reg = <0 0x10500000 0 0x100000>,
-- 
2.18.0

