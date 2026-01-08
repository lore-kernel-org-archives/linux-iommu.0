Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9D4366DD0
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861504; cv=none; b=b4AiWJLeFzHgHkC9q5irogOOP7Wdu03wdbjv7ltH6312xl1SbtqI4WmA19wvi8nchJWLbXhfJ6Z/sg9VCi/Quh3AFsEbh2rOcJ8BV9SmsFu5ak17dz92Ob9tg/1xlLhby92F/PhgPxUyeBaAc4VDQDqj8eoyPTBjqiFpawjyKno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861504; c=relaxed/simple;
	bh=u8OWxiSZNBybma2krIYghSGX96zoLPTn+4X9CK59iRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=eDjE4/3tPU9yWKcZzkaWYLbyEp+Cp/PcP0acU+kOV3KnMecFuryCZDXRqocjlqC92OJaAAYI9iq671xVXEJ7VVSQyz6GuAfub2PdFr4xybmHMRoEjP0M2Hlg4ZqfXgl/EYeOJfd1e/gMUO8pZsbWdngEF4knFgOqBsWDspumQhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VLAlD4+G; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VLAlD4+G"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260108083807euoutp023880d8bdf8922825b9e6b5f96160181f~ItKgUGson3036730367euoutp02Y
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 08:38:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260108083807euoutp023880d8bdf8922825b9e6b5f96160181f~ItKgUGson3036730367euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1767861487;
	bh=B8lQjdPHzwY5BW+8DVEc7GDTLuJ804s2dZgdDbIbuNw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=VLAlD4+Gz6jgXM6GgsCe1KfORg0MRmgsZmUq+MJ65uH/fYxC6J6nna9uaoWlt3/OK
	 YVnYMU2zV8JwFN3PHVK4l2uTw2malOdWURY1tDTdBQ0t10RjYGUdkvqF36TQmrazY1
	 OzncowCWkAWvAIG0D5xgcc1dyCe7Gd9OrIHFlVlk=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260108083807eucas1p1d3bd759adeb14c6fea800476ae33563d~ItKgGTuT71760717607eucas1p1G;
	Thu,  8 Jan 2026 08:38:07 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260108083806eusmtip1635c3e2a5b95dfd047d9196a94ceb056~ItKfiuTiH2688626886eusmtip1M;
	Thu,  8 Jan 2026 08:38:06 +0000 (GMT)
Message-ID: <94dae28d-82ae-4340-9abd-097e2d08fb9f@samsung.com>
Date: Thu, 8 Jan 2026 09:38:06 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-direct: Skip cache prep for HighMem coherent
 allocations
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Arnd Bergmann
	<arnd@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Linus Walleij <linusw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, Suzuki K Poulose
	<suzuki.poulose@arm.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260102155118.2551804-1-aneesh.kumar@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260108083807eucas1p1d3bd759adeb14c6fea800476ae33563d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260102155138eucas1p1563e460256561f6974079d3de733e895
X-EPHeader: CA
X-CMS-RootMailID: 20260102155138eucas1p1563e460256561f6974079d3de733e895
References: <CGME20260102155138eucas1p1563e460256561f6974079d3de733e895@eucas1p1.samsung.com>
	<20260102155118.2551804-1-aneesh.kumar@kernel.org>

On 02.01.2026 16:51, Aneesh Kumar K.V (Arm) wrote:
> dma_direct_alloc() calls arch_dma_prep_coherent() to clean any dirty
> cache lines from the kernel linear alias before creating a coherent
> remapping.
>
> HighMem pages have no kernel alias mapping, so there are no alias cache
> lines to clean. Skip arch_dma_prep_coherent() for HighMem allocations.
>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Indeed this is an overhead to call prep for HighMem pages, but on the 
other hand highmem support is being phased out according to 
https://lwn.net/ml/all/20251219161559.556737-1-arnd@kernel.org/ Does it 
make sense to apply this assuming that it will be removed soon?

> ---
>   kernel/dma/direct.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 50c3fe2a1d55..ffa267020a1e 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -272,7 +272,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   			prot = pgprot_decrypted(prot);
>   
>   		/* remove any dirty cache lines on the kernel alias */
> -		arch_dma_prep_coherent(page, size);
> +		if (!PageHighMem(page))
> +			arch_dma_prep_coherent(page, size);
>   
>   		/* create a coherent mapping */
>   		ret = dma_common_contiguous_remap(page, size, prot,

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

