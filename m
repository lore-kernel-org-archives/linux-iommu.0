From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 00/18] Exynos SYSMMU (IOMMU) integration with DT and
	DMA-mapping subsystem
Date: Tue, 16 Sep 2014 13:54:27 +0200
Message-ID: <1410868485-4143-1-git-send-email-m.szyprowski@samsung.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, David Wodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello Everyone,

This is yet another attempt to finally make Exynos SYSMMU driver fully
integrated with DMA-mapping subsystem.

Previous approach is available here: https://lkml.org/lkml/2014/8/5/183

I meantime, there have been a discussion about the way the iommu driver
should be integrated with dma-mapping subsystem, which resulted in "[RFC
PATCH v3 0/7] Introduce automatic DMA configuration for IOMMU masters"
patches prepared by Will Deacon:
http://www.spinics.net/lists/arm-kernel/msg362076.html 
Those patches removed the need to use bus-specific notifiers for
initialization.

Main changes since previous version of my patches:

1. rebased onto "[RFC PATCH v3 0/7] Introduce automatic DMA
configuration for IOMMU masters" patches, changed initialization from
bus notifiers to DT related callbacks

2. removed support for separate IO address spaces - this will be
discussed separately after the basic support gets merged

3. removed support for power domain notifier-based runtime power
management - this also will be discussed separately later

I hope that the driver with above changes will be easier to be merged to
v3.18.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland



Patch summary:

Marek Szyprowski (18):
  arm: dma-mapping: arm_iommu_attach_device: automatically set
    max_seg_size
  arm: exynos: bind power domains earlier, on device creation
  drm: exynos: detach from default dma-mapping domain on init
  clk: exynos: add missing smmu_g2d clock and update comments
  ARM: DTS: Exynos4: add System MMU nodes
  iommu: exynos: don't read version register on every tlb operation
  iommu: exynos: remove unused functions
  iommu: exynos: remove useless spinlock
  iommu: exynos: refactor function parameters to simplify code
  iommu: exynos: remove unused functions, part 2
  iommu: exynos: remove useless device_add/remove callbacks
  iommu: exynos: add support for binding more than one sysmmu to master
    device
  iommu: exynos: add support for runtime_pm
  iommu: exynos: rename variables to reflect their purpose
  iommu: exynos: document internal structures
  iommu: exynos: remove excessive includes and sort others
    alphabetically
  iommu: exynos: init from dt-specific callback instead of initcall
  iommu: exynos: add callback for initializing devices from device tree

 arch/arm/boot/dts/exynos4.dtsi            | 117 +++++++
 arch/arm/boot/dts/exynos4210.dtsi         |  23 ++
 arch/arm/boot/dts/exynos4x12.dtsi         |  82 +++++
 arch/arm/mach-exynos/pm_domains.c         |  12 +-
 arch/arm/mm/dma-mapping.c                 |  16 +
 drivers/clk/samsung/clk-exynos4.c         |   1 +
 drivers/gpu/drm/exynos/exynos_drm_iommu.c |   3 +
 drivers/iommu/exynos-iommu.c              | 494 ++++++++++++++----------------
 include/dt-bindings/clock/exynos4.h       |  10 +-
 9 files changed, 483 insertions(+), 275 deletions(-)

-- 
1.9.2
