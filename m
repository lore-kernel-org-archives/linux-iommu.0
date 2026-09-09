Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D713F8254
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946456; cv=none; b=CEzgooBt4JLRowGrVrR/CKpcXuHJUkBz5dgBd9yDzODreTexf5cldlrmbei4bSSmud1OuhC4evcveFfqM821FFHo23HDxMff7HXWVPXWN6NcfJnltHYp0UQ6HYdNR7yyE1t0j1vP0NVdVyuXvX8SycNFlP9eOIDzN3h7y7JCqps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946456; c=relaxed/simple;
	bh=kI0dFl9THJgq2NRN3l8zcpKi8pMsX5t348uZacY6h58=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:In-Reply-To:
	 Content-Type:References; b=r1QuTlH+sQnG9yNexsoBzVSN6YVeS2P35XtZ0QHS1172gBbJXvTk/BeHWMmQkpxRCgJHTfdxnpRs4zOn3w9+awDjXF17gbO9ovVqn/9qhMBAf6JBuJGnYJhuu/RzcV239Eh1BJnFK5Q48gpAAyjMB+od/mMd2yY0fvWvtF088fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qGFwFM9t; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qGFwFM9t"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260909093401euoutp0269abef05669019a9ffff6516d9c2a8ef~TnU9weya71745717457euoutp02U
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 09:34:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260909093401euoutp0269abef05669019a9ffff6516d9c2a8ef~TnU9weya71745717457euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1788946441;
	bh=UV0/+f1l1BoLThd42Ew9ojQmpG98ujp+B6DNFtXMLB0=;
	h=Date:Subject:To:From:In-Reply-To:References:From;
	b=qGFwFM9tX/POMB+cQXb+N3gFZtllUteEnaYW/feAzpisaHwTmSrLknMNODUX+2+UL
	 QIFUXIjgsWhk54Q+6dHd5FmBOwbLGezgtyHlrwzcYMHn381fM3QogCqd6nesWjrxad
	 bsOo4TD+5t/1/mAha5R/CuffwjY9IqfOmSLpPYhM=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260909093401eucas1p1978a50cffbadcd28189328b8a35181f1~TnU9aG9Mo1629716297eucas1p1H;
	Wed,  9 Sep 2026 09:34:01 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260909093358eusmtip199556b4956c3d189eaf7446be74818ee~TnU7Tv7y41967519675eusmtip1Q;
	Wed,  9 Sep 2026 09:33:58 +0000 (GMT)
Message-ID: <c694433e-4006-40f9-81a0-f1de58f0c93e@samsung.com>
Date: Wed, 9 Sep 2026 11:33:58 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2] dma-mapping: use exact allocation for DMA pages
To: Qingfang Deng <qingfang.deng@linux.dev>, Robin Murphy
	<robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, David
	Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike
	Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
	Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260903012914.312305-1-qingfang.deng@linux.dev>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260909093401eucas1p1978a50cffbadcd28189328b8a35181f1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260903012931eucas1p1d558f849340fa7b92074201c28f7937b
X-EPHeader: CA
X-CMS-RootMailID: 20260903012931eucas1p1d558f849340fa7b92074201c28f7937b
References: <CGME20260903012931eucas1p1d558f849340fa7b92074201c28f7937b@eucas1p1.samsung.com>
	<20260903012914.312305-1-qingfang.deng@linux.dev>

On 03.09.2026 03:29, Qingfang Deng wrote:
> DMA page allocation fallbacks use alloc_pages_node() with get_order(size),
> wasting the unused tail for non-power-of-two requests.
>
> Use alloc_pages_exact_nid() and free_pages_exact() so that a buddy
> fallback retains only requested pages.
>
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
Applied to dma-mapping-for-next, thanks!
> ---
> v2: drop __meminit to fix section mismatch
>
> v1:
> https://lore.kernel.org/linux-iommu/20260901085348.53140-1-qingfang.deng@linux.dev/
> ---
>  drivers/iommu/dma-iommu.c   | 10 ++++++----
>  include/linux/dma-map-ops.h |  2 +-
>  include/linux/gfp.h         |  2 +-
>  kernel/dma/contiguous.c     |  6 +++---
>  kernel/dma/direct.c         |  8 +++++---
>  kernel/dma/ops_helpers.c    | 11 +++++++----
>  mm/page_alloc.c             |  2 +-
>  7 files changed, 24 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 58c624513cd4..8f262c83802c 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1628,10 +1628,12 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
>  	void *cpu_addr;
>  
>  	page = dma_alloc_contiguous(dev, alloc_size, gfp);
> -	if (!page)
> -		page = alloc_pages_node(node, gfp, get_order(alloc_size));
> -	if (!page)
> -		return NULL;
> +	if (!page) {
> +		cpu_addr = alloc_pages_exact_nid(node, alloc_size, gfp);
> +		if (!cpu_addr)
> +			return NULL;
> +		page = virt_to_page(cpu_addr);
> +	}
>  
>  	if (!coherent || PageHighMem(page)) {
>  		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 8fae2b7deb20..3ef3003713a6 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -143,7 +143,7 @@ static inline struct page *dma_alloc_contiguous(struct device *dev, size_t size,
>  static inline void dma_free_contiguous(struct device *dev, struct page *page,
>  		size_t size)
>  {
> -	__free_pages(page, get_order(size));
> +	free_pages_exact(page_address(page), size);
>  }
>  #endif /* CONFIG_DMA_CMA*/
>  
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 872bc53f32ec..aa4601805f21 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -329,7 +329,7 @@ void *alloc_pages_exact_noprof(size_t size, gfp_t gfp_mask) __alloc_size(1);
>  
>  void free_pages_exact(void *virt, size_t size);
>  
> -__meminit void *alloc_pages_exact_nid_noprof(int nid, size_t size, gfp_t gfp_mask) __alloc_size(2);
> +void *alloc_pages_exact_nid_noprof(int nid, size_t size, gfp_t gfp_mask) __alloc_size(2);
>  #define alloc_pages_exact_nid(...)					\
>  	alloc_hooks(alloc_pages_exact_nid_noprof(__VA_ARGS__))
>  
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 66093460584e..90937dc7c627 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -451,8 +451,8 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
>   *
>   * This function releases memory allocated by dma_alloc_contiguous(). As the
>   * cma_release returns false when provided pages do not belong to contiguous
> - * area and true otherwise, this function then does a fallback __free_pages()
> - * upon a false-return.
> + * area and true otherwise, this function then does a fallback
> + * free_pages_exact() upon a false-return.
>   */
>  void dma_free_contiguous(struct device *dev, struct page *page, size_t size)
>  {
> @@ -476,7 +476,7 @@ void dma_free_contiguous(struct device *dev, struct page *page, size_t size)
>  	}
>  
>  	/* not in any cma, free from buddy */
> -	__free_pages(page, get_order(size));
> +	free_pages_exact(page_address(page), size);
>  }
>  
>  /*
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index da665ca22d5c..ea64453d7370 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -120,6 +120,7 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
>  	int node = dev_to_node(dev);
>  	struct page *page;
>  	u64 phys_limit;
> +	void *va;
>  
>  	WARN_ON_ONCE(!PAGE_ALIGNED(size));
>  
> @@ -133,9 +134,9 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
>  		dma_free_contiguous(dev, page, size);
>  	}
>  
> -	while ((page = alloc_pages_node(node, gfp, get_order(size)))
> -	       && !dma_coherent_ok(dev, page_to_phys(page), size)) {
> -		__free_pages(page, get_order(size));
> +	while ((va = alloc_pages_exact_nid(node, size, gfp)) &&
> +	       !dma_coherent_ok(dev, virt_to_phys(va), size)) {
> +		free_pages_exact(va, size);
>  
>  		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
>  		    phys_limit < DMA_BIT_MASK(64) &&
> @@ -146,6 +147,7 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
>  		else
>  			return NULL;
>  	}
> +	page = va ? virt_to_page(va) : NULL;
>  
>  	return page;
>  }
> diff --git a/kernel/dma/ops_helpers.c b/kernel/dma/ops_helpers.c
> index 6b5f9208d31c..5cdf3f60cf47 100644
> --- a/kernel/dma/ops_helpers.c
> +++ b/kernel/dma/ops_helpers.c
> @@ -67,10 +67,13 @@ struct page *dma_common_alloc_pages(struct device *dev, size_t size,
>  	phys_addr_t phys;
>  
>  	page = dma_alloc_contiguous(dev, size, gfp);
> -	if (!page)
> -		page = alloc_pages_node(dev_to_node(dev), gfp, get_order(size));
> -	if (!page)
> -		return NULL;
> +	if (!page) {
> +		void *va = alloc_pages_exact_nid(dev_to_node(dev), size, gfp);
> +
> +		if (!va)
> +			return NULL;
> +		page = virt_to_page(va);
> +	}
>  
>  	phys = page_to_phys(page);
>  	if (use_dma_iommu(dev))
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c4dc61ec663e..d3a135dfcdd3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5637,7 +5637,7 @@ EXPORT_SYMBOL(alloc_pages_exact_noprof);
>   *
>   * Return: pointer to the allocated area or %NULL in case of error.
>   */
> -void * __meminit alloc_pages_exact_nid_noprof(int nid, size_t size, gfp_t gfp_mask)
> +void *alloc_pages_exact_nid_noprof(int nid, size_t size, gfp_t gfp_mask)
>  {
>  	unsigned int order = get_order(size);
>  	struct page *p;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

