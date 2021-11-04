Return-Path: <SRS0=75oM=PX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FA5C433F5
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 12:35:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A27D160E90
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 12:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A27D160E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 798B84058E;
	Thu,  4 Nov 2021 12:35:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IS-0Cwkr2aZ8; Thu,  4 Nov 2021 12:35:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5516A40571;
	Thu,  4 Nov 2021 12:35:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34357C0019;
	Thu,  4 Nov 2021 12:35:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3347C000E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:35:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9582880FF5
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:35:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uvjxSuyPfkV8 for <iommu@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 12:35:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id EEF0A80DD1
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 12:35:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BD7C1063;
 Thu,  4 Nov 2021 05:35:46 -0700 (PDT)
Received: from [10.57.80.217] (unknown [10.57.80.217])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 858A73F7D7;
 Thu,  4 Nov 2021 05:35:45 -0700 (PDT)
Message-ID: <81bc1acc-7701-0f27-f11b-1fd91adde63d@arm.com>
Date: Thu, 4 Nov 2021 12:35:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 02/10] dma-direct: unmapped remapped pages when
 dma_set_decrypted
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
References: <20211021090611.488281-1-hch@lst.de>
 <20211021090611.488281-3-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211021090611.488281-3-hch@lst.de>
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
> When dma_set_decrypted fails for the remapping case in dma_direct_alloc
> we also need to unmap the pages before freeing them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/direct.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index d4d54af31a341..2fef8dd401fe9 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -230,7 +230,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   		if (!ret)
>   			goto out_free_pages;
>   		if (dma_set_decrypted(dev, ret, size))

I was going to say just stick the vunmap() in here to avoid adding yet 
more messy conditionals, but one rabbit hole later... Given that the 
dma_pgprot() we've just passed to dma_common_pages_remap() already adds 
in pgprot_decrypted, why is this even here at all?

Robin.

> -			goto out_free_pages;
> +			goto out_unmap_pages;
>   		memset(ret, 0, size);
>   		goto done;
>   	}
> @@ -266,6 +266,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   	/* If memory cannot be re-encrypted, it must be leaked */
>   	if (dma_set_encrypted(dev, page_address(page), size))
>   		return NULL;
> +out_unmap_pages:
> +	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(ret))
> +		vunmap(ret);
>   out_free_pages:
>   	__dma_direct_free_pages(dev, page, size);
>   	return NULL;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
