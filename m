Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BF947A537
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876740; cv=none; b=HdDC7CiZ62he5z88uLO3EMrdpZxVxMExOb3oOdd3ojfXdhg9Lm94jXlx5KJ2RFMIVr9AkmBAntv8Hj8Xf1MMcOREU8swV9rUJKXWGuwdlInx8tkGLdZy5nVb43vKz9xUJSMJNIEKifMkbzhSQw+a+b/VJYHrejVC15Q6jOCt7h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876740; c=relaxed/simple;
	bh=zu72ng1U26p514b3TMYQAv5hE7z0ZgMnHnIkuj5XLYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGIN+FdGHfRuuaxfUnHaZZ50WFB7ohY9FK07UwhGT6+0KVxoA3DYeJaVMDEsWIKnsRA7UVUSEQHj/se6EPHzftzSUhrvKatg6MM0bpvW+TKgGbJrD2vyX0HMMz69sE/lCpKaaH0gIsbh8vnPddaWCoPBvYVr6cgLHRr/PAcrLOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E126497;
	Thu,  8 Jan 2026 04:52:09 -0800 (PST)
Received: from [10.57.47.193] (unknown [10.57.47.193])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 550CC3F6A8;
	Thu,  8 Jan 2026 04:52:15 -0800 (PST)
Message-ID: <56c39e62-0417-495d-a40e-99180a107777@arm.com>
Date: Thu, 8 Jan 2026 12:52:13 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/io-pgtable-arm: Drop DMA API usage for CMOs
To: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: will@kernel.org, joro@8bytes.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20260108113846.56179-1-smostafa@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260108113846.56179-1-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-01-08 11:38 am, Mostafa Saleh wrote:
> As part of the KVM SMMUv3 series[1], we are trying to factor out
> the kernel specific code from io-pgtable-arm so it can also compile
> for the hypervisor.
> 
> Jason pointed out that the DMA-API calls are not really needed [2].
> 
> Looking more into this. Initially, the io-pgtable API let drivers
> do the CMOs using tlb::flush_pgtable() where drivers were using the
> DMA API (map/unmap_single) only to do CMOs as the low-level cache
> functions won’t be available for modules.
> 
> This was later moved to the core code [3], with possibility to
> convert it to full blown DMA-API code if there was a use case.

I don't understand that sentence at all.

> However, no such use case appeared, and we can simplify the code
> slightly by doing CMO directly instead of going through the DMA-API
> functions just for CMOs.
> 
> Although HTTU is not used at the moment, leave the
> arch_sync_dma_for_cpu() in __arm_lpae_free_pages() as this is not a
> hot path.
> 
> Removing the DMA-API will also remove some extra checks ensuring that
> the IOMMU can deal with physical addrs. we can add those check at
> page table creation time (Something as use_dma_iommu/is_swiotlb_active
> However, that seemed a little too much as Linux doesn't support such
> topologies anyways.

NAK - io-pgtable is regular driver code doing what is absolutely a DMA 
mapping operation. How would Panfrost calling arch_sync_* signal to hyp 
that the page is now being used for DMA so needs mapping/pinning at 
stage 2? We can't even say that that doesn't apply to "real" IOMMU 
drivers, since there do unfortunately exist cases where an entire "stage 
1" SMMUv3 is upstream of a "stage 2" SMMUv3 such that it's only workable 
if the former is assigned to EL1 as just another black-box device, while 
only EL2 knows about the latter.

If "pagetable creation time" means alloc_io_pgtable_ops() as I've taken 
it to, how do you specifically propose to check that pages which haven't 
been allocated yet will definitely be valid for DMA in future? Also note 
that the only reason for the virt_to_phys() check (which *has* often 
caught genuine driver/platform configuration issues to a degree that I 
would be very uncomfortable removing it) is basically laziness, in that 
nobody's got round to doing the work to be able to keep track of kernel 
addresses separately from the DMA addresses in the tables themselves, 
and thus allow visibly-remapped pagetables - every now and then there 
arises a situation where that would be really useful, so it is still on 
my wishlist.

Frankly if KVM is going to have increasingly divergent requirements and 
assumptions about pagetables, then it should have its own pagetable code 
like it does for the CPU.

Thanks,
Robin.

> [1] https://lore.kernel.org/linux-iommu/20251117184815.1027271-1-smostafa@google.com/
> [2] https://lore.kernel.org/linux-iommu/20251216005834.GC31492@ziepe.ca/
> [3] https://lore.kernel.org/linux-iommu/7c5584d3efa61ee6b0b87efb72f24f32852aafb7.1438195011.git.robin.murphy@arm.com/
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>   drivers/iommu/io-pgtable-arm.c | 39 +++++++---------------------------
>   1 file changed, 8 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index e6626004b323..0da9195155ec 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -15,7 +15,7 @@
>   #include <linux/sizes.h>
>   #include <linux/slab.h>
>   #include <linux/types.h>
> -#include <linux/dma-mapping.h>
> +#include <linux/dma-map-ops.h>
>   
>   #include <asm/barrier.h>
>   
> @@ -254,7 +254,6 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
>   {
>   	struct device *dev = cfg->iommu_dev;
>   	size_t alloc_size;
> -	dma_addr_t dma;
>   	void *pages;
>   
>   	/*
> @@ -271,32 +270,10 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
>   	if (!pages)
>   		return NULL;
>   
> -	if (!cfg->coherent_walk) {
> -		dma = dma_map_single(dev, pages, size, DMA_TO_DEVICE);
> -		if (dma_mapping_error(dev, dma))
> -			goto out_free;
> -		/*
> -		 * We depend on the IOMMU being able to work with any physical
> -		 * address directly, so if the DMA layer suggests otherwise by
> -		 * translating or truncating them, that bodes very badly...
> -		 */
> -		if (dma != virt_to_phys(pages))
> -			goto out_unmap;
> -	}
> -
> +	if (!cfg->coherent_walk)
> +		arch_sync_dma_for_device(__arm_lpae_dma_addr(pages), size,
> +					 DMA_TO_DEVICE);
>   	return pages;
> -
> -out_unmap:
> -	dev_err(dev, "Cannot accommodate DMA translation for IOMMU page tables\n");
> -	dma_unmap_single(dev, dma, size, DMA_TO_DEVICE);
> -
> -out_free:
> -	if (cfg->free)
> -		cfg->free(cookie, pages, size);
> -	else
> -		iommu_free_pages(pages);
> -
> -	return NULL;
>   }
>   
>   static void __arm_lpae_free_pages(void *pages, size_t size,
> @@ -304,8 +281,8 @@ static void __arm_lpae_free_pages(void *pages, size_t size,
>   				  void *cookie)
>   {
>   	if (!cfg->coherent_walk)
> -		dma_unmap_single(cfg->iommu_dev, __arm_lpae_dma_addr(pages),
> -				 size, DMA_TO_DEVICE);
> +		arch_sync_dma_for_cpu(__arm_lpae_dma_addr(pages),
> +				      size, DMA_TO_DEVICE);
>   
>   	if (cfg->free)
>   		cfg->free(cookie, pages, size);
> @@ -316,8 +293,8 @@ static void __arm_lpae_free_pages(void *pages, size_t size,
>   static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
>   				struct io_pgtable_cfg *cfg)
>   {
> -	dma_sync_single_for_device(cfg->iommu_dev, __arm_lpae_dma_addr(ptep),
> -				   sizeof(*ptep) * num_entries, DMA_TO_DEVICE);
> +	arch_sync_dma_for_device(__arm_lpae_dma_addr(ptep),
> +				 sizeof(*ptep) * num_entries, DMA_TO_DEVICE);
>   }
>   
>   static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtable_cfg *cfg, int num_entries)

