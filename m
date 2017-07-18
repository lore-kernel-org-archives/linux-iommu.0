From: Simon Xue <xxm@rock-chips.com>
Subject: [PATCH 1/4] ARM64: dts: rockchip: rk3328 add iommu nodes
Date: Tue, 18 Jul 2017 18:02:02 +0800
Message-ID: <1500372125-114261-1-git-send-email-xxm@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Simon <xxm@rock-chips.com>
List-Id: iommu@lists.linux-foundation.org

From: Simon <xxm@rock-chips.com>

Add H265e/VEPU/VPU/VDEC/VOP iommu nodes

Signed-off-by: Simon <xxm@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 45 ++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 0be96ce..bdd7711 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -320,6 +320,51 @@
 		status = "disabled";
 	};
 
+	h265e_mmu: iommu@ff330200 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xff330200 0 0x100>;
+		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "h265e_mmu";
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
+	vepu_mmu: iommu@ff340800 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xff340800 0x0 0x40>;
+		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "vepu_mmu";
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
+	vpu_mmu: iommu@ff350800 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xff350800 0x0 0x40>;
+		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "vpu_mmu";
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
+	rkvdec_mmu: iommu@ff360480 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xff360480 0x0 0x40>, <0x0 0xff3604c0 0x0 0x40>;
+		interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "rkvdec_mmu";
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
+	vop_mmu: iommu@ff373f00 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xff373f00 0x0 0x100>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "vop_mmu";
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
 	cru: clock-controller@ff440000 {
 		compatible = "rockchip,rk3328-cru", "rockchip,cru", "syscon";
 		reg = <0x0 0xff440000 0x0 0x1000>;
-- 
1.9.1
