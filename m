From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v12 0/3] iommu/exynos: Add IOMMU/System MMU driver for Samsung
	Exynos
Date: Thu, 15 Mar 2012 17:32:36 +0900
Message-ID: <000001cd0286$2cf947e0$86ebd7a0$%cho@samsung.com>
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
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.orglinux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.orglinux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.orgiommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.orglinux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: 'Kukjin Kim' <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Subash Patel' <subash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Younglak Kim' <younglak1004.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Kyungmin Park' <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Sanghyun Lee' <sanghyun75.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

These patches are successfully compiled in
linux-samsung.git/for-next branch
You can find the git repo in
http://git.kernel.org/?p=linux/kernel/git/kgene/linux-samsung.git

Changes since v11:
- Removed struct iommu_client and merged it
   with struct sysmmu_drvdata
- Fix kfree() invalid address in exynos_iommu_destroy_domain().

Changes since v10:
- Prevent race condition between iommu_attach_device() and
   iommu_detach_device().
- Added declaration of platform device for System MMU-FIMCs
   in mach/sysmmu.h.
- Some changes on macros and type names:
   * enum EXYNOS_SYSMMU_INTERRUPT_TYPE
      -> enum exynos_sysmmu_inttype
   * Changed macro definitions for register offsets
      to look uniform.

Changes since v9:
- Split the first patch into 2 patches.
   One removes System MMU driver from arch/arm/plat- tree and
   the other modifies and adds platform device definitions in
   arch/arm/mach tree
- Some bug fixes
- Change "gsc" for Exynos4 to "fimc"

Changes since v8:
- exynos_iommu_map/unmap() just works for the page sizes
   that System MMU supports. (Joerg's comment)
- 1 platform device for 1 H/W though a multimedia accelerator
   with several System MMUs attached.
   This make controlling System MMU simpler.
- Information between System MMU and the accelerators:
   Shifted to accelerator's device structure from System MMU's

Changes since v7:
- Rebased with the recent commits of the following git branches
  * git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/next
  * git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git/for-next
- Changed magic numbers into macros
- Setting owner of a System MMU in 'iommu' field of dev_archdata
- Verbose message in the default fault handler
- Some bug fixes.

Changes since v6:
- Totally rewrite exynos_iommu_map() and exynos_iommu_unmap() according
  to the change in iommu_map() and iommu_unmap().
- Change special slab for Lv2 page table to kmalloc().

Changes since v5:
- Relation between device and a domain become n:1 (Joerg's comment)
- Implements iommu_commit(). --> Removed

Changes since v4:
- exynos_iommu_unmap()returns unmapped size in page order
  (Ohad Ben-Cohen's comment)
- Fixed typo error of resource names
- Fixed missing #include<mach/sysmmu.h>
  in arch/arm/mach-exynos4/mach-armlex4210.c

Changes since v3:
- Used DEFINE_RES_MEM and DEFINE_RES_IRQ macros
  to define resources of System MMU (Russell King's comment)
- Fixed removal of CONFIG_S5P_SLEEP definition  (Sylwester Nawrocki's comment)

Changes since v2:
- Add lock for System MMU private data.
  And fixes the following problems pointed by Joerg Rodel:
- Fix wrong argument to kmalloc() and get_free_pages()
- Merged patches into 2 due to bisectability

Changes since v1:
Fixes of the following problems pointed by Russell King.:
 - Missing unlocking a spinlock in exynos_iommu_attach_dev().
 - atomic_t -> int in sysmmu_drvdata.activations
 - sysmmu_platdata -> sysmmu_drvdata
 - Change in error messages in irq handler
 - Removed casting in format of error message
 - omap_iommu_ops -> exynos_iommu_ops in the last patch

Patch Summary:
[PATCH v12 1/3] S5P: SYSMMU: Remove System MMU device driver
[PATCH v12 2/3] ARM: EXYNOS: Change System MMU platform device definitions
[PATCH v12 3/3] iommu/exynos: Add iommu driver for Exynos Platforms

The first patch removes the existing System MMU device driver which does not conform to IOMMU API set prepared in the kernel.
 
The second patch enhances System MMU platform device definition:
 - Removed System MMU for MDMA0 in TOP block because it is not
   used. Use MDMA2 in LCD block.
 - Removed System MMU ID. Instead, a System MMU is bound to a device
   that the System MMU is dedicated during machine initialization.
   If a device driver wants to handle System MMU, it must bind its
   device with System MMU with sysmmu_set_owner().
 - clkdev
 - Added support for Exynos5

The last patch implements IOMMU API:
- New System MMU device driver that fully implements IOMMU API.

Thanks to Kyungmin Park and Marek Szyprowski for kind review.

Diffstats:
 arch/arm/mach-exynos/Kconfig                    |   10 +-
 arch/arm/mach-exynos/Makefile                   |    2 +-
 arch/arm/mach-exynos/clock-exynos4.c            |   79 +-
 arch/arm/mach-exynos/clock-exynos4.h            |    2 +
 arch/arm/mach-exynos/clock-exynos4210.c         |   11 +
 arch/arm/mach-exynos/clock-exynos4212.c         |   28 +-
 arch/arm/mach-exynos/clock-exynos5.c            |   90 ++
 arch/arm/mach-exynos/dev-sysmmu.c               |  457 ++++++-----
 arch/arm/mach-exynos/include/mach/irqs.h        |   25 +-
 arch/arm/mach-exynos/include/mach/map.h         |   38 +
 arch/arm/mach-exynos/include/mach/regs-clock.h  |    5 +
 arch/arm/mach-exynos/include/mach/regs-sysmmu.h |   28 -
 arch/arm/mach-exynos/include/mach/sysmmu.h      |   88 ++-
 arch/arm/mach-exynos/mach-armlex4210.c          |    1 -
 arch/arm/mach-exynos/mach-smdkv310.c            |    1 -
 arch/arm/plat-s5p/Kconfig                       |    8 -
 arch/arm/plat-s5p/Makefile                      |    1 -
 arch/arm/plat-s5p/sysmmu.c                      |  313 -------
 arch/arm/plat-samsung/include/plat/devs.h       |    1 -
 arch/arm/plat-samsung/include/plat/sysmmu.h     |   95 --
 drivers/iommu/Kconfig                           |   21 +
 drivers/iommu/Makefile                          |    1 +
 drivers/iommu/exynos-iommu.c                    | 1057 +++++++++++++++++++++++
 23 files changed, 1608 insertions(+), 754 deletions(-)
