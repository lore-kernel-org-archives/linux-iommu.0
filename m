Return-Path: <SRS0=kzsj=LS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DDBC49EA6
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 14:08:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A5F56140A
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 14:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5F56140A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25ED8605E1;
	Thu, 24 Jun 2021 14:08:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zz9VABGpdl10; Thu, 24 Jun 2021 14:08:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E09796059E;
	Thu, 24 Jun 2021 14:08:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E947C001A;
	Thu, 24 Jun 2021 14:08:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A177CC000E
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 14:08:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 890B340176
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 14:08:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vw-bKk6VqiiF for <iommu@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 14:08:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CB611405FD
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 14:08:18 +0000 (UTC)
Received: by mail-vs1-xe2f.google.com with SMTP id g28so889679vsr.13
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 07:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qA/15TvxyljLeiT6v+8qmN6kWt8A8lTygEXqoXNw+04=;
 b=Rw6WpSNMHTbg23NxwJvuOjaHdtgv0Fj8nxCsBmOYLlr9CLdBH8VOno97w1rjhpK7QS
 fwqIqx9HX6X8tYR/DUbVTec6h1/VI2RngzjSavToO71KaG1mXaNuJKT6sdAS0G2d8VEg
 i8Ybg3BEoJp0gfRJeGyl62WDRO2HONssyTuck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qA/15TvxyljLeiT6v+8qmN6kWt8A8lTygEXqoXNw+04=;
 b=l8Kx8tfz7Idz6/dE7VEVL6E8Xi/s7guoFbjWskNL99+V4GCVCht2mGOQul+l9LXs2W
 uhf6tlEgqklM9aa3yECzP3ViQJWQWdqgC4oWQs/zAk+2x+7VlyFAyHGtUlB/ZqVesFZg
 doLEfXjdJU8QReiuZJIuGL7K5hObAfp1BpT5YinozcXgWhZH30jXR/v5dukqLb3YOAhT
 eQJANnhw46LyNI9rEANl53v7Dd1BSOlMXZPBXRzMiokSXIRX+NgIRTI2iylPoFOBzGxY
 5d9FKSbALHUG22ZUURZWNgT+Nh12aDuWhnmc4iu5q0oKbKv1yRqOxXBFyxRNza4WEJMP
 1cag==
X-Gm-Message-State: AOAM533BWjXq9taMtfZTiHGLd8JU13en6BmxdGCiCVaGuQTsE2enGxym
 Vwa0MO3J3X/7O7XAqTXIFaLJukSrxDjAig==
X-Google-Smtp-Source: ABdhPJyMHA8zKCHEVFZzfBcwtgTrGpi16Bd+37CKs6ou1sA9ZmvYGaOZnYX8ayfF/CWAIjg9BqC6KA==
X-Received: by 2002:a05:6102:3097:: with SMTP id
 l23mr3100068vsb.19.1624543697504; 
 Thu, 24 Jun 2021 07:08:17 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com.
 [209.85.222.48])
 by smtp.gmail.com with ESMTPSA id j11sm595966vkd.18.2021.06.24.07.08.17
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jun 2021 07:08:17 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id e7so2229325uaj.11
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 07:08:17 -0700 (PDT)
X-Received: by 2002:a25:bcb:: with SMTP id 194mr5441792ybl.32.1624543265649;
 Thu, 24 Jun 2021 07:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.6.Icde6be7601a5939960caf802056c88cd5132eb4e@changeid>
 <YNSL/r+fOz6KMuwI@kroah.com>
In-Reply-To: <YNSL/r+fOz6KMuwI@kroah.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 24 Jun 2021 07:00:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VsdYpgzoC9JvDEjBDqVNKmuz-gOs8oceiuYXs8E680XA@mail.gmail.com>
Message-ID: <CAD=FV=VsdYpgzoC9JvDEjBDqVNKmuz-gOs8oceiuYXs8E680XA@mail.gmail.com>
Subject: Re: [PATCH 6/6] mmc: sdhci-msm: Request non-strict IOMMU mode
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, Rajat Jain <rajatja@google.com>,
 Will Deacon <will@kernel.org>, Rob Clark <robdclark@chromium.org>,
 Saravana Kannan <saravanak@google.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, quic_c_gdjako@quicinc.com,
 Andy Gross <agross@kernel.org>,
 Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Sonny Rao <sonnyrao@chromium.org>,
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

On Thu, Jun 24, 2021 at 6:43 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 21, 2021 at 04:52:48PM -0700, Douglas Anderson wrote:
> > IOMMUs can be run in "strict" mode or in "non-strict" mode. The
> > quick-summary difference between the two is that in "strict" mode we
> > wait until everything is flushed out when we unmap DMA memory. In
> > "non-strict" we don't.
> >
> > Using the IOMMU in "strict" mode is more secure/safer but slower
> > because we have to sit and wait for flushes while we're unmapping. To
> > explain a bit why "non-strict" mode is unsafe, let's imagine two
> > examples.
> >
> > An example of "non-strict" being insecure when reading from a device:
> > a) Linux driver maps memory for DMA.
> > b) Linux driver starts DMA on the device.
> > c) Device write to RAM subject to bounds checking done by IOMMU.
> > d) Device finishes writing to RAM and signals transfer is finished.
> > e) Linux driver starts unmapping DMA memory but doesn't flush.
>
> Why doesn't it "flush"?

This is just how the pre-existing "iommu.strict=0" command line parameter works.


> > f) Linux driver validates that the data in memory looks sane and that
> >    accessing it won't cause the driver to, for instance, overflow a
> >    buffer.
> > g) Device takes advantage of knowledge of how the Linux driver works
> >    and sneaks in a modification to the data after the validation but
> >    before the IOMMU unmap flush finishes.
> > h) Device has now caused the Linux driver to access memory it
> >    shouldn't.
>
> So you are now saying we need to not trust hardware?  If so, that's a
> massive switch for how the kernel needs to work right?

This is a pre-existing concept in the kernel and is in fact so
prevalent that there are a bunch of inconsistent ways to configure it
(though it's being made better [1])

* On ARM64, default is strict and you can configure it with iommu.strict

* On AMD, default is non-strict and you can configure it with
amd_iommu=fullflush

* On Intel, default is non-strict and you can configure it with
intel_iommu=strict

...also pre-existing is that the kernel has special cases for
"external" PCI devices where it forces them to strict mode even if the
default is non-strict (like on Intel and AMD). I was pointed
specifically at <http://thunderclap.io/> for an example of why this
was important.


> And what driver does f) and allows g) to happen?  That would be a normal
> bug anyway, why not just fix the driver?

This one would be possible to workaround in the driver by copying the
memory somewhere else, but it violates the DMA model. Specifically
step "e)" above is supposed to mean that the driver is now in full
control of the memory, so it should be perfectly justified in assuming
that nobody else is scribbling on it.


> > An example of "non-strict" being insecure when writing to a device:
> > a) Linux driver writes data intended for the device to RAM.
> > b) Linux driver maps memory for DMA.
> > c) Linux driver starts DMA on the device.
> > d) Device reads from RAM subject to bounds checking done by IOMMU.
> > e) Device finishes reading from RAM and signals transfer is finished.
> > f) Linux driver starts unmapping DMA memory but doesn't flush.
>
> Why does it not flush?
>
> What do you mean by "flush"

"flush" means force / wait for the IOMMU unmap to fully take effect.


> > g) Linux driver frees memory and returns it to the pool.
>
> What pool?

The normal Linux memory pool.


> > h) Memory is allocated for another purpose.
>
> Allocated by what?

Someone else that wanted memory.


> We have memory allocators that write over the data when freed, why not
> just use this if you are concerned about this type of issue?
>
> > i) Device takes advantage of the period of time before IOMMU flush to
> >    read memory that it shouldn't have had access to.
>
> What memory would that be?

Depends on who got it. This could be hard to predict unless a
peripheral was trying to exploit a very specific version of Linux
where maybe it was predictable who got the memory next.


> And if you really care about these issues, are you not able to take the
> "hit" for the flush all the time as that is a hardware thing, not a
> software thing.  Why not just always take advantage of that, no driver
> changes needed?

The whole concept of strict vs. non-strict is definitely not new to my
series and I'm mostly just trying to configure it properly.


> And this isn't going to work, again, because the "pre_probe" isn't going
> to be acceptable, sorry.

Right. As discussed in the cover letter, I'm going to try to solve
this in other ways that doesn't involve pre_probe.

[1] https://lore.kernel.org/linux-iommu/1624016058-189713-1-git-send-email-john.garry@huawei.com/T/#m21bc07b9353b3ba85f2a40557645c2bcc13cbb3e

-Doug
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
