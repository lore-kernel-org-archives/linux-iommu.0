Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A511377
	for <iommu@lists.linux.dev>; Thu, 28 Sep 2023 01:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695865013; x=1727401013;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k2IBvK6ZA6AxFCZCz+4sX+cJsNm9cNzhfSFcC+S7MHU=;
  b=d/r21/wbPO9UdfUBlkPN0nHpUX+xYmk74Y+oGBxJsuYqtkrJjqUAftKO
   6x2zEYUBjhWSv+vUXctf3Tm3RrkRVwz/3yzxzh2qwAom2AcSXkAy59aKf
   yVozz5LFL0fLBkkAjSAhWGgIvqWLf3Srzn3I6b+V3f7w6vlwSyhoTFyxv
   Es4gRm6jdp/dEwKVgrjD6+2PRqb6VOilgli4eYYcrToOtQBgcbQj1nDNZ
   9zVtm7VMM3lufKs19yaa3U2GIJEjSWswnKbpcMHJz9OWpoN/z1iyYy9mk
   OLwo32wmX1CbP8IkCmQXuLfB9oBTEnRfUWCovaF6kAw7zYjO1UUWBIfVW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="379240969"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="379240969"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 18:36:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="778746235"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="778746235"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga008.jf.intel.com with ESMTP; 27 Sep 2023 18:36:44 -0700
Message-ID: <7c7b8981-022c-2fa8-7ee5-9c97d8e17862@linux.intel.com>
Date: Thu, 28 Sep 2023 09:33:29 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: baolu.lu@linux.intel.com, robin.murphy@arm.com, jgg@nvidia.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Sanity check on param list for
 iommu_get_resv_regions
Content-Language: en-US
To: Dawei Li <set_pte_at@outlook.com>, joro@8bytes.org, will@kernel.org
References: <TYTP286MB35645FDEF45FDFC91D35CE1ECAC2A@TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <TYTP286MB35645FDEF45FDFC91D35CE1ECAC2A@TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/23 10:25 PM, Dawei Li wrote:
> In iommu_get_resv_regions(), param list is an argument supplied by caller,
> into which callee is supposed to insert resv regions.
> 
> In other words, this 'list' argument is expected to be an empty list,
> so make an explicit annotation on it.
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
>   drivers/iommu/iommu.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 1ecac2b5c54f..a01c4a7a9d19 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -813,7 +813,7 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
>   
>   	mutex_lock(&group->mutex);
>   	for_each_group_device(group, device) {
> -		struct list_head dev_resv_regions;
> +		LIST_HEAD(dev_resv_regions);
>   
>   		/*
>   		 * Non-API groups still expose reserved_regions in sysfs,
> @@ -822,7 +822,6 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
>   		if (!device->dev->iommu)
>   			break;
>   
> -		INIT_LIST_HEAD(&dev_resv_regions);
>   		iommu_get_resv_regions(device->dev, &dev_resv_regions);
>   		ret = iommu_insert_device_resv_regions(&dev_resv_regions, head);
>   		iommu_put_resv_regions(device->dev, &dev_resv_regions);
> @@ -1061,12 +1060,11 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
>   					       struct device *dev)
>   {
>   	struct iommu_resv_region *entry;
> -	struct list_head mappings;
>   	unsigned long pg_size;
> +	LIST_HEAD(mappings);
>   	int ret = 0;
>   
>   	pg_size = domain->pgsize_bitmap ? 1UL << __ffs(domain->pgsize_bitmap) : 0;
> -	INIT_LIST_HEAD(&mappings);
>   
>   	if (WARN_ON_ONCE(iommu_is_dma_domain(domain) && !pg_size))
>   		return -EINVAL;
> @@ -2813,6 +2811,9 @@ void iommu_get_resv_regions(struct device *dev, struct list_head *list)
>   {
>   	const struct iommu_ops *ops = dev_iommu_ops(dev);
>   
> +	if (WARN_ON(!list_empty(list)))
> +		return;

I don't understand why the input list *must* be empty. This interface
has already been exported, so please update the comment to explain this
new requirement.

> +
>   	if (ops->get_resv_regions)
>   		ops->get_resv_regions(dev, list);
>   }

Best regards,
baolu
