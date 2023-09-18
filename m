Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5311D5384
	for <iommu@lists.linux.dev>; Mon, 18 Sep 2023 06:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695017647; x=1726553647;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kUpHOK5IBjbqfbjc9MQ81MuDWUW3Xr1pW4Y/QY8RBCE=;
  b=QbDy/rHBS7N0L08Lb2/NsJoZqLSBaq4wHJ0Sg5zeWPl1G5uoOEbaR1VF
   vcIPenAkmXODF04mWFaQtu93DNqAyQj+8G8EEQJF9Um3AzvL+xVoMJFp9
   2LY+JDH/m0scehIYN1uqjU5srwZWldFeregAMdGkZX8SP05GyntVRPlLg
   MhVeQwaydLlZrx4yDe8bAs9SOMvFZe30JwIqGKHh3FRMknS9x29SgaZdj
   mZWaDJKUW0hQKPHMcdtSNxhLOg42RapEIdC0jftEbD49JjtOyN88qqG/z
   0UMQdrzeglcFfV3m5npXxJmtV3klVGHpNVySwCsSW2XCqBMkHqSgHhTDZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="364618653"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="364618653"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2023 23:14:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="722351024"
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="722351024"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga006.jf.intel.com with ESMTP; 17 Sep 2023 23:14:04 -0700
Message-ID: <e0a7969a-60e3-6b3c-4f74-592654d4407f@linux.intel.com>
Date: Mon, 18 Sep 2023 14:10:58 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 jgg@nvidia.com
Subject: Re: [PATCH v3 4/7] iommu: Switch __iommu_domain_alloc() to device ops
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1694693889.git.robin.murphy@arm.com>
 <404d8395cf4252c6fe6d98f317f3570127451778.1694693889.git.robin.murphy@arm.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <404d8395cf4252c6fe6d98f317f3570127451778.1694693889.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/23 12:58 AM, Robin Murphy wrote:
> @@ -1997,16 +1995,13 @@ void iommu_set_fault_handler(struct iommu_domain *domain,
>   }
>   EXPORT_SYMBOL_GPL(iommu_set_fault_handler);
>   
> -static struct iommu_domain *__iommu_domain_alloc(const struct bus_type *bus,
> +static struct iommu_domain *__iommu_domain_alloc(struct device *dev,
>   						 unsigned type)
>   {
> -	const struct iommu_ops *ops = bus ? bus->iommu_ops : NULL;
> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
>   	struct iommu_domain *domain;
>   	unsigned int alloc_type = type & IOMMU_DOMAIN_ALLOC_FLAGS;
>   
> -	if (!ops)
> -		return NULL;
> -
>   	domain = ops->domain_alloc(alloc_type);
>   	if (!domain)
>   		return NULL;
> @@ -2030,9 +2025,28 @@ static struct iommu_domain *__iommu_domain_alloc(const struct bus_type *bus,
>   	return domain;
>   }
>   
> +static int __iommu_domain_alloc_dev(struct device *dev, void *data)
> +{
> +	struct device **alloc_dev = data;
> +
> +	if (!dev_has_iommu(dev))
> +		return 0;
> +
> +	WARN_ONCE(*alloc_dev && dev_iommu_ops(dev) != dev_iommu_ops(*alloc_dev),
> +		  "Multiple IOMMU drivers present, which the public IOMMU API can't fully support yet. You may still need to disable one or more to get the expected result here, sorry!\n");
> +
> +	*alloc_dev = dev;
> +	return 0;
> +}
> +
>   struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
>   {
> -	return __iommu_domain_alloc(bus, IOMMU_DOMAIN_UNMANAGED);
> +	struct device *dev = NULL;
> +
> +	if (bus_for_each_dev(bus, NULL, &dev, __iommu_domain_alloc_dev))
> +		return NULL;

__iommu_domain_alloc_dev() always returns 0. Hence above if condition
will never be true. Perhaps, in __iommu_domain_alloc_dev(),

	if (WARN_ON(*alloc_dev && dev_iommu_ops(dev) !=
             dev_iommu_ops(*alloc_dev))
		return -EPERM;

?

> +
> +	return __iommu_domain_alloc(dev, IOMMU_DOMAIN_UNMANAGED);

Is it possible that all devices on this bus have dev_has_iommu() to be
false? If so, we probably need something like below:

	if (!dev_has_iommu(dev))
		return -ENODEV;

?

>   }
>   EXPORT_SYMBOL_GPL(iommu_domain_alloc);
>   
> @@ -3228,13 +3242,17 @@ static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
>   	if (group->blocking_domain)
>   		return 0;
>   
> -	group->blocking_domain = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_BLOCKED);
> +	/* noiommu groups should never be here */
> +	if (WARN_ON(!dev_has_iommu(dev)))
> +		return -ENODEV;
> +
> +	group->blocking_domain = __iommu_domain_alloc(dev, IOMMU_DOMAIN_BLOCKED);
>   	if (!group->blocking_domain) {
>   		/*
>   		 * For drivers that do not yet understand IOMMU_DOMAIN_BLOCKED
>   		 * create an empty domain instead.
>   		 */
> -		group->blocking_domain = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_UNMANAGED);
> +		group->blocking_domain = __iommu_domain_alloc(dev, IOMMU_DOMAIN_UNMANAGED);
>   		if (!group->blocking_domain)
>   			return -EINVAL;
>   	}

Best regards,
baolu
