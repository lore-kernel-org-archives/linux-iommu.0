From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 1/6] iommu/arm-smmu: add support for specifying clocks
Date: Wed, 13 Aug 2014 14:07:30 -0700
Message-ID: <vnkwmwb8f699.fsf@mitchelh-linux.qualcomm.com>
References: <1407891099-24641-1-git-send-email-mitchelh@codeaurora.org>
	<1407891099-24641-2-git-send-email-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1407891099-24641-2-git-send-email-mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
	(Mitchel Humpherys's message of "Tue, 12 Aug 2014 17:51:34 -0700")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Well hopefully this isn't too Nick Krouse-esque, but I have some
comments on my own patch below. I sat on these for a few days but have
noticed a few things after testing on another platform...

On Tue, Aug 12 2014 at 05:51:34 PM, Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> On some platforms with tight power constraints it is polite to only
> leave your clocks on for as long as you absolutely need them. Currently
> we assume that all clocks necessary for SMMU register access are always
> on.
>
> Add some optional device tree properties to specify any clocks that are
> necessary for SMMU register access and turn them on and off as needed.
>
> If no clocks are specified in the device tree things continue to work
> the way they always have: we assume all necessary clocks are always
> turned on.
>
> Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.txt         |  11 ++
>  drivers/iommu/arm-smmu.c                           | 127 +++++++++++++++++++--
>  2 files changed, 129 insertions(+), 9 deletions(-)

[...]

> -static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
> +static int arm_smmu_init_clocks(struct arm_smmu_device *smmu)
> +{
> +	const char *cname;
> +	struct property *prop;
> +	int i;
> +	struct device *dev = smmu->dev;
> +
> +	smmu->num_clocks = of_property_count_strings(dev->of_node,
> +						"clock-names");
> +
> +	if (!smmu->num_clocks)
> +		return 0;
> +
> +	smmu->clocks = devm_kzalloc(
> +		dev, sizeof(*smmu->clocks) * smmu->num_clocks,
> +		GFP_KERNEL);
> +
> +	if (!smmu->clocks) {
> +		dev_err(dev,
> +			"Failed to allocate memory for clocks\n");
> +		return -ENODEV;
> +	}
> +
> +	i = 0;
> +	of_property_for_each_string(dev->of_node, "clock-names",
> +				prop, cname) {
> +		struct clk *c = devm_clk_get(dev, cname);
> +		if (IS_ERR(c)) {
> +			dev_err(dev, "Couldn't get clock: %s",
> +				cname);
> +			return -ENODEV;
> +		}
> +
> +		if (clk_get_rate(c) == 0) {
> +			long rate = clk_round_rate(c, 1000);
> +			clk_set_rate(c, rate);
> +		}
> +
> +		smmu->clocks[i] = c;
> +
> +		++i;
> +	}
> +	return 0;
> +}
> +
> +int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)

The `static' was dropped unintentionally here.


-Mitch

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
