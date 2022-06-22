Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9B3C43334
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 10:52:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EEF9761296;
	Wed, 22 Jun 2022 10:52:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EEF9761296
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=fAYTDojm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3CpK5yLDeMTy; Wed, 22 Jun 2022 10:52:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B215B61060;
	Wed, 22 Jun 2022 10:52:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B215B61060
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70E1CC0039;
	Wed, 22 Jun 2022 10:52:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95D06C002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 10:52:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 60EFE41CB0
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 10:52:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 60EFE41CB0
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=fAYTDojm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8x5cyE3b1x-M for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 10:52:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BDF6641CA5
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BDF6641CA5
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 10:52:40 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id pk21so10229781ejb.2
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 03:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oaXOVl5GbpzrwUwV/ImpOqO7sc14IuZ0zxyCyofIONY=;
 b=fAYTDojmK1smvHwGNsWw7YZE+c033Tr1yoX1+0von2aMoUv1c6u/lXSW342IrQcP4M
 xPN+GRDfDYCxmUIv6sDSqnaI8Em+Oh+JKrva7+3g/EzeKV1Ki583f+s9svwO4PTOK3VO
 FNBVAE15VZ93Za7cLKMBU9l53ej2lPfk32eNT2dPoL31kpXd5JF9QExrHJGiNWskQaoi
 GwbpG7yGkbThNaRXEKOmk3fTJtRnVtpyyhPasWlhFmRt+RC4liDaJM5tK4YKEVkPB0lZ
 cAhCT1RJZQYl9ir4lgrKLNKqAQifLqf1rW/MelSqXTepRExaSRDBPQAnc0kZG468DnbP
 an5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oaXOVl5GbpzrwUwV/ImpOqO7sc14IuZ0zxyCyofIONY=;
 b=6KTjyEEnpJlBq3oSDyhiS1S4jJceUs6bpCHVZlEXcx1LAW0CLH4o/tqnmINH6hTROD
 MR7ELpUcIz8nLIsn1A321YhvdxaoFyQJQRQDcvkp4MnBnuoHmaO7cvxd2MNihG/GsLpb
 66DStBnr7D0PtlTQGHU+Cd4mW/ILLUS4qY+uXKdFX9895XkM/aPqeH0cX/M7K8HzUhW9
 Pzm1lVPqTSrFJKtqgrd5O3DZoSMB+3JRe0ozImOPuS4hO9jbGnrdwSTzHtq5wK0mp9NW
 ffwlmW6KWCmbJ0oIlwSAGClGBIKu0d+Z1RjEoa2f0aoNFR14Do5IITONX7bH8qSpEP0p
 anTQ==
X-Gm-Message-State: AJIora/uAG/vZ8uEMRCvyXCbmv4l/BsI60UeQoDpKtsfU4/28ZZ9uAby
 mOGMemjwa2IKH7tPXQa1xIrLEdZQrppDJVEb2Wg=
X-Google-Smtp-Source: AGRyM1uyQ/Y01CLF3k0VqbSatCLy5utHlTkfRj9OEacTCqDgiOfz+58yhgtrbg6k3a0mp5dlHgOdAW0EC2clcTJB1Rg=
X-Received: by 2002:a17:906:149:b0:711:fca6:bc2f with SMTP id
 9-20020a170906014900b00711fca6bc2fmr2554745ejh.497.1655895158817; Wed, 22 Jun
 2022 03:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
 <20220601070707.3946847-8-saravanak@google.com>
 <20220622074756.GA1647@pengutronix.de>
 <CACRpkdYe=u9Ozj_dtLVr6GSau8yS5H7LnBNNrQHki1CJ1zST0A@mail.gmail.com>
In-Reply-To: <CACRpkdYe=u9Ozj_dtLVr6GSau8yS5H7LnBNNrQHki1CJ1zST0A@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 22 Jun 2022 12:52:02 +0200
Message-ID: <CAHp75VdqjCoWAHV4AyYrju0o8buREA8pM5wyf8TD=rCMTs-tEA@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] driver core: Set fw_devlink.strict=1 by default
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 Sascha Hauer <sha@pengutronix.de>, Saravana Kannan <saravanak@google.com>,
 Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Android Kernel Team <kernel-team@android.com>, Len Brown <len.brown@intel.com>,
 Linux PM <linux-pm@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Sascha Hauer <kernel@pengutronix.de>, netdev <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Heiner Kallweit <hkallweit1@gmail.com>
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

On Wed, Jun 22, 2022 at 10:44 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Jun 22, 2022 at 9:48 AM Sascha Hauer <sha@pengutronix.de> wrote:

...

> > This patch has the effect that console UART devices which have "dmas"
> > properties specified in the device tree get deferred for 10 to 20
> > seconds. This happens on i.MX and likely on other SoCs as well. On i.MX
> > the dma channel is only requested at UART startup time and not at probe
> > time. dma is not used for the console. Nevertheless with this driver probe
> > defers until the dma engine driver is available.
> >
> > It shouldn't go in as-is.
>
> This affects all machines with the PL011 UART and DMAs specified as
> well.
>
> It would be best if the console subsystem could be treated special and
> not require DMA devlink to be satisfied before probing.

In 8250 we force disable DMA and PM on kernel consoles, because it's
so-o PITA and has a lot of corner cases we may never chase down.

089b6d365491 serial: 8250_port: Disable DMA operations for kernel console
bedb404e91bb serial: 8250_port: Don't use power management for kernel console


> It seems devlink is not quite aware of the concept of resources that are
> necessary to probe vs resources that are nice to have and might be
> added after probe. We need a strong devlink for the first category
> and maybe a weak devlink for the latter category.
>
> I don't know if this is a generic hardware property for all operating
> systems so it could be a DT property such as dma-weak-dependency?
> Or maybe compromize and add a linux,dma-weak-dependency;
> property?


-- 
With Best Regards,
Andy Shevchenko
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
