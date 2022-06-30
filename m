Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C118EC433EF
	for <iommu@archiver.kernel.org>; Thu, 30 Jun 2022 23:11:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B15AF423BA;
	Thu, 30 Jun 2022 23:11:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B15AF423BA
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=j6G/dJbF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o07hMpgX0X38; Thu, 30 Jun 2022 23:11:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E9E1841706;
	Thu, 30 Jun 2022 23:11:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E9E1841706
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6D56C002D;
	Thu, 30 Jun 2022 23:11:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40F8DC0011
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 23:11:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 071AC41727
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 23:11:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 071AC41727
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hWoVmk_T03dy for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 23:11:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ABC4D41706
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ABC4D41706
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 23:11:00 +0000 (UTC)
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-2ef5380669cso7819307b3.9
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 16:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=S1BoFOa2LtA+D+cJfjxLFr8ByDI13+RV4RpERikla2g=;
 b=j6G/dJbFKHnQExUqH76mXhgqPp9ZcqVNcEQ+TkrRQCB4vbElxQSuQLezKQlQ7xN+VC
 CDDzmaQeHdxlOZOCBFq//logchR7RZDvSUc+pDl0prPBWCPWEX69BjWXjPSEp2UxoX7u
 wDKATzphl9/JUAB/pAgWFj7XeUNfrTbYLZHtGGbwPBqb4efbEEjdJtWBbMaCbpb1rcIp
 o6T1fs6ZC9OgDeTixalEeTj3kFaVH5X1sN++K92xWyut4jEM6I+OmHfvOw0Abh1REVAc
 VPf1701wcHq3wjBOr+BDHBnKRAl9ol09c0TNkhO+FRlji0Jcx3/ON8sPMqhei3siga1C
 tf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S1BoFOa2LtA+D+cJfjxLFr8ByDI13+RV4RpERikla2g=;
 b=xzUdrH5dndhRdDGk6ZrmD6TMqExcvK5/WluSArebZyxM36zAgGhODqKv3AFdgC4I+9
 0Ej21qR/xX2Jj6lfgWHsZczf6gXmjKU4xy6Z9WsKw7YBWMATeEIo2oDqPPJZ4nOcYJ0w
 aydFRrxbaIDhn+WsZpqKpy3dmqJSN8nmT/6cslxjd4mbhR7eoEBJcTiqLeqJFHP4z3zZ
 I4hr8sHgceqRbgjeQvDR2+C+mGZ+LOZd+K+feLkrW5NjpVi6I4KnviEoQr6bob//gl9J
 I4A384Km/lGzFgUoo7Js6q/3RXwpiXxYyT7gunYBEf0F70YAjnzMiXWa2Q0sn6DBBY07
 OHFQ==
X-Gm-Message-State: AJIora/SQSeUQgqPonXJs0ksebAfR3mXRN69BSFD/gtcGAYMkA+MIYb7
 6lKTnG+UmkIdjmkAZprJcOj3nh/bDelsDLABMfKjBA==
X-Google-Smtp-Source: AGRyM1u13ZqWwVRME+f0vAv8E2QASlU+p6PTsPGGdH/NEQ/jIY6Gn1dbdhukUneaQ15EmMWjJGOMoC+FKq768Lix/J4=
X-Received: by 2002:a81:a095:0:b0:317:d4ce:38b6 with SMTP id
 x143-20020a81a095000000b00317d4ce38b6mr13731218ywg.83.1656630659375; Thu, 30
 Jun 2022 16:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
 <20220601070707.3946847-2-saravanak@google.com> <YrFzK6EiVvXmzVG6@atomide.com>
 <CAGETcx_1USPRbFKV5j00qkQ-QXJkp7=FAfnFcfiNnM4J5KF1cQ@mail.gmail.com>
 <YrKhkmj3jCQA39X/@atomide.com>
 <CAGETcx_11wO-HkZ2QsBF8o1+L9L3Xe1QBQ_GzegwozxAx1i0jg@mail.gmail.com>
 <YrQP3OZbe8aCQxKU@atomide.com>
 <CAGETcx9aFBzMcuOiTAEy5SJyWw3UfajZ8DVQfW2DGmzzDabZVg@mail.gmail.com>
 <Yrlz/P6Un2fACG98@atomide.com>
In-Reply-To: <Yrlz/P6Un2fACG98@atomide.com>
Date: Thu, 30 Jun 2022 16:10:23 -0700
Message-ID: <CAGETcx8c+P0r6ARmhv+ERaz9zAGBOVJQu3bSDXELBycEGfkYQw@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] PM: domains: Delete usage of
 driver_deferred_probe_check_state()
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kernel-team@android.com, Len Brown <len.brown@intel.com>,
 linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
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

On Mon, Jun 27, 2022 at 2:10 AM Tony Lindgren <tony@atomide.com> wrote:
>
> * Saravana Kannan <saravanak@google.com> [220623 08:17]:
> > On Thu, Jun 23, 2022 at 12:01 AM Tony Lindgren <tony@atomide.com> wrote:
> > >
> > > * Saravana Kannan <saravanak@google.com> [220622 19:05]:
> > > > On Tue, Jun 21, 2022 at 9:59 PM Tony Lindgren <tony@atomide.com> wrote:
> > > > > This issue is no directly related fw_devlink. It is a side effect of
> > > > > removing driver_deferred_probe_check_state(). We no longer return
> > > > > -EPROBE_DEFER at the end of driver_deferred_probe_check_state().
> > > >
> > > > Yes, I understand the issue. But driver_deferred_probe_check_state()
> > > > was deleted because fw_devlink=on should have short circuited the
> > > > probe attempt with an  -EPROBE_DEFER before reaching the bus/driver
> > > > probe function and hitting this -ENOENT failure. That's why I was
> > > > asking the other questions.
> > >
> > > OK. So where is the -EPROBE_DEFER supposed to happen without
> > > driver_deferred_probe_check_state() then?
> >
> > device_links_check_suppliers() call inside really_probe() would short
> > circuit and return an -EPROBE_DEFER if the device links are created as
> > expected.
>
> OK
>
> > > Hmm so I'm not seeing any supplier for the top level ocp device in
> > > the booting case without your patches. I see the suppliers for the
> > > ocp child device instances only.
> >
> > Hmmm... this is strange (that the device link isn't there), but this
> > is what I suspected.
>
> Yup, maybe it's because of the supplier being a device in the child
> interconnect for the ocp.

Ugh... yeah, this is why the normal (not SYNC_STATE_ONLY) device link
isn't being created.

So the aggregated view is something like (I had to set tabs = 4 space
to fit it within 80 cols):

    ocp: ocp {         <========================= Consumer
        compatible = "simple-pm-bus";
        power-domains = <&prm_per>; <=========== Supplier ref

                l4_wkup: interconnect@44c00000 {
            compatible = "ti,am33xx-l4-wkup", "simple-pm-bus";

            segment@200000 {  /* 0x44e00000 */
                compatible = "simple-pm-bus";

                target-module@0 { /* 0x44e00000, ap 8 58.0 */
                    compatible = "ti,sysc-omap4", "ti,sysc";

                    prcm: prcm@0 {
                        compatible = "ti,am3-prcm", "simple-bus";

                        prm_per: prm@c00 { <========= Actual Supplier
                            compatible = "ti,am3-prm-inst", "ti,omap-prm-inst";
                        };
                    };
                };
            };
        };
    };

The power-domain supplier is the great-great-great-grand-child of the
consumer. It's not clear to me how this is valid. What does it even
mean?

Rob, is this considered a valid DT?

Geert, thoughts on whether this is a correct use of simple-pm-bus device?

Also, how is the power domain attach/get working in this case? As far
as I can tell, at least for "simple-pm-bus" devices, the pm domain
attachment is happening under:
really_probe() -> call_driver_probe -> platform_probe() ->
dev_pm_domain_attach()

So, how is the pm domain attach succeeding in the first place without
my changes?

> > Now we need to figure out why it's missing. There are only a few
> > things that could cause this and I don't see any of those. I already
> > checked to make sure the power domain in this instance had a proper
> > driver with a probe() function -- if it didn't, then that's one thing
> > that'd could have caused the missing device link. The device does seem
> > to have a proper driver, so looks like I can rule that out.
> >
> > Can you point me to the dts file that corresponds to the specific
> > board you are testing this one? I probably won't find anything, but I
> > want to rule out some of the possibilities.
>
> You can use the beaglebone black dts for example, that's
> arch/arm/boot/dts/am335x-boneblack.dts and uses am33xx.dtsi for
> ocp interconnect with simple-pm-bus.
>
> > All the device link creation logic is inside drivers/base/core.c. So
> > if you can look at the existing messages or add other stuff to figure
> > out why the device link isn't getting created, that'd be handy. In
> > either case, I'll continue staring at the DT and code to see what
> > might be happening here.
>
> In device_links_check_suppliers() I see these ocp suppliers:
>
> platform ocp: device_links_check_suppliers: 1024: supplier 44e00d00.prm: link->status: 0 link->flags: 000001c0
> platform ocp: device_links_check_suppliers: 1024: supplier 44e01000.prm: link->status: 0 link->flags: 000001c0
> platform ocp: device_links_check_suppliers: 1024: supplier 44e00c00.prm: link->status: 0 link->flags: 000001c0
> platform ocp: device_links_check_suppliers: 1024: supplier 44e00e00.prm: link->status: 0 link->flags: 000001c0
> platform ocp: device_links_check_suppliers: 1024: supplier 44e01100.prm: link->status: 0 link->flags: 000001c0
> platform ocp: device_links_check_suppliers: 1024: supplier fixedregulator0: link->status: 1 link->flags: 000001c0
>
> No -EPROBE_DEFER is returned in device_links_check_suppliers() for
> 44e00c00.prm supplier for beaglebone black for example, 0 gets
> returned.

Yeah, the "1c0" flags are SYNC_STATE_ONLY device links and aren't
relevant to the issue we are seeing. Those links are being created as
a proxy for other descendant devices of ocp that haven't been added
yet, but are consumers of these *.prm devices. They are mainly meant
for correctness of sync_state() callbacks of the supplier and don't
affect probe order. For example: target-module@56000000 is a consumer
of prm_gfx 44e01100.prm.

-Saravana
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
