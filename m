Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0ED48B38D
	for <iommu@lists.linux.dev>; Wed,  1 Jul 2026 12:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909373; cv=none; b=JjeRCn47CjPXByUFSsDkQPe3pZo7lGG0p/piaKJBC+RodiGcwkKFKOCC3kWe4rvdKipG9XhGU8CPWyrqvO1S3f+i6UhH02UT/aXdGm4gfJvIyfgAu9cKj8Vt/e0Q1Nbx5J+gi10zlEjIgujlcYNXQS+XAEudWkMPx85+o4a7npM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909373; c=relaxed/simple;
	bh=HUBVX/IKPKUaeetXR7Ho4UIgMYtPe7qBv118DqwksrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qXJ6IXamKAJXk+4FcZMVX9jbi1uJ0I8T7Hjzecw+oqOD2KSdhACxa2JubWr9u5e6YqLRk2pt5kj7KtNtWGwz8yZqAxjbs5Y6Acp0p39WAdDsGLAzJdw99Kc+tW/SZp98SILtTVTnH+VSgC/q2B/ZoQVsF4aJ7gJkDyDBqHDpa7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MNw7qijd; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MNw7qijd"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E34C82309;
	Wed,  1 Jul 2026 05:36:05 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEE573F85F;
	Wed,  1 Jul 2026 05:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782909370; bh=HUBVX/IKPKUaeetXR7Ho4UIgMYtPe7qBv118DqwksrU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MNw7qijddCS+p3aXtdtw1/dj+6946LRjPwOrsto9/PgurUXHgyyIOBRIBhiL1By9C
	 EaEzQAh+2G+lbnVFgBwlG5Ht3F23aQYTW1+V4UNP88nCWNiH0AzYbjUdfBVZcVpLxH
	 5excs3QAN0mKugaF5MeSN3eufiWDuN7AXXXO/VSI=
Message-ID: <820112f0-4361-496f-ba84-557746c75601@arm.com>
Date: Wed, 1 Jul 2026 13:36:00 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/dma: free the entire IOVA reservation in
 dma_iova_destroy()
To: Honglei Huang <honghuan@amd.com>, joro@8bytes.org, will@kernel.org,
 leonro@nvidia.com, m.szyprowski@samsung.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Ray.Huang@amd.com
References: <20260701092033.422867-1-honghuan@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260701092033.422867-1-honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/07/2026 10:20 am, Honglei Huang wrote:
> dma_iova_try_alloc() reserves IOVA for the whole requested size and
> records it in state->__size, but callers may subsequently link only a
> part of that reservation, for example the drm_gpusvm mixed range case,
> where a device page range is linked incrementally.
> 
> The doc for dma_iova_destroy() is:
> 
>    "Unlink the IOVA range up to @mapped_len and free the entire IOVA
>     space."
> 
> However __iommu_dma_iova_unlink() computed the amount of IOVA to free
> from @mapped_len rather than from the full reservation. When the
> reservation is larger than the linked length, the tail
> [mapped_len, reserved size] is never returned to the allocator and
> is leaked, contrary to the documented contract.

That's not what really happens in practice though - note that 
free_iova() doesn't even take a size, only a pfn with which to look up 
the corresponding rbtree entry. At worst, for sizes small enough for the 
rcaches, a larger IOVA may be put in a cache for a smaller size, which 
although wasteful, is otherwise pretty much benign.

This isn't to say that the allocator behaviour might not eventually 
change in future, but for now I can only assume that dma_iova_destroy() 
doing this is intentional, because I pointed it out at least 3 times 
over the course of the original review from RFC to eventual merge, and 
Leon made a point of refusing to do anything about it :/

Thanks,
Robin.

> Free the whole reservation using dma_iova_size(), mirroring
> dma_iova_free(). The unmap step still operates on @mapped_len only, and
> the same iotlb_gather is reused so a single IOTLB flush is performed.
> 
> Fixes: 433a76207dcf ("dma-mapping: Implement link/unlink ranges API")
> Cc: stable@vger.kernel.org
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>   drivers/iommu/dma-iommu.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 9abaec0703e..bb29c82d1c8 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -2096,8 +2096,11 @@ static void __iommu_dma_iova_unlink(struct device *dev,
>   
>   	if (!iotlb_gather.queued)
>   		iommu_iotlb_sync(domain, &iotlb_gather);
> -	if (free_iova)
> +	if (free_iova) {
> +		/* Free the whole reservation, not just the linked @size. */
> +		size = iova_align(iovad, dma_iova_size(state) + iova_start_pad);
>   		iommu_dma_free_iova(domain, addr, size, &iotlb_gather);
> +	}
>   }
>   
>   /**
> 
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482

