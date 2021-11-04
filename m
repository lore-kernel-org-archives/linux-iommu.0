Return-Path: <SRS0=75oM=PX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B4AC433EF
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 12:36:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 381C160E90
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 12:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 381C160E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0CF17403D3;
	Thu,  4 Nov 2021 12:36:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C-Nfsg9omscx; Thu,  4 Nov 2021 12:36:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C5D1F403A9;
	Thu,  4 Nov 2021 12:36:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFE68C0019;
	Thu,  4 Nov 2021 12:36:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB1B5C000E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:36:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D9C684058D
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:36:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0cQ4Lc7mNdff for <iommu@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 12:36:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 139F740571
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:36:13 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C593113E;
 Thu,  4 Nov 2021 05:36:12 -0700 (PDT)
Received: from [10.57.80.217] (unknown [10.57.80.217])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFF5F3F7D7;
 Thu,  4 Nov 2021 05:36:11 -0700 (PDT)
Message-ID: <1732d247-e82a-2250-d12e-0d5988d670a9@arm.com>
Date: Thu, 4 Nov 2021 12:36:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 06/10] dma-direct: refactor the !coherent checks in
 dma_direct_alloc
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
References: <20211021090611.488281-1-hch@lst.de>
 <20211021090611.488281-7-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211021090611.488281-7-hch@lst.de>
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

On 2021-10-21 10:06, Christoph Hellwig wrote:
> Add a big central !dev_is_dma_coherent(dev) block to deal with as much
> as of the uncached allocation schemes and document the schemes a bit
> better.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/direct.c | 58 ++++++++++++++++++++++++++++-----------------
>   1 file changed, 36 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 4ffdb524942a1..d66f37f34ba71 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -196,29 +196,46 @@ void *dma_direct_alloc(struct device *dev, size_t size,
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
> +		if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP)) {
> +			if (!gfpflags_allow_blocking(gfp) &&
> +			    !is_swiotlb_for_alloc(dev))
> +				return dma_direct_alloc_from_pool(dev, size,
> +						dma_handle, gfp);
> +			remap = true;

How about:
		remap = IS_ENABLED(CONFIG_DMA_DIRECT_REMAP);

		if (remap && ...)

for a bit less indentation? FWIW I reckon it's slightly more obvious 
that way round.

Robin.

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
> @@ -226,10 +243,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
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
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
