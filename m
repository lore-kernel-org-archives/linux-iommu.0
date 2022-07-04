Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1F5CCA479
	for <iommu@archiver.kernel.org>; Mon,  4 Jul 2022 12:18:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 128A660E5B;
	Mon,  4 Jul 2022 12:18:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 128A660E5B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AoPKXsNjt1y7; Mon,  4 Jul 2022 12:18:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BEEBC60E82;
	Mon,  4 Jul 2022 12:18:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BEEBC60E82
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5A56C0084;
	Mon,  4 Jul 2022 12:18:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3104C007E
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 10:00:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0C4C082438
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 10:00:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0C4C082438
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S1-MtjWr1lZO for <iommu@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 10:00:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 47573826C2
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 47573826C2
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 10:00:45 +0000 (UTC)
X-UUID: e8f70a3c1df64427b253a9dc09f4c9ef-20220704
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7, REQID:d3b62762-9615-45a7-a27b-1f30902318de, OB:10,
 L
 OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
 TION:release,TS:95
X-CID-INFO: VERSION:1.1.7, REQID:d3b62762-9615-45a7-a27b-1f30902318de, OB:10,
 LOB
 :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
 TION:quarantine,TS:95
X-CID-META: VersionHash:87442a2, CLOUDID:04d78dd6-5d6d-4eaf-a635-828a3ee48b7c,
 C
 OID:7dbd4918245b,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
 RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: e8f70a3c1df64427b253a9dc09f4c9ef-20220704
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
 (envelope-from <tinghan.shen@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 466399376; Mon, 04 Jul 2022 18:00:32 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 4 Jul 2022 18:00:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 4 Jul 2022 18:00:31 +0800
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Rob Herring <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Chun-Jie Chen <chun-jie.chen@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Enric
 Balletbo i Serra" <enric.balletbo@collabora.com>, Tinghan Shen
 <tinghan.shen@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v1 15/16] arm64: dts: mt8195: Add gce node
Date: Mon, 4 Jul 2022 18:00:27 +0800
Message-ID: <20220704100028.19932-16-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220704100028.19932-1-tinghan.shen@mediatek.com>
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-Mailman-Approved-At: Mon, 04 Jul 2022 12:18:20 +0000
Cc: devicetree@vger.kernel.org, "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 linux-kernel@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
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
From: Tinghan Shen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tinghan Shen <tinghan.shen@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>

Add gce node and gce alias to mt8195 device tree.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index cb2b79dc08d1..724c6ca837b6 100644
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
@@ -739,6 +745,22 @@
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

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
