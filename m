From: Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH v3 0/5] Add Tegra194 Dual ARM SMMU driver
Date: Mon, 3 Dec 2018 17:36:48 -0800
Message-ID: <1543887414-18209-1-git-send-email-vdumpa@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, treding@nvidia.com, yhsu@nvidia.com, snikam@nvidia.com, praithatha@nvidia.com, talho@nvidia.com, avanbrunt@nvidia.com, thomasz@nvidia.com, olof@lixom.net, jtukkinen@nvidia.com, mperttunen@nvidia.com, Krishna Reddy <vdumpa@nvidia.com>
List-Id: iommu@lists.linux-foundation.org

NVIDIA's Xavier (Tegra194) SOC has two ARM SMMU(MMU-500) instances, which
are used as one SMMU device in HW. The IOVA accesses from HW devices are
interleaved across these two SMMU instances and need to be programmed identical.

The existing ARM SMMU driver can't be used in its current form for programming
the two SMMU instances identically. But, Most of the code can be shared between
ARM SMMU driver and Tegra194 SMMU driver. To allow sharing the code, Created
a libray based on the current ARM SMMU driver and added suppport to program
multiple ARM SMMU Instances identically. Upated Current ARM SMMU driver and
Tegra194 SMMU driver to use the library functions.

Please review the patches and provide feedback.

Changes in v2:
* Added CONFIG_ARM_SMMU_TEGRA to protect Tegra194 SMMU driver compilation
* Enabled CONFIG_ARM_SMMU_TEGRA in defconfig
* Added SMMU nodes in Tegra194 device tree

Changes in v3:
* Created library for ARM SMMU based on arm-smmu.c
* Added support to program multiple ARM SMMU instances identically
* Updated arm-smmu.c/tegra194-smmu.c to use ARM SMMU library functions

Krishna Reddy (6):
  iommu/arm-smmu: create library for ARM SMMU
  iommu/arm-smmu: Add support to program multiple ARM SMMU's identically
  iommu/arm-smmu: update arm-smmu.c to use ARM SMMU library
  iommu/tegra194_smmu: Add Tegra194 SMMU driver
  arm64: defconfig: Enable ARM_SMMU_TEGRA
  arm64: tegra: Add SMMU nodes to Tegra194 device tree

 arch/arm64/boot/dts/nvidia/tegra194.dtsi |  148 +++
 arch/arm64/configs/defconfig             |    1 +
 drivers/iommu/Kconfig                    |   11 +
 drivers/iommu/Makefile                   |    2 +
 drivers/iommu/arm-smmu.c                 | 1709 +----------------------------
 drivers/iommu/lib-arm-smmu.c             | 1768 ++++++++++++++++++++++++++++++
 drivers/iommu/lib-arm-smmu.h             |  161 +++
 drivers/iommu/tegra194-smmu.c            |  394 +++++++
 8 files changed, 2496 insertions(+), 1698 deletions(-)
 create mode 100644 drivers/iommu/lib-arm-smmu.c
 create mode 100644 drivers/iommu/lib-arm-smmu.h
 create mode 100644 drivers/iommu/tegra194-smmu.c

-- 
2.1.4
