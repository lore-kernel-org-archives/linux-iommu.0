From: Cho KyongHo <pullip.cho@samsung.com>
Subject: [PATCH v3 00/12] iommu/exynos: Fixes and Enhancements of System MMU
 driver with DT
Date: Wed, 21 Nov 2012 14:02:25 +0900
Message-ID: <002601cdc7a5$66216bd0$32644370$%cho@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: 'Joerg Roedel' <joro@8bytes.org>, 'Sanghyun Lee' <sanghyun75.lee@samsung.com>, 'Kukjin Kim' <kgene.kim@samsung.com>, sw0312.kim@samsung.com, 'Subash Patel' <subash.ramaswamy@linaro.org>, prathyush.k@samsung.com, rahul.sharma@samsung.com
List-Id: iommu@lists.linux-foundation.org

The current exynos-iommu(System MMU) driver does not work autonomously
since it is lack of support for power management of peripheral blocks.
For example, MFC device driver must ensure that its System MMU is disabled
before MFC block is power-down not to invalidate IOTLB in the System MMU
when I/O memory mapping is changed. Because A System MMU is resides in the
same H/W block, access to control registers of System MMU while the H/W
block is turned off must be prohibited.

This set of changes solves the above problem with setting each System MMUs
as the parent of the device which owns the System MMU to recieve the
information when the device is turned off or turned on.

Another big change to the driver is the support for devicetree.
The bindings for System MMU is described in
Documentation/devicetree/bindings/arm/samsung/system-mmu.txt

In addition, this patchset also includes several bug fixes and enhancements
of the current driver.

Change log:
v2:
- Split the patch to iommu/exynos into 9 patches
- Support for System MMU 3.3
- Some code compaction

v3:
- Fix prefetch buffer flag definition for System MMU 3.3 (patch 10/12)
- Fix incorrect setting for SET_RUNTIME_PM_OPS (patch 09/12)
   Thanks to Prathyush.

Patch summary:
[PATCH v3 01/12] ARM: EXYNOS: remove system mmu initialization from exynos tree
[PATCH v3 02/12] ARM: EXYNOS: Add clk_ops for gating clocks of System MMU
[PATCH v3 03/12] ARM: EXYNOS: add System MMU definition to DT
[PATCH v3 04/12] iommu/exynos: support for device tree
[PATCH v3 05/12] iommu/exynos: pass version information from DT
[PATCH v3 06/12] iommu/exynos: allocate lv2 page table from own slab
[PATCH v3 07/12] iommu/exynos: change rwlock to spinlock
[PATCH v3 08/12] iommu/exynos: set System MMU as the parent of client device
[PATCH v3 09/12] iommu/exynos: add supoort for runtime pm and suspend/resume
[PATCH v3 10/12] iommu/exynos: add support for System MMU 3.2 and 3.3
[PATCH v3 11/12] iommu/exynos: add literal name of System MMU for debugging
[PATCH v3 12/12] iommu/exynos: add debugfs entries for System MMU


Diffstats:
 .../devicetree/bindings/arm/exynos/system-mmu.txt  |   86 ++
 arch/arm/boot/dts/exynos4210.dtsi                  |   96 ++
 arch/arm/boot/dts/exynos4x12.dtsi                  |  124 ++
 arch/arm/boot/dts/exynos5250.dtsi                  |  147 +-
 arch/arm/mach-exynos/Kconfig                       |    5 -
 arch/arm/mach-exynos/Makefile                      |    1 -
 arch/arm/mach-exynos/clock-exynos4.c               |   41 +-
 arch/arm/mach-exynos/clock-exynos4210.c            |    9 +-
 arch/arm/mach-exynos/clock-exynos4212.c            |   23 +-
 arch/arm/mach-exynos/clock-exynos5.c               |   87 +-
 arch/arm/mach-exynos/dev-sysmmu.c                  |  274 ----
 arch/arm/mach-exynos/include/mach/sysmmu.h         |   66 -
 arch/arm/mach-exynos/mach-exynos4-dt.c             |   34 +
 arch/arm/mach-exynos/mach-exynos5-dt.c             |   30 +
 drivers/iommu/Kconfig                              |    2 +-
 drivers/iommu/exynos-iommu.c                       | 1424 +++++++++++++++-----
 16 files changed, 1718 insertions(+), 731 deletions(-)
