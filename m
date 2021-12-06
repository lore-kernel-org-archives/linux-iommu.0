Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1F7C433FE
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 16:33:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD8DC4036A;
	Mon,  6 Dec 2021 16:33:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qaJ7p92Mz-ag; Mon,  6 Dec 2021 16:33:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8F70C4026B;
	Mon,  6 Dec 2021 16:33:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 796AFC001E;
	Mon,  6 Dec 2021 16:33:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94712C0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 16:33:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7531D607A6
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 16:33:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gdswVmPfT1tZ for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 16:33:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id A8C4E607DD
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 16:33:19 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 265E31042;
 Mon,  6 Dec 2021 08:33:19 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8128E3F73B;
 Mon,  6 Dec 2021 08:33:18 -0800 (PST)
Message-ID: <b2a337e3-6c23-d2c0-a0db-aa3ec0d0df9f@arm.com>
Date: Mon, 6 Dec 2021 16:33:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 06/11] dma-direct: refactor the !coherent checks in
 dma_direct_alloc
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
References: <20211111065028.32761-1-hch@lst.de>
 <20211111065028.32761-7-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211111065028.32761-7-hch@lst.de>
Cc: David Rientjes <rientjes@google.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-11-11 06:50, Christoph Hellwig wrote:
> Add a big central !dev_is_dma_coherent(dev) block to deal with as much
> as of the uncached allocation schemes and document the schemes a bit
> better.

With a clear mind and a side-by-side diff viewer, indeed the end result 
is much more readable than the patch itself :)

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/direct.c | 66 ++++++++++++++++++++++++++++-----------------
>   1 file changed, 41 insertions(+), 25 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 01104660ec439..f9658fe18498c 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -201,29 +201,49 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
>   		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp);
>   
> -	if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
> -	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> -	    !IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
> -	    !dev_is_dma_coherent(dev) &&
> -	    !is_swiotlb_for_alloc(dev))
> -		return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
> +	if (!dev_is_dma_coherent(dev)) {
> +		/*
> +		 * Fallback to the arch handler if it exists.  This should
> +		 * eventually go away.
> +		 */
> +		if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
> +		    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> +		    !IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
> +		    !is_swiotlb_for_alloc(dev))
> +			return arch_dma_alloc(dev, size, dma_handle, gfp,
> +					      attrs);
>   
> -	if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
> -	    !dev_is_dma_coherent(dev))
> -		return dma_alloc_from_global_coherent(dev, size, dma_handle);
> +		/*
> +		 * If there is a global pool, always allocate from it for
> +		 * non-coherent devices.
> +		 */
> +		if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL))
> +			return dma_alloc_from_global_coherent(dev, size,
> +					dma_handle);
> +
> +		/*
> +		 * Otherwise remap if the architecture is asking for it.  But
> +		 * given that remapping memory is a blocking operation we'll
> +		 * instead have to dip into the atomic pools.
> +		 */
> +		remap = IS_ENABLED(CONFIG_DMA_DIRECT_REMAP);
> +		if (remap) {
> +			if (!gfpflags_allow_blocking(gfp) &&
> +			    !is_swiotlb_for_alloc(dev))
> +				return dma_direct_alloc_from_pool(dev, size,
> +						dma_handle, gfp);
> +		} else {
> +			if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED))
> +				set_uncached = true;
> +		}
> +	}
>   
>   	/*
> -	 * Remapping or decrypting memory may block. If either is required and
> -	 * we can't block, allocate the memory from the atomic pools.
> -	 * If restricted DMA (i.e., is_swiotlb_for_alloc) is required, one must
> -	 * set up another device coherent pool by shared-dma-pool and use
> -	 * dma_alloc_from_dev_coherent instead.
> +	 * Decrypting memory may block, so allocate the memory from the atomic
> +	 * pools if we can't block.
>   	 */
>   	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
> -	    !gfpflags_allow_blocking(gfp) &&
> -	    (force_dma_unencrypted(dev) ||
> -	     (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> -	      !dev_is_dma_coherent(dev))) &&
> +	    force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp) &&
>   	    !is_swiotlb_for_alloc(dev))
>   		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>   
> @@ -231,10 +251,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO);
>   	if (!page)
>   		return NULL;
> -
> -	if (!dev_is_dma_coherent(dev) && IS_ENABLED(CONFIG_DMA_DIRECT_REMAP)) {
> -		remap = true;
> -	} else if (PageHighMem(page)) {
> +	if (PageHighMem(page)) {
>   		/*
>   		 * Depending on the cma= arguments and per-arch setup,
>   		 * dma_alloc_contiguous could return highmem pages.
> @@ -246,9 +263,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   			goto out_free_pages;
>   		}
>   		remap = true;
> -	} else if (!dev_is_dma_coherent(dev) &&
> -		   IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED))
> -		set_uncached = true;
> +		set_uncached = false;
> +	}
>   
>   	if (remap) {
>   		/* remove any dirty cache lines on the kernel alias */
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
