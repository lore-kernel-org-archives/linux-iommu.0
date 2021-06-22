Return-Path: <SRS0=IFPa=LQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55416C49EBE
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 13:43:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 092EE61289
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 13:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092EE61289
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1E4C4025E;
	Tue, 22 Jun 2021 13:43:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JDF5GJ3vcqLD; Tue, 22 Jun 2021 13:43:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6D34A40242;
	Tue, 22 Jun 2021 13:43:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26B2DC0010;
	Tue, 22 Jun 2021 13:43:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DA3BC000E
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 13:43:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 73DCF402CD
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 13:43:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pmStgf6mZGCO for <iommu@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 13:43:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3A12240103
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 13:43:53 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5B4D61378
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 13:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624369432;
 bh=NqFXh1RzaIB7T3yUivBhV+3jLDLAyj/zzCtWY0JA0SQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=n2C4l95B/w+7fm3Hy/W1ls3BjWTgUnPkeMWPcJwuHNhjALViq36NSNRvf1J+UxXwT
 W1of8Zg2OiipKGz+JaQJVEN0Rymz9BqpYAiOBzmrtdT5/mgiDbEVBsHlr3gDk+TOBO
 Fe7qpiKq+UgUir5JlR9fsJDRZtySIEJhB36NWX9yf5t0mO64+Z1mYCq7ew8ZAwg0KI
 F5hwQr8sPPDgEGs9UTcylTzkdsRMaQyTccf/acpKJhxDJxKtULLFNQYEsUOGj4MJxK
 B3a0hJqzs9FjH4X1uUrkMDUidT5NSByby5xfUTkfYV6nW2261SSjbz6fXsdgEAv5QU
 qCbHec6qB4IfA==
Received: by mail-ed1-f42.google.com with SMTP id h17so13819999edw.11
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 06:43:52 -0700 (PDT)
X-Gm-Message-State: AOAM532tKVEp6BbhCTnUGz/dVQcYWr1gZrMb48og/YzOG8us3P9VKT9B
 MuuhrcDiZV9BEaznkopVyUy4SBu58Z9DDfxz6A==
X-Google-Smtp-Source: ABdhPJzR0Ub3ZgSNkr3MEhjSHq6x9DynzmvMX7quMzOS1boijoDJs7nsAsYPAJuJ3rupM/aSXMVZuLXS4ayPZR+vCGA=
X-Received: by 2002:a05:6402:ca2:: with SMTP id
 cn2mr2897976edb.62.1624369431373; 
 Tue, 22 Jun 2021 06:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210615191543.1043414-1-robh@kernel.org>
 <CAMuHMdUGXu8yj3JWKwM8mt7axkrzGMiowC1t0PHrbpxRCBME3w@mail.gmail.com>
In-Reply-To: <CAMuHMdUGXu8yj3JWKwM8mt7axkrzGMiowC1t0PHrbpxRCBME3w@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 22 Jun 2021 07:43:37 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ8jjkufTAmoFHuqpWB0bMUfCCkUR-pFFa2MoyeGzgBvA@mail.gmail.com>
Message-ID: <CAL_JsqJ8jjkufTAmoFHuqpWB0bMUfCCkUR-pFFa2MoyeGzgBvA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Drop redundant minItems/maxItems
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Linux PWM List <linux-pwm@vger.kernel.org>,
 "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 "open list:REMOTE PROCESSOR \(REMOTEPROC\) SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 "open list:LIBATA SUBSYSTEM \(Serial and Parallel ATA drivers\)"
 <linux-ide@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>,
 linux-phy@lists.infradead.org, linux-riscv <linux-riscv@lists.infradead.org>,
 Lee Jones <lee.jones@linaro.org>, linux-clk <linux-clk@vger.kernel.org>,
 "open list:REAL TIME CLOCK \(RTC\) SUBSYSTEM" <linux-rtc@vger.kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Herbert Xu <herbert@gondor.apana.org.au>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, Marc Zyngier <maz@kernel.org>,
 Jassi Brar <jassisinghbrar@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@ti.com>, David Airlie <airlied@linux.ie>,
 "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Jakub Kicinski <kuba@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Vivien Didelot <vivien.didelot@gmail.com>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Ohad Ben-Cohen <ohad@wizery.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
 Linux PM list <linux-pm@vger.kernel.org>, linux-can@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Kamal Dasu <kdasu.kdev@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, Jens Axboe <axboe@kernel.dk>,
 Alessandro Zummo <a.zummo@towertech.it>, Guenter Roeck <linux@roeck-us.net>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 netdev <netdev@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 USB list <linux-usb@vger.kernel.org>,
 Linux MMC List <linux-mmc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-spi <linux-spi@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dmaengine <dmaengine@vger.kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jonathan Cameron <jic23@kernel.org>
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

On Tue, Jun 22, 2021 at 2:17 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Tue, Jun 15, 2021 at 9:16 PM Rob Herring <robh@kernel.org> wrote:
> > If a property has an 'items' list, then a 'minItems' or 'maxItems' with the
> > same size as the list is redundant and can be dropped. Note that is DT
> > schema specific behavior and not standard json-schema behavior. The tooling
> > will fixup the final schema adding any unspecified minItems/maxItems.
> >
> > This condition is partially checked with the meta-schema already, but
> > only if both 'minItems' and 'maxItems' are equal to the 'items' length.
> > An improved meta-schema is pending.
>
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> > --- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> > @@ -46,7 +46,6 @@ properties:
> >
> >    clocks:
> >      minItems: 3
> > -    maxItems: 5
> >      items:
> >        - description: GMAC main clock
> >        - description: MAC TX clock
>
> While resolving the conflict with commit fea99822914039c6
> ("dt-bindings: net: document ptp_ref clk in dwmac") in soc/for-next,
> I noticed the following construct for clock-names:
>
>   clock-names:
>     minItems: 3
>     maxItems: 6
>     contains:
>       enum:
>         - stmmaceth
>         - mac-clk-tx
>         - mac-clk-rx
>         - ethstp
>         - eth-ck
>         - ptp_ref
>
> Should this use items instead of enum, and drop maxItems, or is this
> a valid construct to support specifying the clocks in random order?
> If the latter, it does mean that the order of clock-names may not
> match the order of the clock descriptions.

'contains' is true if one or more entries match the strings. So it is
really saying one of these is required. That's not really much of a
constraint. There's 'minContains' and 'maxContains' in newer
json-schema versions (not yet supported) that could add some
constraints if there has to be at least N entries from contains. An
'items' schema (as opposed to a list) would say all items have to
match one of the strings. I'm sure that's too strict.

TLDR: clocks for this binding are a mess and the above is probably all
we can do here.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
