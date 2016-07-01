From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 7/9] iommu/arm-smmu: Implement of_xlate() for SMMUv3
Date: Fri, 1 Jul 2016 13:35:08 +0100
Message-ID: <20160701123507.GJ12735@arm.com>
References: <cover.1467123945.git.robin.murphy@arm.com>
 <6de0ca7795e1b74627ceb55dcefcfd5537f245ce.1467123945.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6de0ca7795e1b74627ceb55dcefcfd5537f245ce.1467123945.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 28, 2016 at 04:48:26PM +0100, Robin Murphy wrote:
> Now that we can properly describe the mapping between PCI RIDs and
> stream IDs via "iommu-map", and have it fed it to the driver
> automatically via of_xlate(), rework the SMMUv3 driver to benefit from
> that, and get rid of the current misuse of the "iommus" binding.
> 
> Since having of_xlate wired up means that masters will now be given the
> appropriate DMA ops, we also need to make sure that default domains work
> properly. This necessitates dispensing with the "whole group at a time"
> notion for attaching to a domain, as devices which share a group get
> attached to the group's default domain one by one as they are initially
> probed.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---

[...]

>  static int arm_smmu_add_device(struct device *dev)
>  {
>  	int i, ret;
> -	u32 sid, *sids;
> -	struct pci_dev *pdev;
> -	struct iommu_group *group;
> -	struct arm_smmu_group *smmu_group;
>  	struct arm_smmu_device *smmu;
> +	struct arm_smmu_master_data *master;
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec(dev);
> +	struct iommu_group *group;
>  
> -	/* We only support PCI, for now */
> -	if (!dev_is_pci(dev))
> +	if (!fwspec || fwspec->iommu_ops != &arm_smmu_ops)
>  		return -ENODEV;
> -
> -	pdev = to_pci_dev(dev);
> -	group = iommu_group_get_for_dev(dev);
> -	if (IS_ERR(group))
> -		return PTR_ERR(group);
> -
> -	smmu_group = iommu_group_get_iommudata(group);
> -	if (!smmu_group) {
> -		smmu = arm_smmu_get_for_pci_dev(pdev);
> -		if (!smmu) {
> -			ret = -ENOENT;
> -			goto out_remove_dev;
> -		}
> -
> -		smmu_group = kzalloc(sizeof(*smmu_group), GFP_KERNEL);
> -		if (!smmu_group) {
> -			ret = -ENOMEM;
> -			goto out_remove_dev;
> -		}
> -
> -		smmu_group->ste.valid	= true;
> -		smmu_group->smmu	= smmu;
> -		iommu_group_set_iommudata(group, smmu_group,
> -					  __arm_smmu_release_pci_iommudata);
> +	/*
> +	 * We _can_ actually withstand dodgy bus code re-calling add_device()
> +	 * without an intervening remove_device()/of_xlate() sequence, but
> +	 * we're not going to do so quietly...
> +	 */
> +	if (WARN_ON_ONCE(fwspec->iommu_priv)) {
> +		master = fwspec->iommu_priv;
> +		smmu = master->smmu;
>  	} else {
> -		smmu = smmu_group->smmu;
> +		smmu = arm_smmu_get_by_node(fwspec->iommu_np);
> +		if (!smmu)
> +			return -ENODEV;
> +		master = kzalloc(sizeof(*master), GFP_KERNEL);
> +		if (!master)
> +			return -ENOMEM;
> +
> +		master->smmu = smmu;
> +		fwspec->iommu_priv = master;
>  	}
>  
> -	/* Assume SID == RID until firmware tells us otherwise */
> -	pci_for_each_dma_alias(pdev, __arm_smmu_get_pci_sid, &sid);
> -	for (i = 0; i < smmu_group->num_sids; ++i) {
> -		/* If we already know about this SID, then we're done */
> -		if (smmu_group->sids[i] == sid)
> -			goto out_put_group;
> +	/* Check the SIDs are in range of the SMMU and our stream table */
> +	for (i = 0; i < fwspec->num_ids; i++) {
> +		u32 sid = fwspec->ids[i];
> +
> +		if (!arm_smmu_sid_in_range(smmu, sid))
> +			return -ERANGE;
> +
> +		/* Ensure l2 strtab is initialised */
> +		if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
> +			ret = arm_smmu_init_l2_strtab(smmu, sid);
> +			if (ret)
> +				return ret;
> +		}
>  	}

Do you not need to do some cleanup here, rather than just returning (same
for the -ERANGE above)? For example, freeing the master?

Will
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
