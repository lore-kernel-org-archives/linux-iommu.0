Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AF21607B8
	for <iommu@lists.linux.dev>; Thu,  1 Aug 2024 09:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722506343; cv=none; b=AVt3AE4ZpVw8kFziGk2gHuZZsPzzOwtpl+hY0jnyMTTCFxXSVMhlsKqFBd44DpJv4i9B+Cs+JfANcLtzhaXpyPkOljmuQBgx0xxVORIjOtG46nLnumE9Y+AO+UoczozPpJdDEamp5x/FeWAmct2zbw9HMzD0Tl4DMD/unnu+Yfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722506343; c=relaxed/simple;
	bh=Sf4B9iPWqNBr9f2HRAVNmZc4Oddag2qnh9tdTQvNRVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hR9R4whSM+HyVj8DqdRHdPTdAoXZMh4cIqmHK7hKz54a0hJ3JGmfDFfHRhpaLMqH9x1/q0r17+FI/nOmzLs09nGpv6y7qd91gs0iggnprODAJs3hK41+h/yPzpupKDfRmxdHOtajgK3nrIXBesli/Hvt8/y2DT0WWio9Ry0L9i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20CDE1007;
	Thu,  1 Aug 2024 02:59:27 -0700 (PDT)
Received: from [10.57.48.123] (unknown [10.57.48.123])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88E443F5A1;
	Thu,  1 Aug 2024 02:59:00 -0700 (PDT)
Message-ID: <c9e7107e-f1fd-4a22-be6d-45eef392f76b@arm.com>
Date: Thu, 1 Aug 2024 10:58:52 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Use of_property_present()
To: "Rob Herring (Arm)" <robh@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240731191312.1710417-6-robh@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240731191312.1710417-6-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-07-31 8:12 pm, Rob Herring (Arm) wrote:
> Use of_property_present() to test for property presence rather than
> of_(find|get)_property(). This is part of a larger effort to remove
> callers of of_find_property() and similar functions. of_find_property()
> leaks the DT struct property and data pointers which is a problem for
> dynamically allocated nodes which may be freed.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>   drivers/iommu/fsl_pamu_domain.c | 4 +---
>   drivers/iommu/of_iommu.c        | 2 +-
>   2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
> index e9d2bff4659b..30be786bff11 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c
> @@ -416,14 +416,12 @@ static struct iommu_group *fsl_pamu_device_group(struct device *dev)
>   
>   static struct iommu_device *fsl_pamu_probe_device(struct device *dev)
>   {
> -	int len;
> -
>   	/*
>   	 * uboot must fill the fsl,liodn for platform devices to be supported by
>   	 * the iommu.
>   	 */
>   	if (!dev_is_pci(dev) &&
> -	    !of_get_property(dev->of_node, "fsl,liodn", &len))
> +	    !of_property_present(dev->of_node, "fsl,liodn"))
>   		return ERR_PTR(-ENODEV);
>   
>   	return &pamu_iommu;
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 78d61da75257..e7a6a1611d19 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -214,7 +214,7 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
>   		 * that represent reservations in the IOVA space, which are regions that should
>   		 * not be mapped.
>   		 */
> -		if (of_find_property(it.node, "reg", NULL)) {
> +		if (of_property_present(it.node, "reg")) {
>   			err = of_address_to_resource(it.node, 0, &phys);
>   			if (err < 0) {
>   				dev_err(dev, "failed to parse memory region %pOF: %d\n",
