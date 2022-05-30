Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDD8C433EF
	for <iommu@archiver.kernel.org>; Mon, 30 May 2022 09:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 432C5409E1;
	Mon, 30 May 2022 09:22:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qe_8TamTqpSs; Mon, 30 May 2022 09:22:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0C8AD40198;
	Mon, 30 May 2022 09:22:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6923C0032;
	Mon, 30 May 2022 09:22:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55307C002D
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 09:22:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2EADF40588
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 09:22:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M1gyxFzpxJuX for <iommu@lists.linux-foundation.org>;
 Mon, 30 May 2022 09:22:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0D4A340198
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 09:22:20 +0000 (UTC)
Received: by mail-qt1-f180.google.com with SMTP id g3so11126219qtb.7
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 02:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sRRIuRryzgFI8ELIIPROeVlwSt2lbuDu8QoygFjo9dY=;
 b=S6p4k6zHMMsvmp3+m1vlW1l/ypN0wlGOt9ZKP1822LP5CJBN/NVcl9G/Prv8LcBs8D
 7+NG6FqejvmR2h1/V2gMsgx1ks4F4ZQj0isXhTqJVsztepToCRhkAKGNLLfd/9bQCNTB
 4hKP8/mQg04Rt3+kT1/rUbh9tbnrT+oxetH4DPcc6SBIY7NEfruA0ar7N5yvBJqpPe7R
 k3P6L1MQ1HYPHGtEZEHrAI+xZZ7QXmUozDEwDIepNkUCq4y5FZgLuf7LMj/3kybg2s+7
 nThow9kzl0hue2FC7w/GmJA9ERUXJigM5G7NSEsLx2x72jWl3C0aXAX5YwY50ATmpRYt
 rsvQ==
X-Gm-Message-State: AOAM531WpDnLmLtqqXYpA0jqM8FUcqv8X9blsiUeKAuwJGOA1uT8egsY
 uyJhF546/wNnnEq1v7yWUveANwE9R6WPHQ==
X-Google-Smtp-Source: ABdhPJxx1ptntrCn34So8TWYP1CmeV/RRmInStl10ShzR4WjXVx5OOjkLl24O7INikkfoWjJfDuhxA==
X-Received: by 2002:ac8:57c9:0:b0:300:658f:c01d with SMTP id
 w9-20020ac857c9000000b00300658fc01dmr7206260qta.512.1653902539745; 
 Mon, 30 May 2022 02:22:19 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com.
 [209.85.219.171]) by smtp.gmail.com with ESMTPSA id
 m9-20020a05620a214900b006a5bc8e956esm6467947qkm.133.2022.05.30.02.22.14
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 May 2022 02:22:16 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id z186so13793561ybz.3
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 02:22:14 -0700 (PDT)
X-Received: by 2002:a05:6902:389:b0:633:31c1:d0f7 with SMTP id
 f9-20020a056902038900b0063331c1d0f7mr50896098ybs.543.1653902534054; Mon, 30
 May 2022 02:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220526081550.1089805-1-saravanak@google.com>
 <20220526081550.1089805-3-saravanak@google.com>
In-Reply-To: <20220526081550.1089805-3-saravanak@google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 May 2022 11:22:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV4Uzfg8aBY=tKnRcig=Npebd158J7UK3zg5_DtHwAR5w@mail.gmail.com>
Message-ID: <CAMuHMdV4Uzfg8aBY=tKnRcig=Npebd158J7UK3zg5_DtHwAR5w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/9] pinctrl: devicetree: Delete usage of
 driver_deferred_probe_check_state()
To: Saravana Kannan <saravanak@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>,
 John Stultz <jstultz@google.com>, Pavel Machek <pavel@ucw.cz>,
 Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
 Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Android Kernel Team <kernel-team@android.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Daniel Scally <djrscally@gmail.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, netdev <netdev@vger.kernel.org>,
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

Hi Saravana,

Thanks for your patch!

On Thu, May 26, 2022 at 10:16 AM Saravana Kannan <saravanak@google.com> wrote:
> Now that fw_devlink=on by default and fw_devlink supports
> "pinctrl-[0-8]" property, the execution will never get to the point

0-9?

oh, it's really 0-8:

    drivers/of/property.c:DEFINE_SIMPLE_PROP(pinctrl0, "pinctrl-0", NULL)
    drivers/of/property.c:DEFINE_SIMPLE_PROP(pinctrl1, "pinctrl-1", NULL)
    drivers/of/property.c:DEFINE_SIMPLE_PROP(pinctrl2, "pinctrl-2", NULL)
    drivers/of/property.c:DEFINE_SIMPLE_PROP(pinctrl3, "pinctrl-3", NULL)
    drivers/of/property.c:DEFINE_SIMPLE_PROP(pinctrl4, "pinctrl-4", NULL)
    drivers/of/property.c:DEFINE_SIMPLE_PROP(pinctrl5, "pinctrl-5", NULL)
    drivers/of/property.c:DEFINE_SIMPLE_PROP(pinctrl6, "pinctrl-6", NULL)
    drivers/of/property.c:DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
    drivers/of/property.c:DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)

Looks fragile, especially since we now have:

    arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi:
pinctrl-9 = <&i2cmux_9>;
    arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi: pinctrl-10
= <&i2cmux_10>;
    arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi: pinctrl-11
= <&i2cmux_11>;
    arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi: pinctrl-12
= <&i2cmux_pins_i>;

> where driver_deferred_probe_check_state() is called before the supplier
> has probed successfully or before deferred probe timeout has expired.
>
> So, delete the call and replace it with -ENODEV.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

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
