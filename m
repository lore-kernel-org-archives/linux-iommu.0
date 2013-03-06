From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 8/9] iommu: OMAP: build only on OMAP2+
Date: Tue, 5 Mar 2013 17:10:47 -0800
Message-ID: <20130306011046.GK11806@atomide.com>
References: <1362521809-22989-1-git-send-email-arnd@arndb.de>
 <1362521809-22989-9-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1362521809-22989-9-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, arm@kernel.org, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.luna@linaro.org>
List-Id: iommu@lists.linux-foundation.org

* Arnd Bergmann <arnd@arndb.de> [130305 14:21]:
> The OMAP IOMMU driver intentionally fails to build on OMAP1
> platforms, so we should not allow enabling it there.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: iommu@lists.linux-foundation.org
> Cc: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Omar Ramirez Luna <omar.luna@linaro.org>

Makes sense, I doubt that anybody will work on omap1 version
at this point:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  drivers/iommu/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 5c514d07..c332fb9 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -130,7 +130,7 @@ config IRQ_REMAP
>  # OMAP IOMMU support
>  config OMAP_IOMMU
>  	bool "OMAP IOMMU Support"
> -	depends on ARCH_OMAP
> +	depends on ARCH_OMAP2PLUS
>  	select IOMMU_API
>  
>  config OMAP_IOVMM
> -- 
> 1.8.1.2
> 
