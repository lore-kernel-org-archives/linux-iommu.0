Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B65C43334
	for <iommu@archiver.kernel.org>; Sun,  5 Jun 2022 03:19:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E43FC41989;
	Sun,  5 Jun 2022 03:19:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8ysWem0ZKrU3; Sun,  5 Jun 2022 03:19:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A562F41982;
	Sun,  5 Jun 2022 03:19:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8114AC0032;
	Sun,  5 Jun 2022 03:19:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18899C002D
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jun 2022 03:19:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ED19A6121E
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jun 2022 03:19:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2PSHA2ogFNRK for <iommu@lists.linux-foundation.org>;
 Sun,  5 Jun 2022 03:19:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 002BB6121B
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jun 2022 03:19:05 +0000 (UTC)
Received: by mail-yb1-xb30.google.com with SMTP id v106so20264886ybi.0
 for <iommu@lists.linux-foundation.org>; Sat, 04 Jun 2022 20:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UfT4MT7hJVtHg40L/hP1ZN+BqXhrFP6Eg8QB85TqDmI=;
 b=i4t+Zbfv9mgXoHmCp9WTiqZCYX0GPYXzZmsD7L8UxzBPLZkybag0506qJXluqZw/9W
 8o266yL6KiXkLkyDgqNuLuhJo8T+pJg8OYLe27e7FK62LjwxkXtDSdOJhS0pc3IxzEK5
 3GD2dGw+8hVLPviz3mfNjR5XGZaOpWX4m78WG0B6uXq+MhadcayD4wPCAe+mCs0Zvy8S
 4EEQcXrvjcBI9t8m7eTvR3JmMquehZ3UV7MeQzmcQjE83SWx2Ppbi+Lsf1ZuzNYM2zqv
 qlnyYJUZ1wh9prgSQgcuZ9+WXsoJ3byzi+kzLzwt6CuS+LIitH8zkGQSOkK3pLyH86Er
 Eghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UfT4MT7hJVtHg40L/hP1ZN+BqXhrFP6Eg8QB85TqDmI=;
 b=53weNxw1OSEagJ+AB5NHdBbttDM6rviBnOLMsqyNrDZX27TZxLdBUJ1vz+gFIEo616
 y6Zqda4SMu7RptrpqKwGjelTdDIhrW4ob78R9bAZirjb7OKrCE6C12m7Ip2ROlTFRllG
 cmVUWhf5V63RPz4ukvcswCYp68vjFuRC9zlQlh/5dJFLqsf6xIGSYG6uDGzrXgiFdebn
 TchWe5ooPkjcfjADAJq64JMQxsfguyi8DGP8cZrRLgjo4wMvEeVkQMbBR+9u7W6hs27D
 s4bNldCz5iNWGuX202Ir78WDQBtuY1++h2qU+dhz/2ANTuaTgFNzk7K5RczZoH22bHma
 Q7ZA==
X-Gm-Message-State: AOAM533a1CrDbgscWThBPE03Uk6TgYbYuXoOx3K9dhB+61++kNLmLFZQ
 nsi/dK2ccInLP4gxf/Tn0sM/+T4K0XlPpYXmyq7SeQ==
X-Google-Smtp-Source: ABdhPJxrTqtLCQjIW3xp8nX5d6NuEspl0eOAd6/G2L9YHazcgkJ4hRf6Qyt8EmRCHMgQo+I/rvstQNfNmIYyfaK+Hd4=
X-Received: by 2002:a25:d803:0:b0:663:3da5:9813 with SMTP id
 p3-20020a25d803000000b006633da59813mr5189333ybg.530.1654399144708; Sat, 04
 Jun 2022 20:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220526081550.1089805-1-saravanak@google.com>
 <20220526081550.1089805-5-saravanak@google.com>
 <CAMuHMdXcHcuAn8UVS6RPsfenuCny4BgWNJFod41CFjdOF+w0sg@mail.gmail.com>
In-Reply-To: <CAMuHMdXcHcuAn8UVS6RPsfenuCny4BgWNJFod41CFjdOF+w0sg@mail.gmail.com>
Date: Sat, 4 Jun 2022 20:18:28 -0700
Message-ID: <CAGETcx_uXXw_OtHO+_2DmZnHA3WCT5CeKbb_RWNqZtZSU1OB2g@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/9] Revert "driver core: Set default
 deferred_probe_timeout back to 0."
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

On Mon, May 30, 2022 at 2:13 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Thu, May 26, 2022 at 10:16 AM Saravana Kannan <saravanak@google.com> wrote:
> > This reverts commit 11f7e7ef553b6b93ac1aa74a3c2011b9cc8aeb61.
>
> scripts/chdeckpatch.pl says:
>
>     WARNING: Unknown commit id
> '11f7e7ef553b6b93ac1aa74a3c2011b9cc8aeb61', maybe rebased or not
> pulled?
>
> I assume this is your local copy of
> https://lore.kernel.org/r/20220526034609.480766-3-saravanak@google.com?

I somehow missed all your replies and noticed it just now.

That commit should be based on driver-core-next.

-Saravana

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
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
