Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D18DC433F5
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 16:33:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6727607E4;
	Mon,  6 Dec 2021 16:33:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id reo3zOQskikS; Mon,  6 Dec 2021 16:33:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 62F5660791;
	Mon,  6 Dec 2021 16:33:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41A81C001E;
	Mon,  6 Dec 2021 16:33:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3860BC0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 16:33:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 27BA140271
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 16:33:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xpOBXm5XFCux for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 16:33:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 490584026D
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 16:33:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 885B91042;
 Mon,  6 Dec 2021 08:33:15 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5F663F73B;
 Mon,  6 Dec 2021 08:33:14 -0800 (PST)
Message-ID: <4f0109a6-8aea-185a-b73a-0b6e5ed1d514@arm.com>
Date: Mon, 6 Dec 2021 16:33:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 04/11] dma-direct: clean up the remapping checks in
 dma_direct_alloc
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
References: <20211111065028.32761-1-hch@lst.de>
 <20211111065028.32761-5-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211111065028.32761-5-hch@lst.de>
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
> Add two local variables to track if we want to remap the returned
> address using vmap or call dma_set_uncached and use that to simplify
> the code flow.

I still wonder about the asymmetry between the remap and set_uncached 
cases WRT the memset(), which stands out even more the further we clean 
things up, but that's another matter.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/direct.c | 48 ++++++++++++++++++++++++---------------------
>   1 file changed, 26 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index d7a489be48470..3d1718dc077e9 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -171,6 +171,7 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
>   void *dma_direct_alloc(struct device *dev, size_t size,
>   		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>   {
> +	bool remap = false, set_uncached = false;
>   	struct page *page;
>   	void *ret;
>   
> @@ -222,9 +223,25 @@ void *dma_direct_alloc(struct device *dev, size_t size,
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
> +	} else if (!dev_is_dma_coherent(dev) &&
> +		   IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED))
> +		set_uncached = true;
> +
> +	if (remap) {
>   		/* remove any dirty cache lines on the kernel alias */
>   		arch_dma_prep_coherent(page, size);
>   
> @@ -234,34 +251,21 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   				__builtin_return_address(0));
>   		if (!ret)
>   			goto out_free_pages;
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
> +		if (dma_set_decrypted(dev, ret, size))
> +			goto out_free_pages;
>   	}
>   
> -	ret = page_address(page);
> -	if (dma_set_decrypted(dev, ret, size))
> -		goto out_free_pages;
>   	memset(ret, 0, size);
>   
> -	if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
> -	    !dev_is_dma_coherent(dev)) {
> +	if (set_uncached) {
>   		arch_dma_prep_coherent(page, size);
>   		ret = arch_dma_set_uncached(ret, size);
>   		if (IS_ERR(ret))
>   			goto out_encrypt_pages;
>   	}
> -done:
> +
>   	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
>   	return ret;
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
