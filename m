From: Andreas Herrmann <andreas.herrmann@calxeda.com>
Subject: [PATCH 09/11] ARM: dts: Add nodes for SMMUs on Calxeda ECX-2000
Date: Thu, 16 Jan 2014 13:44:21 +0100
Message-ID: <1389876263-25759-10-git-send-email-andreas.herrmann@calxeda.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: Andreas Herrmann <andreas.herrmann@calxeda.com>, iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>, Andreas Herrmann <herrmann.der.user@googlemail.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Andreas Herrmann <herrmann.der.user@googlemail.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
---
 arch/arm/boot/dts/ecx-2000.dts    |   44 +++++++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/ecx-common.dtsi |    9 +++++---
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/ecx-2000.dts b/arch/arm/boot/dts/ecx-2000.dts
index 2ccbb57f..722de49 100644
--- a/arch/arm/boot/dts/ecx-2000.dts
+++ b/arch/arm/boot/dts/ecx-2000.dts
@@ -76,10 +76,11 @@
 	};
 
 	soc {
-		ranges = <0x00000000 0x00000000 0x00000000 0xffffffff>;
+		ranges = <0x0 0x0 0x0 0xffffffff>;
 
 		timer {
-			compatible = "arm,cortex-a15-timer", "arm,armv7-timer"; 			interrupts = <1 13 0xf08>,
+			compatible = "arm,cortex-a15-timer", "arm,armv7-timer";
+			interrupts = <1 13 0xf08>,
 				<1 14 0xf08>,
 				<1 11 0xf08>,
 				<1 10 0xf08>;
@@ -109,6 +110,45 @@
 			interrupts = <0 76 4  0 75 4  0 74 4  0 73 4>;
 		};
 	};
+
+	soc@920000000 {
+		ranges = <0x9 0x20000000 0x9 0x20000000 0x290000>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&intc>;
+
+		smmu_mac0: smmu@920000000 {
+			compatible = "arm,mmu-400";
+			reg = <0x9 0x20000000 0x10000>;
+			#global-interrupts = <1>;
+			interrupts = <0 106 4 0 106 4>;
+			mmu-masters = <&mac0 0 1>;
+			calxeda,smmu-secure-config-access;
+			arm,smmu-isolate-devices;
+		};
+
+		smmu_mac1: smmu@920080000 {
+			compatible = "arm,mmu-400";
+			reg = <0x9 0x20080000 0x10000>;
+			#global-interrupts = <1>;
+			interrupts = <0 108 4 0 108 4>;
+			mmu-masters = <&mac1 0 1>;
+			calxeda,smmu-secure-config-access;
+			arm,smmu-isolate-devices;
+		};
+
+		smmu_sata: smmu@920180000 {
+			compatible = "arm,mmu-400";
+			reg = <0x00000009 0x20180000 0x10000>;
+			mmu-masters = <&sata 0 1 2 3 4 5 6 7 8 9>;
+			#global-interrupts = <1>;
+			interrupts = <0 114 4 0 114 4>;
+			calxeda,smmu-secure-config-access;
+			arm,smmu-isolate-devices;
+		};
+	};
+
 };
 
 /include/ "ecx-common.dtsi"
diff --git a/arch/arm/boot/dts/ecx-common.dtsi b/arch/arm/boot/dts/ecx-common.dtsi
index b90045a..ad9b2fd 100644
--- a/arch/arm/boot/dts/ecx-common.dtsi
+++ b/arch/arm/boot/dts/ecx-common.dtsi
@@ -33,7 +33,7 @@
 		compatible = "simple-bus";
 		interrupt-parent = <&intc>;
 
-		sata@ffe08000 {
+		sata: sata@ffe08000 {
 			compatible = "calxeda,hb-ahci";
 			reg = <0xffe08000 0x10000>;
 			interrupts = <0 83 4>;
@@ -43,6 +43,7 @@
 					     &combophy0 3>;
 			calxeda,sgpio-gpio =<&gpioh 5 1 &gpioh 6 1 &gpioh 7 1>;
 			calxeda,led-order = <4 0 1 2 3>;
+			#stream-id-cells = <10>;
 		};
 
 		sdhci@ffe0e000 {
@@ -210,18 +211,20 @@
 			clock-names = "apb_pclk";
 		};
 
-		ethernet@fff50000 {
+		mac0: ethernet@fff50000 {
 			compatible = "calxeda,hb-xgmac";
 			reg = <0xfff50000 0x1000>;
 			interrupts = <0 77 4  0 78 4  0 79 4>;
 			dma-coherent;
+			#stream-id-cells = <2>;
 		};
 
-		ethernet@fff51000 {
+		mac1: ethernet@fff51000 {
 			compatible = "calxeda,hb-xgmac";
 			reg = <0xfff51000 0x1000>;
 			interrupts = <0 80 4  0 81 4  0 82 4>;
 			dma-coherent;
+			#stream-id-cells = <2>;
 		};
 
 		combophy0: combo-phy@fff58000 {
-- 
1.7.9.5
