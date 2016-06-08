From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 2/3] iommu/ipmmu-vmsa: Increase maximum micro-TLBS to 48
Date: Wed, 08 Jun 2016 03:17:17 +0300
Message-ID: <1502675.8oO2rJ9tLe@avalon>
References: <20160607033918.28687.98260.sendpatchset@little-apple> <20160607033936.28687.78365.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160607033936.28687.78365.sendpatchset@little-apple>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: iommu@lists.linux-foundation.org, laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, joro@8bytes.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, horms+renesas@verge.net.au
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

Thank you for the patch.

On Tuesday 07 Jun 2016 12:39:36 Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Bump up the maximum numbers of micro-TLBS to 48.
> 
> Each IPMMU device instance get micro-TLB assignment via
> the "iommus" property in DT. Older SoCs tend to use a
> maximum number of 32 micro-TLBd per IPMMU instance however
> newer SoCs such as r8a7796 make use of up to 48 micro-TLBs.
> 
> At this point no SoC specific handling is done to validate
> the maximum number of micro-TLBs, and because of that the
> DT information is assumed to be within correct range for
> each particular SoC.
> 
> If needed in the future SoC specific feature flags can be
> added to handle the maximum number of micro-TLBs without
> requiring DT changes, however at this point this does not
> seem necessary.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  drivers/iommu/ipmmu-vmsa.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- 0029/drivers/iommu/ipmmu-vmsa.c
> +++ work/drivers/iommu/ipmmu-vmsa.c	2016-06-06 11:17:33.230607110 +0900
> @@ -1115,7 +1115,7 @@ static int ipmmu_probe(struct platform_d
>  	}
> 
>  	mmu->dev = &pdev->dev;
> -	mmu->num_utlbs = 32;
> +	mmu->num_utlbs = 48;

This value is only used to validate that all utlb numbers in the bus master DT 
nodes are within the range acceptable by the device. If we bump it up 
unconditionally we could as well remove it completely. A possibly better 
alternative would be to specify the number of utlbs, or even the mask of 
implemented utlbs, in the DT node of the IPMMU.

Why 48 by the way ? The IPMMU instance with the largest utlb number in the R-
Car Gen3 datasheet uses a 0-38 utlb range.

>  	spin_lock_init(&mmu->lock);
>  	bitmap_zero(mmu->ctx, IPMMU_CTX_MAX);
>  	mmu->features = match->data;

-- 
Regards,

Laurent Pinchart
