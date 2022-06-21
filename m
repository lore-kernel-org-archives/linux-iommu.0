Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880B2C433EF
	for <iommu@archiver.kernel.org>; Tue, 21 Jun 2022 19:34:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 052EC60BBA;
	Tue, 21 Jun 2022 19:34:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 052EC60BBA
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=hs0LBDjD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OR5IGH6jbqHB; Tue, 21 Jun 2022 19:34:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4B5A761071;
	Tue, 21 Jun 2022 19:34:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4B5A761071
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23E62C0032;
	Tue, 21 Jun 2022 19:34:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80B85C002D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 19:34:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5B71141A1F
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 19:34:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5B71141A1F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20210112 header.b=hs0LBDjD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M9F5JQN_CeEe for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 19:34:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 82F5A417D1
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 82F5A417D1
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 19:34:41 +0000 (UTC)
Received: by mail-yb1-xb32.google.com with SMTP id i15so21384499ybp.1
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 12:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GXndJbSr9Ys4cj6udGMJGPkAdQ+tLqQg3olnN64ieEQ=;
 b=hs0LBDjDT9OlV72N7fBe49gCxiWYUZOxcBIws2Wgn8BN3WqTsnKUdVz0Q6ampLmXSV
 5NkiSMbN9ezJtAmWUjyXVIOyvmB3tJWzCQSXBR+AO4tHEKCswdhBhhSG3vkBJZtJUVht
 3JKyU0RJ2Ra5mCUJKBEJL8bG3wIYavBkn/AC2/Ch3FvXau57I9pfQARkPbGSgaJEoyGe
 lTYcqa0zN/847nKzFl1WJjYqvmR1XHqpgkTYKwx4e2Qa8R6Ns1pVO3swtmqqCxrKN2V9
 Bfty4fIeIEEKkVxTaMUi8q3bxkgjiWSJm0iXnvkRaHi2W0O9dPMwDc0y+T+TfR/UJ6Ei
 2AEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GXndJbSr9Ys4cj6udGMJGPkAdQ+tLqQg3olnN64ieEQ=;
 b=JZyKFJMJrP71be+dbmGmWZNZqhh4IlszFJBkWS3X1tqnN5aVMAuO5xtBvvgLVmg7+G
 ti3SiCzJOM4bw3cHQyJNGa1UaarVLbLfAV+v/nMPKVKJKBl2KXte86BRavReM2g/aiFB
 6DKlO0KqHWSXt6x769MwhxTfjSrhlNiU+Dw8uAQZSTJhpyRoM3tUfsCj+q+KrQVTpSRP
 NZobk7Fc6e+tuTQZAQF6wW630x+EQdEb6mTLQpbjdhmBNQIuYKGzbYEjf0Qu52glv6p/
 YhHEzXvsFeReGgOLBLgqzbVSEY2OwlT6hXbY9+MVBhMo5J53IvSrxp+NaYKG6KGufpoM
 VB5A==
X-Gm-Message-State: AJIora+rAmpMk9XV0QgaaA+7HXG5iIJyDAN10Bb9X+iBXGnou2W0AoFu
 BmfWi5zGytwR3f6gmdV/dzwFjoPeY7nHj9KXugiBnw==
X-Google-Smtp-Source: AGRyM1u+tZKGrSW1cGi362mrQj+GEMsoaxrv0rYK4Hl9mC2GWlTK9NyKv5qqlRv1HupVfSdChNkUORkFSlefFHsLXRY=
X-Received: by 2002:a25:9947:0:b0:663:ec43:61eb with SMTP id
 n7-20020a259947000000b00663ec4361ebmr32241009ybo.115.1655840080076; Tue, 21
 Jun 2022 12:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
 <20220601070707.3946847-2-saravanak@google.com> <YrFzK6EiVvXmzVG6@atomide.com>
In-Reply-To: <YrFzK6EiVvXmzVG6@atomide.com>
Date: Tue, 21 Jun 2022 12:34:03 -0700
Message-ID: <CAGETcx_1USPRbFKV5j00qkQ-QXJkp7=FAfnFcfiNnM4J5KF1cQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] PM: domains: Delete usage of
 driver_deferred_probe_check_state()
To: Tony Lindgren <tony@atomide.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, kernel-team@android.com,
 Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
 linux-gpio@vger.kernel.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
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

On Tue, Jun 21, 2022 at 12:28 AM Tony Lindgren <tony@atomide.com> wrote:
>
> Hi,
>
> * Saravana Kannan <saravanak@google.com> [700101 02:00]:
> > Now that fw_devlink=on by default and fw_devlink supports
> > "power-domains" property, the execution will never get to the point
> > where driver_deferred_probe_check_state() is called before the supplier
> > has probed successfully or before deferred probe timeout has expired.
> >
> > So, delete the call and replace it with -ENODEV.
>
> Looks like this causes omaps to not boot in Linux next.

Can you please point me to an example DTS I could use for debugging
this? I'm assuming you are leaving fw_devlink=on and not turning it
off or putting it in permissive mode.

> With this
> simple-pm-bus fails to probe initially as the power-domain is not
> yet available.

Before we get to late_initcall(), I'd expect this series to not have
any impact because both fw_devlink and
driver_deferred_probe_check_state() should be causing the device's
probe to get deferred until the PM domain device comes up.

To double check this, without this series, can you give me the list of
"supplier:*" symlinks under a simple-pm-bus device's sysfs folder
that's having problems with this series? And for all those symlinks,
cat the "status" file under that directory?

In the system where this is failing, is the PM domain driver loaded as
a module at a later point?

Couple of other things to try (with the patches) to narrow this down:
* Can you set driver_probe_timeout=0 in the command line and see if that helps?
* Can you set it to something high like 30 or even larger and see if it helps?

> On platform_probe() genpd_get_from_provider() returns
> -ENOENT.

This error is with the series I assume?

> Seems like other stuff is potentially broken too, any ideas on
> how to fix this?

I'll want to understand the issue first. It's not yet clear to me why
fw_devlink isn't blocking the probe of the simple-pm-bus device until
the PM domain device shows up. And if it is not blocking, then why and
at what point in boot it's giving up and letting the probe get to this
point where there's an error.

-Saravana

>
>
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/power/domain.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 739e52cd4aba..3e86772d5fac 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -2730,7 +2730,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
> >               mutex_unlock(&gpd_list_lock);
> >               dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
> >                       __func__, PTR_ERR(pd));
> > -             return driver_deferred_probe_check_state(base_dev);
> > +             return -ENODEV;
> >       }
> >
> >       dev_dbg(dev, "adding to PM domain %s\n", pd->name);
> > --
> > 2.36.1.255.ge46751e96f-goog
> >
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
