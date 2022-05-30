Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2EAC433FE
	for <iommu@archiver.kernel.org>; Mon, 30 May 2022 09:13:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F06FD41823;
	Mon, 30 May 2022 09:13:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id av-eoHhnNuma; Mon, 30 May 2022 09:13:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8D88441806;
	Mon, 30 May 2022 09:13:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4ACFAC0032;
	Mon, 30 May 2022 09:13:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A4AFC002D
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 09:13:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 30D6260E72
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 09:13:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ENUB2VSZ9RUN for <iommu@lists.linux-foundation.org>;
 Mon, 30 May 2022 09:13:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 72EE46080A
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 09:13:01 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id j2so2385738qvp.9
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 02:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CevRGTtrDTs4Z7bTQdrqHWG/lWL6b5bSowmXhMt2lks=;
 b=24ZxrE97yyRwFFLBgGeqT43vwX9/ERBGkK6Jg1Gopn4ygk5oSaJ5LbSLFdglSrancO
 76a28VpMh1oYcJxLcivanmnEes6LIctxMJu4KJbAZNu5S++4jFNBYsvvRu/PvCHILOkT
 O6yeMcjG7tIm/juZLvi1hnUmfBm+c430WwSHfwzghadD43U3F+qB2xt2DoP3p04gZhzP
 cqQMbobf/G/WtcVYGOsHbeIwvN0zVBeHSYuzYG8noQHTopdbFTV/YEgeRNR/cSLkvptG
 UXZc8eKG58xv9A7zD1Onj5I1y21mYgI7sQvQAj+V8Lsr0jlQd4FzAExgkSYBYb3VCMdX
 jTOQ==
X-Gm-Message-State: AOAM532wdA4OJ5tGOLBeS+AKakl13co48Ry+JjoG1l96W+6Va/png4kG
 /dKB8DvORLVw9jDmMX+i8hJAIam6EPgJWw==
X-Google-Smtp-Source: ABdhPJwX/PqDwsF30FsLKITvuzZ5cLhRbMSB02aEYR2H8jv1D/9yOGh79l9c4xrjcPKIKgwOdVAyNg==
X-Received: by 2002:a05:6214:29cd:b0:464:4ffa:bfb8 with SMTP id
 gh13-20020a05621429cd00b004644ffabfb8mr3257984qvb.34.1653901980429; 
 Mon, 30 May 2022 02:13:00 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com.
 [209.85.219.178]) by smtp.gmail.com with ESMTPSA id
 25-20020a05620a079900b006a39e915252sm7061413qka.97.2022.05.30.02.12.57
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 May 2022 02:12:58 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id l204so7316905ybf.10
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 02:12:57 -0700 (PDT)
X-Received: by 2002:a05:6902:905:b0:64a:2089:f487 with SMTP id
 bu5-20020a056902090500b0064a2089f487mr53259449ybb.202.1653901976605; Mon, 30
 May 2022 02:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220526081550.1089805-1-saravanak@google.com>
 <20220526081550.1089805-5-saravanak@google.com>
In-Reply-To: <20220526081550.1089805-5-saravanak@google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 May 2022 11:12:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXcHcuAn8UVS6RPsfenuCny4BgWNJFod41CFjdOF+w0sg@mail.gmail.com>
Message-ID: <CAMuHMdXcHcuAn8UVS6RPsfenuCny4BgWNJFod41CFjdOF+w0sg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/9] Revert "driver core: Set default
 deferred_probe_timeout back to 0."
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

On Thu, May 26, 2022 at 10:16 AM Saravana Kannan <saravanak@google.com> wrote:
> This reverts commit 11f7e7ef553b6b93ac1aa74a3c2011b9cc8aeb61.

scripts/chdeckpatch.pl says:

    WARNING: Unknown commit id
'11f7e7ef553b6b93ac1aa74a3c2011b9cc8aeb61', maybe rebased or not
pulled?

I assume this is your local copy of
https://lore.kernel.org/r/20220526034609.480766-3-saravanak@google.com?

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
