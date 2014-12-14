From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3 18/19] iommu: exynos: init from dt-specific callback instead of initcall
Date: Sun, 14 Dec 2014 14:45:36 +0200
Message-ID: <1826772.xgprzQcfXd@avalon>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com> <1416395748-10731-19-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1416395748-10731-19-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, Rob Herring <robh@kernel.org>, Thierry Reding <treding@nvidia.com>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Inki Dae <inki.dae@samsung.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Tomasz Figa <tomasz.figa@gmail.com>, linaro-mm-sig@lists.linaro.org, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Olof Johansson <olof@lixom.net>, Cho KyongHo <pullip.cho@samsung.com>, David Wodhouse <dwmw2@infradead.org>
List-Id: iommu@lists.linux-foundation.org

Hi Marek,

Thank you for the patch.

On Wednesday 19 November 2014 12:15:47 Marek Szyprowski wrote:
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
> index cd28dc09db39..88f9afe641a0 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c

[snip]

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

If we end up having to create the IOMMU platform devices from within the 
drivers, the introduction of IOMMU_OF_DECLARE starts to feel like a workaround 
to me. I wonder whether it wouldn't then be better to let the driver core 
instantiate the IOMMU platform device from DT as for all other devices, and 
use device notifiers to defer probe of the bus masters until the required 
IOMMU(s) are registered.

Will, what's your opinion on that ?

> +
> +	of_iommu_set_ops(np, &exynos_iommu_ops);
> +	return 0;
> +}
> +
> +IOMMU_OF_DECLARE(exynos_iommu_of, "samsung,exynos-sysmmu",
> +		 exynos_iommu_of_setup);

-- 
Regards,

Laurent Pinchart
