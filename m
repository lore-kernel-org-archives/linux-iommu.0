Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7B11465BE
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 12:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504788; cv=none; b=TxCAuacO9TjFqK6G2XygPYanbARTpLcwpP4/55Ahy59ohiDe3XTlA8yE78k3SDZmaV/KTMoUYYGqjH/4MzTDmmF/tK90Pm3gxStQWYFZ4wlqHPGt4qFlcrgocvGbHhWs/CUFB8hjn7WgaUeb9Kn5pjIr8zloKY9nE5z4stFkXVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504788; c=relaxed/simple;
	bh=uTsztnqbT4iOcXiermoEhzWU5FdfFGzOa8AsZ4gZ2Q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rGCxmkwlN3R/D7AOK0I1XKfmH+Zr1XZj3EA6vlDJGwDORfNyO6+H93+MZqRU7KZx6Ke/0ihuBpY0F/wWoFSWmsyP/8nc5BGlUTUDnY5N4CPvupXI5fTG1QZfFa3PQYzEjaZB2CEtf9yLiZ9yMkBf1hITHnwDjIT7r1UmGUW2F3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A57451063;
	Tue,  4 Jun 2024 05:40:09 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E75D3F64C;
	Tue,  4 Jun 2024 05:39:41 -0700 (PDT)
Message-ID: <f688bf74-7d12-459c-b8b7-b85aaafc3785@arm.com>
Date: Tue, 4 Jun 2024 13:39:36 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma: direct: Optimize the code for the dma_direct_free
 function
To: kunyu <kunyu@nfschina.com>, hch@lst.de, m.szyprowski@samsung.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240604084100.51464-1-kunyu@nfschina.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240604084100.51464-1-kunyu@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/06/2024 9:41 am, kunyu wrote:
> The 'is_swiotlb-for-alloc' and 'dev_isdma_coherent' judgment functions
> need to be called multiple times, so they are adjusted to variable
> judgment, which can improve code conciseness.
> 
> Signed-off-by: kunyu <kunyu@nfschina.com>
> ---
>   kernel/dma/direct.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

It's hardly concise to add *more* code than was there before... :/

Personally I don't think shaving a handful of characters off each 
invocation has any positive impact on readability in this case, while 
the extra visual indirection, and breaking consistency with the rest of 
this file, definitely has a negative one.

Also note that these "functions" are already just inline wrappers around 
a single variable dereference - for my arm64 build at least, this patch 
has no effect at all on the generated object code, since the compiler 
can still optimise out the locals (so at least it doesn't make things 
*worse* by forcing it to allocate a larger stack frame).

Thanks,
Robin.

> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 4d543b1e9d57..041e316ad4c0 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -315,23 +315,24 @@ void dma_direct_free(struct device *dev, size_t size,
>   		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
>   {
>   	unsigned int page_order = get_order(size);
> +	bool swiotlb_for_alloc = is_swiotlb_for_alloc(dev);
> +	bool is_dma_coherent = dev_is_dma_coherent(dev);
>   
>   	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> -	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev)) {
> +	    !force_dma_unencrypted(dev) && !swiotlb_for_alloc) {
>   		/* cpu_addr is a struct page cookie, not a kernel address */
>   		dma_free_contiguous(dev, cpu_addr, size);
>   		return;
>   	}
>   
>   	if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_ALLOC) &&
> -	    !dev_is_dma_coherent(dev) &&
> -	    !is_swiotlb_for_alloc(dev)) {
> +	    !is_dma_coherent && !swiotlb_for_alloc) {
>   		arch_dma_free(dev, size, cpu_addr, dma_addr, attrs);
>   		return;
>   	}
>   
>   	if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
> -	    !dev_is_dma_coherent(dev)) {
> +	    !is_dma_coherent) {
>   		if (!dma_release_from_global_coherent(page_order, cpu_addr))
>   			WARN_ON_ONCE(1);
>   		return;
