Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D652C3768
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764690434; cv=none; b=uAvqclkKjgaFcYgW2uAVb5Ecb+jihJkTh2vN+J9R3slf11v6q8i23DMwKeo8cC210+EKQbEIu0zgU3l7i+Wz3o1dBa9wQu2v9dlrvhce/6sIU/3YVPhU+kqiG70KkVDE0isD4zEP5kn2ONFtWgkyvjd6bDkOelYzmlWfAj1HRqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764690434; c=relaxed/simple;
	bh=hJiEuFx0IG4hLVpqWs7/uwjGxdWmHYJGBDqss9lNGoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gjb+9Eui/IiI9EL9rfZyQDwkA9B0xjUU3GiYM3nNreHS/dKyI4z04thSutJrl9oA0MyR5OkxQts5AkboKrBjgIlP16nOfwLpkOogamfeJmpeOQDp7sPs3S5xrXuQ26pCwPQ7N5Sa48Ws7qttponWXu0k/muKEdU3ELjrxYr7CM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87B331477;
	Tue,  2 Dec 2025 07:47:04 -0800 (PST)
Received: from [10.1.35.20] (010265703453.cambridge.arm.com [10.1.35.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 392113F66E;
	Tue,  2 Dec 2025 07:47:11 -0800 (PST)
Message-ID: <8b72d722-5e68-404b-bcb0-04b7daa2a24d@arm.com>
Date: Tue, 2 Dec 2025 15:47:00 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma/pool: eliminate alloc_pages warning in
 atomic_pool_expand
To: Dave Kleikamp <dave.kleikamp@oracle.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251202152810.142370-1-dave.kleikamp@oracle.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20251202152810.142370-1-dave.kleikamp@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-12-02 3:28 pm, Dave Kleikamp wrote:
> atomic_pool_expand iterately tries the allocation while decrementing the

"iteratively"?

> page order. There is no need to issue a warning if an attempted
> allocation fails.
> 
> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> ---
>   kernel/dma/pool.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index ee45dee33d49..26392badc36b 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -93,7 +93,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>   			page = dma_alloc_from_contiguous(NULL, 1 << order,
>   							 order, false);
>   		if (!page)
> -			page = alloc_pages(gfp, order);
> +			page = alloc_pages(gfp | __GFP_NOWARN, order);

Might be nice to keep some kind of warning if we entirely fail all the 
way down to order 0, although I guess if it matters it would show up via 
the warning on dma_alloc_from_pool() failure soon enough anyway...

Either way it certainly makes sense in general;

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   	} while (!page && order-- > 0);
>   	if (!page)
>   		goto out;

