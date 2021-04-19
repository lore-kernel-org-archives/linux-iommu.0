Return-Path: <SRS0=soV1=JQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F3BC433ED
	for <iommu@archiver.kernel.org>; Mon, 19 Apr 2021 12:17:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94E00611CE
	for <iommu@archiver.kernel.org>; Mon, 19 Apr 2021 12:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E00611CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4DD5B834C6;
	Mon, 19 Apr 2021 12:17:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OugyVtljI5kZ; Mon, 19 Apr 2021 12:17:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id E069983459;
	Mon, 19 Apr 2021 12:17:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B12C9C000E;
	Mon, 19 Apr 2021 12:17:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF441C000B
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 12:17:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A7DB8607BF
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 12:17:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jPwOpyBcq1aX for <iommu@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 12:17:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 310356064C
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 12:17:06 +0000 (UTC)
Received: from mail-lj1-f169.google.com ([209.85.208.169]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mzi3l-1llRNO3sbR-00vfJJ for <iommu@lists.linux-foundation.org>; Mon, 19 Apr
 2021 14:17:04 +0200
Received: by mail-lj1-f169.google.com with SMTP id a25so25791581ljm.11
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 05:17:03 -0700 (PDT)
X-Gm-Message-State: AOAM5330JIQY6BiDsRWk6e8Bc5/ekRVPAtAMqIqnhCyNz0J7NH9vlkkk
 pFlbFqzIm7vU3O682divZQWpO0K53DWbCyeheEg=
X-Google-Smtp-Source: ABdhPJw4F20QerTwfst1rAMwc6NWiXDSUWeUkZ8E4j2sezaYrIv6atAni45jIwUzsYws7AyLO9D3pu8QFGIGztgXd7o=
X-Received: by 2002:a05:6000:1843:: with SMTP id
 c3mr14679907wri.361.1618834612186; 
 Mon, 19 Apr 2021 05:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210419042722.27554-1-alice.guo@oss.nxp.com>
 <20210419042722.27554-4-alice.guo@oss.nxp.com>
 <YH0O907dfGY9jQRZ@atmark-techno.com>
 <CAMuHMdVY1SLZ0K30T2pimyrR6Mm=VoSTO=L-xxCy2Bj7_kostw@mail.gmail.com>
 <YH1OeFy+SepIYYG0@atmark-techno.com>
In-Reply-To: <YH1OeFy+SepIYYG0@atmark-techno.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 19 Apr 2021 14:16:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1Mu2F0irDDCL-50HiHth29iYFL5b7WHZ=UX6W7zzoxAg@mail.gmail.com>
Message-ID: <CAK8P3a1Mu2F0irDDCL-50HiHth29iYFL5b7WHZ=UX6W7zzoxAg@mail.gmail.com>
Subject: Re: [RFC v1 PATCH 3/3] driver: update all the code that use
 soc_device_match
To: Dominique MARTINET <dominique.martinet@atmark-techno.com>
X-Provags-ID: V03:K1:JpMg4eOTzywsMVgUjhWyTOC/jUGEGJuYjU9MGjaShhROxtiVy3W
 1Lv5zhxWslAXJ6yv7ixPTIpSzs3Ww6yhVMYIo11UljRVrn/022g/ewl68vbMwc/Q467udKx
 npoF+VcK9N6ab2xXdLiHQSNQdUmbxdML8al5Tq5O5/eLRYeckPWIFXpIen3RhOB0QTjpwx5
 794PWKD3i174cYP4umI1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FfDSK5oh0zU=:aeD1clYsnTS7hWBlIHD6pm
 Mz4iuOaH4ZvhsZ4PyKjMbUwjti3xt4h2SLkRjwM4clAgF3bbHO/FDYkcOhAxvXU1qfEY+FHTh
 AU8IaI9EOpdlzeZRZLNo8qEblkKDSrPwqTZmw757xF80GFgEUDXouoX5+t6CgdCnwb+lIA53G
 XODQ+UnI3rjkoNAk59Xg0S7U2bQ5t3JTdaVzQAUX3wsx9vs1muJF4Ub5j+HDD284nhhJRXvCj
 Nf8E3aKmckptUJsIMDt7orn94zFtQB/YsCL/zo/8HghCG1hDx5ai5X2kP+oxdUYxI2uSurKoe
 N0a8ooAHAxO1GzcUC4/U502zoRwnFlMIqmQ8AQd3CRjbARpWOTiQd87+H0MaT9XOSbzJmFKG1
 A/P0CXEuKtHMrNRcQMul8D7IBR1xFsaz6bPiCavKSwWGAd5yk9m5kFEIwR9Z3Fy8Li4sH3+c3
 9CZCpfic+xsd4FWsrgsprVW4nKXG94TTDtoQ2UuEfau2eb2KQGZbn9qDmhxV2tV46tc29N6rS
 a6ymKmOwAoCx1d1UIut2F2Ac9pBSYes6kUdX00xRwAKfn1lztwCWhVUnI8jq4J2fMAVZvWOGQ
 H9i2J6EyEQ4MpADhSECnnmp3rRbP9OQvEGwsF4QVhLjKk+axld3Ir0FMbhd4M6nk5/Tg1dm0+
 9++0=
Cc: Ulf Hansson <ulf.hansson@linaro.org>, aymen.sghaier@nxp.com,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Rafael Wysocki <rafael@kernel.org>, David Airlie <airlied@linux.ie>,
 Michael Turquette <mturquette@baylibre.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrzej Hajda <a.hajda@samsung.com>, Networking <netdev@vger.kernel.org>,
 linux-phy@lists.infradead.org, peter.ujfalusi@gmail.com,
 linux-clk <linux-clk@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
 Kevin Hilman <khilman@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>,
 linux-staging@lists.linux.dev,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Kishon <kishon@ti.com>, Tony Lindgren <tony@atomide.com>,
 linux-omap <linux-omap@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jakub Kicinski <kuba@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Guenter Roeck <linux@roeck-us.net>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Linux PM list <linux-pm@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Eduardo Valentin <edubezval@gmail.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC..." <linux-mediatek@lists.infradead.org>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "open list:ARM/Amlogic Meson SoC support" <linux-amlogic@lists.infradead.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "Alice Guo \(OSS\)" <alice.guo@oss.nxp.com>, Felipe Balbi <balbi@kernel.org>,
 tomba@kernel.org, Stephen Boyd <sboyd@kernel.org>,
 gregkh <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>,
 USB list <linux-usb@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Robert Foss <robert.foss@linaro.org>,
 Leo Li <leoyang.li@nxp.com>, Tony Prisk <linux@prisktech.co.nz>,
 Vinod Koul <vkoul@kernel.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Keerthy <j-keerthy@ti.com>, dmaengine@vger.kernel.org,
 Roy Pledge <Roy.Pledge@nxp.com>, jyri.sarha@iki.fi,
 David Miller <davem@davemloft.net>
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

On Mon, Apr 19, 2021 at 11:33 AM Dominique MARTINET
<dominique.martinet@atmark-techno.com> wrote:
> Geert Uytterhoeven wrote on Mon, Apr 19, 2021 at 11:03:24AM +0200:
>
> > soc_device_match() should only be used as a last resort, to identify
> > systems that cannot be identified otherwise.  Typically this is used for
> > quirks, which should only be enabled on a very specific subset of
> > systems.  IMHO such systems should make sure soc_device_match()
> > is available early, by registering their SoC device early.
>
> I definitely agree there, my suggestion to defer was only because I know
> of no other way to influence the ordering of drivers loading reliably
> and gave up on soc being init'd early.

In some cases, you can use the device_link infrastructure to deal
with dependencies between devices. Not sure if this would help
in your case, but have a look at device_link_add() etc in drivers/base/core.c

> In this particular case the problem is that since 7d981405d0fd ("soc:
> imx8m: change to use platform driver") the soc probe tries to use the
> nvmem driver for ocotp fuses for imx8m devices, which isn't ready yet.
> So soc loading gets pushed back to the end of the list because it gets
> defered and other drivers relying on soc_device_match get confused
> because they wrongly think a device doesn't match a quirk when it
> actually does.
>
> If there is a way to ensure the nvmem driver gets loaded before the soc,
> that would also solve the problem nicely, and avoid the need to mess
> with all the ~50 drivers which use it.
>
> Is there a way to control in what order drivers get loaded? Something in
> the dtb perhaps?

For built-in drivers, load order depends on the initcall level and
link order (how things are lined listed in the Makefile hierarchy).

For loadable modules, this is up to user space in the end.

Which of the drivers in this scenario are loadable modules?

        Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
