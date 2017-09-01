From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/dma: limit the IOVA allocated to dma-ranges region
Date: Fri, 1 Sep 2017 11:26:09 +0200
Message-ID: <20170901092609.GL19533@8bytes.org>
References: <1504217301-17216-1-git-send-email-vdumpa@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1504217301-17216-1-git-send-email-vdumpa@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krishna Reddy <vdumpa@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Adding Robin for review.

On Thu, Aug 31, 2017 at 03:08:21PM -0700, Krishna Reddy wrote:
> Limit the IOVA allocated to dma-ranges specified for the device.
> This is necessary to ensure that IOVA allocated is addressable
> by device.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>  drivers/iommu/dma-iommu.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 9d1cebe7f6cb..e8a8320b571b 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -364,6 +364,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>  	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>  	struct iova_domain *iovad = &cookie->iovad;
>  	unsigned long shift, iova_len, iova = 0;
> +	dma_addr_t dma_end_addr;
>  
>  	if (cookie->type == IOMMU_DMA_MSI_COOKIE) {
>  		cookie->msi_iova += size;
> @@ -381,6 +382,10 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>  	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
>  		iova_len = roundup_pow_of_two(iova_len);
>  
> +	/* Limit IOVA allocated to device addressable dma-ranges region. */
> +	dma_end_addr = (dma_addr_t)iovad->dma_32bit_pfn << shift;
> +	dma_limit = dma_limit > dma_end_addr ? dma_end_addr : dma_limit;

This looks like a good use-case for min().

> +
>  	if (domain->geometry.force_aperture)
>  		dma_limit = min(dma_limit, domain->geometry.aperture_end);
>  
> -- 
> 2.1.4
