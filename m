Return-Path: <SRS0=85So=MN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B2AC6377E
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 21:08:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8073261407
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 21:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8073261407
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3DEBC400F3;
	Wed, 21 Jul 2021 21:08:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 41pEPkNIG3DK; Wed, 21 Jul 2021 21:08:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 15C89400E1;
	Wed, 21 Jul 2021 21:08:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEF1CC0010;
	Wed, 21 Jul 2021 21:08:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2AB9C000E
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 21:08:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BA54D81CE1
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 21:08:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LglixCzEBI0z for <iommu@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 21:08:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 109BC81CD0
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 21:08:26 +0000 (UTC)
Received: by mail-yb1-xb2d.google.com with SMTP id x192so5176644ybe.6
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 14:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UBf2xEk8/8fmvgHkUbAP/1+jhiB7YJMg6Fos6jC4Avk=;
 b=iOswR8bDPKPmaXbxSo7LpAdDVia28Nw7iA1NHSB/hQm4djv0jw5Jry1olvb2YDLWDG
 4syxrMbOJa3ePkJiCDFub8LMNdCmo8gKJv261PJAx7n/XrKPZryC6RHomlOR2lORPHBq
 19QfM45Ce3lWlwQ89vaHLLOQ19Y4YMroc3T75jo5J9zIBLM397xBNisHOL9/Tq6pSRCo
 iFuE7M1Fbd3/8UqgzRgvapwRQR/BecMCco7lyG5UFSZxT3QMf9TErTmhP+7Lakl6v3Wj
 5nUkWuAUuA7SVWshHwa3UhWtZbwWsdrICHmfxHqnSVVsdPU2XQ8RmNBe6MvbTe9zqiOY
 HkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UBf2xEk8/8fmvgHkUbAP/1+jhiB7YJMg6Fos6jC4Avk=;
 b=b1hcfEZj4HBj0V7yEdgIdctBgN5toIYy1OIPWInymyRWxkh6Zu1wfBZfolchZsV2pQ
 eho5Zm49b8Y5MchFoDeJWGbTuJdyNXAMHfyd4hHOJeI7fZE3VAB4vQB8wn38NayJ4l3d
 Odsy09v7gHgxvwwmC5h668r5/Cd/9brOupsin1b6rLwhn72KA9hXmNtq4pLph6h2jc8O
 EDz1YinFAEVA/6A6iA38KkD8o8ea7sZFgHPT8MIkUTiiPdB/N70268Ik82H+DWeJsgNK
 441QWke6n3cS47l6HmZ8YlC1dmlFwGGfM4f8Ih0xIpxBfGHjuPy9Amdf3c8ZZWfMr9aC
 JUyw==
X-Gm-Message-State: AOAM532uwHxXdGCvWh74Kixbmbj3Td3Ni9yi9tmxuN4xDoPuvP9I2FMy
 1sy7OIZoxSbqUo1GgTAYA9PXu4iBe5Tf31GZIz2Q4w==
X-Google-Smtp-Source: ABdhPJxvvcIxjS1sPhcRo3uY116bCVXOf5nADsCBhFulbFzDi8z6ZYiOJj9B6s7MAoSBOkXUSsdQXTh0BQ4kxrSemrQ=
X-Received: by 2002:a25:8b91:: with SMTP id j17mr46134726ybl.228.1626901705723; 
 Wed, 21 Jul 2021 14:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210707045320.529186-1-john.stultz@linaro.org>
 <YPgK50dmV7Z69WsL@kroah.com>
 <CALAqxLUVgUT+1DyDGsFbF0138S0OYzpKADk__PsYbR4B4mbMhw@mail.gmail.com>
 <CAGETcx91URbHCYMoGt_cCgvMXNkVyJb4Ek-ng8jwR+eQhvZN1A@mail.gmail.com>
 <YPiCSOys6zEH6Kfg@yoga>
In-Reply-To: <YPiCSOys6zEH6Kfg@yoga>
Date: Wed, 21 Jul 2021 14:07:49 -0700
Message-ID: <CAGETcx8Yw2QDYBYNpqVt_kPHnokFR+qinr5GAJ1byVWMuc3PLQ@mail.gmail.com>
Subject: Re: [PATCH] firmware: QCOM_SCM: Allow qcom_scm driver to be loadable
 as a permenent module
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Maulik Shah <mkshah@codeaurora.org>, Marc Zyngier <maz@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
 John Stultz <john.stultz@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Kalle Valo <kvalo@codeaurora.org>,
 Todd Kjos <tkjos@google.com>
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
From: Saravana Kannan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Jul 21, 2021 at 1:23 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Wed 21 Jul 13:00 CDT 2021, Saravana Kannan wrote:
>
> > On Wed, Jul 21, 2021 at 10:24 AM John Stultz <john.stultz@linaro.org> wrote:
> > >
> > > On Wed, Jul 21, 2021 at 4:54 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Wed, Jul 07, 2021 at 04:53:20AM +0000, John Stultz wrote:
> > > > > Allow the qcom_scm driver to be loadable as a permenent module.
> > > >
> > > > This feels like a regression, it should be allowed to be a module.
> > >
> > > I'm sorry, I'm not sure I'm following you, Greg.  This patch is trying
> > > to enable the driver to be able to be loaded as a module.
> >
> > I think the mix up might be that Greg mentally read "permanent module"
> > as "builtin"?
> >
> > "permanent module" is just something that can't be unloaded once it's
> > loaded. It's not "builtin".
> >
>
> Afaict there's nothing in this patch that makes it more or less
> permanent.

The lack of a module_exit() makes it a permanent module. If you do
lsmod, it'll mark this as "[permanent]".

-Saravana

> The module will be quite permanent (in practice) because
> several other core modules reference symbols in the qcom_scm module.
>
> But thanks to a previous patch, the qcom_scm device comes with
> suppress_bind_attrs, to prevent that the device goes away from a simple
> unbind operation - which the API and client drivers aren't designed to
> handle.
>
> So, it would have been better in this case to omit the word "permanent"
> from the commit message, but the change is good and I don't want to
> rebase my tree to drop that word.
>
> Thanks,
> Bjorn
>
> > -Saravana
> >
> > >
> > > > > This still uses the "depends on QCOM_SCM || !QCOM_SCM" bit to
> > > > > ensure that drivers that call into the qcom_scm driver are
> > > > > also built as modules. While not ideal in some cases its the
> > > > > only safe way I can find to avoid build errors without having
> > > > > those drivers select QCOM_SCM and have to force it on (as
> > > > > QCOM_SCM=n can be valid for those drivers).
> > > > >
> > > > > Reviving this now that Saravana's fw_devlink defaults to on,
> > > > > which should avoid loading troubles seen before.
> > > >
> > > > fw_devlink was supposed to resolve these issues and _allow_ code to be
> > > > built as modules and not forced to be built into the kernel.
> > >
> > > Right. I'm re-submitting this patch to enable a driver to work as a
> > > module, because earlier attempts to submit it ran into boot trouble
> > > because fw_devlink wasn't yet enabled.
> > >
> > > I worry something in my description made it seem otherwise, so let me
> > > know how you read it and I'll try to avoid such confusion in the
> > > future.
> > >
> > > thanks
> > > -john
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
