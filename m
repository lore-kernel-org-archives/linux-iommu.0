Return-Path: <SRS0=QBaT=OR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D26C433FE
	for <iommu@archiver.kernel.org>; Mon, 27 Sep 2021 20:48:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E44E86103B
	for <iommu@archiver.kernel.org>; Mon, 27 Sep 2021 20:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E44E86103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4C91404B8;
	Mon, 27 Sep 2021 20:48:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BGuxqyir2eU7; Mon, 27 Sep 2021 20:48:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9DC1F404B9;
	Mon, 27 Sep 2021 20:48:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 570CCC001C;
	Mon, 27 Sep 2021 20:48:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C08FC000F
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 20:48:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1389640536
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 20:48:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rjzX-RkBehEg for <iommu@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 20:48:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8DCB2404D6
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 20:48:05 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20B4761074
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 20:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632775685;
 bh=GHCCCNNGDh7j8AzsSAwR+7WjFwTTkZQkWzBp4yf5Anw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=EtTYXuV99xHvDuCezChTC1fYR0ncVq3Rk1GokwMu8SQwpY+EmUiFM+RJIajTO8jW3
 VrmnSOnx8ztK/horbiFLR4Q1ZWDBNyvy7tKy9OeuG4ddMCv7tR6NZWpZqi+5myOFRZ
 fUlC6Cg5AZEODAOrfOLYA3DADysDTM/85vB/lrkAnFddU4ZJYrY9Qs93uwL2IgXWp2
 ShOzsV013bF2pbhJUOsUOYV7NBfbitxpmzxjeFzmgMdmeTIB3GqmWBkk202+UoozT6
 QbwxnW2Yp/G+PD6grSc1VyWUP3kS05HQi/kIejRv/Gb69g5//VZRJWFOBSMsttdGMH
 imsrWEit+NvGQ==
Received: by mail-wr1-f48.google.com with SMTP id x20so9466312wrg.10
 for <iommu@lists.linux-foundation.org>; Mon, 27 Sep 2021 13:48:05 -0700 (PDT)
X-Gm-Message-State: AOAM5316lrK1DTCYc+HLXVwh/2qXQPaGfFJjttqRgxfTtO/vdspCxqPa
 mct4+Ozletf00bFJagU1p5NIl6E1mJPVPZN9HXU=
X-Google-Smtp-Source: ABdhPJyr//9nG+qcYuFmIIHo02EBLzzoRAIp7o7Kc5vnLIs/c/42qbXfOQSeIjG8WR8ZxK+L1GxrgnNIqE5zvhpeDJ8=
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr2207127wru.336.1632775683762; 
 Mon, 27 Sep 2021 13:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210927152412.2900928-1-arnd@kernel.org>
 <YVIg9CxJGaJr1vpp@ripper>
 <CAK8P3a1fEuFsQVY9b1oGdTOHzr8pu9wvrSBCMn2iOvgWqtHNnA@mail.gmail.com>
 <YVIsrgKiOG/gFVdT@ripper>
In-Reply-To: <YVIsrgKiOG/gFVdT@ripper>
From: Arnd Bergmann <arnd@kernel.org>
Date: Mon, 27 Sep 2021 22:47:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1WRBA4mP691fO82ZhYdPhHLGjLH=VhcUxGNeGRMX8knw@mail.gmail.com>
Message-ID: <CAK8P3a1WRBA4mP691fO82ZhYdPhHLGjLH=VhcUxGNeGRMX8knw@mail.gmail.com>
Subject: Re: [PATCH] [RFC] qcom_scm: hide Kconfig symbol
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 David Airlie <airlied@linux.ie>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, ath10k@lists.infradead.org,
 Will Deacon <will@kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Andy Gross <agross@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jakub Kicinski <kuba@kernel.org>, linux-sunxi@lists.linux.dev,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 John Stultz <john.stultz@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Sean Paul <sean@poorly.run>,
 Kalle Valo <kvalo@codeaurora.org>, Alex Elder <elder@kernel.org>,
 Networking <netdev@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, Sudeep Holla <sudeep.holla@arm.com>,
 freedreno <freedreno@lists.freedesktop.org>,
 "David S. Miller" <davem@davemloft.net>
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

On Mon, Sep 27, 2021 at 10:42 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Mon 27 Sep 13:15 PDT 2021, Arnd Bergmann wrote:
> > On Mon, Sep 27, 2021 at 9:52 PM Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> >
> > An easier option might be to find a way to build QCOM_SCM without
> > RESET_CONTROLLER for compile testing purposes. I don't know
> > what would break from that.
> >
>
> Afaict the reset API is properly stubbed and RESET_CONTROLLER is a bool,
> so I think we can simply drop the "select" and the kernel will still
> compile fine in all combinations.
>
> When it comes to runtime, we currently select RESET_CONTROLLER from the
> Qualcomm common clocks. If that is dropped (why would it...) it seems
> possible to build a custom kernel for msm8916 that we can boot and miss
> the stubbed out "mss restart" reset line from the SCM.
>
>
> So, let's just drop the select RESET_CONTROLLER from SCM for now.

Ok, I've made that change locally, giving it more time on the randconfig
build box now.

       Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
