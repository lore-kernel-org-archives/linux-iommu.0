Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDA7C433EF
	for <iommu@archiver.kernel.org>; Fri, 25 Mar 2022 07:43:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 173C94159A;
	Fri, 25 Mar 2022 07:43:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vDTOo6vrsRLf; Fri, 25 Mar 2022 07:43:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C86F4408A0;
	Fri, 25 Mar 2022 07:43:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A301C002C;
	Fri, 25 Mar 2022 07:43:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69CFCC0012
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 07:43:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4685960759
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 07:43:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id El9mR7rxg-9Z for <iommu@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 07:43:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7CC31606A0
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 07:43:27 +0000 (UTC)
Received: by mail-yb1-xb2a.google.com with SMTP id o5so12654615ybe.2
 for <iommu@lists.linux-foundation.org>; Fri, 25 Mar 2022 00:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Am0L9ligemASqtUdJYFc236DAhyGFKoE3Ccf35F1C6w=;
 b=Uq+OITyfpzuTELkA8wF9pc0m+o/xFTC70oLMbh2xskCEGMyjFzdzgbvr7sKJ3B8ZKs
 rE9Aizm4O6kZBa9okUHVY0gwnMA1KMqNMb0fSOYdCSqJDKfO4c5wPPyNsGF6W82/oCUj
 XM5aUtbGSNGo7XTF5SkMIftNT2rxMvW4bF1/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Am0L9ligemASqtUdJYFc236DAhyGFKoE3Ccf35F1C6w=;
 b=tb9F467t35nxrnTJZaxIjFzrtM3f7Oa7sXgS2OJgT0Emwwr+63cmvNvb13CEnVP302
 vEysiwxBsEIUqdfrVpfqXqKcqt+Hl6Qll/LaJWbBE3LVFU6rUb1ThZVRyRq53W5BZDcY
 bU5TgXEFYsiTnc+LHfknhIoByvp4ZHvy02NCZTkNT3EMvjG/yq1pI9sqeeJ9LCOx6206
 HpXrvsXzhuT0Ptno5zish0ZD5y/zcpaZ6x2JIzCkFJXR8keRtZOH973cYdHh29veD37E
 fk0FTEsVHImDPH0rdQ4woR/9tD47yvn5Qwut4Zsdv79HXn7uJbgVqtuN9AcGd/FEeqTI
 X52Q==
X-Gm-Message-State: AOAM530vfIjfNVWxXDeBkam8SRBiO9snqxGQ5jmGULlXeSzrXRnQ9vqu
 Iebn3y8Lsm1X6jEvXzvIFxcrr1388+JllZy1AOiqOQ==
X-Google-Smtp-Source: ABdhPJyqOgFRVDd45FmufhY5GTrXj9stUYT0oewf28eZCCtvQS4mIdD0SmV9zTIJliXbUngg1JdOfaMLh+zCKvLMa4E=
X-Received: by 2002:a05:6902:724:b0:635:1972:616f with SMTP id
 l4-20020a056902072400b006351972616fmr8984769ybt.453.1648194206434; Fri, 25
 Mar 2022 00:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220322063555.1422042-1-stevensd@google.com>
 <BN9PR11MB52761E41CAD28CFCB935688C8C1A9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <MW5PR11MB58814148CD05C8284C3BCB23891A9@MW5PR11MB5881.namprd11.prod.outlook.com>
In-Reply-To: <MW5PR11MB58814148CD05C8284C3BCB23891A9@MW5PR11MB5881.namprd11.prod.outlook.com>
From: David Stevens <stevensd@chromium.org>
Date: Fri, 25 Mar 2022 16:43:16 +0900
Message-ID: <CAD=HUj5dPb9jsUyh5REm=dX0HJaqW807LxnAouQ9rspMHB7vuw@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/vt-d: calculate mask for non-aligned flushes
To: "Zhang, Tina" <tina.zhang@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

On Fri, Mar 25, 2022 at 4:15 PM Zhang, Tina <tina.zhang@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: iommu <iommu-bounces@lists.linux-foundation.org> On Behalf Of
> > Tian, Kevin
> > Sent: Friday, March 25, 2022 2:14 PM
> > To: David Stevens <stevensd@chromium.org>; Lu Baolu
> > <baolu.lu@linux.intel.com>
> > Cc: iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org
> > Subject: RE: [PATCH v2] iommu/vt-d: calculate mask for non-aligned flushes
> >
> > > From: David Stevens
> > > Sent: Tuesday, March 22, 2022 2:36 PM
> > >
> > > From: David Stevens <stevensd@chromium.org>
> > >
> > > Calculate the appropriate mask for non-size-aligned page selective
> > > invalidation. Since psi uses the mask value to mask out the lower
> > > order bits of the target address, properly flushing the iotlb requires
> > > using a mask value such that [pfn, pfn+pages) all lie within the
> > > flushed size-aligned region.  This is not normally an issue because
> > > iova.c always allocates iovas that are aligned to their size. However,
> > > iovas which come from other sources (e.g. userspace via VFIO) may not
> > > be aligned.
> > >
> > > Signed-off-by: David Stevens <stevensd@chromium.org>
> > > ---
> > > v1 -> v2:
> > >  - Calculate an appropriate mask for non-size-aligned iovas instead
> > >    of falling back to domain selective flush.
> > >
> > >  drivers/iommu/intel/iommu.c | 27 ++++++++++++++++++++++++---
> > >  1 file changed, 24 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > > index 5b196cfe9ed2..ab2273300346 100644
> > > --- a/drivers/iommu/intel/iommu.c
> > > +++ b/drivers/iommu/intel/iommu.c
> > > @@ -1717,7 +1717,8 @@ static void iommu_flush_iotlb_psi(struct
> > > intel_iommu *iommu,
> > >                               unsigned long pfn, unsigned int pages,
> > >                               int ih, int map)
> > >  {
> > > -   unsigned int mask = ilog2(__roundup_pow_of_two(pages));
> > > +   unsigned int aligned_pages = __roundup_pow_of_two(pages);
> > > +   unsigned int mask = ilog2(aligned_pages);
> > >     uint64_t addr = (uint64_t)pfn << VTD_PAGE_SHIFT;
> > >     u16 did = domain->iommu_did[iommu->seq_id];
> > >
> > > @@ -1729,10 +1730,30 @@ static void iommu_flush_iotlb_psi(struct
> > > intel_iommu *iommu,
> > >     if (domain_use_first_level(domain)) {
> > >             domain_flush_piotlb(iommu, domain, addr, pages, ih);
> > >     } else {
> > > +           unsigned long bitmask = aligned_pages - 1;
> > > +
> > > +           /*
> > > +            * PSI masks the low order bits of the base address. If the
> > > +            * address isn't aligned to the mask, then compute a mask
> > > value
> > > +            * needed to ensure the target range is flushed.
> > > +            */
> > > +           if (unlikely(bitmask & pfn)) {
> > > +                   unsigned long end_pfn = pfn + pages - 1, shared_bits;
> > > +
> > > +                   /*
> > > +                    * Since end_pfn <= pfn + bitmask, the only way bits
> > > +                    * higher than bitmask can differ in pfn and end_pfn
> > > is
> > > +                    * by carrying. This means after masking out bitmask,
> > > +                    * high bits starting with the first set bit in
> > > +                    * shared_bits are all equal in both pfn and end_pfn.
> > > +                    */
> > > +                   shared_bits = ~(pfn ^ end_pfn) & ~bitmask;
> > > +                   mask = shared_bits ? __ffs(shared_bits) :
> > > BITS_PER_LONG;
> > > +           }
> >
> > While it works I wonder whether below is simpler regarding to readability:
> >
> >       } else {
> > +             /*
> > +              * PSI masks the low order bits of the base address. If the
> > +              * address isn't aligned to the mask and [pfn, pfn+pages)
> > +              * don't all lie within the flushed size-aligned region,
> > +              * simply increment the mask by one to cover the trailing
> > pages.
> > +              */
> > +             if (unlikely((pfn & (aligned_pages - 1)) &&
> > +                          (pfn + pages - 1 >= ALIGN(pfn, aligned_pages))))
> > +                     mask++;
>
> According to the vt-d spec, increasing mask means more bits of the pfn would be masked out. So simply increasing the mask number might not be correct.
> This second version does give more consideration on that.
>

Right, this is what the more complicated code handles. For a concrete
example, if pfn=0x17f and pages=2, just doing mask+1 would only flush
[0x17c, 0x17f], which still misses 0x180. To ensure 0x180 is flushed,
mask needs to be 8.

-David


-David
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
