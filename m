Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CFECCA47A
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 04:59:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 632448463F;
	Wed, 22 Jun 2022 04:59:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 632448463F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L9KCImPHz9yw; Wed, 22 Jun 2022 04:59:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 25C62842B8;
	Wed, 22 Jun 2022 04:59:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 25C62842B8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D924EC0039;
	Wed, 22 Jun 2022 04:59:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EC50C002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 04:59:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 37466845D4
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 04:59:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 37466845D4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dZscnj8yxlXB for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 04:59:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 43069842B8
Received: from muru.com (muru.com [72.249.23.125])
 by smtp1.osuosl.org (Postfix) with ESMTP id 43069842B8
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 04:59:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 6B48A809F;
 Wed, 22 Jun 2022 04:54:00 +0000 (UTC)
Date: Wed, 22 Jun 2022 07:58:58 +0300
From: Tony Lindgren <tony@atomide.com>
To: Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v2 1/9] PM: domains: Delete usage of
 driver_deferred_probe_check_state()
Message-ID: <YrKhkmj3jCQA39X/@atomide.com>
References: <20220601070707.3946847-1-saravanak@google.com>
 <20220601070707.3946847-2-saravanak@google.com>
 <YrFzK6EiVvXmzVG6@atomide.com>
 <CAGETcx_1USPRbFKV5j00qkQ-QXJkp7=FAfnFcfiNnM4J5KF1cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGETcx_1USPRbFKV5j00qkQ-QXJkp7=FAfnFcfiNnM4J5KF1cQ@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

* Saravana Kannan <saravanak@google.com> [220621 19:29]:
> On Tue, Jun 21, 2022 at 12:28 AM Tony Lindgren <tony@atomide.com> wrote:
> >
> > Hi,
> >
> > * Saravana Kannan <saravanak@google.com> [700101 02:00]:
> > > Now that fw_devlink=on by default and fw_devlink supports
> > > "power-domains" property, the execution will never get to the point
> > > where driver_deferred_probe_check_state() is called before the supplier
> > > has probed successfully or before deferred probe timeout has expired.
> > >
> > > So, delete the call and replace it with -ENODEV.
> >
> > Looks like this causes omaps to not boot in Linux next.
> 
> Can you please point me to an example DTS I could use for debugging
> this? I'm assuming you are leaving fw_devlink=on and not turning it
> off or putting it in permissive mode.

Sure, this seems to happen at least with simple-pm-bus as the top
level interconnect with a configured power-domains property:

$ git grep -A10 "ocp {" arch/arm/boot/dts/*.dtsi | grep -B3 -A4 simple-pm-bus

This issue is no directly related fw_devlink. It is a side effect of
removing driver_deferred_probe_check_state(). We no longer return
-EPROBE_DEFER at the end of driver_deferred_probe_check_state().

> > On platform_probe() genpd_get_from_provider() returns
> > -ENOENT.
> 
> This error is with the series I assume?

On the first probe genpd_get_from_provider() will return -ENOENT in
both cases. The list is empty on the first probe and there are no
genpd providers at this point.

Earlier with driver_deferred_probe_check_state(), the initial -ENOENT
ends up getting changed to -EPROBE_DEFER at the end of
driver_deferred_probe_check_state(), we are now missing that.

Regards,

Tony
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
