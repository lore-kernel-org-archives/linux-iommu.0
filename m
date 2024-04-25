Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC681CD23
	for <iommu@lists.linux.dev>; Thu, 25 Apr 2024 10:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714041359; cv=none; b=VjusfcYhdEylykoo+VslhXjWVaf/6seBmNH6NpVbBlbzCCznQzI+40/g8mkoZpddc/gAnWbm4Sqx6CuYEg+qLo8any4iPdezQQcLXbI2HUr5zUpiYz3YVYFVooZrJk61JScHnTm+Uu07WwPTee9RqWykofUIEJG8y+IPNa9h1dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714041359; c=relaxed/simple;
	bh=q6lkpKJMorSwTo+NLAoNtokuFO5no9PMJ4oQa8UkFUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GGBhgvDcWzQdV4MkI8loKWIIp8cdxb1SLoaTjALONR8ZndTvTiIslY4yC/8r5L2ndTRk//zI1UZHJyQufIv765PJCVAPzL2EKvVaZ61M8jKxqYX6E6+9gruEKFmVdB+OcenmaCTGQeRP8d3SP+3oOy0BwammsQvAeCr3wW2ErqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C87EE1007;
	Thu, 25 Apr 2024 03:36:23 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91E6E3F64C;
	Thu, 25 Apr 2024 03:35:54 -0700 (PDT)
Message-ID: <473f2b61-9015-481a-b231-b642f6c7be41@arm.com>
Date: Thu, 25 Apr 2024 11:35:53 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/rockchip: Add missing check for
 of_find_device_by_node
To: Chen Ni <nichen@iscas.ac.cn>, joro@8bytes.org, will@kernel.org,
 heiko@sntech.de, jeffy.chen@rock-chips.com
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240425091813.965003-1-nichen@iscas.ac.cn>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240425091813.965003-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/04/2024 10:18 am, Chen Ni wrote:
> Add check for the return value of of_find_device_by_node() and return
> the error if it fails in order to avoid NULL pointer dereference.

How would it return NULL?

Or to put it another way, if a device has somehow vanished without 
unbinding its driver or unregistering the iommu_ops through which this 
is called, then the kernel state is clearly so broken that crashing is 
probably the safest thing to do. Furthermore if we couldn't assume we 
have the right device here then we also couldn't assume that its drvdata 
points to the right thing either, so we'd be rather stuck.

Thanks,
Robin.

> Fixes: 5fd577c3eac3 ("iommu/rockchip: Use OF_IOMMU to attach devices automatically")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>   drivers/iommu/rockchip-iommu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 4b369419b32c..1225c1df6ef6 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -1152,6 +1152,8 @@ static int rk_iommu_of_xlate(struct device *dev,
>   		return -ENOMEM;
>   
>   	iommu_dev = of_find_device_by_node(args->np);
> +	if (!iommu_dev)
> +		return -ENODEV;
>   
>   	data->iommu = platform_get_drvdata(iommu_dev);
>   	data->iommu->domain = &rk_identity_domain;
