Return-Path: <SRS0=jPbF=ND=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF67C4338F
	for <iommu@archiver.kernel.org>; Thu, 12 Aug 2021 01:45:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B78960231
	for <iommu@archiver.kernel.org>; Thu, 12 Aug 2021 01:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B78960231
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D57F4405FB;
	Thu, 12 Aug 2021 01:45:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7W0tIherYRE9; Thu, 12 Aug 2021 01:45:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 677D9405F7;
	Thu, 12 Aug 2021 01:45:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 252C5C0010;
	Thu, 12 Aug 2021 01:45:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5A92C000E
 for <iommu@lists.linux-foundation.org>; Thu, 12 Aug 2021 01:45:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B1DF160A48
 for <iommu@lists.linux-foundation.org>; Thu, 12 Aug 2021 01:45:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K3i6t-lfF0s7 for <iommu@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 01:45:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 94D0B608AA
 for <iommu@lists.linux-foundation.org>; Thu, 12 Aug 2021 01:45:38 +0000 (UTC)
Received: by mail-qk1-x735.google.com with SMTP id az7so4755507qkb.5
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 18:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sVlaR7t/R94hd0zmYZq3g+CzewEHmfZEE8FNG6b25iA=;
 b=nTPBIgSR1+DYRuTz126NpJG3MGlML74YM1Le2P962yisyrtzCnff17kwv/c5kyI7i5
 k83aktakoC1RDga4lJ6tpulebc9ZSC51LDDl2Zq3S3sHSaqssdBI/jblrsHMO7MDGXNF
 /nSk5dmIM+FwBtSIrNcRk0EI7SZSD1NCSYxz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sVlaR7t/R94hd0zmYZq3g+CzewEHmfZEE8FNG6b25iA=;
 b=skWODZsKXxwu+irUz69byBLyRMbeMR0KVSqsEnEOScBc7OU+f25QBAy8YON4kcKYLF
 S3r5eo07FUd0GKTmr8lqNq0JDXZCTIEQ6U8B3d6BDMWE98/nPFk/Dx8wd4xWhoOE+8/T
 vaatb2SS4pGldOUl1rwz1Ee5TRsuS9lupmdtYyFmrF1tzaJyRDCO1hd4jOPyg9S1Jl6A
 rYmICdX3fWVz1vUmcZ7tbPNmLMOnNSLCD8WRWamYuiuEa7vlzVIrcfjOz/ZiNXiqOCrn
 CEWRempTfzX61JsMmgHXX++tw6O1pm3wC2LUrMJRdEg3MAR9pcFO/FjniHjWZzwgeiWF
 FPnQ==
X-Gm-Message-State: AOAM533e2BfFM8mv8CyGz/7Lyw7OVIixBi1paOyTuQDTClk/VsHzOuqw
 MX3+qXz+agfeQ/Tg2sAzHsfdtrFGUq7A+gzmLpyL6Q==
X-Google-Smtp-Source: ABdhPJwC6Y9w83pWVs6KCrJupE+hkSFvjIO2mfTRLAyBQ2KctEfzgqHFI5pSOZvgZ0DFQfcOgMhPzyLR0BQnU31+3lE=
X-Received: by 2002:a37:8505:: with SMTP id h5mr2116592qkd.241.1628732737520; 
 Wed, 11 Aug 2021 18:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210811024247.1144246-1-stevensd@google.com>
 <20210811024247.1144246-6-stevensd@google.com>
 <b5fff839-3242-7080-13f7-61c0e40af304@arm.com>
In-Reply-To: <b5fff839-3242-7080-13f7-61c0e40af304@arm.com>
From: David Stevens <stevensd@chromium.org>
Date: Thu, 12 Aug 2021 10:45:26 +0900
Message-ID: <CAD=HUj7u71cdPfJ5t2tC8A26YOgwDe8H7i-h78f_MeRmuNUySQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] dma-iommu: account for min_align_mask
To: Robin Murphy <robin.murphy@arm.com>
Cc: open list <linux-kernel@vger.kernel.org>, Tom Murphy <murphyt7@tcd.ie>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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

On Thu, Aug 12, 2021 at 4:12 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-08-11 03:42, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> >
> > For devices which set min_align_mask, swiotlb preserves the offset of
> > the original physical address within that mask. Since __iommu_dma_map
> > accounts for non-aligned addresses, passing a non-aligned swiotlb
> > address with the swiotlb aligned size results in the offset being
> > accounted for twice in the size passed to iommu_map_atomic. The extra
> > page exposed to DMA is also not cleaned up by __iommu_dma_unmap, since
> > tht at function unmaps with the correct size. This causes mapping failures
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
> >   drivers/iommu/dma-iommu.c | 23 ++++++++++++-----------
> >   1 file changed, 12 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 89b689bf801f..ffa7e8ef5db4 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -549,9 +549,8 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
> >       struct iommu_domain *domain = iommu_get_dma_domain(dev);
> >       struct iommu_dma_cookie *cookie = domain->iova_cookie;
> >       struct iova_domain *iovad = &cookie->iovad;
> > -     size_t aligned_size = org_size;
> > -     void *padding_start;
> > -     size_t padding_size;
> > +     void *tlb_start;
> > +     size_t aligned_size, iova_off, mapping_end_off;
> >       dma_addr_t iova;
> >
> >       /*
> > @@ -566,24 +565,26 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
> >               if (phys == DMA_MAPPING_ERROR)
> >                       return DMA_MAPPING_ERROR;
> >
> > -             /* Cleanup the padding area. */
> > -             padding_start = phys_to_virt(phys);
> > -             padding_size = aligned_size;
> > +             iova_off = iova_offset(iovad, phys);
> > +             tlb_start = phys_to_virt(phys - iova_off);
> >
> > +             /* Cleanup the padding area. */
> >               if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
> >                   (dir == DMA_TO_DEVICE ||
> >                    dir == DMA_BIDIRECTIONAL)) {
> > -                     padding_start += org_size;
> > -                     padding_size -= org_size;
> > +                     mapping_end_off = iova_off + org_size;
> > +                     memset(tlb_start, 0, iova_off);
> > +                     memset(tlb_start + mapping_end_off, 0,
> > +                            aligned_size - mapping_end_off);
> > +             } else {
> > +                     memset(tlb_start, 0, aligned_size);
> >               }
> > -
> > -             memset(padding_start, 0, padding_size);
> >       }
> >
> >       if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> >               arch_sync_dma_for_device(phys, org_size, dir);
> >
> > -     iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
> > +     iova = __iommu_dma_map(dev, phys, org_size, prot, dma_mask);
>
> This doesn't feel right - what if the IOVA granule was equal to or
> smaller than min_align_mask, wouldn't you potentially end up mapping the
> padding rather than the data?

The phys value returned by swiotlb_tbl_map_single is the address of
the start of the data in the swiotlb buffer, so the range that needs
to be mapped is [phys, phys + org_size). __iommu_dma_map will handle
this the same as it handles a misaligned mapping in the non-swiotlb
case. It might map memory before/after the desired range, but it will
map the entire range and iova will be the mapped address of phys. Is
there something I'm missing there?

That said, considering that memory before phys might be mapped, I
think there is actually still a bug. The buffer allocated by swiotlb
needs to be aligned to the granule size to ensure that preceding
swiotlb slots aren't mapped. The swiotlb does align allocations larger
than a page to PAGE_SIZE, but if IO_TLB_SIZE < IOVA granule <
PAGE_SIZE, then there can be problems. That can't happen if PAGE_SIZE
is 4k, but it can for larger page sizes. I'll add a fix for that to
the next version of this series.

-David

> Robin.
>
> >       if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys))
> >               swiotlb_tbl_unmap_single(dev, phys, org_size, dir, attrs);
> >       return iova;
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
