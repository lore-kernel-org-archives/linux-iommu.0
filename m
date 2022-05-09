Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171F4C433F5
	for <iommu@archiver.kernel.org>; Mon,  9 May 2022 22:15:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9209408C6;
	Mon,  9 May 2022 22:15:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dhnNjZztr4YN; Mon,  9 May 2022 22:15:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D7914408B6;
	Mon,  9 May 2022 22:15:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B739EC0039;
	Mon,  9 May 2022 22:15:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABAD8C002D
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 22:15:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 946C8408BB
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 22:15:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xSLdAF3MlYtd for <iommu@lists.linux-foundation.org>;
 Mon,  9 May 2022 22:15:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id DE8A5408B6
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 22:15:44 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F15012FC;
 Mon,  9 May 2022 15:15:44 -0700 (PDT)
Received: from [10.57.80.111] (unknown [10.57.80.111])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 437A03F5A1;
 Mon,  9 May 2022 15:15:42 -0700 (PDT)
Message-ID: <1dd3a5fb-b2a7-1134-7b78-7d5c501cf0a0@arm.com>
Date: Mon, 9 May 2022 23:15:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3] iommu: iommu_group_claim_dma_owner() must always
 assign a domain
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux-foundation.org,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
References: <0-v3-db7f0785022b+149-iommu_dma_block_jgg@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <0-v3-db7f0785022b+149-iommu_dma_block_jgg@nvidia.com>
Cc: Qian Cai <quic_qiancai@quicinc.com>, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <jroedel@suse.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022-05-09 17:19, Jason Gunthorpe wrote:
> Once the group enters 'owned' mode it can never be assigned back to the
> default_domain or to a NULL domain. It must always be actively assigned to
> a current domain. If the caller hasn't provided a domain then the core
> must provide an explicit DMA blocking domain that has no DMA map.
> 
> Lazily create a group-global blocking DMA domain when
> iommu_group_claim_dma_owner is first called and immediately assign the
> group to it. This ensures that DMA is immediately fully isolated on all
> IOMMU drivers.
> 
> If the user attaches/detaches while owned then detach will set the group
> back to the blocking domain.
> 
> Slightly reorganize the call chains so that
> __iommu_group_set_core_domain() is the function that removes any caller
> configured domain and sets the domains back a core owned domain with an
> appropriate lifetime.
> 
> __iommu_group_set_domain() is the worker function that can change the
> domain assigned to a group to any target domain, including NULL.
> 
> Add comments clarifying how the NULL vs detach_dev vs default_domain works
> based on Robin's remarks.
> 
> This fixes an oops with VFIO and SMMUv3 because VFIO will call
> iommu_detach_group() and then immediately iommu_domain_free(), but
> SMMUv3 has no way to know that the domain it is holding a pointer to
> has been freed. Now the iommu_detach_group() will assign the blocking
> domain and SMMUv3 will no longer hold a stale domain reference.

Thanks Jason, from my PoV this looks great now - I still think it feels 
too silly to give a formal review tag for a patch with my own sign-off, 
so this is just my ephemeral "let's get this branch back in -next ASAP 
and hope nothing else shakes loose" :)

Cheers,
Robin.

> Fixes: 1ea2a07a532b ("iommu: Add DMA ownership management interfaces")
> Reported-by: Qian Cai <quic_qiancai@quicinc.com>
> Tested-by: Baolu Lu <baolu.lu@linux.intel.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Co-developed-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> --
> 
> Just minor polishing as discussed
> 
> v3:
>   - Change names to __iommu_group_set_domain() /
>     __iommu_group_set_core_domain()
>   - Clarify comments
>   - Call __iommu_group_set_domain() directly in
>     iommu_group_release_dma_owner() since we know it is always selecting
>     the default_domain
> v2: https://lore.kernel.org/r/0-v2-f62259511ac0+6-iommu_dma_block_jgg@nvidia.com
>   - Remove redundant detach_dev ops check in __iommu_detach_device and
>     make the added WARN_ON fail instead
>   - Check for blocking_domain in __iommu_attach_group() so VFIO can
>     actually attach a new group
>   - Update comments and spelling
>   - Fix missed change to new_domain in iommu_group_do_detach_device()
> v1: https://lore.kernel.org/r/0-v1-6e9d2d0a759d+11b-iommu_dma_block_jgg@nvidia.com
> 
> ---
>   drivers/iommu/iommu.c | 127 ++++++++++++++++++++++++++++++------------
>   1 file changed, 91 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0c42ece2585406..0b22e51e90f416 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -44,6 +44,7 @@ struct iommu_group {
>   	char *name;
>   	int id;
>   	struct iommu_domain *default_domain;
> +	struct iommu_domain *blocking_domain;
>   	struct iommu_domain *domain;
>   	struct list_head entry;
>   	unsigned int owner_cnt;
> @@ -82,8 +83,8 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>   				 struct device *dev);
>   static int __iommu_attach_group(struct iommu_domain *domain,
>   				struct iommu_group *group);
> -static void __iommu_detach_group(struct iommu_domain *domain,
> -				 struct iommu_group *group);
> +static int __iommu_group_set_domain(struct iommu_group *group,
> +				    struct iommu_domain *new_domain);
>   static int iommu_create_device_direct_mappings(struct iommu_group *group,
>   					       struct device *dev);
>   static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
> @@ -596,6 +597,8 @@ static void iommu_group_release(struct kobject *kobj)
>   
>   	if (group->default_domain)
>   		iommu_domain_free(group->default_domain);
> +	if (group->blocking_domain)
> +		iommu_domain_free(group->blocking_domain);
>   
>   	kfree(group->name);
>   	kfree(group);
> @@ -1907,6 +1910,24 @@ void iommu_domain_free(struct iommu_domain *domain)
>   }
>   EXPORT_SYMBOL_GPL(iommu_domain_free);
>   
> +/*
> + * Put the group's domain back to the appropriate core-owned domain - either the
> + * standard kernel-mode DMA configuration or an all-DMA-blocked domain.
> + */
> +static void __iommu_group_set_core_domain(struct iommu_group *group)
> +{
> +	struct iommu_domain *new_domain;
> +	int ret;
> +
> +	if (group->owner)
> +		new_domain = group->blocking_domain;
> +	else
> +		new_domain = group->default_domain;
> +
> +	ret = __iommu_group_set_domain(group, new_domain);
> +	WARN(ret, "iommu driver failed to attach the default/blocking domain");
> +}
> +
>   static int __iommu_attach_device(struct iommu_domain *domain,
>   				 struct device *dev)
>   {
> @@ -1963,9 +1984,6 @@ static void __iommu_detach_device(struct iommu_domain *domain,
>   	if (iommu_is_attach_deferred(dev))
>   		return;
>   
> -	if (unlikely(domain->ops->detach_dev == NULL))
> -		return;
> -
>   	domain->ops->detach_dev(domain, dev);
>   	trace_detach_device_from_domain(dev);
>   }
> @@ -1979,12 +1997,10 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
>   		return;
>   
>   	mutex_lock(&group->mutex);
> -	if (iommu_group_device_count(group) != 1) {
> -		WARN_ON(1);
> +	if (WARN_ON(domain != group->domain) ||
> +	    WARN_ON(iommu_group_device_count(group) != 1))
>   		goto out_unlock;
> -	}
> -
> -	__iommu_detach_group(domain, group);
> +	__iommu_group_set_core_domain(group);
>   
>   out_unlock:
>   	mutex_unlock(&group->mutex);
> @@ -2040,7 +2056,8 @@ static int __iommu_attach_group(struct iommu_domain *domain,
>   {
>   	int ret;
>   
> -	if (group->domain && group->domain != group->default_domain)
> +	if (group->domain && group->domain != group->default_domain &&
> +	    group->domain != group->blocking_domain)
>   		return -EBUSY;
>   
>   	ret = __iommu_group_for_each_dev(group, domain,
> @@ -2072,38 +2089,49 @@ static int iommu_group_do_detach_device(struct device *dev, void *data)
>   	return 0;
>   }
>   
> -static void __iommu_detach_group(struct iommu_domain *domain,
> -				 struct iommu_group *group)
> +static int __iommu_group_set_domain(struct iommu_group *group,
> +				    struct iommu_domain *new_domain)
>   {
>   	int ret;
>   
> +	if (group->domain == new_domain)
> +		return 0;
> +
>   	/*
> -	 * If the group has been claimed already, do not re-attach the default
> -	 * domain.
> +	 * New drivers should support default domains and so the detach_dev() op
> +	 * will never be called. Otherwise the NULL domain represents some
> +	 * platform specific behavior.
>   	 */
> -	if (!group->default_domain || group->owner) {
> -		__iommu_group_for_each_dev(group, domain,
> +	if (!new_domain) {
> +		if (WARN_ON(!group->domain->ops->detach_dev))
> +			return -EINVAL;
> +		__iommu_group_for_each_dev(group, group->domain,
>   					   iommu_group_do_detach_device);
>   		group->domain = NULL;
> -		return;
> +		return 0;
>   	}
>   
> -	if (group->domain == group->default_domain)
> -		return;
> -
> -	/* Detach by re-attaching to the default domain */
> -	ret = __iommu_group_for_each_dev(group, group->default_domain,
> +	/*
> +	 * Changing the domain is done by calling attach_dev() on the new
> +	 * domain. This switch does not have to be atomic and DMA can be
> +	 * discarded during the transition. DMA must only be able to access
> +	 * either new_domain or group->domain, never something else.
> +	 *
> +	 * Note that this is called in error unwind paths, attaching to a
> +	 * domain that has already been attached cannot fail.
> +	 */
> +	ret = __iommu_group_for_each_dev(group, new_domain,
>   					 iommu_group_do_attach_device);
> -	if (ret != 0)
> -		WARN_ON(1);
> -	else
> -		group->domain = group->default_domain;
> +	if (ret)
> +		return ret;
> +	group->domain = new_domain;
> +	return 0;
>   }
>   
>   void iommu_detach_group(struct iommu_domain *domain, struct iommu_group *group)
>   {
>   	mutex_lock(&group->mutex);
> -	__iommu_detach_group(domain, group);
> +	__iommu_group_set_core_domain(group);
>   	mutex_unlock(&group->mutex);
>   }
>   EXPORT_SYMBOL_GPL(iommu_detach_group);
> @@ -3088,6 +3116,29 @@ void iommu_device_unuse_default_domain(struct device *dev)
>   	iommu_group_put(group);
>   }
>   
> +static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
> +{
> +	struct group_device *dev =
> +		list_first_entry(&group->devices, struct group_device, list);
> +
> +	if (group->blocking_domain)
> +		return 0;
> +
> +	group->blocking_domain =
> +		__iommu_domain_alloc(dev->dev->bus, IOMMU_DOMAIN_BLOCKED);
> +	if (!group->blocking_domain) {
> +		/*
> +		 * For drivers that do not yet understand IOMMU_DOMAIN_BLOCKED
> +		 * create an empty domain instead.
> +		 */
> +		group->blocking_domain = __iommu_domain_alloc(
> +			dev->dev->bus, IOMMU_DOMAIN_UNMANAGED);
> +		if (!group->blocking_domain)
> +			return -EINVAL;
> +	}
> +	return 0;
> +}
> +
>   /**
>    * iommu_group_claim_dma_owner() - Set DMA ownership of a group
>    * @group: The group.
> @@ -3111,9 +3162,14 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner)
>   			goto unlock_out;
>   		}
>   
> +		ret = __iommu_group_alloc_blocking_domain(group);
> +		if (ret)
> +			goto unlock_out;
> +
> +		ret = __iommu_group_set_domain(group, group->blocking_domain);
> +		if (ret)
> +			goto unlock_out;
>   		group->owner = owner;
> -		if (group->domain)
> -			__iommu_detach_group(group->domain, group);
>   	}
>   
>   	group->owner_cnt++;
> @@ -3132,18 +3188,17 @@ EXPORT_SYMBOL_GPL(iommu_group_claim_dma_owner);
>    */
>   void iommu_group_release_dma_owner(struct iommu_group *group)
>   {
> +	int ret;
> +
>   	mutex_lock(&group->mutex);
>   	if (WARN_ON(!group->owner_cnt || !group->owner))
>   		goto unlock_out;
>   
>   	group->owner_cnt = 0;
> -	/*
> -	 * The UNMANAGED domain should be detached before all USER
> -	 * owners have been released.
> -	 */
> -	if (!WARN_ON(group->domain) && group->default_domain)
> -		__iommu_attach_group(group->default_domain, group);
>   	group->owner = NULL;
> +	ret = __iommu_group_set_domain(group, group->default_domain);
> +	WARN(ret, "iommu driver failed to attach the default domain");
> +
>   unlock_out:
>   	mutex_unlock(&group->mutex);
>   }
> 
> base-commit: da844db4722bdd333142b40f0e414e2aedc2a4c0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
