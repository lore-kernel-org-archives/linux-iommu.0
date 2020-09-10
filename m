Return-Path: <SRS0=7VEr=CT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE94C2BB84
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 08:26:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86F4A2076D
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 08:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YFX3C21Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F4A2076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 14BF887655;
	Thu, 10 Sep 2020 08:26:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Ul-95oF-uba; Thu, 10 Sep 2020 08:26:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 680848764C;
	Thu, 10 Sep 2020 08:26:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43F21C0859;
	Thu, 10 Sep 2020 08:26:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49033C0051
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 08:26:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 30A4A86EE8
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 08:26:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5WTNEYxH1kY2 for <iommu@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 08:26:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1755286EAA
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 08:26:21 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id a9so4899234wmm.2
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 01:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jV15et7Yw8A7Imw4OszYwam1pGezadF7ay4AoPCRTlw=;
 b=YFX3C21ZwVO7s35wZGtviE1XqbE7aCLtO3wFFDiZBQLPyeEj7XL687V0Ka17r+pHow
 trvRePYr75Vgj+evG/sbfJ5EEYunaBaoAbSvIka3o38lU7/FKTwwJQ7jj74iOjPtp4iL
 YrUv5JVWK1FJoTvd7t+cUgJAdvv6LvUo9pvjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jV15et7Yw8A7Imw4OszYwam1pGezadF7ay4AoPCRTlw=;
 b=Oje45kW/zU6CxeX4V7URqPBA0PwsWRiriu0gVDXt+KKY16doigV0T1LAR2nglMOw0s
 uvHjWU7Nu7u1HJOtWJ/iA3/IhMNhxRHU9m2Z4vswEzxU8oGFcl05WKv9ns5/bENKfHYE
 CKV+oIvjRggrCb0oFU193RtHyXqSiNs0LbZHGsV/XGg0fTQU5yXPNHryaNIfj3rEgxWb
 4t/brsSvpH3fqhBwzi+KWvP6IsPOTRG1RNSwWX5KQa5zbar+I8/3K4+8VAE/wzSoK6rU
 9MXiH8cHLxxJKd8C06MNC3URTv3//mF6OjGYDvu/kCyZoB3smUps3VSUXIbz58FSR+la
 KSug==
X-Gm-Message-State: AOAM532y7wM3nN+sYwHQ+EdR/KXRIZiQxPe3+Xkc/PPJtRTxgYUrHaAQ
 /rqSTNU0w7tD+Qpn6NnFPgPJTCD4yyaBi/gN7+cUFg==
X-Google-Smtp-Source: ABdhPJwMw0Wh177JlXOipH/ky7eUTophvRRubdU+aDyAbXNA/Xm+BsW76uAWLWKihoVqdk9x08SGwZLIRGafLV94erc=
X-Received: by 2002:a7b:c384:: with SMTP id s4mr7073300wmj.138.1599726379101; 
 Thu, 10 Sep 2020 01:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200909053234.17027-1-srinath.mannam@broadcom.com>
 <1996b772-774c-3475-05cc-77ae87176c3f@arm.com>
In-Reply-To: <1996b772-774c-3475-05cc-77ae87176c3f@arm.com>
Date: Thu, 10 Sep 2020 13:56:07 +0530
Message-ID: <CABe79T6fAmovPdx6ZzBeR8D9mJoX5qoAOG3=ZOt5TYpeT=LUJQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/dma: Fix IOVA reserve dma ranges
To: Robin Murphy <robin.murphy@arm.com>
Cc: poza@codeaurora.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org,
 BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
 Bjorn Helgaas <bhelgaas@google.com>
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
From: Srinath Mannam via iommu <iommu@lists.linux-foundation.org>
Reply-To: Srinath Mannam <srinath.mannam@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Sep 9, 2020 at 5:35 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
Hi Robin,
Thanks for review
> On 2020-09-09 06:32, Srinath Mannam wrote:
> > Fix IOVA reserve failure for memory regions listed in dma-ranges in the
> > following cases.
> >
> > - start address of memory region is 0x0.
>
> That's fair enough, and in fact generalises to the case of zero-sized
> gaps between regions, which is indeed an oversight.
Yes this is the main reason for the requirement of this fix.
>
> > - end address of a memory region is equal to start address of next memory
> >    region.
>
> This part doesn't make much sense, however - if the regions described in
> bridge->dma_ranges overlap, that's a bug in whoever created a malformed
> list to begin with. Possibly it's just poor wording, and you're using
> "memory regions" to refer to any or all of the dma_ranges, the reserved
> IOVA ranges, and what "start" and "end" in this function represent which
> isn't quite either of those.
You are right, this case is very unlikely that nobody lists regions with zero
gap, in such a case they will combine both the regions. Reason for highlighting
this point is, the same fix will handle this case also. Here I used memory
regions to refer entries of dma-ranges(allowed IOVA addresses range) not
reserved IOVA ranges. start and end variables in this function refers to
start and end addresses of reserved IOVA ranges which are derived from
dma ranges resources start and end values.
>
> > Fixes: aadad097cd46f ("iommu/dma: Reserve IOVA for PCIe inaccessible DMA address")
> > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > ---
> >   drivers/iommu/dma-iommu.c | 15 +++++++++++----
> >   1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 5141d49a046b..0a3f67a4f9ae 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -213,14 +213,21 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
> >       resource_list_for_each_entry(window, &bridge->dma_ranges) {
> >               end = window->res->start - window->offset;
> >   resv_iova:
> > +             if (end < start) {
> > +                     /* dma_ranges list should be sorted */
> > +                     dev_err(&dev->dev, "Failed to reserve IOVA\n");
> > +                     return -EINVAL;
> > +             }
> > +             /*
> > +              * Skip the cases when start address of first memory region is
> > +              * 0x0 and end address of one memory region and start address
> > +              * of next memory region are equal. Reserve IOVA for rest of
> > +              * addresses fall in between given memory ranges.
> > +              */
> >               if (end > start) {
> >                       lo = iova_pfn(iovad, start);
> >                       hi = iova_pfn(iovad, end);
> >                       reserve_iova(iovad, lo, hi);
> > -             } else {
>
> Surely this only needs to be a one-liner?
Yes I agree with you this one line is sufficient.
>
> -               } else {
> +               } else if (end < start) {
>
> (or possibly "end != start"; I can't quite decide which expresses the
> semantic intent better)
I think "end < start" is better choice because it tells list is not sorted
and "!=" contradicts previous condition "end > start".
>
> The rest just looks like unnecessary churn - I don't think it needs
> commenting that a sorted list may simply not have gaps between entries,
> and as above I think the wording of that comment is actively misleading.
I agree with you, these lines were added to explain the issue and fix with
more details.
I will send a new patch with a single line change as you said.
" } else if (end < start) {"

Thanks & Regards,
Srinath.
>
> Robin.
>
> > -                     /* dma_ranges list should be sorted */
> > -                     dev_err(&dev->dev, "Failed to reserve IOVA\n");
> > -                     return -EINVAL;
> >               }
> >
> >               start = window->res->end - window->offset + 1;
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
