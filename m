Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D553A1DA
	for <iommu@lists.linux.dev>; Thu,  1 Aug 2024 16:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530577; cv=none; b=R4d3KDLgiwsdWpC96zbB/STOb2YkrlNMGhHFOtKGy4UYGY5se6dLZPqauYse8wYi9y27Ev60B89EA50yfl8DFJ8avlYQlaq1jvPc2d/oKljEvJhC89bQdTfF/caKWq7QucLn/wGaqoKNvWOlUcIqKvpRzdBNNsLOX7jL0dfW00k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530577; c=relaxed/simple;
	bh=Mq/r6yWF9nhwO1MHUfoDU2pzEZ7xg/BqW/xHQR5wfNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PW7Y0SqqmfmWr2ckZ0DtXztTmeQG5pAzLi8DUVB8+BrGww8aAr0M3xkzMqCk3LfPZUf1LjgA5ApQJtHyLgIM5lT3L3BgYBDLpHgFwRNXHvIYkDM5kllAm8b+MaxoZcgSstrxRnVJtb7+Oei+kzXfaSspTA7vQo+8YyCASp5N7Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B0D715A1;
	Thu,  1 Aug 2024 09:43:20 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E8043F5A1;
	Thu,  1 Aug 2024 09:42:53 -0700 (PDT)
Message-ID: <6cb4e7db-4ac0-43b4-a823-7d230ff3438b@arm.com>
Date: Thu, 1 Aug 2024 17:42:52 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] include: linux: Update gather only if it's not
 NULL
To: Ashish Mhetre <amhetre@nvidia.com>, will@kernel.org, joro@8bytes.org
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20240801033432.106837-1-amhetre@nvidia.com>
 <20240801033432.106837-2-amhetre@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240801033432.106837-2-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/08/2024 4:34 am, Ashish Mhetre wrote:
> Gather can be NULL when unmap is called for freeing old table while
> mapping. If it's NULL then there is no need to add page for syncing
> the TLB.

But that's only because __arm_lpae_unmap() is now choosing to 
over-invalidate the table entries for simplicity. I think it would make 
more sense to handle that at the callsite, e.g. "if (gather && 
!iommu_iotlb_gather_queued(gather))".

Also doesn't this mean that bisection is broken as-is since patch #1 on 
its own is going to blow up dereferencing NULL->pgsize when it gets here?

Thanks,
Robin.

> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>   include/linux/iommu.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 4d47f2c33311..2a28c1ef8517 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -928,6 +928,9 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
>   					       struct iommu_iotlb_gather *gather,
>   					       unsigned long iova, size_t size)
>   {
> +	if (!gather)
> +		return;
> +
>   	/*
>   	 * If the new page is disjoint from the current range or is mapped at
>   	 * a different granularity, then sync the TLB so that the gather
