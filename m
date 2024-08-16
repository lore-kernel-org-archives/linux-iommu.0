Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9955778C68
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 07:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723792301; cv=none; b=HzNScN9r6y8QNpZYOn6SIUfjYP9YehVzPRNNDDhiq76Bo7lhgD3btHmBoQo1PlKymwnjkRKpU6bizE2diewINEL9gnkSFUEAlhe6bhLMSc85tI4d5qAPFgQ4YskV6ddXEVGoKx5RlOSN68DQuXdASwJDYwwfZlmZSxrZDQa4CxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723792301; c=relaxed/simple;
	bh=muBrsezKV8v8bj8HQqTAtEJr/fVMUdL6A0sNbQsvgc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxIIQyPwapMPajj1zeoG7ZuNEH4MFUZuI2Tw5Hc/HgGxe2eSY7Lqtal/9R7fXTEti5du20/NVjGeXVK6G/iRbKgJ7P2HPx5LRetpnikKnwzCFud9aFUi0cc9LQghjFu+2mQiHvwDNfdCyGQeVYO1WChLFmTHSQhxWOVhJZBG+F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E85B8227A87; Fri, 16 Aug 2024 09:11:34 +0200 (CEST)
Date: Fri, 16 Aug 2024 09:11:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 2/2] dma: add IOMMU static calls with clear default
 ops
Message-ID: <20240816071134.GA2943@lst.de>
References: <cover.1721818168.git.leon@kernel.org> <c3179690b16d790d5bfd7d0afabac9b90922ec28.1721818168.git.leon@kernel.org> <20369981-37c8-482a-9ffa-cf54d12dad2d@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20369981-37c8-482a-9ffa-cf54d12dad2d@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Aug 15, 2024 at 05:54:49PM +0100, Robin Murphy wrote:
>>   +#ifdef CONFIG_DMA_OPS_HELPERS
>> +#include <asm/dma-mapping.h>
>
> What needs a definition of get_arch_dma_ops() in this scope?
>
>> +struct page *dma_common_alloc_pages(struct device *dev, size_t size,
>> +		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp);
>> +void dma_common_free_pages(struct device *dev, size_t size, struct page *vaddr,
>> +		dma_addr_t dma_handle, enum dma_data_direction dir);
>
> Why not bring the rest of the dma_common_* declarations in here as well? 
> (Or more literally, add the #ifdef around where they all are already)

We actually don't need the ifdef at all, the calls in mapping.c are
all keyed off compile time constants, so just leaving the stray
prorotypes for this code that won't ever be called around should be
just fine.

>>   	depends on !NO_DMA
>>   	default y
>>   +# DMA IOMMU uses common ops helpers for certain operations, so let's 
>> allow to build
>> +# ops_helpers.c even if DMA_OPS is not enabled
>
> Hmm, but actually dma-direct also uses dma_common_contiguous_remap(), so 
> something seems a little inconsistent here...

Yes, but that's not really new.  I'll look into a patch to select
the helpers based on the conditions that make dma-direct use it.

I'll fix up all style issues and will apply the patch with that over
the weekend so that we can get it into this merge window.

