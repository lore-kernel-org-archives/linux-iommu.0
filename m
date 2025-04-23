Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C65828F930
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745437095; cv=none; b=UEFZPnCANrnm5e0UvQfHIfEJp5xDnvNTHb5Gyook7VJizT9TFNIib+b+5iKsAOF1kt9JpNlAqRTdlP8tP9K3aHQt+tcafAL5BepgCeu5v2d9lQAt6Ib0bVVs5OQi1kc89OE86nI053YfnRg97Q1I75JpqDzuqdcgyoCI7/myxH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745437095; c=relaxed/simple;
	bh=ZMAy0koe8QRjR90kEa0BTwUcnx789qVMbwmNTlSN4N4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxInCCiz1yDaKqHEeBwc3e433LYXHq+2tBkDh375as0i+Am6W9danU8l8dU2H40xf9mA1jEOe6d6jZgnm7bGJcj5aA5+XwqqPmIjF87Kx+oNT+rXsqX2ET8at8kF1nTu8zSl58mp1mcoT/jjr3Z5nX2FbGn85YGTYOryDYO9Kkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4BA12B;
	Wed, 23 Apr 2025 12:38:07 -0700 (PDT)
Received: from [10.57.74.63] (unknown [10.57.74.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D79F83F5A1;
	Wed, 23 Apr 2025 12:38:10 -0700 (PDT)
Message-ID: <3c7cdc09-272f-4226-851c-dfc50777f2dc@arm.com>
Date: Wed, 23 Apr 2025 20:38:08 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iommu: Allow attaching static domains in
 iommu_attach_device_pasid()
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, shangsong2@lenovo.com,
 Dave Jiang <dave.jiang@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250423021839.2189204-1-baolu.lu@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250423021839.2189204-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-04-23 3:18 am, Lu Baolu wrote:
> The idxd driver attaches the default domain to a PASID of the device to
> perform kernel DMA using that PASID. The domain is attached to the
> device's PASID through iommu_attach_device_pasid(), which checks if the
> domain->owner matches the iommu_ops retrieved from the device. If they
> do not match, it returns a failure.
> 
>          if (ops != domain->owner || pasid == IOMMU_NO_PASID)
>                  return -EINVAL;
> 
> The static identity domain implemented by the intel iommu driver doesn't
> specify the domain owner. Therefore, kernel DMA with PASID doesn't work
> for the idxd driver if the device translation mode is set to passthrough.
> 
> Generally the owner field of static domains are not set because they are
> already part of iommu ops. Add a helper domain_iommu_ops_compatible()
> that checks if a domain is compatible with the device's iommu ops. This
> helper explicitly allows the static blocked and identity domains associated
> with the device's iommu_ops to be considered compatible.

With the other domain->owner checks also wrapped as Jason pointed out 
(since it would be weird but not impossible for static domains to get 
into those paths as well),

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Fixes: 2031c469f816 ("iommu/vt-d: Add support for static identity domain")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220031
> Cc: stable@vger.kernel.org
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Link: https://lore.kernel.org/linux-iommu/20250422191554.GC1213339@ziepe.ca/
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/iommu.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> Change log:
> -v2:
>   - Make the solution generic for all static domains as suggested by
>     Jason.
> -v1: https://lore.kernel.org/linux-iommu/20250422075422.2084548-1-baolu.lu@linux.intel.com/
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 4f91a740c15f..abda40ec377a 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3402,6 +3402,19 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
>   		iommu_remove_dev_pasid(device->dev, pasid, domain);
>   }
>   
> +static bool domain_iommu_ops_compatible(const struct iommu_ops *ops,
> +					struct iommu_domain *domain)
> +{
> +	if (domain->owner == ops)
> +		return true;
> +
> +	/* For static domains, owner isn't set. */
> +	if (domain == ops->blocked_domain || domain == ops->identity_domain)
> +		return true;
> +
> +	return false;
> +}
> +
>   /*
>    * iommu_attach_device_pasid() - Attach a domain to pasid of device
>    * @domain: the iommu domain.
> @@ -3435,7 +3448,8 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>   	    !ops->blocked_domain->ops->set_dev_pasid)
>   		return -EOPNOTSUPP;
>   
> -	if (ops != domain->owner || pasid == IOMMU_NO_PASID)
> +	if (!domain_iommu_ops_compatible(ops, domain) ||
> +	    pasid == IOMMU_NO_PASID)
>   		return -EINVAL;
>   
>   	mutex_lock(&group->mutex);

