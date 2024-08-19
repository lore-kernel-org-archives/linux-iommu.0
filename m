Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5501DDC9
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724073421; cv=none; b=dtEhPg4qfteUNoORG5RblEjSA0xzoXSG3/NcbedNozGMNY/Eo5ggcg1AuatX4u/PjAmI3FUls2RJqXAnruPK/OawNXquRKtt9lO3IpTwbYxGozJrIn0emSJh9dvJHZbE+PTCqR5CVlNhZMa/mJJtDit3l2RBiPPCEumKfcOf9aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724073421; c=relaxed/simple;
	bh=Q3J4giWjoThpIIOjerPd8FDwUw1UbaDegxaJ+xYfNA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjpVvZfAFZO++bRz4s7TW9q1arUmNrk3rAPuPlQe+qWpQcGIMEbYQy7m0AINQrUqiBqiRYkFoQ0C1RtlGOzYYcO1wc1ixuwwyzza0JlGVTzixx0NysirNppv1RDmDwpGwkAy/aZbT7/trq2GofUCoDqtJrpv2fNtAoj0XIgTVWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F3D3339;
	Mon, 19 Aug 2024 06:17:25 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03DB63F73B;
	Mon, 19 Aug 2024 06:16:57 -0700 (PDT)
Message-ID: <91b6da73-fc59-4751-8215-1edf68de222e@arm.com>
Date: Mon, 19 Aug 2024 14:16:56 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] dma: add IOMMU static calls with clear default ops
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Leon Romanovsky <leonro@nvidia.com>,
 Easwar Hariharan <eahariha@linux.microsoft.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 Jason Gunthorpe <jgg@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <cover.1721818168.git.leon@kernel.org>
 <c3179690b16d790d5bfd7d0afabac9b90922ec28.1721818168.git.leon@kernel.org>
 <20369981-37c8-482a-9ffa-cf54d12dad2d@arm.com> <20240816071134.GA2943@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240816071134.GA2943@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/08/2024 8:11 am, Christoph Hellwig wrote:
> On Thu, Aug 15, 2024 at 05:54:49PM +0100, Robin Murphy wrote:
>>>    +#ifdef CONFIG_DMA_OPS_HELPERS
>>> +#include <asm/dma-mapping.h>
>>
>> What needs a definition of get_arch_dma_ops() in this scope?
>>
>>> +struct page *dma_common_alloc_pages(struct device *dev, size_t size,
>>> +		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp);
>>> +void dma_common_free_pages(struct device *dev, size_t size, struct page *vaddr,
>>> +		dma_addr_t dma_handle, enum dma_data_direction dir);
>>
>> Why not bring the rest of the dma_common_* declarations in here as well?
>> (Or more literally, add the #ifdef around where they all are already)
> 
> We actually don't need the ifdef at all, the calls in mapping.c are
> all keyed off compile time constants, so just leaving the stray
> prorotypes for this code that won't ever be called around should be
> just fine.
> 
>>>    	depends on !NO_DMA
>>>    	default y
>>>    +# DMA IOMMU uses common ops helpers for certain operations, so let's
>>> allow to build
>>> +# ops_helpers.c even if DMA_OPS is not enabled
>>
>> Hmm, but actually dma-direct also uses dma_common_contiguous_remap(), so
>> something seems a little inconsistent here...
> 
> Yes, but that's not really new.  I'll look into a patch to select
> the helpers based on the conditions that make dma-direct use it.
> 
> I'll fix up all style issues and will apply the patch with that over
> the weekend so that we can get it into this merge window.

Thanks, I've just had a quick look over what you queued on 
dma-iommu-direct-calls, and you're welcome to stick my ack on that if 
you like.

Cheers,
Robin.
