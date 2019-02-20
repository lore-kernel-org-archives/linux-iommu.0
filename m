From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 3/7] iommu/ipmmu-vmsa: Prepare to handle 40-bit error
 addresses
Date: Wed, 20 Feb 2019 17:30:57 +0200
Message-ID: <20190220153057.GF3516@pendragon.ideasonboard.com>
References: <20190220150531.2462-1-geert+renesas@glider.be>
 <20190220150531.2462-4-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190220150531.2462-4-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Joerg Roedel <joro@8bytes.org>, Magnus Damm <damm+renesas@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Geert,

Thank you for the patch.

On Wed, Feb 20, 2019 at 04:05:27PM +0100, Geert Uytterhoeven wrote:
> On R-Car Gen3, the faulting virtual address is a 40-bit address, and
> comprised of two registers.  Read the upper address part, and combine
> both parts, when running on a 64-bit system.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Apart from this, the driver doesn't support 40-bit IOVA addresses yet.
> ---
>  drivers/iommu/ipmmu-vmsa.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index ac70cb967ff821c6..4d07c26c97848b65 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -186,7 +186,9 @@ static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
>  #define IMMAIR_ATTR_IDX_WBRWA		1
>  #define IMMAIR_ATTR_IDX_DEV		2
>  
> -#define IMEAR				0x0030
> +#define IMEAR				0x0030	/* R-Car Gen2 */
> +#define IMELAR				IMEAR	/* R-Car Gen3 */

I would have defined that as a single macro.

> +#define IMEUAR				0x0034	/* R-Car Gen3 */
>  
>  #define IMPCTR				0x0200
>  #define IMPSTR				0x0208
> @@ -521,14 +523,16 @@ static irqreturn_t ipmmu_domain_irq(struct ipmmu_vmsa_domain *domain)
>  {
>  	const u32 err_mask = IMSTR_MHIT | IMSTR_ABORT | IMSTR_PF | IMSTR_TF;
>  	struct ipmmu_vmsa_device *mmu = domain->mmu;
> +	unsigned long iova;

Isn't there a more appropriate type, such as dma_addr_t possibly ?

>  	u32 status;
> -	u32 iova;
>  
>  	status = ipmmu_ctx_read_root(domain, IMSTR);
>  	if (!(status & err_mask))
>  		return IRQ_NONE;
>  
> -	iova = ipmmu_ctx_read_root(domain, IMEAR);
> +	iova = ipmmu_ctx_read_root(domain, IMELAR);
> +	if (IS_ENABLED(CONFIG_64BIT))
> +		iova |= (u64)ipmmu_ctx_read_root(domain, IMEUAR) << 32;
>  
>  	/*
>  	 * Clear the error status flags. Unlike traditional interrupt flag
> @@ -540,10 +544,10 @@ static irqreturn_t ipmmu_domain_irq(struct ipmmu_vmsa_domain *domain)
>  
>  	/* Log fatal errors. */
>  	if (status & IMSTR_MHIT)
> -		dev_err_ratelimited(mmu->dev, "Multiple TLB hits @0x%08x\n",
> +		dev_err_ratelimited(mmu->dev, "Multiple TLB hits @0x%lx\n",
>  				    iova);
>  	if (status & IMSTR_ABORT)
> -		dev_err_ratelimited(mmu->dev, "Page Table Walk Abort @0x%08x\n",
> +		dev_err_ratelimited(mmu->dev, "Page Table Walk Abort @0x%lx\n",
>  				    iova);
>  
>  	if (!(status & (IMSTR_PF | IMSTR_TF)))
> @@ -559,7 +563,7 @@ static irqreturn_t ipmmu_domain_irq(struct ipmmu_vmsa_domain *domain)
>  		return IRQ_HANDLED;
>  
>  	dev_err_ratelimited(mmu->dev,
> -			    "Unhandled fault: status 0x%08x iova 0x%08x\n",
> +			    "Unhandled fault: status 0x%08x iova 0x%lx\n",
>  			    status, iova);
>  
>  	return IRQ_HANDLED;

-- 
Regards,

Laurent Pinchart
