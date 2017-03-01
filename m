From: Rob Clark <robdclark@gmail.com>
Subject: [PATCH 0/9] iommu: add qcom_iommu for early "B" family devices
Date: Wed,  1 Mar 2017 12:42:49 -0500
Message-ID: <20170301174258.14618-1-robdclark@gmail.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Sricharan <sricharan@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, Rob Clark <robdclark@gmail.com>
List-Id: iommu@lists.linux-foundation.org

An iommu driver for Qualcomm "B" family devices which do not completely
implement the ARM SMMU spec.  These devices have context-bank register
layout that is similar to ARM SMMU, but no global register space (or at
least not one that is accessible).

Compared to first version of the patchset, the bindings have changed
somewhat, which necessitated some changes in the structure of the driver.
It turns out that even though the global register space is not accessible,
we do have (for IOMMUs that contain secure contexts) a separate non-
standard global register space where we need to configure the routing
of irqs.  And we could not just assign this register range to each
context-bank node.  So now we have a single iommu device which contains
all of it's context banks:

	apps_iommu: msm-iommu-v1@1e20000 {
		#address-cells = <1>;
		#size-cells = <1>;
		#iommu-cells = <1>;
		compatible = "qcom,msm-iommu-v1";
		ranges = <0 0x1e20000 0x40000>;
		reg = <0x1ef0000 0x3000>;
		clocks = <&gcc GCC_SMMU_CFG_CLK>,
			 <&gcc GCC_APSS_TCU_CLK>;
		clock-names = "iface_clk", "bus_clk";
		qcom,iommu-secure-id = <17>;

		// mdp_0:
		msm-iommu-v1-ctx@4000 {
			compatible = "qcom,msm-iommu-v1-ns";
			reg = <0x4000 0x1000>;
			interrupts = <GIC_SPI 70 0>;
		};

		// venus_ns:
		msm-iommu-v1-ctx@5000 {
			compatible = "qcom,msm-iommu-v1-sec";
			reg = <0x5000 0x1000>;
			interrupts = <GIC_SPI 70 0>;
		};
	};

	gpu_iommu: msm-iommu-v1@1f08000 {
		...
	};

There are a couple vaguely unrelated patches to add venus and gpu dt nodes,
so that we have something to wire up the iommu to.

These patches apply on top of some in-flight patches to support IOMMU
probe deferral.  You can find full branch on top of linux-next here:

   git://people.freedesktop.org/~robclark/linux  next-20170228-db410c-qcom-smmu-3-venus

or github if you prefer:

   https://github.com/freedreno/kernel-msm/commits/next-20170228-db410c-qcom-smmu-3-venus


Rob Clark (6):
  firmware/qcom: add qcom_scm_restore_sec_cfg()
  Docs: dt: document qcom iommu bindings
  iommu: arm-smmu: split out register defines
  iommu: add qcom_iommu
  ARM64: DT: add gpu for msm8916
  ARM64: DT: add iommu for msm8916

Stanimir Varbanov (3):
  firmware: qcom_scm: add two scm calls for iommu secure page table
  iommu: qcom: initialize secure page table
  ARM64: DT: add video codec devicetree node

 .../devicetree/bindings/iommu/qcom,iommu.txt       | 106 +++
 arch/arm64/boot/dts/qcom/msm8916.dtsi              | 108 +++
 drivers/firmware/qcom_scm-32.c                     |   6 +
 drivers/firmware/qcom_scm-64.c                     |  58 ++
 drivers/firmware/qcom_scm.c                        |  18 +
 drivers/firmware/qcom_scm.h                        |  11 +
 drivers/iommu/Kconfig                              |  10 +
 drivers/iommu/Makefile                             |   1 +
 drivers/iommu/arm-smmu-regs.h                      | 227 ++++++
 drivers/iommu/arm-smmu.c                           | 200 +----
 drivers/iommu/qcom_iommu.c                         | 889 +++++++++++++++++++++
 include/linux/qcom_scm.h                           |   4 +
 12 files changed, 1439 insertions(+), 199 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/qcom,iommu.txt
 create mode 100644 drivers/iommu/arm-smmu-regs.h
 create mode 100644 drivers/iommu/qcom_iommu.c

-- 
2.9.3
