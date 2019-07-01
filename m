Return-Path: <SRS0=o8L7=U6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B58C06510
	for <iommu@archiver.kernel.org>; Mon,  1 Jul 2019 09:11:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44214213F2
	for <iommu@archiver.kernel.org>; Mon,  1 Jul 2019 09:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44214213F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C8CFC721C;
	Mon,  1 Jul 2019 09:11:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E20F3721B
	for <iommu@lists.linux-foundation.org>;
	Mon,  1 Jul 2019 09:11:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
	[209.85.210.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3FF5B84C
	for <iommu@lists.linux-foundation.org>;
	Mon,  1 Jul 2019 09:11:57 +0000 (UTC)
Received: by mail-ot1-f68.google.com with SMTP id q20so12741025otl.0
	for <iommu@lists.linux-foundation.org>;
	Mon, 01 Jul 2019 02:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=vrfkJssjVDLW+XqYQpIBNfx1iw/D41O+Rgdu06lVQjo=;
	b=L3OhmQoVgo9SsNPzDuzg5Fz+EZqSYW/ERZHLIuW2kfCGBP2vPtP/Li9l4X+nj/APan
	7C6pfcRHrW4bKFy+LNhQgQQk0BdxR0BJsW11OnrUNo57XzVzTbi/Zz5+WwKEy8QUtLuA
	TpWIeS+seGG7ZMScf804aAk7jpiSpsY+KLjZTw56dxzjXovZKY1SjyH2Zqw858yhe/1D
	2P6+SwFZtpS1qLpqbaaLxPId/ofZjFXxTCARTD0rLq88BJf6dGu/U4cUFT/H/EcvksC6
	0KVrju2npNHASFN1vtCKDwkoowJXMACGIhzHFWxONrCBDCHYat8dz7oLmPW40WFaXRqs
	GxIw==
X-Gm-Message-State: APjAAAW6bWMirsnTPZbn/BKlkYc4iEg6KARUnOCq8skoIYV/FQSMzgyW
	GYtY+A2UGzyb80R6rme+RdhfSRxGQNOMMzLNljo=
X-Google-Smtp-Source: APXvYqzVk/OyjjzY0nFtClX5qDGpGeyg9GkiF4n9W945/G5IBkuHr61awlT7Lm9v1RLyJvTz3n3CldjmYOSicw0m17c=
X-Received: by 2002:a9d:2f03:: with SMTP id h3mr18782897otb.107.1561972316496; 
	Mon, 01 Jul 2019 02:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190625090135.18872-1-hch@lst.de>
	<20190625090135.18872-2-hch@lst.de>
In-Reply-To: <20190625090135.18872-2-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 1 Jul 2019 11:11:45 +0200
Message-ID: <CAMuHMdUqVi61Uf15w4xxDVDmHU1mAyipq75otE7j14C3tLjMmw@mail.gmail.com>
Subject: Re: [PATCH 1/2] m68k: use the generic dma coherent remap allocator
To: Christoph Hellwig <hch@lst.de>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Christoph,

On Tue, Jun 25, 2019 at 11:01 AM Christoph Hellwig <hch@lst.de> wrote:
> This switche to using common code for the DMA allocations, including

switches m68k

> potential use of the CMA allocator if configure.  Also add a

configured

> comment where the existing behavior seems to be lacking.
>
> Switching to the generic code enables DMA allocations from atomic
> context, which is required by the DMA API documentation, and also
> adds various other minor features drivers start relying upon.  It
> also makes sure we have on tested code base for all architectures

a tested code base

> that require uncached pte bits for coherent DMA allocations.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks, applying and queueing for v5.3.

> --- a/arch/m68k/kernel/dma.c
> +++ b/arch/m68k/kernel/dma.c
> @@ -18,57 +18,20 @@
>  #include <asm/pgalloc.h>
>
>  #if defined(CONFIG_MMU) && !defined(CONFIG_COLDFIRE)
> -
> -void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
> -               gfp_t flag, unsigned long attrs)
> +pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
> +               unsigned long attrs)
>  {
> -       struct page *page, **map;
> -       pgprot_t pgprot;
> -       void *addr;
> -       int i, order;
> -
> -       pr_debug("dma_alloc_coherent: %d,%x\n", size, flag);
> -
> -       size = PAGE_ALIGN(size);
> -       order = get_order(size);
> -
> -       page = alloc_pages(flag | __GFP_ZERO, order);
> -       if (!page)
> -               return NULL;
> -
> -       *handle = page_to_phys(page);
> -       map = kmalloc(sizeof(struct page *) << order, flag & ~__GFP_DMA);
> -       if (!map) {
> -               __free_pages(page, order);
> -               return NULL;
> +       /*
> +        * XXX: this doesn't seem to handle the sun3 MMU at all.

Correct.  This file is not compiled on Sun-3, which selects NO_DMA, so
I'll drop the comment while applying.

> +        */
> +       if (CPU_IS_040_OR_060) {
> +               pgprot_val(prot) &= ~_PAGE_CACHE040;
> +               pgprot_val(prot) |= _PAGE_GLOBAL040 | _PAGE_NOCACHE_S;
> +       } else {
> +               pgprot_val(prot) |= _PAGE_NOCACHE030;
>         }
> -       split_page(page, order);
> -
> -       order = 1 << order;
> -       size >>= PAGE_SHIFT;
> -       map[0] = page;
> -       for (i = 1; i < size; i++)
> -               map[i] = page + i;
> -       for (; i < order; i++)
> -               __free_page(page + i);
> -       pgprot = __pgprot(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_DIRTY);
> -       if (CPU_IS_040_OR_060)
> -               pgprot_val(pgprot) |= _PAGE_GLOBAL040 | _PAGE_NOCACHE_S;
> -       else
> -               pgprot_val(pgprot) |= _PAGE_NOCACHE030;
> -       addr = vmap(map, size, VM_MAP, pgprot);
> -       kfree(map);
> -
> -       return addr;
> +       return prot;
>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
