From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 1/3] iommu: io-pgtable: Add ARM Mali midgard MMU page
 table format
Date: Thu, 11 Apr 2019 15:15:49 +0200
Message-ID: <20190411131549.GB4518@8bytes.org>
References: <20190401074730.12241-1-robh@kernel.org>
 <20190401074730.12241-2-robh@kernel.org>
 <8d091874-11b0-e348-c4f1-dd1bcfa4bf97@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8d091874-11b0-e348-c4f1-dd1bcfa4bf97@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Lyude Paul <lyude@redhat.com>, Eric Anholt <eric@anholt.net>, Neil Armstrong <narmstrong@baylibre.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 01, 2019 at 08:11:00PM +0100, Robin Murphy wrote:
> With the diff below squashed in to address my outstanding style nits,
> 
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> 
> I don't foresee any conflicting io-pgtable changes to prevent this going via
> DRM, but I'll leave the final say up to Joerg.

No objection from my side with merging this via DRM. With Robin's
concerns addressed:

	Acked-by: Joerg Roedel <jroedel@suse.de>

> 
> Thanks,
> Robin.
> 
> ----->8-----
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 98551d0cff59..55ed039da166 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -197,12 +197,13 @@ struct arm_lpae_io_pgtable {
> 
>  typedef u64 arm_lpae_iopte;
> 
> -static inline bool iopte_leaf(arm_lpae_iopte pte, int l, enum
> io_pgtable_fmt fmt)
> +static inline bool iopte_leaf(arm_lpae_iopte pte, int lvl,
> +			      enum io_pgtable_fmt fmt)
>  {
> -	if ((l == (ARM_LPAE_MAX_LEVELS - 1)) && (fmt != ARM_MALI_LPAE))
> -		return iopte_type(pte,l) == ARM_LPAE_PTE_TYPE_PAGE;
> +	if (lvl == (ARM_LPAE_MAX_LEVELS - 1) && fmt != ARM_MALI_LPAE)
> +		return iopte_type(pte, lvl) == ARM_LPAE_PTE_TYPE_PAGE;
> 
> -	return iopte_type(pte,l) == ARM_LPAE_PTE_TYPE_BLOCK;
> +	return iopte_type(pte, lvl) == ARM_LPAE_PTE_TYPE_BLOCK;
>  }
> 
>  static arm_lpae_iopte paddr_to_iopte(phys_addr_t paddr,
> @@ -310,13 +311,10 @@ static void __arm_lpae_init_pte(struct
> arm_lpae_io_pgtable *data,
>  	if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NS)
>  		pte |= ARM_LPAE_PTE_NS;
> 
> -	if (lvl == ARM_LPAE_MAX_LEVELS - 1) {
> -		if (data->iop.fmt == ARM_MALI_LPAE)
> -			pte |= ARM_LPAE_PTE_TYPE_BLOCK;
> -		else
> -			pte |= ARM_LPAE_PTE_TYPE_PAGE;
> -	} else
> +	if (data->iop.fmt != ARM_MALI_LPAE && lvl != ARM_LPAE_MAX_LEVELS - 1)
>  		pte |= ARM_LPAE_PTE_TYPE_BLOCK;
> +	else
> +		pte |= ARM_LPAE_PTE_TYPE_PAGE;
> 
>  	if (data->iop.fmt != ARM_MALI_LPAE)
>  		pte |= ARM_LPAE_PTE_AF;
