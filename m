From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v6 00/12] iommu/exynos: Fixes and Enhancements of System MMU
	driver with DT
Date: Wed, 26 Dec 2012 10:53:15 +0900
Message-ID: <003301cde30b$c584c2d0$508e4870$%cho@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-language: ko
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Linux ARM Kernel' <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, 'Linux IOMMU' <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, 'Linux Kernel' <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Linux Samsung SOC' <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: 'Kukjin Kim' <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Hyunwoong Kim' <khw0178.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Prathyush' <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Subash Patel' <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Rahul Sharma' <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

notice: v6 patch-set is rebased on next/iommu-exynos branch of
linux-samsung.git.  This patch-set does not include 2 patches (05 and 06
patches in v5 patch-se) because they alread exist already in the branch.

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
v6:
- Rebased on the branch, next/iommu-exynos of
  git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git

v5:
- new bugfix: patch 01
- Reordered patches
  * patch 01 ~ 05: Bugfix and enhancements of the existing driver
  * patch 06 ~ 10: Device Tree support and callbacks for power management
  * patch 11     : System MMU 3.2 and 3.3 support
  * patch 12 ~ 14: Debugging features
- Additional code compaction

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
[PATCH v6 01/12] iommu/exynos: add missing cache flush for removed pagetable entries
[PATCH v6 02/12] iommu/exynos: always use iommu fault handler
[PATCH v6 03/12] iommu/exynos: allocate lv2 page table from own slab
[PATCH v6 04/12] iommu/exynos: change rwlock to spinlock
[PATCH v6 05/12] iommu/exynos: support for device tree
[PATCH v6 06/12] iommu/exynos: set System MMU as the parent of client device
[PATCH v6 07/12] ARM: EXYNOS: remove system mmu initialization from exynos tree
[PATCH v6 08/12] iommu/exynos: add support for runtime pm and suspend/resume
[PATCH v6 09/12] iommu/exynos: add support for System MMU 3.2 and 3.3
[PATCH v6 10/12] iommu/exynos: pass version information from DT
[PATCH v6 11/12] iommu/exynos: add literal name of System MMU for debugging
[PATCH v6 12/12] iommu/exynos: add debugfs entries for System MMU

Diffstats:
 arch/arm/boot/dts/exynos5250-smdk5250.dts  |    2 +-
 arch/arm/boot/dts/exynos5250.dtsi          |   27 +-
 arch/arm/mach-exynos/Kconfig               |    5 -
 arch/arm/mach-exynos/Makefile              |    1 -
 arch/arm/mach-exynos/clock-exynos4.c       |   41 +-
 arch/arm/mach-exynos/clock-exynos4210.c    |    9 +-
 arch/arm/mach-exynos/clock-exynos4212.c    |   23 +-
 arch/arm/mach-exynos/clock-exynos5.c       |   87 +-
 arch/arm/mach-exynos/dev-sysmmu.c          |  274 ------
 arch/arm/mach-exynos/include/mach/sysmmu.h |   66 --
 arch/arm/mach-exynos/mach-exynos4-dt.c     |   34 +
 arch/arm/mach-exynos/mach-exynos5-dt.c     |   30 +
 drivers/iommu/Kconfig                      |    2 +-
 drivers/iommu/Makefile                     |    2 +-
 drivers/iommu/exynos-iommu.c               | 1477 +++++++++++++++++++++-------
 15 files changed, 1284 insertions(+), 796 deletions(-)
