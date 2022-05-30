Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49875C433F5
	for <iommu@archiver.kernel.org>; Mon, 30 May 2022 09:38:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EDC6F840E8;
	Mon, 30 May 2022 09:38:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rZ2ZFBBbU761; Mon, 30 May 2022 09:38:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C0EBC83E9B;
	Mon, 30 May 2022 09:38:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8104CC0032;
	Mon, 30 May 2022 09:38:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19A33C002D
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 09:38:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E796F41A09
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 09:38:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ay_9bk36vJMQ for <iommu@lists.linux-foundation.org>;
 Mon, 30 May 2022 09:38:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EAFB341959
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 09:38:21 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id x20so2823748qtp.8
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 02:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2eXMq1aM/7odJFSrV6FBn6WXqmOgMduOgC14zR4eCz0=;
 b=xA+uwu3X98Nk6FwbTlJh+JUrN1OLr7gugfaaFVRKhH0Zt+rW/98N9fJthKefB/hHjU
 h8bAihux6ELLojHqMuyT2vrvj960C91sKDL8UrmPTFUsyYheQUBuxTdO2eeUiYx2MAqQ
 rkR8X8EaXWm/AOsro9RpIgeuRameARelH0r48xne7XXJvq3N/qiVEl3oJ73OQC3HNDIi
 2VAtx7HaMAiO0MDNF1//Y3ZXMeO3MJYhH/AuPrdgCCtCuP8uL46HexJGZZNphZstgIZD
 LTNGgMU8gy4riYIXyN4Az6b4PmNUCZ/rNNYJZ4cyihWU0SvB3iGVmxhDiQCE+8JncNhy
 S6XQ==
X-Gm-Message-State: AOAM530TC2bRT6v8wi8DLr9ssegsAz4qIAFnKCaEPaYuh8Xg9wtN75qs
 Yl2cVA4SBS8dwKEwxZ09tAAiEG2ixl/ZKg==
X-Google-Smtp-Source: ABdhPJzWRT0W0Oaa8bRAWQbekKwl8TNmLcI4Ce9JI3Y78Yme0VLMDo3NaQk8eQhSwGYiUfa+IuAV1A==
X-Received: by 2002:a05:622a:1e12:b0:2f3:d254:45b7 with SMTP id
 br18-20020a05622a1e1200b002f3d25445b7mr43618311qtb.88.1653903500050; 
 Mon, 30 May 2022 02:38:20 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com.
 [209.85.128.180]) by smtp.gmail.com with ESMTPSA id
 b26-20020a05620a271a00b0069fe1fc72e7sm7352323qkp.90.2022.05.30.02.38.17
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 May 2022 02:38:18 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-306b5b452b1so71227787b3.1
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 02:38:17 -0700 (PDT)
X-Received: by 2002:a81:2143:0:b0:2fb:1274:247e with SMTP id
 h64-20020a812143000000b002fb1274247emr56723516ywh.384.1653903497533; Mon, 30
 May 2022 02:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220526081550.1089805-1-saravanak@google.com>
In-Reply-To: <20220526081550.1089805-1-saravanak@google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 May 2022 11:38:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW+Dmi9g=Cw9g5vOa9iYRA+L_ujU9C1-j0eKE7u3EmcFQ@mail.gmail.com>
Message-ID: <CAMuHMdW+Dmi9g=Cw9g5vOa9iYRA+L_ujU9C1-j0eKE7u3EmcFQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/9] deferred_probe_timeout logic clean up
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

On Thu, May 26, 2022 at 10:15 AM Saravana Kannan <saravanak@google.com> wrote:
> This series is based on linux-next + these 2 small patches applies on top:
> https://lore.kernel.org/lkml/20220526034609.480766-1-saravanak@google.com/
>
> A lot of the deferred_probe_timeout logic is redundant with
> fw_devlink=on.  Also, enabling deferred_probe_timeout by default breaks
> a few cases.
>
> This series tries to delete the redundant logic, simplify the frameworks
> that use driver_deferred_probe_check_state(), enable
> deferred_probe_timeout=10 by default, and fixes the nfsroot failure
> case.
>
> Patches 1 to 3 are fairly straightforward and can probably be applied
> right away.
>
> Patches 4 to 9 are related and are the complicated bits of this series.
>
> Patch 8 is where someone with more knowledge of the IP auto config code
> can help rewrite the patch to limit the scope of the workaround by
> running the work around only if IP auto config fails the first time
> around. But it's also something that can be optimized in the future
> because it's already limited to the case where IP auto config is enabled
> using the kernel commandline.

Thanks for your series!

> Yoshihiro/Geert,
>
> If you can test this patch series and confirm that the NFS root case
> works, I'd really appreciate that.

On Salvator-XS, Micrel KSZ9031 Gigabit PHY probe is no longer delayed
by 9s after applying the two earlier patches, and the same is true
after applying this series on top.
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

I will do testing on more boards, but that may take a while, as we're
in the middle of the merge window.

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
