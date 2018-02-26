From: Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH 7/8] arm64: dts: renesas: r8a77965: Add IPMMU mm and ds0 blocks
Date: Mon, 26 Feb 2018 18:57:15 +0100
Message-ID: <1519667836-31330-8-git-send-email-jacopo+renesas@jmondi.org>
References: <1519667836-31330-1-git-send-email-jacopo+renesas@jmondi.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519667836-31330-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
To: geert@linux-m68k.org, horms@verge.net.au, sergei.shtylyov@cogentembedded.com, magnus.damm@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Add IPMMU device nodes for mm and ds0 domains. "ipmmu_ds0" is a
dependency for EtherAVB enablement and it has "ipmmu_mm" as it main
ipmmu.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 8c9648a..b3c0be8 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -169,6 +169,23 @@
 			reg = <0 0xe6060000 0 0x50c>;
 		};
 
+		ipmmu_ds0: mmu@e6740000 {
+			compatible = "renesas,ipmmu-r8a77965";
+			reg = <0 0xe6740000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 0>;
+			power-domains = <&sysc 32>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_mm: mmu@e67b0000 {
+			compatible = "renesas,ipmmu-r8a77965";
+			reg = <0 0xe67b0000 0 0x1000>;
+			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&sysc 32>;
+			#iommu-cells = <1>;
+		};
+
 		cpg: clock-controller@e6150000 {
 			compatible = "renesas,r8a77965-cpg-mssr";
 			reg = <0 0xe6150000 0 0x1000>;
-- 
2.7.4
