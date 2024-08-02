Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0261B813
	for <iommu@lists.linux.dev>; Fri,  2 Aug 2024 00:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722559454; cv=none; b=tc/FXuDf6Y8zTVHE5TO6aL9QReukQR1w+dUjnUj+XAxImUiXV4uQ6ItpD15KET9FczrdT+IzTX8rCgCrnyZXcHo7eeZpOm8k7UEMPo1rG0zOtKuD03hL5TbahlLoGJ4UWvO5aT34rwWYgy7hyKEbPHbsSzi6Gh4zkI5oE4cviTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722559454; c=relaxed/simple;
	bh=CTLkbVOUqKRrv5iOskCYfNiSAHa9FW/BJr1Ri128IbE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aC4mLkEqETrbgNPmQeWfFjgB3fg7q5lk2hnEzTVprYvEsUZCuaWKUCuhyJBjal97y5SoC01HWVs71IPVgLBVAhaPSbgFrULuujAQBr6qxkmdviYXFnilPwk/wvXSgiZgFzsMIJz5CssGu8OI0/MQEeAoEBdBjysqqkKU7ICw98A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NWN1+btx; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NWN1+btx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722559452; x=1754095452;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CTLkbVOUqKRrv5iOskCYfNiSAHa9FW/BJr1Ri128IbE=;
  b=NWN1+btx4nvud47guupQc4PHgZTZspwH345blpunJe9kz7KIEHCuw3uq
   nPmmPcmJpgaHzhSzT3v/FU41dKc+bPyNNF+e/mqRWs5DJ0/EvFmVKk5Y1
   7rCmxTm5L3SziQvtfrLjoryzc0MwhW0awuYMTPZTITZ+8Y093h/LoT8gn
   9MgVHwx8QvfK+/l+90wy4wpK6IpFPjEuO5QqvPSfgghZe5I7PdMbZiomM
   73rO4RrHMHMXYV2qQqrqI2D4nUeYNcmqCnxAdHtuVuaHfJ49uWEbyLG5Z
   Lelw7YA7iPa5Etmdu/YqJaX7mXH8V7LNvkhJpq2ubJEQNs33k5y9tsbOM
   w==;
X-CSE-ConnectionGUID: 26Y/eeW7Ta6U1ZG9+rhkUQ==
X-CSE-MsgGUID: AChNA+4jQe662DMwe8PUSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="20691279"
X-IronPort-AV: E=Sophos;i="6.09,256,1716274800"; 
   d="scan'208";a="20691279"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 17:44:07 -0700
X-CSE-ConnectionGUID: 1o1CAHMERJ2xRSaQX2g6yQ==
X-CSE-MsgGUID: rgZtOZ4RRuKJqDytTmuKRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,256,1716274800"; 
   d="scan'208";a="86159512"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.238.251]) ([10.124.238.251])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2024 17:44:05 -0700
Message-ID: <8e531f39-9d14-4d3b-8a52-c2e8ca026f9e@linux.intel.com>
Date: Fri, 2 Aug 2024 08:44:02 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com, jgg@ziepe.ca,
 yi.l.liu@intel.com
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
References: <20240801144523.11803-1-vasant.hegde@amd.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240801144523.11803-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/1 22:45, Vasant Hegde wrote:
> Currently domain_alloc_paging() passes device as param for domain
> allocation. While this is sufficient for some HW vendor, its not
> sufficent for others.
> 
> AMD IOMMU has two different page tables (v1 and v2). For DMA API mode it
> wants to allocate page table based on device capability. V2 for PASID
> capable device and v1 for rest of the devices. For UNMANAGED domain, it
> wants to continue to enforce v1 page table as its cache efficient. Hence
> include 'domain type' as parameter to domain_alloc_paging().
> 
> While at it also add 'flag' as additional parameter. So that any page
> table specific quirks (like IO_PGTABLE_QUIRK_*) can be passed to vendor
> driver. Once we have this we can remove ops->set_pgtable_quirks()
> interface.
> 
> Note:
>    Intent of this patch is to discuss/finalize the domain_alloc_paging()
>    ops. Once we agree on interfaces I will fix other drivers and send proper
>    patch series. That means with vendor driver config this doesn't
>    compile.
> 
> @Robin,
>    Once we have this patch and Baolu's series [1], we can enhance
>    iommu_paging_domain_alloc() to include page table quirks and then we can
>    remove ops->set_pgtable_quirks(). I hope this works for ARM driver
>    (arm/arm-smmu/arm-smmu.c).
> 
> RFC v1 : https://lore.kernel.org/linux-iommu/7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com/
> 
> Thanks everyone for looking into RFC patch and giving valuable suggestions.
> 
> [1] https://lore.kernel.org/linux-iommu/20240610085555.88197-2-baolu.lu@linux.intel.com/

That patch has been merged for v6.11-rc1.

> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>   drivers/iommu/amd/iommu.c | 26 ++++++++++++++++++++++++++
>   drivers/iommu/iommu.c     |  2 +-
>   include/linux/iommu.h     |  3 ++-
>   3 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index b19e8c0f48fa..240cca8bed21 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2429,6 +2429,31 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned int type)
>   	return domain;
>   }
>   
> +static struct iommu_domain *amd_iommu_domain_alloc_paging(struct device *dev, u32 type, u32 flags)
> +{
> +	struct iommu_dev_data *dev_data;
> +	int pgtable = amd_iommu_pgtable;
> +
> +	if (dev)
> +		dev_data = dev_iommu_priv_get(dev);
> +
> +	/*
> +	 * - Force V1 page table for UNMANAGED domain.
> +	 * - Use V2 page table for PASID capable device except when :
> +	 *   - SNP is enabled, because it prohibits DTE[Mode]=0
> +	 *   - amd_iommu=pgtbl_v[1/2] kernel command line is passed
> +	 */
> +	if (type == IOMMU_DOMAIN_UNMANAGED) {
> +		pgtable = AMD_IOMMU_V1;
> +	} else if (dev && dev_is_pci(dev) && pdev_pasid_supported(dev_data) &&
> +		   !amd_iommu_force_isolation && !amd_iommu_snp_en) {
> +		pgtable = AMD_IOMMU_V2;
> +	}
> +
> +	/* TODO: Pass pgtable as param */
> +	return do_iommu_domain_alloc(IOMMU_DOMAIN_DMA, dev, 0);
> +}
> +
>   static struct iommu_domain *
>   amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
>   			    struct iommu_domain *parent,
> @@ -2860,6 +2885,7 @@ static int amd_iommu_dev_disable_feature(struct device *dev,
>   const struct iommu_ops amd_iommu_ops = {
>   	.capable = amd_iommu_capable,
>   	.domain_alloc = amd_iommu_domain_alloc,
> +	.domain_alloc_paging = amd_iommu_domain_alloc_paging,
>   	.domain_alloc_user = amd_iommu_domain_alloc_user,
>   	.domain_alloc_sva = amd_iommu_domain_alloc_sva,
>   	.probe_device = amd_iommu_probe_device,
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index ed6c5cb60c5a..d8a67b39a4cb 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1946,7 +1946,7 @@ static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
>   	else if (alloc_type == IOMMU_DOMAIN_BLOCKED && ops->blocked_domain)
>   		return ops->blocked_domain;
>   	else if (type & __IOMMU_DOMAIN_PAGING && ops->domain_alloc_paging)
> -		domain = ops->domain_alloc_paging(dev);
> +		domain = ops->domain_alloc_paging(dev, type, 0);
>   	else if (ops->domain_alloc)
>   		domain = ops->domain_alloc(alloc_type);
>   	else
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 4d47f2c33311..72383f6bdd9f 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -565,7 +565,8 @@ struct iommu_ops {
>   	struct iommu_domain *(*domain_alloc_user)(
>   		struct device *dev, u32 flags, struct iommu_domain *parent,
>   		const struct iommu_user_data *user_data);
> -	struct iommu_domain *(*domain_alloc_paging)(struct device *dev);
> +	struct iommu_domain *(*domain_alloc_paging)(struct device *dev,
> +						    u32 iommu_domain_type, u32 flags);

I still can't see a value to pass the domain type in this callback.
Different domain could have different domain allocation callback, hence
the domain type has already been implied.

For the paging domain, there should be no difference between DMA and
UNMNANAGED from iommu driver's point of view.

>   	struct iommu_domain *(*domain_alloc_sva)(struct device *dev,
>   						 struct mm_struct *mm);
>   

Thanks,
baolu
