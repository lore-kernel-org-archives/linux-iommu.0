Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3817FBA2
	for <iommu@lists.linux.dev>; Tue, 23 Apr 2024 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871568; cv=none; b=FNgC0IN0GES1VXlIGmBqmIrpCpl+xvNA+hexqUjOrmAwpQIMBTP2RtJGurOIosrbiNQGeWZXypG8Oi5GaPc3VgDHOE7aoTjZxrwzVdIOnz5G8Jd2yEZeGyPXuJfKTzgxwIcA3ZLI4NkBag+V+Zd1VxSnggWOrtyY0jWyHGWJQQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871568; c=relaxed/simple;
	bh=iwmEpvYuT2BnKvTgE+n8rkL1jozO+gKv3woLsWt/N7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BoCH9RTQo1l8WQddXY+m8SCqoRB6Dn7Dr/oebatm+NMbj8ZeohLHL2+eYu1OzlVODwBlL8f5rsRaUuQobkK1op1PgyntgItVg1kgsipMd1LJb6ZgJ4MOY+NLkj7r8G4/Glp711BhN2XBB1KLfjgBAIjMuoq0D2NrBN1Xp3GSbRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD1ED339;
	Tue, 23 Apr 2024 04:26:33 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0D3B3F7BD;
	Tue, 23 Apr 2024 04:26:04 -0700 (PDT)
Message-ID: <6552a5bb-0481-4a0c-a587-84275ab3a179@arm.com>
Date: Tue, 23 Apr 2024 12:26:03 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/amd: Enhance def_domain_type to handle untrusted
 device
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com, alexander.deucher@amd.com,
 baolu.lu@linux.intel.com, Eric Wagner <ewagner12@gmail.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, stable@kernel.org
References: <20240423111725.5813-1-vasant.hegde@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240423111725.5813-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/04/2024 12:17 pm, Vasant Hegde wrote:
> Previously, IOMMU core layer was forcing IOMMU_DOMAIN_DMA domain for
> untrusted device. This always took precedence over driver's
> def_domain_type(). Commit 59ddce4418da ("iommu: Reorganize
> iommu_get_default_domain_type() to respect def_domain_type()") changed
> the behaviour. Current code calls def_domain_type() but if it doesn't
> return IOMMU_DOMAIN_DMA for untrusted device it throws error. This
> results in IOMMU group (and potentially IOMMU itself) in undetermined
> state.
> 
> This patch adds untrusted check in AMD IOMMU driver code. So that it
> allows eGPUs behind Thunderbolt work again.

Sorry, but I firmly disagree with this approach - regardless of what the 
AMD driver is currently doing and how appropriate it may or may not be, 
we should not be duplicating core code policy in drivers, and we 
certainly shouldn't be doing so to bodge around a breakage in how the 
core code implements said policy.

Thanks,
Robin.

> Fine tuning amd_iommu_def_domain_type() will be done later.
> 
> Reported-by: Eric Wagner <ewagner12@gmail.com>
> Link: https://lore.kernel.org/linux-iommu/CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3182
> Fixes: 59ddce4418da ("iommu: Reorganize iommu_get_default_domain_type() to respect def_domain_type()")
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: stable@kernel.org # v6.7+
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
> Changes in v2:
>    - Added dev_is_pci() check - Thanks Lu Baolu
> 
> -Vasant
> 
>   drivers/iommu/amd/iommu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index e692217fcb28..fb727f5b0b82 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2754,6 +2754,10 @@ static int amd_iommu_def_domain_type(struct device *dev)
>   	if (!dev_data)
>   		return 0;
>   
> +	/* Always use DMA domain for untrusted device */
> +	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
> +		return IOMMU_DOMAIN_DMA;
> +
>   	/*
>   	 * Do not identity map IOMMUv2 capable devices when:
>   	 *  - memory encryption is active, because some of those devices
