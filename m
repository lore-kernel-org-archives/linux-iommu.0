Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566111E884B
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 11:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729511941; cv=none; b=s1/Hmu7dYD0F/vsuT7cGmVNoqPmLGFtJw7nSqcu0zH7WH6hMJ7nOzUZ0rdOiplj2cwGlzWezbgvgJIZieaQxCGfBK2CAZlP3zUO+XpSQ+Ym1tZAT4c0sk9I6wXkSBTtV+DeGn0eJONPU2Hg4VQV3T1z/wNNQEMZkeBogXMbE3YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729511941; c=relaxed/simple;
	bh=oVLyn9xJoNtOHftizsogJhdFwXJKLvSl/bkma+E9FXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=trcAh99Mw9o/fNKglapKcjZhJKW+gUoW9FLHSzxML1uEPAVSJxRk79JAYwgUWzUCyQGacqdl0SH8ifdhdSGp8b66H4PMEdy35q/wtmjzDgRW49vKgPxAzukHX1AuhmairsoNox33whJnkErhlC6VhmdvbWR/I647XJ1n1gCocEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EBEADA7;
	Mon, 21 Oct 2024 04:59:28 -0700 (PDT)
Received: from [10.57.88.139] (unknown [10.57.88.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9C343F528;
	Mon, 21 Oct 2024 04:58:57 -0700 (PDT)
Message-ID: <a25451b8-b898-4354-acd3-2826a340f9fe@arm.com>
Date: Mon, 21 Oct 2024 12:58:55 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Distinguish between sw-msi and msi
To: Angus Chen <angus.chen@jaguarmicro.com>, joro@8bytes.org, will@kernel.org
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20241021113448.1894-1-angus.chen@jaguarmicro.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241021113448.1894-1-angus.chen@jaguarmicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-21 12:34 pm, Angus Chen wrote:
> iommu_group_resv_type_string use the same string of IOMMU_RESV_MSI
> and IOMMU_RESV_SW_MSI, Make a distinction for these.

Why? What in userspace needs to know the exact details of how the kernel 
and the underlying hardware are routing MSIs?

Thanks,
Robin.

> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> ---
>   drivers/iommu/iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 83c8e617a2c5..8a2bbb5c4a91 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -84,7 +84,7 @@ static const char * const iommu_group_resv_type_string[] = {
>   	[IOMMU_RESV_DIRECT_RELAXABLE]		= "direct-relaxable",
>   	[IOMMU_RESV_RESERVED]			= "reserved",
>   	[IOMMU_RESV_MSI]			= "msi",
> -	[IOMMU_RESV_SW_MSI]			= "msi",
> +	[IOMMU_RESV_SW_MSI]			= "sw-msi",
>   };
>   
>   #define IOMMU_CMD_LINE_DMA_API		BIT(0)

