Return-Path: <SRS0=IFPa=LQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700B6C49EAB
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 08:17:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06A796135A
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 08:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A796135A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1BE682675;
	Tue, 22 Jun 2021 08:17:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x0VUCEm8rrSn; Tue, 22 Jun 2021 08:17:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A15A682612;
	Tue, 22 Jun 2021 08:17:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78579C001A;
	Tue, 22 Jun 2021 08:17:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9405C000E
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 08:17:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A4C5B82662
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 08:17:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NkKys9Y1--iu for <iommu@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 08:17:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com
 [209.85.217.54])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DC58382612
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 08:17:41 +0000 (UTC)
Received: by mail-vs1-f54.google.com with SMTP id x13so10762153vsf.11
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 01:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s0hVMlLFV5eIwzuXXBEJWEV7FxMfuDBGtQwv1PuAfDc=;
 b=chdQjItdgN049rIqsToTvfnvWc9V1J0tuQPgVerMQ5XurhaYZImMy0xciSZy/cvhxM
 njKUblXBx0Y3eS0zyJfWiVIPqtZMvTRA4KAW2n6IYuUpfUEYYeQIvzNm2MDQATokyWHh
 /vnD/sY9OuyvFR975aVxklYhe05AN2zTgY/STMrhpu877JQLnfDZLDzwN4IP0uZxd04b
 34B9Uqsk2CycJ2iR7KIIymwXLICLd1wvCiu6/AvnetfLzBZtqLLgMmhu5ub1q2BK5ZXC
 VnQU5dlJ4JQ8xq68LX6L7tlhbzxG7TlQMihqyddBx4EcHZVQg8YICZCh9jEGrn3Eqrav
 ZjVA==
X-Gm-Message-State: AOAM531Ifa44cRhbqt8LfXG7/o3Y6dEGIUQqyzWnOA2FedE14IxBBVm+
 TcjW6S22K/ubjzNXRl/1ilrn7X+TA9hvcfs7Bf8=
X-Google-Smtp-Source: ABdhPJz3clw2O8tsVFk5F4OGcaBfo9Z8eHqvoF8LwYXAPGollSTCOREHx1S0f08A9nsiznMjaM5G5srL4UVXlJSotsU=
X-Received: by 2002:a05:6102:2011:: with SMTP id
 p17mr21421376vsr.40.1624349860512; 
 Tue, 22 Jun 2021 01:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210615191543.1043414-1-robh@kernel.org>
In-Reply-To: <20210615191543.1043414-1-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 Jun 2021 10:17:28 +0200
Message-ID: <CAMuHMdUGXu8yj3JWKwM8mt7axkrzGMiowC1t0PHrbpxRCBME3w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Drop redundant minItems/maxItems
To: Rob Herring <robh@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Linux PWM List <linux-pwm@vger.kernel.org>, linux-iio@vger.kernel.org,
 linux-pci <linux-pci@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 "open list:REMOTE PROCESSOR \(REMOTEPROC\) SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 DRI Development <dri-devel@lists.freedesktop.org>, linux-ide@vger.kernel.org,
 Linux I2C <linux-i2c@vger.kernel.org>, linux-phy@lists.infradead.org,
 linux-riscv <linux-riscv@lists.infradead.org>,
 Lee Jones <lee.jones@linaro.org>, linux-clk <linux-clk@vger.kernel.org>,
 linux-rtc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Herbert Xu <herbert@gondor.apana.org.au>,
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

Hi Rob,

On Tue, Jun 15, 2021 at 9:16 PM Rob Herring <robh@kernel.org> wrote:
> If a property has an 'items' list, then a 'minItems' or 'maxItems' with the
> same size as the list is redundant and can be dropped. Note that is DT
> schema specific behavior and not standard json-schema behavior. The tooling
> will fixup the final schema adding any unspecified minItems/maxItems.
>
> This condition is partially checked with the meta-schema already, but
> only if both 'minItems' and 'maxItems' are equal to the 'items' length.
> An improved meta-schema is pending.

> Signed-off-by: Rob Herring <robh@kernel.org>

> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> @@ -46,7 +46,6 @@ properties:
>
>    clocks:
>      minItems: 3
> -    maxItems: 5
>      items:
>        - description: GMAC main clock
>        - description: MAC TX clock

While resolving the conflict with commit fea99822914039c6
("dt-bindings: net: document ptp_ref clk in dwmac") in soc/for-next,
I noticed the following construct for clock-names:

  clock-names:
    minItems: 3
    maxItems: 6
    contains:
      enum:
        - stmmaceth
        - mac-clk-tx
        - mac-clk-rx
        - ethstp
        - eth-ck
        - ptp_ref

Should this use items instead of enum, and drop maxItems, or is this
a valid construct to support specifying the clocks in random order?
If the latter, it does mean that the order of clock-names may not
match the order of the clock descriptions.

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
