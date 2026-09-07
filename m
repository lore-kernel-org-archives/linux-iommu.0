Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374024734FC
	for <iommu@lists.linux.dev>; Mon,  7 Sep 2026 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788779126; cv=none; b=aA0pohGfu1XqBeGk3CPBUf7zGgMBSaRC0ob6oJB1iszMiN+hneTQ8BWtQ1E2rzJWvabvJv6QVrkWDhaLi3g50Xcpo1dHd0Wx3n+Vtb1ATEsoVVNS7sGlVS1XsausRNWDxhA5GxlbMT+nX0ME4tOoUxSSEXeh+tRRHfHPTdyDwJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788779126; c=relaxed/simple;
	bh=zqXmbd2Z50wJl0hBIofHZ5M98CDm1cup+pJ6kyw+sNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=e4zXXeaUX0euaCcAXismdKdaft33U4mjQaZZtAe1WH0EhHo9zpk6ON1KE86U5D4PaTfR2ZjP9O8GcLY9xAdwvE2ueMnQToFcOE17D2D/VoRDbV+22gB27JSWh7na8jujrxTb39JzcO1ncml+kZYM0q3hKZciP5iRuunuqiVvPoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZU1pLrNm; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZU1pLrNm"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260907110521euoutp0214ec9465ffeb3750bbedda336f904120~TBSIjX67I1014010140euoutp02t
	for <iommu@lists.linux.dev>; Mon,  7 Sep 2026 11:05:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260907110521euoutp0214ec9465ffeb3750bbedda336f904120~TBSIjX67I1014010140euoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1788779121;
	bh=cdiHqfP066vD1Eme2p0UfDhpDV63v+NMGx+7TiqjvH4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ZU1pLrNmQtu2fdBgeTKgZ3z0T+DgIKLXmUWcUc9fU+XMzqvwSUnVEoi1XDJ4oTDrG
	 HOS3gEyx6c4hv7w2W/vOGGUEm/Khow2RhaLjXAVvuJYr5a9x1ZhEfG3Jx56Bx2hC0j
	 oacx2+DsPSOqWQsvRTQMGZe0gWSbRZkgFQ9yFxQo=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260907110521eucas1p2b210f0e3af19462cd56aaf34a8236055~TBSIZXzKe2716927169eucas1p20;
	Mon,  7 Sep 2026 11:05:21 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260907110520eusmtip17567050ca784110fbe7d68f6cd8f16ef~TBSIFRM0h1147811478eusmtip1g;
	Mon,  7 Sep 2026 11:05:20 +0000 (GMT)
Message-ID: <ff20483d-c701-4cdb-8db8-15aa79bc32cf@samsung.com>
Date: Mon, 7 Sep 2026 13:05:20 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-mapping: don't trace the DMA address when the
 allocation fails
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Sean Anderson
	<sean.anderson@linux.dev>, Steven Rostedt <rostedt@goodmis.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260905071919.30784-1-donggeunyoo.kernel@gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260907110521eucas1p2b210f0e3af19462cd56aaf34a8236055
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260905071928eucas1p1c5690e441968982d4acd9ea1c43b02e5
X-EPHeader: CA
X-CMS-RootMailID: 20260905071928eucas1p1c5690e441968982d4acd9ea1c43b02e5
References: <CGME20260905071928eucas1p1c5690e441968982d4acd9ea1c43b02e5@eucas1p1.samsung.com>
	<20260905071919.30784-1-donggeunyoo.kernel@gmail.com>

On 05.09.2026 09:19, Donggeun Yoo wrote:
> dma_alloc_attrs() passes *dma_handle to trace_dma_alloc() and
> debug_dma_alloc_coherent() without checking whether the allocation
> succeeded. No backend writes it on failure: dma_direct_alloc(),
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
>  kernel/dma/mapping.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index bf2651a70b7c..098cd57e1157 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -656,8 +656,12 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
>  
>  	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr)) {
> -		trace_dma_alloc(dev, cpu_addr, *dma_handle, size,
> -				DMA_BIDIRECTIONAL, flag, attrs);
> +		if (cpu_addr)
> +			trace_dma_alloc(dev, cpu_addr, *dma_handle, size,
> +					DMA_BIDIRECTIONAL, flag, attrs);
> +		else
> +			trace_dma_alloc(dev, NULL, 0, size, DMA_BIDIRECTIONAL,
> +					flag, attrs);
Frankly speaking I would prefer to fix this in include/trace/events/dma.h with
__entry->dma_addr = virt_addr ? dma_addr : 0;


>  		return cpu_addr;
>  	}
>  
> @@ -676,9 +680,15 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  		return NULL;
>  	}
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
Here You remove the debug_dma_alloc call for the failed case. Right, it
is a noop now for the allocation failure, but it might be extended with
some kind of debugging in the future, so I prefer to keep the current
code here.
>  	return cpu_addr;
>  }
>  EXPORT_SYMBOL(dma_alloc_attrs);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

