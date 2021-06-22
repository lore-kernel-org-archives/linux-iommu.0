Return-Path: <SRS0=IFPa=LQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B0CC2B9F4
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 17:08:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C1F961360
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 17:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1F961360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6062183B10;
	Tue, 22 Jun 2021 17:08:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ymo5gGghDHOw; Tue, 22 Jun 2021 17:08:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5D17E83B0F;
	Tue, 22 Jun 2021 17:08:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F7B1C001A;
	Tue, 22 Jun 2021 17:08:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1DA9C000E
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 17:08:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CB45F404F3
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 17:08:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fjVdOKpD5KDj for <iommu@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 17:08:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 75F82402EB
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 17:08:27 +0000 (UTC)
Received: by mail-qt1-x833.google.com with SMTP id w26so11260692qto.13
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 10:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8ZLfOF3k/f6yL2AQLJ+h2J00Oz5HjAD+vwU2S+DCH90=;
 b=gd1QJ+p0JA8dyVAsY4WKjdqQGTpnW4p+P5TOHPu1jd4FeLJ/H6Qvzbn6gyTv7wJVI6
 36wOQR0QS6Ab0J7LxCWnPEzDaKyFhbkR0dyQHikgrWT9HmTn5M8DAb0Bs2e0HWcalTrm
 dzu+DKJGfjkl52u/OhJeVIwWeXfqiKtJLOnOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8ZLfOF3k/f6yL2AQLJ+h2J00Oz5HjAD+vwU2S+DCH90=;
 b=keLnY8lz9EcSVWaYs72THkHgz1bamGtpfu32mV98rTXL6uGOOfJdIlxGKgJKRoTGnQ
 WcKFPwA8hIlTO6KDGjmQRfl0LIm5pqSMyHbVmNBi1mV94Bv55T/IZ0wxlwYTclhbnK4j
 iZwWLn7japorZlXpjTUbcv8M609wNvHweNSC3XTGlcQf9SbitzUWVKu7U2QbMZxWFH5L
 VsNp1+ARw8HMR/MZr88i+rUSvhgbXoouyqpX81aHOAL0lL/goHD0nnAG4vKeDLr0rMoG
 uep1ePVJeD5YSc7xGRyWl0H+atmp/S16aXlXQp/Rfo3BfE0TGit+0CN1anwl3lc45ZI6
 L1GA==
X-Gm-Message-State: AOAM533nSQtVJy2fif/Nfsxc47TsC4CJ5aqa8nhIWWI+pAHCGIDNihOy
 iEDpAIU+YKz7wX707djXQmuUNkMcfw2Arw==
X-Google-Smtp-Source: ABdhPJwLl2LiBgftI5viRT66PouZOXet+75vLYzqQRb8eZJmb+h5Kac3fPd2YwGuXnQqFsfV7T1Gew==
X-Received: by 2002:ac8:5813:: with SMTP id g19mr4377043qtg.383.1624381706204; 
 Tue, 22 Jun 2021 10:08:26 -0700 (PDT)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com.
 [209.85.222.181])
 by smtp.gmail.com with ESMTPSA id e1sm2185132qti.27.2021.06.22.10.08.25
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jun 2021 10:08:26 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id bj15so39542003qkb.11
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 10:08:25 -0700 (PDT)
X-Received: by 2002:a25:6088:: with SMTP id u130mr6308972ybb.257.1624381323248; 
 Tue, 22 Jun 2021 10:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.4.Id84a954e705fcad3fdb35beb2bc372e4bf2108c7@changeid>
 <a86c2f9c-f66a-3a12-cf80-6e3fc6dafda4@linux.intel.com>
 <CAD=FV=XpYkUqGNcumJ0NvoXqbSkBaV5ZadUnpsKTMPx7tSjGig@mail.gmail.com>
In-Reply-To: <CAD=FV=XpYkUqGNcumJ0NvoXqbSkBaV5ZadUnpsKTMPx7tSjGig@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 22 Jun 2021 10:01:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xi8Qai5sKwuT4-4B=K5i7f4BWQfp9+TxR1x3VSt7dkGA@mail.gmail.com>
Message-ID: <CAD=FV=Xi8Qai5sKwuT4-4B=K5i7f4BWQfp9+TxR1x3VSt7dkGA@mail.gmail.com>
Subject: Re: [PATCH 4/6] iommu: Combine device strictness requests with the
 global default
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, Rajat Jain <rajatja@google.com>,
 Will Deacon <will@kernel.org>, Rob Clark <robdclark@chromium.org>,
 Saravana Kannan <saravanak@google.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, quic_c_gdjako@quicinc.com,
 Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Sonny Rao <sonnyrao@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux MMC List <linux-mmc@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>
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

Hi,

On Tue, Jun 22, 2021 at 9:53 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Jun 21, 2021 at 7:05 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
> >
> > On 6/22/21 7:52 AM, Douglas Anderson wrote:
> > > @@ -1519,7 +1542,8 @@ static int iommu_get_def_domain_type(struct device *dev)
> > >
> > >   static int iommu_group_alloc_default_domain(struct bus_type *bus,
> > >                                           struct iommu_group *group,
> > > -                                         unsigned int type)
> > > +                                         unsigned int type,
> > > +                                         struct device *dev)
> > >   {
> > >       struct iommu_domain *dom;
> > >
> > > @@ -1534,6 +1558,12 @@ static int iommu_group_alloc_default_domain(struct bus_type *bus,
> > >       if (!dom)
> > >               return -ENOMEM;
> > >
> > > +     /* Save the strictness requests from the device */
> > > +     if (dev && type == IOMMU_DOMAIN_DMA) {
> > > +             dom->request_non_strict = dev->request_non_strict_iommu;
> > > +             dom->force_strict = dev->force_strict_iommu;
> > > +     }
> > > +
> >
> > An iommu default domain might be used by multiple devices which might
> > have different "strict" attributions. Then who could override who?
>
> My gut instinct would be that if multiple devices were part of a given
> domain that it would be combined like this:
>
> 1. Any device that requests strict makes the domain strict force strict.
>
> 2. To request non-strict all of the devices in the domain would have
> to request non-strict.
>
> To do that I'd have to change my patchset obviously, but I don't think
> it should be hard. We can just keep a count of devices and a count of
> the strict vs. non-strict requests? If there are no other blockers
> I'll try to do that in my v2.

One issue, I guess, is that we might need to transition a non-strict
domain to become strict. Is that possible? We'd end up with an extra
"flush queue" that we didn't need to allocate, but are there other
problems?

Actually, in general would it be possible to transition between strict
and non-strict at runtime as long as we called
init_iova_flush_queue()? Maybe that's a better solution than all
this--we just boot in strict mode and can just transition to
non-strict mode after-the-fact?


-Doug
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
