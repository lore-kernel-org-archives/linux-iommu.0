Return-Path: <SRS0=fO5g=PU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA537C433EF
	for <iommu@archiver.kernel.org>; Mon,  1 Nov 2021 08:35:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83F0A60FD9
	for <iommu@archiver.kernel.org>; Mon,  1 Nov 2021 08:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 83F0A60FD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C60C606D9;
	Mon,  1 Nov 2021 08:35:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sjub705zM_bD; Mon,  1 Nov 2021 08:35:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8635460613;
	Mon,  1 Nov 2021 08:35:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67549C0019;
	Mon,  1 Nov 2021 08:35:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 833BCC000E
 for <iommu@lists.linux-foundation.org>; Mon,  1 Nov 2021 08:35:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 70AAB6063C
 for <iommu@lists.linux-foundation.org>; Mon,  1 Nov 2021 08:35:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JQG_KGOm74du for <iommu@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 08:34:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 038DB60613
 for <iommu@lists.linux-foundation.org>; Mon,  1 Nov 2021 08:34:55 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9735560F46
 for <iommu@lists.linux-foundation.org>; Mon,  1 Nov 2021 08:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635755695;
 bh=obeo4arX2BcSuRDdS9k9PamPIZJFgpOtT0SeoVp8Vtg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=UFIwWTzawtcc6PC1NEffH3E+HJQucMTcYfc9JzH6RVIkYZb+rJQkasPbW6qu9m8MJ
 mPLG2n/rxnrgZ+rQdM9GzYRdYMQEOSI22G1i04I6R0KEJDlB9Pzy9kGSv5H8j0y5xi
 zY+/083SME90EYoQQDb5teZHpmWIOQctHoLm3SPochR1kMZIml2NtWepojNHL8gAKl
 9xPNfy4tYedrmP4uwxSnOlzfvHHd6SlMnStCQ1OmnaunVp0juYfsOwzrFaSOXqNgfT
 SUHTYRDclf7O/64NTfRP2Rkb/LI17TTMCzFtqe0uMJ3mOsuMoIpTW/kKoGuWAr4cYD
 b0MVQph+yoprw==
Received: by mail-oi1-f171.google.com with SMTP id u2so4756503oiu.12
 for <iommu@lists.linux-foundation.org>; Mon, 01 Nov 2021 01:34:55 -0700 (PDT)
X-Gm-Message-State: AOAM533OotRQCD8GwLCsNkE6Mv9x05rISOl39QU3AjICFbMrWk1gt6ZP
 iRL+VPP6wJezZwIWDVbIUr3vNA6+/IAMcNfGa3w=
X-Google-Smtp-Source: ABdhPJw9u4sF3GagDkzYyWDjJxayAqxSo5SlRgNq8NAwK5VHTPb+bEN/WnF/aGaG9yS3U1m8w4dyOlys5a7lQf9P8zk=
X-Received: by 2002:aca:3cc1:: with SMTP id
 j184mr12787185oia.174.1635755694924; 
 Mon, 01 Nov 2021 01:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211101031558.7184-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20211101031558.7184-1-walter-zh.wu@mediatek.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 1 Nov 2021 09:34:43 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGqOzHM+J30TXR3-uZPkjHBCXB4CMkzZjHbbmptyU5W9w@mail.gmail.com>
Message-ID: <CAMj1kXGqOzHM+J30TXR3-uZPkjHBCXB4CMkzZjHbbmptyU5W9w@mail.gmail.com>
Subject: Re: [PATCH] dma-direct: fix DMA_ATTR_NO_KERNEL_MAPPING
To: Walter Wu <walter-zh.wu@mediatek.com>
Cc: wsd_upstream <wsd_upstream@mediatek.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, 1 Nov 2021 at 04:17, Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> DMA_ATTR_NO_KERNEL_MAPPING is to avoid creating a kernel mapping
> for the allocated buffer, but current implementation is that
> PTE of allocated buffer in kernel page table is valid. So we
> should set invalid for PTE of allocate buffer so that there are
> no kernel mapping for the allocated buffer.
>
> In some cases, we don't hope the allocated buffer to be read
> by cpu or speculative execution, so we use DMA_ATTR_NO_KERNEL_MAPPING
> to get no kernel mapping in order to achieve this goal.
>
> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  kernel/dma/direct.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 4c6c5e0635e3..aa10b4c5d762 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -13,6 +13,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/set_memory.h>
>  #include <linux/slab.h>
> +#include <asm/cacheflush.h>
>  #include "direct.h"
>
>  /*
> @@ -169,6 +170,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>                 if (!PageHighMem(page))
>                         arch_dma_prep_coherent(page, size);
>                 *dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
> +               /* remove kernel mapping for pages */
> +               set_memory_valid((unsigned long)phys_to_virt(dma_to_phys(dev, *dma_handle)),
> +                               size >> PAGE_SHIFT, 0);

This only works if the memory is mapped at page granularity in the
linear region, and you cannot rely on that. Many architectures prefer
block mappings for the linear region, and arm64 will only use page
mappings if rodata=full is set (which is set by default but can be
overridden on the kernel command line)


>                 /* return the page pointer as the opaque cookie */
>                 return page;
>         }
> @@ -278,6 +282,10 @@ void dma_direct_free(struct device *dev, size_t size,
>
>         if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
>             !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev)) {
> +               size = PAGE_ALIGN(size);
> +               /* create kernel mapping for pages */
> +               set_memory_valid((unsigned long)phys_to_virt(dma_to_phys(dev, dma_addr)),
> +                               size >> PAGE_SHIFT, 1);
>                 /* cpu_addr is a struct page cookie, not a kernel address */
>                 dma_free_contiguous(dev, cpu_addr, size);
>                 return;
> --
> 2.18.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
