Return-Path: <SRS0=75oM=PX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C56C433FE
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 12:36:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CAA260E90
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 12:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6CAA260E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 45084403BB;
	Thu,  4 Nov 2021 12:36:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GMPVXD3wYdlI; Thu,  4 Nov 2021 12:36:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AB690403A9;
	Thu,  4 Nov 2021 12:36:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88AB9C0019;
	Thu,  4 Nov 2021 12:36:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3426EC000E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:36:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 21A93403B6
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:36:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ThcKCm4cJfFF for <iommu@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 12:36:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id DB11A403A9
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:36:04 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50BA51063;
 Thu,  4 Nov 2021 05:36:04 -0700 (PDT)
Received: from [10.57.80.217] (unknown [10.57.80.217])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B27293F7D7;
 Thu,  4 Nov 2021 05:36:03 -0700 (PDT)
Message-ID: <bc7bc5eb-282d-3dbb-b4f9-b9bbd9e0f0a1@arm.com>
Date: Thu, 4 Nov 2021 12:35:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 04/10] dma-direct: clean up the remapping checks in
 dma_direct_alloc
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
References: <20211021090611.488281-1-hch@lst.de>
 <20211021090611.488281-5-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211021090611.488281-5-hch@lst.de>
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
> Add a local variable to track if we want to remap the returned address
> using vmap and use that to simplify the code flow.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/direct.c | 47 +++++++++++++++++++++++----------------------
>   1 file changed, 24 insertions(+), 23 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 60cb75aa6778e..a6b6fe72af4d1 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -166,6 +166,7 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
>   void *dma_direct_alloc(struct device *dev, size_t size,
>   		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>   {
> +	bool remap = false;

How about also adding a "bool set_uncached = false"...

>   	struct page *page;
>   	void *ret;
>   
> @@ -217,9 +218,23 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   	if (!page)
>   		return NULL;
>   
> -	if ((IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> -	     !dev_is_dma_coherent(dev)) ||
> -	    (IS_ENABLED(CONFIG_DMA_REMAP) && PageHighMem(page))) {
> +	if (!dev_is_dma_coherent(dev) && IS_ENABLED(CONFIG_DMA_DIRECT_REMAP)) {
> +		remap = true;
> +	} else if (PageHighMem(page)) {
> +		/*
> +		 * Depending on the cma= arguments and per-arch setup,
> +		 * dma_alloc_contiguous could return highmem pages.
> +		 * Without remapping there is no way to return them here, so
> +		 * log an error and fail.
> +		 */
> +		if (!IS_ENABLED(CONFIG_DMA_REMAP)) {
> +			dev_info(dev, "Rejecting highmem page from CMA.\n");
> +			goto out_free_pages;
> +		}
> +		remap = true;
> +	}

...then "else if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED))
		set_uncached = true;"...

> +
> +	if (remap) {
>   		/* remove any dirty cache lines on the kernel alias */
>   		arch_dma_prep_coherent(page, size);
>   
> @@ -229,36 +244,22 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   				__builtin_return_address(0));
>   		if (!ret)
>   			goto out_free_pages;
> -		if (dma_set_decrypted(dev, ret, size))
> -			goto out_unmap_pages;
> -		memset(ret, 0, size);
> -		goto done;
> -	}
> -
> -	if (PageHighMem(page)) {
> -		/*
> -		 * Depending on the cma= arguments and per-arch setup
> -		 * dma_alloc_contiguous could return highmem pages.
> -		 * Without remapping there is no way to return them here,
> -		 * so log an error and fail.
> -		 */
> -		dev_info(dev, "Rejecting highmem page from CMA.\n");
> -		goto out_free_pages;
> +	} else {
> +		ret = page_address(page);

As before, I'm thinking that dma_set_decrypted() probably belongs in here.

>   	}
>   
> -	ret = page_address(page);
>   	if (dma_set_decrypted(dev, ret, size))
> -		goto out_free_pages;
> +		goto out_unmap_pages;
>   	memset(ret, 0, size);
>   
> -	if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
> -	    !dev_is_dma_coherent(dev)) {
> +	if (!dev_is_dma_coherent(dev) && !remap &&
> +	    IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED)) {

...then from earlier we'd have just a nice "if (set_uncached)" here?

>   		arch_dma_prep_coherent(page, size);
>   		ret = arch_dma_set_uncached(ret, size);
>   		if (IS_ERR(ret))
>   			goto out_encrypt_pages;

 From a quick Kconfig survey, this is a purely theoretical exercise in 
dead code generation. Let's just be pragmatic, stick in a
"BUILD_BUG_ON(IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) && 
IS_ENABLED(CONFIG_ARCH_HAS_MEM_ENCRYPT));" and leave this re-encryption 
case for theoretical future arch maintainers to worry about.

All that said, I'm also now wondering why the arch_set_dma_uncached() 
call is down here in the first place. If we could do it at as an else 
case of the remapping stage (given that it's a semantically equivalent 
operation), the complexity inherently falls away.

>   	}
> -done:
> +
>   	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
>   	return ret;
>   
> 

If the "out_unmap_pages" step is even still necessary, I think the 
condition there should now simplify down to "if (remap)" as well.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
