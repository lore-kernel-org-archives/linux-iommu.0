From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH] iommu: Convert to using %pOF instead of full_name
Date: Thu, 20 Jul 2017 22:35:46 +0200
Message-ID: <3567821.Si31GJ2fDW@phil>
References: <20170718214339.7774-29-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170718214339.7774-29-robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Am Dienstag, 18. Juli 2017, 16:43:09 CEST schrieb Rob Herring:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> ---
>  drivers/iommu/rockchip-iommu.c  | 10 +++++-----

for the Rockchip-related part
Reviewed-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>


> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 4ba48a26b389..1b8155dada26 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -1008,20 +1008,20 @@ static int rk_iommu_group_set_iommudata(struct iommu_group *group,
>  	ret = of_parse_phandle_with_args(np, "iommus", "#iommu-cells", 0,
>  					 &args);
>  	if (ret) {
> -		dev_err(dev, "of_parse_phandle_with_args(%s) => %d\n",
> -			np->full_name, ret);
> +		dev_err(dev, "of_parse_phandle_with_args(%pOF) => %d\n",
> +			np, ret);
>  		return ret;
>  	}
>  	if (args.args_count != 0) {
> -		dev_err(dev, "incorrect number of iommu params found for %s (found %d, expected 0)\n",
> -			args.np->full_name, args.args_count);
> +		dev_err(dev, "incorrect number of iommu params found for %pOF (found %d, expected 0)\n",
> +			args.np, args.args_count);
>  		return -EINVAL;
>  	}
> 
>  	pd = of_find_device_by_node(args.np);
>  	of_node_put(args.np);
>  	if (!pd) {
> -		dev_err(dev, "iommu %s not found\n", args.np->full_name);
> +		dev_err(dev, "iommu %pOF not found\n", args.np);
>  		return -EPROBE_DEFER;
>  	}
> 
> --
> 2.11.0
> 
> 
> 


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
