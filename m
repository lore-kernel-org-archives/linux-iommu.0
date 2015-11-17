From: Chen Feng <puck.chen@hisilicon.com>
Subject: [PATCH 1/3] docs: iommu: Documentation for iommu in hi6220 SoC
Date: Tue, 17 Nov 2015 19:57:46 +0800
Message-ID: <1447761468-36952-2-git-send-email-puck.chen@hisilicon.com>
References: <1447761468-36952-1-git-send-email-puck.chen@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447761468-36952-1-git-send-email-puck.chen@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: puck.chen@hisilicon.com, yudongbin@hisilicon.com, saberlily.xia@hisilicon.com, suzhuangluan@hisilicon.com, kong.kongxinwei@hisilicon.com, xuyiping@hisilicon.com, z.liuxinliang@hisilicon.com, puck.chen@aliyun.com, weidong2@hisilicon.com, w.f@huawei.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, xuwei5@hisilicon.com
Cc: qijiwen@hisilicon.com, peter.panshilin@hisilicon.com, dan.zhao@hisilicon.com, linuxarm@huawei.com, arnd@linaro.org, rob.herring@linaro.org, guodong.xu@linaro.org, liguozhu@hisilicon.com
List-Id: iommu@lists.linux-foundation.org

Documentation for hi6220 iommu driver.

Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
---
 .../bindings/iommu/hisi,hi6220-iommu.txt           | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/hisi,hi6220-iommu.txt

diff --git a/Documentation/devicetree/bindings/iommu/hisi,hi6220-iommu.txt b/Documentation/devicetree/bindings/iommu/hisi,hi6220-iommu.txt
new file mode 100644
index 0000000..44f9101
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/hisi,hi6220-iommu.txt
@@ -0,0 +1,32 @@
+Hi6220 SoC SMMU Device Driver devicetree document
+The media system shared the same smmu IP to access DDR memory. And all
+media IP used the same page table.
+
+Below binding describes the system mmu for media system in hi6220 platform
+
+Required properties:
+- compatible: should contain "hisilicon,hi6220-smmu".
+- reg: A tuple of base address and size of System MMU registers.
+- clocks: a list of phandle + clock-specifier pairs, one for each entry
+  in clock-names.
+- clock-names: should contain:
+  * "smmu"
+  * "media-sc"
+  * "smmu-peri"
+- interrupts: An interrupt specifier for interrupt signal of System MMU.
+- #iommu-cells: The iommu-cells should be 0. Because no additional information
+  needs to be encoded in the specifier.
+
+Examples:
+	iommu@f4210000 {
+		compatible = "hisilicon,hi6220-smmu";
+		reg = <0x0 0xf4210000 0x0 0x1000>;
+		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&sys_ctrl HI6220_MMU_CLK>,
+		         <&media_ctrl HI6220_MED_MMU>,
+		         <&sys_ctrl HI6220_MEDIA_PLL_SRC>;
+		clock-names = "smmu",
+			      "media-sc",
+			      "smmu-peri";
+		#iommu-cells = <0>;
+	};
-- 
1.9.1
