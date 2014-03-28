From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 5/5] [TEST] ARM: shmobile: r8a7791: Enable IOMMU support for the VSP1
Date: Sat, 29 Mar 2014 00:36:21 +0100
Message-ID: <1396049781-12941-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1396049781-12941-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1396049781-12941-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7791.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index bbadf7a..26edcbe 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -508,6 +508,8 @@
 		interrupts = <0 267 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7791_CLK_VSP1_SY>;
 
+		iommus = <&ipmmu_mx 10>;
+
 		renesas,has-lut;
 		renesas,has-sru;
 		renesas,#rpf = <5>;
@@ -521,6 +523,8 @@
 		interrupts = <0 246 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7791_CLK_VSP1_DU0>;
 
+		iommus = <&ipmmu_mx 13>;
+
 		renesas,has-lif;
 		renesas,has-lut;
 		renesas,#rpf = <4>;
@@ -534,6 +538,8 @@
 		interrupts = <0 247 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7791_CLK_VSP1_DU1>;
 
+		iommus = <&ipmmu_mx 14>;
+
 		renesas,has-lif;
 		renesas,has-lut;
 		renesas,#rpf = <4>;
@@ -942,7 +948,6 @@
 		compatible = "renesas,ipmmu-vmsa";
 		reg = <0 0xfe951800 0 0x800>;
 		interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>;
-		status = "disabled";
 	};
 
 	ipmmu_rt: mmu@ffc80800 {
-- 
1.8.3.2

