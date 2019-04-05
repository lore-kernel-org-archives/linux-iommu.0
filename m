From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 06/21] dma-iommu: use for_each_sg in iommu_dma_alloc
Date: Fri, 5 Apr 2019 19:08:34 +0100
Message-ID: <e0143e7a-bfcd-36fb-ffe4-754cc1202fa3@arm.com>
References: <20190327080448.5500-1-hch@lst.de>
 <20190327080448.5500-7-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327080448.5500-7-hch@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 27/03/2019 08:04, Christoph Hellwig wrote:
> arch_dma_prep_coherent can handle physically contiguous ranges larger
> than PAGE_SIZE just fine, which means we don't need a page-based
> iterator.

Heh, I got several minutes into writing a "but highmem..." reply before 
finding csky's arch_dma_prep_coherent() implementation. And of course 
that's why it specifically takes a page instead of any addresses. In 
hindsight I now have no idea why I didn't just write the flush_page() 
logic to work that way in the first place...

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/dma-iommu.c | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 77d704c8f565..f915cb7c46e6 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -577,15 +577,11 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>   		goto out_free_iova;
>   
>   	if (!(prot & IOMMU_CACHE)) {
> -		struct sg_mapping_iter miter;
> -		/*
> -		 * The CPU-centric flushing implied by SG_MITER_TO_SG isn't
> -		 * sufficient here, so skip it by using the "wrong" direction.
> -		 */
> -		sg_miter_start(&miter, sgt.sgl, sgt.orig_nents, SG_MITER_FROM_SG);
> -		while (sg_miter_next(&miter))
> -			arch_dma_prep_coherent(miter.page, PAGE_SIZE);
> -		sg_miter_stop(&miter);
> +		struct scatterlist *sg;
> +		int i;
> +
> +		for_each_sg(sgt.sgl, sg, sgt.orig_nents, i)
> +			arch_dma_prep_coherent(sg_page(sg), sg->length);
>   	}
>   
>   	if (iommu_map_sg(domain, iova, sgt.sgl, sgt.orig_nents, prot)
> 
