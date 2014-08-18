From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 00/29] Exynos SYSMMU (IOMMU) integration with DT and
	DMA-mapping subsystem
Date: Tue, 19 Aug 2014 01:32:01 +0200
Message-ID: <20140818233201.GL9809@8bytes.org>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1407235677-26324-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 05, 2014 at 12:47:28PM +0200, Marek Szyprowski wrote:
>  .../devicetree/bindings/iommu/samsung,sysmmu.txt   |  93 ++-
>  Documentation/power/notifiers.txt                  |  14 +
>  arch/arm/boot/dts/exynos4.dtsi                     | 118 ++++
>  arch/arm/boot/dts/exynos4210.dtsi                  |  23 +
>  arch/arm/boot/dts/exynos4x12.dtsi                  |  82 +++
>  arch/arm/include/asm/dma-iommu.h                   |  36 ++
>  arch/arm/mach-exynos/pm_domains.c                  |  12 +-
>  arch/arm/mach-integrator/impd1.c                   |   2 +-
>  arch/arm/mm/dma-mapping.c                          |  47 ++
>  drivers/base/bus.c                                 |   4 +-
>  drivers/base/dd.c                                  |  10 +-
>  drivers/base/platform.c                            |   2 +-
>  drivers/base/power/domain.c                        |  70 ++-
>  drivers/clk/samsung/clk-exynos4.c                  |   1 +
>  drivers/gpu/drm/exynos/exynos_drm_fimc.c           |   1 +
>  drivers/gpu/drm/exynos/exynos_drm_fimd.c           |  26 +-
>  drivers/gpu/drm/exynos/exynos_drm_g2d.c            |   1 +
>  drivers/gpu/drm/exynos/exynos_drm_gsc.c            |   1 +
>  drivers/gpu/drm/exynos/exynos_drm_rotator.c        |   1 +
>  drivers/gpu/drm/exynos/exynos_mixer.c              |   1 +
>  drivers/iommu/exynos-iommu.c                       | 663 +++++++++++++--------
>  drivers/iommu/iommu.c                              |   3 +
>  drivers/media/platform/s5p-mfc/s5p_mfc.c           | 107 ++--
>  drivers/pci/host/pci-mvebu.c                       |   2 +-
>  drivers/pci/host/pci-rcar-gen2.c                   |   2 +-
>  drivers/pci/host/pci-tegra.c                       |   2 +-
>  drivers/pci/host/pcie-rcar.c                       |   2 +-
>  drivers/soc/tegra/pmc.c                            |   2 +-
>  include/dt-bindings/clock/exynos4.h                |  10 +-
>  include/linux/device.h                             |  12 +-
>  include/linux/iommu.h                              |   1 +
>  include/linux/pm.h                                 |   2 +
>  include/linux/pm_domain.h                          |  19 +
>  33 files changed, 1016 insertions(+), 356 deletions(-)

This touches a lot of non-iommu stuff. What is your strategy on getting
this in, do you plan to get the non-iommu changes merged first or do you
want to collect the respective Acks and merge this all through one tree?


	Joerg
