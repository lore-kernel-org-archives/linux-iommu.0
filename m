Return-Path: <SRS0=75oM=PX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C51C433EF
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 12:35:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 707B9611EF
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 12:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 707B9611EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48EA140571;
	Thu,  4 Nov 2021 12:35:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cstw0EgTmi74; Thu,  4 Nov 2021 12:35:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1C09A404C3;
	Thu,  4 Nov 2021 12:35:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04F81C0019;
	Thu,  4 Nov 2021 12:35:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45782C000E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:35:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 281F380F94
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:35:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5_87k0GS44T2 for <iommu@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 12:35:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2F8B880DD1
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:35:38 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74AB81063;
 Thu,  4 Nov 2021 05:35:36 -0700 (PDT)
Received: from [10.57.80.217] (unknown [10.57.80.217])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5537E3F7D7;
 Thu,  4 Nov 2021 05:35:35 -0700 (PDT)
Message-ID: <35a26087-ed44-c8fc-4ef7-c8f329aa683f@arm.com>
Date: Thu, 4 Nov 2021 12:35:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 01/10] dma-direct: factor out dma_set_{de,en}crypted
 helpers
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
References: <20211021090611.488281-1-hch@lst.de>
 <20211021090611.488281-2-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211021090611.488281-2-hch@lst.de>
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
> Factor out helpers the make dealing with memory encryption a little less
> cumbersome.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/direct.c | 56 ++++++++++++++++++++-------------------------
>   1 file changed, 25 insertions(+), 31 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 4c6c5e0635e34..d4d54af31a341 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -75,6 +75,20 @@ static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
>   		min_not_zero(dev->coherent_dma_mask, dev->bus_dma_limit);
>   }
>   
> +static int dma_set_decrypted(struct device *dev, void *vaddr, size_t size)
> +{
> +	if (!force_dma_unencrypted(dev))
> +		return 0;
> +	return set_memory_decrypted((unsigned long)vaddr, 1 << get_order(size));
> +}
> +
> +static int dma_set_encrypted(struct device *dev, void *vaddr, size_t size)
> +{
> +	if (!force_dma_unencrypted(dev))
> +		return 0;
> +	return set_memory_encrypted((unsigned long)vaddr, 1 << get_order(size));
> +}
> +
>   static void __dma_direct_free_pages(struct device *dev, struct page *page,
>   				    size_t size)
>   {
> @@ -154,7 +168,6 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   {
>   	struct page *page;
>   	void *ret;
> -	int err;
>   
>   	size = PAGE_ALIGN(size);
>   	if (attrs & DMA_ATTR_NO_WARN)
> @@ -216,12 +229,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   				__builtin_return_address(0));
>   		if (!ret)
>   			goto out_free_pages;
> -		if (force_dma_unencrypted(dev)) {
> -			err = set_memory_decrypted((unsigned long)ret,
> -						   1 << get_order(size));
> -			if (err)
> -				goto out_free_pages;
> -		}
> +		if (dma_set_decrypted(dev, ret, size))
> +			goto out_free_pages;
>   		memset(ret, 0, size);
>   		goto done;
>   	}
> @@ -238,13 +247,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   	}
>   
>   	ret = page_address(page);
> -	if (force_dma_unencrypted(dev)) {
> -		err = set_memory_decrypted((unsigned long)ret,
> -					   1 << get_order(size));
> -		if (err)
> -			goto out_free_pages;
> -	}
> -
> +	if (dma_set_decrypted(dev, ret, size))
> +		goto out_free_pages;
>   	memset(ret, 0, size);
>   
>   	if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
> @@ -259,13 +263,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   	return ret;
>   
>   out_encrypt_pages:
> -	if (force_dma_unencrypted(dev)) {
> -		err = set_memory_encrypted((unsigned long)page_address(page),
> -					   1 << get_order(size));
> -		/* If memory cannot be re-encrypted, it must be leaked */
> -		if (err)
> -			return NULL;
> -	}
> +	/* If memory cannot be re-encrypted, it must be leaked */
> +	if (dma_set_encrypted(dev, page_address(page), size))
> +		return NULL;
>   out_free_pages:
>   	__dma_direct_free_pages(dev, page, size);
>   	return NULL;
> @@ -304,8 +304,7 @@ void dma_direct_free(struct device *dev, size_t size,
>   	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
>   		return;
>   
> -	if (force_dma_unencrypted(dev))
> -		set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
> +	dma_set_encrypted(dev, cpu_addr, 1 << page_order);
>   
>   	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr))
>   		vunmap(cpu_addr);
> @@ -341,11 +340,8 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>   	}
>   
>   	ret = page_address(page);
> -	if (force_dma_unencrypted(dev)) {
> -		if (set_memory_decrypted((unsigned long)ret,
> -				1 << get_order(size)))
> -			goto out_free_pages;
> -	}
> +	if (dma_set_decrypted(dev, ret, size))
> +		goto out_free_pages;
>   	memset(ret, 0, size);
>   	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
>   	return page;
> @@ -366,9 +362,7 @@ void dma_direct_free_pages(struct device *dev, size_t size,
>   	    dma_free_from_pool(dev, vaddr, size))
>   		return;
>   
> -	if (force_dma_unencrypted(dev))
> -		set_memory_encrypted((unsigned long)vaddr, 1 << page_order);
> -
> +	dma_set_encrypted(dev, vaddr, 1 << page_order);
>   	__dma_direct_free_pages(dev, page, size);
>   }
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
