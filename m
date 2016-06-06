From: Jean-Philippe Brucker <Jean-Philippe.Brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 6/7] iommu/arm-smmu: Finish off SMMUv3 default domain
 support
Date: Mon, 6 Jun 2016 16:47:12 +0100
Message-ID: <20160606154712.GA9864@e106794-lin.localdomain>
References: <cover.1464966939.git.robin.murphy@arm.com>
 <aabcdd814b93b2b6a902b189f6911f929a29b64f.1464966939.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <aabcdd814b93b2b6a902b189f6911f929a29b64f.1464966939.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

I quite like this change, the result looks pretty clean. I rebased my
current work and didn't notice any major issue. Some nits below.

On Fri, Jun 03, 2016 at 06:15:41PM +0100, Robin Murphy wrote:
> The driver's current reliance on attaching/detaching an entire group
> for the first device it sees is at odds with the IOMMU core's initial
> construction of a group by adding each device and attaching it to the
> default domain in turn. As it turns out, we can happily do away with the
> whole palaver by simply letting each device be in charge of its own
> stream ID/stream table entry, and reducing the problem of tracking
> duplicate IDs and domains down to "Is the STE already associated with
> the appropriate context?", which is easily done by just looking at the
> stream table itself.
> 
> With an of_xlate() callback in place, devices attached to default
> domains will now get appropriate DMA ops installed, so make sure we
> enable translation again to stop them getting horribly confused - this
> reverts the SMMUv3 portion of cbf8277ef456 ("iommu/arm-smmu: Treat
> IOMMU_DOMAIN_DMA as bypass for now")
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
...
>  
> -static int arm_smmu_install_ste_for_group(struct arm_smmu_group *smmu_group)
> +static void arm_smmu_install_ste(struct arm_smmu_master_data *master,
> +				struct arm_smmu_domain *smmu_domain)

(Second line is misaligned here)

>  {
> -	int i;
> -	struct arm_smmu_domain *smmu_domain = smmu_group->domain;
> -	struct arm_smmu_strtab_ent *ste = &smmu_group->ste;
> -	struct arm_smmu_device *smmu = smmu_group->smmu;
> +	struct arm_smmu_device *smmu = master->smmu;
> +	struct arm_smmu_strtab_ent *ste = &master->ste;
> +	__le64 *step = arm_smmu_get_step_for_sid(smmu, master->sid);
>  
>  	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
>  		ste->s1_cfg = &smmu_domain->s1_cfg;
> @@ -1634,42 +1628,16 @@ static int arm_smmu_install_ste_for_group(struct arm_smmu_group *smmu_group)
>  		ste->s2_cfg = &smmu_domain->s2_cfg;
>  	}
>  
> -	for (i = 0; i < smmu_group->num_sids; ++i) {
> -		u32 sid = smmu_group->sids[i];
> -		__le64 *step = arm_smmu_get_step_for_sid(smmu, sid);
> -
> -		arm_smmu_write_strtab_ent(smmu, sid, step, ste);
> -	}
> -
> -	return 0;
> -}
> -
> -static void arm_smmu_detach_dev(struct device *dev)
> -{
> -	struct arm_smmu_group *smmu_group = arm_smmu_group_get(dev);
> -
> -	smmu_group->ste.bypass = true;
> -	if (arm_smmu_install_ste_for_group(smmu_group) < 0)
> -		dev_warn(dev, "failed to install bypass STE\n");
> -
> -	smmu_group->domain = NULL;
> +	arm_smmu_write_strtab_ent(smmu, master->sid, step, ste);
>  }
>  
>  static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  {
>  	int ret = 0;
> -	struct arm_smmu_device *smmu;
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> -	struct arm_smmu_group *smmu_group = arm_smmu_group_get(dev);
> +	struct arm_smmu_master_data *master = dev->archdata.iommu;

(calling this member 'master' or 'smmu_master' consistently, instead of
'data', would make the driver easier to grep)

> +	struct arm_smmu_device *smmu = master->smmu;
>  
> -	if (!smmu_group)
> -		return -ENOENT;
> -
> -	/* Already attached to a different domain? */
> -	if (smmu_group->domain && smmu_group->domain != smmu_domain)
> -		arm_smmu_detach_dev(dev);
> -
> -	smmu = smmu_group->smmu;
>  	mutex_lock(&smmu_domain->init_mutex);
>  
>  	if (!smmu_domain->smmu) {
> @@ -1688,21 +1656,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  		goto out_unlock;
>  	}
>  
> -	/* Group already attached to this domain? */
> -	if (smmu_group->domain)
> -		goto out_unlock;
> +	master->ste.bypass = false;

Should also set master->ste.valid = true. It worked out of the box
during my first test, because master is allocated with kmalloc and
initialised with garbage. Could we also use kzalloc, in the of_xlate
patch?

Thanks,
Jean-Philippe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
