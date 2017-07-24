From: Simon Xue <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH V3 1/4] ARM64: dts: rockchip: rk3328 add iommu nodes
Date: Mon, 24 Jul 2017 10:32:07 +0800
Message-ID: <1500863530-32792-1-git-send-email-xxm@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Xue <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Add H265e/VEPU/VPU/VDEC/VOP iommu nodes

Signed-off-by: Simon Xue <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
changes since V2:
 - none

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


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
