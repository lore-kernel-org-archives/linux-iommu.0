From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 4/7] iommu/ipmmu-vmsa: Make IPMMU_CTX_MAX unsigned
Date: Wed, 20 Feb 2019 17:31:33 +0200
Message-ID: <20190220153133.GG3516@pendragon.ideasonboard.com>
References: <20190220150531.2462-1-geert+renesas@glider.be>
 <20190220150531.2462-5-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190220150531.2462-5-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Joerg Roedel <joro@8bytes.org>, Magnus Damm <damm+renesas@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Geert,

Thank you for the patch.

On Wed, Feb 20, 2019 at 04:05:28PM +0100, Geert Uytterhoeven wrote:
> Make the IPMMU_CTX_MAX constant unsigned, to match the type of
> ipmmu_features.number_of_contexts.
> 
> This allows to use plain min() instead of type-casting min_t().
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/iommu/ipmmu-vmsa.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 4d07c26c97848b65..4e3134a9a52f8d87 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -36,7 +36,7 @@
>  #define arm_iommu_detach_device(...)	do {} while (0)
>  #endif
>  
> -#define IPMMU_CTX_MAX 8
> +#define IPMMU_CTX_MAX 8U
>  
>  struct ipmmu_features {
>  	bool use_ns_alias_offset;
> @@ -1060,8 +1060,7 @@ static int ipmmu_probe(struct platform_device *pdev)
>  	if (mmu->features->use_ns_alias_offset)
>  		mmu->base += IM_NS_ALIAS_OFFSET;
>  
> -	mmu->num_ctx = min_t(unsigned int, IPMMU_CTX_MAX,
> -			     mmu->features->number_of_contexts);
> +	mmu->num_ctx = min(IPMMU_CTX_MAX, mmu->features->number_of_contexts);
>  
>  	irq = platform_get_irq(pdev, 0);
>  

-- 
Regards,

Laurent Pinchart
