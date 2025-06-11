Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D7128C2CB
	for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 14:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652139; cv=none; b=e3xjWBjZESImxFnNV8oI3SbhToMhRDlwCcUgwFfs5dxStY7g0UWFOtmd05I2IDdJXN+JxC/31XdOV+cCkxl3JKUIBl2NE3n+hdOhgj44BiplKDtcVY+Tft19l68hcxBq6ZKlsi/RwzgkgoUPWPDSNo6iMcl2EX3wR9RWsj4uTJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652139; c=relaxed/simple;
	bh=EY1GvCod1xS/lS7mriTNXRbI5lI8/SAVCHmM1jsz+0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOoNCKw1colnZCFgQo8RQcJa/icDIfO0OKlkN4i1oMhHU5IAqiX1ffCRpNLPy4VprhZpie2+QC+zg0pjk2lpwA0t1MWceKTzJku1Hxh+yqUoJYeT8HSRtTjiUJXDa2nLtqBqjtvlj1mq8I9wX8aL0pd+si1Q/St+S8pk3bhk8io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A1AD15A1;
	Wed, 11 Jun 2025 07:28:36 -0700 (PDT)
Received: from [10.57.28.131] (unknown [10.57.28.131])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB3DE3F673;
	Wed, 11 Jun 2025 07:28:54 -0700 (PDT)
Message-ID: <e2d856b7-0214-49ab-a4c5-4e6ee2541c6d@arm.com>
Date: Wed, 11 Jun 2025 15:28:52 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] swiotlb: iommu/dma: Move trace_swiotlb_bounced() into
 swiotlb_tbl_map_single()
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 iommu@lists.linux.dev
Cc: Christoph Hellwig <hch@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
References: <20250611100103.7b3c28c8@batman.local.home>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250611100103.7b3c28c8@batman.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-11 3:01 pm, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> I'm working on code that will warn when a tracepoint is defined but not
> used. As the TRACE_EVENT() logic still creates all the code regardless if
> something calls the trace_<event>() function. It wastes around 5K per trace
> event (less for tracepoints).
> 
> But it seems that the code in drivers/iommu/dma-iommu.c does the opposite.
> It calls the trace_swiotlb_bounced() tracepoint without it being defined.
> The tracepoint is defined in kernel/dma/swiotlb.c when CONFIG_SWIOTLB is
> defined, but this code exists when that config is not defined.
> 
> This now fails with my work because I have all the callers reference the
> tracepoint that they will call.
> 
> Thanks to the kernel test robot, it found this:
> 
>    https://lore.kernel.org/all/202506091015.7zd87kI7-lkp@intel.com/
> 
> Instead of calling trace_swiotlb_bounced() from drivers/iommu/dma-iommu.c
> where it is useless when CONFIG_SWIOTLB is not defined, move the
> tracepoint into swiotlb_tbl_map_single(). This also makes it consistent
> with which memory is being traced (physical as supposed to dma address).

Consistent with what? Certainly not the other callers which invoke the 
tracepoint with phys_to_dma(orig_addr), but will now do so twice with 
potentially different values. Arguably iommu-dma is already consistent 
as things stand, since it does not support static address offsets 
underneath IOMMU translation, and therefore orig_addr will always be 
equal to phys_to_dma(orig_addr) anyway. The point of interest really is 
in those other cases, where if there *were* a static DMA offset then 
phys_to_dma(orig_addr) would actually be a pretty meaningless value 
which is not used anywhere else and therefore not overly helpful to 
trace - neither the recognisable PA of the underlying memory itself, nor 
the actual DMA address which will be used subsequently, since at this 
point that's yet to be allocated.

> Fixes: ed18a46262be4 ("iommu/dma: Factor out a iommu_dma_map_swiotlb helper")

It's a fair bit older than that, try a63c357b9fd5 ("iommu/dma: Trace 
bounce buffer usage when mapping buffers") - looks like it's always just 
been hopeful of being DCE'd.

Thanks,
Robin.

> Closes: https://lore.kernel.org/all/20250610202457.5a599336@gandalf.local.home/
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>   drivers/iommu/dma-iommu.c | 2 --
>   kernel/dma/swiotlb.c      | 2 ++
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index ea2ef53bd4fe..1935b360cc94 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1153,8 +1153,6 @@ static phys_addr_t iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
>   		return (phys_addr_t)DMA_MAPPING_ERROR;
>   	}
>   
> -	trace_swiotlb_bounced(dev, phys, size);
> -
>   	phys = swiotlb_tbl_map_single(dev, phys, size, iova_mask(iovad), dir,
>   			attrs);
>   
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index abcf3fa63a56..c112f1d98861 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1379,6 +1379,8 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>   	phys_addr_t tlb_addr;
>   	unsigned short pad_slots;
>   
> +	trace_swiotlb_bounced(dev, orig_addr, mapping_size);
> +
>   	if (!mem || !mem->nslabs) {
>   		dev_warn_ratelimited(dev,
>   			"Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");

