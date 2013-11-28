From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 04/15] iommu: shmobile: Enable driver compilation with
 COMPILE_TEST
Date: Thu, 28 Nov 2013 16:36:51 +0900
Message-ID: <20131128073651.GE24146@verge.net.au>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1385515117-23664-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1385515117-23664-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 27, 2013 at 02:18:26AM +0100, Laurent Pinchart wrote:
> This helps increasing build testing coverage.
> 
> The driver doesn't compile on non-ARM platforms due to usage of the ARM
> DMA IOMMU API, restrict compilation to ARM.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: iommu@lists.linux-foundation.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/iommu/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 3e7fdbb..79bbc21 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -207,6 +207,7 @@ config SHMOBILE_IOMMU
>  	bool "IOMMU for Renesas IPMMU/IPMMUI"
>  	default n
>  	depends on ARM
> +	depends on SH_MOBILE || COMPILE_TEST
>  	select IOMMU_API
>  	select ARM_DMA_USE_IOMMU
>  	select SHMOBILE_IPMMU
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
