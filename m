From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 5/5] ARM: dts: Add nodes for SMMUs on Calxeda ECX-2000
Date: Tue,  8 Oct 2013 11:27:24 +0200
Message-ID: <1381224444-27303-6-git-send-email-andreas.herrmann@calxeda.com>
References: <1381224444-27303-1-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1381224444-27303-1-git-send-email-andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/ecx-2000.dts    |   45 +++++++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/ecx-common.dtsi |    9 +++++---
 2 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/ecx-2000.dts b/arch/arm/boot/dts/ecx-2000.dts
index 139b40c..4444905 100644
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
@@ -103,6 +104,46 @@
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
+			mmu-masters = <&mac0 0x0 0x1>;
+			arm,smmu-secure-config-access;
+			arm,smmu-isolate-devices;
+		};
+
+		smmu_mac1: smmu@920080000 {
+			compatible = "arm,mmu-400";
+			reg = <0x9 0x20080000 0x10000>;
+			#global-interrupts = <1>;
+			interrupts = <0 108 4 0 108 4>;
+			mmu-masters = <&mac1 0x0 0x1>;
+			arm,smmu-secure-config-access;
+			arm,smmu-isolate-devices;
+		};
+
+		smmu_sata: smmu@920180000 {
+			compatible = "arm,mmu-400";
+			reg = <0x00000009 0x20180000 0x10000>;
+			mmu-masters = <&sata>;
+			#global-interrupts = <1>;
+			interrupts = <0 114 4 0 114 4>;
+			arm,smmu-secure-config-access;
+			arm,smmu-isolate-devices;
+			arm,smmu-mask-stream-ids;
+		};
+	};
+
 };
 
 /include/ "ecx-common.dtsi"
diff --git a/arch/arm/boot/dts/ecx-common.dtsi b/arch/arm/boot/dts/ecx-common.dtsi
index e8559b7..50e401e 100644
--- a/arch/arm/boot/dts/ecx-common.dtsi
+++ b/arch/arm/boot/dts/ecx-common.dtsi
@@ -25,7 +25,7 @@
 		compatible = "simple-bus";
 		interrupt-parent = <&intc>;
 
-		sata@ffe08000 {
+		sata: sata@ffe08000 {
 			compatible = "calxeda,hb-ahci";
 			reg = <0xffe08000 0x10000>;
 			interrupts = <0 83 4>;
@@ -35,6 +35,7 @@
 					     &combophy0 3>;
 			calxeda,sgpio-gpio =<&gpioh 5 1 &gpioh 6 1 &gpioh 7 1>;
 			calxeda,led-order = <4 0 1 2 3>;
+			#stream-id-cells = <0>;
 		};
 
 		sdhci@ffe0e000 {
@@ -208,18 +209,20 @@
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
