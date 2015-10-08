From: Chen Feng <puck.chen@hisilicon.com>
Subject: [PATCH 3/3] arm64: dts: Add dts node for hi6220 iommu
Date: Thu, 8 Oct 2015 15:45:48 +0800
Message-ID: <1444290348-66509-3-git-send-email-puck.chen@hisilicon.com>
References: <1444290348-66509-1-git-send-email-puck.chen@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444290348-66509-1-git-send-email-puck.chen@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: puck.chen@hisilicon.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, haojian.zhuang@linaro.org, devicetree@vger.kernel.org, xuwei5@hisilicon.com, xuyiping@hisilicon.com, w.f@huawei.com, kong.kongxinwei@hisilicon.com, z.liuxinliang@hisilicon.com, yudongbin@hisilicon.com, weidong2@hisilicon.com, saberlily.xia@hisilicon.com
Cc: linuxarm@huawei.com, dan.zhao@hisilicon.com, peter.panshilin@hisilicon.com, qijiwen@hisilicon.com
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
Signed-off-by: Yu Dongbin <yudongbin@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 3f03380..3ef33b4 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -5,6 +5,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/hi6220-clock.h>
 
 / {
 	compatible = "hisilicon,hi6220";
@@ -167,5 +168,19 @@
 			clocks = <&ao_ctrl 36>, <&ao_ctrl 36>;
 			clock-names = "uartclk", "apb_pclk";
 		};
+
+		smmu@f4210000 {
+			compatible = "hisilicon,hi6220-smmu";
+			reg = <0x0 0xf4210000 0x0 0x1000>;
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sys_ctrl HI6220_MMU_CLK>,
+				 <&media_ctrl HI6220_MED_MMU>,
+				 <&sys_ctrl HI6220_MEDIA_PLL_SRC>;
+			clock-names = "smmu_clk",
+				      "media_sc_clk",
+				      "smmu_peri_clk";
+			#iommu-cells = <1>;
+		};
+
 	};
 };
-- 
1.9.1
