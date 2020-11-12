Return-Path: <SRS0=2i4G=ES=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF3AC2D0E4
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 19:24:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EFBD20B80
	for <iommu@archiver.kernel.org>; Thu, 12 Nov 2020 19:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yz0ymP9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EFBD20B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 115DC813F6;
	Thu, 12 Nov 2020 19:24:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0l0Ku2sGY78f; Thu, 12 Nov 2020 19:24:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BFB6680787;
	Thu, 12 Nov 2020 19:24:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B028BC088B;
	Thu, 12 Nov 2020 19:24:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CE1EC016F
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 19:24:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 02CD0834D6
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 19:24:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wtObkfQn8qoY for <iommu@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 19:24:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ua1-f68.google.com (mail-ua1-f68.google.com
 [209.85.222.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8BA47834BE
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 19:24:24 +0000 (UTC)
Received: by mail-ua1-f68.google.com with SMTP id q4so2226497ual.8
 for <iommu@lists.linux-foundation.org>; Thu, 12 Nov 2020 11:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DbWNwoS/yA7kFAHQEVZG/j97G/b6ri6eA2QM6vIo46Q=;
 b=yz0ymP9pfxOL7R9kW/KCBuusxjIPnYw6bv7tfZWUECDoktuk0IiAxrkqivHwV+rriT
 dTrOTJ2Dd6NHXgMpnvcfW0SO1AZ7TZdGZVXsexIER4OF5YimMmgixv3vFk07fd9dWfNC
 F06SeSfSE4ZZSsJbbnXx7d90EtlAgpIH0AKMSpfLCsBYbcLq0usM0MQCSkTs7I2afZJJ
 Hw7mh681pob5cxX7yJ+tRTDJ9CmGSOl9BrFJGuu+K4EUYI44exl4WSAm8kosyC5kqKZ4
 6INGhj66NSL3gimg9zwKMliZg6fWGsgt0hDEL77kaWnS/ohjlHwKV4d92WMEQmHNsdj/
 kZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DbWNwoS/yA7kFAHQEVZG/j97G/b6ri6eA2QM6vIo46Q=;
 b=S48527Y0lmEjo4XCfiyYe3FGhUw5Dh7eCw4z+Ir8F8Gkeqcj9NHL0Ngm83jRkiGDxe
 g4s3hxM1s+XhXc6bkiplqJ7muHudU5PrzD1CkKAzFC3q/MjWvRdIxi/WXE6UAJlGsBBR
 NWubZ0ikgjHHn4cSNO3IuuarwYoTC7IcNrTVMvU/7T5I1lLu4zt9WfH2lu8ILBG6XZHA
 zpKXFV8DUNvIe9NBka/L33fci8lqizo3SQwl9s0L0yo1r71VSfaZ2mxHxkS5kK9eh9qD
 SFR02S0jrEZrW3P4ZgETNfIEWi9AVePQYp1c5DWO1KkLy7jkQ+IaC3bmDT+LLdOjloSb
 WbrQ==
X-Gm-Message-State: AOAM530DYGNi6dqWjm/iwS2SUQ7LB3zFgp/M2c3IXZOjgtLnQZUY1EMO
 7SUqLcFJznMWLfxQ3DznxlgXyQIggu7yzLtW0AlmxXv2/nY=
X-Google-Smtp-Source: ABdhPJzgTS+q8i38W1HnqJ1uOTJLpUkruB06T/Rv8JZYX8xhAUjWunWguACyKENcXkwSa8gHdkehxZAoBIlJVyrwgIU=
X-Received: by 2002:a4a:c218:: with SMTP id z24mr625496oop.9.1605208657781;
 Thu, 12 Nov 2020 11:17:37 -0800 (PST)
MIME-Version: 1.0
References: <20201106042710.55979-1-john.stultz@linaro.org>
 <20201106042710.55979-3-john.stultz@linaro.org>
 <CACRpkdYhfjRBz8GwMyCrOTzjd-Y6-G16xPjH6xhwSHcnaJfuXA@mail.gmail.com>
 <CALAqxLXigwvauJgvN5FxoND60zybYw1L78POHY6KoxP2_gpkFA@mail.gmail.com>
 <20201112173721.GB20000@willie-the-truck>
In-Reply-To: <20201112173721.GB20000@willie-the-truck>
From: John Stultz <john.stultz@linaro.org>
Date: Thu, 12 Nov 2020 11:17:27 -0800
Message-ID: <CALAqxLWQ2SfbFZs+S=CcJJwrX7iok5vvGo-c=2htWQWTc486wg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] firmware: QCOM_SCM: Allow qcom_scm driver to be
 loadable as a permenent module
To: Will Deacon <will@kernel.org>
Cc: Maulik Shah <mkshah@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, lkml <linux-kernel@vger.kernel.org>,
 Lina Iyer <ilina@codeaurora.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>, MSM <linux-arm-msm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Kalle Valo <kvalo@codeaurora.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Nov 12, 2020 at 9:37 AM Will Deacon <will@kernel.org> wrote:
> On Tue, Nov 10, 2020 at 10:51:46AM -0800, John Stultz wrote:
> > On Tue, Nov 10, 2020 at 5:35 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > > On Fri, Nov 6, 2020 at 5:27 AM John Stultz <john.stultz@linaro.org> wrote:
> > >
> > > > Allow the qcom_scm driver to be loadable as a permenent module.
> > > >
> > ...
> > > I applied this patch to the pinctrl tree as well, I suppose
> > > that was the intention. If someone gets upset I can always
> > > pull it out.
> >
> > Will: You ok with this?
>
> We didn't come up with something better, so I can live with it.

Ok, thanks!

> Not sure
> about the otehr issues that were reported by Robin though -- your RFC for
> fixing those looked a bit more controversial ;)

Huh, I hadn't heard anything back on that series and was going to
resend it. Do let me know if you have more thoughts on that one.

thanks
-john
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
