From: Simon Xue <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH V3 4/4] ARM64: dts: rockchip: rk3399 add iommu nodes
Date: Mon, 24 Jul 2017 10:32:10 +0800
Message-ID: <1500863530-32792-4-git-send-email-xxm@rock-chips.com>
References: <1500863530-32792-1-git-send-email-xxm@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1500863530-32792-1-git-send-email-xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Add VPU/VDEC/IEP/VOPL/VOPB/ISP0/ISP1 iommu nodes

Signed-off-by: Simon Xue <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
changes since V2:
use rockchip,disable-mmu-reset instead of rk-iommu,disable-reset-quirk

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 65 ++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 69c56f7..99948d9 100644
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
@@ -1426,6 +1462,35 @@
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
+		rockchip,disable-mmu-reset;
+		status = "disabled";
+	};
+
+	isp1_mmu: iommu@ff924000 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xff924000 0x0 0x100>, <0x0 0xff925000 0x0 0x100>;
+		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "isp1_mmu";
+		#iommu-cells = <0>;
+		rockchip,disable-mmu-reset;
+		status = "disabled";
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3399-pinctrl";
 		rockchip,grf = <&grf>;
-- 
1.9.1
