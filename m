Return-Path: <SRS0=75oM=PX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558ADC433EF
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 12:35:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 108EB611EF
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 12:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 108EB611EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF0244059B;
	Thu,  4 Nov 2021 12:35:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6orekg6APeO1; Thu,  4 Nov 2021 12:35:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 81D9840571;
	Thu,  4 Nov 2021 12:35:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FB64C0019;
	Thu,  4 Nov 2021 12:35:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B76D4C000E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:35:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 99ED560886
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:35:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id COEbIRHc846a for <iommu@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 12:35:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 88E326086E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:35:51 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E765E1063;
 Thu,  4 Nov 2021 05:35:50 -0700 (PDT)
Received: from [10.57.80.217] (unknown [10.57.80.217])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5495E3F7D7;
 Thu,  4 Nov 2021 05:35:50 -0700 (PDT)
Message-ID: <8556aafc-f006-ad25-3bd0-0664d06dcaaf@arm.com>
Date: Thu, 4 Nov 2021 12:35:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 03/10] dma-direct: leak memory that can't be re-encrypted
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
References: <20211021090611.488281-1-hch@lst.de>
 <20211021090611.488281-4-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211021090611.488281-4-hch@lst.de>
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
> We must never unencryped memory go back into the general page pool.
> So if we fail to set it back to encrypted when freeing DMA memory, leak
> the memory insted and warn the user.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/direct.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 2fef8dd401fe9..60cb75aa6778e 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -263,9 +263,11 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   	return ret;
>   
>   out_encrypt_pages:
> -	/* If memory cannot be re-encrypted, it must be leaked */
> -	if (dma_set_encrypted(dev, page_address(page), size))
> +	if (dma_set_encrypted(dev, page_address(page), size)) {
> +		pr_warn_ratelimited(
> +			"leaking DMA memory that can't be re-encrypted\n");

Given that this is consistent for all uses of dma_set_encrypted(), seems 
like it should be factored into the helper itself.

Robin.

>   		return NULL;
> +	}
>   out_unmap_pages:
>   	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(ret))
>   		vunmap(ret);
> @@ -307,7 +309,11 @@ void dma_direct_free(struct device *dev, size_t size,
>   	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
>   		return;
>   
> -	dma_set_encrypted(dev, cpu_addr, 1 << page_order);
> +	if (dma_set_encrypted(dev, cpu_addr, 1 << page_order)) {
> +		pr_warn_ratelimited(
> +			"leaking DMA memory that can't be re-encrypted\n");
> +		return;
> +	}
>   
>   	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr))
>   		vunmap(cpu_addr);
> @@ -365,7 +371,11 @@ void dma_direct_free_pages(struct device *dev, size_t size,
>   	    dma_free_from_pool(dev, vaddr, size))
>   		return;
>   
> -	dma_set_encrypted(dev, vaddr, 1 << page_order);
> +	if (dma_set_encrypted(dev, vaddr, 1 << page_order)) {
> +		pr_warn_ratelimited(
> +			"leaking DMA memory that can't be re-encrypted\n");
> +		return;
> +	}
>   	__dma_direct_free_pages(dev, page, size);
>   }
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
