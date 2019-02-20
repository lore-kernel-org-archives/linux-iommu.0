From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 2/7] iommu/ipmmu-vmsa: Call ipmmu_ctx_write_root()
 instead of open coding
Date: Wed, 20 Feb 2019 17:27:44 +0200
Message-ID: <20190220152744.GE3516@pendragon.ideasonboard.com>
References: <20190220150531.2462-1-geert+renesas@glider.be>
 <20190220150531.2462-3-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190220150531.2462-3-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Joerg Roedel <joro@8bytes.org>, Magnus Damm <damm+renesas@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Geert,

Thank you for the patch.

On Wed, Feb 20, 2019 at 04:05:26PM +0100, Geert Uytterhoeven wrote:
> There is a helper to write to the root IPMMU instance's registers, so
> let's use it.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 9f2b781e20a0eba6..ac70cb967ff821c6 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -280,8 +280,7 @@ static void ipmmu_ctx_write_all(struct ipmmu_vmsa_domain *domain,
>  		ipmmu_write(domain->mmu,
>  			    domain->context_id * IM_CTX_SIZE + reg, data);
>  
> -	ipmmu_write(domain->mmu->root,
> -		    domain->context_id * IM_CTX_SIZE + reg, data);
> +	ipmmu_ctx_write_root(domain, reg, data);

This makes the code harder to read in my opinion, and I don't think it
bring much optimization.

>  }
>  
>  /* -----------------------------------------------------------------------------

-- 
Regards,

Laurent Pinchart
