Return-Path: <SRS0=QvS0=3F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D127C33CAF
	for <iommu@archiver.kernel.org>; Thu, 16 Jan 2020 23:09:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0ED42072E
	for <iommu@archiver.kernel.org>; Thu, 16 Jan 2020 23:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oraTFzCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0ED42072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id ABEFA2155B;
	Thu, 16 Jan 2020 23:09:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hfbLSYX2ls-6; Thu, 16 Jan 2020 23:09:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5FCC2203B5;
	Thu, 16 Jan 2020 23:09:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44298C1D82;
	Thu, 16 Jan 2020 23:09:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8337C077D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jan 2020 23:09:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CEB2787DDB
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jan 2020 23:09:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YDEp0+s0cirA for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jan 2020 23:09:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1956887DC5
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jan 2020 23:09:19 +0000 (UTC)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B3F58207FF
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jan 2020 23:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579216158;
 bh=LoHupW9qCJ7phkgs2sZp0Zyk2cnZNOABudI3pb+dJjA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=oraTFzCOiWxEKuDzczbnrBj1LPgqqRq01/Op7tE442ncNbJVCmMOPB+y0bc/Cst79
 KGxNEsP/sq5e4iMkhGt1Zx+dSgTtYlppyUv6+tOa04opORlC9G+LufPpvvxopn5aJK
 Vp+lh0EMJRLTXLoU81q70YQGg9sJo5jwCuPQjyKE=
Received: by mail-qt1-f174.google.com with SMTP id d5so20386001qto.0
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jan 2020 15:09:18 -0800 (PST)
X-Gm-Message-State: APjAAAVV+AqYPfM+lfSx09GsxKQqsado8nFhTHytvungKJBEOcz79uRW
 HpWcAFhqmBHfwNauA8vfJr9agNYvPdBICydfZQ==
X-Google-Smtp-Source: APXvYqzQ3d6HR9m+kzkCmXhNqqXJRbu9Dm22ICkymk1ps1h7XmvDI/vWnC/KGHSBN9scixti2b+8TFsoIPylG9FwYcU=
X-Received: by 2002:ac8:6747:: with SMTP id n7mr4837753qtp.224.1579216157767; 
 Thu, 16 Jan 2020 15:09:17 -0800 (PST)
MIME-Version: 1.0
References: <20200113143924.11576-1-robh@kernel.org>
 <2ee87a12-1a0e-bd48-0209-b5e205342d44@redhat.com>
 <CAL_JsqKrh0nLuoRgi1-bKyEErwCFpWPRPNVDuoeJrbFMCz60KQ@mail.gmail.com>
 <bc72f4c5-de47-8684-c7d5-0e60a4a78ee2@redhat.com>
 <CAL_Jsq+fwdLfxgW=aoMNySrKunSgtC+i5ttsn1vCdR2p4BMPfA@mail.gmail.com>
 <4e56aa27-37f0-d8d9-46fd-871055abcb49@redhat.com>
In-Reply-To: <4e56aa27-37f0-d8d9-46fd-871055abcb49@redhat.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 16 Jan 2020 17:09:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKABoE+0crGwyZdNogNgEoG=MOOpf6deQgH6s73c0UNdA@mail.gmail.com>
Message-ID: <CAL_JsqKABoE+0crGwyZdNogNgEoG=MOOpf6deQgH6s73c0UNdA@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add SMMUv3.2 range invalidation support
To: Auger Eric <eric.auger@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>, Will Deacon <will@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

On Thu, Jan 16, 2020 at 3:23 PM Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi Rob,
>
> On 1/16/20 5:57 PM, Rob Herring wrote:
> > On Wed, Jan 15, 2020 at 10:33 AM Auger Eric <eric.auger@redhat.com> wrote:
> >>
> >> Hi Rob,
> >>
> >> On 1/15/20 3:02 PM, Rob Herring wrote:
> >>> On Wed, Jan 15, 2020 at 3:21 AM Auger Eric <eric.auger@redhat.com> wrote:
> >>>>
> >>>> Hi Rob,
> >>>>
> >>>> On 1/13/20 3:39 PM, Rob Herring wrote:
> >>>>> Arm SMMUv3.2 adds support for TLB range invalidate operations.
> >>>>> Support for range invalidate is determined by the RIL bit in the IDR3
> >>>>> register.
> >>>>>
> >>>>> The range invalidate is in units of the leaf page size and operates on
> >>>>> 1-32 chunks of a power of 2 multiple pages. First we determine from the
> >>>>> size what power of 2 multiple we can use and then adjust the granule to
> >>>>> 32x that size.
> >
> >>>>> @@ -2022,12 +2043,39 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
> >>>>>               cmd.tlbi.vmid   = smmu_domain->s2_cfg.vmid;
> >>>>>       }
> >>>>>
> >>>>> +     if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
> >>>>> +             unsigned long tg, scale;
> >>>>> +
> >>>>> +             /* Get the leaf page size */
> >>>>> +             tg = __ffs(smmu_domain->domain.pgsize_bitmap);
> >>>> it is unclear to me why you can't set tg with the granule parameter.
> >>>
> >>> granule could be 2MB sections if THP is enabled, right?
> >>
> >> Ah OK I thought it was a page size and not a block size.
> >>
> >> I requested this feature a long time ago for virtual SMMUv3. With
> >> DPDK/VFIO the guest was sending page TLB invalidation for each page
> >> (granule=4K or 64K) part of the hugepage buffer and those were trapped
> >> by the VMM. This stalled qemu.
> >
> > I did some more testing to make sure THP is enabled, but haven't been
> > able to get granule to be anything but 4K. I only have the Fast Model
> > with AHCI on PCI to test this with. Maybe I'm hitting some place where
> > THPs aren't supported yet.
> >
> >>>>> +             /* Determine the power of 2 multiple number of pages */
> >>>>> +             scale = __ffs(size / (1UL << tg));
> >>>>> +             cmd.tlbi.scale = scale;
> >>>>> +
> >>>>> +             cmd.tlbi.num = CMDQ_TLBI_RANGE_NUM_MAX - 1;
> >>>> Also could you explain why you use CMDQ_TLBI_RANGE_NUM_MAX.
> >>>
> >>> How's this:
> >>> /* The invalidation loop defaults to the maximum range */
> >> I would have expected num=0 directly. Don't we invalidate the &size in
> >> one shot as 2^scale * pages of granularity @tg? I fail to understand
> >> when NUM > 0.
> >
> > NUM is > 0 anytime size is not a power of 2. For example, if size is
> > 33 pages, then it takes 2 loops doing 32 pages and then 1 page. If
> > size is 34 pages, then NUM is (17-1) and SCALE is 1.
> OK I get it now. I misread the scale computation as log2() :-(.
>
> I still have a doubt about the scale choice. What if you invalidate a
> large number of pages such as 1025 pages. scale is 0 and you end up with
> 32 * 32 * 2^0 + 1 * 2 * 2^0  invalidations (33). Whereas you could
> invalidate the whole range with 2 invalidation commands: 1 x 2^10 +
> 1*1^1 (packing the invalidations by largest scale). Am I correct or do I
> still miss something?

No, that's correct. 33 is a lot better than 1025 though. :) 1023 pages
is about the worst case if we assume we get 2MB blocks, but maybe not
a good assumption given our testing so far...

So thinking out loud, I guess we could iterate on power of 2 chunks of
size (in units of pages) like this:

while (size) {
  scale = fls(size);
  range = 1 << scale;
  size &= ~range;

  iova += range;
}

But that means NUM is always 0, so also not ideal. So we need to
extract 5 bits from size for NUM on each iteration:

while (size) {
  scale = __ffs(size);
  num = (size >> scale)) & 0x1f;
  size -= (num + 1) * (1 << scale);

  ...
}

So worst case, we'd have 4 invalidates for up to 4G.

> Besides in the patch I think in the while loop the iova should be
> incremented with the actual number of invalidated bytes and not the max
> sized granule variable.

Ok.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
