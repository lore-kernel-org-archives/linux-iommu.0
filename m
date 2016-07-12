From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 07/20] iommu/amd: Remove special mapping code for dma_ops
	path
Date: Tue, 12 Jul 2016 11:55:39 +0100
Message-ID: <5784CCAB.8000007@arm.com>
References: <1467978311-28322-1-git-send-email-joro@8bytes.org>
	<1467978311-28322-8-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1467978311-28322-8-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Vincent.Wan-5C7GfCeVMHo@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 08/07/16 12:44, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> Use the iommu-api map/unmap functions instead. This will be
> required anyway when IOVA code is used for address
> allocation.
> 
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/iommu/amd_iommu.c | 107 ++++++----------------------------------------
>  1 file changed, 14 insertions(+), 93 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index e7c042b..08aa46c 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -2557,94 +2557,6 @@ static void update_domain(struct protection_domain *domain)
>  }
>  
>  /*
> - * This function fetches the PTE for a given address in the aperture
> - */
> -static u64* dma_ops_get_pte(struct dma_ops_domain *dom,
> -			    unsigned long address)
> -{
> -	struct aperture_range *aperture;
> -	u64 *pte, *pte_page;
> -
> -	aperture = dom->aperture[APERTURE_RANGE_INDEX(address)];
> -	if (!aperture)
> -		return NULL;
> -
> -	pte = aperture->pte_pages[APERTURE_PAGE_INDEX(address)];
> -	if (!pte) {
> -		pte = alloc_pte(&dom->domain, address, PAGE_SIZE, &pte_page,
> -				GFP_ATOMIC);
> -		aperture->pte_pages[APERTURE_PAGE_INDEX(address)] = pte_page;
> -	} else
> -		pte += PM_LEVEL_INDEX(0, address);
> -
> -	update_domain(&dom->domain);
> -
> -	return pte;
> -}
> -
> -/*
> - * This is the generic map function. It maps one 4kb page at paddr to
> - * the given address in the DMA address space for the domain.
> - */
> -static dma_addr_t dma_ops_domain_map(struct dma_ops_domain *dom,
> -				     unsigned long address,
> -				     phys_addr_t paddr,
> -				     int direction)
> -{
> -	u64 *pte, __pte;
> -
> -	WARN_ON(address > dom->aperture_size);
> -
> -	paddr &= PAGE_MASK;
> -
> -	pte  = dma_ops_get_pte(dom, address);
> -	if (!pte)
> -		return DMA_ERROR_CODE;
> -
> -	__pte = paddr | IOMMU_PTE_P | IOMMU_PTE_FC;
> -
> -	if (direction == DMA_TO_DEVICE)
> -		__pte |= IOMMU_PTE_IR;
> -	else if (direction == DMA_FROM_DEVICE)
> -		__pte |= IOMMU_PTE_IW;
> -	else if (direction == DMA_BIDIRECTIONAL)
> -		__pte |= IOMMU_PTE_IR | IOMMU_PTE_IW;
> -
> -	WARN_ON_ONCE(*pte);
> -
> -	*pte = __pte;
> -
> -	return (dma_addr_t)address;
> -}
> -
> -/*
> - * The generic unmapping function for on page in the DMA address space.
> - */
> -static void dma_ops_domain_unmap(struct dma_ops_domain *dom,
> -				 unsigned long address)
> -{
> -	struct aperture_range *aperture;
> -	u64 *pte;
> -
> -	if (address >= dom->aperture_size)
> -		return;
> -
> -	aperture = dom->aperture[APERTURE_RANGE_INDEX(address)];
> -	if (!aperture)
> -		return;
> -
> -	pte  = aperture->pte_pages[APERTURE_PAGE_INDEX(address)];
> -	if (!pte)
> -		return;
> -
> -	pte += PM_LEVEL_INDEX(0, address);
> -
> -	WARN_ON_ONCE(!*pte);
> -
> -	*pte = 0ULL;
> -}
> -
> -/*
>   * This function contains common code for mapping of a physically
>   * contiguous memory region into DMA address space. It is used by all
>   * mapping functions provided with this IOMMU driver.
> @@ -2654,7 +2566,7 @@ static dma_addr_t __map_single(struct device *dev,
>  			       struct dma_ops_domain *dma_dom,
>  			       phys_addr_t paddr,
>  			       size_t size,
> -			       int dir,
> +			       int direction,
>  			       bool align,
>  			       u64 dma_mask)
>  {
> @@ -2662,6 +2574,7 @@ static dma_addr_t __map_single(struct device *dev,
>  	dma_addr_t address, start, ret;
>  	unsigned int pages;
>  	unsigned long align_mask = 0;
> +	int prot = 0;
>  	int i;
>  
>  	pages = iommu_num_pages(paddr, size, PAGE_SIZE);
> @@ -2676,10 +2589,18 @@ static dma_addr_t __map_single(struct device *dev,
>  	if (address == DMA_ERROR_CODE)
>  		goto out;
>  
> +	if (direction == DMA_TO_DEVICE)
> +		prot = IOMMU_PROT_IR;
> +	else if (direction == DMA_FROM_DEVICE)
> +		prot = IOMMU_PROT_IW;
> +	else if (direction == DMA_BIDIRECTIONAL)
> +		prot = IOMMU_PROT_IW | IOMMU_PROT_IR;
> +
>  	start = address;
>  	for (i = 0; i < pages; ++i) {
> -		ret = dma_ops_domain_map(dma_dom, start, paddr, dir);
> -		if (ret == DMA_ERROR_CODE)
> +		ret = iommu_map_page(&dma_dom->domain, start, paddr,
> +				     PAGE_SIZE, prot, GFP_ATOMIC);

I see that amd_iommu_map/unmap() takes a lock around calling
iommu_map/unmap_page(), but we don't appear to do that here. That seems
to suggest that either one is unsafe or the other is unnecessary.

Robin.

> +		if (ret)
>  			goto out_unmap;
>  
>  		paddr += PAGE_SIZE;
> @@ -2699,7 +2620,7 @@ out_unmap:
>  
>  	for (--i; i >= 0; --i) {
>  		start -= PAGE_SIZE;
> -		dma_ops_domain_unmap(dma_dom, start);
> +		iommu_unmap_page(&dma_dom->domain, start, PAGE_SIZE);
>  	}
>  
>  	dma_ops_free_addresses(dma_dom, address, pages);
> @@ -2730,7 +2651,7 @@ static void __unmap_single(struct dma_ops_domain *dma_dom,
>  	start = dma_addr;
>  
>  	for (i = 0; i < pages; ++i) {
> -		dma_ops_domain_unmap(dma_dom, start);
> +		iommu_unmap_page(&dma_dom->domain, start, PAGE_SIZE);
>  		start += PAGE_SIZE;
>  	}
>  
> 
