From: Chen Feng <puck.chen@hisilicon.com>
Subject: [PATCH 3/3] arm64: dts: Add dts node for hi6220 smmu driver
Date: Tue, 17 Nov 2015 19:57:48 +0800
Message-ID: <1447761468-36952-4-git-send-email-puck.chen@hisilicon.com>
References: <1447761468-36952-1-git-send-email-puck.chen@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447761468-36952-1-git-send-email-puck.chen@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: puck.chen@hisilicon.com, yudongbin@hisilicon.com, saberlily.xia@hisilicon.com, suzhuangluan@hisilicon.com, kong.kongxinwei@hisilicon.com, xuyiping@hisilicon.com, z.liuxinliang@hisilicon.com, puck.chen@aliyun.com, weidong2@hisilicon.com, w.f@huawei.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, xuwei5@hisilicon.com
Cc: qijiwen@hisilicon.com, peter.panshilin@hisilicon.com, dan.zhao@hisilicon.com, linuxarm@huawei.com, arnd@linaro.org, rob.herring@linaro.org, guodong.xu@linaro.org, liguozhu@hisilicon.com
List-Id: iommu@lists.linux-foundation.org

Add iommu node for hi6220 SoC platform

Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 82d2488..589424a 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -208,5 +208,18 @@
 			clock-names = "uartclk", "apb_pclk";
 			status = "disabled";
 		};
+
+		iommu: iommu@f4210000 {
+			compatible = "hisilicon,hi6220-smmu";
+			reg = <0x0 0xf4210000 0x0 0x1000>;
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sys_ctrl HI6220_MMU_CLK>,
+				 <&media_ctrl HI6220_MED_MMU>,
+				 <&sys_ctrl HI6220_MEDIA_PLL_SRC>;
+			clock-names = "smmu",
+				      "media-sc",
+				      "smmu-peri";
+			#iommu-cells = <0>;
+		};
 	};
 };
-- 
1.9.1
