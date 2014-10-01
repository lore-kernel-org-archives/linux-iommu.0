From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 3/3] ARM: dts: rk3288: add VOP iommu nodes
Date: Wed,  1 Oct 2014 18:20:43 +0800
Message-ID: <1412158843-8115-4-git-send-email-djkurtz@chromium.org>
References: <1412158843-8115-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1412158843-8115-1-git-send-email-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@linaro.org>, Simon Xue <xxm@rock-chips.com>, Daniel Kurtz <djkurtz@chromium.org>, Grant Grundler <grundler@chromium.org>, =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-rockchip@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Add device nodes for the VOP iommus.
Device nodes for other iommus will be added in later patches.

The iommu nodes use the #iommu-cells property as described in:
  Documentation/devicetree/bindings/iommu/iommu.txt

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Simon Xue <xxm@rock-chips.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 5950b0a..cbc92fa 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -271,6 +271,24 @@
 		status = "disabled";
 	};
 
+	vopb_mmu: iommu@0xff930300 {
+		compatible = "rockchip,iommu";
+		reg = <0xff930300 0x100>;
+		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "vopb_mmu";
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
+	vopl_mmu: iommu@0xff940300 {
+		compatible = "rockchip,iommu";
+		reg = <0xff940300 0x100>;
+		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "vopl_mmu";
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
 	gic: interrupt-controller@ffc01000 {
 		compatible = "arm,gic-400";
 		interrupt-controller;
-- 
2.1.0.rc2.206.gedb03e5
