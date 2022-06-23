Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3775C43334
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 07:01:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8164340995;
	Thu, 23 Jun 2022 07:01:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8164340995
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s6sElHhFbTUp; Thu, 23 Jun 2022 07:01:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EB8AD40947;
	Thu, 23 Jun 2022 07:01:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB8AD40947
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C54A8C0032;
	Thu, 23 Jun 2022 07:01:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 233A8C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 07:01:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F1FB84059B
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 07:01:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F1FB84059B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id POyEPURhwwUz for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 07:01:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 07DE540576
Received: from muru.com (muru.com [72.249.23.125])
 by smtp2.osuosl.org (Postfix) with ESMTP id 07DE540576
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 07:01:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTPS id B6087804D;
 Thu, 23 Jun 2022 06:56:47 +0000 (UTC)
Date: Thu, 23 Jun 2022 10:01:48 +0300
From: Tony Lindgren <tony@atomide.com>
To: Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v2 1/9] PM: domains: Delete usage of
 driver_deferred_probe_check_state()
Message-ID: <YrQP3OZbe8aCQxKU@atomide.com>
References: <20220601070707.3946847-1-saravanak@google.com>
 <20220601070707.3946847-2-saravanak@google.com>
 <YrFzK6EiVvXmzVG6@atomide.com>
 <CAGETcx_1USPRbFKV5j00qkQ-QXJkp7=FAfnFcfiNnM4J5KF1cQ@mail.gmail.com>
 <YrKhkmj3jCQA39X/@atomide.com>
 <CAGETcx_11wO-HkZ2QsBF8o1+L9L3Xe1QBQ_GzegwozxAx1i0jg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGETcx_11wO-HkZ2QsBF8o1+L9L3Xe1QBQ_GzegwozxAx1i0jg@mail.gmail.com>
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

* Saravana Kannan <saravanak@google.com> [220622 19:05]:
> On Tue, Jun 21, 2022 at 9:59 PM Tony Lindgren <tony@atomide.com> wrote:
> >
> > Hi,
> >
> > * Saravana Kannan <saravanak@google.com> [220621 19:29]:
> > > On Tue, Jun 21, 2022 at 12:28 AM Tony Lindgren <tony@atomide.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > * Saravana Kannan <saravanak@google.com> [700101 02:00]:
> > > > > Now that fw_devlink=on by default and fw_devlink supports
> > > > > "power-domains" property, the execution will never get to the point
> > > > > where driver_deferred_probe_check_state() is called before the supplier
> > > > > has probed successfully or before deferred probe timeout has expired.
> > > > >
> > > > > So, delete the call and replace it with -ENODEV.
> > > >
> > > > Looks like this causes omaps to not boot in Linux next.
> > >
> > > Can you please point me to an example DTS I could use for debugging
> > > this? I'm assuming you are leaving fw_devlink=on and not turning it
> > > off or putting it in permissive mode.
> >
> > Sure, this seems to happen at least with simple-pm-bus as the top
> > level interconnect with a configured power-domains property:
> >
> > $ git grep -A10 "ocp {" arch/arm/boot/dts/*.dtsi | grep -B3 -A4 simple-pm-bus
> 
> Thanks for the example. I generally start looking from dts (not dtsi)
> files in case there are some DT property override/additions after the
> dtsi files are included in the dts file. But I'll assume for now
> that's not the case. If there's a specific dts file for a board I can
> look from that'd be helpful to rule out those kinds of issues.
> 
> For now, I looked at arch/arm/boot/dts/omap4.dtsi.

OK it should be very similar for all the affected SoCs.

> > This issue is no directly related fw_devlink. It is a side effect of
> > removing driver_deferred_probe_check_state(). We no longer return
> > -EPROBE_DEFER at the end of driver_deferred_probe_check_state().
> 
> Yes, I understand the issue. But driver_deferred_probe_check_state()
> was deleted because fw_devlink=on should have short circuited the
> probe attempt with an  -EPROBE_DEFER before reaching the bus/driver
> probe function and hitting this -ENOENT failure. That's why I was
> asking the other questions.

OK. So where is the -EPROBE_DEFER supposed to happen without
driver_deferred_probe_check_state() then?

> > > > On platform_probe() genpd_get_from_provider() returns
> > > > -ENOENT.
> > >
> > > This error is with the series I assume?
> >
> > On the first probe genpd_get_from_provider() will return -ENOENT in
> > both cases. The list is empty on the first probe and there are no
> > genpd providers at this point.
> >
> > Earlier with driver_deferred_probe_check_state(), the initial -ENOENT
> > ends up getting changed to -EPROBE_DEFER at the end of
> > driver_deferred_probe_check_state(), we are now missing that.
> 
> Right, I was aware -ENOENT would be returned if we got this far. But
> the point of this series is that you shouldn't have gotten that far
> before your pm domain device is ready. Hence my questions from the
> earlier reply.

OK

> Can I get answers to rest of my questions in the first reply please?
> That should help us figure out why fw_devlink let us get this far.
> Summarize them here to make it easy:
> * Are you running with fw_devlink=on?

Yes with the default with no specific kernel params so looks like
FW_DEVLINK_FLAGS_ON.

> * Is the"ti,omap4-prm-inst"/"ti,omap-prm-inst" built-in in this case?

Yes

> * If it's not built-in, can you please try deferred_probe_timeout=0
> and deferred_probe_timeout=30 and see if either one of them help?

It's built in so I did not try these.

> * Can I get the output of "ls -d supplier:*" and "cat
> supplier:*/status" output from the sysfs dir for the ocp device
> without this series where it boots properly.

Hmm so I'm not seeing any supplier for the top level ocp device in
the booting case without your patches. I see the suppliers for the
ocp child device instances only.

Without your patches I see simple-pm-bus probe initially with
EPROBE_DEFER like I described earlier, and then simple-pm-bus probes
on the second try.

Regards,

Tony
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
