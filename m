Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD8A230BDB
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 12:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776169937; cv=none; b=LU0oUvR6nQv3WCILYC/BzaUqACPEUhehgBxnRkl1kt8G9a9sGJTZQYLngJATJ/iErmU0Twy/mMJOgWl1p9A4DJcCZn334KJIXGJDHdrk4vtgNhjJgDuIBetaPH6PtxGygJ+p0ITRxhbxrw4TKI5e2GGzpXQl+c7vZcz1UvIGbZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776169937; c=relaxed/simple;
	bh=VZvVyMhOmvhEi2GK+M0VS6jtUaAMnHvXiIDqIjg3+PQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rZcGDzKL2VU0mLpWGt38M8AwH3zkAILehqPa9qnh0tNf+h25F0Ld5rE3OodABPnRDVVz82KYg3FyYCezuzwk+xZdJ3SI2CSlcEphiEm0a4wkOd8xV4FTyS8I8jDM0jjuaXH7xKA11D8zwjl0EIe19KoC9jM5jjgbEu8nNfAkiQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FnLy3+JE; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FnLy3+JE"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA1C24424;
	Tue, 14 Apr 2026 05:32:09 -0700 (PDT)
Received: from [10.1.196.85] (e121345-lin.cambridge.arm.com [10.1.196.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 987833F641;
	Tue, 14 Apr 2026 05:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776169935; bh=VZvVyMhOmvhEi2GK+M0VS6jtUaAMnHvXiIDqIjg3+PQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=FnLy3+JEWLyFMbQMoMUSNPcw+QkSkEiWrLU8EHS0Y0/wlV5Ln2WEGUJkHVx5lJ+Jb
	 I0ZVWCcslfiTJ1+H1Jp4QFtL7c2UuuoTJMJ9ZVntHf+ucD3bRqW4mojMipW65TKpqj
	 3smyuGd1CzLyL6sGj4h67/YGOd6IOeJYtMk2Iqu8=
Message-ID: <dbe5ceb4-cf2a-4742-a706-dac64611998c@arm.com>
Date: Tue, 14 Apr 2026 13:32:11 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] dma-contiguous: try local node first for
 dma_alloc_contiguous()
To: Feng Tang <feng.tang@linux.alibaba.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260414090310.92055-1-feng.tang@linux.alibaba.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260414090310.92055-1-feng.tang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/04/2026 10:03 am, Feng Tang wrote:
> There was a bug report on a multi-numa-nodes ARM server that when
> IOMMU is disabled, the dma_alloc_coherent() function always returns
> memory from node 0 even for devices attaching to other nodes, while
> they can get local dma memory when IOMMU is on with the same API.
> 
> The reason is, when IOMMU is disabled, the dma_alloc_coherent() will
> go the direct way and call dma_alloc_contiguous(). The system doesn't
> have any explicit cma setting (like per-numa cma), and only has a
> default 64MB cma reserved area (on node 0), where kernel will try
> first to allocate memory from.
> 
> Make the dma allocation more locality friendly by trying first the
> numa aware allocation alloc_pages_node() before falling back to the
> reserved cma area.
> 
> One more thought is to check the node of the reserved cma area and
> only call alloc_pages_nodes() when it isn't the same node that the
> device attaches to.

Frankly, no. We literally have a feature specifically created for this 
use-case already - if you care about NUMA locality of DMA allocations 
then enable DMA_NUMA_CMA. Or if you don't need CMA at all, then 
disabling CMA would be even better for the overall performance of your 
system.

Thanks,
Robin.

> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> ---
>   kernel/dma/contiguous.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index c56004d314dc..0180f40f094e 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -371,8 +371,9 @@ static struct page *cma_alloc_aligned(struct cma *cma, size_t size, gfp_t gfp)
>    */
>   struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
>   {
> -#ifdef CONFIG_DMA_NUMA_CMA
> +#ifdef CONFIG_NUMA
>   	int nid = dev_to_node(dev);
> +	struct page *page;
>   #endif
>   
>   	/* CMA can be used only in the context which permits sleeping */
> @@ -386,7 +387,6 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
>   #ifdef CONFIG_DMA_NUMA_CMA
>   	if (nid != NUMA_NO_NODE && !(gfp & (GFP_DMA | GFP_DMA32))) {
>   		struct cma *cma = dma_contiguous_pernuma_area[nid];
> -		struct page *page;
>   
>   		if (cma) {
>   			page = cma_alloc_aligned(cma, size, gfp);
> @@ -402,6 +402,14 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
>   		}
>   	}
>   #endif
> +
> +#ifdef CONFIG_NUMA
> +	/* Try first to allocate memory on the same node as the device */
> +	page = alloc_pages_node(nid, gfp, get_order(size));
> +	if (page)
> +		return page;
> +#endif
> +
>   	if (!dma_contiguous_default_area)
>   		return NULL;
>   

