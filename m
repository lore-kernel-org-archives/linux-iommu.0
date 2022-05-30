Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E12C433FE
	for <iommu@archiver.kernel.org>; Mon, 30 May 2022 13:27:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DABE1840CC;
	Mon, 30 May 2022 13:27:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C4l9_APL29Ch; Mon, 30 May 2022 13:27:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 848F582B81;
	Mon, 30 May 2022 13:27:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50579C0039;
	Mon, 30 May 2022 13:27:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47CC5C002D
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 13:27:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 36C4282B81
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 13:27:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3ZD45SMhm2G0 for <iommu@lists.linux-foundation.org>;
 Mon, 30 May 2022 13:27:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 52A7984035
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 13:27:37 +0000 (UTC)
Received: by mail-yb1-xb34.google.com with SMTP id e184so9537133ybf.8
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 06:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=br/aOrv0eoxb0+NjBs/C/EYldji2QtrwhbttZFDDc58=;
 b=iQv3Gmbazk5lWfoXfvHs8UZn+/U9+J4WvKaDIvb8aXNugratarnTWNMJswiFBLpz7s
 jDq1vYDksD4flgfhvEhKI26EnhtI4FUr7wJOmqoIPGn0EjC40yeeNg30AGx3t35L8OSZ
 rKEB4K3XNHsk3NYjPOM7s1kou89QQDqVKOjQmehSo6Sg535YYgmJ+R5iVvWEPAxp5WP3
 FVhpRnpyOu0CsZKsxZOPlgt+uiekB0WtnTyvZPWeA3iXI0e3JLz+8n8XqZbZ8g6fw1Z5
 /+on3YiVpJoIOhN63rNOi/TVZ6NhSogNQg3r+oA2bFJ6dTN4vjSsNVsGNQhro8EoMNKk
 j8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=br/aOrv0eoxb0+NjBs/C/EYldji2QtrwhbttZFDDc58=;
 b=NaJeeyAY2nkxW4OKawI+H1B+LX5pEECbPVhPPjXQx8kkDJpk2w5SrSkxIE+W8leA6m
 neGRLFrgx7JTpV1rS8cCr4R15Vp8DK25UczQSkHMw0UMNtxyrg2hIBUfQOm/hlStbRVZ
 NYGJHPoJFIUlubTpSt0/v2eH6dh0fU5wFjFlYwmnTNPAL933Z/3L8X4JmVaernaD8jz1
 FN05j6wSpojdK4h0R+sezZfDbRXQZPj8vq5dfRYFZ4BIuwzv7U9g0D7cj3qNGGA7Y97M
 HwpQpbp15xHhUBlomjIEg9dIFec52ys+NIrijwOySr8akjJpykZWOuhNEKIOS07zpo8l
 0tSg==
X-Gm-Message-State: AOAM532eCcrLn8YzSew3cE52lrGgi5T7zhF6equCKnnxxyy4mekB+E5q
 zJsDIe1AF2q5kH4iGG6SaBEmETJrdZFaGrtQIP8=
X-Google-Smtp-Source: ABdhPJxTcR5UjAS0Kbpbk5PBx48jgm9C0j68mYcjiNzm8etJyiO57QuuviEFkOgVnmZSKa/uUZtrNIeGL1JDXGqKAXg=
X-Received: by 2002:a25:f82:0:b0:64a:7f7e:f512 with SMTP id
 124-20020a250f82000000b0064a7f7ef512mr52691694ybp.571.1653917256190; Mon, 30
 May 2022 06:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220511121544.5998-1-ajaykumar.rs@samsung.com>
 <CGME20220511121433epcas5p3de77375a85edf1aa78c0976a7107fdfa@epcas5p3.samsung.com>
 <20220511121544.5998-3-ajaykumar.rs@samsung.com>
 <a21f3016-a9f1-dc86-8604-ae651a763fc8@arm.com>
In-Reply-To: <a21f3016-a9f1-dc86-8604-ae651a763fc8@arm.com>
From: Ajay Kumar <ajaykumar.rs1989@gmail.com>
Date: Mon, 30 May 2022 18:57:25 +0530
Message-ID: <CADe9J7F5QuOJt5_c3Gig13LnXihKfLpDWTE7K0nwO=b6RzkhWw@mail.gmail.com>
Subject: Re: [PATCH V2 2/6] iommu: iova: properly handle 0 as a valid IOVA
 address
To: Robin Murphy <robin.murphy@arm.com>
Cc: pankaj.dubey@samsung.com, Linux IOMMU <iommu@lists.linux-foundation.org>,
 alim.akhtar@samsung.com, Will Deacon <will@kernel.org>,
 Ajay Kumar <ajaykumar.rs@samsung.com>, linux-arm-kernel@lists.infradead.org
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

Hi Robin

On Mon, May 23, 2022 at 11:00 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-05-11 13:15, Ajay Kumar wrote:
> > From: Marek Szyprowski <m.szyprowski@samsung.com>
> >
> > Zero is a valid DMA and IOVA address on many architectures, so adjust the
> > IOVA management code to properly handle it. A new value IOVA_BAD_ADDR
> > (~0UL) is introduced as a generic value for the error case. Adjust all
> > callers of the alloc_iova_fast() function for the new return value.
>
> And when does anything actually need this? In fact if you were to stop
> iommu-dma from reserving IOVA 0 - which you don't - it would only show
> how patch #3 is broken.
Right! Since the IOVA allocation happens from higher addr to lower addr,
hitting this (IOVA==0) case means out of IOVA space which is highly unlikely.

> Also note that it's really nothing to do with architectures either way;
> iommu-dma simply chooses to reserve IOVA 0 for its own convenience,
> mostly because it can. Much the same way that 0 is typically a valid CPU
> VA, but mapping something meaningful there is just asking for a world of
> pain debugging NULL-dereference bugs.
>
> Robin.
This makes sense, let me think about managing the PFN at lowest address
in some other way.

Thanks,
Ajay Kumar

> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> > ---
> >   drivers/iommu/dma-iommu.c | 16 +++++++++-------
> >   drivers/iommu/iova.c      | 13 +++++++++----
> >   include/linux/iova.h      |  1 +
> >   3 files changed, 19 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 1ca85d37eeab..16218d6a0703 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -605,7 +605,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
> >   {
> >       struct iommu_dma_cookie *cookie = domain->iova_cookie;
> >       struct iova_domain *iovad = &cookie->iovad;
> > -     unsigned long shift, iova_len, iova = 0;
> > +     unsigned long shift, iova_len, iova = IOVA_BAD_ADDR;
> >
> >       if (cookie->type == IOMMU_DMA_MSI_COOKIE) {
> >               cookie->msi_iova += size;
> > @@ -625,11 +625,13 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
> >               iova = alloc_iova_fast(iovad, iova_len,
> >                                      DMA_BIT_MASK(32) >> shift, false);
> >
> > -     if (!iova)
> > +     if (iova == IOVA_BAD_ADDR)
> >               iova = alloc_iova_fast(iovad, iova_len, dma_limit >> shift,
> >                                      true);
> >
> > -     return (dma_addr_t)iova << shift;
> > +     if (iova != IOVA_BAD_ADDR)
> > +             return (dma_addr_t)iova << shift;
> > +     return DMA_MAPPING_ERROR;
> >   }
> >
> >   static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
> > @@ -688,7 +690,7 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
> >       size = iova_align(iovad, size + iova_off);
> >
> >       iova = iommu_dma_alloc_iova(domain, size, dma_mask, dev);
> > -     if (!iova)
> > +     if (iova == DMA_MAPPING_ERROR)
> >               return DMA_MAPPING_ERROR;
> >
> >       if (iommu_map_atomic(domain, iova, phys - iova_off, size, prot)) {
> > @@ -799,7 +801,7 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
> >
> >       size = iova_align(iovad, size);
> >       iova = iommu_dma_alloc_iova(domain, size, dev->coherent_dma_mask, dev);
> > -     if (!iova)
> > +     if (iova == DMA_MAPPING_ERROR)
> >               goto out_free_pages;
> >
> >       if (sg_alloc_table_from_pages(sgt, pages, count, 0, size, GFP_KERNEL))
> > @@ -1204,7 +1206,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
> >       }
> >
> >       iova = iommu_dma_alloc_iova(domain, iova_len, dma_get_mask(dev), dev);
> > -     if (!iova) {
> > +     if (iova == DMA_MAPPING_ERROR) {
> >               ret = -ENOMEM;
> >               goto out_restore_sg;
> >       }
> > @@ -1516,7 +1518,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
> >               return NULL;
> >
> >       iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
> > -     if (!iova)
> > +     if (iova == DMA_MAPPING_ERROR)
> >               goto out_free_page;
> >
> >       if (iommu_map(domain, iova, msi_addr, size, prot))
> > diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> > index db77aa675145..ae0fe0a6714e 100644
> > --- a/drivers/iommu/iova.c
> > +++ b/drivers/iommu/iova.c
> > @@ -429,6 +429,8 @@ EXPORT_SYMBOL_GPL(free_iova);
> >    * This function tries to satisfy an iova allocation from the rcache,
> >    * and falls back to regular allocation on failure. If regular allocation
> >    * fails too and the flush_rcache flag is set then the rcache will be flushed.
> > + * Returns a pfn the allocated iova starts at or IOVA_BAD_ADDR in the case
> > + * of a failure.
> >   */
> >   unsigned long
> >   alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
> > @@ -447,7 +449,7 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
> >               size = roundup_pow_of_two(size);
> >
> >       iova_pfn = iova_rcache_get(iovad, size, limit_pfn + 1);
> > -     if (iova_pfn)
> > +     if (iova_pfn != IOVA_BAD_ADDR)
> >               return iova_pfn;
> >
> >   retry:
> > @@ -456,7 +458,7 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
> >               unsigned int cpu;
> >
> >               if (!flush_rcache)
> > -                     return 0;
> > +                     return IOVA_BAD_ADDR;
> >
> >               /* Try replenishing IOVAs by flushing rcache. */
> >               flush_rcache = false;
> > @@ -831,7 +833,7 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
> >                                      unsigned long limit_pfn)
> >   {
> >       struct iova_cpu_rcache *cpu_rcache;
> > -     unsigned long iova_pfn = 0;
> > +     unsigned long iova_pfn = IOVA_BAD_ADDR;
> >       bool has_pfn = false;
> >       unsigned long flags;
> >
> > @@ -858,6 +860,9 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
> >
> >       spin_unlock_irqrestore(&cpu_rcache->lock, flags);
> >
> > +     if (!iova_pfn)
> > +             return IOVA_BAD_ADDR;
> > +
> >       return iova_pfn;
> >   }
> >
> > @@ -873,7 +878,7 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
> >       unsigned int log_size = order_base_2(size);
> >
> >       if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE || !iovad->rcaches)
> > -             return 0;
> > +             return IOVA_BAD_ADDR;
> >
> >       return __iova_rcache_get(&iovad->rcaches[log_size], limit_pfn - size);
> >   }
> > diff --git a/include/linux/iova.h b/include/linux/iova.h
> > index 320a70e40233..46b5b10c532b 100644
> > --- a/include/linux/iova.h
> > +++ b/include/linux/iova.h
> > @@ -21,6 +21,7 @@ struct iova {
> >       unsigned long   pfn_lo; /* Lowest allocated pfn */
> >   };
> >
> > +#define IOVA_BAD_ADDR        (~0UL)
> >
> >   struct iova_rcache;
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
