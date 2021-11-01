Return-Path: <SRS0=fO5g=PU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA8EC433FE
	for <iommu@archiver.kernel.org>; Mon,  1 Nov 2021 14:17:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CB6160F58
	for <iommu@archiver.kernel.org>; Mon,  1 Nov 2021 14:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9CB6160F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71B0F80CF7;
	Mon,  1 Nov 2021 14:17:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NfVskUd1X3ND; Mon,  1 Nov 2021 14:17:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 453B380CFC;
	Mon,  1 Nov 2021 14:17:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E595C0019;
	Mon,  1 Nov 2021 14:17:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 184C7C000E
 for <iommu@lists.linux-foundation.org>; Mon,  1 Nov 2021 14:17:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 06E6F80CFC
 for <iommu@lists.linux-foundation.org>; Mon,  1 Nov 2021 14:17:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VoWt0D8MC-rA for <iommu@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 14:17:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 29AD880CF7
 for <iommu@lists.linux-foundation.org>; Mon,  1 Nov 2021 14:17:26 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADF2561058
 for <iommu@lists.linux-foundation.org>; Mon,  1 Nov 2021 14:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635776245;
 bh=YseqVJrHR7rIwk1Wkg7bXw9N3GSGkFjmGgMqZlAIww0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=qAS4RW253o/aPKrkn/TPqputjRnBTQYs4GdDZS/Kerln6MSUDwbTa1FUJAXfT9bXw
 vp9+coeWw4ZFxBvQWq/ZyHnHf8itNYrCVeSR9VJtziPNoto6KbNhX8yn7dbUkh1znh
 3l+2WMG1/3ZETyAy2M92C32hSbLxdAW9ovpMJeXivTVW8nE+Ba+mqZV6/c+bOtxydS
 U6y7MHrSBlwXuRzxJoOEIdgISM4hPhYp+zdFNfdhJ+eWV7DZGpCV1FFHlB0pweZpCl
 tCRUZyfE0rRg/aYlD1kpe1j7e3oJsXPfI+5X+iQf17kwyO84twOjBwdRSEaQ+ueYVt
 N1bRlqxbTqlTg==
Received: by mail-oi1-f172.google.com with SMTP id n11so16990242oig.6
 for <iommu@lists.linux-foundation.org>; Mon, 01 Nov 2021 07:17:25 -0700 (PDT)
X-Gm-Message-State: AOAM533lHfOQwFTk6oLj9z8s6zrezKU7HqDBi6TPcrfyvq4jjI82hxL1
 7LdhR4owo/mFzxqyKxIcoIuaZzi4hwS5udSNNwU=
X-Google-Smtp-Source: ABdhPJxOXIuTNzqz1i2MYTktHa+hdjvUeJScl8qV7kA68t3cZIj0tYQxHF0FaYTt+YNAwRP/dwuEZad0WfxqaUhVXts=
X-Received: by 2002:a05:6808:4d9:: with SMTP id
 a25mr19998210oie.33.1635776245009; 
 Mon, 01 Nov 2021 07:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211101031558.7184-1-walter-zh.wu@mediatek.com>
 <CAMj1kXGqOzHM+J30TXR3-uZPkjHBCXB4CMkzZjHbbmptyU5W9w@mail.gmail.com>
 <76840b40fcf26a65467931a73f236982ad39989c.camel@mediatek.com>
In-Reply-To: <76840b40fcf26a65467931a73f236982ad39989c.camel@mediatek.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 1 Nov 2021 15:17:12 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFrUrThJFDJ0Q9qjDemcEovQVMtO20KbdnLccp7VfyVwA@mail.gmail.com>
Message-ID: <CAMj1kXFrUrThJFDJ0Q9qjDemcEovQVMtO20KbdnLccp7VfyVwA@mail.gmail.com>
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

On Mon, 1 Nov 2021 at 13:21, Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> Hi Ard,
>
> On Mon, 2021-11-01 at 09:34 +0100, Ard Biesheuvel wrote:
> > On Mon, 1 Nov 2021 at 04:17, Walter Wu <walter-zh.wu@mediatek.com>
> > wrote:
> > >
> > > DMA_ATTR_NO_KERNEL_MAPPING is to avoid creating a kernel mapping
> > > for the allocated buffer, but current implementation is that
> > > PTE of allocated buffer in kernel page table is valid. So we
> > > should set invalid for PTE of allocate buffer so that there are
> > > no kernel mapping for the allocated buffer.
> > >
> > > In some cases, we don't hope the allocated buffer to be read
> > > by cpu or speculative execution, so we use
> > > DMA_ATTR_NO_KERNEL_MAPPING
> > > to get no kernel mapping in order to achieve this goal.
> > >
> > > Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > ---
> > >  kernel/dma/direct.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > > index 4c6c5e0635e3..aa10b4c5d762 100644
> > > --- a/kernel/dma/direct.c
> > > +++ b/kernel/dma/direct.c
> > > @@ -13,6 +13,7 @@
> > >  #include <linux/vmalloc.h>
> > >  #include <linux/set_memory.h>
> > >  #include <linux/slab.h>
> > > +#include <asm/cacheflush.h>
> > >  #include "direct.h"
> > >
> > >  /*
> > > @@ -169,6 +170,9 @@ void *dma_direct_alloc(struct device *dev,
> > > size_t size,
> > >                 if (!PageHighMem(page))
> > >                         arch_dma_prep_coherent(page, size);
> > >                 *dma_handle = phys_to_dma_direct(dev,
> > > page_to_phys(page));
> > > +               /* remove kernel mapping for pages */
> > > +               set_memory_valid((unsigned
> > > long)phys_to_virt(dma_to_phys(dev, *dma_handle)),
> > > +                               size >> PAGE_SHIFT, 0);
> >
> > This only works if the memory is mapped at page granularity in the
> > linear region, and you cannot rely on that. Many architectures prefer
> > block mappings for the linear region, and arm64 will only use page
> > mappings if rodata=full is set (which is set by default but can be
> > overridden on the kernel command line)
> >
>
> We mainly want to solve arm64 arch.

Solve what?

> RODATA_FULL_DEFAULT_ENABLED should
> be the arm64 config. If we use CONFIG_RODATA_FULL_DEFAULT_ENABLED to
> check whether it call set_memory_valid(). It should avoid other
> architectures. Do you think this method is work?
>

No. Try it with rodata=off (or rodata=on for that matter) and see what happens.

> Thanks for your explaination and suggestion.
>

YW

>
> >
> > >                 /* return the page pointer as the opaque cookie */
> > >                 return page;
> > >         }
> > > @@ -278,6 +282,10 @@ void dma_direct_free(struct device *dev,
> > > size_t size,
> > >
> > >         if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> > >             !force_dma_unencrypted(dev) &&
> > > !is_swiotlb_for_alloc(dev)) {
> > > +               size = PAGE_ALIGN(size);
> > > +               /* create kernel mapping for pages */
> > > +               set_memory_valid((unsigned
> > > long)phys_to_virt(dma_to_phys(dev, dma_addr)),
> > > +                               size >> PAGE_SHIFT, 1);
> > >                 /* cpu_addr is a struct page cookie, not a kernel
> > > address */
> > >                 dma_free_contiguous(dev, cpu_addr, size);
> > >                 return;
> > > --
> > > 2.18.0
> > >
> > >
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > >
> https://urldefense.com/v3/__http://lists.infradead.org/mailman/listinfo/linux-arm-kernel__;!!CTRNKA9wMg0ARbw!16dLCjnvtRkaRLeCO9AQ7Fund5XL0FicZmeVaU3-WkFymr-0lbITfzwrvoJpiHlqnqIu-g$
> > >
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
