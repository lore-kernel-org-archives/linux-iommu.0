Return-Path: <SRS0=soV1=JQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF618C433B4
	for <iommu@archiver.kernel.org>; Mon, 19 Apr 2021 23:43:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A1C561279
	for <iommu@archiver.kernel.org>; Mon, 19 Apr 2021 23:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1C561279
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC7D14029E;
	Mon, 19 Apr 2021 23:43:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bFyeR5Q8a4Lw; Mon, 19 Apr 2021 23:43:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9BB57402A3;
	Mon, 19 Apr 2021 23:43:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79DF2C000F;
	Mon, 19 Apr 2021 23:43:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E365FC000B
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 23:43:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D0EEB401C4
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 23:43:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pmq9bLq6_4pp for <iommu@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 23:43:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gw.atmark-techno.com (gw.atmark-techno.com [13.115.124.170])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4450140181
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 23:43:10 +0000 (UTC)
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by gw.atmark-techno.com (Postfix) with ESMTPS id 839BF8047F
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 08:43:08 +0900 (JST)
Received: by mail-ot1-f71.google.com with SMTP id
 l10-20020a056830054ab0290241bf5f8c25so10704978otb.11
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 16:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YfTDNxUjME1kzwn4ONpBlmaWp5uEs0PGjlewRbiJ8O0=;
 b=CnVzoI1AZ1LSVEH4pO0S/AT+i9/uGe5+i3jbnpegv4KRXnZljA8bSTPBbpCCOFubOD
 vnIcGWSqxmg8kd+D8rhlfggzv4hhKQwKEd72weeujidubNx649MyvFQxOJ1q3MrcIsdF
 5oT4hJYLb/hraOXTWiSEDWm2ruJdgVrLZmLaCiAknmnfqAxzXJzZ/YnC0iJA97MIcIWu
 tDbyqIlq5tOwxDrF6kgQs/BxPDmI+o/xO3qYV5dIvC70g9kB9bVjQMPedaVf63Fs1jMJ
 btHYQeryFU+PfRAD+Vp/alRUvlHg8oIDiJNcw9HndUSDTI9QX5FXMeSf6vaTwiV05cAC
 qY5w==
X-Gm-Message-State: AOAM531q2BbznfGQat0uRNmw5HeAcK9a2yA42lu/ECIJXbrLUgmGWUT7
 RtquI+7Tj+G/3ODX9eWiV6pBY6nmhZAgu4xXZ4GIZNnB/YNnK2KizGjLhtckvtecibeTzE6wevW
 J3h9XcG5eYWPtGTof5TobuztM41q5LrG2Ow==
X-Received: by 2002:a17:90a:1c1:: with SMTP id 1mr1708189pjd.190.1618875776933; 
 Mon, 19 Apr 2021 16:42:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRGNIqy2AO5m9iOwuC4N09BxordE8LmUXYTIIeyniOtbCQKfA0MKaQl391n1ZLV3YIJOra8w==
X-Received: by 2002:a17:90a:1c1:: with SMTP id 1mr1708139pjd.190.1618875776711; 
 Mon, 19 Apr 2021 16:42:56 -0700 (PDT)
Received: from pc-0115 (76.125.194.35.bc.googleusercontent.com.
 [35.194.125.76])
 by smtp.gmail.com with ESMTPSA id r3sm8384971pgn.82.2021.04.19.16.42.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 19 Apr 2021 16:42:55 -0700 (PDT)
Received: from martinet by pc-0115 with local (Exim 4.94)
 (envelope-from <martinet@pc-0115>)
 id 1lYdXa-002mPj-58; Tue, 20 Apr 2021 08:42:54 +0900
Date: Tue, 20 Apr 2021 08:42:44 +0900
From: Dominique MARTINET <dominique.martinet@atmark-techno.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC v1 PATCH 3/3] driver: update all the code that use
 soc_device_match
Message-ID: <YH4VdPNO9cdzc5MD@atmark-techno.com>
References: <20210419042722.27554-1-alice.guo@oss.nxp.com>
 <20210419042722.27554-4-alice.guo@oss.nxp.com>
 <YH0O907dfGY9jQRZ@atmark-techno.com>
 <CAMuHMdVY1SLZ0K30T2pimyrR6Mm=VoSTO=L-xxCy2Bj7_kostw@mail.gmail.com>
 <YH1OeFy+SepIYYG0@atmark-techno.com>
 <CAK8P3a1Mu2F0irDDCL-50HiHth29iYFL5b7WHZ=UX6W7zzoxAg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a1Mu2F0irDDCL-50HiHth29iYFL5b7WHZ=UX6W7zzoxAg@mail.gmail.com>
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
 Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
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

Arnd Bergmann wrote on Mon, Apr 19, 2021 at 02:16:36PM +0200:
> In some cases, you can use the device_link infrastructure to deal
> with dependencies between devices. Not sure if this would help
> in your case, but have a look at device_link_add() etc in drivers/base/core.c

I'll need to actually try to convince myself but if creating the link
forces driver registration then it should be workable.

> > In this particular case the problem is that since 7d981405d0fd ("soc:
> > imx8m: change to use platform driver") the soc probe tries to use the
> > nvmem driver for ocotp fuses for imx8m devices, which isn't ready yet.
> > So soc loading gets pushed back to the end of the list because it gets
> > defered and other drivers relying on soc_device_match get confused
> > because they wrongly think a device doesn't match a quirk when it
> > actually does.
> >
> > If there is a way to ensure the nvmem driver gets loaded before the soc,
> > that would also solve the problem nicely, and avoid the need to mess
> > with all the ~50 drivers which use it.
> >
> > Is there a way to control in what order drivers get loaded? Something in
> > the dtb perhaps?
> 
> For built-in drivers, load order depends on the initcall level and
> link order (how things are lined listed in the Makefile hierarchy).
> 
> For loadable modules, this is up to user space in the end.
> 
> Which of the drivers in this scenario are loadable modules?

All the drivers involved in my case are built-in (nvmem, soc and final
soc_device_match consumer e.g. caam_jr that crashes the kernel if soc is
not identified properly).

I frankly don't like the idea of moving nvmem/ above soc/ in
drivers/Makefile as a "solution" to this (especially as there is one
that seems to care about what soc they run on...), so I'll have a look
at links first, hopefully that will work out.


Thanks,
-- 
Dominique
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
