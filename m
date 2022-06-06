Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E91C433EF
	for <iommu@archiver.kernel.org>; Mon,  6 Jun 2022 10:19:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 644EF83033;
	Mon,  6 Jun 2022 10:19:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UUxMGdqra6uU; Mon,  6 Jun 2022 10:19:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3535A827C9;
	Mon,  6 Jun 2022 10:19:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07EE7C0039;
	Mon,  6 Jun 2022 10:19:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E43D0C002D
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 10:19:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C4FB2828B3
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 10:19:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wI7D6BtAeF1o for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 10:19:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EC4A6827C9
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 10:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654510788; x=1686046788;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=XkXW18DsxASgWy3W6vVrSfD8C2RLZ7Hhaeol5XaMazA=;
 b=RC4KGxyQ/MvWN7OiaYUG2zLhZjsR9fHBp6+PNgJkXIkZQOm94EjKz10s
 7vZPidN53t/kzOnWiY+u0NWYLlh8vhnid+6+jBFORiTmcITrOi5umcf48
 jhJUkHy3NxqfBK2kWA2TOnRQfn+PnBMnNH/h9TTvv2y3OREidp5pppe7H
 ZGh94vE9CAh4Oi3StivXNN+XQKBrK/ygECIGDzOq6RfpuoKZ/7aMMJIPU
 e+xgaDsH61b+zVKSDHy4jx7nlrSnrIb+XZF4vG336LksWcufUk1ZI4ycN
 9o0YG1VuhxSan/pNVdkd2pqBzms9//lRFJrrUGxjV+utheR+wuu5RpwQ/ Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="339889990"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; d="scan'208";a="339889990"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2022 03:19:48 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; d="scan'208";a="647476480"
Received: from smile.fi.intel.com ([10.237.72.54])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2022 03:19:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1ny9nZ-000UYV-54; Mon, 06 Jun 2022 13:17:25 +0300
Date: Mon, 6 Jun 2022 13:17:24 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Saravana Kannan <saravanak@google.com>
Subject: Re: [RFC PATCH v1 2/9] pinctrl: devicetree: Delete usage of
 driver_deferred_probe_check_state()
Message-ID: <Yp3UNAW5Zv+RjabA@smile.fi.intel.com>
References: <20220526081550.1089805-1-saravanak@google.com>
 <20220526081550.1089805-3-saravanak@google.com>
 <CAMuHMdV4Uzfg8aBY=tKnRcig=Npebd158J7UK3zg5_DtHwAR5w@mail.gmail.com>
 <CAGETcx-=kAJp282OvG4yd830fhQowN7-yXifERqiHRi2w0bGFw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGETcx-=kAJp282OvG4yd830fhQowN7-yXifERqiHRi2w0bGFw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>,
 John Stultz <jstultz@google.com>, Pavel Machek <pavel@ucw.cz>,
 Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
 Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Android Kernel Team <kernel-team@android.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
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

On Sat, Jun 04, 2022 at 08:41:01PM -0700, Saravana Kannan wrote:
> On Mon, May 30, 2022 at 2:22 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, May 26, 2022 at 10:16 AM Saravana Kannan <saravanak@google.com> wrote:
> > > Now that fw_devlink=on by default and fw_devlink supports
> > > "pinctrl-[0-8]" property, the execution will never get to the point
> >
> > 0-9?
> >
> > oh, it's really 0-8:
> >
> >     drivers/of/property.c:DEFINE_SIMPLE_PROP(pinctrl0, "pinctrl-0", NULL)
> >     drivers/of/property.c:DEFINE_SIMPLE_PROP(pinctrl1, "pinctrl-1", NULL)
> >     drivers/of/property.c:DEFINE_SIMPLE_PROP(pinctrl2, "pinctrl-2", NULL)
> >     drivers/of/property.c:DEFINE_SIMPLE_PROP(pinctrl3, "pinctrl-3", NULL)
> >     drivers/of/property.c:DEFINE_SIMPLE_PROP(pinctrl4, "pinctrl-4", NULL)
> >     drivers/of/property.c:DEFINE_SIMPLE_PROP(pinctrl5, "pinctrl-5", NULL)
> >     drivers/of/property.c:DEFINE_SIMPLE_PROP(pinctrl6, "pinctrl-6", NULL)
> >     drivers/of/property.c:DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
> >     drivers/of/property.c:DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)
> >
> > Looks fragile, especially since we now have:
> >
> >     arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi:
> > pinctrl-9 = <&i2cmux_9>;
> >     arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi: pinctrl-10
> > = <&i2cmux_10>;
> >     arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi: pinctrl-11
> > = <&i2cmux_11>;
> >     arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi: pinctrl-12
> > = <&i2cmux_pins_i>;
> 
> Checking for pinctrl-* and then verifying if * matches %d would be
> more complicated and probably more expensive compared to listing
> pinctrl-[0-8]. Especially because more than 50% of pinctrl-*
> properties in DT files are NOT pinctrl-%d. So back when we merged
> this, Rob and I agreed [0-8] was good enough for now and we can add
> more if we needed to. Also, when I checked back then, all the
> pinctrl-5+ properties ended up pointing to the same suppliers as the
> lower numbered ones. So it didn't make a difference.
> 
> Ok, I just checked linux-next all the pinctrl-9+ instances and it's
> still true that they all point to the same supplier pointed to by
> pinctrl-[0-8].
> 
> So yeah, it looks fragile, 

And feels fragile, adds into confusion, etc.
Please, consider redesigning this to be more robust.

>	but is not broken and it's more efficient
> than looking for pinctrl-%d or adding more pinctrl-xx entries. So,
> let's fix it if it actually breaks? Not going to oppose a patch if
> anyone wants to make it more complete.
> 
> > > where driver_deferred_probe_check_state() is called before the supplier
> > > has probed successfully or before deferred probe timeout has expired.
> > >
> > > So, delete the call and replace it with -ENODEV.

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
