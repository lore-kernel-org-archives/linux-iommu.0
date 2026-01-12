Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3814050097D
	for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227204; cv=none; b=UvMgtMC1/jJxdMVd+3gnSkJX0lk93FkYK7752KX6b7lYd5riwfw5GG9ssFe0BGesTxNXOl5TczpnS7wuUYfN5YepdQkIhl9j+XeASvohGZcuDTi7Dt+Igzj0PcdkDuR6R4VjD5fWf9/C9umXRKp6wD+6rcwm/tuWT/HpDB5m8Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227204; c=relaxed/simple;
	bh=nsP2em0YtuyFUDsB5PftQZ+aQ3/YwXgQYLn8BVWbLTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tgmjq7/cWYIdvr/Y3e7Pu1nnfha5DlH+mcsOMh0kc6cOJ9U+yuG9I6QlZ33OIjIC2Gn0c0eNstptQ9KlHvFqs+3L5n00ljF54xxBRj7ArHdmvHHwyn6fMyPgHAAFVLShwxqE/qw5Ndifu21cVCkLpNKyqsBLv6S37PkPF3orLFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07086497;
	Mon, 12 Jan 2026 06:13:16 -0800 (PST)
Received: from [10.57.48.115] (unknown [10.57.48.115])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB21C3F59E;
	Mon, 12 Jan 2026 06:13:21 -0800 (PST)
Message-ID: <aa4565e7-af59-483a-a875-5bd970c9c923@arm.com>
Date: Mon, 12 Jan 2026 14:13:19 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dma/pool: respect __GFP_NOWARN in
 dma_alloc_from_pool()
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, m.szyprowski@samsung.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: vigneshr@ti.com
References: <20260112104749.4132641-1-s-adivi@ti.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260112104749.4132641-1-s-adivi@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-12 10:47 am, Sai Sree Kartheek Adivi wrote:
> Currently, dma_alloc_from_pool() unconditionally warns and dumps a stack
> trace when an allocation fails.
> 
> This prevents callers from using the __GFP_NOWARN flag to suppress error
> messages, breaking the expectation that this flag will silence
> allocation failure logs.

This is not an "allocation failure" in that sense, though. It's not like 
the caller has opportunistically requested a large allocation, and is 
happy to try again with a smaller size - if someone has asked for an 
allocation in atomic context that can only be satisfied from an atomic 
pool, and there is no atomic pool at all, that points at something being 
more fundamentally wrong with the system, in a manner that the caller 
probably isn't expecting.

Under what circumstances are you seeing the warning without things being 
totally broken anyway?

Thanks,
Robin.

> Align dma_pool behaviour with other core allocators by checking for
> __GFP_NOWARN before issuing the warning.
> 
> Fixes: 9420139f516d ("dma-pool: fix coherent pool allocations for IOMMU mappings")
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>   kernel/dma/pool.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 26392badc36b..f63e027b8a27 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -276,7 +276,7 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
>   			return page;
>   	}
>   
> -	WARN(1, "Failed to get suitable pool for %s\n", dev_name(dev));
> +	WARN(!(gfp & __GFP_NOWARN), "Failed to get suitable pool for %s\n", dev_name(dev));
>   	return NULL;
>   }
>   

