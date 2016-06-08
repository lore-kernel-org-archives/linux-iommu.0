From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 3/3] iommu/ipmmu-vmsa: Hook up r8a7796 DT matching code
Date: Wed, 08 Jun 2016 03:18:41 +0300
Message-ID: <10108662.fYf10pMtGa@avalon>
References: <20160607033918.28687.98260.sendpatchset@little-apple> <20160607033945.28687.70956.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160607033945.28687.70956.sendpatchset@little-apple>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: iommu@lists.linux-foundation.org, laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, joro@8bytes.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, horms+renesas@verge.net.au
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

Thank you for the patch.

On Tuesday 07 Jun 2016 12:39:45 Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Support the r8a7796 IPMMU by sharing feature flags between
> r8a7795 and r8a7796. Also update IOMMU_OF_DECLARE to hook
> up the updated compat string.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  drivers/iommu/ipmmu-vmsa.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> --- 0031/drivers/iommu/ipmmu-vmsa.c
> +++ work/drivers/iommu/ipmmu-vmsa.c	2016-06-06 11:19:40.210607110 +0900
> @@ -1074,7 +1074,7 @@ static const struct ipmmu_features ipmmu
>  	.twobit_imttbcr_sl0 = false,
>  };
> 
> -static const struct ipmmu_features ipmmu_features_r8a7795 = {
> +static const struct ipmmu_features ipmmu_features_rcar_gen3 = {
>  	.use_ns_alias_offset = false,
>  	.has_cache_leaf_nodes = true,
>  	.has_eight_ctx = true,
> @@ -1088,7 +1088,10 @@ static const struct of_device_id ipmmu_o
>  		.data = &ipmmu_features_default,
>  	}, {
>  		.compatible = "renesas,ipmmu-r8a7795",
> -		.data = &ipmmu_features_r8a7795,
> +		.data = &ipmmu_features_rcar_gen3,
> +	}, {
> +		.compatible = "renesas,ipmmu-r8a7796",
> +		.data = &ipmmu_features_rcar_gen3,
>  	}, {
>  		/* Terminator */
>  	},
> @@ -1268,6 +1271,8 @@ IOMMU_OF_DECLARE(ipmmu_vmsa_iommu_of, "r
>  		 ipmmu_vmsa_iommu_of_setup);
>  IOMMU_OF_DECLARE(ipmmu_r8a7795_iommu_of, "renesas,ipmmu-r8a7795",
>  		 ipmmu_vmsa_iommu_of_setup);
> +IOMMU_OF_DECLARE(ipmmu_r8a7796_iommu_of, "renesas,ipmmu-r8a7796",
> +		 ipmmu_vmsa_iommu_of_setup);

How about a Gen3 generic compatible string in addition to the SoC-specific 
ones ?

>  #endif
> 
>  MODULE_DESCRIPTION("IOMMU API for Renesas VMSA-compatible IPMMU");

-- 
Regards,

Laurent Pinchart
