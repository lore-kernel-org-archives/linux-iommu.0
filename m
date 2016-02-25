From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 00/13] SYSMMU driver update and support for Exynos 5433
Date: Thu, 25 Feb 2016 15:34:03 +0100
Message-ID: <20160225143403.GC16675@8bytes.org>
References: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, Feb 18, 2016 at 03:12:47PM +0100, Marek Szyprowski wrote:
> Marek Szyprowski (13):
>   iommu: exynos: rework iommu group initialization
>   iommu: exynos: add support for IOMMU_DOMAIN_DMA domain type
>   iommu: exynos: remove ARM-specific cache flush interface
>   iommu: exynos: simplify master clock operations
>   iommu: exynos: refactor code (no direct register access)
>   iommu: exynos: refactor fault handling code
>   iommu: exynos: refactor init config code
>   iommu: exynos: unify code for fldp cache invalidation
>   iommu: exynos: add support for SYSMMU controller with bogus version
>     reg
>   iommu: exynos: update device tree documentation
>   iommu: exynos: add support for v5 SYSMMU
>   iommu: exynos: add Maintainers entry for Exynos SYSMMU driver
>   iommu: exynos: support multiple attach_device calls
> 
>  .../devicetree/bindings/iommu/samsung,sysmmu.txt   |  22 +-
>  MAINTAINERS                                        |   6 +
>  drivers/iommu/Kconfig                              |   2 +-
>  drivers/iommu/exynos-iommu.c                       | 598 ++++++++++++---------
>  4 files changed, 372 insertions(+), 256 deletions(-)

Applied all patches and changed the subjects to:

Marek Szyprowski (13):
      iommu/exynos: Rework iommu group initialization
      iommu/exynos: Add support for IOMMU_DOMAIN_DMA domain type
      iommu/exynos: Remove ARM-specific cache flush interface
      iommu/exynos: Simplify master clock operations
      iommu/exynos: Refactor code (no direct register access)
      iommu/exynos: Refactor fault handling code
      iommu/exynos: Refactor init config code
      iommu/exynos: Unify code for fldp cache invalidation
      iommu/exynos: Add support for SYSMMU controller with bogus version reg
      iommu/exynos: Update device tree documentation
      iommu/exynos: Add support for v5 SYSMMU
      iommu/exynos: Add Maintainers entry for Exynos SYSMMU driver
      iommu/exynos: Support multiple attach_device calls

Please make sure you follow this sheme for future iommu patches too.

Thanks,

	Joerg
