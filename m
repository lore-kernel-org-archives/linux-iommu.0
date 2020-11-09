Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_FAIL,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDFBC2D0A3
	for <iommu@archiver.kernel.org>; Mon,  9 Nov 2020 15:08:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35AEF221E9
	for <iommu@archiver.kernel.org>; Mon,  9 Nov 2020 15:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pd5SRD8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35AEF221E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CBEED87237;
	Mon,  9 Nov 2020 15:08:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EVvKMm3K+F6Q; Mon,  9 Nov 2020 15:08:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A846987245;
	Mon,  9 Nov 2020 15:08:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90219C088B;
	Mon,  9 Nov 2020 15:08:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CFC0C016F
 for <iommu@lists.linux-foundation.org>; Mon,  9 Nov 2020 14:54:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EF194871EE
 for <iommu@lists.linux-foundation.org>; Mon,  9 Nov 2020 14:54:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4laZOGlhF+YO for <iommu@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 14:54:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1B6E7871E2
 for <iommu@lists.linux-foundation.org>; Mon,  9 Nov 2020 14:54:09 +0000 (UTC)
Received: by mail-ot1-f66.google.com with SMTP id z16so9145270otq.6
 for <iommu@lists.linux-foundation.org>; Mon, 09 Nov 2020 06:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+H+sh7Xx5cfQ4qCc62GuweRPK+p13Oni3c8PkkMskeE=;
 b=Pd5SRD8Ddmf2dmCkFmXc1uKc1DaEiWNLoBkYCIyJnSvckbTdi29dmZtkp+Or3xrRDX
 gxhd2iyJBBotLe7amIJ4fcv9cam6LALfBMeQDnFnJtRYCJDSk+a47VVb7Rnak/Yobz3m
 y3K2X6j2wcyf/Id5omdFuxvO2PZvful6gQgD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+H+sh7Xx5cfQ4qCc62GuweRPK+p13Oni3c8PkkMskeE=;
 b=eejEpMSCU6AvvwWLbCGYunX2sFXhTS/kZXLLOF6oKSbO0YbPRabIYx/qIIb6A1XO43
 HP3e9h8PqeTWKV7a1CoJAMJ5Y1O2K/UFRV0xKpmHaJJHtCpiR530wpb7ect46D4y33xV
 X6Vl9qMFqMIHehzzTTAgVyB0u37tAzgrvR9SLAgjigFgnwnoFcZo/8H00SZMNVmo9M5r
 S0MJOmvynPCKL6yJEN+jDhPUFh5bTrDkjd3ilf8zrzJ9cinTiwGEnintLJ4C2TTa4TZ2
 AAmGjePyHc1pUbceLd8zERECoxlVvTESQxt8nCYzm/hLveXvBaCW0WWU46ytWTIWS76I
 WafA==
X-Gm-Message-State: AOAM532ZPPxxEAXprk8nGRDqjigSddGRr8crjaxO+OSeudRGPgJMOyL5
 T0oRlvpDv8yn3DBjGfZ+SQsX6wL7SSiErw==
X-Google-Smtp-Source: ABdhPJz0Gz3nIFW05U+9Ut2iz2pDeLUJKJpKmpX6zLQTVq1CIKD1b+Jx/8PK2EHYN2HuXrN1GOq4Pw==
X-Received: by 2002:a05:6830:1342:: with SMTP id
 r2mr11021698otq.0.1604933647936; 
 Mon, 09 Nov 2020 06:54:07 -0800 (PST)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com.
 [209.85.167.172])
 by smtp.gmail.com with ESMTPSA id c64sm2383052oia.49.2020.11.09.06.54.06
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 06:54:07 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id q206so10435120oif.13
 for <iommu@lists.linux-foundation.org>; Mon, 09 Nov 2020 06:54:06 -0800 (PST)
X-Received: by 2002:a05:6808:983:: with SMTP id
 a3mr5075572oic.15.1604933646157; 
 Mon, 09 Nov 2020 06:54:06 -0800 (PST)
MIME-Version: 1.0
References: <20200930160917.1234225-1-hch@lst.de>
 <20200930160917.1234225-9-hch@lst.de>
 <CAAFQd5CttttqMXb=iDPb+Z0WGUa2g=W6JwXJ-5HbhmrDyxP+cQ@mail.gmail.com>
In-Reply-To: <CAAFQd5CttttqMXb=iDPb+Z0WGUa2g=W6JwXJ-5HbhmrDyxP+cQ@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 9 Nov 2020 15:53:55 +0100
X-Gmail-Original-Message-ID: <CANiDSCtefXKw-xC3bskyggW-BzCmVPj6GGLvO=cCPZHbS1oTDA@mail.gmail.com>
Message-ID: <CANiDSCtefXKw-xC3bskyggW-BzCmVPj6GGLvO=cCPZHbS1oTDA@mail.gmail.com>
Subject: Re: [PATCH 8/8] WIP: add a dma_alloc_contiguous API
To: Tomasz Figa <tfiga@chromium.org>
X-Mailman-Approved-At: Mon, 09 Nov 2020 15:08:21 +0000
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

Hi Christoph

I have started now to give a try to your patchset. Sorry for the delay.

For uvc I have prepared this patch:
https://github.com/ribalda/linux/commit/9094fe223fe38f8c8ff21366d893b43cbbdf0113

I have tested successfully in a x86_64 noteboot..., yes I know there
is no change for that platform :).
I am trying to get hold of an arm device that can run the latest
kernel from upstream.

On the meanwhile if you could take a look to the patch to verify that
this the way that you expect the drivers to use your api I would
appreciate it

Thanks



On Wed, Oct 14, 2020 at 3:20 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> +CC Ricardo who will be looking into using this in the USB stack (UVC
> camera driver).
>
> On Wed, Sep 30, 2020 at 6:09 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Add a new API that returns a virtually non-contigous array of pages
> > and dma address.  This API is only implemented for dma-iommu and will
> > not be implemented for non-iommu DMA API instances that have to allocate
> > contiguous memory.  It is up to the caller to check if the API is
> > available.
> >
> > The intent is that media drivers can use this API if either:
> >
> >  - no kernel mapping or only temporary kernel mappings are required.
> >    That is as a better replacement for DMA_ATTR_NO_KERNEL_MAPPING
> >  - a kernel mapping is required for cached and DMA mapped pages, but
> >    the driver also needs the pages to e.g. map them to userspace.
> >    In that sense it is a replacement for some aspects of the recently
> >    removed and never fully implemented DMA_ATTR_NON_CONSISTENT
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  drivers/iommu/dma-iommu.c   | 73 +++++++++++++++++++++++++------------
> >  include/linux/dma-mapping.h |  9 +++++
> >  kernel/dma/mapping.c        | 35 ++++++++++++++++++
> >  3 files changed, 93 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 7922f545cd5eef..158026a856622c 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -565,23 +565,12 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
> >         return pages;
> >  }
> >
> > -/**
> > - * iommu_dma_alloc_remap - Allocate and map a buffer contiguous in IOVA space
> > - * @dev: Device to allocate memory for. Must be a real device
> > - *      attached to an iommu_dma_domain
> > - * @size: Size of buffer in bytes
> > - * @dma_handle: Out argument for allocated DMA handle
> > - * @gfp: Allocation flags
> > - * @prot: pgprot_t to use for the remapped mapping
> > - * @attrs: DMA attributes for this allocation
> > - *
> > - * If @size is less than PAGE_SIZE, then a full CPU page will be allocated,
> > +/*
> > + * If size is less than PAGE_SIZE, then a full CPU page will be allocated,
> >   * but an IOMMU which supports smaller pages might not map the whole thing.
> > - *
> > - * Return: Mapped virtual address, or NULL on failure.
> >   */
> > -static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
> > -               dma_addr_t *dma_handle, gfp_t gfp, pgprot_t prot,
> > +static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
> > +               size_t size, dma_addr_t *dma_handle, gfp_t gfp, pgprot_t prot,
> >                 unsigned long attrs)
> >  {
> >         struct iommu_domain *domain = iommu_get_dma_domain(dev);
> > @@ -593,7 +582,6 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
> >         struct page **pages;
> >         struct sg_table sgt;
> >         dma_addr_t iova;
> > -       void *vaddr;
> >
> >         *dma_handle = DMA_MAPPING_ERROR;
> >
> > @@ -636,17 +624,10 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
> >                         < size)
> >                 goto out_free_sg;
> >
> > -       vaddr = dma_common_pages_remap(pages, size, prot,
> > -                       __builtin_return_address(0));
> > -       if (!vaddr)
> > -               goto out_unmap;
> > -
> >         *dma_handle = iova;
> >         sg_free_table(&sgt);
> > -       return vaddr;
> > +       return pages;
> >
> > -out_unmap:
> > -       __iommu_dma_unmap(dev, iova, size);
> >  out_free_sg:
> >         sg_free_table(&sgt);
> >  out_free_iova:
> > @@ -656,6 +637,46 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
> >         return NULL;
> >  }
> >
> > +static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
> > +               dma_addr_t *dma_handle, gfp_t gfp, pgprot_t prot,
> > +               unsigned long attrs)
> > +{
> > +       struct page **pages;
> > +       void *vaddr;
> > +
> > +       pages = __iommu_dma_alloc_noncontiguous(dev, size, dma_handle, gfp,
> > +                                               prot, attrs);
> > +       if (!pages)
> > +               return NULL;
> > +       vaddr = dma_common_pages_remap(pages, size, prot,
> > +                       __builtin_return_address(0));
> > +       if (!vaddr)
> > +               goto out_unmap;
> > +       return vaddr;
> > +
> > +out_unmap:
> > +       __iommu_dma_unmap(dev, *dma_handle, size);
> > +       __iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
> > +       return NULL;
> > +}
> > +
> > +#ifdef CONFIG_DMA_REMAP
> > +static struct page **iommu_dma_alloc_noncontiguous(struct device *dev,
> > +               size_t size, dma_addr_t *dma_handle, gfp_t gfp,
> > +               unsigned long attrs)
> > +{
> > +       return __iommu_dma_alloc_noncontiguous(dev, size, dma_handle, gfp,
> > +                                              PAGE_KERNEL, attrs);
> > +}
> > +
> > +static void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
> > +               struct page **pages, dma_addr_t dma_handle)
> > +{
> > +       __iommu_dma_unmap(dev, dma_handle, size);
> > +       __iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
> > +}
> > +#endif
> > +
> >  static void iommu_dma_sync_single_for_cpu(struct device *dev,
> >                 dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
> >  {
> > @@ -1110,6 +1131,10 @@ static const struct dma_map_ops iommu_dma_ops = {
> >         .free                   = iommu_dma_free,
> >         .alloc_pages            = dma_common_alloc_pages,
> >         .free_pages             = dma_common_free_pages,
> > +#ifdef CONFIG_DMA_REMAP
> > +       .alloc_noncontiguous    = iommu_dma_alloc_noncontiguous,
> > +       .free_noncontiguous     = iommu_dma_free_noncontiguous,
> > +#endif
> >         .mmap                   = iommu_dma_mmap,
> >         .get_sgtable            = iommu_dma_get_sgtable,
> >         .map_page               = iommu_dma_map_page,
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index 4b9b1d64f5ec9e..51bbc32365bb8d 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -74,6 +74,10 @@ struct dma_map_ops {
> >                         gfp_t gfp);
> >         void (*free_pages)(struct device *dev, size_t size, struct page *vaddr,
> >                         dma_addr_t dma_handle, enum dma_data_direction dir);
> > +       struct page **(*alloc_noncontiguous)(struct device *dev, size_t size,
> > +                       dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs);
> > +       void (*free_noncontiguous)(struct device *dev, size_t size,
> > +                       struct page **pages, dma_addr_t dma_handle);
> >         int (*mmap)(struct device *, struct vm_area_struct *,
> >                           void *, dma_addr_t, size_t,
> >                           unsigned long attrs);
> > @@ -384,6 +388,11 @@ void *dma_alloc_noncoherent(struct device *dev, size_t size,
> >                 dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp);
> >  void dma_free_noncoherent(struct device *dev, size_t size, void *vaddr,
> >                 dma_addr_t dma_handle, enum dma_data_direction dir);
> > +bool dma_can_alloc_noncontiguous(struct device *dev);
> > +struct page **dma_alloc_noncontiguous(struct device *dev, size_t size,
> > +               dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs);
> > +void dma_free_noncontiguous(struct device *dev, size_t size,
> > +               struct page **pages, dma_addr_t dma_handle);
> >
> >  static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
> >                 size_t size, enum dma_data_direction dir, unsigned long attrs)
> > diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> > index 06115f59f4ffbf..6d975d1a20dd72 100644
> > --- a/kernel/dma/mapping.c
> > +++ b/kernel/dma/mapping.c
> > @@ -529,6 +529,41 @@ void dma_free_noncoherent(struct device *dev, size_t size, void *vaddr,
> >  }
> >  EXPORT_SYMBOL_GPL(dma_free_noncoherent);
> >
> > +bool dma_can_alloc_noncontiguous(struct device *dev)
> > +{
> > +       const struct dma_map_ops *ops = get_dma_ops(dev);
> > +
> > +       return ops && ops->free_noncontiguous;
> > +}
> > +EXPORT_SYMBOL_GPL(dma_can_alloc_noncontiguous);
> > +
> > +struct page **dma_alloc_noncontiguous(struct device *dev, size_t size,
> > +               dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
> > +{
> > +       const struct dma_map_ops *ops = get_dma_ops(dev);
> > +
> > +       if (WARN_ON_ONCE(!dma_can_alloc_noncontiguous(dev)))
> > +               return NULL;
> > +       if (attrs & ~DMA_ATTR_ALLOC_SINGLE_PAGES) {
> > +               dev_warn(dev, "invalid flags (0x%lx) for %s\n",
> > +                        attrs, __func__);
> > +               return NULL;
> > +       }
> > +       return ops->alloc_noncontiguous(dev, size, dma_handle, gfp, attrs);
> > +}
> > +EXPORT_SYMBOL_GPL(dma_alloc_noncontiguous);
> > +
> > +void dma_free_noncontiguous(struct device *dev, size_t size,
> > +               struct page **pages, dma_addr_t dma_handle)
> > +{
> > +       const struct dma_map_ops *ops = get_dma_ops(dev);
> > +
> > +       if (WARN_ON_ONCE(!dma_can_alloc_noncontiguous(dev)))
> > +               return;
> > +       ops->free_noncontiguous(dev, size, pages, dma_handle);
> > +}
> > +EXPORT_SYMBOL_GPL(dma_free_noncontiguous);
> > +
> >  int dma_supported(struct device *dev, u64 mask)
> >  {
> >         const struct dma_map_ops *ops = get_dma_ops(dev);
> > --
> > 2.28.0
> >



-- 
Ricardo Ribalda
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
