Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4FEC433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 18:17:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D132D61429;
	Thu, 23 Jun 2022 18:17:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D132D61429
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=HJ6V5dP4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gfBE_xMj1Mh9; Thu, 23 Jun 2022 18:17:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 675E160A73;
	Thu, 23 Jun 2022 18:17:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 675E160A73
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1580FC0032;
	Thu, 23 Jun 2022 18:17:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDE17C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 18:17:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9023840474
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 18:17:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9023840474
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20210112 header.b=HJ6V5dP4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o7nzoj3R1H6K for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 18:17:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4C4EB401A1
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4C4EB401A1
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 18:17:41 +0000 (UTC)
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-3176b6ed923so2228397b3.11
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 11:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p5I7lwaxg3ERNdh1USCLL4gsDNHBsesSwjbd6s/cNSY=;
 b=HJ6V5dP4AOSSwMe7wcgfuDX/clqSs9gbT7weCDHIdQMoMq/tOG9jM9s9f0AVeRDeGC
 6i5p1kAgTQDU+NkxVXG7PAUzfambG55P1F4tcUrSXCH+tWquWb0GtqXEg+nA8Dchanzn
 HRW1WDYo5QE/5U8e3rDPy8HatPAjphhwWyXIsW7bt1MI5QLeN/88pxyeRjlGf5flDm1D
 YFJuq5/ejD0Xbcv02GN2um3+I2gA0lfF+XZedqX37LXzCxA7LGwtr/E9d95mnlTXfr5z
 bsQ/MyVF23+eCsn7mS+xZwrqAGSVGxeXvWRjd8N+eXvQsslukdaOR7K9u2E0eGYmGLYO
 oqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p5I7lwaxg3ERNdh1USCLL4gsDNHBsesSwjbd6s/cNSY=;
 b=GTolP6j9NrP1cD2sYVdk50WAfukiRXEwxeZyLRzKaMnIR9x1sPR0wOhTbwcvzBvP3A
 HD/W7yObFoXB1egiAcc3z5MoyIyEgx6td8PoPkd5ftxhMm5MoILxJOFo0Y/+a5KwLWBE
 /zWnfvlzISO3/9fQHwsMi9DbclfhRjFQ6J8qpAptIjOtPEvtgSFZ7gFLnOzchGloyuko
 KEVTVOE4gTtUdrqdRYLWPknrsrUpTaaNouI5/3i2OunMFZ1YYXTui34yahUFZO5ktxPw
 49P0pu3czLfhBSK0ZMm4BEDQuasfdF7F98yObIxJgnTNtbmvB183fnxz7+FKBMz0a+ZT
 O/Lg==
X-Gm-Message-State: AJIora+XnMUXXkkkuDNSp181ovXW9h4IeTueOFI0vWh6RnOGEVQO6ZYf
 NpUX2eEzzSo7JoUUIcSEW833UJQvx35c72vMg3peVg==
X-Google-Smtp-Source: AGRyM1uilfZ0qukZAX74cZpSq2rgoRk3U9n8kYZfj2P22qz/S+S3tWRG5TkEZw7C9nYFw+KJ3ktelnjUqr/SV5UBD5M=
X-Received: by 2002:a81:4896:0:b0:317:f767:95f8 with SMTP id
 v144-20020a814896000000b00317f76795f8mr12660216ywa.218.1656008259994; Thu, 23
 Jun 2022 11:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220623080344.783549-1-saravanak@google.com>
 <20220623080344.783549-3-saravanak@google.com>
 <20220623100421.GY1615@pengutronix.de>
 <CAGETcx_eVkYtVX9=TOKnhpP2_ZpJwRDoBye3i7ND2u5Q-eQfPg@mail.gmail.com>
 <ec4168b6-36f1-0183-b1ed-6a33d9fa1bbc@pengutronix.de>
In-Reply-To: <ec4168b6-36f1-0183-b1ed-6a33d9fa1bbc@pengutronix.de>
Date: Thu, 23 Jun 2022 11:17:03 -0700
Message-ID: <CAGETcx9ytCwrYUbS2PpuaCSyGq60HbWJexatv74Zz3qk973wmg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] of: base: Avoid console probe delay when
 fw_devlink.strict=1
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: andrew lunn <andrew@lunn.ch>, peng fan <peng.fan@nxp.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 linus walleij <linus.walleij@linaro.org>, ulf hansson <ulf.hansson@linaro.org>,
 eric dumazet <edumazet@google.com>, pavel machek <pavel@ucw.cz>,
 Frank Rowand <frowand.list@gmail.com>, sascha hauer <sha@pengutronix.de>,
 kevin hilman <khilman@kernel.org>, will deacon <will@kernel.org>,
 russell king <linux@armlinux.org.uk>, linux-acpi@vger.kernel.org,
 jakub kicinski <kuba@kernel.org>, paolo abeni <pabeni@redhat.com>,
 kernel-team@android.com, Len Brown <lenb@kernel.org>,
 len brown <len.brown@intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>,
 linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 hideaki yoshifuji <yoshfuji@linux-ipv6.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 david ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org,
 Daniel Scally <djrscally@gmail.com>, iommu@lists.linux-foundation.org,
 kernel@pengutronix.de, netdev@vger.kernel.org,
 "david s. miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
 heiner kallweit <hkallweit1@gmail.com>
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

On Thu, Jun 23, 2022 at 10:36 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello Saravana,
>
> On 23.06.22 19:26, Saravana Kannan wrote:
> > On Thu, Jun 23, 2022 at 3:05 AM sascha hauer <sha@pengutronix.de> wrote:
> >>
> >> On Thu, Jun 23, 2022 at 01:03:43AM -0700, Saravana Kannan wrote:
> >>> Commit 71066545b48e ("driver core: Set fw_devlink.strict=1 by default")
> >>> enabled iommus and dmas dependency enforcement by default. On some
> >>> systems, this caused the console device's probe to get delayed until the
> >>> deferred_probe_timeout expires.
> >>>
> >>> We need consoles to work as soon as possible, so mark the console device
> >>> node with FWNODE_FLAG_BEST_EFFORT so that fw_delink knows not to delay
> >>> the probe of the console device for suppliers without drivers. The
> >>> driver can then make the decision on where it can probe without those
> >>> suppliers or defer its probe.
> >>>
> >>> Fixes: 71066545b48e ("driver core: Set fw_devlink.strict=1 by default")
> >>> Reported-by: Sascha Hauer <sha@pengutronix.de>
> >>> Reported-by: Peng Fan <peng.fan@nxp.com>
> >>> Signed-off-by: Saravana Kannan <saravanak@google.com>
> >>> Tested-by: Peng Fan <peng.fan@nxp.com>
> >>> ---
> >>>  drivers/of/base.c | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/drivers/of/base.c b/drivers/of/base.c
> >>> index d4f98c8469ed..a19cd0c73644 100644
> >>> --- a/drivers/of/base.c
> >>> +++ b/drivers/of/base.c
> >>> @@ -1919,6 +1919,8 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
> >>>                       of_property_read_string(of_aliases, "stdout", &name);
> >>>               if (name)
> >>>                       of_stdout = of_find_node_opts_by_path(name, &of_stdout_options);
> >>> +             if (of_stdout)
> >>> +                     of_stdout->fwnode.flags |= FWNODE_FLAG_BEST_EFFORT;
> >>
> >> The device given in the stdout-path property doesn't necessarily have to
> >> be consistent with the console= parameter. The former is usually
> >> statically set in the device trees contained in the kernel while the
> >> latter is dynamically set by the bootloader. So if you change the
> >> console uart in the bootloader then you'll still run into this trap.
> >>
> >> It's problematic to consult only the device tree for dependencies. I
> >> found several examples of drivers in the tree for which dma support
> >> is optional. They use it if they can, but continue without it when
> >> not available. "hwlock" is another property which consider several
> >> drivers as optional. Also consider SoCs in early upstreaming phases
> >> when the device tree is merged with "dmas" or "hwlock" properties,
> >> but the corresponding drivers are not yet upstreamed. It's not nice
> >> to defer probing of all these devices for a long time.
> >>
> >> I wonder if it wouldn't be a better approach to just probe all devices
> >> and record the device(node) they are waiting on. Then you know that you
> >> don't need to probe them again until the device they are waiting for
> >> is available.
> >
> > That actually breaks things in a worse sense. There are cases where
> > the consumer driver is built in and the optional supplier driver is
> > loaded at boot. Without fw_devlink and the deferred probe timeout, we
> > end up probing the consumer with limited functionality. With the
> > current setup, sure we delay some probes a bit but at least everything
> > works with the right functionality. And you can reduce or remove the
> > delay if you want to optimize it.
>
> I have a system that doesn't use stdout-path and has the bootloader
> set console= either to ttynull when secure booting or to an UART
> when booting normally. How would I optimize the kernel to avoid
> my UART being loaded after DMA controller probe without touching
> the bootloader?
>

Thanks for the report Ahmad. I think someone else reported a similar
thing in another thread. I plan to take a look at it. It should be
possible to find the device and set the flag for those devices too.

-Saravana
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
