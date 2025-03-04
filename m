Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B911E20A5EB
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099837; cv=none; b=DaAlQQ8k0ro50qK7mjF1z+Wt6qnnPaXpDbjQsAZ4JA3H3bK70YuxjLqShcKWXEEifFHUFcCuqZRO8EemZn7OxSvLvh2brfDXo7UJ73cVeNBOeEuMiG4N2fgBAYxpPJrwOjUgXUcKzSqOQ04FVvMBWcKVA/TjCbLY3iOd6+OS+Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099837; c=relaxed/simple;
	bh=UZjqD9Jrk5VtVzsrf2nqJpCAa7TMxIB9xEi0ZFwhNe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q91OzaBYzz6dMnU5EV9mf85RgNlYxhlBYoQ0Klu7nyx5T6YSEKrdYoCvq3N7Z7SMzX4xeDUKvovVrs9JSI4/pRFa5kAw5ZIPG/xBBX9JvOfGXYeKq0O3IzhlglR/saCXZLjUuko5pIx3lvamZme45jI++njgKd84IQoSWGhzzX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9C3FFEC;
	Tue,  4 Mar 2025 06:50:48 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12CD03F66E;
	Tue,  4 Mar 2025 06:50:33 -0800 (PST)
Message-ID: <af6d3526-5a54-41dd-ae93-1827de9205f6@arm.com>
Date: Tue, 4 Mar 2025 14:50:32 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] iommu: Drop sw_msi from iommu_domain
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1741034885.git.nicolinc@nvidia.com>
 <17eead28dcf8ae6b246471c05c2cf1eb0774236b.1741034886.git.nicolinc@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <17eead28dcf8ae6b246471c05c2cf1eb0774236b.1741034886.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/03/2025 8:52 pm, Nicolin Chen wrote:
> There are only two sw_msi implementations in the entire system, thus it's
> not very necessary to have an sw_msi pointer.
> 
> Instead, check domain->private_data_owner to call the two implementations
> directly from the core code.

FWIW I still wish this was squashed into the pending patches so we're 
not adding stuff we immediately remove again, but oh well, what's done 
is done.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

(assuming this isn't also queued already given that once again I've had 
the audacity to not look at my inbox until after 2PM the day after it 
was posted...)

> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/dma-iommu.h            |  9 +++++++++
>   include/linux/iommu.h                | 15 ---------------
>   drivers/iommu/dma-iommu.c            | 14 ++------------
>   drivers/iommu/iommu.c                | 17 +++++++++++++++--
>   drivers/iommu/iommufd/hw_pagetable.c |  3 ---
>   5 files changed, 26 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
> index 9cca11806e5d..eca201c1f963 100644
> --- a/drivers/iommu/dma-iommu.h
> +++ b/drivers/iommu/dma-iommu.h
> @@ -19,6 +19,9 @@ int iommu_dma_init_fq(struct iommu_domain *domain);
>   
>   void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
>   
> +int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
> +		     phys_addr_t msi_addr);
> +
>   extern bool iommu_dma_forcedac;
>   
>   #else /* CONFIG_IOMMU_DMA */
> @@ -49,5 +52,11 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
>   {
>   }
>   
> +static inline int iommu_dma_sw_msi(struct iommu_domain *domain,
> +				   struct msi_desc *desc, phys_addr_t msi_addr)
> +{
> +	return -ENODEV;
> +}
> +
>   #endif	/* CONFIG_IOMMU_DMA */
>   #endif	/* __DMA_IOMMU_H */
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 06cc14e9993d..e01c855ae8a7 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -229,11 +229,6 @@ struct iommu_domain {
>   	struct iommu_domain_geometry geometry;
>   	int (*iopf_handler)(struct iopf_group *group);
>   
> -#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
> -	int (*sw_msi)(struct iommu_domain *domain, struct msi_desc *desc,
> -		      phys_addr_t msi_addr);
> -#endif
> -
>   	union { /* cookie */
>   		struct iommu_dma_cookie *iova_cookie;
>   		struct iommu_dma_msi_cookie *msi_cookie;
> @@ -254,16 +249,6 @@ struct iommu_domain {
>   	};
>   };
>   
> -static inline void iommu_domain_set_sw_msi(
> -	struct iommu_domain *domain,
> -	int (*sw_msi)(struct iommu_domain *domain, struct msi_desc *desc,
> -		      phys_addr_t msi_addr))
> -{
> -#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
> -	domain->sw_msi = sw_msi;
> -#endif
> -}
> -
>   static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
>   {
>   	return domain->type & __IOMMU_DOMAIN_DMA_API;
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index bc9bb9cb70c8..96e9f8d0a4f6 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -94,9 +94,6 @@ static int __init iommu_dma_forcedac_setup(char *str)
>   }
>   early_param("iommu.forcedac", iommu_dma_forcedac_setup);
>   
> -static int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
> -			    phys_addr_t msi_addr);
> -
>   /* Number of entries per flush queue */
>   #define IOVA_DEFAULT_FQ_SIZE	256
>   #define IOVA_SINGLE_FQ_SIZE	32768
> @@ -377,7 +374,6 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
>   
>   	mutex_init(&cookie->mutex);
>   	INIT_LIST_HEAD(&cookie->msi_page_list);
> -	iommu_domain_set_sw_msi(domain, iommu_dma_sw_msi);
>   	domain->cookie_type = IOMMU_COOKIE_DMA_IOVA;
>   	domain->iova_cookie = cookie;
>   	return 0;
> @@ -411,7 +407,6 @@ int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
>   
>   	cookie->msi_iova = base;
>   	INIT_LIST_HEAD(&cookie->msi_page_list);
> -	iommu_domain_set_sw_msi(domain, iommu_dma_sw_msi);
>   	domain->cookie_type = IOMMU_COOKIE_DMA_MSI;
>   	domain->msi_cookie = cookie;
>   	return 0;
> @@ -427,11 +422,6 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>   	struct iommu_dma_msi_page *msi, *tmp;
>   
> -#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
> -	if (domain->sw_msi != iommu_dma_sw_msi)
> -		return;
> -#endif
> -
>   	if (cookie->iovad.granule) {
>   		iommu_dma_free_fq(cookie);
>   		put_iova_domain(&cookie->iovad);
> @@ -1825,8 +1815,8 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>   	return NULL;
>   }
>   
> -static int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
> -			    phys_addr_t msi_addr)
> +int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
> +		     phys_addr_t msi_addr)
>   {
>   	struct device *dev = msi_desc_to_dev(desc);
>   	const struct iommu_dma_msi_page *msi_page;
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 8b9423340221..c1c0656f41ef 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -18,6 +18,7 @@
>   #include <linux/errno.h>
>   #include <linux/host1x_context_bus.h>
>   #include <linux/iommu.h>
> +#include <linux/iommufd.h>
>   #include <linux/idr.h>
>   #include <linux/err.h>
>   #include <linux/pci.h>
> @@ -3649,8 +3650,20 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>   		return 0;
>   
>   	mutex_lock(&group->mutex);
> -	if (group->domain && group->domain->sw_msi)
> -		ret = group->domain->sw_msi(group->domain, desc, msi_addr);
> +	if (group->domain) {
> +		switch (group->domain->cookie_type) {
> +		case IOMMU_COOKIE_DMA_MSI:
> +		case IOMMU_COOKIE_DMA_IOVA:
> +			ret = iommu_dma_sw_msi(group->domain, desc, msi_addr);
> +			break;
> +		case IOMMU_COOKIE_IOMMUFD:
> +			ret = iommufd_sw_msi(group->domain, desc, msi_addr);
> +			break;
> +		default:
> +			ret = -EOPNOTSUPP;
> +			break;
> +		}
> +	}
>   	mutex_unlock(&group->mutex);
>   	return ret;
>   }
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index 227514030655..98aecf904902 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -156,7 +156,6 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>   			goto out_abort;
>   		}
>   	}
> -	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
>   
>   	/*
>   	 * Set the coherency mode before we do iopt_table_add_domain() as some
> @@ -252,7 +251,6 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
>   		goto out_abort;
>   	}
>   	hwpt->domain->owner = ops;
> -	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
>   
>   	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
>   		rc = -EINVAL;
> @@ -309,7 +307,6 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
>   		goto out_abort;
>   	}
>   	hwpt->domain->owner = viommu->iommu_dev->ops;
> -	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
>   
>   	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
>   		rc = -EINVAL;
