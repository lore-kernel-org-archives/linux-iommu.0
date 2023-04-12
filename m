Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BAE5698
	for <iommu@lists.linux.dev>; Wed, 12 Apr 2023 14:19:59 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 308C4D75;
	Wed, 12 Apr 2023 07:20:38 -0700 (PDT)
Received: from [10.57.55.240] (unknown [10.57.55.240])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DB9F3F587;
	Wed, 12 Apr 2023 07:19:52 -0700 (PDT)
Message-ID: <f92ff425-04d8-6201-dd1e-5be96a599bc6@arm.com>
Date: Wed, 12 Apr 2023 15:19:48 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] iommu: Make iommu_release_device() static
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
References: <0-v1-c3da18124d2d+56-rm_iommu_release_jgg@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <0-v1-c3da18124d2d+56-rm_iommu_release_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-04-12 15:10, Jason Gunthorpe wrote:
> This is not called outside the core code, and indeed cannot be called
> correctly outside the bus notifier. Make it static.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 3 ++-
>   include/linux/iommu.h | 1 -
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 7abee83610b6c9..435fc902df1984 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -87,6 +87,7 @@ static const char * const iommu_group_resv_type_string[] = {
>   
>   static int iommu_bus_notifier(struct notifier_block *nb,
>   			      unsigned long action, void *data);
> +static void iommu_release_device(struct device *dev);
>   static int iommu_alloc_default_domain(struct iommu_group *group,
>   				      struct device *dev);
>   static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
> @@ -493,7 +494,7 @@ static void __iommu_group_release_device(struct iommu_group *group,
>   	kobject_put(group->devices_kobj);
>   }
>   
> -void iommu_release_device(struct device *dev)
> +static void iommu_release_device(struct device *dev)
>   {
>   	struct iommu_group *group = dev->iommu_group;
>   	struct group_device *device;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 54f535ff9868af..c892e06f8357ee 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -699,7 +699,6 @@ static inline void dev_iommu_priv_set(struct device *dev, void *priv)
>   }
>   
>   int iommu_probe_device(struct device *dev);
> -void iommu_release_device(struct device *dev);
>   
>   int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
>   int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
> 
> base-commit: 43a31380ed6e16ad08675de5e68b5e4d05cf8716
