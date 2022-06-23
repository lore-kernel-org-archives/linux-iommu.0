Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48B5C43334
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 08:22:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 438D341A4C;
	Thu, 23 Jun 2022 08:22:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 438D341A4C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=pzqGfXQL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YCq0cHO446GL; Thu, 23 Jun 2022 08:22:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 31E7241A3C;
	Thu, 23 Jun 2022 08:22:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 31E7241A3C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECFB8C0032;
	Thu, 23 Jun 2022 08:22:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35334C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 08:22:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1645A60E66
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 08:22:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1645A60E66
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20210112 header.b=pzqGfXQL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 359K8VIRULuv for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 08:22:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 26A6F60E45
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 26A6F60E45
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 08:22:22 +0000 (UTC)
Received: by mail-yb1-xb2c.google.com with SMTP id 23so34525390ybe.8
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 01:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9PjNiNhLCuh9WhzT1AaONPfu5Pj4HpLdf/1QRxDQ9sQ=;
 b=pzqGfXQLba3va5/8Sml5dTqasBd22VtMC6LsIY9XM86NydlS9zpVJnL7w7xX6iuDe8
 X7CBtL21Xt/roY99vHIUugx0rcpAIZr/MRxvyoGKpsUZLiqAk//S2jlQpBwrNnHk7wGm
 RQTEw34L8DZMyPfA1AsauTTsxDs05tA56d4f5svcOAWjw1Odk+3DTByfTvJrYBNr/zRF
 iPbOdMh47ENO95zTpdz/17l4CgcdpExtT5e0NypAQFBQc/j/g67fTa8i40rOqRH7rdeC
 +qNvOlp6pV5Z2uaLHf2Y3ZncmyJaUhr6W/xXlsYAJCLg8Ts5Y0LhOT8aCUZsWexiZHkk
 67Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9PjNiNhLCuh9WhzT1AaONPfu5Pj4HpLdf/1QRxDQ9sQ=;
 b=JmKLOYSrcWm1om3fJrRQ8eX1UOI0F6EKbwDT4aqFbIQILTsrxH5fcA/NM4xzogILHb
 7kFAfgtED5b6eXJ4vcqP1tFd19RMJ3pksaCf0Maa/1nVIFL0hpPuGZTqXsVkkObQvy7l
 3RqqkYngmypyGUET2XCZk2gQ/SA56vMlkvBkCVSM1f7nCqhvD1tOXEFWoJlXE/KX4UuU
 3nmGnwUiLtsx3XYTzwIn0h3LzHwVRZl7s1BMut6TapVmOrQZuO+5TxmaqR/zhX5Gk/EB
 Bg+jX0WvUVeMxs7wIF0kCrn6tYaPlUlBxAva64RDsg5Qy+PHJ7AoV4sE1HXaa85w1pDc
 sUCw==
X-Gm-Message-State: AJIora85n01ACXi7VAko6ItPf7ecWW1/XF4Mzjq/QZjuMF69LIEK7hPj
 5TNEKkUdj5Bx2TaHNREL0n/KXQZtIJbEiRxIZbzFQA==
X-Google-Smtp-Source: AGRyM1vxaAj9yCr/MgE5OXOPyoZP2NZubFdKuQ3kk1yDt2x8rBApcAn2+N11GLiK2OWn/arC4N2rlY0DEOynYw1Ms08=
X-Received: by 2002:a25:9e82:0:b0:669:b38d:e93e with SMTP id
 p2-20020a259e82000000b00669b38de93emr775933ybq.242.1655972540895; Thu, 23 Jun
 2022 01:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
 <20220601070707.3946847-2-saravanak@google.com> <YrFzK6EiVvXmzVG6@atomide.com>
 <CAGETcx_1USPRbFKV5j00qkQ-QXJkp7=FAfnFcfiNnM4J5KF1cQ@mail.gmail.com>
 <YrKhkmj3jCQA39X/@atomide.com>
 <CAGETcx_11wO-HkZ2QsBF8o1+L9L3Xe1QBQ_GzegwozxAx1i0jg@mail.gmail.com>
 <YrQP3OZbe8aCQxKU@atomide.com>
In-Reply-To: <YrQP3OZbe8aCQxKU@atomide.com>
Date: Thu, 23 Jun 2022 01:21:43 -0700
Message-ID: <CAGETcx9aFBzMcuOiTAEy5SJyWw3UfajZ8DVQfW2DGmzzDabZVg@mail.gmail.com>
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

On Thu, Jun 23, 2022 at 12:01 AM Tony Lindgren <tony@atomide.com> wrote:
>
> * Saravana Kannan <saravanak@google.com> [220622 19:05]:
> > On Tue, Jun 21, 2022 at 9:59 PM Tony Lindgren <tony@atomide.com> wrote:
> > >
> > > Hi,
> > >
> > > * Saravana Kannan <saravanak@google.com> [220621 19:29]:
> > > > On Tue, Jun 21, 2022 at 12:28 AM Tony Lindgren <tony@atomide.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > * Saravana Kannan <saravanak@google.com> [700101 02:00]:
> > > > > > Now that fw_devlink=on by default and fw_devlink supports
> > > > > > "power-domains" property, the execution will never get to the point
> > > > > > where driver_deferred_probe_check_state() is called before the supplier
> > > > > > has probed successfully or before deferred probe timeout has expired.
> > > > > >
> > > > > > So, delete the call and replace it with -ENODEV.
> > > > >
> > > > > Looks like this causes omaps to not boot in Linux next.
> > > >
> > > > Can you please point me to an example DTS I could use for debugging
> > > > this? I'm assuming you are leaving fw_devlink=on and not turning it
> > > > off or putting it in permissive mode.
> > >
> > > Sure, this seems to happen at least with simple-pm-bus as the top
> > > level interconnect with a configured power-domains property:
> > >
> > > $ git grep -A10 "ocp {" arch/arm/boot/dts/*.dtsi | grep -B3 -A4 simple-pm-bus
> >
> > Thanks for the example. I generally start looking from dts (not dtsi)
> > files in case there are some DT property override/additions after the
> > dtsi files are included in the dts file. But I'll assume for now
> > that's not the case. If there's a specific dts file for a board I can
> > look from that'd be helpful to rule out those kinds of issues.
> >
> > For now, I looked at arch/arm/boot/dts/omap4.dtsi.
>
> OK it should be very similar for all the affected SoCs.
>
> > > This issue is no directly related fw_devlink. It is a side effect of
> > > removing driver_deferred_probe_check_state(). We no longer return
> > > -EPROBE_DEFER at the end of driver_deferred_probe_check_state().
> >
> > Yes, I understand the issue. But driver_deferred_probe_check_state()
> > was deleted because fw_devlink=on should have short circuited the
> > probe attempt with an  -EPROBE_DEFER before reaching the bus/driver
> > probe function and hitting this -ENOENT failure. That's why I was
> > asking the other questions.
>
> OK. So where is the -EPROBE_DEFER supposed to happen without
> driver_deferred_probe_check_state() then?

device_links_check_suppliers() call inside really_probe() would short
circuit and return an -EPROBE_DEFER if the device links are created as
expected.

>
> > > > > On platform_probe() genpd_get_from_provider() returns
> > > > > -ENOENT.
> > > >
> > > > This error is with the series I assume?
> > >
> > > On the first probe genpd_get_from_provider() will return -ENOENT in
> > > both cases. The list is empty on the first probe and there are no
> > > genpd providers at this point.
> > >
> > > Earlier with driver_deferred_probe_check_state(), the initial -ENOENT
> > > ends up getting changed to -EPROBE_DEFER at the end of
> > > driver_deferred_probe_check_state(), we are now missing that.
> >
> > Right, I was aware -ENOENT would be returned if we got this far. But
> > the point of this series is that you shouldn't have gotten that far
> > before your pm domain device is ready. Hence my questions from the
> > earlier reply.
>
> OK
>
> > Can I get answers to rest of my questions in the first reply please?
> > That should help us figure out why fw_devlink let us get this far.
> > Summarize them here to make it easy:
> > * Are you running with fw_devlink=on?
>
> Yes with the default with no specific kernel params so looks like
> FW_DEVLINK_FLAGS_ON.
>
> > * Is the"ti,omap4-prm-inst"/"ti,omap-prm-inst" built-in in this case?
>
> Yes
>
> > * If it's not built-in, can you please try deferred_probe_timeout=0
> > and deferred_probe_timeout=30 and see if either one of them help?
>
> It's built in so I did not try these.
>
> > * Can I get the output of "ls -d supplier:*" and "cat
> > supplier:*/status" output from the sysfs dir for the ocp device
> > without this series where it boots properly.
>
> Hmm so I'm not seeing any supplier for the top level ocp device in
> the booting case without your patches. I see the suppliers for the
> ocp child device instances only.

Hmmm... this is strange (that the device link isn't there), but this
is what I suspected.

Now we need to figure out why it's missing. There are only a few
things that could cause this and I don't see any of those. I already
checked to make sure the power domain in this instance had a proper
driver with a probe() function -- if it didn't, then that's one thing
that'd could have caused the missing device link. The device does seem
to have a proper driver, so looks like I can rule that out.

Can you point me to the dts file that corresponds to the specific
board you are testing this one? I probably won't find anything, but I
want to rule out some of the possibilities.

All the device link creation logic is inside drivers/base/core.c. So
if you can look at the existing messages or add other stuff to figure
out why the device link isn't getting created, that'd be handy. In
either case, I'll continue staring at the DT and code to see what
might be happening here.

-Saravana
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
