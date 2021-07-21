Return-Path: <SRS0=85So=MN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AA1C12002
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 18:00:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 332476109F
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 18:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 332476109F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4C1582C04;
	Wed, 21 Jul 2021 18:00:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id giekeU8Adern; Wed, 21 Jul 2021 18:00:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DD60682BC5;
	Wed, 21 Jul 2021 18:00:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B38F4C001A;
	Wed, 21 Jul 2021 18:00:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98155C000E
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 18:00:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7088F40362
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 18:00:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id So_cfOAMfbjh for <iommu@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 18:00:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5EBDF40361
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 18:00:53 +0000 (UTC)
Received: by mail-yb1-xb2c.google.com with SMTP id c16so4424618ybl.9
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 11:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p55HWTaC5dpMadxxZA1E7+qzD3OpeEPoXK9rz/EuCCs=;
 b=VKgoCKHjjpFlb8dMXuXUAgOoQYJ3Mbnrm6/8qx4IsUefGakwA3IGEEr0CxwNVsnR0r
 RyfUGx1agkrTHn27tIBpoNtSqHuQIrO4FyGElTusIg9o9RmLBO7FkzuQthByFgbU6N8Y
 JezczchD0E6nSwFpbW8Wfl7RpqflPfgmmeESl0jFVbpcOVfbsj3iiGTbr35EbCaIhQLd
 +qZv+Y0LjBjmprpNCgVby1ICXtdpYSBOqbSSJRJbkaVXma2Aj2qTOobmNUVgfUDa19vr
 7ybpE/C0bS8Dt5I+VXMpwsa+xtbTlG2BZf44XVR2lX0WCvHAENYExpgoiy/ccdAmuV3Q
 wiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p55HWTaC5dpMadxxZA1E7+qzD3OpeEPoXK9rz/EuCCs=;
 b=FxM8A49BbgRQ538yjfOkuEZ9MvsDXY/fQ/302HuS3OTcw+vJpaTD5uRXdrYRc90fG7
 NHwKNxVnVxC1Zs4u2dUxDxceU6tuNqLaiTB6IbGx0Xpy/VLELcNeQ04lubOn8s5Edoz5
 wovfORMchRnnUVs9zMIsG5E2BMQ9wocEAK1+61Z/wVjRv+Uoic+38/cS2XQi5p6YZVak
 x1D7+Lh8aSETfh/9X05+7Wh3ftyl7gODD3iWMR+OFLSO2jMk0XnB7U5seK33Yx6hDojf
 +v+Jhvk2w6VJ7Dn1EFdI/elyOUVo3PjTza0MCX+kQj+Zu8Rkclck4NOQiMYfq1p0vvbN
 SeQw==
X-Gm-Message-State: AOAM531mBi8rUEtTHphf8jFzvEysOo5Sc3M6uZikOQdnxXc4chgEOTP7
 zE08NaUnui7BUtAlFu4NItkL7xzydNHC0/zgVDzoYg==
X-Google-Smtp-Source: ABdhPJwbIrbhhVYNYobPTcneIblXUvvyWcuD63Tzux+fXk8oy4TabvNhfXszej/xrPC8W06ZGSSznRT/A7sB9Z46Za8=
X-Received: by 2002:a25:8b91:: with SMTP id j17mr45175948ybl.228.1626890452055; 
 Wed, 21 Jul 2021 11:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210707045320.529186-1-john.stultz@linaro.org>
 <YPgK50dmV7Z69WsL@kroah.com>
 <CALAqxLUVgUT+1DyDGsFbF0138S0OYzpKADk__PsYbR4B4mbMhw@mail.gmail.com>
In-Reply-To: <CALAqxLUVgUT+1DyDGsFbF0138S0OYzpKADk__PsYbR4B4mbMhw@mail.gmail.com>
Date: Wed, 21 Jul 2021 11:00:15 -0700
Message-ID: <CAGETcx91URbHCYMoGt_cCgvMXNkVyJb4Ek-ng8jwR+eQhvZN1A@mail.gmail.com>
Subject: Re: [PATCH] firmware: QCOM_SCM: Allow qcom_scm driver to be loadable
 as a permenent module
To: John Stultz <john.stultz@linaro.org>
Cc: Maulik Shah <mkshah@codeaurora.org>, Marc Zyngier <maz@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
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

On Wed, Jul 21, 2021 at 10:24 AM John Stultz <john.stultz@linaro.org> wrote:
>
> On Wed, Jul 21, 2021 at 4:54 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jul 07, 2021 at 04:53:20AM +0000, John Stultz wrote:
> > > Allow the qcom_scm driver to be loadable as a permenent module.
> >
> > This feels like a regression, it should be allowed to be a module.
>
> I'm sorry, I'm not sure I'm following you, Greg.  This patch is trying
> to enable the driver to be able to be loaded as a module.

I think the mix up might be that Greg mentally read "permanent module"
as "builtin"?

"permanent module" is just something that can't be unloaded once it's
loaded. It's not "builtin".

-Saravana

>
> > > This still uses the "depends on QCOM_SCM || !QCOM_SCM" bit to
> > > ensure that drivers that call into the qcom_scm driver are
> > > also built as modules. While not ideal in some cases its the
> > > only safe way I can find to avoid build errors without having
> > > those drivers select QCOM_SCM and have to force it on (as
> > > QCOM_SCM=n can be valid for those drivers).
> > >
> > > Reviving this now that Saravana's fw_devlink defaults to on,
> > > which should avoid loading troubles seen before.
> >
> > fw_devlink was supposed to resolve these issues and _allow_ code to be
> > built as modules and not forced to be built into the kernel.
>
> Right. I'm re-submitting this patch to enable a driver to work as a
> module, because earlier attempts to submit it ran into boot trouble
> because fw_devlink wasn't yet enabled.
>
> I worry something in my description made it seem otherwise, so let me
> know how you read it and I'll try to avoid such confusion in the
> future.
>
> thanks
> -john
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
