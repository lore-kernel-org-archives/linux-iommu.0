Received: from mta0.migadu.com (out-97.mta0.migadu.com [91.218.175.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11EE3DDAE2
	for <iommu@lists.linux.dev>; Sat,  5 Sep 2026 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788613078; cv=none; b=Br8aeD/np4pFTmK+ITM/8YlXLap/gzWAIXuDG3UNITqw5WZDUyIfO7X9knbmtHPtGmnNXzLIdus0el6a9wwGW+Ahh2v61ZOCxVx0vN/Ls8Vx/08OMW6UMflWdCjZsHvLs+8VKQqOZoRgg7retlt44pzzYI1PMMt1FfsiDNoc2zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788613078; c=relaxed/simple;
	bh=6PIvpKWK+Ee59Xh6tlvDfoJ4/XkFQFEdfgzS5msTKzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WhNSfY1Tin7/+wtKnvHfRr0Qkbm2/UY0zGhCSdDO1TsKdxoKxGrG0VI+MMvUBFSMqIW0fMqyiPvQRV9TgfRzkPSz48faQL6HHAJV+PhwYqwqUHaE200x3I3y4R5cqtoRLAji/WztCUHz15iEh1p4VGasTc75pVx3HEFVhCMh4Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i5NENDXr; arc=none smtp.client-ip=91.218.175.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i5NENDXr"
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=6PIvpKWK+Ee59Xh6tlvDfoJ4/XkFQFEdfgzS5msTKzA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788613073; v=1; x=1789217873;
 b=i5NENDXr/ZrDyO6VqLA7b42fpX/hQMJoCXqfg2fMu/9kq8uwIM622WgEYZncHFu0MA5ZQd7U
 ccGN5+c0VlelVwcmxIGdFnWlW43wem2tkhULMgNXt1oAa5qAHgYySkkzFoWZ8DEtZaLbAe41Rd8
 v6XX7en4NTzvr+7zaRvKNJGM=
X-Envelope-To: iommu@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id fc90dd21752b853b;
	Sat, 05 Sep 2026 12:57:43 +0000
X-Mizu-Trace-ID: fc90dd21752b853b
X-Migadu-Flow: FLOW_OUT
Message-ID: <568a4f04-e0db-342a-13a8-886cf6b2a8ab@linux.dev>
Date: Sat, 5 Sep 2026 08:57:42 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dma-mapping: don't trace the DMA address when the
 allocation fails
Content-Language: en-US
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260905071919.30784-1-donggeunyoo.kernel@gmail.com>
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20260905071919.30784-1-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/26 03:19, Donggeun Yoo wrote:
> dma_alloc_attrs() passes *dma_handle to trace_dma_alloc() and
> debug_dma_alloc_coherent() without checking whether the allocation
> succeeded.

I don't understand what you mean. We are literally in an if-statement
that checks whether the allocation succeeded.

--Sean

> No backend writes it on failure: dma_direct_alloc(),
> iommu_dma_alloc() and the dma_map_ops instances assign it only on the
> path that returns a buffer. Callers usually pass an uninitialized
> automatic variable, so with the tracepoint enabled a failed allocation
> records whatever the stack held, next to the virt_addr=(null) that marks
> the record as an error.
> 
> The device coherent pool path is the same: a non-zero return from
> dma_alloc_from_dev_coherent() means the request was handled, not that it
> succeeded, so cpu_addr is NULL and dma_handle untouched once the pool
> runs out.
> 
> Split both sites on cpu_addr, as dma_alloc_pages() and
> dma_alloc_noncontiguous() do further down the file, and pass 0 for the
> failure case like the two error paths already in this function.
> 
> Fixes: 038eb433dc14 ("dma-mapping: add tracing for dma-mapping API calls")
> Fixes: 68b6dbf1f441 ("dma-mapping: trace more error paths")
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> ---
> Compile-tested only, with CONFIG_DMA_API_DEBUG=y and CONFIG_TRACEPOINTS=y
> so that both changed calls are built. The claim that no backend writes
> *dma_handle on failure was checked against dma_direct_alloc() and its
> helpers, iommu_dma_alloc(), iommu_dma_alloc_remap() and every in-tree
> dma_map_ops .alloc implementation.
> 
>   kernel/dma/mapping.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index bf2651a70b7c..098cd57e1157 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -656,8 +656,12 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
>   
>   	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr)) {
> -		trace_dma_alloc(dev, cpu_addr, *dma_handle, size,
> -				DMA_BIDIRECTIONAL, flag, attrs);
> +		if (cpu_addr)
> +			trace_dma_alloc(dev, cpu_addr, *dma_handle, size,
> +					DMA_BIDIRECTIONAL, flag, attrs);
> +		else
> +			trace_dma_alloc(dev, NULL, 0, size, DMA_BIDIRECTIONAL,
> +					flag, attrs);
>   		return cpu_addr;
>   	}
>   
> @@ -676,9 +680,15 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   		return NULL;
>   	}
>   
> -	trace_dma_alloc(dev, cpu_addr, *dma_handle, size, DMA_BIDIRECTIONAL,
> -			flag, attrs);
> -	debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr, attrs);
> +	if (cpu_addr) {
> +		trace_dma_alloc(dev, cpu_addr, *dma_handle, size,
> +				DMA_BIDIRECTIONAL, flag, attrs);
> +		debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr,
> +					 attrs);
> +	} else {
> +		trace_dma_alloc(dev, NULL, 0, size, DMA_BIDIRECTIONAL, flag,
> +				attrs);
> +	}
>   	return cpu_addr;
>   }
>   EXPORT_SYMBOL(dma_alloc_attrs);

