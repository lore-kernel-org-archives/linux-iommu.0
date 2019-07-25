Return-Path: <SRS0=la/L=VW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7B1C7618B
	for <iommu@archiver.kernel.org>; Thu, 25 Jul 2019 16:08:53 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2096C22C7B
	for <iommu@archiver.kernel.org>; Thu, 25 Jul 2019 16:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="uzCFtgHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2096C22C7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vanguardiasur.com.ar
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C8772C6A;
	Thu, 25 Jul 2019 16:08:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 28C40C6A
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Jul 2019 16:06:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-vk1-f194.google.com (mail-vk1-f194.google.com
	[209.85.221.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 20A5289D
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Jul 2019 16:06:54 +0000 (UTC)
Received: by mail-vk1-f194.google.com with SMTP id u64so10147371vku.8
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Jul 2019 09:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=j4i8w9Kr6s0PSmw7woZ7h8pKLb/pNRsFccRAOvuNOpk=;
	b=uzCFtgHlrcbsjdi9+t4cRoMJEPLPUy6CNPcdz+xpdwFEOhQsc9IVpHdNKiQjYpUEK9
	LNAa5fcYBaeGzt1M4KOvDDb1gTH1kXLX+S6+54oxu7dzVVbUvJUtPUVcvuBQ2LyBfHUU
	zXt4Jh+mvxYcnl98CiNNdhmg1jjlXX3ZXSuvZ2cd+RQYR0dgHVu1cvhoBsGQRCAguiGh
	Dwc/v3mECILcLvUAZ9EJPMzeE5dlYbm+MrKP2eQiaZesGCNNVxHeIIJxO+yP+543nnKv
	hn5GO2/w6tlJ9PiY7EK/zmKPVHmVtTLdR2eFn6iDiTdj8eS3PWHuchbCdnbiQrarxagJ
	JGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=j4i8w9Kr6s0PSmw7woZ7h8pKLb/pNRsFccRAOvuNOpk=;
	b=fe5gogI9631PLMPyiTgDDzcESwWKFXLyojFFHU7qvPKa+E3U6vPd5B3IH+mi3YIIcZ
	UaJ+L4bJMDx5c7zDJ5cTvhP7DC5UetfQjIT0NpLpGSWK16x8afugjmWTWM9FOsw7KXd6
	447pCMZ9WiN2/sKOhrZPz0tS3XyPghTp3Zm8sofaZhBFTJxCGUIZLnT17O7oPHrR88wj
	2OxKpa2/QrdFtX83Y7IXYjmhW07Xrb1jOXUQNnirDHZbEgRjXQVjuBKD7im9f/tkwhrY
	SlDkEIa+N3B/1uRzQbGe0Txs0ix3KPq5/l8rZ3F2pPGMgRgkqckeKM50ckVMF39gVob/
	+iZQ==
X-Gm-Message-State: APjAAAXXB9wjiPpnul7VyBj7Udb7bS3Tz+ubtSY1+iTYLmrO2FJR1bzu
	k3hwcA1Ody30JQonGHT4RWGDSLVGHk9guF3e+vE=
X-Google-Smtp-Source: APXvYqwgwDqpsWNLo+H70+5x1cZL09rHVbL+sr/g+NLtDIYDxR3O/b4ANbpuw1/A6zcLHbGh4mXHxwEJHhs2RFuZ3tU=
X-Received: by 2002:a1f:b0b:: with SMTP id 11mr34502286vkl.64.1564070813830;
	Thu, 25 Jul 2019 09:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190524040633.16854-1-nicoleotsuka@gmail.com>
	<20190524040633.16854-2-nicoleotsuka@gmail.com>
In-Reply-To: <20190524040633.16854-2-nicoleotsuka@gmail.com>
From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date: Thu, 25 Jul 2019 13:06:42 -0300
Message-ID: <CAAEAJfA+edVLfZzEZe98249Y7NZQFht9185JH21pV10Bq9Wk3w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dma-contiguous: Abstract dma_{alloc,
	free}_contiguous()
To: Nicolin Chen <nicoleotsuka@gmail.com>
X-Mailman-Approved-At: Thu, 25 Jul 2019 16:08:52 +0000
Cc: dafna.hirschfeld@collabora.com, Tony Lindgren <tony@atomide.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, jcmvbkbc@gmail.com,
	hch@lst.de, sfr@canb.auug.org.au, dann.frazier@canonical.com,
	Russell King <linux@armlinux.org.uk>, treding@nvidia.com,
	linux-xtensa@linux-xtensa.org, keescook@chromium.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	chris@zankel.net, wsa+renesas@sang-engineering.com, robin.murphy@arm.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	iommu@lists.linux-foundation.org, iamjoonsoo.kim@lge.com,
	David Woodhouse <dwmw2@infradead.org>
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

I can't find a way to forward-redirect from Gmail, so I'm Ccing Dafna
who found a regression caused by this commit. Dafna, can you give all
the details, including the log and how you are reproducing it?


On Fri, 24 May 2019 at 01:08, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> Both dma_alloc_from_contiguous() and dma_release_from_contiguous()
> are very simply implemented, but requiring callers to pass certain
> parameters like count and align, and taking a boolean parameter to
> check __GFP_NOWARN in the allocation flags. So every function call
> duplicates similar work:
>   /* A piece of example */
>   unsigned long order = get_order(size);
>   size_t count = size >> PAGE_SHIFT;
>   page = dma_alloc_from_contiguous(dev, count, order, gfp & __GFP_NOWARN);
>   [...]
>   dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
>
> Additionally, as CMA can be used only in the context which permits
> sleeping, most of callers do a gfpflags_allow_blocking() check and
> a corresponding fallback allocation of normal pages upon any false
> result:
>   /* A piece of example */
>   if (gfpflags_allow_blocking(flag))
>       page = dma_alloc_from_contiguous();
>   if (!page)
>       page = alloc_pages();
>   [...]
>   if (!dma_release_from_contiguous(dev, page, count))
>       __free_pages(page, get_order(size));
>
> So this patch simplifies those function calls by abstracting these
> operations into the two new functions: dma_{alloc,free}_contiguous.
>
> As some callers of dma_{alloc,release}_from_contiguous() might be
> complicated, this patch just implements these two new functions to
> kernel/dma/direct.c only as an initial step.
>
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
> Changelog
> v2->v3:
>  * Added missing "static inline" in header file to fix build error.
> v1->v2:
>  * Added new functions beside the old ones so we can replace callers
>    one by one later.
>  * Applied new functions to dma/direct.c only, because it's the best
>    example caller to apply and should be safe with the new functions.
>
>  include/linux/dma-contiguous.h | 11 ++++++++
>  kernel/dma/contiguous.c        | 48 ++++++++++++++++++++++++++++++++++
>  kernel/dma/direct.c            | 24 +++--------------
>  3 files changed, 63 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
> index f247e8aa5e3d..00a370c1c140 100644
> --- a/include/linux/dma-contiguous.h
> +++ b/include/linux/dma-contiguous.h
> @@ -115,6 +115,8 @@ struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
>                                        unsigned int order, bool no_warn);
>  bool dma_release_from_contiguous(struct device *dev, struct page *pages,
>                                  int count);
> +struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp);
> +void dma_free_contiguous(struct device *dev, struct page *page, size_t size);
>
>  #else
>
> @@ -157,6 +159,15 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
>         return false;
>  }
>
> +static inline
> +struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
> +{
> +       return NULL;
> +}
> +
> +static inline
> +void dma_free_contiguous(struct device *dev, struct page *page, size_t size) { }
> +
>  #endif
>
>  #endif
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index b2a87905846d..21f39a6cb04f 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -214,6 +214,54 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
>         return cma_release(dev_get_cma_area(dev), pages, count);
>  }
>
> +/**
> + * dma_alloc_contiguous() - allocate contiguous pages
> + * @dev:   Pointer to device for which the allocation is performed.
> + * @size:  Requested allocation size.
> + * @gfp:   Allocation flags.
> + *
> + * This function allocates contiguous memory buffer for specified device. It
> + * first tries to use device specific contiguous memory area if available or
> + * the default global one, then tries a fallback allocation of normal pages.
> + */
> +struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
> +{
> +       int node = dev ? dev_to_node(dev) : NUMA_NO_NODE;
> +       size_t count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> +       size_t align = get_order(PAGE_ALIGN(size));
> +       struct cma *cma = dev_get_cma_area(dev);
> +       struct page *page = NULL;
> +
> +       /* CMA can be used only in the context which permits sleeping */
> +       if (cma && gfpflags_allow_blocking(gfp)) {
> +               align = min_t(size_t, align, CONFIG_CMA_ALIGNMENT);
> +               page = cma_alloc(cma, count, align, gfp & __GFP_NOWARN);
> +       }
> +
> +       /* Fallback allocation of normal pages */
> +       if (!page)
> +               page = alloc_pages_node(node, gfp, align);
> +
> +       return page;
> +}
> +
> +/**
> + * dma_free_contiguous() - release allocated pages
> + * @dev:   Pointer to device for which the pages were allocated.
> + * @page:  Pointer to the allocated pages.
> + * @size:  Size of allocated pages.
> + *
> + * This function releases memory allocated by dma_alloc_contiguous(). As the
> + * cma_release returns false when provided pages do not belong to contiguous
> + * area and true otherwise, this function then does a fallback __free_pages()
> + * upon a false-return.
> + */
> +void dma_free_contiguous(struct device *dev, struct page *page, size_t size)
> +{
> +       if (!cma_release(dev_get_cma_area(dev), page, size >> PAGE_SHIFT))
> +               __free_pages(page, get_order(size));
> +}
> +
>  /*
>   * Support for reserved memory regions defined in device tree
>   */
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 2c2772e9702a..0816c1e8b05a 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -96,8 +96,6 @@ static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
>  struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
>                 dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>  {
> -       unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -       int page_order = get_order(size);
>         struct page *page = NULL;
>         u64 phys_mask;
>
> @@ -109,20 +107,9 @@ struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
>         gfp |= __dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
>                         &phys_mask);
>  again:
> -       /* CMA can be used only in the context which permits sleeping */
> -       if (gfpflags_allow_blocking(gfp)) {
> -               page = dma_alloc_from_contiguous(dev, count, page_order,
> -                                                gfp & __GFP_NOWARN);
> -               if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
> -                       dma_release_from_contiguous(dev, page, count);
> -                       page = NULL;
> -               }
> -       }
> -       if (!page)
> -               page = alloc_pages_node(dev_to_node(dev), gfp, page_order);
> -
> +       page = dma_alloc_contiguous(dev, size, gfp);
>         if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
> -               __free_pages(page, page_order);
> +               dma_free_contiguous(dev, page, size);
>                 page = NULL;
>
>                 if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
> @@ -154,7 +141,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>         if (PageHighMem(page)) {
>                 /*
>                  * Depending on the cma= arguments and per-arch setup
> -                * dma_alloc_from_contiguous could return highmem pages.
> +                * dma_alloc_contiguous could return highmem pages.
>                  * Without remapping there is no way to return them here,
>                  * so log an error and fail.
>                  */
> @@ -176,10 +163,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>
>  void __dma_direct_free_pages(struct device *dev, size_t size, struct page *page)
>  {
> -       unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -
> -       if (!dma_release_from_contiguous(dev, page, count))
> -               __free_pages(page, get_order(size));
> +       dma_free_contiguous(dev, page, size);
>  }
>
>  void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
> --
> 2.17.1
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
