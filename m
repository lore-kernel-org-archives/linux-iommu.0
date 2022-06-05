Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637F0C43334
	for <iommu@archiver.kernel.org>; Sun,  5 Jun 2022 04:13:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0117A41854;
	Sun,  5 Jun 2022 04:13:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YDZCj9rSoDLc; Sun,  5 Jun 2022 04:13:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 776334179F;
	Sun,  5 Jun 2022 04:13:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49AECC0039;
	Sun,  5 Jun 2022 04:13:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34527C002D
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jun 2022 04:13:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 29C68845CC
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jun 2022 04:13:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GAhrkrsTqhDU for <iommu@lists.linux-foundation.org>;
 Sun,  5 Jun 2022 04:13:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 76970845C5
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jun 2022 04:13:20 +0000 (UTC)
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-2ff90e0937aso116069367b3.4
 for <iommu@lists.linux-foundation.org>; Sat, 04 Jun 2022 21:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2MjRSm5fzYQetqVlpQBYSrGfumNiB0ZrM39dLqOPrH4=;
 b=iruy/VIRmrmVkPQ3JLz43LdlgzYIIgIh0TbvAdWum+0Rddx+fvFvZL+AZmkeq14EM3
 EQj2TyKZKOx/AidEftZoePqY5YpO4cwMuitvB+yKPScFqtDTdzo5ldCi4OGAOk3+UFMp
 j/kBbn6KV51/XQkwn8o9tfq6LNjmHBZoctzSxwBUBFOQBY/6aPKKgU+LJpKUd4lxHOLC
 a3pKPoOaZ50Yav85+Htu9s5WpYjwMqsKV6ln5h3Ivwjaws5e9R7ngDvbV4Yh0sJleDX7
 vOAsHme5FRTkYJMFVoEn7Vce2+XgoAYlewVpVngjjzo07L1N3f9jaxvI2/N8fznw3lB9
 3viw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2MjRSm5fzYQetqVlpQBYSrGfumNiB0ZrM39dLqOPrH4=;
 b=1VlZhIh080g+JwikyyS2H2q5osNZqWf87IygnEhReD3t0bIYXClwBcDJMF+EGAHqn6
 rfcx1yh8WH/gjYpKUPXODwzycjXDEKrRATBzBs/iIMd5nFkr5NO8OAR5sYpTD5n1kaZA
 8ArBhQPoanqgTVaQUTtB1Obf8JgQf1XiYYw+sluRRpHZjUDkucX5srezY/pnb6rAsDah
 IspIwmERLyW1jupUALBpdWxTiBheYgOD1yZQfl8qmY/+1jVk8LwIJXNJk5LqYIdmCjEf
 ESiTCJb4Pll9MELclPsC7f89Q4xQqDf1WYIU+T2dEU4G16AlVOx6+4UMn6b9UMNt3/K4
 GBfQ==
X-Gm-Message-State: AOAM530FPqlAy7OEs4yJugmE9gu9touMFqbLDNWZ29HfaLpnYbrgZKoH
 3SC1BuIEYYBuxZBHfOiQ+TWfCpZ3snjdl03SB7PAOw==
X-Google-Smtp-Source: ABdhPJzUYcFQq7wQgnRsS9UvlhN43rSEgXe2PJa6kBJxtfcgg8d502Y2JGKc3riC3LG/Qxh1ZRmB7415nK5yWOq+ZK0=
X-Received: by 2002:a81:87c2:0:b0:2ff:c948:ae50 with SMTP id
 x185-20020a8187c2000000b002ffc948ae50mr19620905ywf.83.1654402399190; Sat, 04
 Jun 2022 21:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220526081550.1089805-1-saravanak@google.com>
 <20220526081550.1089805-5-saravanak@google.com>
 <CAMuHMdXcHcuAn8UVS6RPsfenuCny4BgWNJFod41CFjdOF+w0sg@mail.gmail.com>
 <CAGETcx_uXXw_OtHO+_2DmZnHA3WCT5CeKbb_RWNqZtZSU1OB2g@mail.gmail.com>
In-Reply-To: <CAGETcx_uXXw_OtHO+_2DmZnHA3WCT5CeKbb_RWNqZtZSU1OB2g@mail.gmail.com>
Date: Sat, 4 Jun 2022 21:12:43 -0700
Message-ID: <CAGETcx9=CQha3HyBmw1S2KS--Fqv_kGEKwyVT-GSQCT=Uxi0zQ@mail.gmail.com>
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

On Sat, Jun 4, 2022 at 8:18 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Mon, May 30, 2022 at 2:13 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Saravana,
> >
> > On Thu, May 26, 2022 at 10:16 AM Saravana Kannan <saravanak@google.com> wrote:
> > > This reverts commit 11f7e7ef553b6b93ac1aa74a3c2011b9cc8aeb61.
> >
> > scripts/chdeckpatch.pl says:
> >
> >     WARNING: Unknown commit id
> > '11f7e7ef553b6b93ac1aa74a3c2011b9cc8aeb61', maybe rebased or not
> > pulled?
> >
> > I assume this is your local copy of
> > https://lore.kernel.org/r/20220526034609.480766-3-saravanak@google.com?
>
> I somehow missed all your replies and noticed it just now.
>
> That commit should be based on driver-core-next.

My bad, it was indeed a local commit, but it's one I had already sent
to LKML. It's one of the 2 patches I asked to pull-in in the cover
letter. I'll fix this once I get some tests/reviews on this series or
if I need to send out a v3 series before that.

-Saravana
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
