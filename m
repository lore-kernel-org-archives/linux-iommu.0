Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60F12595
	for <iommu@lists.linux.dev>; Sat, 28 Oct 2023 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="i1I47jI4"
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 90B82183965;
	Sat, 28 Oct 2023 19:24:15 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1698513855; bh=63piwosiHAopoeCkW5PJAry2Pc8VSvApdr9vB2aS6wo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i1I47jI4h+WzrG11i7vQx3T1qvsyl7dc6LewNWIe+xOizzWuw/BO+eeZiPoYeKt0S
	 FG/lYSwcN3SCcaXnzzpe36QVC20/vJI8SSSTxFEkBJ0sjXM2lzyAzWRRSVasFCOiFk
	 RuXb4n5xMMjoLcW+7S0iwGj5+iqiOfJ/Nx5nMFt2GIf3Lbd2TWvOGYQSDAx3BQ+PW9
	 mrNNKkA0R4Vz1Z7OgOik0/RDVdnwCrK/p21fflDADjBM/xzFjGkqtdCCKRFymGxVSO
	 mPfC6HcaPdB6b8fynA25wGDm6V+AWmXCsbxVognzzowkkVYR61f+5HHXXKqPz9VrBI
	 m/p0t9XFrCKxw==
Date: Sat, 28 Oct 2023 19:24:14 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Petr Tesarik <petrtesarik@huaweicloud.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>, iommu@lists.linux.dev (open list:DMA
 MAPPING HELPERS), linux-kernel@vger.kernel.org (open list), Wangkefeng
 <wangkefeng.wang@huawei.com>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH] swiotlb: check dynamically allocated TLB address before
 decrypting
Message-ID: <20231028192414.637bf4fd@meshulam.tesarici.cz>
In-Reply-To: <20231026095123.222-1-petrtesarik@huaweicloud.com>
References: <20231026095123.222-1-petrtesarik@huaweicloud.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Christoph,

On Thu, 26 Oct 2023 11:51:23 +0200
Petr Tesarik <petrtesarik@huaweicloud.com> wrote:

> From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> 
> Do not decrypt a dynamically allocated TLB area until its physical address
> is known to be below the requested limit. Currently, pages are allocated
> and decrypted, but then they may be freed while still decrypted if
> swiotlb_alloc_tlb() determines that the physical address is too high.
> 
> Let the caller differentiate between unsuitable physical address (=> retry
> from a lower zone) and allocation failures (=> no point in retrying).
> 
> Fixes: 79636caad361 ("swiotlb: if swiotlb is full, fall back to a transient memory pool")
> Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>

This patch fixes a potential information leak from a CoCo VM, so I
would like to see it reviewed. Is this on your radar, or did it fall
through the cracks?

Petr T

> ---
>  kernel/dma/swiotlb.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index dff067bd56b1..d1118f6f61b8 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -558,30 +558,36 @@ void __init swiotlb_exit(void)
>   * alloc_dma_pages() - allocate pages to be used for DMA
>   * @gfp:	GFP flags for the allocation.
>   * @bytes:	Size of the buffer.
> + * @phys_limit:	Maximum allowed physical address of the
> buffer. *
>   * Allocate pages from the buddy allocator. If successful, make the
> allocated
>   * pages decrypted that they can be used for DMA.
>   *
> - * Return: Decrypted pages, or %NULL on failure.
> + * Return: Decrypted pages, %NULL on allocation failure, or
> ERR_PTR(-EAGAIN)
> + * if the allocated physical address was above @phys_limit.
>   */
> -static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes)
> +static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes, u64
> phys_limit) {
>  	unsigned int order = get_order(bytes);
>  	struct page *page;
> +	phys_addr_t paddr;
>  	void *vaddr;
>  
>  	page = alloc_pages(gfp, order);
>  	if (!page)
>  		return NULL;
>  
> -	vaddr = page_address(page);
> +	paddr = page_to_phys(page);
> +	if (paddr + bytes - 1 > phys_limit)
> +		goto error;
> +	vaddr = phys_to_virt(paddr);
>  	if (set_memory_decrypted((unsigned long)vaddr,
> PFN_UP(bytes))) goto error;
>  	return page;
>  
>  error:
>  	__free_pages(page, order);
> -	return NULL;
> +	return ERR_PTR(-EAGAIN);
>  }
>  
>  /**
> @@ -618,11 +624,7 @@ static struct page *swiotlb_alloc_tlb(struct
> device *dev, size_t bytes, else if (phys_limit <= DMA_BIT_MASK(32))
>  		gfp |= __GFP_DMA32;
>  
> -	while ((page = alloc_dma_pages(gfp, bytes)) &&
> -	       page_to_phys(page) + bytes - 1 > phys_limit) {
> -		/* allocated, but too high */
> -		__free_pages(page, get_order(bytes));
> -
> +	while (IS_ERR(page = alloc_dma_pages(gfp, bytes,
> phys_limit))) { if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
>  		    phys_limit < DMA_BIT_MASK(64) &&
>  		    !(gfp & (__GFP_DMA32 | __GFP_DMA)))

