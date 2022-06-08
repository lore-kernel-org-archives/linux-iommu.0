Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E81C433EF
	for <iommu@archiver.kernel.org>; Wed,  8 Jun 2022 23:15:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 869C0417A7;
	Wed,  8 Jun 2022 23:15:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TukCsHUb1NF5; Wed,  8 Jun 2022 23:15:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 139C64177F;
	Wed,  8 Jun 2022 23:15:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0A8EC0032;
	Wed,  8 Jun 2022 23:15:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39B4AC002D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 23:15:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 224F283396
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 23:15:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4jD1oc7FMSRU for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 23:15:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 16A8E83386
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 23:15:44 +0000 (UTC)
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-3137c877092so24698607b3.13
 for <iommu@lists.linux-foundation.org>; Wed, 08 Jun 2022 16:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5dm3ORkewVvScpNnTHAWD0lWUpKHv8ZP9Eg12POa/hY=;
 b=s8ajev8ylc24lWL+uVn0aQqBmKLBXSt4qhwBZySWYs06ap1dTsQm6yNKQo5ZZk1Ttw
 CogFfnoV9WalwlDwJZQwIzhS53XYG0TnpLr6RaCiWz52oS8Ya2rxty3/51rSjmJayx7c
 EWdKZF1ai138Psl2FvsA3fb81ZOFaNvnMqn373Non4bghec4LDcPh888h9mpuh/1unnN
 f9dX3yfRPbSr2zW6HLeQ/tEvTedV0nhIrv0QdBSD7AwR10AtUBj/yefZJX+LJ+vEpqtI
 mz7ygzZjwLzaYvbU7IBn1tdY8nY9jEOw6ZGRU2lMtt4y+nfEmnlgAfeCbdWY91a6rwLO
 KGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5dm3ORkewVvScpNnTHAWD0lWUpKHv8ZP9Eg12POa/hY=;
 b=v4iXIXfw1JZECOuY/NQbmrBigqoCzuOBwfyTpJvUjpyZRQsbBpKUvzBWkKjm+IemfQ
 pRDI3FDmwfNaGHPvgwww6AlEnkSpk0A2i/vIQ3JmtrwNcFcgiapSNtQ+2Ky70ilBa2YD
 PkipZQX79a4Pb+/LRNhpOh8EHcz7e2CyLayuQQSqf3ElZMhSqKya2ZAl296NHahDVkiX
 cpfoGr/HWSg63hNebQwAW7qc9tSwitCL5EX0q4sxWGU5JzjG+z3tIRAht2/8NaQkkc0P
 wvvM9pF+05blCiyqRQvE9hY1n4EU82pZ7D6wAenzjVs4hrjKRJwMEhmopyUjG0BS1Rpk
 BGmg==
X-Gm-Message-State: AOAM533BzZJqznwO+hlg+Ch+6XT/6AMsHrCXksEw2LTMxIuzOh1TZZ+s
 3Hk0xK1F0rq9N1ltvqzJK8rciVlRUsslJvjbXtLjeA==
X-Google-Smtp-Source: ABdhPJydbDnoddm1zrWGAsHzuwqdddTQzuodu0O1Gb1JEUm33YqJ1CQ0JnoMmfFGzaJs2LsBc2KxBacSkdprXywkGyo=
X-Received: by 2002:a81:1a4c:0:b0:30c:8363:e170 with SMTP id
 a73-20020a811a4c000000b0030c8363e170mr38925926ywa.455.1654730143827; Wed, 08
 Jun 2022 16:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
 <CAMuHMdXkX-SXtBuTRGJOUnpw9goSP6RFr_PTt_3w_yWgBpWsqg@mail.gmail.com>
 <CAGETcx9f0UBhpp6dM+KJwtYpLx19wwsq6_ygi3En7FrXobOSpA@mail.gmail.com>
 <CAGETcx8VM+xOCe7HEx9FUU-1B9nrX8Q=tE=NjTyb9uX2_8RXLQ@mail.gmail.com>
 <CAMuHMdXzu8Vp=a7fyjOB=xt04aee=vWXV=TcRZeeKUGYFFZ1CA@mail.gmail.com>
 <CAGETcx_Nqo4ju7cWwO3dP3YM2wpCb0jx23OHOReexOjpT5pATA@mail.gmail.com>
 <CAMuHMdXQCwMQj_ZiOBAzusdCxd8w6NbTqD_7nzykhVs+UWx8Gw@mail.gmail.com>
 <CAGETcx8UO=4mk31tU4QaWU3RaNM_myA9woe0idBp6p7+X5AEgg@mail.gmail.com>
 <20220608154908.4ddb9795@kernel.org>
In-Reply-To: <20220608154908.4ddb9795@kernel.org>
Date: Wed, 8 Jun 2022 16:15:07 -0700
Message-ID: <CAGETcx_ZPB2ce-7Zf-bVy4hHe8Nvk62_7HVeO1dhQvg1iuHQDw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] deferred_probe_timeout logic clean up
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 Thomas Bogendoerfer <tbogendoerfer@suse.de>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Paolo Abeni <pabeni@redhat.com>,
 Android Kernel Team <kernel-team@android.com>, Len Brown <len.brown@intel.com>,
 Linux PM list <linux-pm@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
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
From: Saravana Kannan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Jun 8, 2022 at 3:49 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 8 Jun 2022 14:07:44 -0700 Saravana Kannan wrote:
> > David/Jakub,
> >
> > Do the IP4 autoconfig changes look reasonable to you?
>
> I'm no expert in this area, I'd trust the opinion of the embedded folks
> (adding Florian as well) more than myself.

Thanks.

> It's unclear to me why we'd
> wait_for_init_devices_probe() after the first failed iteration,

wait_for_init_devices_probe() relaxes ordering rules for all devices
and it's not something we want to do unless we really need it. That's
why we are doing that only if we can't find any network device in the
first iteration.

> sleep,
> and then allow 11 more iterations with wait_for_device_probe().
> Let me also add Thomas since he wrote e2ffe3ff6f5e ("net: ipconfig:
> Wait for deferred device probes").

Even without this change, I'm not sure the wait_for_device_probe()
needs to be within the loop. It's probably sufficient to just do it
once in the beginning, but it's already there and I'm not sure if I'm
missing some scenarios, so I left that part as is.

-Saravana
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
