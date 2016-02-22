From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] iommu: ipmmu-vmsa: Use ARCH_RENESAS
Date: Mon, 22 Feb 2016 17:15:44 +0200
Message-ID: <2998503.qyvlMsm1S5@avalon>
References: <1456105295-13497-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1456105295-13497-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Joerg Roedel <joro@8bytes.org>, Magnus Damm <magnus.damm@gmail.com>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Simon,

Thank you for the patch.

On Monday 22 February 2016 10:41:35 Simon Horman wrote:
> Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.
> 
> This is part of an ongoing process to migrate from ARCH_SHMOBILE to
> ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
> appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/iommu/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
>  Based on the next branch of Joerg's iommu tree on kernel.org
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index a1e75cba18e0..d4b38e4d27fe 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -266,7 +266,7 @@ config EXYNOS_IOMMU_DEBUG
>  config IPMMU_VMSA
>  	bool "Renesas VMSA-compatible IPMMU"
>  	depends on ARM_LPAE
> -	depends on ARCH_SHMOBILE || COMPILE_TEST
> +	depends on ARCH_RENESAS || COMPILE_TEST
>  	select IOMMU_API
>  	select IOMMU_IO_PGTABLE_LPAE
>  	select ARM_DMA_USE_IOMMU

-- 
Regards,

Laurent Pinchart
