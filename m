Return-Path: <SRS0=soV1=JQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0ACC43460
	for <iommu@archiver.kernel.org>; Mon, 19 Apr 2021 08:20:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EA6261151
	for <iommu@archiver.kernel.org>; Mon, 19 Apr 2021 08:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA6261151
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 403B540298;
	Mon, 19 Apr 2021 08:20:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i7i9PhexvMjI; Mon, 19 Apr 2021 08:20:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id D1E2D40250;
	Mon, 19 Apr 2021 08:20:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9087C000E;
	Mon, 19 Apr 2021 08:20:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F4105C000B
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 08:20:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D45384014D
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 08:20:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ApjQi0qGNU_T for <iommu@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 08:20:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com
 [209.85.217.51])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 10CC94014C
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 08:20:25 +0000 (UTC)
Received: by mail-vs1-f51.google.com with SMTP id d25so10531768vsp.1
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 01:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ltv54OOOgcKhPoH7oRaigoXMRi+Z2QqH7bQ4dTNkEvU=;
 b=jDw793P/J1BufwDIqmsB6HyWGUNv4uDc8c/aO5fFrqX0etEVYWsq2A6YFR0MEZ/A4D
 GuAQwJIcaE1PMa+vvf8Z1qzGageRsH2jpCzDFVfufFj9Mukft9tHShv4HsdkU4RQ7wyS
 bOHgQQcFSexRjq0O859lKHkw3cIll8B4vNezG8A+0GM0T0pclGKq+Ve77uqtLq/KR/WR
 +d7UbqSWTTxkmhYQDyXS0w7JAoR9ps+bGtmLs97jWNnCQ28TfkA1pLKcTNbttCyO5vFN
 cVPbtowi+ilsuTbKurdDthBypexXzawhY/rGYYR6ynBattNqaaAIpBqL6ZnC6bO1gPw5
 bHJw==
X-Gm-Message-State: AOAM5308hqsSQ2zmI0vMYccwJAyGCCo/xoxXiI9YSVAelSJPat/STH+X
 uk6vnl3W6GEl/OGLS7OwEzLmMLbN0oUZcU1YuwU=
X-Google-Smtp-Source: ABdhPJw0QI7XOFx1TPnFrXWAlR/QW1v6zaWS/KnYbAtB/CEX2DsVVO2yNBv9r1VAA3kWmuOXuQwF2fQGH/J1go6B4oc=
X-Received: by 2002:a67:f503:: with SMTP id u3mr12373252vsn.3.1618820424835;
 Mon, 19 Apr 2021 01:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210419042722.27554-1-alice.guo@oss.nxp.com>
 <20210419042722.27554-2-alice.guo@oss.nxp.com>
In-Reply-To: <20210419042722.27554-2-alice.guo@oss.nxp.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Apr 2021 10:20:13 +0200
Message-ID: <CAMuHMdUbrPxtJ9DCP0_nFrReuuO4vFY2J79LrKY82D7bCOfzRw@mail.gmail.com>
Subject: Re: [RFC v1 PATCH 1/3] drivers: soc: add support for soc_device_match
 returning -EPROBE_DEFER
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: ulf.hansson@linaro.org, aymen.sghaier@nxp.com, geert+renesas@glider.be,
 rafael@kernel.org, airlied@linux.ie, mturquette@baylibre.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 a.hajda@samsung.com, netdev@vger.kernel.org, linux-phy@lists.infradead.org,
 will@kernel.org, linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 wim@linux-watchdog.org, herbert@gondor.apana.org.au, horia.geanta@nxp.com,
 khilman@baylibre.com, narmstrong@baylibre.com, linux-staging@lists.linux.dev,
 iommu@lists.linux-foundation.org, peter.ujfalusi@gmail.com, kishon@ti.com,
 tony@atomide.com, linux-omap@vger.kernel.org, stern@rowland.harvard.edu,
 kuba@kernel.org, linus.walleij@linaro.org, linux@roeck-us.net,
 linux-media@vger.kernel.org, linux-watchdog@vger.kernel.org,
 Roy.Pledge@nxp.com, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 edubezval@gmail.com, linux-gpio@vger.kernel.org,
 linux-mediatek@lists.infradead.org, ssantosh@kernel.org,
 matthias.bgg@gmail.com, linux-amlogic@lists.infradead.org, mchehab@kernel.org,
 linux-arm-kernel@lists.infradead.org, balbi@kernel.org, tomba@kernel.org,
 sboyd@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-mmc@vger.kernel.org, adrian.hunter@intel.com, robert.foss@linaro.org,
 leoyang.li@nxp.com, linux@prisktech.co.nz, vkoul@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-crypto@vger.kernel.org, daniel@ffwll.ch,
 j-keerthy@ti.com, dmaengine@vger.kernel.org, jyri.sarha@iki.fi,
 davem@davemloft.net
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

Hi Alice,

CC Arnd (soc_device_match() author)

On Mon, Apr 19, 2021 at 6:28 AM Alice Guo (OSS) <alice.guo@oss.nxp.com> wrote:
> From: Alice Guo <alice.guo@nxp.com>
>
> In i.MX8M boards, the registration of SoC device is later than caam
> driver which needs it. Caam driver needs soc_device_match to provide
> -EPROBE_DEFER when no SoC device is registered and no
> early_soc_dev_attr.

I'm wondering if this is really a good idea: soc_device_match() is a
last-resort low-level check, and IMHO should be made available early on,
so there is no need for -EPROBE_DEFER.

>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>

Thanks for your patch!

> --- a/drivers/base/soc.c
> +++ b/drivers/base/soc.c
> @@ -110,6 +110,7 @@ static void soc_release(struct device *dev)
>  }
>
>  static struct soc_device_attribute *early_soc_dev_attr;
> +static bool soc_dev_attr_init_done = false;

Do you need this variable?

>
>  struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr)
>  {
> @@ -157,6 +158,7 @@ struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr
>                 return ERR_PTR(ret);
>         }
>
> +       soc_dev_attr_init_done = true;
>         return soc_dev;
>
>  out3:
> @@ -246,6 +248,9 @@ const struct soc_device_attribute *soc_device_match(
>         if (!matches)
>                 return NULL;
>
> +       if (!soc_dev_attr_init_done && !early_soc_dev_attr)

if (!soc_bus_type.p && !early_soc_dev_attr)

> +               return ERR_PTR(-EPROBE_DEFER);
> +
>         while (!ret) {
>                 if (!(matches->machine || matches->family ||
>                       matches->revision || matches->soc_id))

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
