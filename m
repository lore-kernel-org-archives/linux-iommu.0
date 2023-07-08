Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E7C80F
	for <iommu@lists.linux.dev>; Sat,  8 Jul 2023 23:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5196C433C7;
	Sat,  8 Jul 2023 23:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688860797;
	bh=WC+yJU+KAuLbcUiFIRKOOKm3qK3FbcCY7ckACZkrILs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=PH9oJdzfJ/Z8KEP448j1h7oROLZF3SphvS5QTuijRHG1W10PpeGvQff0ibA5Be2ux
	 wScxJ/jv3djsYsEpdruZ86sMDYQz4ky1O8BOYG/bFQkAHgRxBYlbWVTfcB9THhRA/b
	 4xx2PdYR/+qqkGLfE/hm165gdIWknBc0meR1f66A7YLMrutDJ/6nvqlLf3UshlvTcq
	 0C9jfkcA54RPY6HdmEe8hxVlE/WCbLlLSR3uF5m89eCaojHO7inmlmxFfUd65ogp/p
	 5oCHXkOlB1md0oYi0ajpXHHEaohrF1kKFTbutkpIc3UV66yi3CSRuXFNcsgjtMn0gR
	 H6kkWIl3U62IQ==
Date: Sat, 8 Jul 2023 16:59:54 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Christoph Hellwig <hch@lst.de>
cc: jgross@suse.com, sstabellini@kernel.org, oleksandr_tyshchenko@epam.com, 
    xen-devel@lists.xenproject.org, iommu@lists.linux.dev
Subject: Re: [PATCH, RFC] swiotlb-xen: fix dma to physical address translation
 for cache operations
In-Reply-To: <20230607132518.15381-1-hch@lst.de>
Message-ID: <alpine.DEB.2.22.394.2307081650460.761183@ubuntu-linux-20-04-desktop>
References: <20230607132518.15381-1-hch@lst.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 7 Jun 2023, Christoph Hellwig wrote:
> All other places in swiotlb-xen got from PFN to BFN and then call
> phys_to_dma on the result or vice versa, but the reverse mapping used
> for cache maintenance skips the BFN to PFN mapping.
> 
> [Note: only found by code inspection, please review very carefully!]
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Hi Christoph,

No, these checks are done on purpose differently. Let me explain.


xen_phys_to_dma does 2 translations:
1) guest physical to real physical (also called mfn in Xen)
2) real physical to dma

2) is not interesting in this discussion, 1) is.

Dom0 is mapped 1:1 guest physical == real physical by default on ARM.

For any Dom0 memory page:
- guest physical == real physical

Dom0 sometimes maps memory of other domains. By definitions, those are
not 1:1 mapped. For those:
- guest physical != real physical

Linux normally only knows about guest physical addresses, not real
physical addresses.


The checks below are meant to check if a given page is a regular Dom0
page, or a page of another domain. The check relies on the fact that if
it is a local Dom0 page then (guest physical == real physical) and
pfn_valid return true, otherwise if it not a local Dom0 page then (guest
physical != real physical) and pfn_valid return false.

Basically the check is doing:

  pfn_valid(real phys address)

In the local case:

  pfn_valid(real phys address) == pfn_valid(guest phys address) => true

In the foreign case:

  pfn_valid(real phys address) != pfn_valid(guest phys address) => false


Note that pfn_valid(guest phys address) would return true in both cases
because the foreign page is mapped over a valid Dom0 guest physical
address.


In short, it is a simple trick to detect if the address corresponds to a
regular Dom0 memory page or not.

Cheers,

Stefano

> ---
>  drivers/xen/swiotlb-xen.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 67aa74d201627d..e4620303138b4d 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -234,7 +234,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
>  
>  done:
>  	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
> -		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dev_addr))))
> +		if (pfn_valid(PFN_DOWN(phys)))
>  			arch_sync_dma_for_device(phys, size, dir);
>  		else
>  			xen_dma_sync_for_device(dev, dev_addr, size, dir);
> @@ -258,7 +258,7 @@ static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
>  	BUG_ON(dir == DMA_NONE);
>  
>  	if (!dev_is_dma_coherent(hwdev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
> -		if (pfn_valid(PFN_DOWN(dma_to_phys(hwdev, dev_addr))))
> +		if (pfn_valid(PFN_DOWN(paddr)))
>  			arch_sync_dma_for_cpu(paddr, size, dir);
>  		else
>  			xen_dma_sync_for_cpu(hwdev, dev_addr, size, dir);
> @@ -276,7 +276,7 @@ xen_swiotlb_sync_single_for_cpu(struct device *dev, dma_addr_t dma_addr,
>  	phys_addr_t paddr = xen_dma_to_phys(dev, dma_addr);
>  
>  	if (!dev_is_dma_coherent(dev)) {
> -		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dma_addr))))
> +		if (pfn_valid(PFN_DOWN(paddr)))
>  			arch_sync_dma_for_cpu(paddr, size, dir);
>  		else
>  			xen_dma_sync_for_cpu(dev, dma_addr, size, dir);
> @@ -296,7 +296,7 @@ xen_swiotlb_sync_single_for_device(struct device *dev, dma_addr_t dma_addr,
>  		swiotlb_sync_single_for_device(dev, paddr, size, dir);
>  
>  	if (!dev_is_dma_coherent(dev)) {
> -		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dma_addr))))
> +		if (pfn_valid(PFN_DOWN(paddr)))
>  			arch_sync_dma_for_device(paddr, size, dir);
>  		else
>  			xen_dma_sync_for_device(dev, dma_addr, size, dir);
> -- 
> 2.39.2
> 
