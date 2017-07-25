From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/of: Handle PCI aliases properly
Date: Tue, 25 Jul 2017 19:15:18 +0100
Message-ID: <09c528ce-32b2-f6ff-d6c8-93e6af8dc450@arm.com>
References: <20170531175230.16529-3-robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170531175230.16529-3-robin.murphy@arm.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 31/05/17 18:52, Robin Murphy wrote:
> When a PCI device has DMA quirks, we need to ensure that an upstream
> IOMMU knows about all possible aliases, since the presence of a DMA
> quirk does not preclude the device still also emitting transactions
> (e.g. MSIs) on its 'real' RID. Similarly, the rules for bridge aliasing
> are relatively complex, and some bridges may only take ownership of
> transactions under particular transient circumstances, leading again to
> multiple RIDs potentially being seen at the IOMMU for the given device.
> 
> Take all this into account in the OF code by translating every RID
> produced by the alias walk, not just whichever one comes out last.
> Happily, this also makes things tidy enough that we can reduce the
> number of both total lines of code, and confusing levels of indirection,
> by pulling the "iommus"/"iommu-map" parsing helpers back in-line again.

Any comments on this? It should still apply as-is; I don't recall any
conflicts when I rebased a local branch onto 4.13-rc1.

Robin.

> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> This applies on top of the fix currently queued in the IOMMU tree:
> "iommu/of: Ignore all errors except EPROBE_DEFER"
> 
>  drivers/iommu/of_iommu.c | 104 +++++++++++++++++++++--------------------------
>  1 file changed, 47 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 19779b88a479..1fbd7a142b30 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -140,75 +140,39 @@ static const struct iommu_ops
>  	return ops;
>  }
>  
> -static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
> -{
> -	struct of_phandle_args *iommu_spec = data;
> +struct of_pci_iommu_alias_info {
> +	struct device *dev;
> +	struct device_node *np;
> +};
>  
> -	iommu_spec->args[0] = alias;
> -	return iommu_spec->np == pdev->bus->dev.of_node;
> -}
> -
> -static const struct iommu_ops
> -*of_pci_iommu_init(struct pci_dev *pdev, struct device_node *bridge_np)
> +static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
>  {
> +	struct of_pci_iommu_alias_info *info = data;
>  	const struct iommu_ops *ops;
> -	struct of_phandle_args iommu_spec;
> +	struct of_phandle_args iommu_spec = { .args_count = 1 };
>  	int err;
>  
> -	/*
> -	 * Start by tracing the RID alias down the PCI topology as
> -	 * far as the host bridge whose OF node we have...
> -	 * (we're not even attempting to handle multi-alias devices yet)
> -	 */
> -	iommu_spec.args_count = 1;
> -	iommu_spec.np = bridge_np;
> -	pci_for_each_dma_alias(pdev, __get_pci_rid, &iommu_spec);
> -	/*
> -	 * ...then find out what that becomes once it escapes the PCI
> -	 * bus into the system beyond, and which IOMMU it ends up at.
> -	 */
> -	iommu_spec.np = NULL;
> -	err = of_pci_map_rid(bridge_np, iommu_spec.args[0], "iommu-map",
> +	err = of_pci_map_rid(info->np, alias, "iommu-map",
>  			     "iommu-map-mask", &iommu_spec.np,
>  			     iommu_spec.args);
>  	if (err)
> -		return err == -ENODEV ? NULL : ERR_PTR(err);
> -
> -	ops = of_iommu_xlate(&pdev->dev, &iommu_spec);
> +		return err == -ENODEV ? 1 : err;
>  
> +	ops = of_iommu_xlate(info->dev, &iommu_spec);
>  	of_node_put(iommu_spec.np);
> -	return ops;
> -}
>  
> -static const struct iommu_ops
> -*of_platform_iommu_init(struct device *dev, struct device_node *np)
> -{
> -	struct of_phandle_args iommu_spec;
> -	const struct iommu_ops *ops = NULL;
> -	int idx = 0;
> +	if (IS_ERR(ops))
> +		return PTR_ERR(ops);
>  
> -	/*
> -	 * We don't currently walk up the tree looking for a parent IOMMU.
> -	 * See the `Notes:' section of
> -	 * Documentation/devicetree/bindings/iommu/iommu.txt
> -	 */
> -	while (!of_parse_phandle_with_args(np, "iommus", "#iommu-cells",
> -					   idx, &iommu_spec)) {
> -		ops = of_iommu_xlate(dev, &iommu_spec);
> -		of_node_put(iommu_spec.np);
> -		idx++;
> -		if (IS_ERR_OR_NULL(ops))
> -			break;
> -	}
> -
> -	return ops;
> +	return info->np == pdev->bus->dev.of_node;
>  }
>  
>  const struct iommu_ops *of_iommu_configure(struct device *dev,
>  					   struct device_node *master_np)
>  {
> -	const struct iommu_ops *ops;
> +	const struct iommu_ops *ops = NULL;
>  	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
> +	int err;
>  
>  	if (!master_np)
>  		return NULL;
> @@ -221,18 +185,44 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>  		iommu_fwspec_free(dev);
>  	}
>  
> -	if (dev_is_pci(dev))
> -		ops = of_pci_iommu_init(to_pci_dev(dev), master_np);
> -	else
> -		ops = of_platform_iommu_init(dev, master_np);
> +	/*
> +	 * We don't currently walk up the tree looking for a parent IOMMU.
> +	 * See the `Notes:' section of
> +	 * Documentation/devicetree/bindings/iommu/iommu.txt
> +	 */
> +	if (dev_is_pci(dev)) {
> +		struct of_pci_iommu_alias_info info = {
> +			.dev = dev,
> +			.np = master_np,
> +		};
> +
> +		err = pci_for_each_dma_alias(to_pci_dev(dev),
> +					     of_pci_iommu_init, &info);
> +		if (err) /* err > 0 means the walk stopped, but non-fatally */
> +			ops = ERR_PTR(min(err, 0));
> +		else /* success implies both fwspec and ops are now valid */
> +			ops = dev->iommu_fwspec->ops;
> +	} else {
> +		struct of_phandle_args iommu_spec;
> +		int idx = 0;
> +
> +		while (!of_parse_phandle_with_args(master_np, "iommus",
> +						   "#iommu-cells",
> +						   idx, &iommu_spec)) {
> +			ops = of_iommu_xlate(dev, &iommu_spec);
> +			of_node_put(iommu_spec.np);
> +			idx++;
> +			if (IS_ERR_OR_NULL(ops))
> +				break;
> +		}
> +	}
>  	/*
>  	 * If we have reason to believe the IOMMU driver missed the initial
>  	 * add_device callback for dev, replay it to get things in order.
>  	 */
>  	if (!IS_ERR_OR_NULL(ops) && ops->add_device &&
>  	    dev->bus && !dev->iommu_group) {
> -		int err = ops->add_device(dev);
> -
> +		err = ops->add_device(dev);
>  		if (err)
>  			ops = ERR_PTR(err);
>  	}
> 
