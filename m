Return-Path: <SRS0=wClR=S7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5794C04AA6
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 13:21:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C6392053B
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 13:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C6392053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 471842122;
	Mon, 29 Apr 2019 13:21:12 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E5C882116
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 13:18:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 84AA8711
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 13:18:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4441AA78;
	Mon, 29 Apr 2019 06:18:05 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCF433F71A;
	Mon, 29 Apr 2019 06:18:03 -0700 (PDT)
Subject: Re: [PATCH 13/26] iommu/dma: Remove __iommu_dma_free
To: Christoph Hellwig <hch@lst.de>
References: <20190422175942.18788-1-hch@lst.de>
	<20190422175942.18788-14-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <9c53d0e6-3692-e151-c64b-0070a89ca725@arm.com>
Date: Mon, 29 Apr 2019 14:18:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422175942.18788-14-hch@lst.de>
Content-Language: en-GB
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190429131802.SMYQt7qv91vwEpuffOPmvXSM8xbZ9pvzL3nqP1w-TgQ@z>

On 22/04/2019 18:59, Christoph Hellwig wrote:
> We only have a single caller of this function left, so open code it there.

Heh, I even caught myself out for a moment thinking this looked 
redundant with #18 now, but no :)

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/dma-iommu.c | 21 ++-------------------
>   1 file changed, 2 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index b8e46e89a60a..4632b9d301a1 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -534,24 +534,6 @@ static struct page **__iommu_dma_get_pages(void *cpu_addr)
>   	return area->pages;
>   }
>   
> -/**
> - * iommu_dma_free - Free a buffer allocated by iommu_dma_alloc_remap()
> - * @dev: Device which owns this buffer
> - * @pages: Array of buffer pages as returned by __iommu_dma_alloc_remap()
> - * @size: Size of buffer in bytes
> - * @handle: DMA address of buffer
> - *
> - * Frees both the pages associated with the buffer, and the array
> - * describing them
> - */
> -static void __iommu_dma_free(struct device *dev, struct page **pages,
> -		size_t size, dma_addr_t *handle)
> -{
> -	__iommu_dma_unmap(dev, *handle, size);
> -	__iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
> -	*handle = DMA_MAPPING_ERROR;
> -}
> -
>   /**
>    * iommu_dma_alloc_remap - Allocate and map a buffer contiguous in IOVA space
>    * @dev: Device to allocate memory for. Must be a real device
> @@ -1034,7 +1016,8 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
>   
>   		if (WARN_ON(!pages))
>   			return;
> -		__iommu_dma_free(dev, pages, iosize, &handle);
> +		__iommu_dma_unmap(dev, handle, iosize);
> +		__iommu_dma_free_pages(pages, size >> PAGE_SHIFT);
>   		dma_common_free_remap(cpu_addr, size, VM_USERMAP);
>   	} else {
>   		__iommu_dma_unmap(dev, handle, iosize);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
