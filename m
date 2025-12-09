Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDD72EA490
	for <iommu@lists.linux.dev>; Tue,  9 Dec 2025 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765280643; cv=none; b=Ho6S9Q4hxkHUqWmntD32vU3fWTLycgJfkO8Jy25Lx/sdj0YkdGmPktzL/eHUsJ0ZJ8xLcFCiOxGtEqQ007jIoWv+RFpOEOX5tjbeyCeCX0fbOopRhQ4zB4pxH1A2u3Y3CbfS0z1W0G8zQkM8BXEodxCRsnSP5Ey1+5iU2lBCQ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765280643; c=relaxed/simple;
	bh=K+CbSWvOIPB4pqgGaG5NwofgUgluGHSM87vC6Aq9USM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhmbxJ60br4Nsj9IQKGcHPcp1PuomjYHC4zPGYgREaDWgT38merzpsfarHEoftwL5zIQQaikc7taaYMvbKYVWyGfVS1I96BR15T41X9d7CFui0hsOnyNzopVjz0l2bw7UWpSlCofjp8NyUtdLjizLjqResFPMOZikw722RW2+XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1583A1691;
	Tue,  9 Dec 2025 03:43:52 -0800 (PST)
Received: from [10.57.46.210] (unknown [10.57.46.210])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D19653F762;
	Tue,  9 Dec 2025 03:43:57 -0800 (PST)
Message-ID: <e22ea775-84e3-4116-a81a-52031be9f176@arm.com>
Date: Tue, 9 Dec 2025 11:43:55 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/rockchip: Check of_find_device_by_node() return
 value
To: Haotian Zhang <vulab@iscas.ac.cn>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251209113333.1086-1-vulab@iscas.ac.cn>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20251209113333.1086-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-12-09 11:33 am, Haotian Zhang wrote:
> rk_iommu_of_xlate() calls of_find_device_by_node() without
> verifying it is non-NULL, which can lead to a NULL pointer
> dereference and crash.

No, it can't. Please look at how of_xlate is called - at this point we 
are looking up the IOMMU device, which has a driver bound to it, which 
has registered ops against this of_node that are the only way to reach 
this function in the first place. If the device could have somehow 
disappeared from underneath an active driver, this potential crash is 
the least of the kernel's worries...

Thanks,
Robin.

> Add a check for a NULL return from of_find_device_by_node()
> and return -ENODEV upon failure.
> 
> Fixes: 5fd577c3eac3 ("iommu/rockchip: Use OF_IOMMU to attach devices automatically")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>   drivers/iommu/rockchip-iommu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 0861dd469bd8..e59d0617574b 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -1153,6 +1153,8 @@ static int rk_iommu_of_xlate(struct device *dev,
>   	struct rk_iommudata *data;
>   
>   	iommu_dev = of_find_device_by_node(args->np);
> +	if (!iommu_dev)
> +		return -ENODEV;
>   
>   	data = devm_kzalloc(&iommu_dev->dev, sizeof(*data), GFP_KERNEL);
>   	if (!data)

