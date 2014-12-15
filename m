From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 09/10] ARM: shmobile: r8a7790: Add IPMMU DT nodes
Date: Mon, 15 Dec 2014 02:13:48 +0200
Message-ID: <1418602429-11276-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1418602429-11276-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1418602429-11276-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Add the six IPMMU instances found in the r8a7790 to DT with a disabled
status.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 48 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index ffeff98fa16e..430bb67216fd 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1459,4 +1459,52 @@
 			ssi9: ssi@9 { interrupts = <0 379 IRQ_TYPE_LEVEL_HIGH>; };
 		};
 	};
+
+	ipmmu_sy0: mmu@e6280800 {
+		compatible = "renesas,ipmmu-vmsa";
+		reg = <0 0xe6280800 0 0x800>;
+		interrupts = <0 223 IRQ_TYPE_LEVEL_HIGH>;
+		#iommu-cells = <1>;
+		status = "disabled";
+	};
+
+	ipmmu_sy1: mmu@e6290800 {
+		compatible = "renesas,ipmmu-vmsa";
+		reg = <0 0xe6290800 0 0x800>;
+		interrupts = <0 225 IRQ_TYPE_LEVEL_HIGH>;
+		#iommu-cells = <1>;
+		status = "disabled";
+	};
+
+	ipmmu_ds: mmu@e6740800 {
+		compatible = "renesas,ipmmu-vmsa";
+		reg = <0 0xe6740800 0 0x800>;
+		interrupts = <0 198 IRQ_TYPE_LEVEL_HIGH>;
+		#iommu-cells = <1>;
+		status = "disabled";
+	};
+
+	ipmmu_mp: mmu@ec680800 {
+		compatible = "renesas,ipmmu-vmsa";
+		reg = <0 0xec680800 0 0x800>;
+		interrupts = <0 226 IRQ_TYPE_LEVEL_HIGH>;
+		#iommu-cells = <1>;
+		status = "disabled";
+	};
+
+	ipmmu_mx: mmu@fe951800 {
+		compatible = "renesas,ipmmu-vmsa";
+		reg = <0 0xfe951800 0 0x800>;
+		interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>;
+		#iommu-cells = <1>;
+		status = "disabled";
+	};
+
+	ipmmu_rt: mmu@ffc80800 {
+		compatible = "renesas,ipmmu-vmsa";
+		reg = <0 0xffc80800 0 0x800>;
+		interrupts = <0 307 IRQ_TYPE_LEVEL_HIGH>;
+		#iommu-cells = <1>;
+		status = "disabled";
+	};
 };
-- 
2.0.4

