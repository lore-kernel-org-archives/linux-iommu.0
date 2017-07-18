From: Simon Xue <xxm@rock-chips.com>
Subject: [PATCH 4/4] ARM64: dts: rockchip: rk3399 add iommu nodes
Date: Tue, 18 Jul 2017 18:02:05 +0800
Message-ID: <1500372125-114261-4-git-send-email-xxm@rock-chips.com>
References: <1500372125-114261-1-git-send-email-xxm@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500372125-114261-1-git-send-email-xxm@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Simon <xxm@rock-chips.com>
List-Id: iommu@lists.linux-foundation.org

From: Simon <xxm@rock-chips.com>

Add VPU/VDEC/IEP/VOPL/VOPB/ISP0/ISP1 iommu nodes

Signed-off-by: Simon <xxm@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 63 ++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 69c56f7..95cabe1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1151,6 +1151,33 @@
 		status = "disabled";
 	};
 
+	vpu_mmu: iommu@ff650800 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xff650800 0x0 0x40>;
+		interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "vpu_mmu";
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
+	vdec_mmu: iommu@ff660480 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xff660480 0x0 0x40>, <0x0 0xff6604c0 0x0 0x40>;
+		interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "vdec_mmu";
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
+	iep_mmu: iommu@ff670800 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xff670800 0x0 0x40>;
+		interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "iep_mmu";
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
 	efuse0: efuse@ff690000 {
 		compatible = "rockchip,rk3399-efuse";
 		reg = <0x0 0xff690000 0x0 0x80>;
@@ -1360,6 +1387,15 @@
 		};
 	};
 
+	vopl_mmu: iommu@ff8f3f00 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xff8f3f00 0x0 0x100>;
+		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "vopl_mmu";
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
 	watchdog@ff848000 {
 		compatible = "snps,dw-wdt";
 		reg = <0x0 0xff848000 0x0 0x100>;
@@ -1426,6 +1462,33 @@
 		status = "disabled";
 	};
 
+	vopb_mmu: iommu@ff903f00 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xff903f00 0x0 0x100>;
+		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "vopb_mmu";
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
+	isp0_mmu: iommu@ff914000 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xff914000 0x0 0x100>, <0x0 0xff915000 0x0 0x100>;
+		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "isp0_mmu";
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
+	isp1_mmu: iommu@ff924000 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xff924000 0x0 0x100>, <0x0 0xff925000 0x0 0x100>;
+		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "isp1_mmu";
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3399-pinctrl";
 		rockchip,grf = <&grf>;
-- 
1.9.1
