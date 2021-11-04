Return-Path: <SRS0=75oM=PX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A827C433EF
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 12:36:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDC3B611EE
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 12:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CDC3B611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95CE4817C0;
	Thu,  4 Nov 2021 12:36:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gpUIkPVe29_R; Thu,  4 Nov 2021 12:36:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 16F5D80F94;
	Thu,  4 Nov 2021 12:36:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E980CC0019;
	Thu,  4 Nov 2021 12:36:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B75B9C000E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:36:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9982E404C3
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:36:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VbWdbOIm-aZj for <iommu@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 12:36:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id DB78E40245
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:36:50 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B8521063;
 Thu,  4 Nov 2021 05:36:50 -0700 (PDT)
Received: from [10.57.80.217] (unknown [10.57.80.217])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3F3D3F7D7;
 Thu,  4 Nov 2021 05:36:49 -0700 (PDT)
Message-ID: <b0c11b91-36d6-e794-9efa-46cdf7a741b1@arm.com>
Date: Thu, 4 Nov 2021 12:36:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 05/10] dma-direct: factor out a helper for
 DMA_ATTR_NO_KERNEL_MAPPING allocations
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
References: <20211021090611.488281-1-hch@lst.de>
 <20211021090611.488281-6-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211021090611.488281-6-hch@lst.de>
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
> Split the code for DMA_ATTR_NO_KERNEL_MAPPING allocations into a separate
> helper to make dma_direct_alloc a little more readable.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: David Rientjes <rientjes@google.com>
> ---
>   kernel/dma/direct.c | 31 ++++++++++++++++++++-----------
>   1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index a6b6fe72af4d1..4ffdb524942a1 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -163,6 +163,24 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
>   	return ret;
>   }
>   
> +static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
> +		dma_addr_t *dma_handle, gfp_t gfp)
> +{
> +	struct page *page;
> +
> +	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO);
> +	if (!page)
> +		return NULL;
> +
> +	/* remove any dirty cache lines on the kernel alias */
> +	if (!PageHighMem(page))
> +		arch_dma_prep_coherent(page, size);
> +
> +	/* return the page pointer as the opaque cookie */
> +	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
> +	return page;
> +}
> +
>   void *dma_direct_alloc(struct device *dev, size_t size,
>   		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>   {
> @@ -175,17 +193,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   		gfp |= __GFP_NOWARN;
>   
>   	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> -	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev)) {
> -		page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO);
> -		if (!page)
> -			return NULL;
> -		/* remove any dirty cache lines on the kernel alias */
> -		if (!PageHighMem(page))
> -			arch_dma_prep_coherent(page, size);
> -		*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
> -		/* return the page pointer as the opaque cookie */
> -		return page;
> -	}
> +	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))

Hmm, does force_dma_unencrypted() actually matter if the caller doesn't 
want to access the buffer itself? Presumably any subsequent mmap() to 
userspace would still do the right thing?

Robin.

> +		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp);
>   
>   	if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
>   	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
