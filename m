Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C8EC433EF
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 16:33:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98AB984B5E;
	Mon,  6 Dec 2021 16:33:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5n7TOiX5NPgD; Mon,  6 Dec 2021 16:33:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 46E1B84B62;
	Mon,  6 Dec 2021 16:33:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8459C001E;
	Mon,  6 Dec 2021 16:33:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B87FC0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 16:33:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 099E44022D
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 16:33:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B4f7h6CIJKWa for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 16:33:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id DFBA9400FB
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 16:33:07 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48CFD1042;
 Mon,  6 Dec 2021 08:33:06 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 824803F73B;
 Mon,  6 Dec 2021 08:33:05 -0800 (PST)
Message-ID: <6a8f8c40-a3bd-9dac-fbf1-8feeca8ac554@arm.com>
Date: Mon, 6 Dec 2021 16:32:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 03/11] dma-direct: always leak memory that can't be
 re-encrypted
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
References: <20211111065028.32761-1-hch@lst.de>
 <20211111065028.32761-4-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211111065028.32761-4-hch@lst.de>
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
> We must never unencryped memory go back into the general page pool.
> So if we fail to set it back to encrypted when freeing DMA memory, leak
> the memory insted and warn the user.

Nit: typos of "unencrypted" and "instead". Plus presumably the first 
sentence was meant to have a "let" or similar in there too.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/direct.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 996ba4edb2fa3..d7a489be48470 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -84,9 +84,14 @@ static int dma_set_decrypted(struct device *dev, void *vaddr, size_t size)
>   
>   static int dma_set_encrypted(struct device *dev, void *vaddr, size_t size)
>   {
> +	int ret;
> +
>   	if (!force_dma_unencrypted(dev))
>   		return 0;
> -	return set_memory_encrypted((unsigned long)vaddr, 1 << get_order(size));
> +	ret = set_memory_encrypted((unsigned long)vaddr, 1 << get_order(size));
> +	if (ret)
> +		pr_warn_ratelimited("leaking DMA memory that can't be re-encrypted\n");
> +	return ret;
>   }
>   
>   static void __dma_direct_free_pages(struct device *dev, struct page *page,
> @@ -261,7 +266,6 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   	return ret;
>   
>   out_encrypt_pages:
> -	/* If memory cannot be re-encrypted, it must be leaked */
>   	if (dma_set_encrypted(dev, page_address(page), size))
>   		return NULL;
>   out_free_pages:
> @@ -307,7 +311,8 @@ void dma_direct_free(struct device *dev, size_t size,
>   	} else {
>   		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
>   			arch_dma_clear_uncached(cpu_addr, size);
> -		dma_set_encrypted(dev, cpu_addr, 1 << page_order);
> +		if (dma_set_encrypted(dev, cpu_addr, 1 << page_order))
> +			return;
>   	}
>   
>   	__dma_direct_free_pages(dev, dma_direct_to_page(dev, dma_addr), size);
> @@ -361,7 +366,8 @@ void dma_direct_free_pages(struct device *dev, size_t size,
>   	    dma_free_from_pool(dev, vaddr, size))
>   		return;
>   
> -	dma_set_encrypted(dev, vaddr, 1 << page_order);
> +	if (dma_set_encrypted(dev, vaddr, 1 << page_order))
> +		return;
>   	__dma_direct_free_pages(dev, page, size);
>   }
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
