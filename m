Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB3DC43334
	for <iommu@archiver.kernel.org>; Thu, 30 Jun 2022 23:26:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 051C260F9C;
	Thu, 30 Jun 2022 23:26:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 051C260F9C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Qi98AIkp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JaTOTEpWHj2f; Thu, 30 Jun 2022 23:26:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BC9B660ACE;
	Thu, 30 Jun 2022 23:26:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BC9B660ACE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7780CC002D;
	Thu, 30 Jun 2022 23:26:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3B30C0011
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 23:26:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 96D2760F97
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 23:26:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 96D2760F97
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iYOFMMKCOU1i for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 23:26:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B5C8B60ACE
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B5C8B60ACE
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 23:26:36 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E0EE7615AD
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 23:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9FFC34115
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 23:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656631595;
 bh=ocxWtABVoequW5YNJWHtxjCAN6pvUTRglOmXliA+RpI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Qi98AIkpiogBRU1SIQ0tRIDCbTH3aUhLmIwceSXkScDwXJRgoZSsHLUvO4xn/Aaco
 jUeeJ1bfKaPPoD5NhRVnYvDv7ZJXteCeyyAcTVk2eHussC2U0xAsQizgRBBb0q143b
 FegjCvwcXeJGM0D9K4OwnWTFftyuJNqy/fsRt4PTeKXuJzs2BuvZWQf47mcHBJ2zFS
 QiVBk+IwIKPPurNp4TBJXnbB2mxb/ZoerePEqqTYli4zzKaVWaF/7nbwI+VJW9Rn0M
 rjJI0pOTvoDA8U1DSfb8VACgJqhFmYGFBJhUpERO6ZqZ0i2uiu9/r5+1gdHldP6Y7H
 ugsbpRRMOTwdQ==
Received: by mail-ua1-f47.google.com with SMTP id o21so251405uat.6
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 16:26:35 -0700 (PDT)
X-Gm-Message-State: AJIora9qgPnaxK2cBvGIi2Sr/QYOvHCAPSlaH/L3bb+kNipFoSsuGWkp
 DSdTFkjur/7J3yRQC81p2XiTwGErAiFJP1ksLQ==
X-Google-Smtp-Source: AGRyM1uzRDE+5OSb/zj34pnreLyYTDG7fKIijDdSX9upnNZPRoBKS78Ucyprll5y2N89WsffxoVjZnek2U5JH0kmp0E=
X-Received: by 2002:ab0:244f:0:b0:37f:2985:e620 with SMTP id
 g15-20020ab0244f000000b0037f2985e620mr6853095uan.36.1656631594258; Thu, 30
 Jun 2022 16:26:34 -0700 (PDT)
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
In-Reply-To: <CAGETcx8c+P0r6ARmhv+ERaz9zAGBOVJQu3bSDXELBycEGfkYQw@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 30 Jun 2022 17:26:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJd3J6k6pRar7CkHVaaPbY7jqvzAePd8rVDisRV-dLLtg@mail.gmail.com>
Message-ID: <CAL_JsqJd3J6k6pRar7CkHVaaPbY7jqvzAePd8rVDisRV-dLLtg@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] PM: domains: Delete usage of
 driver_deferred_probe_check_state()
To: Saravana Kannan <saravanak@google.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Jun 30, 2022 at 5:11 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Mon, Jun 27, 2022 at 2:10 AM Tony Lindgren <tony@atomide.com> wrote:
> >
> > * Saravana Kannan <saravanak@google.com> [220623 08:17]:
> > > On Thu, Jun 23, 2022 at 12:01 AM Tony Lindgren <tony@atomide.com> wrote:
> > > >
> > > > * Saravana Kannan <saravanak@google.com> [220622 19:05]:
> > > > > On Tue, Jun 21, 2022 at 9:59 PM Tony Lindgren <tony@atomide.com> wrote:
> > > > > > This issue is no directly related fw_devlink. It is a side effect of
> > > > > > removing driver_deferred_probe_check_state(). We no longer return
> > > > > > -EPROBE_DEFER at the end of driver_deferred_probe_check_state().
> > > > >
> > > > > Yes, I understand the issue. But driver_deferred_probe_check_state()
> > > > > was deleted because fw_devlink=on should have short circuited the
> > > > > probe attempt with an  -EPROBE_DEFER before reaching the bus/driver
> > > > > probe function and hitting this -ENOENT failure. That's why I was
> > > > > asking the other questions.
> > > >
> > > > OK. So where is the -EPROBE_DEFER supposed to happen without
> > > > driver_deferred_probe_check_state() then?
> > >
> > > device_links_check_suppliers() call inside really_probe() would short
> > > circuit and return an -EPROBE_DEFER if the device links are created as
> > > expected.
> >
> > OK
> >
> > > > Hmm so I'm not seeing any supplier for the top level ocp device in
> > > > the booting case without your patches. I see the suppliers for the
> > > > ocp child device instances only.
> > >
> > > Hmmm... this is strange (that the device link isn't there), but this
> > > is what I suspected.
> >
> > Yup, maybe it's because of the supplier being a device in the child
> > interconnect for the ocp.
>
> Ugh... yeah, this is why the normal (not SYNC_STATE_ONLY) device link
> isn't being created.
>
> So the aggregated view is something like (I had to set tabs = 4 space
> to fit it within 80 cols):
>
>     ocp: ocp {         <========================= Consumer
>         compatible = "simple-pm-bus";
>         power-domains = <&prm_per>; <=========== Supplier ref
>
>                 l4_wkup: interconnect@44c00000 {
>             compatible = "ti,am33xx-l4-wkup", "simple-pm-bus";
>
>             segment@200000 {  /* 0x44e00000 */
>                 compatible = "simple-pm-bus";
>
>                 target-module@0 { /* 0x44e00000, ap 8 58.0 */
>                     compatible = "ti,sysc-omap4", "ti,sysc";
>
>                     prcm: prcm@0 {
>                         compatible = "ti,am3-prcm", "simple-bus";
>
>                         prm_per: prm@c00 { <========= Actual Supplier
>                             compatible = "ti,am3-prm-inst", "ti,omap-prm-inst";
>                         };
>                     };
>                 };
>             };
>         };
>     };
>
> The power-domain supplier is the great-great-great-grand-child of the
> consumer. It's not clear to me how this is valid. What does it even
> mean?
>
> Rob, is this considered a valid DT?

Valid DT for broken h/w.

So the domain must be default on and then simple-pm-bus is going to
hold a reference to the domain preventing it from ever getting powered
off and things seem to work. Except what happens during suspend?

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
