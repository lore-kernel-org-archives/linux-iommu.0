From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 00/20] IOMMU: Tegra GART driver clean up and optimization
Date: Mon, 24 Sep 2018 03:41:33 +0300
Message-ID: <20180924004153.8232-1-digetx@gmail.com>
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
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello,

This patch-series integrates the GART (IOMMU) driver with the Memory
Controller driver, that allows to report the name of a faulty memory
client on GART page fault. A major cleanup of the code is performed by
this series as well, it also optimizes performance of the GART driver.

In the previous v2 iteration Thierry Reding suggested that it is better to
break/change GART's device-tree ABI in order to integrate it with Memory
Controller without much churning. This patch series includes patches that
change the device tree binding in a way that updated driver will work only
with the new binding and older kernels won't be broken by the new binding.

Changelog:

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

Dmitry Osipenko (20):
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
  iommu/tegra: gart: Integrate with Memory Controller driver
  iommu/tegra: gart: Fix spinlock recursion
  iommu/tegra: gart: Fix NULL pointer dereference
  iommu/tegra: gart: Allow only one active domain at a time
  iommu/tegra: gart: Don't use managed resources
  iommu/tegra: gart: Prepend error/debug messages with "GART:"
  iommu/tegra: gart: Don't detach devices from inactive domains
  iommu/tegra: gart: Simplify clients-tracking code
  iommu/tegra: gart: Perform code refactoring

 .../bindings/iommu/nvidia,tegra20-gart.txt    |  14 -
 .../memory-controllers/nvidia,tegra20-mc.txt  |  27 +-
 arch/arm/boot/dts/tegra20.dtsi                |  15 +-
 drivers/iommu/Kconfig                         |   1 +
 drivers/iommu/iommu.c                         |   8 +-
 drivers/iommu/tegra-gart.c                    | 478 +++++++-----------
 drivers/memory/tegra/mc.c                     |  95 +++-
 drivers/memory/tegra/mc.h                     |   6 -
 include/linux/iommu.h                         |   1 +
 include/soc/tegra/mc.h                        |  29 +-
 10 files changed, 298 insertions(+), 376 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt

-- 
2.19.0
