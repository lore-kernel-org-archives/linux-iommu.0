From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v5 8/8] iommu/rockchip: Enable Rockchip IOMMU on ARM64
Date: Mon, 28 Nov 2016 16:42:27 -0800
Message-ID: <20161129004225.GA109697@google.com>
References: <1466734413-7453-9-git-send-email-zhengsq@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1466734413-7453-9-git-send-email-zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, mark.yao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On Fri, Jun 24, 2016 at 10:13:33AM +0800, Shunqian Zheng wrote:
> From: Simon Xue <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> 
> This patch makes it possible to compile the rockchip-iommu driver on
> ARM64, so that it can be used with 64-bit SoCs equipped with this type
> of IOMMU.
> 
> Signed-off-by: Simon Xue <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> Signed-off-by: Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/iommu/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index ad08603..5572621 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -218,7 +218,7 @@ config OMAP_IOMMU_DEBUG
>  
>  config ROCKCHIP_IOMMU
>  	bool "Rockchip IOMMU Support"
> -	depends on ARM
> +	depends on ARM || ARM64
>  	depends on ARCH_ROCKCHIP || COMPILE_TEST
>  	select IOMMU_API
>  	select ARM_DMA_USE_IOMMU

Whatever happened with the rest of this series? Some of the IOMMU bits
made it, but the DRM fixes never did, and so this didn't get applied.
This leaves the whole DRM stack unusable on ARM64 Rockchip systems.

The patch context has changed a bit on patch 7 (and maybe 6?), so
somebody will need to refresh those on the latest upstream.

Brian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
