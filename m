Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511E65252
	for <iommu@lists.linux.dev>; Mon,  6 Feb 2023 13:29:56 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC4BDC14;
	Mon,  6 Feb 2023 05:30:37 -0800 (PST)
Received: from [10.57.89.151] (unknown [10.57.89.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC2143F8C6;
	Mon,  6 Feb 2023 05:29:54 -0800 (PST)
Message-ID: <b2061df7-d28b-207f-1968-a7dac3171cfe@arm.com>
Date: Mon, 6 Feb 2023 13:29:51 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/3] iommu: Attach device group to old domain in error
 path
Content-Language: en-GB
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com, will@kernel.org
References: <20230203173623.18308-1-vasant.hegde@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230203173623.18308-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-02-03 17:36, Vasant Hegde wrote:
> iommu_attach_group() attaches all devices in a group to domain and then
> sets group domain (group->domain). Current code (__iommu_attach_group())
> does not handle error path. This creates problem as devices to domain
> attachment is in inconsistent state.

Can you clarify the circumstances for this happening? I think the 
implicit assumption here is that if first attach_dev succeeds, then the 
group is compatible with the domain in general, so then any subsequent 
attach_dev calls are mostly just updating data for additional RIDs, and 
as such would not be expected to fail.

Thanks,
Robin.

> To recover from this situation, we need force attaching all devices back
> to the old domain. This patch introduces `force` parameter to
> __iommu_group_set_domain() so that we can attach devices back to old
> domain.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>   drivers/iommu/iommu.c | 24 +++++++++++++++++-------
>   1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index de91dd88705b..e58683cd3bf7 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -95,7 +95,8 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>   static int __iommu_attach_group(struct iommu_domain *domain,
>   				struct iommu_group *group);
>   static int __iommu_group_set_domain(struct iommu_group *group,
> -				    struct iommu_domain *new_domain);
> +				    struct iommu_domain *new_domain,
> +				    bool force);
>   static int iommu_create_device_direct_mappings(struct iommu_group *group,
>   					       struct device *dev);
>   static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
> @@ -1974,7 +1975,7 @@ static void __iommu_group_set_core_domain(struct iommu_group *group)
>   	else
>   		new_domain = group->default_domain;
>   
> -	ret = __iommu_group_set_domain(group, new_domain);
> +	ret = __iommu_group_set_domain(group, new_domain, false);
>   	WARN(ret, "iommu driver failed to attach the default/blocking domain");
>   }
>   
> @@ -2124,8 +2125,16 @@ static int __iommu_attach_group(struct iommu_domain *domain,
>   
>   	ret = __iommu_group_for_each_dev(group, domain,
>   					 iommu_group_do_attach_device);
> -	if (ret == 0)
> +	if (ret == 0) {
>   		group->domain = domain;
> +	} else {
> +		/*
> +		 * To recover from the case when certain device within the
> +		 * group fails to attach to the new domain, we need force
> +		 * attaching all devices back to the old domain.
> +		 */
> +		__iommu_group_set_domain(group, group->domain, true);
> +	}
>   
>   	return ret;
>   }
> @@ -2164,11 +2173,12 @@ static int iommu_group_do_detach_device(struct device *dev, void *data)
>   }
>   
>   static int __iommu_group_set_domain(struct iommu_group *group,
> -				    struct iommu_domain *new_domain)
> +				    struct iommu_domain *new_domain,
> +				    bool force)
>   {
>   	int ret;
>   
> -	if (group->domain == new_domain)
> +	if (!force && group->domain == new_domain)
>   		return 0;
>   
>   	/*
> @@ -3135,7 +3145,7 @@ static int __iommu_take_dma_ownership(struct iommu_group *group, void *owner)
>   	ret = __iommu_group_alloc_blocking_domain(group);
>   	if (ret)
>   		return ret;
> -	ret = __iommu_group_set_domain(group, group->blocking_domain);
> +	ret = __iommu_group_set_domain(group, group->blocking_domain, false);
>   	if (ret)
>   		return ret;
>   
> @@ -3222,7 +3232,7 @@ static void __iommu_release_dma_ownership(struct iommu_group *group)
>   
>   	group->owner_cnt = 0;
>   	group->owner = NULL;
> -	ret = __iommu_group_set_domain(group, group->default_domain);
> +	ret = __iommu_group_set_domain(group, group->default_domain, false);
>   	WARN(ret, "iommu driver failed to attach the default domain");
>   }
>   
