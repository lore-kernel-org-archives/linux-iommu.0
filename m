Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B006323D7DB
	for <iommu@lists.linux.dev>; Wed, 28 Jan 2026 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769609123; cv=none; b=LNAr7p/3RR3qoObN+iIDss2G06A2zcofvzrEIiHRLMCNjdi+G5YmCT2r/xIax4+DqjWzoEp6l9uvcQN6zvzFwgD9KDvwiArGlAXxS2ns9CichhuFyU8fgkt/EWqZbP7UsHtpmDLyZAETnLdoXBqoiaGRKClQ2nAbdSaPLD4qZKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769609123; c=relaxed/simple;
	bh=6ZuUiMusRx9W/mto2GWxPcSkkPDlwrLZrw7Khijece4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kw0gL92ENh0/j9dPTKeA1si3LYK5TPoWpNJj+if2jo8QHjKZ9g+g9Rvbk9dlqw97cEUveAqOp7yjkH0NS6LK2K9Cz2S60j2DxzPypW9xj7KVTpa6n7Et+QCtfrNUb9gsDedSE7NItW6dsB1zKe/dmQii4BkrQpHpPcCuhuC/2UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86E751515;
	Wed, 28 Jan 2026 06:05:14 -0800 (PST)
Received: from [10.57.51.176] (unknown [10.57.51.176])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 151543F5CA;
	Wed, 28 Jan 2026 06:05:19 -0800 (PST)
Message-ID: <6190c781-925b-43af-a68d-3654a4050cc5@arm.com>
Date: Wed, 28 Jan 2026 14:05:18 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dma/pool: distinguish between missing and exhausted
 atomic pools
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, m.szyprowski@samsung.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: vigneshr@ti.com
References: <20260128133554.3056582-1-s-adivi@ti.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260128133554.3056582-1-s-adivi@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-28 1:35 pm, Sai Sree Kartheek Adivi wrote:
> Currently, dma_alloc_from_pool() unconditionally warns and dumps a stack
> trace when an allocation fails, with the message "Failed to get suitable
> pool".
> 
> This conflates two distinct failure modes:
> 1. Configuration error: No atomic pool is available for the requested
>     DMA mask (a fundamental system setup issue)
> 2. Resource Exhaustion: A suitable pool exists but is currently full (a
>     recoverable runtime state)
> 
> This lack of distinction prevents drivers from using __GFP_NOWARN to
> suppress error messages during temporary pressure spikes, such as when
> awaiting synchronous reclaim of descriptors.
> 
> Refactor the error handling to distinguish these cases:
> - If no suitable pool is found, keep the unconditional WARN regarding
>    the missing pool.
> - If a pool was found but is exhausted, respect __GFP_NOWARN and update
>    the warning message to explicitly state "DMA pool exhausted".

Great writeup!

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Fixes: 9420139f516d ("dma-pool: fix coherent pool allocations for IOMMU mappings")
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
> 
> Changes from v2 to v3:
> - Distinguish between "no suitable pool is found" and "pool is
>    exhausted" cases.
> Link: https://lore.kernel.org/all/20260112104749.4132641-1-s-adivi@ti.com/
> 
>   kernel/dma/pool.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index c5da29ad010c4..2b2fbb7092429 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -277,15 +277,20 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
>   {
>   	struct gen_pool *pool = NULL;
>   	struct page *page;
> +	bool pool_found = false;
>   
>   	while ((pool = dma_guess_pool(pool, gfp))) {
> +		pool_found = true;
>   		page = __dma_alloc_from_pool(dev, size, pool, cpu_addr,
>   					     phys_addr_ok);
>   		if (page)
>   			return page;
>   	}
>   
> -	WARN(1, "Failed to get suitable pool for %s\n", dev_name(dev));
> +	if (pool_found)
> +		WARN(!(gfp & __GFP_NOWARN), "DMA pool exhausted for %s\n", dev_name(dev));
> +	else
> +		WARN(1, "Failed to get suitable pool for %s\n", dev_name(dev));
>   	return NULL;
>   }
>   

