Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF69320A33;
	Mon, 22 Dec 2025 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766415958; cv=none; b=Nhv9vucxWB7W/CmwVKykK03sE5hzbT8S7vc6Lt6EdjRk/GhEf4yuZNc+3V+O/BMD+ez5+rF0VsuLlfL7ZgJ6FAuTGrcUnh3JyHEnqB0s8J22tgHofAr4x9pMUa0cPqP7TZ0sLWGnA7aeMip+HHOYmp1staoiKnlhVdvdU8qnaf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766415958; c=relaxed/simple;
	bh=vjmnSr1yyf7nBn0QHxXYcZPNqNC9Tbr4qqi5nU8+96E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkdSy6EAhwSgaAhcht9rbSWzv9qSFY55zta4l31EHMaYCLxbScS9Rh670tSsouJZR6CwbiyIDGNxl1jdZMC+NK/JuH4mQK5JyXEHfbNkwuKDwzpyn1pTuFRZyCz6LrGaBIQT0hZeT5MXKBoU6byIqJhZiGv3Z0rUYuJZx8h5O2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18212497;
	Mon, 22 Dec 2025 07:05:48 -0800 (PST)
Received: from [10.57.78.114] (unknown [10.57.78.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85E243F694;
	Mon, 22 Dec 2025 07:05:52 -0800 (PST)
Message-ID: <5820e8f3-9cf8-423f-89df-0df7ca78a84b@arm.com>
Date: Mon, 22 Dec 2025 15:05:50 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] dma: direct: set decrypted flag for remapped dma
 allocations
Content-Language: en-GB
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-coco@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
 maz@kernel.org, tglx@linutronix.de, robin.murphy@arm.com,
 akpm@linux-foundation.org, jgg@ziepe.ca, steven.price@arm.com
References: <20251221160920.297689-1-aneesh.kumar@kernel.org>
 <20251221160920.297689-5-aneesh.kumar@kernel.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20251221160920.297689-5-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/12/2025 16:09, Aneesh Kumar K.V (Arm) wrote:
> Devices that are DMA non-coherent and need a remap were skipping
> dma_set_decrypted(), leaving buffers encrypted even when the device
> requires unencrypted access. Move the call after the remap
> branch so both paths mark the allocation decrypted (or fail cleanly)
> before use.
> 
> Fixes: f3c962226dbe ("dma-direct: clean up the remapping checks in dma_direct_alloc")
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>   kernel/dma/direct.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 3448d877c7c6..a62dc25524cc 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -271,9 +271,6 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   	if (remap) {
>   		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
>   
> -		if (force_dma_unencrypted(dev))
> -			prot = pgprot_decrypted(prot);

This would be problematic, isn't it ? We don't support decrypted on a
vmap area for arm64. If we move this down, we might actually use the
vmapped area. Not sure if other archs are fine with "decrypting" a
"vmap" address.

If we map the "vmap" address with pgprot_decrypted, we could go ahead
and further map the linear map (i.e., page_address(page)) decrypted
and get everything working.

Suzuki


> -
>   		/* remove any dirty cache lines on the kernel alias */
>   		arch_dma_prep_coherent(page, size);
>   
> @@ -284,10 +281,11 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   			goto out_free_pages;
>   	} else {
>   		ret = page_address(page);
> -		if (dma_set_decrypted(dev, ret, size))
> -			goto out_leak_pages;
>   	}
>   
> +	if (dma_set_decrypted(dev, ret, size))
> +		goto out_leak_pages;
> +
>   	memset(ret, 0, size);
>   
>   	if (set_uncached) {

