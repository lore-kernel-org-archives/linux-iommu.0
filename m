From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 4/6] iommu/arm-smmu: implement generic DT bindings
Date: Tue, 19 Aug 2014 13:54:49 +0100
Message-ID: <20140819125449.GN23128@arm.com>
References: <1407891099-24641-1-git-send-email-mitchelh@codeaurora.org>
	<1407891099-24641-5-git-send-email-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1407891099-24641-5-git-send-email-mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, arnd-r2nGTMty4D4@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

[adding Rob, Mark, Arnd, Thierry and Hiroshi]

On Wed, Aug 13, 2014 at 01:51:37AM +0100, Mitchel Humpherys wrote:
> Generic IOMMU device tree bindings were recently added in
> ["devicetree: Add generic IOMMU device tree bindings"]. Implement the
> bindings in the ARM SMMU driver.
> 
> See Documentation/devicetree/bindings/iommu/iommu.txt for the bindings
> themselves.

Could you look at moving the parsing code into a separate file please (maybe
under lib/ ?). That way, other IOMMUs can use the same binding without the
boilerplate having to be rewritten each time.

> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 63c6707fad..22e25f3172 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -538,25 +538,32 @@ static int insert_smmu_master(struct arm_smmu_device *smmu,
>  	return 0;
>  }
>  
> +struct iommus_entry {
> +	struct list_head list;
> +	struct device_node *node;
> +	u16 streamids[MAX_MASTER_STREAMIDS];
> +	int num_sids;
> +};
> +
>  static int register_smmu_master(struct arm_smmu_device *smmu,
> -				struct device *dev,
> -				struct of_phandle_args *masterspec)
> +				struct iommus_entry *entry)
>  {
>  	int i;
>  	struct arm_smmu_master *master;
> +	struct device *dev = smmu->dev;
>  
> -	master = find_smmu_master(smmu, masterspec->np);
> +	master = find_smmu_master(smmu, entry->node);
>  	if (master) {
>  		dev_err(dev,
>  			"rejecting multiple registrations for master device %s\n",
> -			masterspec->np->name);
> +			entry->node->name);
>  		return -EBUSY;
>  	}
>  
> -	if (masterspec->args_count > MAX_MASTER_STREAMIDS) {
> +	if (entry->num_sids > MAX_MASTER_STREAMIDS) {
>  		dev_err(dev,
>  			"reached maximum number (%d) of stream IDs for master device %s\n",
> -			MAX_MASTER_STREAMIDS, masterspec->np->name);
> +			MAX_MASTER_STREAMIDS, entry->node->name);
>  		return -ENOSPC;
>  	}
>  
> @@ -564,15 +571,58 @@ static int register_smmu_master(struct arm_smmu_device *smmu,
>  	if (!master)
>  		return -ENOMEM;
>  
> -	master->of_node			= masterspec->np;
> -	master->cfg.num_streamids	= masterspec->args_count;
> +	master->of_node			= entry->node;
> +	master->cfg.num_streamids	= entry->num_sids;
>  
>  	for (i = 0; i < master->cfg.num_streamids; ++i)
> -		master->cfg.streamids[i] = masterspec->args[i];
> +		master->cfg.streamids[i] = entry->streamids[i];
>  
>  	return insert_smmu_master(smmu, master);
>  }
>  
> +static int arm_smmu_parse_iommus_properties(struct arm_smmu_device *smmu,
> +					int *num_masters)
> +{
> +	struct of_phandle_args iommuspec;
> +	struct device_node *dn;
> +
> +	for_each_node_with_property(dn, "iommus") {
> +		int arg_ind = 0;
> +		struct iommus_entry *entry, *n;
> +		LIST_HEAD(iommus);
> +
> +		while (!of_parse_phandle_with_args(dn, "iommus", "#iommu-cells",
> +							arg_ind, &iommuspec)) {

We need to check that the phandle does indeed point at one of our SMMUs
here, in case we have a system with multiple IOMMU types, all using the
generic binding.

> +			int i;
> +
> +			list_for_each_entry(entry, &iommus, list)
> +				if (entry->node == dn)
> +					break;

Oh, yuck, this is really nasty to parse...

> +			if (&entry->list == &iommus) {

Where is entry initialised the first time around?

> +				entry = devm_kzalloc(smmu->dev, sizeof(*entry),
> +						GFP_KERNEL);
> +				if (!entry)
> +					return -ENOMEM;

You need to of_node_put the guys you've got back from the phandle parsing
code.

> +				entry->node = dn;
> +				list_add(&entry->list, &iommus);
> +			}
> +			entry->num_sids = iommuspec.args_count;
> +			for (i = 0; i < entry->num_sids; ++i)
> +				entry->streamids[i] = iommuspec.args[i];
> +			arg_ind++;

Isn't this defined by #iommu-cells?

> +		}
> +
> +		list_for_each_entry_safe(entry, n, &iommus, list) {

Why the _safe variant? This is a local list, right?

Will
