From: Simon Xue <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH V3 2/4] ARM: dts: rockchip: rk322x add iommu nodes
Date: Mon, 24 Jul 2017 10:32:08 +0800
Message-ID: <1500863530-32792-2-git-send-email-xxm@rock-chips.com>
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

Add VPU/VDEC/VOP/IEP iommu nodes

Signed-off-by: Simon Xue <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
changes since V2:
 - none

 arch/arm/boot/dts/rk322x.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index f3e4ffd..36f7c4b 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -500,6 +500,42 @@
 		status = "disabled";
 	};
 
+	vpu_mmu: iommu@20020800 {
+		compatible = "rockchip,iommu";
+		reg = <0x20020800 0x100>;
+		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "vpu_mmu";
+		iommu-cells = <0>;
+		status = "disabled";
+	};
+
+	vdec_mmu: iommu@20030480 {
+		compatible = "rockchip,iommu";
+		reg = <0x20030480 0x40>, <0x200304c0 0x40>;
+		interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "vdec_mmu";
+		iommu-cells = <0>;
+		status = "disabled";
+	};
+
+	vop_mmu: iommu@20053f00 {
+		compatible = "rockchip,iommu";
+		reg = <0x20053f00 0x100>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "vop_mmu";
+		iommu-cells = <0>;
+		status = "disabled";
+	};
+
+	iep_mmu: iommu@20070800 {
+		compatible = "rockchip,iommu";
+		reg = <0x20070800 0x100>;
+		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "iep_mmu";
+		iommu-cells = <0>;
+		status = "disabled";
+	};
+
 	emmc: dwmmc@30020000 {
 		compatible = "rockchip,rk3288-dw-mshc";
 		reg = <0x30020000 0x4000>;
-- 
1.9.1
