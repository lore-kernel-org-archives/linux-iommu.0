Return-Path: <SRS0=85Jd=UY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBA3C48BD5
	for <iommu@archiver.kernel.org>; Tue, 25 Jun 2019 08:54:42 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27C0D214DA
	for <iommu@archiver.kernel.org>; Tue, 25 Jun 2019 08:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C0D214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DE6A9CBA;
	Tue, 25 Jun 2019 08:54:41 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D870C9D
	for <iommu@lists.linux-foundation.org>;
	Tue, 25 Jun 2019 05:29:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
	[209.85.166.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BD6D0710
	for <iommu@lists.linux-foundation.org>;
	Tue, 25 Jun 2019 05:29:51 +0000 (UTC)
Received: by mail-io1-f67.google.com with SMTP id m24so856381ioo.2
	for <iommu@lists.linux-foundation.org>;
	Mon, 24 Jun 2019 22:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=MYUiPcf5RNWGOQUq7NpIrQgIK0WGzaR6xdyIKOYFVRU=;
	b=SO2FSKCmyRaXUL5kBVMqj1pHvxZH6wM89RBfrCj2SjxfjNDcSTq6P9Q7LAiOVOzuFq
	mauVF1PcoJsnoPyu2Twi86D4zIg3YL4kpFQePK9JjS7chrUYvdezZlDBGipD67EKCHAu
	JRyQPsKQCqjKkEXm72HF/ft8NkCme3I5E91S39kslt4qDA/uJA9lLPPUWwveUqB00+iK
	raSDelXWcbsXoRFyTBTZyLOCHatVDXery1353SQ19Z+/KxvHRujCXfaOOXorsjiVGBbE
	yxBOVWASPIa08nEdzgot2eL+TvMy8wcr+Nd+o6ZJiXO4lzjBkl9Avu1mvyv1R5svSCUV
	RTSQ==
X-Gm-Message-State: APjAAAUJR1vCksqqZldiYs6BHfIBKZUrfvPdOPEa/s6vVPunClGq036S
	7ST15r5dZX9NT5saUeByDBQs9vVFtV9xy4dIgmc=
X-Google-Smtp-Source: APXvYqzl/YK06q/o3k/iCtkW4OABCLfQXuU0wfB1EvfVqq/jXv0xKo+3GYXqQ5dTbDeIVCET6Wr2KMIs9dGRJlfWIh8=
X-Received: by 2002:a02:8816:: with SMTP id r22mr34047002jai.60.1561440591131; 
	Mon, 24 Jun 2019 22:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190603065324.9724-1-hch@lst.de>
	<20190603065324.9724-2-hch@lst.de>
In-Reply-To: <20190603065324.9724-2-hch@lst.de>
From: Ley Foon Tan <lftan@altera.com>
Date: Tue, 25 Jun 2019 13:29:40 +0800
Message-ID: <CAFiDJ5-HwPR-SWUkYA9=Jn_iHnZ+xWzx6RrcHPNy8kA0jmeZfw@mail.gmail.com>
Subject: Re: [PATCH 1/2] nios2: use the generic uncached segment support in
	dma-direct
To: Christoph Hellwig <hch@lst.de>
X-Mailman-Approved-At: Tue, 25 Jun 2019 08:54:40 +0000
Cc: Michal Simek <monstr@monstr.eu>, linux-mips@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On Mon, Jun 3, 2019 at 2:54 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Stop providing our own arch alloc/free hooks and just expose the segment
> offset and use the generic dma-direct allocator.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Ley Foon Tan <ley.foon.tan@intel.com>

> ---
>  arch/nios2/Kconfig            |  1 +
>  arch/nios2/include/asm/page.h |  6 ------
>  arch/nios2/mm/dma-mapping.c   | 34 +++++++++++++++-------------------
>  3 files changed, 16 insertions(+), 25 deletions(-)
>
> diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
> index 26a9c760a98b..44b5da37e8bd 100644
> --- a/arch/nios2/Kconfig
> +++ b/arch/nios2/Kconfig
> @@ -4,6 +4,7 @@ config NIOS2
>         select ARCH_32BIT_OFF_T
>         select ARCH_HAS_SYNC_DMA_FOR_CPU
>         select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> +       select ARCH_HAS_UNCACHED_SEGMENT
>         select ARCH_NO_SWAP
>         select TIMER_OF
>         select GENERIC_ATOMIC64
> diff --git a/arch/nios2/include/asm/page.h b/arch/nios2/include/asm/page.h
> index f1fbdc47bdaf..79fcac61f6ef 100644
> --- a/arch/nios2/include/asm/page.h
> +++ b/arch/nios2/include/asm/page.h
> @@ -101,12 +101,6 @@ static inline bool pfn_valid(unsigned long pfn)
>  # define VM_DATA_DEFAULT_FLAGS (VM_READ | VM_WRITE | \
>                                  VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
>
> -# define UNCAC_ADDR(addr)      \
> -       ((void *)((unsigned)(addr) | CONFIG_NIOS2_IO_REGION_BASE))
> -# define CAC_ADDR(addr)                \
> -       ((void *)(((unsigned)(addr) & ~CONFIG_NIOS2_IO_REGION_BASE) |   \
> -               CONFIG_NIOS2_KERNEL_REGION_BASE))
> -
>  #include <asm-generic/memory_model.h>
>
>  #include <asm-generic/getorder.h>
> diff --git a/arch/nios2/mm/dma-mapping.c b/arch/nios2/mm/dma-mapping.c
> index 4af9e5b5ba1c..9cb238664584 100644
> --- a/arch/nios2/mm/dma-mapping.c
> +++ b/arch/nios2/mm/dma-mapping.c
> @@ -60,32 +60,28 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
>         }
>  }
>
> -void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
> -               gfp_t gfp, unsigned long attrs)
> +void arch_dma_prep_coherent(struct page *page, size_t size)
>  {
> -       void *ret;
> +       unsigned long start = (unsigned long)page_address(page);
>
> -       /* optimized page clearing */
> -       gfp |= __GFP_ZERO;
> +       flush_dcache_range(start, start + size);
> +}
>
> -       if (dev == NULL || (dev->coherent_dma_mask < 0xffffffff))
> -               gfp |= GFP_DMA;
> +void *uncached_kernel_address(void *ptr)
> +{
> +       unsigned long addr = (unsigned long)ptr;
>
> -       ret = (void *) __get_free_pages(gfp, get_order(size));
> -       if (ret != NULL) {
> -               *dma_handle = virt_to_phys(ret);
> -               flush_dcache_range((unsigned long) ret,
> -                       (unsigned long) ret + size);
> -               ret = UNCAC_ADDR(ret);
> -       }
> +       addr |= CONFIG_NIOS2_IO_REGION_BASE;
>
> -       return ret;
> +       return (void *)ptr;
>  }
>
> -void arch_dma_free(struct device *dev, size_t size, void *vaddr,
> -               dma_addr_t dma_handle, unsigned long attrs)
> +void *cached_kernel_address(void *ptr)
>  {
> -       unsigned long addr = (unsigned long) CAC_ADDR((unsigned long) vaddr);
> +       unsigned long addr = (unsigned long)ptr;
> +
> +       addr &= ~CONFIG_NIOS2_IO_REGION_BASE;
> +       addr |= CONFIG_NIOS2_KERNEL_REGION_BASE;
>
> -       free_pages(addr, get_order(size));
> +       return (void *)ptr;
>  }
> --
> 2.20.1
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
