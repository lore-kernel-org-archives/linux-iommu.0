Return-Path: <SRS0=wTTv=AV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0E2C433E7
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 22:52:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F4C3206E2
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 22:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pEe0x1D2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4C3206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0E88E89C2E;
	Fri, 10 Jul 2020 22:52:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wpcMN944WZ4V; Fri, 10 Jul 2020 22:52:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 777B788C3F;
	Fri, 10 Jul 2020 22:52:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6895CC077B;
	Fri, 10 Jul 2020 22:52:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E31DC016F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 22:52:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1642189455
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 22:52:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bciW+72ippRl for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jul 2020 22:52:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com
 [209.85.219.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 34D5789433
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 22:52:12 +0000 (UTC)
Received: by mail-yb1-f195.google.com with SMTP id f5so1428452ybq.2
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 15:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gCyI0kUrT87FAQAI0Q1u+opAu/z1jGmTcNbCc0ywLlQ=;
 b=pEe0x1D2oXhrROhhsfdBSl2Of0HeeOQzHLu21ytP7olDdMMZPcgjiV0SFxkgRAMS/a
 zblIckErEPPlyKbegdkpsh0OW2Xqu9dnKnUdDl8IU+qez3avQGV8FZM14sbgNWmRlm7w
 Ko1PO1Prn7C0/+tMbFDpECoaIDNxX4OffjwTb6Ox7od3D9ZNzpnW3pgRUR/h8hQQQUnw
 NAWhdtBgvYpwFCMZjLHabISmRiZm6E7qj3wdj04qmnUqNzmD90pKyk3HAmgJ+Eu491o1
 m/JxPxczvMRz7ZVoUvv+TZ8LvVDcYiZGgoZQEAs290rCxG9VW0H0QJwbyUdRTgYdcdoP
 jx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gCyI0kUrT87FAQAI0Q1u+opAu/z1jGmTcNbCc0ywLlQ=;
 b=EnfVOWM9J6lzTSWGlKp2M5cswFdgGZYEew/gMh58k+n1jehYjKQGP2oZafbqr7ykyt
 9FxlBM6W8UiBdDTvzckP62RJWPtltoUG72STK2GkMo8QguVmGbMx4EVtXsoZ8rPxgwQL
 yoU0FdSu+kYyRLm/dPtjOkFBhFbD7t37YbIj6ks2SKOVeAEhqOznZ7OAeF4+vQnEQRYk
 FxULXxChqtQ26UaEAL6gGm2pJqKgQMuC/ykrdfRvjT8t3lAFPyAbWuU+oESqR7ljf0Fc
 9ocxg3cgyqPgD5J0MNknu76UcsixsIICybpu+vngbrQ2ubBmNQ8FPL3++rNuKqcj6apO
 kUdQ==
X-Gm-Message-State: AOAM532ohKFDD3+cfO4MJFO3IyypSZjKSqjBxS1pi8aLWidZ49fKIR8Q
 BLGfuRLB2BKJfHSyyUyJG23RlLWezNCHW9rSxNm//LK2rbw=
X-Google-Smtp-Source: ABdhPJwHQLhjN0fx5nsYDQ/5gAMYf/FtTG+FNllJpIvQ3csH/hy0WBxDIT6X+tOsNnJi0NtINvoXzdjwg4qm1AYXGVE=
X-Received: by 2002:a4a:d08a:: with SMTP id i10mr60007237oor.88.1594421071672; 
 Fri, 10 Jul 2020 15:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200625001039.56174-1-john.stultz@linaro.org>
 <20200625001039.56174-4-john.stultz@linaro.org>
 <159315737502.62212.16093934831673347066@swboyd.mtv.corp.google.com>
 <CALAqxLVNGar8g+FvHaVHN_e-MOZZ+=ZPmDt_GKKSC8AS-wLFGg@mail.gmail.com>
 <87wo3setn8.wl-maz@kernel.org>
 <159436097057.1987609.13993891118929459851@swboyd.mtv.corp.google.com>
In-Reply-To: <159436097057.1987609.13993891118929459851@swboyd.mtv.corp.google.com>
From: John Stultz <john.stultz@linaro.org>
Date: Fri, 10 Jul 2020 15:44:18 -0700
Message-ID: <CALAqxLW14f4Gn6Q3b89X10y7=Zct2NJSgjagUqxez_bObcp42w@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] irqchip: Allow QCOM_PDC to be loadable as a
 permanent module
To: Stephen Boyd <swboyd@chromium.org>
Cc: Maulik Shah <mkshah@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>,
 Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>,
 lkml <linux-kernel@vger.kernel.org>, Lina Iyer <ilina@codeaurora.org>,
 linux-gpio@vger.kernel.org, iommu@lists.linux-foundation.org,
 Andy Gross <agross@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, Todd Kjos <tkjos@google.com>
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

On Thu, Jul 9, 2020 at 11:02 PM Stephen Boyd <swboyd@chromium.org> wrote:
> Quoting Marc Zyngier (2020-06-27 02:37:47)
> > On Sat, 27 Jun 2020 02:34:25 +0100,
> > John Stultz <john.stultz@linaro.org> wrote:
> > >
> > > On Fri, Jun 26, 2020 at 12:42 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > > >
> > > >
> > > > Is there any reason to use IRQCHIP_DECLARE if this can work as a
> > > > platform device driver?
> > > >
> > >
> > > Hey! Thanks so much for the review!
> > >
> > > Mostly it was done this way to minimize the change in the non-module
> > > case. But if you'd rather avoid the #ifdefery I'll respin it without.
> >
> > That would certainly be my own preference. In general, IRQCHIP_DECLARE
> > and platform drivers should be mutually exclusive in the same driver:
> > if you can delay the probing and have it as a proper platform device,
> > then this should be the one true way.
> >
>
> Does it work? I haven't looked in detail but I worry that the child
> irqdomain (i.e. pinctrl-msm) would need to delay probing until this
> parent irqdomain is registered. Or has the hierarchical irqdomain code
> been updated to handle the parent child relationship and wait for things
> to probe or be loaded?

So I can't say I know the underlying hardware particularly well, but
I've been using this successfully on the Dragonboard 845c with both
static builds as well as module enabled builds.
And the same patch has been in the android-mainline and android-5.4
kernels for a while without objections from QCOM.

As to the probe ordering question, Saravana can maybe speak in more
detail if it's involved in this case but the fw_devlink code has
addressed many of these sorts of ordering issues.
However, I'm not sure if I'm lucking into the right probe order, as we
have been able to boot android-mainline w/ both fw_devlink=on and
fw_devlink=off (though in the =off case, we need
deferred_probe_timeout=30 to give us a bit more time for modules to
load after init starts).

thanks
-john
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
