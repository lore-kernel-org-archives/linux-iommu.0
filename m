From: thor.thayer@linux.intel.com
Subject: [PATCH 3/3] arm64: dts: stratix10: Add SMMU Node
Date: Fri, 13 Jul 2018 11:27:58 -0500
Message-ID: <1531499278-32132-4-git-send-email-thor.thayer@linux.intel.com>
References: <1531499278-32132-1-git-send-email-thor.thayer@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1531499278-32132-1-git-send-email-thor.thayer@linux.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: dinguyen@kernel.org, robh+dt@kernel.org, joro@8bytes.org, mark.rutland@arm.com, robin.murphy@arm.com
Cc: devicetree@vger.kernel.org, Thor Thayer <thor.thayer@linux.intel.com>, catalin.marinas@arm.com, will.deacon@arm.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add the SMMU node and IOMMU parameters to the
Stratix10 Device Tree.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 44 +++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index ca67ecb5866e..9b6ead87ae70 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -162,6 +162,8 @@
 			reset-names = "stmmaceth", "stmmaceth-ocp";
 			clocks = <&clkmgr STRATIX10_EMAC0_CLK>;
 			clock-names = "stmmaceth";
+			#stream-id-cells = <1>;
+			iommus = <&smmu 1>;
 			status = "disabled";
 		};
 
@@ -175,6 +177,8 @@
 			reset-names = "stmmaceth", "stmmaceth-ocp";
 			clocks = <&clkmgr STRATIX10_EMAC1_CLK>;
 			clock-names = "stmmaceth";
+			#stream-id-cells = <1>;
+			iommus = <&smmu 2>;
 			status = "disabled";
 		};
 
@@ -188,6 +192,8 @@
 			reset-names = "stmmaceth", "stmmaceth-ocp";
 			clocks = <&clkmgr STRATIX10_EMAC2_CLK>;
 			clock-names = "stmmaceth";
+			#stream-id-cells = <1>;
+			iommus = <&smmu 3>;
 			status = "disabled";
 		};
 
@@ -298,6 +304,8 @@
 			clocks = <&clkmgr STRATIX10_L4_MP_CLK>,
 				 <&clkmgr STRATIX10_SDMMC_CLK>;
 			clock-names = "biu", "ciu";
+			#stream-id-cells = <1>;
+			iommus = <&smmu 5>;
 			status = "disabled";
 		};
 
@@ -323,6 +331,8 @@
 			#dma-requests = <32>;
 			clocks = <&clkmgr STRATIX10_L4_MAIN_CLK>;
 			clock-names = "apb_pclk";
+			#stream-id-cells = <1>;
+			iommus = <&smmu 8>;
 		};
 
 		rst: rstmgr@ffd11000 {
@@ -332,6 +342,36 @@
 			altr,modrst-offset = <0x20>;
 		};
 
+		smmu: iommu@fa000000 {
+			compatible = "arm,mmu-500", "arm,smmu-v2";
+			reg = <0xfa000000 0x40000>;
+			#global-interrupts = <9>;
+			#iommu-cells = <1>;
+			clocks = <&clkmgr STRATIX10_L4_MAIN_CLK>;
+			clock-names = "smmu_clk";
+			interrupt-parent = <&intc>;
+			interrupts = <0 128 4>,	/* Global Secure Fault */
+				<0 129 4>, /* Global Non-secure Fault */
+				<0 130 4>, /* FPGA Performance Counter */
+				<0 131 4>, /* DMA Performance Counter */
+				<0 132 4>, /* EMAC Performance Counter */
+				<0 133 4>, /* IO Performance Counter */
+				<0 134 4>, /* SDM Performance Counter */
+				<0 136 4>, /* Non-secure Combined Interrupt */
+				<0 137 4>, /* Secure Combined Interrupt */
+				/* Non-secure Context Interrupts (32) */
+				<0 138 4>, <0 139 4>, <0 140 4>, <0 141 4>,
+				<0 142 4>, <0 143 4>, <0 144 4>, <0 145 4>,
+				<0 146 4>, <0 147 4>, <0 148 4>, <0 149 4>,
+				<0 150 4>, <0 151 4>, <0 152 4>, <0 153 4>,
+				<0 154 4>, <0 155 4>, <0 156 4>, <0 157 4>,
+				<0 158 4>, <0 159 4>, <0 160 4>, <0 161 4>,
+				<0 162 4>, <0 163 4>, <0 164 4>, <0 165 4>,
+				<0 166 4>, <0 167 4>, <0 168 4>, <0 169 4>;
+			stream-match-mask = <0x7ff0>;
+			status = "disabled";
+		};
+
 		spi0: spi@ffda4000 {
 			compatible = "snps,dw-apb-ssi";
 			#address-cells = <1>;
@@ -439,6 +479,8 @@
 			resets = <&rst USB0_RESET>, <&rst USB0_OCP_RESET>;
 			reset-names = "dwc2", "dwc2-ecc";
 			clocks = <&clkmgr STRATIX10_USB_CLK>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 6>;
 			status = "disabled";
 		};
 
@@ -451,6 +493,8 @@
 			resets = <&rst USB1_RESET>, <&rst USB1_OCP_RESET>;
 			reset-names = "dwc2", "dwc2-ecc";
 			clocks = <&clkmgr STRATIX10_USB_CLK>;
+			#stream-id-cells = <1>;
+			iommus = <&smmu 7>;
 			status = "disabled";
 		};
 
-- 
2.7.4
