Return-Path: <SRS0=N1FY=J6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6030C433ED
	for <iommu@archiver.kernel.org>; Mon,  3 May 2021 14:26:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E6A7611AC
	for <iommu@archiver.kernel.org>; Mon,  3 May 2021 14:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6A7611AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8CD8940E49;
	Mon,  3 May 2021 14:26:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Obcxz1dAJG_9; Mon,  3 May 2021 14:26:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 088A740E48;
	Mon,  3 May 2021 14:26:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFD87C000D;
	Mon,  3 May 2021 14:26:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA7EDC0001
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 14:26:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A586640149
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 14:26:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L7hwxjnod9Oq for <iommu@lists.linux-foundation.org>;
 Mon,  3 May 2021 14:26:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 05F74400CD
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 14:26:14 +0000 (UTC)
Received: by mail-il1-x132.google.com with SMTP id j20so3798727ilo.10
 for <iommu@lists.linux-foundation.org>; Mon, 03 May 2021 07:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ELcNibbwxopbe4wnzShPTb7xRMLVvYpqQ8un28QQp9U=;
 b=nOyrfh2thpmQagEkzKEHJkMTgRy+3FJJdT9Oo6MZndwooAl8msGQ2IZHFMeS6aJ6Md
 +OeRGM111zl+0t7XmNgYC8WpP2ka9OwZM9VN//prTwlXpUXb+Muztthx/dt4YfUeTqwD
 ene0+k2RSvchnHpwNfAnGfkLV6l7GmkYIbRvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ELcNibbwxopbe4wnzShPTb7xRMLVvYpqQ8un28QQp9U=;
 b=QspUS3W6FGLm+P1z7YJotpiGn27M+Iwf7omgNUzbGchXaFNCHFGYj+EZeZGORgLOR4
 Ktq9pQYXGFNIdsY/77/Anu7be+FT1BgEclc6+KirLNtYVQqQuqcDnbOfjEcqSXnslkt4
 lGNlZjaS1TC5HxBjDuIMD1qoDeMRyrS02VTd0hLUo2mgHrcPbuTMmBFYvjj3XQjknOtH
 3CjfinYXd/KAhZwSysQuVE4Bs7KjWSW3+UwWNhwkUjnJOyYw5GHfWC3ew62xAb8inbhg
 0MR569uESnTL40fFE0OKVEJwY4dAIbYXMVyQ44jczmC/6QVGroR2CytaI2PNfmZUTOXp
 x4xg==
X-Gm-Message-State: AOAM533k9azkWEndY3rvUq1y7M9qmeOavT3VLLRdnashwTOMic6JBj6y
 i7XFqHsaoJ1p8jY2g07UPzwT/RCCGX44yQ==
X-Google-Smtp-Source: ABdhPJyQkIbSemaHBchp72WKpXW6pzGWnaGeJlHnd5UHTjnf4/GN/LqslT5hNrZudKArS/IiMlEmpA==
X-Received: by 2002:a05:6e02:eeb:: with SMTP id
 j11mr15903902ilk.23.1620051973591; 
 Mon, 03 May 2021 07:26:13 -0700 (PDT)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com.
 [209.85.166.181])
 by smtp.gmail.com with ESMTPSA id z8sm2597138iot.27.2021.05.03.07.26.12
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 May 2021 07:26:12 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id j12so3806225ils.4
 for <iommu@lists.linux-foundation.org>; Mon, 03 May 2021 07:26:12 -0700 (PDT)
X-Received: by 2002:a05:6e02:f4e:: with SMTP id
 y14mr3397094ilj.18.1620051971892; 
 Mon, 03 May 2021 07:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210422081508.3942748-1-tientzu@chromium.org>
 <20210422081508.3942748-15-tientzu@chromium.org>
 <70b895c2-4a39-bbbd-a719-5c8b6b922026@arm.com>
In-Reply-To: <70b895c2-4a39-bbbd-a719-5c8b6b922026@arm.com>
From: Claire Chang <tientzu@chromium.org>
Date: Mon, 3 May 2021 22:26:00 +0800
X-Gmail-Original-Message-ID: <CALiNf28cc5T-cMZxNPZnrTQvqu2Ge_MmZj-teN4mE_-E-6_6XQ@mail.gmail.com>
Message-ID: <CALiNf28cc5T-cMZxNPZnrTQvqu2Ge_MmZj-teN4mE_-E-6_6XQ@mail.gmail.com>
Subject: Re: [PATCH v5 14/16] dma-direct: Allocate memory from restricted DMA
 pool if available
To: Robin Murphy <robin.murphy@arm.com>
Cc: heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
 peterz@infradead.org, benh@kernel.crashing.org,
 joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
 lkml <linux-kernel@vger.kernel.org>, grant.likely@arm.com, paulus@samba.org,
 Will Deacon <will@kernel.org>, mingo@kernel.org, sstabellini@kernel.org,
 Saravana Kannan <saravanak@google.com>, xypron.glpk@gmx.de,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, intel-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, linux-devicetree <devicetree@vger.kernel.org>,
 Jianxiong Gao <jxgao@google.com>, Daniel Vetter <daniel@ffwll.ch>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 maarten.lankhorst@linux.intel.com, airlied@linux.ie,
 Dan Williams <dan.j.williams@intel.com>, jani.nikula@linux.intel.com,
 Nicolas Boichat <drinkcat@chromium.org>, rodrigo.vivi@intel.com,
 Bjorn Helgaas <bhelgaas@google.com>, boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 chris@chris-wilson.co.uk, nouveau@lists.freedesktop.org,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Frank Rowand <frowand.list@gmail.com>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, linuxppc-dev@lists.ozlabs.org,
 bauerman@linux.ibm.com
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

On Fri, Apr 23, 2021 at 9:46 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-04-22 09:15, Claire Chang wrote:
> > The restricted DMA pool is preferred if available.
> >
> > The restricted DMA pools provide a basic level of protection against the
> > DMA overwriting buffer contents at unexpected times. However, to protect
> > against general data leakage and system memory corruption, the system
> > needs to provide a way to lock down the memory access, e.g., MPU.
> >
> > Signed-off-by: Claire Chang <tientzu@chromium.org>
> > ---
> >   kernel/dma/direct.c | 35 ++++++++++++++++++++++++++---------
> >   1 file changed, 26 insertions(+), 9 deletions(-)
> >
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 7a27f0510fcc..29523d2a9845 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -78,6 +78,10 @@ static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
> >   static void __dma_direct_free_pages(struct device *dev, struct page *page,
> >                                   size_t size)
> >   {
> > +#ifdef CONFIG_DMA_RESTRICTED_POOL
> > +     if (swiotlb_free(dev, page, size))
> > +             return;
> > +#endif
> >       dma_free_contiguous(dev, page, size);
> >   }
> >
> > @@ -92,7 +96,17 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
> >
> >       gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
> >                                          &phys_limit);
> > -     page = dma_alloc_contiguous(dev, size, gfp);
> > +
> > +#ifdef CONFIG_DMA_RESTRICTED_POOL
> > +     page = swiotlb_alloc(dev, size);
> > +     if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
> > +             __dma_direct_free_pages(dev, page, size);
> > +             page = NULL;
> > +     }
> > +#endif
> > +
> > +     if (!page)
> > +             page = dma_alloc_contiguous(dev, size, gfp);
> >       if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
> >               dma_free_contiguous(dev, page, size);
> >               page = NULL;
> > @@ -148,7 +162,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
> >               gfp |= __GFP_NOWARN;
> >
> >       if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> > -         !force_dma_unencrypted(dev)) {
> > +         !force_dma_unencrypted(dev) && !is_dev_swiotlb_force(dev)) {
> >               page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO);
> >               if (!page)
> >                       return NULL;
> > @@ -161,8 +175,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
> >       }
> >
> >       if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
> > -         !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> > -         !dev_is_dma_coherent(dev))
> > +         !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) && !dev_is_dma_coherent(dev) &&
> > +         !is_dev_swiotlb_force(dev))
> >               return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
> >
> >       /*
> > @@ -172,7 +186,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
> >       if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
> >           !gfpflags_allow_blocking(gfp) &&
> >           (force_dma_unencrypted(dev) ||
> > -          (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) && !dev_is_dma_coherent(dev))))
> > +          (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> > +           !dev_is_dma_coherent(dev))) &&
> > +         !is_dev_swiotlb_force(dev))
> >               return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
> >
> >       /* we always manually zero the memory once we are done */
> > @@ -253,15 +269,15 @@ void dma_direct_free(struct device *dev, size_t size,
> >       unsigned int page_order = get_order(size);
> >
> >       if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> > -         !force_dma_unencrypted(dev)) {
> > +         !force_dma_unencrypted(dev) && !is_dev_swiotlb_force(dev)) {
> >               /* cpu_addr is a struct page cookie, not a kernel address */
> >               dma_free_contiguous(dev, cpu_addr, size);
> >               return;
> >       }
> >
> >       if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
> > -         !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> > -         !dev_is_dma_coherent(dev)) {
> > +         !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) && !dev_is_dma_coherent(dev) &&
> > +         !is_dev_swiotlb_force(dev)) {
> >               arch_dma_free(dev, size, cpu_addr, dma_addr, attrs);
> >               return;
> >       }
> > @@ -289,7 +305,8 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
> >       void *ret;
> >
> >       if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
> > -         force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp))
> > +         force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp) &&
> > +         !is_dev_swiotlb_force(dev))
> >               return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>
> Wait, this seems broken for non-coherent devices - in that case we need
> to return a non-cacheable address, but we can't simply fall through into
> the remapping path below in GFP_ATOMIC context. That's why we need the
> atomic pool concept in the first place :/

Sorry for the late reply. I'm not very familiar with this. I wonder if
the memory returned here must be coherent. If yes, could we say for
this case, one must set up another device coherent pool
(shared-dma-pool) and go with dma_alloc_from_dev_coherent()[1]?

[1] https://elixir.bootlin.com/linux/v5.12/source/kernel/dma/mapping.c#L435

>
> Unless I've overlooked something, we're still using the regular
> cacheable linear map address of the dma_io_tlb_mem buffer, no?
>
> Robin.
>
> >
> >       page = __dma_direct_alloc_pages(dev, size, gfp);
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
