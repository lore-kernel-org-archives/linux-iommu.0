From: Alvise Rigo <a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: Vfio-on-arm: the device tree does not contain the DMA device
Date: Wed, 18 Jun 2014 15:24:14 +0200
Message-ID: <53A192FE.2070303@virtualopensystems.com>
References: <53A0FA5D.5090204@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <53A0FA5D.5090204-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Shannon Zhao <zhaoshenglong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Shannon,

Thank you for reporting this issue, the device tree file was indeed missing.
To solve the problem, you can apply the following patch to the
repository you mentioned
(git://github.com/virtualopensystems/arm-dts.git).

For your information, soon we will update the guide with a newer version
of VFIO with this issue fixed.

Thank you,
alvise

---
 fast_models/rtsm_ve-cortex_a15x4_a7x4.dts | 100
+++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 3 deletions(-)

diff --git a/fast_models/rtsm_ve-cortex_a15x4_a7x4.dts
b/fast_models/rtsm_ve-cortex_a15x4_a7x4.dts
index ef1275b..79c6af2 100644
--- a/fast_models/rtsm_ve-cortex_a15x4_a7x4.dts
+++ b/fast_models/rtsm_ve-cortex_a15x4_a7x4.dts
@@ -142,7 +142,7 @@
 		cpu7: cpu@7 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
-			reg = <0x104>;
+			reg = <0x103>;
 			cluster = <&cluster1>;
 			core = <&core7>;
 		};
@@ -159,7 +159,7 @@
 		#address-cells = <0>;
 		interrupt-controller;
 		reg = <0 0x2c001000 0 0x1000>,
-		      <0 0x2c002000 0 0x2000>,
+		      <0 0x2c002000 0 0x1000>,
 		      <0 0x2c004000 0 0x2000>,
 		      <0 0x2c006000 0 0x2000>;
 		interrupts = <1 9 0xf04>;
@@ -183,6 +183,101 @@
 			     <1 10 0xf08>;
 	};

+	smmu@2c0b0000 {
+                compatible = "arm,smmu-v2";
+                reg = <0x0 0x2c0b0000 0x0 0x10000>;
+                #global-interrupts = <2>;
+                interrupts = <0 58 4>,
+                             <0 59 4>,
+                             <0 60 4>,
+                             <0 60 4>,
+                             <0 60 4>,
+                             <0 60 4>,
+                             <0 60 4>,
+                             <0 60 4>,
+                             <0 60 4>;
+                mmu-masters = <&dma0 0x0 0x8>,
+                              <&dma1 0x1 0x9>,
+                              <&dma2 0x2 0xa>,
+                              <&dma3 0x3 0xb>;
+        };
+
+	dma0: dma@2c0a0000 {
+		compatible = "arm,pl330";
+		reg = <0 0x2c0a0000 0 0x1000>;
+		interrupts = <0 64 4>,
+			     <0 65 4>,
+			     <0 66 4>,
+			     <0 67 4>,
+			     <0 68 4>,
+			     <0 69 4>,
+			     <0 70 4>,
+			     <0 71 4>;
+		#dma-cells = <1>;
+		#stream-id-cells = <2>;
+		clocks = <&oscclk6a>;
+		clock-names = "apb_pclk";
+	};
+
+	dma1: dma@2c0a1000 {
+		compatible = "arm,pl330", "arm,primecell";
+		reg = <0 0x2c0a1000 0 0x1000>;
+		interrupts = <0 96 4>,
+			     <0 97 4>,
+			     <0 98 4>,
+			     <0 99 4>,
+			     <0 100 4>,
+			     <0 101 4>,
+			     <0 102 4>,
+			     <0 103 4>;
+		#dma-cells = <1>;
+		#stream-id-cells = <2>;
+		clocks = <&oscclk6a>;
+		clock-names = "apb_pclk";
+	};
+
+	dma2: dma@2c0a2000 {
+		compatible = "arm,pl330", "arm,primecell";
+		reg = <0 0x2c0a2000 0 0x1000>;
+		interrupts = <0 128 4>,
+			     <0 129 4>,
+			     <0 130 4>,
+			     <0 131 4>,
+			     <0 132 4>,
+			     <0 133 4>,
+			     <0 134 4>,
+			     <0 135 4>;
+		#dma-cells = <1>;
+		#stream-id-cells = <2>;
+		clocks = <&oscclk6a>;
+		clock-names = "apb_pclk";
+	};
+
+	dma3: dma@2c0a3000 {
+		compatible = "arm,pl330", "arm,primecell";
+		reg = <0 0x2c0a3000 0 0x1000>;
+		interrupts = <0 160 4>,
+			     <0 161 4>,
+			     <0 162 4>,
+			     <0 163 4>,
+			     <0 164 4>,
+			     <0 165 4>,
+			     <0 166 4>,
+			     <0 167 4>;
+		#dma-cells = <1>;
+		#stream-id-cells = <2>;
+		clocks = <&oscclk6a>;
+		clock-names = "apb_pclk";
+	};
+
+	oscclk6a: oscclk6a {
+		/* Reference 24MHz clock */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "oscclk6a";
+	};
+
 	smb {
 		compatible = "simple-bus";

@@ -244,4 +339,3 @@
 		/include/ "rtsm_ve-motherboard.dtsi"
 	};
 };
-
-- 
1.9.1


On 18/06/2014 04:33, Shannon Zhao wrote:
> Hi Antonios and all,
> 
> 	Recently, I want to test vfio on ARM and refer to this document "http://www.virtualopensystems.com/en/solutions/guides/vfio-on-arm/" .
> 	Following is my test steps.
> 
> 	1. Get kernel src
> 		git clone git://github.com/virtualopensystems/linux-kvm-arm.git
> 		cd linux-kvm-arm
> 		git checkout origin/vfio-platform-v4
> 
> 	2. Get kernel config
> 		http://www.virtualopensystems.com/downloads/guides/kvm_on_arm/kernel-config > .config
> 
> 	3. Make menuconfig the kernel
> 		enable the KVM, SMMU and VFIO configuration options for the host kernel
> 
> 	4. Compile the kernel
> 		CROSS_COMPILE=arm-linux-gnueabi- ARCH=arm make zImage
> 
> 	5. Build a device tree
> 		There isn't rtsm_ve-cortex_a15x4_a7x4.dts in the directory "arch/arm/boot/dts/".
> 		So I download it from this git "git://github.com/virtualopensystems/arm-dts.git".
> 		./scripts/dtc/dtc -O dtb -o host-a15.dtb ../arm-dts/fast_models/rtsm_ve-cortex_a15x4_a7x4.dts
> 		But the rtsm_ve-cortex_a15x4_a7x4.dts doesn't contain the DMA or SMMU device.
> 
> 	6. Launch the model
> 		Following is the boot_model.sh.
> 			#!/bin/bash
> 
> 			MODEL_PATH='/root/ARM/FastModelsPortfolio_8.2/examples/FVP_VE/Build_Cortex-A15x4-A7x4-MMU400-DMA330/Linux64-Debug-GCC-4.4'
> 
> 			$MODEL_PATH/isim_system \
> 			-a coretile.cluster0.*=/home/vfio/linux-system-semi.axf \
> 			-a coretile.cluster1.*=/home/vfio/linux-system-semi.axf \
> 			-C motherboard.smsc_91c111.enabled=1 \
> 			-C motherboard.hostbridge.interfaceName="ARMroot" \
> 			-C coretile.cluster0.cpu0.semihosting-enable=1 \
> 			-C coretile.dmac0_int_base=64 \
> 			-C coretile.dmac1_int_base=96 \
> 			-C coretile.dmac2_int_base=128 \
> 			-C coretile.dmac3_int_base=168 \
> 			-C coretile.mmu400_dma330.dmac0.p_irq_nsecure="true" \
> 			-C coretile.mmu400_dma330.dmac1.p_irq_nsecure="true" \
> 			-C coretile.mmu400_dma330.dmac2.p_irq_nsecure="true" \
> 			-C coretile.mmu400_dma330.dmac3.p_irq_nsecure="true" \
> 			-C coretile.cluster0.cpu0.semihosting-cmd_line="\
> 			--kernel /home/vfio/zImage \
> 			--initrd /home/vfio/filesystem.cpio.gz \
> 			--dtb host-a15.dtb  -- earlyprintk console=ttyAMA0 mem=2048M "
> 		It launched successfully. There is "vfio_platform" in the directory, but I can't see any DMA decive in the directory "/sys/devices".
> 
> 	PS: I also try to enable the kernel configuration option for DMA. "DMA Engine support --> DMA API Driver for PL330".
> 	Is there something I'm wrong? Is there any way I can get the right device tree and kernel config?
> 	Look forward to your reply.
> 
