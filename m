Return-Path: <SRS0=IFPa=LQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FB3C2B9F4
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 17:01:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE9796128C
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 17:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9796128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A79796085E;
	Tue, 22 Jun 2021 17:01:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zswMFGqRrJ49; Tue, 22 Jun 2021 17:01:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 355B56085A;
	Tue, 22 Jun 2021 17:01:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17DC0C001A;
	Tue, 22 Jun 2021 17:01:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46D9BC000E
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 17:01:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2879360872
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 17:01:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9JQFBz4dwgqA for <iommu@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 17:01:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 700D56085A
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 17:01:20 +0000 (UTC)
Received: by mail-qv1-xf2c.google.com with SMTP id m15so3672032qvc.9
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 10:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ln0rqCYelsyqtkFalmwSESWUlyrC6dhevN9AgMvP0es=;
 b=ZLQfwSSaECfOSlROL5O1FHfITEWnKqUE8cvB9T5PPjirTAOMnWmZdjsUCwl1g4kPPr
 XUPv7VEcFM2DmgpmjLKv4cmbNnZ/u/O0jZo4fu3vmcnnzDdkB8qyMAD8QUQsW3EriGRk
 ZuK+8EDXiwWgHqRMyWcUdrrzbS0u3BRBjDKaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ln0rqCYelsyqtkFalmwSESWUlyrC6dhevN9AgMvP0es=;
 b=WxSzYTm5Vnq3G1AimnFcfZu4FSDqRc9nl+h44cG8gP1fHnVZvq2P2FTWuQp79UKbRy
 Uq+GahmFOsK2gVKwBOl07sMGQCP9h65p6ItRj/oEdRxmP/qW+KQVICfAYpc9k4u2Qm09
 c2DnQBuKoVkqX9/RipNBnFoPOzuyyJ4JEMiqiz2K23HK8ZE7X1dm2afCmG0/0u1QVeB5
 LeEQ45jkFeyxjM2rIoQECjL5J/H5SgwVJu48I+OpyJ/E5qtyuwKKEaaYlz4MsT1zxcJE
 KmhMQAFYIi29t+MhjZ+/fuF5sQslVExt/etOOwUM4g3YJKubTdfgwTSVVqZBEn9ch2of
 qDaQ==
X-Gm-Message-State: AOAM532QtTQzbmtb7LK2Iu4fjH0vdr0suKPN0CeTym1j4vFMCTzVT/6N
 iLk8xWj/UApfJhHDH/AWRm7mGcOYdkiLVA==
X-Google-Smtp-Source: ABdhPJw9zxX5P3x3ZaKvJeLo0wGqAmR0C19mLdQrZ9no6zKFLrU3PSdi4ogLOFls/ZAc5WJXkERRzQ==
X-Received: by 2002:ad4:5def:: with SMTP id jn15mr26228642qvb.22.1624381279077; 
 Tue, 22 Jun 2021 10:01:19 -0700 (PDT)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com.
 [209.85.222.172])
 by smtp.gmail.com with ESMTPSA id x7sm13510774qke.62.2021.06.22.10.01.18
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jun 2021 10:01:18 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id q190so38631270qkd.2
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 10:01:18 -0700 (PDT)
X-Received: by 2002:a25:2405:: with SMTP id k5mr5864261ybk.405.1624380851918; 
 Tue, 22 Jun 2021 09:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.4.Id84a954e705fcad3fdb35beb2bc372e4bf2108c7@changeid>
 <a86c2f9c-f66a-3a12-cf80-6e3fc6dafda4@linux.intel.com>
In-Reply-To: <a86c2f9c-f66a-3a12-cf80-6e3fc6dafda4@linux.intel.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 22 Jun 2021 09:53:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XpYkUqGNcumJ0NvoXqbSkBaV5ZadUnpsKTMPx7tSjGig@mail.gmail.com>
Message-ID: <CAD=FV=XpYkUqGNcumJ0NvoXqbSkBaV5ZadUnpsKTMPx7tSjGig@mail.gmail.com>
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

On Mon, Jun 21, 2021 at 7:05 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> On 6/22/21 7:52 AM, Douglas Anderson wrote:
> > @@ -1519,7 +1542,8 @@ static int iommu_get_def_domain_type(struct device *dev)
> >
> >   static int iommu_group_alloc_default_domain(struct bus_type *bus,
> >                                           struct iommu_group *group,
> > -                                         unsigned int type)
> > +                                         unsigned int type,
> > +                                         struct device *dev)
> >   {
> >       struct iommu_domain *dom;
> >
> > @@ -1534,6 +1558,12 @@ static int iommu_group_alloc_default_domain(struct bus_type *bus,
> >       if (!dom)
> >               return -ENOMEM;
> >
> > +     /* Save the strictness requests from the device */
> > +     if (dev && type == IOMMU_DOMAIN_DMA) {
> > +             dom->request_non_strict = dev->request_non_strict_iommu;
> > +             dom->force_strict = dev->force_strict_iommu;
> > +     }
> > +
>
> An iommu default domain might be used by multiple devices which might
> have different "strict" attributions. Then who could override who?

My gut instinct would be that if multiple devices were part of a given
domain that it would be combined like this:

1. Any device that requests strict makes the domain strict force strict.

2. To request non-strict all of the devices in the domain would have
to request non-strict.

To do that I'd have to change my patchset obviously, but I don't think
it should be hard. We can just keep a count of devices and a count of
the strict vs. non-strict requests? If there are no other blockers
I'll try to do that in my v2.

-Doug
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
