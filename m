Return-Path: <SRS0=fO5g=PU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81919C433F5
	for <iommu@archiver.kernel.org>; Mon,  1 Nov 2021 10:29:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A3FD610E5
	for <iommu@archiver.kernel.org>; Mon,  1 Nov 2021 10:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2A3FD610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EAF8440132;
	Mon,  1 Nov 2021 10:29:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HgmS-b4eBeeD; Mon,  1 Nov 2021 10:29:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C4B2340130;
	Mon,  1 Nov 2021 10:29:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D5A5C0019;
	Mon,  1 Nov 2021 10:29:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B20ADC000E
 for <iommu@lists.linux-foundation.org>; Mon,  1 Nov 2021 10:29:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 92D9B401B0
 for <iommu@lists.linux-foundation.org>; Mon,  1 Nov 2021 10:29:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SrPqBGJHDDe2 for <iommu@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 10:29:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2AA3B40010
 for <iommu@lists.linux-foundation.org>; Mon,  1 Nov 2021 10:29:28 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2382411B3;
 Mon,  1 Nov 2021 03:29:28 -0700 (PDT)
Received: from [10.57.80.217] (unknown [10.57.80.217])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21D2B3F719;
 Mon,  1 Nov 2021 03:29:26 -0700 (PDT)
Message-ID: <0316e4f0-b0ad-c702-676f-36347b4ebcb1@arm.com>
Date: Mon, 1 Nov 2021 10:29:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] dma-direct: fix DMA_ATTR_NO_KERNEL_MAPPING
Content-Language: en-GB
To: Walter Wu <walter-zh.wu@mediatek.com>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
References: <20211101031558.7184-1-walter-zh.wu@mediatek.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211101031558.7184-1-walter-zh.wu@mediatek.com>
Cc: wsd_upstream <wsd_upstream@mediatek.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
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

On 2021-11-01 03:15, Walter Wu wrote:
> DMA_ATTR_NO_KERNEL_MAPPING is to avoid creating a kernel mapping
> for the allocated buffer, but current implementation is that
> PTE of allocated buffer in kernel page table is valid. So we
> should set invalid for PTE of allocate buffer so that there are
> no kernel mapping for the allocated buffer.

No, the semantic of NO_KERNEL_MAPPING is an indication that the *caller* 
does not need a mapping, such that the DMA API implementation may choose 
to optimise for that internally. It has never given any guarantee of any 
particular behaviour - like most attributes it is only a hint.

> In some cases, we don't hope the allocated buffer to be read
> by cpu or speculative execution, so we use DMA_ATTR_NO_KERNEL_MAPPING
> to get no kernel mapping in order to achieve this goal.

If it's important that no CPU accesses to this memory can happen, then I 
think the only way to absolutely guarantee that is to exclude it from 
the kernel's memory map in the first place, e.g. as a DT reserved-memory 
region with the "no-map" property.

Robin.

> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>   kernel/dma/direct.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 4c6c5e0635e3..aa10b4c5d762 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -13,6 +13,7 @@
>   #include <linux/vmalloc.h>
>   #include <linux/set_memory.h>
>   #include <linux/slab.h>
> +#include <asm/cacheflush.h>
>   #include "direct.h"
>   
>   /*
> @@ -169,6 +170,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   		if (!PageHighMem(page))
>   			arch_dma_prep_coherent(page, size);
>   		*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
> +		/* remove kernel mapping for pages */
> +		set_memory_valid((unsigned long)phys_to_virt(dma_to_phys(dev, *dma_handle)),
> +				size >> PAGE_SHIFT, 0);
>   		/* return the page pointer as the opaque cookie */
>   		return page;
>   	}
> @@ -278,6 +282,10 @@ void dma_direct_free(struct device *dev, size_t size,
>   
>   	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
>   	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev)) {
> +		size = PAGE_ALIGN(size);
> +		/* create kernel mapping for pages */
> +		set_memory_valid((unsigned long)phys_to_virt(dma_to_phys(dev, dma_addr)),
> +				size >> PAGE_SHIFT, 1);
>   		/* cpu_addr is a struct page cookie, not a kernel address */
>   		dma_free_contiguous(dev, cpu_addr, size);
>   		return;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
