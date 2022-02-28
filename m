Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BEDC433FE
	for <iommu@archiver.kernel.org>; Mon, 28 Feb 2022 10:33:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8756760E1E;
	Mon, 28 Feb 2022 10:33:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rYeTuZIhE9sL; Mon, 28 Feb 2022 10:33:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5843960E1B;
	Mon, 28 Feb 2022 10:33:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DF75C0033;
	Mon, 28 Feb 2022 10:33:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B244C001A
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 10:33:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ED7434015D
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 10:33:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nWzj8qb34COA for <iommu@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 10:33:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC6724014B
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 10:33:01 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D76521063;
 Mon, 28 Feb 2022 02:33:00 -0800 (PST)
Received: from [10.57.39.47] (unknown [10.57.39.47])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEC333F70D;
 Mon, 28 Feb 2022 02:32:59 -0800 (PST)
Message-ID: <4802e9fd-733f-3246-92f3-05f590e05d37@arm.com>
Date: Mon, 28 Feb 2022 10:32:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] dma-mapping: remove CONFIG_DMA_REMAP
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
References: <20220227143533.357356-1-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220227143533.357356-1-hch@lst.de>
Cc: x86@kernel.org, will@kernel.org, linux-kernel@vger.kernel.org
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

On 2022-02-27 14:35, Christoph Hellwig wrote:
> CONFIG_DMA_REMAP is used to build a few helpers around the core
> vmalloc code, and to use them in case there is a highmem page in
> dma-direct, and to make dma coherent allocations be able to use
> non-contiguous pages allocations for DMA allocations in the dma-iommu
> layer.
> 
> Right now it needs to be explicitly selected by architectures, and
> is only done so by architectures that require remapping to deal
> with devices that are not DMA coherent.  Make it unconditional for
> builds with CONFIG_MMU as it is very little extra code, but makes
> it much more likely that large DMA allocations succeed on x86.
> 
> This fixes hot plugging a NVMe thunderbolt SSD for me, which tries
> to allocate a 1MB buffer that is otherwise hard to obtain due to
> memory fragmentation on a heavily used laptop.

Simplifying the maze is most welcome, however one thing stands out...

[...]
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 50f48e9e45987..fe1682fecdd57 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -269,10 +269,10 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   		/*
>   		 * Depending on the cma= arguments and per-arch setup,
>   		 * dma_alloc_contiguous could return highmem pages.
> -		 * Without remapping there is no way to return them here, so
> -		 * log an error and fail.
> +		 * Without MMU-based remapping there is no way to return them
> +		 * here, so log an error and fail.
>   		 */
> -		if (!IS_ENABLED(CONFIG_DMA_REMAP)) {
> +		if (!IS_ENABLED(CONFIG_MMU)) {
>   			dev_info(dev, "Rejecting highmem page from CMA.\n");
>   			goto out_free_pages;
>   		}

Is it even possible to hit this case now? From a quick look, all the 
architectures defining HIGHMEM either have an explicit dependency on MMU 
or don't allow deselecting it anyway (plus I don't see how HIGHMEM && 
!MMU could work in general), so I'm pretty sure this whole chunk should 
go away now.

With that (or if there *is* some subtle wacky case where PageHighmem() 
can actually return true for !MMU, a comment to remind us in future),

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Cheers,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
