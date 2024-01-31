Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20705A7A1
	for <iommu@lists.linux.dev>; Wed, 31 Jan 2024 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706714063; cv=none; b=uIGA9/LRY0Akx4+SMb7BAVfE4qzwCewLDOcC7NXOrHw3deZX3fNI43sGOre4IERIDivmIis9jiWcPFlgIVaQRXMw60hmPad4VwLG+b9V56ggpR/jvjTKNuR2TFZkj8lwWi9r2ehrSl1siDhkm+vZGzplnGOuXTe3cjKpF0Pi9eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706714063; c=relaxed/simple;
	bh=/qhuO5HuYtAvq48p1CcziTjf7g4yt0baC+LPUKnS3Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMlMH9BcdeKdzgn4N55rPcQcZd+0nY95wPo9eJ2jfdwa7EGl/4n3ImPb9afjxZDciKkiAM9jM9haCZE0ZIdBvI6KJvfRqBahESXfFYJ7Z3ogAjQdZJ2wl0DjrFs5jZabPZeKg7Si0xyICPzUt1fmEJ9nEbWxUf0Tm76j6uRByOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FD83DA7;
	Wed, 31 Jan 2024 07:15:04 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E5703F762;
	Wed, 31 Jan 2024 07:14:20 -0800 (PST)
Message-ID: <b4045104-7ea4-47b2-ad74-a44bab76c796@arm.com>
Date: Wed, 31 Jan 2024 15:14:18 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] swiotlb: Enforce page alignment in swiotlb_alloc()
Content-Language: en-GB
To: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc: kernel-team@android.com, iommu@lists.linux.dev,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Petr Tesarik <petr.tesarik1@huawei-partners.com>,
 Dexuan Cui <decui@microsoft.com>
References: <20240131122543.14791-1-will@kernel.org>
 <20240131122543.14791-3-will@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240131122543.14791-3-will@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/01/2024 12:25 pm, Will Deacon wrote:
> When allocating pages from a restricted DMA pool in swiotlb_alloc(),
> the buffer address is blindly converted to a 'struct page *' that is
> returned to the caller. In the unlikely event of an allocation bug,
> page-unaligned addresses are not detected and slots can silently be
> double-allocated.
> 
> Add a simple check of the buffer alignment in swiotlb_alloc() to make
> debugging a little easier if something has gone wonky.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> Cc: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>   kernel/dma/swiotlb.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 56cc08b1fbd6..4485f216e620 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1642,6 +1642,12 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
>   		return NULL;
>   
>   	tlb_addr = slot_addr(pool->start, index);
> +	if (unlikely(!PAGE_ALIGNED(tlb_addr))) {
> +		dev_WARN_ONCE(dev, 1, "Cannot allocate pages from non page-aligned swiotlb addr 0x%pa.\n",
> +			      &tlb_addr);

Nit: if there's cause for another respin, I'd be inclined to use a 
straightforward "if (WARN_ON(...))" here - this condition should 
represent SWIOTLB itself going badly wrong, which isn't really 
attributable to whatever device happened to be involved in the call.

Cheers,
Robin.

> +		swiotlb_release_slots(dev, tlb_addr);
> +		return NULL;
> +	}
>   
>   	return pfn_to_page(PFN_DOWN(tlb_addr));
>   }
