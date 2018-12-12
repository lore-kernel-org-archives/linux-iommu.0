From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v7 00/24] Tegra GART driver clean up and optimization
Date: Wed, 12 Dec 2018 23:38:43 +0300
Message-ID: <20181212203907.23461-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hello,

This patch-series integrates the GART (IOMMU) driver with the Memory
Controller driver, that allows to report the name of a faulty memory
client on GART page fault. A major code clean up and performance
optimization is performed in this series as well.

Changelog:

v7: Addressed review comments to v6 from Thierry Reding.

    Added three new (minor) patches that further prettifying the drivers
    code.

    New patches in v7:
        1) "memory: tegra: Do not try to probe SMMU on Tegra20"
        2) "memory: tegra: Do not ask for IRQ sharing"
        3) "memory: tegra: Clean up error messages"

    Incorporated another "one-line" change into the "perform code refactoring"
    patch: now GART translation is kept disabled in HW while GART is suspended.

v6: v5 that is re-based on the recent linux-next.

v5: Addressed review comments from Thierry Reding to v4. Added WARN_ON() to
    make sure that active domain isn't getting released, kept include headers
    where necessary, etc.. All changes are quite minor.

    Added new patch "memory: tegra: Use relaxed versions of readl/writel".

v4: In the v3 Rob Herring requested to make device-tree binding changes
    backwards-compatible with the older kernels, that is achieved by
    changing the 'compatible' value of the DT node.

    The code-refactoring patches got some more (minor) polish.

    Added new patch "memory: tegra: Use of_device_get_match_data()".

v3: Memory Controller integration part has been reworked and now GART's
    device-tree binding is changed. Adding Rob Herring for the device-tree
    changes reviewing.

    GART now disallows more than one active domain at a time.

    Fixed "spinlock recursion", "NULL pointer dereference" and "detaching
    of all devices from inactive domains".

    New code-refactoring patches.

    The previously standalone patch "memory: tegra: Don't invoke Tegra30+
    specific memory timing setup on Tegra20" is now included into this
    series because there is a dependency on that patch and it wasn't applied
    yet.

v2: Addressed review comments from Robin Murphy to v1 by moving devices
    iommu_fwspec check to gart_iommu_add_device().

    Dropped the "Provide single domain and group for all devices" patch from
    the series for now because after some more considering it became not
    exactly apparent whether that is what we need, that was also suggested
    by Robin Murphy in the review comment. Maybe something like a runtime
    IOMMU usage for devices would be a better solution, allowing to implement
    transparent context switching of virtual IOMMU domains.

    Some very minor code cleanups, reworded commit messages.

Dmitry Osipenko (24):
  iommu/tegra: gart: Remove pr_fmt and clean up includes
  iommu/tegra: gart: Clean up driver probe errors handling
  iommu/tegra: gart: Ignore devices without IOMMU phandle in DT
  iommu: Introduce iotlb_sync_map callback
  iommu/tegra: gart: Optimize mapping / unmapping performance
  dt-bindings: memory: tegra: Squash tegra20-gart into tegra20-mc
  ARM: dts: tegra20: Update Memory Controller node to the new binding
  memory: tegra: Don't invoke Tegra30+ specific memory timing setup on
    Tegra20
  memory: tegra: Adapt to Tegra20 device-tree binding changes
  memory: tegra: Read client ID on GART page fault
  memory: tegra: Use of_device_get_match_data()
  memory: tegra: Use relaxed versions of readl/writel
  iommu/tegra: gart: Integrate with Memory Controller driver
  memory: tegra: Do not try to probe SMMU on Tegra20
  memory: tegra: Do not ask for IRQ sharing
  memory: tegra: Clean up error messages
  iommu/tegra: gart: Fix spinlock recursion
  iommu/tegra: gart: Fix NULL pointer dereference
  iommu/tegra: gart: Allow only one active domain at a time
  iommu/tegra: gart: Don't use managed resources
  iommu/tegra: gart: Prepend error/debug messages with "gart:"
  iommu/tegra: gart: Don't detach devices from inactive domains
  iommu/tegra: gart: Simplify clients-tracking code
  iommu/tegra: gart: Perform code refactoring

 .../bindings/iommu/nvidia,tegra20-gart.txt    |  14 -
 .../memory-controllers/nvidia,tegra20-mc.txt  |  27 +-
 arch/arm/boot/dts/tegra20.dtsi                |  15 +-
 drivers/iommu/Kconfig                         |   1 +
 drivers/iommu/iommu.c                         |   8 +-
 drivers/iommu/tegra-gart.c                    | 473 +++++++-----------
 drivers/iommu/tegra-smmu.c                    |   4 -
 drivers/memory/tegra/mc.c                     | 118 +++--
 drivers/memory/tegra/mc.h                     |  10 +-
 include/linux/iommu.h                         |   1 +
 include/soc/tegra/mc.h                        |  27 +-
 11 files changed, 323 insertions(+), 375 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt

-- 
2.20.0
