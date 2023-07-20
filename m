Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A38A5E;
	Thu, 20 Jul 2023 07:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689838779; x=1721374779;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u/CMXF3lu6xbOAoxteln+cW6/SG/tWj+VRYeOVr9Ja0=;
  b=ZvW2dvLSHn+dwmg8PjCIvW6aFlYv6rfDj8kZ3MrMNNvI8F25muOKpVKS
   TvpnlIVMKQCk6F6N3sjHFhVsVjtwU8l+ecJvwNacjKvvEpsPKcSUosOF6
   BHJzny00xNcNBaTJVLPrNVWIpox1CN3M6GBnxDENDaXjhR9hnqBbnGPhb
   LYY/AFdMxpq8WzkujD+YPK2jDhJhDhrzT7TvdaAp4Qy8FD1sFr8E3TO8o
   tN54+CF3+593+gfdoVH1ZLB4l5WRluu2p+vE/UgHyheSPtHUVXwQ+Y/gE
   ycLvARKJLnNwAdNGzZUT9vvjJOCXHWl5ZUviBl7GghhMWaMexeu+feM15
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="365544995"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="365544995"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 00:39:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="1055044515"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="1055044515"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.191.114]) ([10.252.191.114])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 00:39:31 -0700
Message-ID: <32eadc5b-bb39-5bb1-f124-44feead97ce9@linux.intel.com>
Date: Thu, 20 Jul 2023 15:39:27 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 03/10] iommu: Add generic_single_device_group()
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 David Woodhouse <dwmw2@infradead.org>, Heiko Stuebner <heiko@sntech.de>,
 iommu@lists.linux.dev, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Orson Zhai <orsonzhai@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
 Will Deacon <will@kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>
References: <3-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <3-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/7/19 3:05, Jason Gunthorpe wrote:
> This implements the common pattern seen in drivers of a single
> iommu_group for the entire iommu driver. Implement this in core code
> so the drivers that want this can select it from their ops.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 25 +++++++++++++++++++++++++
>   include/linux/iommu.h |  3 +++
>   2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 9e41ad4e3219b6..1e0c5d9a0370fb 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -289,6 +289,9 @@ void iommu_device_unregister(struct iommu_device *iommu)
>   	spin_lock(&iommu_device_lock);
>   	list_del(&iommu->list);
>   	spin_unlock(&iommu_device_lock);
> +
> +	/* Pairs with the alloc in generic_single_device_group() */
> +	iommu_group_put(iommu->singleton_group);
>   }
>   EXPORT_SYMBOL_GPL(iommu_device_unregister);
>   
> @@ -1595,6 +1598,28 @@ struct iommu_group *generic_device_group(struct device *dev)
>   }
>   EXPORT_SYMBOL_GPL(generic_device_group);
>   
> +/*
> + * Generic device_group call-back function. It just allocates one
> + * iommu-group per iommu driver.
> + */
> +struct iommu_group *generic_single_device_group(struct device *dev)
> +{
> +	struct iommu_device *iommu = dev->iommu->iommu_dev;
> +
> +	lockdep_assert_held(&dev_iommu_group_lock);
> +
> +	if (!iommu->singleton_group) {
> +		struct iommu_group *group;
> +
> +		group = iommu_group_alloc();
> +		if (IS_ERR(group))
> +			return group;
> +		iommu->singleton_group = group;
> +	}
> +	return iommu_group_ref_get(iommu->singleton_group);
> +}
> +EXPORT_SYMBOL_GPL(generic_single_device_group);

When allocating the singleton group for the first time, the group's
refcount is taken twice. This can cause memory leaks even after calling
iommu_device_unregister(). Perhaps it can be adjusted as follows?

struct iommu_group *generic_single_device_group(struct device *dev)
{
         struct iommu_device *iommu = dev->iommu->iommu_dev;
         struct iommu_group *group;

         lockdep_assert_held(&dev_iommu_group_lock);

         if (iommu->singleton_group)
                 return iommu_group_ref_get(iommu->singleton_group);

         group = iommu_group_alloc();
         if (!IS_ERR(group))
                 iommu->singleton_group = group;

         return group;
}

> +
>   /*
>    * Use standard PCI bus topology, isolation features, and DMA alias quirks
>    * to find or create an IOMMU group for a device.
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index b1dcb1b9b17040..f1e18e81fca78b 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -361,6 +361,7 @@ struct iommu_domain_ops {
>    * @list: Used by the iommu-core to keep a list of registered iommus
>    * @ops: iommu-ops for talking to this iommu
>    * @dev: struct device for sysfs handling
> + * @singleton_group: Used internally for drivers that have only one group
>    * @max_pasids: number of supported PASIDs
>    */
>   struct iommu_device {
> @@ -368,6 +369,7 @@ struct iommu_device {
>   	const struct iommu_ops *ops;
>   	struct fwnode_handle *fwnode;
>   	struct device *dev;
> +	struct iommu_group *singleton_group;
>   	u32 max_pasids;
>   };
>   
> @@ -640,6 +642,7 @@ extern struct iommu_group *pci_device_group(struct device *dev);
>   extern struct iommu_group *generic_device_group(struct device *dev);
>   /* FSL-MC device grouping function */
>   struct iommu_group *fsl_mc_device_group(struct device *dev);
> +extern struct iommu_group *generic_single_device_group(struct device *dev);

"extern" is not necessary.

>   
>   /**
>    * struct iommu_fwspec - per-device IOMMU instance data

Best regards,
baolu
