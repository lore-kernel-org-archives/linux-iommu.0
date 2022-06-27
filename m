Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D81C433EF
	for <iommu@archiver.kernel.org>; Mon, 27 Jun 2022 09:10:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 682A36106E;
	Mon, 27 Jun 2022 09:10:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 682A36106E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qC4Y3wTO8rRf; Mon, 27 Jun 2022 09:10:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2240160D6C;
	Mon, 27 Jun 2022 09:10:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2240160D6C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE8A7C0032;
	Mon, 27 Jun 2022 09:10:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B385C002D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 09:10:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3666982FF9
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 09:10:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3666982FF9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OJIjefAZy37S for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 09:10:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 012D282C1E
Received: from muru.com (muru.com [72.249.23.125])
 by smtp1.osuosl.org (Postfix) with ESMTP id 012D282C1E
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 09:10:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id 310998106;
 Mon, 27 Jun 2022 09:05:11 +0000 (UTC)
Date: Mon, 27 Jun 2022 12:10:20 +0300
From: Tony Lindgren <tony@atomide.com>
To: Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v2 1/9] PM: domains: Delete usage of
 driver_deferred_probe_check_state()
Message-ID: <Yrlz/P6Un2fACG98@atomide.com>
References: <20220601070707.3946847-1-saravanak@google.com>
 <20220601070707.3946847-2-saravanak@google.com>
 <YrFzK6EiVvXmzVG6@atomide.com>
 <CAGETcx_1USPRbFKV5j00qkQ-QXJkp7=FAfnFcfiNnM4J5KF1cQ@mail.gmail.com>
 <YrKhkmj3jCQA39X/@atomide.com>
 <CAGETcx_11wO-HkZ2QsBF8o1+L9L3Xe1QBQ_GzegwozxAx1i0jg@mail.gmail.com>
 <YrQP3OZbe8aCQxKU@atomide.com>
 <CAGETcx9aFBzMcuOiTAEy5SJyWw3UfajZ8DVQfW2DGmzzDabZVg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGETcx9aFBzMcuOiTAEy5SJyWw3UfajZ8DVQfW2DGmzzDabZVg@mail.gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
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

* Saravana Kannan <saravanak@google.com> [220623 08:17]:
> On Thu, Jun 23, 2022 at 12:01 AM Tony Lindgren <tony@atomide.com> wrote:
> >
> > * Saravana Kannan <saravanak@google.com> [220622 19:05]:
> > > On Tue, Jun 21, 2022 at 9:59 PM Tony Lindgren <tony@atomide.com> wrote:
> > > > This issue is no directly related fw_devlink. It is a side effect of
> > > > removing driver_deferred_probe_check_state(). We no longer return
> > > > -EPROBE_DEFER at the end of driver_deferred_probe_check_state().
> > >
> > > Yes, I understand the issue. But driver_deferred_probe_check_state()
> > > was deleted because fw_devlink=on should have short circuited the
> > > probe attempt with an  -EPROBE_DEFER before reaching the bus/driver
> > > probe function and hitting this -ENOENT failure. That's why I was
> > > asking the other questions.
> >
> > OK. So where is the -EPROBE_DEFER supposed to happen without
> > driver_deferred_probe_check_state() then?
> 
> device_links_check_suppliers() call inside really_probe() would short
> circuit and return an -EPROBE_DEFER if the device links are created as
> expected.

OK

> > Hmm so I'm not seeing any supplier for the top level ocp device in
> > the booting case without your patches. I see the suppliers for the
> > ocp child device instances only.
> 
> Hmmm... this is strange (that the device link isn't there), but this
> is what I suspected.

Yup, maybe it's because of the supplier being a device in the child
interconnect for the ocp.

> Now we need to figure out why it's missing. There are only a few
> things that could cause this and I don't see any of those. I already
> checked to make sure the power domain in this instance had a proper
> driver with a probe() function -- if it didn't, then that's one thing
> that'd could have caused the missing device link. The device does seem
> to have a proper driver, so looks like I can rule that out.
> 
> Can you point me to the dts file that corresponds to the specific
> board you are testing this one? I probably won't find anything, but I
> want to rule out some of the possibilities.

You can use the beaglebone black dts for example, that's
arch/arm/boot/dts/am335x-boneblack.dts and uses am33xx.dtsi for
ocp interconnect with simple-pm-bus.

> All the device link creation logic is inside drivers/base/core.c. So
> if you can look at the existing messages or add other stuff to figure
> out why the device link isn't getting created, that'd be handy. In
> either case, I'll continue staring at the DT and code to see what
> might be happening here.

In device_links_check_suppliers() I see these ocp suppliers:

platform ocp: device_links_check_suppliers: 1024: supplier 44e00d00.prm: link->status: 0 link->flags: 000001c0
platform ocp: device_links_check_suppliers: 1024: supplier 44e01000.prm: link->status: 0 link->flags: 000001c0
platform ocp: device_links_check_suppliers: 1024: supplier 44e00c00.prm: link->status: 0 link->flags: 000001c0
platform ocp: device_links_check_suppliers: 1024: supplier 44e00e00.prm: link->status: 0 link->flags: 000001c0
platform ocp: device_links_check_suppliers: 1024: supplier 44e01100.prm: link->status: 0 link->flags: 000001c0
platform ocp: device_links_check_suppliers: 1024: supplier fixedregulator0: link->status: 1 link->flags: 000001c0

No -EPROBE_DEFER is returned in device_links_check_suppliers() for
44e00c00.prm supplier for beaglebone black for example, 0 gets
returned.

Regards,

Tony
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
