From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH V4 4/6] iommu/arm-smmu: Add the device_link between
 masters and smmu
Date: Wed, 12 Jul 2017 15:55:47 -0700
Message-ID: <20170712225547.GA22780@codeaurora.org>
References: <1499333825-7658-1-git-send-email-vivek.gautam@codeaurora.org>
 <1499333825-7658-5-git-send-email-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1499333825-7658-5-git-send-email-vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 07/06, Vivek Gautam wrote:
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index ddbfa8ab69e6..75567d9698ab 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1348,6 +1348,7 @@ static int arm_smmu_add_device(struct device *dev)
>  	struct arm_smmu_device *smmu;
>  	struct arm_smmu_master_cfg *cfg;
>  	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
> +	struct device_link *link = NULL;

Unnecessary initialization?

>  	int i, ret;
>  
>  	if (using_legacy_binding) {
> @@ -1403,6 +1404,16 @@ static int arm_smmu_add_device(struct device *dev)
>  
>  	pm_runtime_put_sync(smmu->dev);
>  
> +	/*
> +	 * Establish the link between smmu and master, so that the
> +	 * smmu gets runtime enabled/disabled as per the master's
> +	 * needs.
> +	 */
> +	link = device_link_add(dev, smmu->dev, DL_FLAG_PM_RUNTIME);
> +	if (!link)
> +		dev_warn(smmu->dev, "Unable to create device link between %s and %s\n",
> +			 dev_name(smmu->dev), dev_name(dev));
> +
>  	return 0;
>  

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
