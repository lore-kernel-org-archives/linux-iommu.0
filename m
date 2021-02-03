Return-Path: <SRS0=gtiV=HF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267ECC433E0
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 08:01:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A10FA64DE7
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 08:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10FA64DE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 58DEF86770;
	Wed,  3 Feb 2021 08:01:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NCFiDlI6w+6d; Wed,  3 Feb 2021 08:01:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 480FC86777;
	Wed,  3 Feb 2021 08:01:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 348CCC0FA7;
	Wed,  3 Feb 2021 08:01:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A83A4C013A
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 08:01:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 95053862B2
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 08:01:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VEuzIULn2lvz for <iommu@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 08:01:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com
 [209.85.167.171])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 99E9186221
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 08:01:35 +0000 (UTC)
Received: by mail-oi1-f171.google.com with SMTP id h6so25861617oie.5
 for <iommu@lists.linux-foundation.org>; Wed, 03 Feb 2021 00:01:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GUaHpRuxDtXxAFdZvqP757XADeBZ3LieB9iSp5HePYo=;
 b=gRi8Fx6JgKtarPjlTfyRFXNRCF8hRMX1dotnGcmSiDowHQGXny77qz7WaHBKOBhwz/
 9ToTdDd/5TKRLVuG5krh7u/ZYMNlD8b+x/mM+QIxUzRqmOCYrm6pIGbneBSTOcpaGRVp
 C6zi6NH2gWLNJ5oiIgQTlO/Azf7vC5rQPctXlrAK/9klZQq8s3Q0iCgjDXVtcnK60X0m
 oxaYnyO+QCE8B5WvisrJtC16EmXfRVngDYM8zekZqpwIiZGRDECYGPaazv6pYwWjoVWs
 LZqTrj0mEZrqnKItgEcTSQM3sPse5vTWKv372aGdTp1otxMs9VVXZa27o0saYW6hnht+
 pdwA==
X-Gm-Message-State: AOAM533uI3mQxsjrsO+q2C1MiXGthDRvf3HFeNGITYUFWcxcwXYkjUm/
 me1IgNuBUwA4Nju7OKG6Ycykvj34O8DEC7GkDrs=
X-Google-Smtp-Source: ABdhPJwqsuDHPLo5fOlX0wowinMiQhY3VwM6kpoW5w0c8+SrgPYoxRUVXo5rAHqaZ3aooghGfjdJuw8T8GflSuyMMQU=
X-Received: by 2002:a54:4e88:: with SMTP id c8mr1200640oiy.148.1612339294830; 
 Wed, 03 Feb 2021 00:01:34 -0800 (PST)
MIME-Version: 1.0
References: <20210202205544.24812-1-robh@kernel.org>
 <20210202205544.24812-3-robh@kernel.org>
In-Reply-To: <20210202205544.24812-3-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 3 Feb 2021 09:01:23 +0100
Message-ID: <CAMuHMdVvtUvrQh3-3kxaqqWvHnF_UOQmt-6jq_GkX8g=cszUug@mail.gmail.com>
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

On Tue, Feb 2, 2021 at 9:55 PM Rob Herring <robh@kernel.org> wrote:
> Properties in if/then schemas weren't getting checked by the meta-schemas.
> Enabling meta-schema checks finds several errors.
>
> The use of an 'items' schema (as opposed to the list form) is wrong in
> some cases as it applies to all entries. 'contains' is the correct schema
> to use in the case of multiple entries.

> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
> @@ -81,9 +81,8 @@ properties:
>  if:
>    properties:
>      compatible:
> -      items:
> -        enum:
> -          - renesas,usb2-phy-r7s9210
> +      contains:
> +        const: renesas,usb2-phy-r7s9210

Single entry, so "contains" not needed?

> --- a/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
> @@ -76,11 +76,10 @@ required:
>  if:
>    properties:
>      compatible:
> -      items:
> -        enum:
> -          - renesas,pfc-r8a73a4
> -          - renesas,pfc-r8a7740
> -          - renesas,pfc-sh73a0
> +      enum:
> +        - renesas,pfc-r8a73a4
> +        - renesas,pfc-r8a7740
> +        - renesas,pfc-sh73a0

Missing "contains"?

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
