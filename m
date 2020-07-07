Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75413C433E0
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 14:24:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DEF42075B
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 14:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3fLamn6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DEF42075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0FC1987EE5;
	Tue,  7 Jul 2020 14:24:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5a15AoRCOFHo; Tue,  7 Jul 2020 14:24:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E3FFE87E84;
	Tue,  7 Jul 2020 14:24:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6A8CC0893;
	Tue,  7 Jul 2020 14:24:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 300DBC016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 14:24:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 265C588FEC
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 14:24:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U9EH1uIyt8kH for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 14:24:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8ABCA88FE3
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 14:24:48 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id a1so46719665ejg.12
 for <iommu@lists.linux-foundation.org>; Tue, 07 Jul 2020 07:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=McOB/0yYDJQ83thcjyemD5c9BdlKzyjDAog3KEfKSkg=;
 b=o3fLamn66/sQMIHRnVoui2FDdrvygbfj/EJvB9Xw4rIv+X9x15ea1yKUTl/955fnzN
 ilaKEb8ttIYKv59wL5G/bO46wHEJ9VdVfjJ9hiJOKl977QUGjg4Lf2pxJ3+c+cBdo7qj
 9cWYbEmJ0jAhS6KOF1mcCJOuaA0rI4YlTAepyHevjsGqCiKKzJ3Id+g6qy6HcrAzgRMy
 OuF87k/dWiLVPrbDxTo+ontV3+3tl9qTGWQUwmfVKEoEu9xKK70cbuv4fiMG+aXvoLBv
 MUubXLSuPp/SumMQ9Kn9iV2TGdU4QyxK2sw7Bx1d+C9FOSmta10Wl7OGhkkaIccGlxwy
 Mifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=McOB/0yYDJQ83thcjyemD5c9BdlKzyjDAog3KEfKSkg=;
 b=q6xAzc5vglgp00daZQY/AyVTrggpdK7zU/wFHXvLilWIsFvBiFy836/SUDh2sm8vAS
 XwBl11PBj3v7JJjybPIN7B316yujL1ZeI7j6Ixko1lu8DMaicKGsrMZdEOQooC/e47vu
 Lh/+Ir+2btKXPZt7kjgDeMJ5fHNITfGZ6+oNLHjWoYGUaPEglfKwXrf0kT+7Fljm05Eu
 6E82SIsb3epHrhvejzeZ3W9cNPQ0JWQpVSLoM9PZucBH/C+DohMrZJdyx8ti+pNA9p0h
 IpcPoCUd01B7QET5AHbSgqSyv7HVpOvM8oCPNqm3bwyfWMn4EV7laAeFbArCdAOqc1T8
 8Ncw==
X-Gm-Message-State: AOAM531bKlIL4jh4WFOo8hH6BmlxNyHWDu0AIEmc9mum563cF6LHz9Ep
 +FAv5tDSWazrfuSV83Rm++KLbfSIq/1Ma7mQ6o4=
X-Google-Smtp-Source: ABdhPJwm/0c5b1pm+RO/PcvtbbwfHWJUpLgSJZX4m+kdgXqWpEywCtvCuyEdwfXmE9Q48ukNOV1sECfMMVrbTNnIlGw=
X-Received: by 2002:a17:906:1187:: with SMTP id
 n7mr41984337eja.161.1594131887033; 
 Tue, 07 Jul 2020 07:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200626200414.14382-1-jcrouse@codeaurora.org>
 <20200626200414.14382-3-jcrouse@codeaurora.org>
 <99ecd948-7476-b9b4-12b4-1ced0084654f@arm.com>
In-Reply-To: <99ecd948-7476-b9b4-12b4-1ced0084654f@arm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 7 Jul 2020 07:25:18 -0700
Message-ID: <CAF6AEGv2YXu44r9O0ZRkNM2ny4oMStxn4=GoCS3CLpPAKh_KZw@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH v2 2/6] iommu/io-pgtable: Allow a pgtable
 implementation to skip TLB operations
To: Robin Murphy <robin.murphy@arm.com>
Cc: freedreno <freedreno@lists.freedesktop.org>, Joerg Roedel <jroedel@suse.de>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 John Stultz <john.stultz@linaro.org>, Will Deacon <will@kernel.org>
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

On Tue, Jul 7, 2020 at 4:34 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-06-26 21:04, Jordan Crouse wrote:
> > Allow a io-pgtable implementation to skip TLB operations by checking for
> > NULL pointers in the helper functions. It will be up to to the owner
> > of the io-pgtable instance to make sure that they independently handle
> > the TLB correctly.
>
> I don't really understand what this is for - tricking the IOMMU driver
> into not performing its TLB maintenance at points when that maintenance
> has been deemed necessary doesn't seem like the appropriate way to
> achieve anything good :/

No, for triggering the io-pgtable helpers into not performing TLB
maintenance.  But seriously, since we are creating pgtables ourselves,
and we don't want to be ioremap'ing the GPU's SMMU instance, the
alternative is plugging in no-op helpers.  Which amounts to the same
thing.

Currently (in a later patch in the series) we are using
iommu_flush_tlb_all() when unmapping, which is a bit of a big hammer.
Although I think we could be a bit more clever and do the TLB ops on
the GPU (since the GPU knows if pagetables we are unmapping from are
in-use and could skip the TLB ops otherwise).

On the topic, if we are using unique ASID values per set of
pagetables, how expensive is tlb invalidate for an ASID that has no
entries in the TLB?

BR,
-R

>
> Robin.
>
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > ---
> >
> >   include/linux/io-pgtable.h | 11 +++++++----
> >   1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> > index 53d53c6c2be9..bbed1d3925ba 100644
> > --- a/include/linux/io-pgtable.h
> > +++ b/include/linux/io-pgtable.h
> > @@ -210,21 +210,24 @@ struct io_pgtable {
> >
> >   static inline void io_pgtable_tlb_flush_all(struct io_pgtable *iop)
> >   {
> > -     iop->cfg.tlb->tlb_flush_all(iop->cookie);
> > +     if (iop->cfg.tlb)
> > +             iop->cfg.tlb->tlb_flush_all(iop->cookie);
> >   }
> >
> >   static inline void
> >   io_pgtable_tlb_flush_walk(struct io_pgtable *iop, unsigned long iova,
> >                         size_t size, size_t granule)
> >   {
> > -     iop->cfg.tlb->tlb_flush_walk(iova, size, granule, iop->cookie);
> > +     if (iop->cfg.tlb)
> > +             iop->cfg.tlb->tlb_flush_walk(iova, size, granule, iop->cookie);
> >   }
> >
> >   static inline void
> >   io_pgtable_tlb_flush_leaf(struct io_pgtable *iop, unsigned long iova,
> >                         size_t size, size_t granule)
> >   {
> > -     iop->cfg.tlb->tlb_flush_leaf(iova, size, granule, iop->cookie);
> > +     if (iop->cfg.tlb)
> > +             iop->cfg.tlb->tlb_flush_leaf(iova, size, granule, iop->cookie);
> >   }
> >
> >   static inline void
> > @@ -232,7 +235,7 @@ io_pgtable_tlb_add_page(struct io_pgtable *iop,
> >                       struct iommu_iotlb_gather * gather, unsigned long iova,
> >                       size_t granule)
> >   {
> > -     if (iop->cfg.tlb->tlb_add_page)
> > +     if (iop->cfg.tlb && iop->cfg.tlb->tlb_add_page)
> >               iop->cfg.tlb->tlb_add_page(gather, iova, granule, iop->cookie);
> >   }
> >
> >
> _______________________________________________
> Freedreno mailing list
> Freedreno@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/freedreno
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
