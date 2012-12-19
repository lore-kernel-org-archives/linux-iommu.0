From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v5 00/12] iommu/exynos: Fixes and Enhancements of System
 MMU driver with DT
Date: Tue, 18 Dec 2012 20:11:05 -0800
Message-ID: <002301cddd9e$dfe265a0$9fa730e0$@samsung.com>
References: <003001cdd78f$a9bb1e00$fd315a00$%cho@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <003001cdd78f$a9bb1e00$fd315a00$%cho@samsung.com>
Content-language: en-us
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Cho KyongHo' <pullip.cho@samsung.com>, 'Linux ARM Kernel' <linux-arm-kernel@lists.infradead.org>, 'Linux IOMMU' <iommu@lists.linux-foundation.org>, 'Linux Kernel' <linux-kernel@vger.kernel.org>, 'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>
Cc: 'Dae Inki' <inki.dae@samsung.com>, 'Joerg Roedel' <joro@8bytes.org>, 'Prathyush' <prathyush.k@samsung.com>, 'Rahun Sharma' <rahul.sharma@samsung.com>, 'Sanghyun Lee' <sanghyun75.lee@samsung.com>, 'Subash Patel' <subash.ramaswamy@linaro.org>, 'SWKim' <sw0312.kim@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Cho KyoungHo wrote:
> 
> The current exynos-iommu(System MMU) driver does not work
> autonomously
> since it is lack of support for power management of peripheral blocks.
> For example, MFC device driver must ensure that its System MMU is
> disabled
> before MFC block is power-down not to invalidate IOTLB in the System MMU
> when I/O memory mapping is changed. Because A System MMU is resides in
> the
> same H/W block, access to control registers of System MMU while the H/W
> block is turned off must be prohibited.
> 
> This set of changes solves the above problem with setting each System
> MMUs
> as the parent of the device which owns the System MMU to receive the
> information when the device is turned off or turned on.
> 
> Another big change to the driver is the support for devicetree.
> The bindings for System MMU is described in
> Documentation/devicetree/bindings/arm/samsung/system-mmu.txt
> 
> In addition, this patchset also includes several bug fixes and
enhancements
> of the current driver.
> 
> Change log:
> v5:
> - new bugfix: patch 01
> - Reordered patches
>   * patch 01 ~ 05: Bugfix and enhancements of the existing driver
>   * patch 06 ~ 10: Device Tree support and callbacks for power management
>   * patch 11     : System MMU 3.2 and 3.3 support
>   * patch 12 ~ 14: Debugging features
> - Additional code compaction
> 
> v4:
> - Remove Change-Id from v3 patches
> - Change the order of the third and the first patch
>   Thanks to Kukjin Kim.
> - Fix memory leak when allocating and assigning exynos_iommu_owner to
> client
>   device if the client device has multiple System MMUs.
>   Thanks to Rahul Sharma.
> 
> v3:
> - Fix prefetch buffer flag definition for System MMU 3.3 (patch 10/12)
> - Fix incorrect setting for SET_RUNTIME_PM_OPS (patch 09/12)
>   Thanks to Prathyush.
> 
> v2:
> - Split the patch to iommu/exynos into 9 patches
> - Support for System MMU 3.3
> - Some code compaction
> 
> Patch summary:
> [PATCH v5 01/14] iommu/exynos: add missing cache flush for removed
> pagetable entries
> [PATCH v5 02/14] iommu/exynos: always use iommu fault handler
> [PATCH v5 03/14] iommu/exynos: allocate lv2 page table from own slab
> [PATCH v5 04/14] iommu/exynos: change rwlock to spinlock
> [PATCH v5 05/14] ARM: EXYNOS: Add clk_ops for gating clocks of System
> MMU
> [PATCH v5 06/14] ARM: EXYNOS: add System MMU definition to DT
> [PATCH v5 07/14] iommu/exynos: support for device tree
> [PATCH v5 08/14] iommu/exynos: set System MMU as the parent of client
> device
> [PATCH v5 09/14] ARM: EXYNOS: remove system mmu initialization from
> exynos tree
> [PATCH v5 10/14] iommu/exynos: add support for runtime pm and
> suspend/resume
> [PATCH v5 11/14] iommu/exynos: add support for System MMU 3.2 and 3.3
> [PATCH v5 12/14] iommu/exynos: pass version information from DT
> [PATCH v5 13/14] iommu/exynos: add literal name of System MMU for
> debugging
> [PATCH v5 14/14] iommu/exynos: add debugfs entries for System MMU
> 
> Diffstats:
>  .../devicetree/bindings/arm/exynos/system-mmu.txt  |   86 ++
>  arch/arm/boot/dts/exynos4210.dtsi                  |   96 ++
>  arch/arm/boot/dts/exynos4x12.dtsi                  |  124 ++
>  arch/arm/boot/dts/exynos5250.dtsi                  |  154 +-
>  arch/arm/mach-exynos/Kconfig                       |    5 -
>  arch/arm/mach-exynos/Makefile                      |    1 -
>  arch/arm/mach-exynos/clock-exynos4.c               |   41 +-
>  arch/arm/mach-exynos/clock-exynos4210.c            |    9 +-
>  arch/arm/mach-exynos/clock-exynos4212.c            |   23 +-
>  arch/arm/mach-exynos/clock-exynos5.c               |   86 +-
>  arch/arm/mach-exynos/dev-sysmmu.c                  |  274 ----
>  arch/arm/mach-exynos/include/mach/sysmmu.h         |   66 -
>  arch/arm/mach-exynos/mach-exynos4-dt.c             |   34 +
>  arch/arm/mach-exynos/mach-exynos5-dt.c             |   30 +
>  drivers/iommu/Kconfig                              |    2 +-
>  drivers/iommu/Makefile                             |    2 +-
>  drivers/iommu/exynos-iommu.c                       | 1477
+++++++++++++++-----
>  17 files changed, 1745 insertions(+), 765 deletions(-)

Hmm, the 5th and 6th patches which were 1st and 2nd patches in previous
version are not merged into mainline via Samsung tree yet. Just merged into
Samsung tree. But if Joerg is ok on this series, this series should be
merged into both tree...Joerg, how do you think?

- Kukjin
