From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V2 1/3] iommu/arm-smmu: Add pm_runtime/sleep ops
Date: Thu, 2 Feb 2017 17:42:18 +0000
Message-ID: <20170202174218.GO31394@leverpostej>
References: <1486055420-19671-1-git-send-email-sricharan@codeaurora.org>
 <1486055420-19671-2-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1486055420-19671-2-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: robin.murphy-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On Thu, Feb 02, 2017 at 10:40:18PM +0530, Sricharan R wrote:
> +- clock-names:    Should be a pair of "smmu_iface_clk" and "smmu_bus_clk"
> +                  required for smmu's register group access and interface
> +                  clk for the smmu's underlying bus access.
> +
> +- clocks:         Phandles for respective clocks described by clock-names.

Which SMMU implementations are those clock-names valid for?

The SMMU architecture specifications do not architect the clocks, which
are implemementation-specific.

AFAICT, this doesn't match MMU-400 or MMU-500.

> +static int arm_smmu_init_clocks(struct arm_smmu_device *smmu)
> +{
> +	const char *cname;
> +	struct property *prop;
> +	int i = 0;
> +	struct device *dev = smmu->dev;
> +
> +	smmu->num_clocks =
> +		of_property_count_strings(dev->of_node, "clock-names");
> +
> +	if (smmu->num_clocks < 1)
> +		return 0;
> +
> +	smmu->clocks = devm_kzalloc(dev,
> +				    sizeof(*smmu->clocks) * smmu->num_clocks,
> +				    GFP_KERNEL);
> +
> +	if (!smmu->clocks) {
> +		dev_err(dev, "Failed to allocate memory for clocks\n");
> +		return -ENODEV;
> +	}
> +
> +	of_property_for_each_string(dev->of_node, "clock-names", prop, cname) {
> +		struct clk *c = devm_clk_get(dev, cname);
> +
> +		if (IS_ERR(c)) {
> +			dev_err(dev, "Couldn't get clock: %s", cname);
> +			return -EPROBE_DEFER;
> +		}
> +
> +		smmu->clocks[i] = c;
> +		++i;
> +	}
> +
> +	return 0;
> +}

I am very much not a fan of grabbing hold of resources that don't
necessarily match the binding, and we likely don't understand the use
of.

Either we know the names, and can manage them, or we don't, and cannot.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
