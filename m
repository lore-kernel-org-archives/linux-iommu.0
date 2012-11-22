From: Cho KyongHo <pullip.cho@samsung.com>
Subject: [PATCH v4 00/12] iommu/exynos: Fixes and Enhancements of System MMU
 driver with DT
Date: Thu, 22 Nov 2012 20:31:59 +0900
Message-ID: <002101cdc8a4$fc375990$f4a60cb0$%cho@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-language: ko
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: 'Kukjin Kim' <kgene.kim@samsung.com>, prathyush.k@samsung.com, 'Joerg Roedel' <joro@8bytes.org>, sw0312.kim@samsung.com, 'Subash Patel' <subash.ramaswamy@linaro.org>, 'Sanghyun Lee' <sanghyun75.lee@samsung.com>, rahul.sharma@samsung.com
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
v4:
- Remove Change-Id from v3 patches
- Change the order of the third and the first patch
  Thanks to Kukjin Kim.
- Fix memory leak when allocating and assigning exynos_iommu_owner to client
  device if the client device has multiple System MMUs.
  Thanks to Rahul Sharma.

v3:
- Fix prefetch buffer flag definition for System MMU 3.3 (patch 10/12)
- Fix incorrect setting for SET_RUNTIME_PM_OPS (patch 09/12)
  Thanks to Prathyush.

v2:
- Split the patch to iommu/exynos into 9 patches
- Support for System MMU 3.3
- Some code compaction

Patch summary:
[PATCH v4 01/12] ARM: EXYNOS: Add clk_ops for gating clocks of System MMU
[PATCH v4 02/12] ARM: EXYNOS: add System MMU definition to DT
[PATCH v4 03/12] ARM: EXYNOS: remove system mmu initialization from exynos tree
[PATCH v4 04/12] iommu/exynos: support for device tree
[PATCH v4 05/12] iommu/exynos: pass version information from DT
[PATCH v4 06/12] iommu/exynos: allocate lv2 page table from own slab
[PATCH v4 07/12] iommu/exynos: change rwlock to spinlock
[PATCH v4 08/12] iommu/exynos: set System MMU as the parent of client device
[PATCH v4 09/12] iommu/exynos: add support for runtime pm and suspend/resume
[PATCH v4 10/12] iommu/exynos: add support for System MMU 3.2 and 3.3
[PATCH v4 11/12] iommu/exynos: add literal name of System MMU for debugging
[PATCH v4 12/12] iommu/exynos: add debugfs entries for System MMU

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
 arch/arm/mach-exynos/clock-exynos5.c               |   86 +-
 arch/arm/mach-exynos/dev-sysmmu.c                  |  274 ----
 arch/arm/mach-exynos/include/mach/sysmmu.h         |   66 -
 arch/arm/mach-exynos/mach-exynos4-dt.c             |   34 +
 arch/arm/mach-exynos/mach-exynos5-dt.c             |   30 +
 drivers/iommu/Kconfig                              |    2 +-
 drivers/iommu/exynos-iommu.c                       | 1428 +++++++++++++++-----
 16 files changed, 1720 insertions(+), 732 deletions(-)
