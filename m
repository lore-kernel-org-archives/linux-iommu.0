Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99878C433EF
	for <iommu@archiver.kernel.org>; Thu, 30 Jun 2022 23:31:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20497423C2;
	Thu, 30 Jun 2022 23:31:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 20497423C2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=esSzbAG9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L6vhvycjiBqC; Thu, 30 Jun 2022 23:31:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 87C3F423BD;
	Thu, 30 Jun 2022 23:31:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 87C3F423BD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E5F8C002D;
	Thu, 30 Jun 2022 23:31:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9ECD4C0011
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 23:31:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 76D018451E
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 23:31:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 76D018451E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20210112 header.b=esSzbAG9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 15b5eC2soJB2 for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 23:31:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 829C084387
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 829C084387
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 23:31:00 +0000 (UTC)
Received: by mail-yb1-xb36.google.com with SMTP id l11so1072322ybu.13
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 16:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7rzBjlWyrGCVnHojYy7aloe09Kk1ZJFyFafJ4B59izQ=;
 b=esSzbAG9SStIKedEdEyPNCZEwWeV7CGfw2gDAyv7xNkZGiGhAKyelsjm5S6l3zYohJ
 d/Eo0n6Mp+36R9EN/Pq2SisCS+9HoblIrvPkImxxTHiatXxbVEpvW3y/yNgVziC5uyoZ
 vYyHIRU3pYbXRmHkZLlWk/frQQwicQxGxfoUSBXj3PLfoEnFnvnX+lQNgSCCK/G112nQ
 +h/LHrk5XRmANsD8K55QOlIqREK2mYKCbE3t0k3EnnSD9DyzGjrrvdjT+EJJoRKX1F7X
 eGAoOxj+hwQhHxN9wOQ0TOIBLZRRt2Qt2wLPB0KOY9Z/NrqQd5sdoLelt/izUN/UnoDM
 mZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7rzBjlWyrGCVnHojYy7aloe09Kk1ZJFyFafJ4B59izQ=;
 b=wXJDlLlWjSKJXH6F40NPpMmI13Ao33rvmtPRJGzOnWAl/P7vDukiQ1WtfM+bOeF2ug
 4IZ3I30TWfWxBreoHAf6l9xXZ52VXr7kRhH/JRzYZfgDxJAcyit+Dao0ozZk2ZpNsIos
 d2C1RK5ynCK8fOyeTEfYQ9wvmm5ASgqryZkWEzw+xYa+Y6v3WToGRvpNYGaTKgL05Lje
 372yaWqAz0FU2tLPzJPVOkV9Ed1xnMyTJvr4ADHVfL8E+TJ90TCPl0sycIenDEIuZzwD
 yf7P10ByZg0InBO4qhXe+xkgOIMtKv3FowzPtcJsyfmA1U1poq+HXg7mWXGKlaViIQdZ
 wAdg==
X-Gm-Message-State: AJIora8vNxrNZHCyU7C6FALkAtxGKNbtgF/aqzUz5Y4BJVkuKKaJadVK
 cZTvri99Ibr9+wsj3iCut08xbzJIdNQ5reJsb4nkNw==
X-Google-Smtp-Source: AGRyM1vZ35BqSkdVoL3YwWkOXOHYil4MKgDP8iAYz+Rz4wCD4ADLbbR0rsgTYZHYxiDej4wVmrVuer94e9q4LpiXAmA=
X-Received: by 2002:a25:5bc3:0:b0:669:b722:beb8 with SMTP id
 p186-20020a255bc3000000b00669b722beb8mr12118791ybb.447.1656631859258; Thu, 30
 Jun 2022 16:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
 <20220601070707.3946847-2-saravanak@google.com> <YrFzK6EiVvXmzVG6@atomide.com>
 <CAGETcx_1USPRbFKV5j00qkQ-QXJkp7=FAfnFcfiNnM4J5KF1cQ@mail.gmail.com>
 <YrKhkmj3jCQA39X/@atomide.com>
 <CAGETcx_11wO-HkZ2QsBF8o1+L9L3Xe1QBQ_GzegwozxAx1i0jg@mail.gmail.com>
 <YrQP3OZbe8aCQxKU@atomide.com>
 <CAGETcx9aFBzMcuOiTAEy5SJyWw3UfajZ8DVQfW2DGmzzDabZVg@mail.gmail.com>
 <Yrlz/P6Un2fACG98@atomide.com>
 <CAGETcx8c+P0r6ARmhv+ERaz9zAGBOVJQu3bSDXELBycEGfkYQw@mail.gmail.com>
 <CAL_JsqJd3J6k6pRar7CkHVaaPbY7jqvzAePd8rVDisRV-dLLtg@mail.gmail.com>
In-Reply-To: <CAL_JsqJd3J6k6pRar7CkHVaaPbY7jqvzAePd8rVDisRV-dLLtg@mail.gmail.com>
Date: Thu, 30 Jun 2022 16:30:23 -0700
Message-ID: <CAGETcx9ZmeTyP1sJCFZ9pBbMyXeifQFohFvWN3aBPx0sSOJ2VA@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] PM: domains: Delete usage of
 driver_deferred_probe_check_state()
To: Rob Herring <robh@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
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
From: Saravana Kannan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Jun 30, 2022 at 4:26 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Jun 30, 2022 at 5:11 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Mon, Jun 27, 2022 at 2:10 AM Tony Lindgren <tony@atomide.com> wrote:
> > >
> > > * Saravana Kannan <saravanak@google.com> [220623 08:17]:
> > > > On Thu, Jun 23, 2022 at 12:01 AM Tony Lindgren <tony@atomide.com> wrote:
> > > > >
> > > > > * Saravana Kannan <saravanak@google.com> [220622 19:05]:
> > > > > > On Tue, Jun 21, 2022 at 9:59 PM Tony Lindgren <tony@atomide.com> wrote:
> > > > > > > This issue is no directly related fw_devlink. It is a side effect of
> > > > > > > removing driver_deferred_probe_check_state(). We no longer return
> > > > > > > -EPROBE_DEFER at the end of driver_deferred_probe_check_state().
> > > > > >
> > > > > > Yes, I understand the issue. But driver_deferred_probe_check_state()
> > > > > > was deleted because fw_devlink=on should have short circuited the
> > > > > > probe attempt with an  -EPROBE_DEFER before reaching the bus/driver
> > > > > > probe function and hitting this -ENOENT failure. That's why I was
> > > > > > asking the other questions.
> > > > >
> > > > > OK. So where is the -EPROBE_DEFER supposed to happen without
> > > > > driver_deferred_probe_check_state() then?
> > > >
> > > > device_links_check_suppliers() call inside really_probe() would short
> > > > circuit and return an -EPROBE_DEFER if the device links are created as
> > > > expected.
> > >
> > > OK
> > >
> > > > > Hmm so I'm not seeing any supplier for the top level ocp device in
> > > > > the booting case without your patches. I see the suppliers for the
> > > > > ocp child device instances only.
> > > >
> > > > Hmmm... this is strange (that the device link isn't there), but this
> > > > is what I suspected.
> > >
> > > Yup, maybe it's because of the supplier being a device in the child
> > > interconnect for the ocp.
> >
> > Ugh... yeah, this is why the normal (not SYNC_STATE_ONLY) device link
> > isn't being created.
> >
> > So the aggregated view is something like (I had to set tabs = 4 space
> > to fit it within 80 cols):
> >
> >     ocp: ocp {         <========================= Consumer
> >         compatible = "simple-pm-bus";
> >         power-domains = <&prm_per>; <=========== Supplier ref
> >
> >                 l4_wkup: interconnect@44c00000 {
> >             compatible = "ti,am33xx-l4-wkup", "simple-pm-bus";
> >
> >             segment@200000 {  /* 0x44e00000 */
> >                 compatible = "simple-pm-bus";
> >
> >                 target-module@0 { /* 0x44e00000, ap 8 58.0 */
> >                     compatible = "ti,sysc-omap4", "ti,sysc";
> >
> >                     prcm: prcm@0 {
> >                         compatible = "ti,am3-prcm", "simple-bus";
> >
> >                         prm_per: prm@c00 { <========= Actual Supplier
> >                             compatible = "ti,am3-prm-inst", "ti,omap-prm-inst";
> >                         };
> >                     };
> >                 };
> >             };
> >         };
> >     };
> >
> > The power-domain supplier is the great-great-great-grand-child of the
> > consumer. It's not clear to me how this is valid. What does it even
> > mean?
> >
> > Rob, is this considered a valid DT?
>
> Valid DT for broken h/w.

I'm not sure even in that case it's valid. When the parent device is
in reset (when the SoC is coming out of reset), there's no way the
descendant is functional. And if the descendant is not functional, how
is the parent device powered up? This just feels like an incorrect
representation of the real h/w.

> So the domain must be default on and then simple-pm-bus is going to
> hold a reference to the domain preventing it from ever getting powered
> off and things seem to work. Except what happens during suspend?

But how can simple-pm-bus even get a reference? The PM domain can't
get added until we are well into the probe of the simple-pm-bus and
AFAICT the genpd attach is done before the driver probe is even
called.

-Saravana
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
