Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3550C6121
	for <iommu@lists.linux.dev>; Wed, 12 Apr 2023 14:39:43 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D930DD75;
	Wed, 12 Apr 2023 07:40:26 -0700 (PDT)
Received: from [10.57.55.240] (unknown [10.57.55.240])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 718503F587;
	Wed, 12 Apr 2023 07:39:41 -0700 (PDT)
Message-ID: <1a2f16aa-6e0b-e2f9-59b2-15160c7c9614@arm.com>
Date: Wed, 12 Apr 2023 15:39:36 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] iommu: Remove iommu_group_get_by_id()
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
References: <0-v1-60bbc66d7e92+24-rm_iommu_get_by_id_jgg@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <0-v1-60bbc66d7e92+24-rm_iommu_get_by_id_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-04-12 15:11, Jason Gunthorpe wrote:
> This is never called.

Ah yes, I see VFIO stopped using it last year.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 29 -----------------------------
>   include/linux/iommu.h |  6 ------
>   2 files changed, 35 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 7abee83610b6c9..e0e7c90b490686 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -881,35 +881,6 @@ struct iommu_group *iommu_group_alloc(void)
>   }
>   EXPORT_SYMBOL_GPL(iommu_group_alloc);
>   
> -struct iommu_group *iommu_group_get_by_id(int id)
> -{
> -	struct kobject *group_kobj;
> -	struct iommu_group *group;
> -	const char *name;
> -
> -	if (!iommu_group_kset)
> -		return NULL;
> -
> -	name = kasprintf(GFP_KERNEL, "%d", id);
> -	if (!name)
> -		return NULL;
> -
> -	group_kobj = kset_find_obj(iommu_group_kset, name);
> -	kfree(name);
> -
> -	if (!group_kobj)
> -		return NULL;
> -
> -	group = container_of(group_kobj, struct iommu_group, kobj);
> -	BUG_ON(group->id != id);
> -
> -	kobject_get(group->devices_kobj);
> -	kobject_put(&group->kobj);
> -
> -	return group;
> -}
> -EXPORT_SYMBOL_GPL(iommu_group_get_by_id);
> -
>   /**
>    * iommu_group_get_iommudata - retrieve iommu_data registered for a group
>    * @group: the group
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 54f535ff9868af..d9e8fc4512d6c5 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -460,7 +460,6 @@ extern bool iommu_present(struct bus_type *bus);
>   extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
>   extern bool iommu_group_has_isolated_msi(struct iommu_group *group);
>   extern struct iommu_domain *iommu_domain_alloc(struct bus_type *bus);
> -extern struct iommu_group *iommu_group_get_by_id(int id);
>   extern void iommu_domain_free(struct iommu_domain *domain);
>   extern int iommu_attach_device(struct iommu_domain *domain,
>   			       struct device *dev);
> @@ -747,11 +746,6 @@ static inline struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
>   	return NULL;
>   }
>   
> -static inline struct iommu_group *iommu_group_get_by_id(int id)
> -{
> -	return NULL;
> -}
> -
>   static inline void iommu_domain_free(struct iommu_domain *domain)
>   {
>   }
> 
> base-commit: 43a31380ed6e16ad08675de5e68b5e4d05cf8716
