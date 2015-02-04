From: Hongbo Zhang <hongbo.zhang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 00/18] Exynos SYSMMU (IOMMU) integration with DT and
	DMA-mapping subsystem
Date: Wed, 4 Feb 2015 17:53:25 +0800
Message-ID: <CAOhR-w3xdFtNGi=cfEM=N4ntjrjGwMUzxnqHWoRwy6r-AQOAjA@mail.gmail.com>
References: <1422028288-891-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422028288-891-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
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
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Seung-Woo Kim <sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Linaro MM SIG Mailman List <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, David Wodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Marek,
This is patch set against v3.19-rc4 plus 'Add HDMI support for
Exynos5420 platform', right?
No other dependencies? If there is, do you have a public git tree to be cloned?

Thanks.

On 23 January 2015 at 23:51, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> Hello Everyone,
>
> This is yet another attempt to get Exynos SYSMMU driver with integrated
> with IOMMU & DMA-mapping subsystems. The main change from previous
> version is a rebase onto some more pending Exynos DTS patches and minor
> fixes of the reported issues.
>
> Merge plan for this patchset:
>
> 1. All iommu related patches (with 'iommu: exynos') can be merged to
> iommu tree. They don't have any direct dependencies on the DTS, DRM and
> power domain initialization change - without them the driver will simply
> not initialize, when no exynos,sysmmu nodes are provided in device tree.
>
> Joerg, could you merge those patches?
>
>
> 2. DTS and power domain patches should go to Samsung Exynos tree. Those
> patches depends on earlier DTS patches for Exynos SoCs, which make
> this patchset really complete:
> - 'ARM: DTS: Exynos: convert to generic power domain bindings'
>   (http://www.spinics.net/lists/linux-samsung-soc/msg40584.html)
> - '[PATCH v4 0/7] Enable HDMI support on Exynos platforms'
>   (http://www.spinics.net/lists/arm-kernel/msg391148.html)
> - '[PATCH 0/2] Add HDMI support for Exynos5420 platform'
>   (http://www.spinics.net/lists/linux-samsung-soc/msg41364.html)
>
> Kukjin, could you merge those patches?
>
>
> 3. Exynos DRM fix. This patch in my opinion should go Exynos DRM tree.
>
> Inki, could you merge it?
>
>
> Best regards
> Marek Szyprowski
> Samsung R&D Institute Poland
>
>
> Changelog:
>
> v5:
> - rebased onto 'Add HDMI support for Exynos5420 platform' patchset
> - fixed 'const' issue in 'iommu: exynos: init from dt-specific callback
>   instead of initcall' patch, thanks to Tobias Jakobi for reporting it
> - fixed copy-paste typo in exynos5250 dts patch
>
> v4: http://www.spinics.net/lists/linux-samsung-soc/msg41177.html
> - rebased onto v3.19-rc4 and other Exynos DTS queued patches
> - added DTS patch for Exynos 5250 & 5420/5422/5800
>
> v3: http://www.spinics.net/lists/linux-samsung-soc/msg39168.html
> - rebased onto "[RFC PATCH v4 0/8] Introduce automatic DMA
>   configuration for IOMMU masters"
> - added some minor fixes for iommu and dma-mapping frameworks
>
> v2: http://thread.gmane.org/gmane.linux.kernel.iommu/6472/
> - rebased onto "[RFC PATCH v3 0/7] Introduce automatic DMA
>   configuration for IOMMU masters" patches:
>   http://www.spinics.net/lists/arm-kernel/msg362076.html
> - changed initialization from bus notifiers to DT related callbacks
> - removed support for separate IO address spaces - this will be
>   discussed separately after the basic support gets merged
> - removed support for power domain notifier-based runtime power
>   management - this also will be discussed separately later
>
> v1: https://lkml.org/lkml/2014/8/5/183
> - initial version, feature complete, completely rewrote integration
>   approach
>
>
> Patch summary:
>
> Marek Szyprowski (18):
>   drm: exynos: detach from default dma-mapping domain on init
>   arm: exynos: pm_domains: add support for devices registered before
>     arch_initcall
>   ARM: dts: exynos4: add sysmmu nodes
>   ARM: dts: exynos5250: add sysmmu nodes
>   ARM: dts: exynos5420: add sysmmu nodes
>   iommu: exynos: don't read version register on every tlb operation
>   iommu: exynos: remove unused functions
>   iommu: exynos: remove useless spinlock
>   iommu: exynos: refactor function parameters to simplify code
>   iommu: exynos: remove unused functions, part 2
>   iommu: exynos: remove useless device_add/remove callbacks
>   iommu: exynos: add support for binding more than one sysmmu to master
>     device
>   iommu: exynos: add support for runtime_pm
>   iommu: exynos: rename variables to reflect their purpose
>   iommu: exynos: document internal structures
>   iommu: exynos: remove excessive includes and sort others
>     alphabetically
>   iommu: exynos: init from dt-specific callback instead of initcall
>   iommu: exynos: add callback for initializing devices from device tree
>
>  arch/arm/boot/dts/exynos4.dtsi            | 118 +++++++
>  arch/arm/boot/dts/exynos4210.dtsi         |  23 ++
>  arch/arm/boot/dts/exynos4x12.dtsi         |  82 +++++
>  arch/arm/boot/dts/exynos5250.dtsi         | 250 +++++++++++++++
>  arch/arm/boot/dts/exynos5420.dtsi         | 181 +++++++++++
>  arch/arm/mach-exynos/pm_domains.c         |   9 +-
>  drivers/gpu/drm/exynos/exynos_drm_iommu.c |   3 +
>  drivers/iommu/exynos-iommu.c              | 492 ++++++++++++++----------------
>  8 files changed, 888 insertions(+), 270 deletions(-)
>
> --
> 1.9.2
>
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
