Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700653;
	b=jHgbF8OWQZOUTHDiFKh4JY4jRjJzDNLV5tQqw6hxCx2CjjMN1Or6yavSlLQEqkxF2JDv
	 R07p/mdWLLRINxGQ+wbywpgYD6p4nCKzF2dR5wPqPisU7FMF/exDx174jo85BXIwAx7g9
	 u+pg/aAylWAI0F3gWORAn8NDa607irjzNCYzqIpOntV6iyu63FFF7HaVdEHzme7EX6II1
	 mJX79c87sK06iT8lFtKpod1WjVpekwHJFiaygd3o2YHmT0N8hRJf+ET8Pr5luZ4liNWEz
	 PDR7S1ZWOT+VTng+8e4eglNyyEl/eY6vIvAqbu3R2eADXNtHyMedFew19W98JD4fd3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700653;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=2miWXckXEf9/8fJq2kLZ6HHXh4pF31ZiQShBy3CvvJQ=;
	b=XDGPy1xcd1NH+iqGUIWt2OZ3xUxiUWwlkKmeh6DxWzU/MxHTABJYruEEt2DBM+V1p3ax
	 H6oqKiZFmpRLX7Zzt+O5WlqY0VuBxpuoVxczxFiTvRuQq3NAS7WjI7CPAbLO0iv7O6+aO
	 hF8UawB7n1m8RPr1pg3nQPuBZLFmv1D33Be3xbjDBN6qud8lrGhMKcLmoO2uaxlFCPWOI
	 QljU7NXXrpccbgqmiNuvacpCO57c+UVIKt7DoBwOZgx4srQO2Toid2jCBoAcqVcvT5lZq
	 HPSeGnvMH7VyH+E1LfAxSV+/7J6hOiwMtbwGw1wcA04Bhy+Q2NR/FDxS/09Ih6IX9Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=P6D9rRFE;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3925C606B112
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 10:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3925C606B112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=P6D9rRFE
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261103101049euoutp02207cc648f5d1d19576c89247af8de6e0~kgTy61HQg2903629036euoutp02n
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 10:10:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261103101049euoutp02207cc648f5d1d19576c89247af8de6e0~kgTy61HQg2903629036euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793700649;
	bh=2miWXckXEf9/8fJq2kLZ6HHXh4pF31ZiQShBy3CvvJQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=P6D9rRFELTCereOoTaTTR2BoDm2AQJAUCJ6qJ5pqGgWyKUfcU21VeGmGdIZI3rjfq
	 7/2xZdKsbuncpMyFJOdceQBRXZMEY2rZ+aLKUN/oK24x2foISLnuqxqgtwun76h4ML
	 +6ju2atQwwopT1FHXFTchGy8kFEZOXsKRZPom06Y=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261103101048eucas1p2192952d7ccdf6cee02830269510aca7e~kgTyPtkgV1245512455eucas1p2H;
	Tue,  3 Nov 2026 10:10:48 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261103101047eusmtip2f99b012249277f80088899badb6f04af~kgTwxvNxT3115731157eusmtip2h;
	Tue,  3 Nov 2026 10:10:46 +0000 (GMT)
Message-ID: <b1058c89-2e87-4035-b7be-76e93fe3ac07@samsung.com>
Date: Tue, 3 Nov 2026 11:10:46 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2 3/7] dma-mapping: Keep DMA memory private for capable
 devices
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
	joro@8bytes.org, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
	rafael@kernel.org, Danilo Krummrich <dakr@kernel.org>, Johan Hovold
	<johan@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, driver-core@lists.linux.dev, Sonang Patel
	<sonangp@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>,
	shameerali.kolothum.thodi@huawei.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <a2a5fe1a1c4d8c99d96874a166f77996d51f3cb7.1793676742.git.nicolinc@nvidia.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261103101048eucas1p2192952d7ccdf6cee02830269510aca7e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261103035025eucas1p2e556ed6dee063a472de0102b87fda0e3
X-EPHeader: CA
X-CMS-RootMailID: 20261103035025eucas1p2e556ed6dee063a472de0102b87fda0e3
References: <cover.1793676742.git.nicolinc@nvidia.com>
	<CGME20261103035025eucas1p2e556ed6dee063a472de0102b87fda0e3@eucas1p2.samsung.com>
	<a2a5fe1a1c4d8c99d96874a166f77996d51f3cb7.1793676742.git.nicolinc@nvidia.com>

On 03.11.2026 04:49, Nicolin Chen wrote:
> Architecture code can require devices to use unencrypted memory. This makes
> the DMA API use shared memory for coherent allocations and bounce streaming
> mappings through SWIOTLB.
>
> A device marked with DEV_FLAG_DMA_CC_PRIVATE can reach private memory
> directly. Add dma_require_decrypted() to combine force_dma_unencrypted()
> with the new device flag, and use it throughout the generic DMA code.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
The change look good, but I'm not really happy to see the mix of unencrypted
and decrypted terms. Wasn't there a consensus which one will be used?


> ---
>  include/linux/dma-direct.h |  7 ++++++-
>  kernel/dma/direct.c        | 16 ++++++++--------
>  kernel/dma/mapping.c       |  2 +-
>  kernel/dma/swiotlb.c       |  2 +-
>  4 files changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index daa31a1adf7b0..fb35ca27941cc 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -134,6 +134,11 @@ static inline bool force_dma_unencrypted(struct device *dev)
>  }
>  #endif /* CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED */
>  
> +static inline bool dma_require_decrypted(struct device *dev)
> +{
> +	return !dev_dma_cc_private(dev) && force_dma_unencrypted(dev);
> +}
> +
>  static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
>  		bool is_ram, unsigned long attrs)
>  {
> @@ -146,7 +151,7 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
>  	 * requires unencrypted DMA addresses. Treat it as not DMA-capable
>  	 * so the caller can fall back to a suitable SWIOTLB pool.
>  	 */
> -	if (!(attrs & DMA_ATTR_CC_SHARED) && force_dma_unencrypted(dev))
> +	if (!(attrs & DMA_ATTR_CC_SHARED) && dma_require_decrypted(dev))
>  		return false;
>  
>  	if (is_ram && !IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT) &&
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 25e9a86835fd3..b3b9ff090c590 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -41,7 +41,7 @@ static inline struct page *dma_direct_to_page(struct device *dev,
>  
>  u64 dma_direct_get_required_mask(struct device *dev)
>  {
> -	bool require_decrypted = force_dma_unencrypted(dev);
> +	bool require_decrypted = dma_require_decrypted(dev);
>  	phys_addr_t phys = ((phys_addr_t)max_pfn << PAGE_SHIFT) - 1;
>  	u64 max_dma = phys_to_dma_direct(dev, phys, require_decrypted);
>  
> @@ -72,7 +72,7 @@ static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 *phys_limit)
>  
>  bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
>  {
> -	bool require_decrypted = force_dma_unencrypted(dev);
> +	bool require_decrypted = dma_require_decrypted(dev);
>  	dma_addr_t dma_addr = phys_to_dma_direct(dev, phys, require_decrypted);
>  
>  	if (dma_addr == DMA_MAPPING_ERROR)
> @@ -226,7 +226,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	struct page *page;
>  	void *cpu_addr;
>  
> -	if (force_dma_unencrypted(dev))
> +	if (dma_require_decrypted(dev))
>  		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
>  
>  	if (attrs & __DMA_ATTR_ALLOC_CC_SHARED) {
> @@ -385,7 +385,7 @@ void dma_direct_free(struct device *dev, size_t size,
>  	 * If the allocation used decrypted/shared backing pages, restore
>  	 * the encryption state on free.
>  	 */
> -	if (force_dma_unencrypted(dev))
> +	if (dma_require_decrypted(dev))
>  		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
>  
>  	if (attrs & __DMA_ATTR_ALLOC_CC_SHARED)
> @@ -452,7 +452,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  	struct page *page;
>  	void *cpu_addr;
>  
> -	if (force_dma_unencrypted(dev))
> +	if (dma_require_decrypted(dev))
>  		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
>  
>  	if ((attrs & __DMA_ATTR_ALLOC_CC_SHARED) && dma_direct_use_pool(dev, gfp))
> @@ -496,7 +496,7 @@ void dma_direct_free_pages(struct device *dev, size_t size,
>  	 * if the device had requested for an unencrypted buffer,
>  	 * convert it to encrypted on free
>  	 */
> -	bool mark_mem_encrypted = force_dma_unencrypted(dev);
> +	bool mark_mem_encrypted = dma_require_decrypted(dev);
>  
>  	/* If page is not from an atomic pool, dma_free_from_pool_page() fails */
>  	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
> @@ -665,7 +665,7 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
>  	const pgoff_t pgoff_end = vma_end_pgoff(vma);
>  	int ret = -ENXIO;
>  
> -	if (force_dma_unencrypted(dev))
> +	if (dma_require_decrypted(dev))
>  		attrs |= DMA_ATTR_CC_SHARED;
>  
>  	vma->vm_page_prot = dma_pgprot(dev, vma->vm_page_prot, attrs);
> @@ -814,7 +814,7 @@ size_t dma_direct_max_mapping_size(struct device *dev)
>  	/* If SWIOTLB is active, use its maximum mapping size */
>  	if (is_swiotlb_active(dev) &&
>  	    (dma_addressing_limited(dev) || is_swiotlb_force_bounce(dev) ||
> -	     force_dma_unencrypted(dev)))
> +	     dma_require_decrypted(dev)))
>  		return swiotlb_max_mapping_size(dev);
>  
>  	return SIZE_MAX;
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index ded585b39fb92..0252473edd0b5 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -673,7 +673,7 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  		return NULL;
>  	}
>  
> -	if (force_dma_unencrypted(dev))
> +	if (dma_require_decrypted(dev))
>  		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
>  
>  	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr)) {
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 2c57b49ac7c06..ddfc4533934a2 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1550,7 +1550,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>  	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
>  
>  		/* swiotlb pool is incorrect for this device */
> -		if (unlikely(mem->cc_shared != force_dma_unencrypted(dev)))
> +		if (unlikely(mem->cc_shared != dma_require_decrypted(dev)))
>  			return (phys_addr_t)DMA_MAPPING_ERROR;
>  
>  	} else if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

