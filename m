From: Simon Xue <xxm@rock-chips.com>
Subject: [PATCH V2 2/4] ARM: dts: rockchip: rk322x add iommu nodes
Date: Fri, 21 Jul 2017 14:24:19 +0800
Message-ID: <1500618261-114262-2-git-send-email-xxm@rock-chips.com>
References: <1500618261-114262-1-git-send-email-xxm@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500618261-114262-1-git-send-email-xxm@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Simon <xxm@rock-chips.com>
List-Id: iommu@lists.linux-foundation.org

From: Simon <xxm@rock-chips.com>

Add VPU/VDEC/VOP/IEP iommu nodes

Signed-off-by: Simon <xxm@rock-chips.com>
---
changes since V1:
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
