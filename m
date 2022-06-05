Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324C0CCA481
	for <iommu@archiver.kernel.org>; Sun,  5 Jun 2022 03:41:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AA72D40CA2;
	Sun,  5 Jun 2022 03:41:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AgJ7_wlDAsGu; Sun,  5 Jun 2022 03:41:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 47A9040022;
	Sun,  5 Jun 2022 03:41:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 293D6C0032;
	Sun,  5 Jun 2022 03:41:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF125C002D
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jun 2022 03:41:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A87BB416EC
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jun 2022 03:41:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hOfc0rHOUvUY for <iommu@lists.linux-foundation.org>;
 Sun,  5 Jun 2022 03:41:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 46707416D8
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jun 2022 03:41:39 +0000 (UTC)
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-30ec2aa3b6cso115395087b3.11
 for <iommu@lists.linux-foundation.org>; Sat, 04 Jun 2022 20:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8D/HSJdgvaLuLG5xNuCfkPKEmuWt/pvFegiJ6KrnY3I=;
 b=mKSUfps2jQlGQKb0Pj23vVrDLYVfTCLfU2eGOHO0w5RekTl50sZCBIWYc422QqsHPk
 /XxL89nyYHDRl97kUmDpzp8WH5h11lP4O0uUOKfMu2TnxilV4Z3H1a8ixh/gPQip4l40
 wv9fe46cZQak2RrkCbgmMKFh6esgjYM7h7RAsIe8vxQcm5WHJgj462Nkln6ihNULbmh5
 yKfql9QWwKpLtxGT6bBf9EVswVowh7YRTqi2uL7N1OXTRp8+5RQKQQC4NnLd+bozSnNH
 FjM1/Y2XwKhaUsQuFhdiKo8uc4DelbeZzUjCAGel2Nl/dlbPYYEsMvzYu7ek9W7Wbjzm
 hm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8D/HSJdgvaLuLG5xNuCfkPKEmuWt/pvFegiJ6KrnY3I=;
 b=WhqYG8BRUDH6tB3RDSUcsYu87/q3Rif6sUUgs2bXuLbbswbwyGg7QUH+pyKxRTW75Y
 DxQWpeRKCcYhK1d1J+99b6j4FuaZWy7BiWpwZhMTZw01IIdt2Rdrud1ui8Y4+ExC5Hqn
 B0ou4cqtP95k3H9vcvTrlqgynB/56CTNCXRNOvlLk0JycMIoGZulJYvaeGlFPSL4s0je
 DpRlN35sieaecLEMjXzvDN33+bw49pdlpwoWtVZJMilwS/A93Lic9XtVUIcGi6qSmXIn
 ESo8WhnvIcm+IQDgxA08jBnUXYbmaDDW8l1T2y69h+CNdFXo+QXykB2VUxZLzUDKMlYA
 xoqw==
X-Gm-Message-State: AOAM533irDkUW/T5sz3f5h5+s07fESywllUUSL6wRXqcuzfNb3js9Oai
 Pef7wMQ8TZhEPmagLwFhmhYDVmB0SrMHJkMVnUsvEQ==
X-Google-Smtp-Source: ABdhPJw562eb7reVPGNJbod3DV69zufo9T9SJHMXkVI4U3mBg/CR3ExMEoEaOQg+VaLP57X91Nj9UD9yZKT138G+/JQ=
X-Received: by 2002:a81:1a4c:0:b0:30c:8363:e170 with SMTP id
 a73-20020a811a4c000000b0030c8363e170mr18860130ywa.455.1654400497941; Sat, 04
 Jun 2022 20:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220526081550.1089805-1-saravanak@google.com>
 <20220526081550.1089805-3-saravanak@google.com>
 <CAMuHMdV4Uzfg8aBY=tKnRcig=Npebd158J7UK3zg5_DtHwAR5w@mail.gmail.com>
In-Reply-To: <CAMuHMdV4Uzfg8aBY=tKnRcig=Npebd158J7UK3zg5_DtHwAR5w@mail.gmail.com>
Date: Sat, 4 Jun 2022 20:41:01 -0700
Message-ID: <CAGETcx-=kAJp282OvG4yd830fhQowN7-yXifERqiHRi2w0bGFw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/9] pinctrl: devicetree: Delete usage of
 driver_deferred_probe_check_state()
To: Geert Uytterhoeven <geert@linux-m68k.org>
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
From: Saravana Kannan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, May 30, 2022 at 2:22 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> Thanks for your patch!
>
> On Thu, May 26, 2022 at 10:16 AM Saravana Kannan <saravanak@google.com> wrote:
> > Now that fw_devlink=on by default and fw_devlink supports
> > "pinctrl-[0-8]" property, the execution will never get to the point
>
> 0-9?
>
> oh, it's really 0-8:
>
>     drivers/of/property.c:DEFINE_SIMPLE_PROP(pinctrl0, "pinctrl-0", NULL)
>     drivers/of/property.c:DEFINE_SIMPLE_PROP(pinctrl1, "pinctrl-1", NULL)
>     drivers/of/property.c:DEFINE_SIMPLE_PROP(pinctrl2, "pinctrl-2", NULL)
>     drivers/of/property.c:DEFINE_SIMPLE_PROP(pinctrl3, "pinctrl-3", NULL)
>     drivers/of/property.c:DEFINE_SIMPLE_PROP(pinctrl4, "pinctrl-4", NULL)
>     drivers/of/property.c:DEFINE_SIMPLE_PROP(pinctrl5, "pinctrl-5", NULL)
>     drivers/of/property.c:DEFINE_SIMPLE_PROP(pinctrl6, "pinctrl-6", NULL)
>     drivers/of/property.c:DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
>     drivers/of/property.c:DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)
>
> Looks fragile, especially since we now have:
>
>     arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi:
> pinctrl-9 = <&i2cmux_9>;
>     arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi: pinctrl-10
> = <&i2cmux_10>;
>     arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi: pinctrl-11
> = <&i2cmux_11>;
>     arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi: pinctrl-12
> = <&i2cmux_pins_i>;

Checking for pinctrl-* and then verifying if * matches %d would be
more complicated and probably more expensive compared to listing
pinctrl-[0-8]. Especially because more than 50% of pinctrl-*
properties in DT files are NOT pinctrl-%d. So back when we merged
this, Rob and I agreed [0-8] was good enough for now and we can add
more if we needed to. Also, when I checked back then, all the
pinctrl-5+ properties ended up pointing to the same suppliers as the
lower numbered ones. So it didn't make a difference.

Ok, I just checked linux-next all the pinctrl-9+ instances and it's
still true that they all point to the same supplier pointed to by
pinctrl-[0-8].

So yeah, it looks fragile, but is not broken and it's more efficient
than looking for pinctrl-%d or adding more pinctrl-xx entries. So,
let's fix it if it actually breaks? Not going to oppose a patch if
anyone wants to make it more complete.


-Saravana

>
> > where driver_deferred_probe_check_state() is called before the supplier
> > has probed successfully or before deferred probe timeout has expired.
> >
> > So, delete the call and replace it with -ENODEV.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
