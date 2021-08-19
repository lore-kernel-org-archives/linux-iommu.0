Return-Path: <SRS0=qbNH=NK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F57C4338F
	for <iommu@archiver.kernel.org>; Thu, 19 Aug 2021 10:05:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0D9A6113B
	for <iommu@archiver.kernel.org>; Thu, 19 Aug 2021 10:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F0D9A6113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ADE8E607A1;
	Thu, 19 Aug 2021 10:05:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RaE6rfUDuQMD; Thu, 19 Aug 2021 10:05:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8AF87606BE;
	Thu, 19 Aug 2021 10:05:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66F7EC0010;
	Thu, 19 Aug 2021 10:05:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FEB7C000E
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 10:05:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8B6E24028B
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 10:05:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kaZ2sRgkAhYS for <iommu@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 10:05:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5FD9340287
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 10:05:16 +0000 (UTC)
Received: by mail-qt1-x834.google.com with SMTP id b1so4142403qtx.0
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 03:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=X3zlPWDyphvVlbQ5qW3mRYO0Onpjp0vHlmpsTSdQ76U=;
 b=Qt/ngTdhvfqfEUTB6oXvy1Tg6d89U6mWp/wKxapl/JcsNUitJUvR9DiI/l+/T/95ZW
 EKkvzDOz4tBamAa3OCDgmTjd5MJAbewUELKSWH1Lyd8S7LDb3T/0AvrxUcFxsjnPLy5K
 /4T96yV6fiQUHdNuKhQ/VwbgjjTLth6uXACDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X3zlPWDyphvVlbQ5qW3mRYO0Onpjp0vHlmpsTSdQ76U=;
 b=aArsOg8GS4buEvJZ2Gmi4hG7t5GC2oY7bA1BFl1ZM6lo9n2wLeD3c4dedwzAETSb2n
 EhgmGouXEqC4ZY0XAV7FA3FuP4jpDGUFDUvFqoPl5ETpoZWUHXr2jpqeu3YaiCjpL0jO
 sTkUaE5Bpa1mpG/QiEN81XVl8YIVzdl1iJh2w/E9KvkchU0K46gv2v8D9MPhyQd6m2Kg
 lCiaifVPHF9ovC2peVOLpW/h91nO7MNr2juGO4FJifiiThtjmloc6mXhAFsSC74rdoTC
 29V+sCd5N+ZmSxwpKCQUaJmJGEl7ZYrjaXVMRLWRphhXBnGTByy8xC9JdQKbpXkNr5UV
 hDsg==
X-Gm-Message-State: AOAM5333Ecb/M1XSTeWVZzAixmWOjTCJ99Dz9EZnpk4MyKYyThAVVR/F
 mGykeu0FpX8N6yt0AX/bEanODyYwEIbLbn3IKncgOg==
X-Google-Smtp-Source: ABdhPJzCdJjP1MwbH7hH0bJZ9B1Z5mWBm8tscwzL3/O2b/V30LA1px2FIzqx7BzQ1O2BI0NboeA0Mz6aGA4pJydjQ34=
X-Received: by 2002:ac8:7183:: with SMTP id w3mr8137304qto.116.1629367515209; 
 Thu, 19 Aug 2021 03:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210817013852.3222824-1-stevensd@google.com>
 <20210817013852.3222824-8-stevensd@google.com>
 <f64b1349-d271-7b57-0eea-276dda065a87@arm.com>
In-Reply-To: <f64b1349-d271-7b57-0eea-276dda065a87@arm.com>
From: David Stevens <stevensd@chromium.org>
Date: Thu, 19 Aug 2021 19:05:04 +0900
Message-ID: <CAD=HUj6pRdiprRNc_wH_vLBMaNKZvQG9mhFa29vOD4WfcAo4=g@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] dma-iommu: account for min_align_mask
To: Robin Murphy <robin.murphy@arm.com>
Cc: open list <linux-kernel@vger.kernel.org>, Tom Murphy <murphyt7@tcd.ie>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>
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

  On Thu, Aug 19, 2021 at 6:03 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-08-17 02:38, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> >
> > For devices which set min_align_mask, swiotlb preserves the offset of
> > the original physical address within that mask. Since __iommu_dma_map
> > accounts for non-aligned addresses, passing a non-aligned swiotlb
> > address with the swiotlb aligned size results in the offset being
> > accounted for twice in the size passed to iommu_map_atomic. The extra
> > page exposed to DMA is also not cleaned up by __iommu_dma_unmap, since
> > that function unmaps with the correct size. This causes mapping failures
> > if the iova gets reused, due to collisions in the iommu page tables.
> >
> > To fix this, pass the original size to __iommu_dma_map, since that
> > function already handles alignment.
> >
> > Additionally, when swiotlb returns non-aligned addresses, there is
> > padding at the start of the bounce buffer that needs to be cleared.
> >
> > Fixes: 1f221a0d0dbf ("swiotlb: respect min_align_mask")
> > Signed-off-by: David Stevens <stevensd@chromium.org>
> > ---
> >   drivers/iommu/dma-iommu.c | 24 +++++++++++++-----------
> >   1 file changed, 13 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 6738420fc081..f2fb360c2907 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -788,7 +788,6 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> >       struct iommu_domain *domain = iommu_get_dma_domain(dev);
> >       struct iommu_dma_cookie *cookie = domain->iova_cookie;
> >       struct iova_domain *iovad = &cookie->iovad;
> > -     size_t aligned_size = size;
> >       dma_addr_t iova, dma_mask = dma_get_mask(dev);
> >
> >       /*
> > @@ -796,8 +795,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> >        * page aligned, we don't need to use a bounce page.
> >        */
> >       if (dev_use_swiotlb(dev) && iova_offset(iovad, phys | size)) {
> > -             void *padding_start;
> > -             size_t padding_size;
> > +             void *tlb_start;
> > +             size_t aligned_size, iova_off, mapping_end_off;
> >
> >               aligned_size = iova_align(iovad, size);
> >               phys = swiotlb_tbl_map_single(dev, phys, size, aligned_size,
> > @@ -806,23 +805,26 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> >               if (phys == DMA_MAPPING_ERROR)
> >                       return DMA_MAPPING_ERROR;
> >
> > -             /* Cleanup the padding area. */
> > -             padding_start = phys_to_virt(phys);
> > -             padding_size = aligned_size;
> > +             iova_off = iova_offset(iovad, phys);
> > +             tlb_start = phys_to_virt(phys - iova_off);
> >
> >               if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
> >                   (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)) {
> > -                     padding_start += size;
> > -                     padding_size -= size;
> > +                     /* Cleanup the padding area. */
> > +                     mapping_end_off = iova_off + size;
> > +                     memset(tlb_start, 0, iova_off);
> > +                     memset(tlb_start + mapping_end_off, 0,
> > +                            aligned_size - mapping_end_off);
> > +             } else {
> > +                     /* Nothing was sync'ed, so clear the whole buffer. */
> > +                     memset(tlb_start, 0, aligned_size);
> >               }
> > -
> > -             memset(padding_start, 0, padding_size);
> >       }
> >
> >       if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> >               arch_sync_dma_for_device(phys, size, dir);
> >
> > -     iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
> > +     iova = __iommu_dma_map(dev, phys, size, prot, dma_mask);
>
> I still don't see how this preserves min_align_mask if it is larger than
> the IOVA granule

That's a slightly different issue, and not addressed in this series. I
guess the commit message should be 'dma-iommu: account for
min_align_mask w/swiotlb'. At least from my understanding of
min_align_mask, getting min_align_mask larger than the IOVA granule to
work would require changes to IOVA allocation, not anything to do
directly with swiotlb bounce buffers. Also, probably changes to
scatterlist coalescing. That being said, it looks like the only driver
that sets min_align_mask is the nvme driver, which sets it to 4096.

> (either way this change here does nothing since the
> first thing __iommu_dma_map() does is iova_align() the size right back
> anyway).
>

__iommu_dma_map() doesn't just align the size, it aligns
size+iova_off. Let's say you're doing a read of size 512 bytes at
offset 2048 within a page. In this case, aligned_size will be 4096.
Without min_align_mask, phys will be page aligned, so that's fine. But
with min_align_mask=4096, phys will also be at offset 2048. This
causes __iommu_dma_map to align 4096 + 2048, which becomes 8192. That
results in an extra page being mapped, which then doesn't get cleaned
up by __iommu_dma_unmap. That causes collisions in the IOMMU driver
the next time the iova is reused.

Passing size to __iommu_dma_map is sufficient. iommu_dma_map_page
needs to map [phys, phys+size), regardless of whether or not bounce
buffers are being used. __iommu_dma_map already takes care of cleaning
up the alignment, there's no need to do any extra alignment specific
to the bounce buffer case.

-David

> Robin.
>
> >       if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys))
> >               swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
> >       return iova;
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
