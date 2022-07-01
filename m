Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C95FC433EF
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 05:33:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 712C083F9C;
	Fri,  1 Jul 2022 05:33:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 712C083F9C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1TxQh3YyETHc; Fri,  1 Jul 2022 05:33:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 31D1183F61;
	Fri,  1 Jul 2022 05:33:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 31D1183F61
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0808DC002D;
	Fri,  1 Jul 2022 05:33:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1139EC0011
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 05:33:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D5DF983F6C
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 05:33:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D5DF983F6C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hwf3qPY9Iq3Q for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 05:33:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 97C4383F61
Received: from muru.com (muru.com [72.249.23.125])
 by smtp1.osuosl.org (Postfix) with ESMTP id 97C4383F61
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 05:33:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id EA42380B0;
 Fri,  1 Jul 2022 05:28:35 +0000 (UTC)
Date: Fri, 1 Jul 2022 08:33:52 +0300
From: Tony Lindgren <tony@atomide.com>
To: Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v2 1/9] PM: domains: Delete usage of
 driver_deferred_probe_check_state()
Message-ID: <Yr6HQOtS4ctUYm9m@atomide.com>
References: <YrFzK6EiVvXmzVG6@atomide.com>
 <CAGETcx_1USPRbFKV5j00qkQ-QXJkp7=FAfnFcfiNnM4J5KF1cQ@mail.gmail.com>
 <YrKhkmj3jCQA39X/@atomide.com>
 <CAGETcx_11wO-HkZ2QsBF8o1+L9L3Xe1QBQ_GzegwozxAx1i0jg@mail.gmail.com>
 <YrQP3OZbe8aCQxKU@atomide.com>
 <CAGETcx9aFBzMcuOiTAEy5SJyWw3UfajZ8DVQfW2DGmzzDabZVg@mail.gmail.com>
 <Yrlz/P6Un2fACG98@atomide.com>
 <CAGETcx8c+P0r6ARmhv+ERaz9zAGBOVJQu3bSDXELBycEGfkYQw@mail.gmail.com>
 <CAL_JsqJd3J6k6pRar7CkHVaaPbY7jqvzAePd8rVDisRV-dLLtg@mail.gmail.com>
 <CAGETcx9ZmeTyP1sJCFZ9pBbMyXeifQFohFvWN3aBPx0sSOJ2VA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGETcx9ZmeTyP1sJCFZ9pBbMyXeifQFohFvWN3aBPx0sSOJ2VA@mail.gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 Rob Herring <robh@kernel.org>, Kevin Hilman <khilman@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Android Kernel Team <kernel-team@android.com>,
 Len Brown <len.brown@intel.com>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

* Saravana Kannan <saravanak@google.com> [220630 23:25]:
> On Thu, Jun 30, 2022 at 4:26 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Jun 30, 2022 at 5:11 PM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > On Mon, Jun 27, 2022 at 2:10 AM Tony Lindgren <tony@atomide.com> wrote:
> > > >
> > > > * Saravana Kannan <saravanak@google.com> [220623 08:17]:
> > > > > On Thu, Jun 23, 2022 at 12:01 AM Tony Lindgren <tony@atomide.com> wrote:
> > > > > >
> > > > > > * Saravana Kannan <saravanak@google.com> [220622 19:05]:
> > > > > > > On Tue, Jun 21, 2022 at 9:59 PM Tony Lindgren <tony@atomide.com> wrote:
> > > > > > > > This issue is no directly related fw_devlink. It is a side effect of
> > > > > > > > removing driver_deferred_probe_check_state(). We no longer return
> > > > > > > > -EPROBE_DEFER at the end of driver_deferred_probe_check_state().
> > > > > > >
> > > > > > > Yes, I understand the issue. But driver_deferred_probe_check_state()
> > > > > > > was deleted because fw_devlink=on should have short circuited the
> > > > > > > probe attempt with an  -EPROBE_DEFER before reaching the bus/driver
> > > > > > > probe function and hitting this -ENOENT failure. That's why I was
> > > > > > > asking the other questions.
> > > > > >
> > > > > > OK. So where is the -EPROBE_DEFER supposed to happen without
> > > > > > driver_deferred_probe_check_state() then?
> > > > >
> > > > > device_links_check_suppliers() call inside really_probe() would short
> > > > > circuit and return an -EPROBE_DEFER if the device links are created as
> > > > > expected.
> > > >
> > > > OK
> > > >
> > > > > > Hmm so I'm not seeing any supplier for the top level ocp device in
> > > > > > the booting case without your patches. I see the suppliers for the
> > > > > > ocp child device instances only.
> > > > >
> > > > > Hmmm... this is strange (that the device link isn't there), but this
> > > > > is what I suspected.
> > > >
> > > > Yup, maybe it's because of the supplier being a device in the child
> > > > interconnect for the ocp.
> > >
> > > Ugh... yeah, this is why the normal (not SYNC_STATE_ONLY) device link
> > > isn't being created.
> > >
> > > So the aggregated view is something like (I had to set tabs = 4 space
> > > to fit it within 80 cols):
> > >
> > >     ocp: ocp {         <========================= Consumer
> > >         compatible = "simple-pm-bus";
> > >         power-domains = <&prm_per>; <=========== Supplier ref
> > >
> > >                 l4_wkup: interconnect@44c00000 {
> > >             compatible = "ti,am33xx-l4-wkup", "simple-pm-bus";
> > >
> > >             segment@200000 {  /* 0x44e00000 */
> > >                 compatible = "simple-pm-bus";
> > >
> > >                 target-module@0 { /* 0x44e00000, ap 8 58.0 */
> > >                     compatible = "ti,sysc-omap4", "ti,sysc";
> > >
> > >                     prcm: prcm@0 {
> > >                         compatible = "ti,am3-prcm", "simple-bus";
> > >
> > >                         prm_per: prm@c00 { <========= Actual Supplier
> > >                             compatible = "ti,am3-prm-inst", "ti,omap-prm-inst";
> > >                         };
> > >                     };
> > >                 };
> > >             };
> > >         };
> > >     };
> > >
> > > The power-domain supplier is the great-great-great-grand-child of the
> > > consumer. It's not clear to me how this is valid. What does it even
> > > mean?
> > >
> > > Rob, is this considered a valid DT?
> >
> > Valid DT for broken h/w.
> 
> I'm not sure even in that case it's valid. When the parent device is
> in reset (when the SoC is coming out of reset), there's no way the
> descendant is functional. And if the descendant is not functional, how
> is the parent device powered up? This just feels like an incorrect
> representation of the real h/w.

It should be correct representation based on scanning the interconnects
and looking at the documentation. Some interconnect parts are wired
always-on and some interconnect instances may be dual-mapped.

We have a quirk to probe prm/prcm first with pdata_quirks_init_clocks().
Maybe that also now fails in addition to the top level interconnect
probing no longer producing -EPROBE_DEFER.

> > So the domain must be default on and then simple-pm-bus is going to
> > hold a reference to the domain preventing it from ever getting powered
> > off and things seem to work. Except what happens during suspend?
> 
> But how can simple-pm-bus even get a reference? The PM domain can't
> get added until we are well into the probe of the simple-pm-bus and
> AFAICT the genpd attach is done before the driver probe is even
> called.

The prm/prcm gets of_platform_populate() called on it early.

Regards,

Tony
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
