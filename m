Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BE2AD29;
	Thu,  6 Apr 2023 18:09:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B21C5169E;
	Thu,  6 Apr 2023 11:09:49 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE41F3F73F;
	Thu,  6 Apr 2023 11:09:03 -0700 (PDT)
Message-ID: <26039535-5f78-74f1-7864-978ad6c2810d@arm.com>
Date: Thu, 6 Apr 2023 19:08:59 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 03/17] iommu: Make __iommu_group_set_domain() handle
 error unwind
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <3-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <3-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/04/2023 12:38 am, Jason Gunthorpe wrote:
> Let's try to have a consistent and clear strategy for error handling
> during domain attach failures.
> 
> There are two broad categories, the first is callers doing destruction and
> trying to set the domain back to a previously good domain. These cases
> cannot handle failure during destruction flows and must succeed, or at
> least avoid a UAF on the current group->domain which is likely about to be
> freed.
> 
> Many of the drivers are well behaved here and will not hit the WARN_ON's
> or a UAF, but some are doing hypercalls/etc that can fail unpredictably
> and don't meet the expectations.
> 
> The second case is attaching a domain for the first time in a failable
> context, failure should restore the attachment back to group->domain using
> the above unfailable operation.
> 
> Have __iommu_group_set_domain_internal() execute a common algorithm that
> tries to achieve this, and in the worst case, would leave a device
> "detached" or assigned to a global blocking domain. This relies on some
> existing common driver behaviors where attach failure will also do detatch
> and true IOMMU_DOMAIN_BLOCK implementations that are not allowed to ever
> fail.
> 
> Name the first case with __iommu_group_set_domain_nofail() to make it
> clear.
> 
> Pull all the error handling and WARN_ON generation into
> __iommu_group_set_domain_internal().
> 
> Avoid the obfuscating use of __iommu_group_for_each_dev() and be more
> careful about what should happen during failures by only touching devices
> we've already touched.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 130 +++++++++++++++++++++++++++++++++++-------
>   1 file changed, 108 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 501257bd02fc3c..b7cb2a56ebfe8c 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -99,8 +99,26 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>   				 struct device *dev);
>   static int __iommu_attach_group(struct iommu_domain *domain,
>   				struct iommu_group *group);
> +
> +enum {
> +	IOMMU_SET_DOMAIN_MUST_SUCCEED = 1 << 0,
> +};
> +
> +static int __iommu_group_set_domain_internal(struct iommu_group *group,
> +					     struct iommu_domain *new_domain,
> +					     unsigned int flags);
>   static int __iommu_group_set_domain(struct iommu_group *group,
> -				    struct iommu_domain *new_domain);
> +				    struct iommu_domain *new_domain)
> +{
> +	return __iommu_group_set_domain_internal(group, new_domain, 0);
> +}
> +static void __iommu_group_set_domain_nofail(struct iommu_group *group,
> +					    struct iommu_domain *new_domain)
> +{
> +	WARN_ON(__iommu_group_set_domain_internal(
> +		group, new_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED));
> +}
> +
>   static int iommu_create_device_direct_mappings(struct iommu_group *group,
>   					       struct device *dev);
>   static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
> @@ -2040,15 +2058,13 @@ EXPORT_SYMBOL_GPL(iommu_domain_free);
>   static void __iommu_group_set_core_domain(struct iommu_group *group)
>   {
>   	struct iommu_domain *new_domain;
> -	int ret;
>   
>   	if (group->owner)
>   		new_domain = group->blocking_domain;
>   	else
>   		new_domain = group->default_domain;
>   
> -	ret = __iommu_group_set_domain(group, new_domain);
> -	WARN(ret, "iommu driver failed to attach the default/blocking domain");
> +	__iommu_group_set_domain_nofail(group, new_domain);
>   }
>   
>   static int __iommu_attach_device(struct iommu_domain *domain,
> @@ -2233,21 +2249,55 @@ int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
>   }
>   EXPORT_SYMBOL_GPL(iommu_attach_group);
>   
> -static int iommu_group_do_set_platform_dma(struct device *dev, void *data)
> +static int __iommu_device_set_domain(struct iommu_group *group,
> +				     struct device *dev,
> +				     struct iommu_domain *new_domain,
> +				     unsigned int flags)
>   {
> -	const struct iommu_ops *ops = dev_iommu_ops(dev);
> -
> -	if (!WARN_ON(!ops->set_platform_dma_ops))
> -		ops->set_platform_dma_ops(dev);
> +	int ret;
>   
> +	ret = __iommu_attach_device(new_domain, dev);
> +	if (ret) {
> +		/*
> +		 * If we have a blocking domain then try to attach that in hopes
> +		 * of avoiding a UAF. Modern drivers should implement blocking
> +		 * domains as global statics that cannot fail.
> +		 */
> +		if ((flags & IOMMU_SET_DOMAIN_MUST_SUCCEED) &&
> +		    group->blocking_domain &&
> +		    group->blocking_domain != new_domain)
> +			__iommu_attach_device(group->blocking_domain, dev);
> +		return ret;
> +	}
>   	return 0;
>   }
>   
> -static int __iommu_group_set_domain(struct iommu_group *group,
> -				    struct iommu_domain *new_domain)
> +/*
> + * If 0 is returned the group's domain is new_domain. If an error is returned
> + * then the group's domain will be set back to the existing domain unless
> + * IOMMU_SET_DOMAIN_MUST_SUCCEED, otherwise an error is returned and the group's
> + * domains is left inconsistent. This is a driver bug to fail attach with a
> + * previously good domain. We try to avoid a kernel UAF because of this.
> + *
> + * IOMMU groups are really the natural working unit of the IOMMU, but the IOMMU
> + * API works on domains and devices.  Bridge that gap by iterating over the
> + * devices in a group.  Ideally we'd have a single device which represents the
> + * requestor ID of the group, but we also allow IOMMU drivers to create policy
> + * defined minimum sets, where the physical hardware may be able to distiguish
> + * members, but we wish to group them at a higher level (ex. untrusted
> + * multi-function PCI devices).  Thus we attach each device.
> + */
> +static int __iommu_group_set_domain_internal(struct iommu_group *group,
> +					     struct iommu_domain *new_domain,
> +					     unsigned int flags)
>   {
> +	struct group_device *last_gdev;
> +	struct group_device *gdev;
> +	int result;
>   	int ret;
>   
> +	lockdep_assert_held(&group->mutex);
> +
>   	if (group->domain == new_domain)
>   		return 0;
>   
> @@ -2257,8 +2307,12 @@ static int __iommu_group_set_domain(struct iommu_group *group,
>   	 * platform specific behavior.
>   	 */
>   	if (!new_domain) {
> -		__iommu_group_for_each_dev(group, NULL,
> -					   iommu_group_do_set_platform_dma);
> +		for_each_group_device(group, gdev) {
> +			const struct iommu_ops *ops = dev_iommu_ops(gdev->dev);
> +
> +			if (!WARN_ON(!ops->set_platform_dma_ops))
> +				ops->set_platform_dma_ops(gdev->dev);
> +		}
>   		group->domain = NULL;
>   		return 0;
>   	}
> @@ -2272,12 +2326,47 @@ static int __iommu_group_set_domain(struct iommu_group *group,
>   	 * Note that this is called in error unwind paths, attaching to a
>   	 * domain that has already been attached cannot fail.

This comment now seems at odds with the rest of the code.

>   	 */
> -	ret = __iommu_group_for_each_dev(group, new_domain,
> -					 iommu_group_do_attach_device);
> -	if (ret)
> -		return ret;
> +	result = 0;
> +	for_each_group_device(group, gdev) {
> +		ret = __iommu_device_set_domain(group, gdev->dev, new_domain,
> +						flags);
> +		if (ret) {
> +			result = ret;
> +			/*
> +			 * Keep trying the other devices in the group. If a
> +			 * driver fails attach to an otherwise good domain, and
> +			 * does not support blocking domains, it should at least
> +			 * drop its reference on the current domain so we don't
> +			 * UAF.
> +			 */
> +			if (flags & IOMMU_SET_DOMAIN_MUST_SUCCEED)
> +				continue;

I know it's called out above, but my brain truly can't cope with a flag 
named "MUST_SUCCEED" which actually means "can fail, but you can't 
reason about the state after failure". As before, I think the actual 
flag itself can go away, but the behaviour itself will still be no nicer 
for being implicit :/

By this point I've started to lose sight of whether we've really 
meaningfully improved the handling of failure if we still have multiple 
different behaviours and one of them is still this mess... The 
big-picture view seems to be that in order to avoid relying on the 
assumption that the second and subsequent attaches within a group can't 
fail if the first one didn't, we can now "handle" such a failure, by 
requiring the assumption that the second and subsequent attaches to a 
domain in general must not fail if the first one didn't. See the problem 
there?

TBH I still think the responsibility should be on the drivers to handle 
rollback of their internal per-device state if returning failure from an 
.attach_dev call. As above, it fundamentally *can't* generalise at the 
core API level since after the one special case of resetting the first 
device in a group when an initial attach failed, it becomes 
self-contradictory. And that special case itself is basically working 
around a dumb driver behaviour that's always going to be simplest to fix 
directly in any driver that does it. But what would be really really 
really good, now that .detach_dev has truly gone, is to pass *both* "to" 
and "from" domains to .attach_dev (and a "from" domain to 
.release_device), so that drivers don't have to squirrel away all these 
internal references to their own notions of "current" domains which are 
the root of this whole class of horrid UAF and consistency bugs.

Thanks,
Robin.

> +			goto err_revert;
> +		}
> +	}
>   	group->domain = new_domain;
> -	return 0;
> +	return result;
> +
> +err_revert:
> +	last_gdev = gdev;
> +	for_each_group_device(group, gdev) {
> +		const struct iommu_ops *ops = dev_iommu_ops(gdev->dev);
> +
> +		/*
> +		 * If set_platform_dma_ops is not present a NULL domain can
> +		 * happen only for first probe, in which case we leave
> +		 * group->domain as NULL and let release clean everything up.
> +		 */
> +		if (group->domain)
> +			WARN_ON(__iommu_device_set_domain(
> +				group, gdev->dev, group->domain,
> +				IOMMU_SET_DOMAIN_MUST_SUCCEED));
> +		else if (ops->set_platform_dma_ops)
> +			ops->set_platform_dma_ops(gdev->dev);
> +		if (gdev == last_gdev)
> +			break;
> +	}
> +	return ret;
>   }
>   
>   void iommu_detach_group(struct iommu_domain *domain, struct iommu_group *group)
> @@ -3194,16 +3283,13 @@ EXPORT_SYMBOL_GPL(iommu_device_claim_dma_owner);
>   
>   static void __iommu_release_dma_ownership(struct iommu_group *group)
>   {
> -	int ret;
> -
>   	if (WARN_ON(!group->owner_cnt || !group->owner ||
>   		    !xa_empty(&group->pasid_array)))
>   		return;
>   
>   	group->owner_cnt = 0;
>   	group->owner = NULL;
> -	ret = __iommu_group_set_domain(group, group->default_domain);
> -	WARN(ret, "iommu driver failed to attach the default domain");
> +	__iommu_group_set_domain_nofail(group, group->default_domain);
>   }
>   
>   /**
