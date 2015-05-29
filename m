From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 00/25] Exynos SYSMMU (IOMMU) integration with DT and
	DMA-mapping subsystem
Date: Fri, 29 May 2015 10:52:30 +0200
Message-ID: <20150529085230.GE13130@8bytes.org>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1432041645-11172-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
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
Cc: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Seung-Woo Kim <sw0312.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, David Wodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, May 19, 2015 at 03:20:20PM +0200, Marek Szyprowski wrote:
> Marek Szyprowski (25):
>   drm/exynos: iommu: detach from default dma-mapping domain on init
>   drm/exynos: fimd: ensure proper hw state in fimd_clear_channel()
>   iommu: Init iommu-groups support earlier, in core_initcall
>   iommu/exynos: Don't read version register on every tlb operation
>   iommu/exynos: Remove unused functions
>   iommu/exynos: Remove useless members from exynos_iommu_owner structure
>   iommu/exynos: Refactor function parameters to simplify code
>   iommu/exynos: Rename variables to reflect their purpose
>   iommu/exynos: Use struct exynos_iommu_domain in internal structures
>   iommu/exynos: Remove excessive includes and sort others alphabetically
>   iommu/exynos: Document internal structures
>   iommu/exynos: Add/remove callbacks should fail if no iommu is
>     available
>   iommu/exynos: Add support for binding more than one sysmmu to master
>     device
>   iommu/exynos: Add support for runtime_pm
>   iommu/exynos: Add system suspend/resume support
>   iommu/exynos: Init from dt-specific callback instead of initcall
>   iommu/exynos: Add callback for initializing devices from device tree
>   ARM: Exynos: pm_domains: register power domain driver from
>     core_initcall
>   ARM: dts: exynos4: add sysmmu nodes
>   ARM: dts: exynos3250: add sysmmu nodes
>   ARM: dts: exynos4415: add sysmmu nodes
>   ARM: dts: exynos5250: add sysmmu nodes
>   ARM: dts: exynos5420: add sysmmu nodes
>   ARM: DMA-mapping: add support for creating reserved mappings in iova
>     space
>   ARM: dts: exynos: add iommu reserved regions for bootloader's splash
>     screen

Applied patches 3-17 to arm/exynos, thanks.
