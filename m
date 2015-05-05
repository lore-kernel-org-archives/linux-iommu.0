From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 00/25] Exynos SYSMMU (IOMMU) integration with DT and
	DMA-mapping subsystem
Date: Tue, 5 May 2015 17:05:54 +0200
Message-ID: <20150505150554.GN15736@8bytes.org>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1430727380-10912-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
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
Cc: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Seung-Woo Kim <sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, David Wodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Marek,

On Mon, May 04, 2015 at 10:15:55AM +0200, Marek Szyprowski wrote:
>   iommu: exynos: don't read version register on every tlb operation

Please use 'iommu/exynos:' as prefix for the iommu patches and start
the remaining subject with a capital letter, like this:

	iommu/exynos: Don't read version register on every tlb operation

>  Documentation/devicetree/bindings/iommu/iommu.txt |  44 ++
>  arch/arm/boot/dts/exynos3250-rinato.dts           |   1 +
>  arch/arm/boot/dts/exynos3250.dtsi                 |  22 +
>  arch/arm/boot/dts/exynos4.dtsi                    | 118 ++++++
>  arch/arm/boot/dts/exynos4210-trats.dts            |   1 +
>  arch/arm/boot/dts/exynos4210-universal_c210.dts   |   1 +
>  arch/arm/boot/dts/exynos4210.dtsi                 |  23 +
>  arch/arm/boot/dts/exynos4412-trats2.dts           |   1 +
>  arch/arm/boot/dts/exynos4415.dtsi                 |  11 +
>  arch/arm/boot/dts/exynos4x12.dtsi                 |  82 ++++
>  arch/arm/boot/dts/exynos5250-snow.dts             |   1 +
>  arch/arm/boot/dts/exynos5250-spring.dts           |   1 +
>  arch/arm/boot/dts/exynos5250.dtsi                 | 250 +++++++++++
>  arch/arm/boot/dts/exynos5420-peach-pit.dts        |   1 +
>  arch/arm/boot/dts/exynos5420.dtsi                 | 181 ++++++++
>  arch/arm/boot/dts/exynos5800-peach-pi.dts         |   1 +
>  arch/arm/mach-exynos/pm_domains.c                 |  18 +-
>  arch/arm/mm/dma-mapping.c                         | 112 +++++
>  drivers/gpu/drm/exynos/exynos_drm_fimd.c          |  27 +-
>  drivers/gpu/drm/exynos/exynos_drm_iommu.c         |   3 +
>  drivers/iommu/exynos-iommu.c                      | 495 ++++++++++------------
>  21 files changed, 1098 insertions(+), 296 deletions(-)

What is the plan for merging this, should it go through the iommu tree
or some other path?


	Joerg
