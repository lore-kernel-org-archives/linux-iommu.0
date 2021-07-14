Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD19C07E9A
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 04:59:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CB20613B0
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 04:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB20613B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D36F4608F2;
	Wed, 14 Jul 2021 04:59:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sy0ht3iDgSAm; Wed, 14 Jul 2021 04:59:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BB4EA6071F;
	Wed, 14 Jul 2021 04:59:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E77CC0010;
	Wed, 14 Jul 2021 04:59:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86D99C000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 04:59:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6D55440697
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 04:59:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=canonical.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ViUEIyylLqzx for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 04:59:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2DA4140685
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 04:59:39 +0000 (UTC)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 62CE440616
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 04:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1626238777;
 bh=IuNCZleIvRlLDBhEJUxcoa5xesWkXuXCrji39Y/aMPw=;
 h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
 b=oRphYpdinUW/r8iLyGw3EUSNu2NsivHyjeqX2j8GRgZ8bjLta2Ygj4h0Ajz4Fi4y/
 n+vldnmywXFuU7cbngTgTso66ZWOhjlvOPRiK27haqSN0xFEh/4QhCeSJCkqIXtYjn
 37jOMvptS2FCK50fYlXaNcCKp11RlGtE1RmmNK2hro8W0QkhZqX/BOMGrYY6B0dxHF
 CHI9No5i0VhlyNUIH7XmCJ3JLuCpY9UuBiNl6bJBlRI+YTcsxGuz/07+r3tFHpPCPl
 To5ngp+FPR/yQan+hAHm2FaVhH7KqdRWBM6kNRwYmvhxOAJeg8gAfq894Ot8MKIyGl
 iraVwnxcqjEpA==
Received: by mail-ed1-f71.google.com with SMTP id
 c21-20020aa7d6150000b02903ab03a06e86so572497edr.14
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 21:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IuNCZleIvRlLDBhEJUxcoa5xesWkXuXCrji39Y/aMPw=;
 b=mNUWhW5Uz41XWEoC2O+EmfPz6NFtWjRgHzcmc4MvIoCoKb3iSnB6dnVO01YDpSjUlP
 JJyCrz0bd98qhfmXX3KsFvGZ4GOHnl51TwnKUvneTI76DzNP8QJGdBO9LZSPr3DVhCLa
 aEOQnU1X45NzhmUd/YmsNq3Y0OwBsIz/gHCIEvFwIAoSsBLQ426H2o+LbrDV9mREsfnA
 DedjbCO/KzHnt1un6JaXqnePWY5lisBwK8eFo1wKWl1DI6ZSC84CN6aWOvB75SjfSJ4f
 O+TRcCoNLANq2gdybYlW09KvM7fvLcIsVvVsUx+Fx08TncWUmQhD3agIy4/ROr9rUagR
 ah8w==
X-Gm-Message-State: AOAM5326koa4eQV3qJ+tJG/cT6x3NZJzBNyqKjU5fJxfNcVA+VsaTSp/
 AUznNvZ8GE0ljYQ1REj55XTiqchcjB+xobQKiSi18IjIbZZ7eJqwI5ym43WK8fRO8Mz0a3wWj1f
 N2g5Yt8k7OS1GU9E5vHHw8t7dM8tgAScdalmrjw928TJcwvYfYJrOMXxPviEDmmk=
X-Received: by 2002:a17:907:724b:: with SMTP id
 ds11mr10478506ejc.192.1626238777054; 
 Tue, 13 Jul 2021 21:59:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRbJHePPsqGNhB2jafTmgA7eCmZexPsfPxuY56irzwgXiVYXY8NchRXgcLJLBngqftlOI645bXKZZ6n8PRSoc=
X-Received: by 2002:a17:907:724b:: with SMTP id
 ds11mr10478490ejc.192.1626238776826; 
 Tue, 13 Jul 2021 21:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210708074232.924844-1-kai.heng.feng@canonical.com>
 <YObFJREB9/JlcNZP@8bytes.org> <fde11cec-d1bd-49be-f129-c69a973d1b3b@arm.com>
 <CAAd53p40RcG0oeYr9QAKMjYRtyq7he=d_b_a39n4Rt5JSVScRQ@mail.gmail.com>
 <f3bdedcb-5602-cbca-7df1-019e8b8c4217@arm.com> <YO4odF0EwqxfNLFq@fedora>
In-Reply-To: <YO4odF0EwqxfNLFq@fedora>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 14 Jul 2021 12:59:25 +0800
Message-ID: <CAAd53p4jgKGuLOyZH+KEzz-KiR2D0Th4MCBo13m4JO+a=n2Lhw@mail.gmail.com>
Subject: Re: [PATCH] iommu/amd: Enable swiotlb if any device supports iommu v2
 and uses identity mapping
To: Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc: will@kernel.org,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, open list <linux-kernel@vger.kernel.org>
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

On Wed, Jul 14, 2021 at 7:57 AM Konrad Rzeszutek Wilk <konrad@darnok.org> wrote:
>
> On Thu, Jul 08, 2021 at 03:43:42PM +0100, Robin Murphy wrote:
> > On 2021-07-08 14:57, Kai-Heng Feng wrote:
> > > On Thu, Jul 8, 2021 at 6:18 PM Robin Murphy <robin.murphy@arm.com> wrote:
> > > >
> > > > On 2021-07-08 10:28, Joerg Roedel wrote:
> > > > > On Thu, Jul 08, 2021 at 03:42:32PM +0800, Kai-Heng Feng wrote:
> > > > > > @@ -344,6 +344,9 @@ static int iommu_init_device(struct device *dev)
> > > > > >
> > > > > >               iommu = amd_iommu_rlookup_table[dev_data->devid];
> > > > > >               dev_data->iommu_v2 = iommu->is_iommu_v2;
> > > > > > +
> > > > > > +            if (dev_data->iommu_v2)
> > > > > > +                    swiotlb = 1;
> > > > >
> > > > > This looks like the big hammer, as it will affect all other systems
> > > > > where the AMD GPUs are in their own group.
> > > > >
> > > > > What is needed here is an explicit check whether a non-iommu-v2 device
> > > > > is direct-mapped because it shares a group with the GPU, and only enable
> > > > > swiotlb in this case.
> > > >
> > > > Right, it's basically about whether any DMA-limited device might at any
> > > > time end up in an IOMMU_DOMAIN_IDENTITY domain. And given the
> > > > possibility of device hotplug and the user being silly with the sysfs
> > > > interface, I don't think we can categorically determine that at boot time.
> > > >
> > > > Also note that Intel systems are likely to be similarly affected (in
> > > > fact intel-iommu doesn't even have the iommu_default_passthough() check
> > > > so it's probably even easier to blow up).
> > >
> > > swiotlb is enabled by pci_swiotlb_detect_4gb() and intel-iommu doesn't
> > > disable it.
> >
> > Oh, right... I did say I found this dance hard to follow. Clearly I
> > shouldn't have trusted what I thought I remembered from looking at it
> > yesterday :)
> >
> > Also not helped by the fact that it sets iommu_detected which *does* disable
> > SWIOTLB, but only on IA-64.
> >
> > > I wonder if we can take the same approach in amd-iommu?
> >
> > Certainly if there's a precedent for leaving SWIOTLB enabled even if it
> > *might* be redundant, that seems like the easiest option (it's what we do on
> > arm64 too, but then we have system topologies where some devices may not be
> > behind IOMMUs even when others are). More fun would be to try to bring it up
> > at the first sign of IOMMU_DOMAIN_IDENTITY if it was disabled previously,
> > but I don't have the highest hope of that being practical.
>
> <scratches his head>
> It is kind of silly to enable SWIOTLB which will just eat 64MB of memory
> "just in case".
>
> The SWIOTLB does have support to do late initialization (xen-pcifront
> does that for example - so if you add devices that can't do 64-bit it
> will allocate something like 4MB).
>
> Would that be a better choice going forward - that is allocate this
> under those conditions?

But how to practically do swiotlb late init on 32-bit capable devices?
On the first DMA map requested by the driver?

Kai-Heng

> >
> > Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
