From: Shannon Zhao <zhaoshenglong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Vfio-on-arm: the device tree does not contain the DMA device
Date: Wed, 18 Jun 2014 10:33:01 +0800
Message-ID: <53A0FA5D.5090204@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Antonios and all,

	Recently, I want to test vfio on ARM and refer to this document "http://www.virtualopensystems.com/en/solutions/guides/vfio-on-arm/" .
	Following is my test steps.

	1. Get kernel src
		git clone git://github.com/virtualopensystems/linux-kvm-arm.git
		cd linux-kvm-arm
		git checkout origin/vfio-platform-v4

	2. Get kernel config
		http://www.virtualopensystems.com/downloads/guides/kvm_on_arm/kernel-config > .config

	3. Make menuconfig the kernel
		enable the KVM, SMMU and VFIO configuration options for the host kernel

	4. Compile the kernel
		CROSS_COMPILE=arm-linux-gnueabi- ARCH=arm make zImage

	5. Build a device tree
		There isn't rtsm_ve-cortex_a15x4_a7x4.dts in the directory "arch/arm/boot/dts/".
		So I download it from this git "git://github.com/virtualopensystems/arm-dts.git".
		./scripts/dtc/dtc -O dtb -o host-a15.dtb ../arm-dts/fast_models/rtsm_ve-cortex_a15x4_a7x4.dts
		But the rtsm_ve-cortex_a15x4_a7x4.dts doesn't contain the DMA or SMMU device.

	6. Launch the model
		Following is the boot_model.sh.
			#!/bin/bash

			MODEL_PATH='/root/ARM/FastModelsPortfolio_8.2/examples/FVP_VE/Build_Cortex-A15x4-A7x4-MMU400-DMA330/Linux64-Debug-GCC-4.4'

			$MODEL_PATH/isim_system \
			-a coretile.cluster0.*=/home/vfio/linux-system-semi.axf \
			-a coretile.cluster1.*=/home/vfio/linux-system-semi.axf \
			-C motherboard.smsc_91c111.enabled=1 \
			-C motherboard.hostbridge.interfaceName="ARMroot" \
			-C coretile.cluster0.cpu0.semihosting-enable=1 \
			-C coretile.dmac0_int_base=64 \
			-C coretile.dmac1_int_base=96 \
			-C coretile.dmac2_int_base=128 \
			-C coretile.dmac3_int_base=168 \
			-C coretile.mmu400_dma330.dmac0.p_irq_nsecure="true" \
			-C coretile.mmu400_dma330.dmac1.p_irq_nsecure="true" \
			-C coretile.mmu400_dma330.dmac2.p_irq_nsecure="true" \
			-C coretile.mmu400_dma330.dmac3.p_irq_nsecure="true" \
			-C coretile.cluster0.cpu0.semihosting-cmd_line="\
			--kernel /home/vfio/zImage \
			--initrd /home/vfio/filesystem.cpio.gz \
			--dtb host-a15.dtb  -- earlyprintk console=ttyAMA0 mem=2048M "
		It launched successfully. There is "vfio_platform" in the directory, but I can't see any DMA decive in the directory "/sys/devices".

	PS: I also try to enable the kernel configuration option for DMA. "DMA Engine support --> DMA API Driver for PL330".
	Is there something I'm wrong? Is there any way I can get the right device tree and kernel config?
	Look forward to your reply.
-- 
Shannon
