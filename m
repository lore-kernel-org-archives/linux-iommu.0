From: <honghui.zhang@mediatek.com>
Subject: [PATCH 3/3] arm: dts: mediatek: add larbid property for larb
Date: Thu, 27 Jul 2017 10:01:12 +0800
Message-ID: <1501120872-19652-4-git-send-email-honghui.zhang@mediatek.com>
References: <1501120872-19652-1-git-send-email-honghui.zhang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501120872-19652-1-git-send-email-honghui.zhang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, matthias.bgg@gmail.com, robh@kernel.org, robin.murphy@arm.com
Cc: devicetree@vger.kernel.org, kendrick.hsu@mediatek.com, srv_heupstream@mediatek.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, robh+dt@kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, youlin.pei@mediatek.com, erin.lo@mediatek.com, yong.wu@mediatek.com, xinping.qian@mediatek.com, Honghui Zhang <honghui.zhang@mediatek.com>
List-Id: iommu@lists.linux-foundation.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

Add mediatek's hardware id information for smi larb.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 arch/arm/boot/dts/mt2701.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index f1efdc6..2cddbec 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -533,6 +533,7 @@
 		compatible = "mediatek,mt2701-smi-larb";
 		reg = <0 0x14010000 0 0x1000>;
 		mediatek,smi = <&smi_common>;
+		mediatek,larbid = <0>;
 		clocks = <&mmsys CLK_MM_SMI_LARB0>,
 			 <&mmsys CLK_MM_SMI_LARB0>;
 		clock-names = "apb", "smi";
@@ -549,6 +550,7 @@
 		compatible = "mediatek,mt2701-smi-larb";
 		reg = <0 0x15001000 0 0x1000>;
 		mediatek,smi = <&smi_common>;
+		mediatek,larbid = <2>;
 		clocks = <&imgsys CLK_IMG_SMI_COMM>,
 			 <&imgsys CLK_IMG_SMI_COMM>;
 		clock-names = "apb", "smi";
@@ -579,6 +581,7 @@
 		compatible = "mediatek,mt2701-smi-larb";
 		reg = <0 0x16010000 0 0x1000>;
 		mediatek,smi = <&smi_common>;
+		mediatek,larbid = <1>;
 		clocks = <&vdecsys CLK_VDEC_CKGEN>,
 			 <&vdecsys CLK_VDEC_LARB>;
 		clock-names = "apb", "smi";
-- 
2.6.4
