From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v4 17/18] iommu: exynos: init from dt-specific callback instead of initcall
Date: Mon, 19 Jan 2015 03:11:07 +0200
Message-ID: <10691050.Z5RGmE4fp0@avalon>
References: <1421399592-7482-1-git-send-email-m.szyprowski@samsung.com> <1421399592-7482-18-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1421399592-7482-18-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi Marek,

Thank you for the patch.

On Friday 16 January 2015 10:13:11 Marek Szyprowski wrote:
> This patch introduces IOMMU_OF_DECLARE-based initialization to the
> driver, which replaces subsys_initcall-based procedure.
> exynos_iommu_of_setup ensures that each sysmmu controller is probed
> before its master device.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/iommu/exynos-iommu.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index c53cc8f61176..ea2659159e63 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -13,16 +13,21 @@
>  #endif
> 
>  #include <linux/clk.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/iommu.h>
>  #include <linux/interrupt.h>
>  #include <linux/list.h>
> +#include <linux/of.h>
> +#include <linux/of_iommu.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
> 
>  #include <asm/cacheflush.h>
> +#include <asm/dma-iommu.h>
>  #include <asm/pgtable.h>
> 
>  typedef u32 sysmmu_iova_t;
> @@ -1084,6 +1089,8 @@ static const struct iommu_ops exynos_iommu_ops = {
>  	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
>  };
> 
> +static int init_done;
> +
>  static int __init exynos_iommu_init(void)
>  {
>  	int ret;
> @@ -1116,6 +1123,8 @@ static int __init exynos_iommu_init(void)
>  		goto err_set_iommu;
>  	}
> 
> +	init_done = true;
> +
>  	return 0;
>  err_set_iommu:
>  	kmem_cache_free(lv2table_kmem_cache, zero_lv2_table);
> @@ -1125,4 +1134,21 @@ err_reg_driver:
>  	kmem_cache_destroy(lv2table_kmem_cache);
>  	return ret;
>  }
> -subsys_initcall(exynos_iommu_init);
> +
> +static int __init exynos_iommu_of_setup(struct device_node *np)
> +{
> +	struct platform_device *pdev;
> +
> +	if (!init_done)
> +		exynos_iommu_init();
> +
> +	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
> +	if (IS_ERR(pdev))
> +		return PTR_ERR(pdev);

This feels like a hack to me. What happens here is that you're using the 
IOMMU_OF_DECLARE mechanism to make sure that the iommu platform device will be 
created and registered before the normal OF bus populate mechanism kicks in, 
thus ensuring that the iommu gets probed before other devices. In practice 
this is pretty similar to using different init levels, which is what Will's 
patch set was trying to avoid in the first place. Creating a new kind of init 
levels mechanism doesn't sound very good to me.

The existing exynos-iommu driver is based on classic instantiation of a 
platform device from DT, using the normal device probing mechanism. As such it 
relies on the availability of a struct device for various helper functions. I 
thus understand why you want a struct device being registered for the iommu, 
instead of initializing the device right from the exynos_iommu_of_setup() 
function without a corresponding struct device being registered.

This leads me to question whether we should really introduce IOMMU_OF_DECLARE. 
Using regular deferred probing seems more and more like a better solution to 
me.

> +	of_iommu_set_ops(np, &exynos_iommu_ops);
> +	return 0;
> +}
> +
> +IOMMU_OF_DECLARE(exynos_iommu_of, "samsung,exynos-sysmmu",
> +		 exynos_iommu_of_setup);

-- 
Regards,

Laurent Pinchart
