From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 4/6] iommu/ipmmu-vmsa: Move num_utlbs to SoC-specific
 features
Date: Thu, 11 Apr 2019 10:32:40 +0200
Message-ID: <20190411083240.jxv3xoasrg3vx5zh@verge.net.au>
References: <20190403182148.18058-1-geert+renesas@glider.be>
 <20190403182148.18058-5-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190403182148.18058-5-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Joerg Roedel <joro@8bytes.org>, Magnus Damm <damm+renesas@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 03, 2019 at 08:21:46PM +0200, Geert Uytterhoeven wrote:
> The maximum number of micro-TLBs per IPMMU instance is not fixed, but
> depends on the SoC type.  Hence move it from struct ipmmu_vmsa_device to
> struct ipmmu_features, and set up the correct value for both R-Car Gen2
> and Gen3 SoCs.
> 
> Note that currently no code uses this value.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Are there any plans to use num_utlbs in the driver or anywhere else in the
kernel? If not, perhaps it should be removed?

> ---
> v2:
>   - Add Reviewed-by.
> ---
>  drivers/iommu/ipmmu-vmsa.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 87acf86f295fac0d..3fa57627b1e35562 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -42,6 +42,7 @@ struct ipmmu_features {
>  	bool use_ns_alias_offset;
>  	bool has_cache_leaf_nodes;
>  	unsigned int number_of_contexts;
> +	unsigned int num_utlbs;
>  	bool setup_imbuscr;
>  	bool twobit_imttbcr_sl0;
>  	bool reserved_context;
> @@ -53,7 +54,6 @@ struct ipmmu_vmsa_device {
>  	struct iommu_device iommu;
>  	struct ipmmu_vmsa_device *root;
>  	const struct ipmmu_features *features;
> -	unsigned int num_utlbs;
>  	unsigned int num_ctx;
>  	spinlock_t lock;			/* Protects ctx and domains[] */
>  	DECLARE_BITMAP(ctx, IPMMU_CTX_MAX);
> @@ -972,6 +972,7 @@ static const struct ipmmu_features ipmmu_features_default = {
>  	.use_ns_alias_offset = true,
>  	.has_cache_leaf_nodes = false,
>  	.number_of_contexts = 1, /* software only tested with one context */
> +	.num_utlbs = 32,
>  	.setup_imbuscr = true,
>  	.twobit_imttbcr_sl0 = false,
>  	.reserved_context = false,
> @@ -981,6 +982,7 @@ static const struct ipmmu_features ipmmu_features_rcar_gen3 = {
>  	.use_ns_alias_offset = false,
>  	.has_cache_leaf_nodes = true,
>  	.number_of_contexts = 8,
> +	.num_utlbs = 48,
>  	.setup_imbuscr = false,
>  	.twobit_imttbcr_sl0 = true,
>  	.reserved_context = true,
> @@ -1033,7 +1035,6 @@ static int ipmmu_probe(struct platform_device *pdev)
>  	}
>  
>  	mmu->dev = &pdev->dev;
> -	mmu->num_utlbs = 48;
>  	spin_lock_init(&mmu->lock);
>  	bitmap_zero(mmu->ctx, IPMMU_CTX_MAX);
>  	mmu->features = of_device_get_match_data(&pdev->dev);
> -- 
> 2.17.1
> 
