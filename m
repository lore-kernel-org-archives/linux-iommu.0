Return-Path: <SRS0=gtiV=HF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D7EC433E0
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 16:03:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C49FC64F95
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 16:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49FC64F95
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 73A9B87120;
	Wed,  3 Feb 2021 16:03:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tk4EyUI7ssDn; Wed,  3 Feb 2021 16:03:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D648D87051;
	Wed,  3 Feb 2021 16:03:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6E48C0FA7;
	Wed,  3 Feb 2021 16:03:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F98AC0174
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 16:03:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6C1EC87082
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 16:03:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KOXuDrMzqiNc for <iommu@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 16:03:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com
 [209.85.167.170])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 89B6B87051
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 16:03:05 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id k25so311869oik.13
 for <iommu@lists.linux-foundation.org>; Wed, 03 Feb 2021 08:03:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BcE4ZZBKyxCDLDrYAu9i4Md6o808j4TR1LnI5e2y0b0=;
 b=BcSLAHRYa+X4ikmwVo/gLsHi6xoNXut771wZjgTOnoAQFUOw17WFRuYV29KCociQKh
 6gWvqV1xzJo0dxJMbJ5hwK/k0+chzKmK0QWpqk/kf0uSKo/khtTKS2C18fi5QsHCp1y3
 MuW2115JurWlwMLFWzEWsE7YflOkbzTjhubYOaIVWDa17Kk/9dytMTmcALpcmkK2kq7D
 W/J4e9hqCYD/J2fQRwS1m9V7NlIzCxQD1T69NH3s/1nnQw9q1hGrrwzZ8dVJ1H2baTwA
 YGLUs/9hKlSIeLTNn2bXttI01oA8xYtkA9ruyPpTIY3Mmpkw6pAkRxpAZut+tPMR9xbN
 GSFA==
X-Gm-Message-State: AOAM530VYfBfS1guICNmGLon20PBYmcDEolGtlHR3d3GiXuNzy+179Rg
 ic8S1Fdm9s2hi9U/LWIwFLWWH6vaUj09JkK9FXc=
X-Google-Smtp-Source: ABdhPJy5RnEli5EScDsGGPC/30HmbHWChMG7KZn1WeCaaLseFVr6EQuBii7Iq7M5O8vzqs7BmEy6ag0EovkF5KtgUsQ=
X-Received: by 2002:a54:4e88:: with SMTP id c8mr2343251oiy.148.1612368184741; 
 Wed, 03 Feb 2021 08:03:04 -0800 (PST)
MIME-Version: 1.0
References: <20210202205544.24812-1-robh@kernel.org>
 <20210202205544.24812-3-robh@kernel.org>
 <CAMuHMdVvtUvrQh3-3kxaqqWvHnF_UOQmt-6jq_GkX8g=cszUug@mail.gmail.com>
 <20210203155517.GC3706951@robh.at.kernel.org>
In-Reply-To: <20210203155517.GC3706951@robh.at.kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 3 Feb 2021 17:02:53 +0100
Message-ID: <CAMuHMdVp-YXtMBPistV0XPDHoSbW6Rz4c7=t3y2JB7B56LniBg@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: Fix errors in 'if' schemas
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Tomer Maimon <tmaimon77@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Linus Walleij <linus.walleij@linaro.org>,
 Vincent Cheng <vincent.cheng.xh@renesas.com>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Tali Perry <tali.perry1@gmail.com>, Eric Anholt <eric@anholt.net>,
 Daniel Palmer <daniel@thingy.jp>, Linux I2C <linux-i2c@vger.kernel.org>,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 linux-clk <linux-clk@vger.kernel.org>, linux-leds <linux-leds@vger.kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, Chen-Yu Tsai <wens@csie.org>,
 Joel Stanley <joel@jms.id.au>, Guenter Roeck <linux@roeck-us.net>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
 Ray Jui <rjui@broadcom.com>, Maxime Ripard <mripard@kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Avi Fishman <avifishman70@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 Stephen Boyd <sboyd@kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrew Jeffery <andrew@aj.id.au>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
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

Hi Rob,

On Wed, Feb 3, 2021 at 4:55 PM Rob Herring <robh@kernel.org> wrote:
> On Wed, Feb 03, 2021 at 09:01:23AM +0100, Geert Uytterhoeven wrote:
> > On Tue, Feb 2, 2021 at 9:55 PM Rob Herring <robh@kernel.org> wrote:
> > > Properties in if/then schemas weren't getting checked by the meta-schemas.
> > > Enabling meta-schema checks finds several errors.
> > >
> > > The use of an 'items' schema (as opposed to the list form) is wrong in
> > > some cases as it applies to all entries. 'contains' is the correct schema
> > > to use in the case of multiple entries.
> >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > Thanks for your patch!
> >
> > > --- a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
> > > +++ b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
> > > @@ -81,9 +81,8 @@ properties:
> > >  if:
> > >    properties:
> > >      compatible:
> > > -      items:
> > > -        enum:
> > > -          - renesas,usb2-phy-r7s9210
> > > +      contains:
> > > +        const: renesas,usb2-phy-r7s9210
> >
> > Single entry, so "contains" not needed?
>
> No, you are misunderstanding how these work. 'contains' means at least
> one entry in an array passes with the subschema. In this case,
> 'renesas,usb2-phy-r7s9210' must appear somewhere in the 'compatible'
> values. (Before, it said *every* entry must be
> 'renesas,usb2-phy-r7s9210'.) As there is a fallback compatible, we need
> 'contains'.
>
> > > --- a/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
> > > +++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
> > > @@ -76,11 +76,10 @@ required:
> > >  if:
> > >    properties:
> > >      compatible:
> > > -      items:
> > > -        enum:
> > > -          - renesas,pfc-r8a73a4
> > > -          - renesas,pfc-r8a7740
> > > -          - renesas,pfc-sh73a0
> > > +      enum:
> > > +        - renesas,pfc-r8a73a4
> > > +        - renesas,pfc-r8a7740
> > > +        - renesas,pfc-sh73a0
> >
> > Missing "contains"?
>
> No. In this case, 'compatible' is always a single entry, so no
> 'contains' needed (but would work). If compatible is one of these 3
> strings, then the 'if' is true.
>
> The original way would actually work in this case (i.e. is valid
> json-schema), but we require 'items' to have a size (maxItems/minItems)
> in our meta-schema.

Thanks for the explanation!
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
