Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 076E3CCA47F
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 07:30:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7E2CC40482;
	Fri,  1 Jul 2022 07:30:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7E2CC40482
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PIdklcEsjSBf; Fri,  1 Jul 2022 07:30:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4E50A40182;
	Fri,  1 Jul 2022 07:30:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4E50A40182
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F939C0071;
	Fri,  1 Jul 2022 07:30:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3764C002D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 07:30:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B480845EE
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 07:30:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B480845EE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2u_9r-qCquIg for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 07:30:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 19224845BC
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 19224845BC
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 07:30:41 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id i17so3283194qvo.13
 for <iommu@lists.linux-foundation.org>; Fri, 01 Jul 2022 00:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YU1XddcO32RLHJVgcyV4xbGLKtUqtr7Z4CGj+gDtTi4=;
 b=H/v/NAiUYJvLL18dpwfWtLQBPYHI6Yjr08Jaw1aR+DJ3Bin0lfi2L+069V2ppk8lgC
 Ueht4GeymTObtq8VrJKwLwrVqChdasokf+RFfvHZo5HoDP0wYXrFzAoyR0YqRS510XRV
 vt3OSp9nkbapGjk0S6dG8vlB8sgap07M9WkYXWVCFvd2Bm+58h5r1vPAM/QNNsQ0npQ9
 CCqYTHLohbYLLgrjSFXirOZ0tDPHDgNhuSfiB/+S/EOCiylPutAh/qi8cPl/sW1/bUrn
 fd/e5wDKe3BHgZI/m8HGslW8QxIXfcVwpSDvxj4swDm5A+CPfJbGFCgWKTQqJUAEpPu0
 /o9g==
X-Gm-Message-State: AJIora+fCEfcXSp3FRG0lzrMYQhFLnsZgACbCmV49k+zVaTPjMa90kiz
 2ayLRvw8bC6MdYyQDly8oB6wW68ZKA3bmg==
X-Google-Smtp-Source: AGRyM1sUjgBz7nfOicSjUZ4tFfe0i+NECpNTsB55tyGDAg1aYi3eZj5F/+ovNl/1JBsycW5UmlcZWw==
X-Received: by 2002:a05:6214:1cc7:b0:470:5371:26ff with SMTP id
 g7-20020a0562141cc700b00470537126ffmr14958905qvd.9.1656660640745; 
 Fri, 01 Jul 2022 00:30:40 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com.
 [209.85.128.173]) by smtp.gmail.com with ESMTPSA id
 y8-20020a05622a004800b0031d2635bbf5sm4653160qtw.38.2022.07.01.00.30.39
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Jul 2022 00:30:40 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-31bf3656517so15010967b3.12
 for <iommu@lists.linux-foundation.org>; Fri, 01 Jul 2022 00:30:39 -0700 (PDT)
X-Received: by 2002:a0d:c787:0:b0:31b:a963:e1de with SMTP id
 j129-20020a0dc787000000b0031ba963e1demr15110386ywd.283.1656660639601; Fri, 01
 Jul 2022 00:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
 <20220601070707.3946847-2-saravanak@google.com> <YrFzK6EiVvXmzVG6@atomide.com>
 <4799738.LvFx2qVVIh@steina-w>
 <CAGETcx_1qa=gGT4LVkyPpcA1vFM9FzuJE+0DhL_nFyg5cbFjVg@mail.gmail.com>
In-Reply-To: <CAGETcx_1qa=gGT4LVkyPpcA1vFM9FzuJE+0DhL_nFyg5cbFjVg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 1 Jul 2022 09:30:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUJbWtTvDdtJGcDKfdULA+uqo_HGaiOz4p2UjszAJtsRQ@mail.gmail.com>
Message-ID: <CAMuHMdUJbWtTvDdtJGcDKfdULA+uqo_HGaiOz4p2UjszAJtsRQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] PM: domains: Delete usage of
 driver_deferred_probe_check_state()
To: Saravana Kannan <saravanak@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Tony Lindgren <tony@atomide.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Android Kernel Team <kernel-team@android.com>,
 Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
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

On Fri, Jul 1, 2022 at 2:37 AM Saravana Kannan <saravanak@google.com> wrote:
> On Thu, Jun 23, 2022 at 5:08 AM Alexander Stein
> <alexander.stein@ew.tq-group.com> wrote:
> > Am Dienstag, 21. Juni 2022, 09:28:43 CEST schrieb Tony Lindgren:

> > > * Saravana Kannan <saravanak@google.com> [700101 02:00]:
> > > > Now that fw_devlink=on by default and fw_devlink supports
> > > > "power-domains" property, the execution will never get to the point
> > > > where driver_deferred_probe_check_state() is called before the supplier
> > > > has probed successfully or before deferred probe timeout has expired.
> > > >
> > > > So, delete the call and replace it with -ENODEV.
> > >
> > > Looks like this causes omaps to not boot in Linux next. With this
> > > simple-pm-bus fails to probe initially as the power-domain is not
> > > yet available. On platform_probe() genpd_get_from_provider() returns
> > > -ENOENT.
> > >
> > > Seems like other stuff is potentially broken too, any ideas on
> > > how to fix this?
> >
> > I think I'm hit by this as well, although I do not get a lockup.
> > In my case I'm using arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts
> > and probing of 38320000.blk-ctrl fails as the power-domain is not (yet)
> > registed.
>
> Ok, took a look.
>
> The problem is that there are two drivers for the same device and they
> both initialize this device.
>
>     gpc: gpc@303a0000 {
>         compatible = "fsl,imx8mq-gpc";
>     }
>
> $ git grep -l "fsl,imx7d-gpc" -- drivers/
> drivers/irqchip/irq-imx-gpcv2.c
> drivers/soc/imx/gpcv2.c

You missed the "driver" in arch/arm/mach-imx/src.c ;-)

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
