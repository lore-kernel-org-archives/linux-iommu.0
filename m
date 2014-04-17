From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 4/5] ARM: shmobile: r8a7791: Add IPMMU DT nodes
Date: Thu, 17 Apr 2014 12:33:26 +0200
Message-ID: <1397730807-5993-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1397730807-5993-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1397730807-5993-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7791.dtsi | 49 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 909d786..d1e446c 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -909,4 +909,53 @@
 		#size-cells = <0>;
 		status = "disabled";
 	};
+
+	ipmmu_sy0: mmu@e6280800 {
+		compatible = "renesas,ipmmu-vmsa";
+		reg = <0 0xe6280800 0 0x800>;
+		interrupts = <0 223 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	ipmmu_sy1: mmu@e6290800 {
+		compatible = "renesas,ipmmu-vmsa";
+		reg = <0 0xe6290800 0 0x800>;
+		interrupts = <0 225 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	ipmmu_ds: mmu@e6740800 {
+		compatible = "renesas,ipmmu-vmsa";
+		reg = <0 0xe6740800 0 0x800>;
+		interrupts = <0 198 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	ipmmu_mp: mmu@ec680800 {
+		compatible = "renesas,ipmmu-vmsa";
+		reg = <0 0xec680800 0 0x800>;
+		interrupts = <0 226 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	ipmmu_mx: mmu@fe951800 {
+		compatible = "renesas,ipmmu-vmsa";
+		reg = <0 0xfe951800 0 0x800>;
+		interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	ipmmu_rt: mmu@ffc80800 {
+		compatible = "renesas,ipmmu-vmsa";
+		reg = <0 0xffc80800 0 0x800>;
+		interrupts = <0 307 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	ipmmu_gp: mmu@e62a0800 {
+		compatible = "renesas,ipmmu-vmsa";
+		reg = <0 0xe62a0800 0 0x800>;
+		interrupts = <0 260 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
 };
-- 
1.8.3.2

